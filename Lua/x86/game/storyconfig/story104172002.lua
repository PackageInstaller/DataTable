return {
	Play417202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417202001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I05c"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.I05c

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			arg_1_1.isInRecall_ = true

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					local var_4_25 = iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_4, iter_4_5 in ipairs(var_4_25) do
						if iter_4_5.color.r > 0.51 then
							iter_4_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_4_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_4_26 = 0.0666666666666667

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_24) / var_4_26

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_27)
			end

			if arg_1_1.time_ >= var_4_24 + var_4_26 and arg_1_1.time_ < var_4_24 + var_4_26 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_28 = 0
			local var_4_29 = 0.2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_34 = 1.66666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_1311", "se_story_1311_run", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.999999999999
			local var_4_39 = 1.2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(417202001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 48
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417202002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 417202002
		arg_8_1.duration_ = 3.63

		local var_8_0 = {
			zh = 3.633,
			ja = 2.3
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play417202003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "10128"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(var_11_1, arg_8_1.canvasGo_.transform)

					var_11_2.transform:SetSiblingIndex(1)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs(var_11_3) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_4 = arg_8_1.actors_["10128"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10128 == nil then
				arg_8_1.var_.actorSpriteComps10128 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps10128 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								local var_11_8 = Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, var_11_7)
								local var_11_9 = Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, var_11_7)
								local var_11_10 = Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, var_11_7)

								iter_11_3.color = Color.New(var_11_8, var_11_9, var_11_10)
							else
								local var_11_11 = Mathf.Lerp(iter_11_3.color.r, 1, var_11_7)

								iter_11_3.color = Color.New(var_11_11, var_11_11, var_11_11)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10128 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10128 = nil
			end

			local var_11_12 = arg_8_1.actors_["10128"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos10128 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10128", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_6" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(0, -347, -300)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10128, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, -347, -300)
			end

			local var_11_19 = 0
			local var_11_20 = 0.2

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				local var_11_21 = "play"
				local var_11_22 = "music"

				arg_8_1:AudioAction(var_11_21, var_11_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_23 = ""
				local var_11_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_24 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_24 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_24

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_24
						arg_8_1.bgmTxt2_.text = var_11_24
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_25 = 0.333333333333333
			local var_11_26 = 1

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				local var_11_27 = "play"
				local var_11_28 = "music"

				arg_8_1:AudioAction(var_11_27, var_11_28, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_11_29 = ""
				local var_11_30 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_11_30 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_30 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_30

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_30
						arg_8_1.bgmTxt2_.text = var_11_30
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_31 = 0
			local var_11_32 = 0.2

			if var_11_31 < arg_8_1.time_ and arg_8_1.time_ <= var_11_31 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_33 = arg_8_1:FormatText(StoryNameCfg[595].name)

				arg_8_1.leftNameTxt_.text = var_11_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_34 = arg_8_1:GetWordFromCfg(417202002)
				local var_11_35 = arg_8_1:FormatText(var_11_34.content)

				arg_8_1.text_.text = var_11_35

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_36 = 8
				local var_11_37 = utf8.len(var_11_35)
				local var_11_38 = var_11_36 <= 0 and var_11_32 or var_11_32 * (var_11_37 / var_11_36)

				if var_11_38 > 0 and var_11_32 < var_11_38 then
					arg_8_1.talkMaxDuration = var_11_38

					if var_11_38 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_38 + var_11_31
					end
				end

				arg_8_1.text_.text = var_11_35
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202002", "story_v_out_417202.awb") ~= 0 then
					local var_11_39 = manager.audio:GetVoiceLength("story_v_out_417202", "417202002", "story_v_out_417202.awb") / 1000

					if var_11_39 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_39 + var_11_31
					end

					if var_11_34.prefab_name ~= "" and arg_8_1.actors_[var_11_34.prefab_name] ~= nil then
						local var_11_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_34.prefab_name].transform, "story_v_out_417202", "417202002", "story_v_out_417202.awb")

						arg_8_1:RecordAudio("417202002", var_11_40)
						arg_8_1:RecordAudio("417202002", var_11_40)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_417202", "417202002", "story_v_out_417202.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_417202", "417202002", "story_v_out_417202.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_41 = math.max(var_11_32, arg_8_1.talkMaxDuration)

			if var_11_31 <= arg_8_1.time_ and arg_8_1.time_ < var_11_31 + var_11_41 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_31) / var_11_41

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_31 + var_11_41 and arg_8_1.time_ < var_11_31 + var_11_41 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play417202003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417202003
		arg_14_1.duration_ = 3.27

		local var_14_0 = {
			zh = 2.3,
			ja = 3.266
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417202004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "1060"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(var_17_1, arg_14_1.canvasGo_.transform)

					var_17_2.transform:SetSiblingIndex(1)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs(var_17_3) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_4 = arg_14_1.actors_["1060"].transform
			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.var_.moveOldPos1060 = var_17_4.localPosition
				var_17_4.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1060", 4)

				local var_17_6 = var_17_4.childCount

				for iter_17_2 = 0, var_17_6 - 1 do
					local var_17_7 = var_17_4:GetChild(iter_17_2)

					if var_17_7.name == "" or not string.find(var_17_7.name, "split") then
						var_17_7.gameObject:SetActive(true)
					else
						var_17_7.gameObject:SetActive(false)
					end
				end
			end

			local var_17_8 = 0.001

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_8 then
				local var_17_9 = (arg_14_1.time_ - var_17_5) / var_17_8
				local var_17_10 = Vector3.New(420.9, -430.8, 6.9)

				var_17_4.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1060, var_17_10, var_17_9)
			end

			if arg_14_1.time_ >= var_17_5 + var_17_8 and arg_14_1.time_ < var_17_5 + var_17_8 + arg_17_0 then
				var_17_4.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_17_11 = arg_14_1.actors_["10128"].transform
			local var_17_12 = 0

			if var_17_12 < arg_14_1.time_ and arg_14_1.time_ <= var_17_12 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = var_17_11.localPosition
				var_17_11.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 2)

				local var_17_13 = var_17_11.childCount

				for iter_17_3 = 0, var_17_13 - 1 do
					local var_17_14 = var_17_11:GetChild(iter_17_3)

					if var_17_14.name == "split_6" or not string.find(var_17_14.name, "split") then
						var_17_14.gameObject:SetActive(true)
					else
						var_17_14.gameObject:SetActive(false)
					end
				end
			end

			local var_17_15 = 0.001

			if var_17_12 <= arg_14_1.time_ and arg_14_1.time_ < var_17_12 + var_17_15 then
				local var_17_16 = (arg_14_1.time_ - var_17_12) / var_17_15
				local var_17_17 = Vector3.New(-390, -347, -300)

				var_17_11.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, var_17_17, var_17_16)
			end

			if arg_14_1.time_ >= var_17_12 + var_17_15 and arg_14_1.time_ < var_17_12 + var_17_15 + arg_17_0 then
				var_17_11.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_17_18 = arg_14_1.actors_["1060"]
			local var_17_19 = 0

			if var_17_19 < arg_14_1.time_ and arg_14_1.time_ <= var_17_19 + arg_17_0 and not isNil(var_17_18) and arg_14_1.var_.actorSpriteComps1060 == nil then
				arg_14_1.var_.actorSpriteComps1060 = var_17_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_20 = 0.2

			if var_17_19 <= arg_14_1.time_ and arg_14_1.time_ < var_17_19 + var_17_20 and not isNil(var_17_18) then
				local var_17_21 = (arg_14_1.time_ - var_17_19) / var_17_20

				if arg_14_1.var_.actorSpriteComps1060 then
					for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_17_5 then
							if arg_14_1.isInRecall_ then
								local var_17_22 = Mathf.Lerp(iter_17_5.color.r, arg_14_1.hightColor1.r, var_17_21)
								local var_17_23 = Mathf.Lerp(iter_17_5.color.g, arg_14_1.hightColor1.g, var_17_21)
								local var_17_24 = Mathf.Lerp(iter_17_5.color.b, arg_14_1.hightColor1.b, var_17_21)

								iter_17_5.color = Color.New(var_17_22, var_17_23, var_17_24)
							else
								local var_17_25 = Mathf.Lerp(iter_17_5.color.r, 1, var_17_21)

								iter_17_5.color = Color.New(var_17_25, var_17_25, var_17_25)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_19 + var_17_20 and arg_14_1.time_ < var_17_19 + var_17_20 + arg_17_0 and not isNil(var_17_18) and arg_14_1.var_.actorSpriteComps1060 then
				for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_17_7 then
						if arg_14_1.isInRecall_ then
							iter_17_7.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1060 = nil
			end

			local var_17_26 = arg_14_1.actors_["10128"]
			local var_17_27 = 0

			if var_17_27 < arg_14_1.time_ and arg_14_1.time_ <= var_17_27 + arg_17_0 and not isNil(var_17_26) and arg_14_1.var_.actorSpriteComps10128 == nil then
				arg_14_1.var_.actorSpriteComps10128 = var_17_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_28 = 0.2

			if var_17_27 <= arg_14_1.time_ and arg_14_1.time_ < var_17_27 + var_17_28 and not isNil(var_17_26) then
				local var_17_29 = (arg_14_1.time_ - var_17_27) / var_17_28

				if arg_14_1.var_.actorSpriteComps10128 then
					for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_17_9 then
							if arg_14_1.isInRecall_ then
								local var_17_30 = Mathf.Lerp(iter_17_9.color.r, arg_14_1.hightColor2.r, var_17_29)
								local var_17_31 = Mathf.Lerp(iter_17_9.color.g, arg_14_1.hightColor2.g, var_17_29)
								local var_17_32 = Mathf.Lerp(iter_17_9.color.b, arg_14_1.hightColor2.b, var_17_29)

								iter_17_9.color = Color.New(var_17_30, var_17_31, var_17_32)
							else
								local var_17_33 = Mathf.Lerp(iter_17_9.color.r, 0.5, var_17_29)

								iter_17_9.color = Color.New(var_17_33, var_17_33, var_17_33)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_27 + var_17_28 and arg_14_1.time_ < var_17_27 + var_17_28 + arg_17_0 and not isNil(var_17_26) and arg_14_1.var_.actorSpriteComps10128 then
				for iter_17_10, iter_17_11 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_17_11 then
						if arg_14_1.isInRecall_ then
							iter_17_11.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps10128 = nil
			end

			local var_17_34 = 0
			local var_17_35 = 0.3

			if var_17_34 < arg_14_1.time_ and arg_14_1.time_ <= var_17_34 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_36 = arg_14_1:FormatText(StoryNameCfg[584].name)

				arg_14_1.leftNameTxt_.text = var_17_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_37 = arg_14_1:GetWordFromCfg(417202003)
				local var_17_38 = arg_14_1:FormatText(var_17_37.content)

				arg_14_1.text_.text = var_17_38

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_39 = 12
				local var_17_40 = utf8.len(var_17_38)
				local var_17_41 = var_17_39 <= 0 and var_17_35 or var_17_35 * (var_17_40 / var_17_39)

				if var_17_41 > 0 and var_17_35 < var_17_41 then
					arg_14_1.talkMaxDuration = var_17_41

					if var_17_41 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_41 + var_17_34
					end
				end

				arg_14_1.text_.text = var_17_38
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202003", "story_v_out_417202.awb") ~= 0 then
					local var_17_42 = manager.audio:GetVoiceLength("story_v_out_417202", "417202003", "story_v_out_417202.awb") / 1000

					if var_17_42 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_42 + var_17_34
					end

					if var_17_37.prefab_name ~= "" and arg_14_1.actors_[var_17_37.prefab_name] ~= nil then
						local var_17_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_37.prefab_name].transform, "story_v_out_417202", "417202003", "story_v_out_417202.awb")

						arg_14_1:RecordAudio("417202003", var_17_43)
						arg_14_1:RecordAudio("417202003", var_17_43)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417202", "417202003", "story_v_out_417202.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417202", "417202003", "story_v_out_417202.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_44 = math.max(var_17_35, arg_14_1.talkMaxDuration)

			if var_17_34 <= arg_14_1.time_ and arg_14_1.time_ < var_17_34 + var_17_44 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_34) / var_17_44

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_34 + var_17_44 and arg_14_1.time_ < var_17_34 + var_17_44 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play417202004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417202004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417202005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10128"].transform
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPos10128 = var_21_0.localPosition
				var_21_0.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("10128", 7)

				local var_21_2 = var_21_0.childCount

				for iter_21_0 = 0, var_21_2 - 1 do
					local var_21_3 = var_21_0:GetChild(iter_21_0)

					if var_21_3.name == "" or not string.find(var_21_3.name, "split") then
						var_21_3.gameObject:SetActive(true)
					else
						var_21_3.gameObject:SetActive(false)
					end
				end
			end

			local var_21_4 = 0.001

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_4 then
				local var_21_5 = (arg_18_1.time_ - var_21_1) / var_21_4
				local var_21_6 = Vector3.New(0, -2000, -40)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10128, var_21_6, var_21_5)
			end

			if arg_18_1.time_ >= var_21_1 + var_21_4 and arg_18_1.time_ < var_21_1 + var_21_4 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_21_7 = arg_18_1.actors_["1060"].transform
			local var_21_8 = 0

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.var_.moveOldPos1060 = var_21_7.localPosition
				var_21_7.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1060", 7)

				local var_21_9 = var_21_7.childCount

				for iter_21_1 = 0, var_21_9 - 1 do
					local var_21_10 = var_21_7:GetChild(iter_21_1)

					if var_21_10.name == "" or not string.find(var_21_10.name, "split") then
						var_21_10.gameObject:SetActive(true)
					else
						var_21_10.gameObject:SetActive(false)
					end
				end
			end

			local var_21_11 = 0.001

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_11 then
				local var_21_12 = (arg_18_1.time_ - var_21_8) / var_21_11
				local var_21_13 = Vector3.New(0, -2000, -40)

				var_21_7.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1060, var_21_13, var_21_12)
			end

			if arg_18_1.time_ >= var_21_8 + var_21_11 and arg_18_1.time_ < var_21_8 + var_21_11 + arg_21_0 then
				var_21_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_21_14 = 0.333333333333333
			local var_21_15 = 1

			if var_21_14 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				local var_21_16 = "play"
				local var_21_17 = "effect"

				arg_18_1:AudioAction(var_21_16, var_21_17, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_21_18 = 0
			local var_21_19 = 0.45

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_20 = arg_18_1:GetWordFromCfg(417202004)
				local var_21_21 = arg_18_1:FormatText(var_21_20.content)

				arg_18_1.text_.text = var_21_21

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_22 = 18
				local var_21_23 = utf8.len(var_21_21)
				local var_21_24 = var_21_22 <= 0 and var_21_19 or var_21_19 * (var_21_23 / var_21_22)

				if var_21_24 > 0 and var_21_19 < var_21_24 then
					arg_18_1.talkMaxDuration = var_21_24

					if var_21_24 + var_21_18 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_24 + var_21_18
					end
				end

				arg_18_1.text_.text = var_21_21
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_25 = math.max(var_21_19, arg_18_1.talkMaxDuration)

			if var_21_18 <= arg_18_1.time_ and arg_18_1.time_ < var_21_18 + var_21_25 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_18) / var_21_25

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_18 + var_21_25 and arg_18_1.time_ < var_21_18 + var_21_25 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play417202005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417202005
		arg_22_1.duration_ = 8.9

		local var_22_0 = {
			zh = 3.466,
			ja = 8.9
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
				arg_22_0:Play417202006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10128"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10128 == nil then
				arg_22_1.var_.actorSpriteComps10128 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps10128 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								local var_25_4 = Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor1.r, var_25_3)
								local var_25_5 = Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor1.g, var_25_3)
								local var_25_6 = Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor1.b, var_25_3)

								iter_25_1.color = Color.New(var_25_4, var_25_5, var_25_6)
							else
								local var_25_7 = Mathf.Lerp(iter_25_1.color.r, 1, var_25_3)

								iter_25_1.color = Color.New(var_25_7, var_25_7, var_25_7)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10128 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps10128 = nil
			end

			local var_25_8 = arg_22_1.actors_["1060"].transform
			local var_25_9 = 0

			if var_25_9 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.var_.moveOldPos1060 = var_25_8.localPosition
				var_25_8.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1060", 3)

				local var_25_10 = var_25_8.childCount

				for iter_25_4 = 0, var_25_10 - 1 do
					local var_25_11 = var_25_8:GetChild(iter_25_4)

					if var_25_11.name == "" or not string.find(var_25_11.name, "split") then
						var_25_11.gameObject:SetActive(true)
					else
						var_25_11.gameObject:SetActive(false)
					end
				end
			end

			local var_25_12 = 0.001

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_12 then
				local var_25_13 = (arg_22_1.time_ - var_25_9) / var_25_12
				local var_25_14 = Vector3.New(33.4, -430.8, 6.9)

				var_25_8.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1060, var_25_14, var_25_13)
			end

			if arg_22_1.time_ >= var_25_9 + var_25_12 and arg_22_1.time_ < var_25_9 + var_25_12 + arg_25_0 then
				var_25_8.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_25_15 = 0
			local var_25_16 = 0.4

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_17 = arg_22_1:FormatText(StoryNameCfg[584].name)

				arg_22_1.leftNameTxt_.text = var_25_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_18 = arg_22_1:GetWordFromCfg(417202005)
				local var_25_19 = arg_22_1:FormatText(var_25_18.content)

				arg_22_1.text_.text = var_25_19

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_20 = 16
				local var_25_21 = utf8.len(var_25_19)
				local var_25_22 = var_25_20 <= 0 and var_25_16 or var_25_16 * (var_25_21 / var_25_20)

				if var_25_22 > 0 and var_25_16 < var_25_22 then
					arg_22_1.talkMaxDuration = var_25_22

					if var_25_22 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_22 + var_25_15
					end
				end

				arg_22_1.text_.text = var_25_19
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202005", "story_v_out_417202.awb") ~= 0 then
					local var_25_23 = manager.audio:GetVoiceLength("story_v_out_417202", "417202005", "story_v_out_417202.awb") / 1000

					if var_25_23 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_23 + var_25_15
					end

					if var_25_18.prefab_name ~= "" and arg_22_1.actors_[var_25_18.prefab_name] ~= nil then
						local var_25_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_18.prefab_name].transform, "story_v_out_417202", "417202005", "story_v_out_417202.awb")

						arg_22_1:RecordAudio("417202005", var_25_24)
						arg_22_1:RecordAudio("417202005", var_25_24)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417202", "417202005", "story_v_out_417202.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417202", "417202005", "story_v_out_417202.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_25 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_15 <= arg_22_1.time_ and arg_22_1.time_ < var_25_15 + var_25_25 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_15) / var_25_25

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_15 + var_25_25 and arg_22_1.time_ < var_25_15 + var_25_25 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417202006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417202006
		arg_26_1.duration_ = 8.13

		local var_26_0 = {
			zh = 4.333,
			ja = 8.133
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417202007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.45

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[584].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:GetWordFromCfg(417202006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 18
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202006", "story_v_out_417202.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202006", "story_v_out_417202.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_417202", "417202006", "story_v_out_417202.awb")

						arg_26_1:RecordAudio("417202006", var_29_9)
						arg_26_1:RecordAudio("417202006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417202", "417202006", "story_v_out_417202.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417202", "417202006", "story_v_out_417202.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417202007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417202007
		arg_30_1.duration_ = 1.33

		local var_30_0 = {
			zh = 1.333,
			ja = 0.999999999999
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
				arg_30_0:Play417202008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1060"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1060 == nil then
				arg_30_1.var_.actorSpriteComps1060 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1060 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 0.5, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1060 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1060 = nil
			end

			local var_33_8 = 0
			local var_33_9 = 0.125

			if var_33_8 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_10 = arg_30_1:FormatText(StoryNameCfg[595].name)

				arg_30_1.leftNameTxt_.text = var_33_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_30_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_33_11 = arg_30_1:GetWordFromCfg(417202007)
				local var_33_12 = arg_30_1:FormatText(var_33_11.content)

				arg_30_1.text_.text = var_33_12

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 5
				local var_33_14 = utf8.len(var_33_12)
				local var_33_15 = var_33_13 <= 0 and var_33_9 or var_33_9 * (var_33_14 / var_33_13)

				if var_33_15 > 0 and var_33_9 < var_33_15 then
					arg_30_1.talkMaxDuration = var_33_15

					if var_33_15 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_15 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_12
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202007", "story_v_out_417202.awb") ~= 0 then
					local var_33_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202007", "story_v_out_417202.awb") / 1000

					if var_33_16 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_16 + var_33_8
					end

					if var_33_11.prefab_name ~= "" and arg_30_1.actors_[var_33_11.prefab_name] ~= nil then
						local var_33_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_11.prefab_name].transform, "story_v_out_417202", "417202007", "story_v_out_417202.awb")

						arg_30_1:RecordAudio("417202007", var_33_17)
						arg_30_1:RecordAudio("417202007", var_33_17)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417202", "417202007", "story_v_out_417202.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417202", "417202007", "story_v_out_417202.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_18 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_18 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_18

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_18 and arg_30_1.time_ < var_33_8 + var_33_18 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417202008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417202008
		arg_34_1.duration_ = 9.83

		local var_34_0 = {
			zh = 6.133,
			ja = 9.833
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417202009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1060"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1060 == nil then
				arg_34_1.var_.actorSpriteComps1060 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1060 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 1, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1060 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1060 = nil
			end

			local var_37_8 = 0
			local var_37_9 = 0.85

			if var_37_8 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_10 = arg_34_1:FormatText(StoryNameCfg[584].name)

				arg_34_1.leftNameTxt_.text = var_37_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_11 = arg_34_1:GetWordFromCfg(417202008)
				local var_37_12 = arg_34_1:FormatText(var_37_11.content)

				arg_34_1.text_.text = var_37_12

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 34
				local var_37_14 = utf8.len(var_37_12)
				local var_37_15 = var_37_13 <= 0 and var_37_9 or var_37_9 * (var_37_14 / var_37_13)

				if var_37_15 > 0 and var_37_9 < var_37_15 then
					arg_34_1.talkMaxDuration = var_37_15

					if var_37_15 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_15 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_12
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202008", "story_v_out_417202.awb") ~= 0 then
					local var_37_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202008", "story_v_out_417202.awb") / 1000

					if var_37_16 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_16 + var_37_8
					end

					if var_37_11.prefab_name ~= "" and arg_34_1.actors_[var_37_11.prefab_name] ~= nil then
						local var_37_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_11.prefab_name].transform, "story_v_out_417202", "417202008", "story_v_out_417202.awb")

						arg_34_1:RecordAudio("417202008", var_37_17)
						arg_34_1:RecordAudio("417202008", var_37_17)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417202", "417202008", "story_v_out_417202.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417202", "417202008", "story_v_out_417202.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_18 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_18 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_18

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_18 and arg_34_1.time_ < var_37_8 + var_37_18 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417202009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417202009
		arg_38_1.duration_ = 7.67

		local var_38_0 = {
			zh = 5.9,
			ja = 7.666
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417202010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.625

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[584].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:GetWordFromCfg(417202009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 25
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202009", "story_v_out_417202.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202009", "story_v_out_417202.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_417202", "417202009", "story_v_out_417202.awb")

						arg_38_1:RecordAudio("417202009", var_41_9)
						arg_38_1:RecordAudio("417202009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417202", "417202009", "story_v_out_417202.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417202", "417202009", "story_v_out_417202.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417202010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417202010
		arg_42_1.duration_ = 3.9

		local var_42_0 = {
			zh = 3.9,
			ja = 3.833
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417202011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.35

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[584].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:GetWordFromCfg(417202010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202010", "story_v_out_417202.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202010", "story_v_out_417202.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_417202", "417202010", "story_v_out_417202.awb")

						arg_42_1:RecordAudio("417202010", var_45_9)
						arg_42_1:RecordAudio("417202010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417202", "417202010", "story_v_out_417202.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417202", "417202010", "story_v_out_417202.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417202011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417202011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417202012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1060"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1060 = var_49_0.localPosition
				var_49_0.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1060", 7)

				local var_49_2 = var_49_0.childCount

				for iter_49_0 = 0, var_49_2 - 1 do
					local var_49_3 = var_49_0:GetChild(iter_49_0)

					if var_49_3.name == "" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_4 then
				local var_49_5 = (arg_46_1.time_ - var_49_1) / var_49_4
				local var_49_6 = Vector3.New(0, -2000, -40)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1060, var_49_6, var_49_5)
			end

			if arg_46_1.time_ >= var_49_1 + var_49_4 and arg_46_1.time_ < var_49_1 + var_49_4 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_49_7 = 0
			local var_49_8 = 0.975

			if var_49_7 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_9 = arg_46_1:GetWordFromCfg(417202011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 39
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_8 or var_49_8 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_8 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_7 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_7
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_8, arg_46_1.talkMaxDuration)

			if var_49_7 <= arg_46_1.time_ and arg_46_1.time_ < var_49_7 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_7) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_7 + var_49_14 and arg_46_1.time_ < var_49_7 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play417202012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417202012
		arg_50_1.duration_ = 6.1

		local var_50_0 = {
			zh = 3.4,
			ja = 6.1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417202013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10128"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								local var_53_4 = Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, var_53_3)
								local var_53_5 = Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, var_53_3)
								local var_53_6 = Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, var_53_3)

								iter_53_1.color = Color.New(var_53_4, var_53_5, var_53_6)
							else
								local var_53_7 = Mathf.Lerp(iter_53_1.color.r, 1, var_53_3)

								iter_53_1.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_8 = arg_50_1.actors_["1060"].transform
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.var_.moveOldPos1060 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1060", 3)

				local var_53_10 = var_53_8.childCount

				for iter_53_4 = 0, var_53_10 - 1 do
					local var_53_11 = var_53_8:GetChild(iter_53_4)

					if var_53_11.name == "split_2" or not string.find(var_53_11.name, "split") then
						var_53_11.gameObject:SetActive(true)
					else
						var_53_11.gameObject:SetActive(false)
					end
				end
			end

			local var_53_12 = 0.001

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_9) / var_53_12
				local var_53_14 = Vector3.New(33.4, -430.8, 6.9)

				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1060, var_53_14, var_53_13)
			end

			if arg_50_1.time_ >= var_53_9 + var_53_12 and arg_50_1.time_ < var_53_9 + var_53_12 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_53_15 = 0
			local var_53_16 = 0.4

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[584].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(417202012)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 16
				local var_53_21 = utf8.len(var_53_19)
				local var_53_22 = var_53_20 <= 0 and var_53_16 or var_53_16 * (var_53_21 / var_53_20)

				if var_53_22 > 0 and var_53_16 < var_53_22 then
					arg_50_1.talkMaxDuration = var_53_22

					if var_53_22 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_19
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202012", "story_v_out_417202.awb") ~= 0 then
					local var_53_23 = manager.audio:GetVoiceLength("story_v_out_417202", "417202012", "story_v_out_417202.awb") / 1000

					if var_53_23 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_15
					end

					if var_53_18.prefab_name ~= "" and arg_50_1.actors_[var_53_18.prefab_name] ~= nil then
						local var_53_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_18.prefab_name].transform, "story_v_out_417202", "417202012", "story_v_out_417202.awb")

						arg_50_1:RecordAudio("417202012", var_53_24)
						arg_50_1:RecordAudio("417202012", var_53_24)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417202", "417202012", "story_v_out_417202.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417202", "417202012", "story_v_out_417202.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_25 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_25 and arg_50_1.time_ < var_53_15 + var_53_25 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417202013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417202013
		arg_54_1.duration_ = 7.7

		local var_54_0 = {
			zh = 4.533,
			ja = 7.7
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play417202014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1060"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1060 = var_57_0.localPosition
				var_57_0.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1060", 3)

				local var_57_2 = var_57_0.childCount

				for iter_57_0 = 0, var_57_2 - 1 do
					local var_57_3 = var_57_0:GetChild(iter_57_0)

					if var_57_3.name == "split_1" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_4 then
				local var_57_5 = (arg_54_1.time_ - var_57_1) / var_57_4
				local var_57_6 = Vector3.New(33.4, -430.8, 6.9)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1060, var_57_6, var_57_5)
			end

			if arg_54_1.time_ >= var_57_1 + var_57_4 and arg_54_1.time_ < var_57_1 + var_57_4 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_57_7 = 0
			local var_57_8 = 0.575

			if var_57_7 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_9 = arg_54_1:FormatText(StoryNameCfg[584].name)

				arg_54_1.leftNameTxt_.text = var_57_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:GetWordFromCfg(417202013)
				local var_57_11 = arg_54_1:FormatText(var_57_10.content)

				arg_54_1.text_.text = var_57_11

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_12 = 23
				local var_57_13 = utf8.len(var_57_11)
				local var_57_14 = var_57_12 <= 0 and var_57_8 or var_57_8 * (var_57_13 / var_57_12)

				if var_57_14 > 0 and var_57_8 < var_57_14 then
					arg_54_1.talkMaxDuration = var_57_14

					if var_57_14 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_7
					end
				end

				arg_54_1.text_.text = var_57_11
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202013", "story_v_out_417202.awb") ~= 0 then
					local var_57_15 = manager.audio:GetVoiceLength("story_v_out_417202", "417202013", "story_v_out_417202.awb") / 1000

					if var_57_15 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_7
					end

					if var_57_10.prefab_name ~= "" and arg_54_1.actors_[var_57_10.prefab_name] ~= nil then
						local var_57_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_10.prefab_name].transform, "story_v_out_417202", "417202013", "story_v_out_417202.awb")

						arg_54_1:RecordAudio("417202013", var_57_16)
						arg_54_1:RecordAudio("417202013", var_57_16)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417202", "417202013", "story_v_out_417202.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417202", "417202013", "story_v_out_417202.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_17 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_17 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_7) / var_57_17

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_7 + var_57_17 and arg_54_1.time_ < var_57_7 + var_57_17 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play417202014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417202014
		arg_58_1.duration_ = 8.7

		local var_58_0 = {
			zh = 8.699999999999,
			ja = 7.599999999999
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417202015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 3.999999999999

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			local var_61_1 = 0.3

			if arg_58_1.time_ >= var_61_0 + var_61_1 and arg_58_1.time_ < var_61_0 + var_61_1 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_2 = "ST04b"

			if arg_58_1.bgs_[var_61_2] == nil then
				local var_61_3 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_2)
				var_61_3.name = var_61_2
				var_61_3.transform.parent = arg_58_1.stage_.transform
				var_61_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_2] = var_61_3
			end

			local var_61_4 = 2

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				local var_61_5 = manager.ui.mainCamera.transform.localPosition
				local var_61_6 = Vector3.New(0, 0, 10) + Vector3.New(var_61_5.x, var_61_5.y, 0)
				local var_61_7 = arg_58_1.bgs_.ST04b

				var_61_7.transform.localPosition = var_61_6
				var_61_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_8 = var_61_7:GetComponent("SpriteRenderer")

				if var_61_8 and var_61_8.sprite then
					local var_61_9 = (var_61_7.transform.localPosition - var_61_5).z
					local var_61_10 = manager.ui.mainCameraCom_
					local var_61_11 = 2 * var_61_9 * Mathf.Tan(var_61_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_61_12 = var_61_11 * var_61_10.aspect
					local var_61_13 = var_61_8.sprite.bounds.size.x
					local var_61_14 = var_61_8.sprite.bounds.size.y
					local var_61_15 = var_61_12 / var_61_13
					local var_61_16 = var_61_11 / var_61_14
					local var_61_17 = var_61_16 < var_61_15 and var_61_15 or var_61_16

					var_61_7.transform.localScale = Vector3.New(var_61_17, var_61_17, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "ST04b" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_18 = 0

			if var_61_18 < arg_58_1.time_ and arg_58_1.time_ <= var_61_18 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_19 = 2

			if var_61_18 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				local var_61_20 = (arg_58_1.time_ - var_61_18) / var_61_19
				local var_61_21 = Color.New(0, 0, 0)

				var_61_21.a = Mathf.Lerp(0, 1, var_61_20)
				arg_58_1.mask_.color = var_61_21
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				local var_61_22 = Color.New(0, 0, 0)

				var_61_22.a = 1
				arg_58_1.mask_.color = var_61_22
			end

			local var_61_23 = 2

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_24 = 2

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_24 then
				local var_61_25 = (arg_58_1.time_ - var_61_23) / var_61_24
				local var_61_26 = Color.New(0, 0, 0)

				var_61_26.a = Mathf.Lerp(1, 0, var_61_25)
				arg_58_1.mask_.color = var_61_26
			end

			if arg_58_1.time_ >= var_61_23 + var_61_24 and arg_58_1.time_ < var_61_23 + var_61_24 + arg_61_0 then
				local var_61_27 = Color.New(0, 0, 0)
				local var_61_28 = 0

				arg_58_1.mask_.enabled = false
				var_61_27.a = var_61_28
				arg_58_1.mask_.color = var_61_27
			end

			local var_61_29 = arg_58_1.actors_["10128"]
			local var_61_30 = 3.66666666666567

			if var_61_30 < arg_58_1.time_ and arg_58_1.time_ <= var_61_30 + arg_61_0 and not isNil(var_61_29) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = var_61_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_31 = 0.2

			if var_61_30 <= arg_58_1.time_ and arg_58_1.time_ < var_61_30 + var_61_31 and not isNil(var_61_29) then
				local var_61_32 = (arg_58_1.time_ - var_61_30) / var_61_31

				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								local var_61_33 = Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor1.r, var_61_32)
								local var_61_34 = Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor1.g, var_61_32)
								local var_61_35 = Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor1.b, var_61_32)

								iter_61_3.color = Color.New(var_61_33, var_61_34, var_61_35)
							else
								local var_61_36 = Mathf.Lerp(iter_61_3.color.r, 1, var_61_32)

								iter_61_3.color = Color.New(var_61_36, var_61_36, var_61_36)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_30 + var_61_31 and arg_58_1.time_ < var_61_30 + var_61_31 + arg_61_0 and not isNil(var_61_29) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_5 then
						if arg_58_1.isInRecall_ then
							iter_61_5.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_37 = arg_58_1.actors_["10128"].transform
			local var_61_38 = 3.66666666666667

			if var_61_38 < arg_58_1.time_ and arg_58_1.time_ <= var_61_38 + arg_61_0 then
				arg_58_1.var_.moveOldPos10128 = var_61_37.localPosition
				var_61_37.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10128", 3)

				local var_61_39 = var_61_37.childCount

				for iter_61_6 = 0, var_61_39 - 1 do
					local var_61_40 = var_61_37:GetChild(iter_61_6)

					if var_61_40.name == "split_2" or not string.find(var_61_40.name, "split") then
						var_61_40.gameObject:SetActive(true)
					else
						var_61_40.gameObject:SetActive(false)
					end
				end
			end

			local var_61_41 = 0.001

			if var_61_38 <= arg_58_1.time_ and arg_58_1.time_ < var_61_38 + var_61_41 then
				local var_61_42 = (arg_58_1.time_ - var_61_38) / var_61_41
				local var_61_43 = Vector3.New(0, -347, -300)

				var_61_37.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10128, var_61_43, var_61_42)
			end

			if arg_58_1.time_ >= var_61_38 + var_61_41 and arg_58_1.time_ < var_61_38 + var_61_41 + arg_61_0 then
				var_61_37.localPosition = Vector3.New(0, -347, -300)
			end

			local var_61_44 = arg_58_1.actors_["10128"]
			local var_61_45 = 3.66666666666567

			if var_61_45 < arg_58_1.time_ and arg_58_1.time_ <= var_61_45 + arg_61_0 then
				local var_61_46 = var_61_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_61_46 then
					arg_58_1.var_.alphaOldValue10128 = var_61_46.alpha
					arg_58_1.var_.characterEffect10128 = var_61_46
				end

				arg_58_1.var_.alphaOldValue10128 = 0
			end

			local var_61_47 = 0.333333333333333

			if var_61_45 <= arg_58_1.time_ and arg_58_1.time_ < var_61_45 + var_61_47 then
				local var_61_48 = (arg_58_1.time_ - var_61_45) / var_61_47
				local var_61_49 = Mathf.Lerp(arg_58_1.var_.alphaOldValue10128, 1, var_61_48)

				if arg_58_1.var_.characterEffect10128 then
					arg_58_1.var_.characterEffect10128.alpha = var_61_49
				end
			end

			if arg_58_1.time_ >= var_61_45 + var_61_47 and arg_58_1.time_ < var_61_45 + var_61_47 + arg_61_0 and arg_58_1.var_.characterEffect10128 then
				arg_58_1.var_.characterEffect10128.alpha = 1
			end

			local var_61_50 = arg_58_1.actors_["1060"].transform
			local var_61_51 = 1.966

			if var_61_51 < arg_58_1.time_ and arg_58_1.time_ <= var_61_51 + arg_61_0 then
				arg_58_1.var_.moveOldPos1060 = var_61_50.localPosition
				var_61_50.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1060", 7)

				local var_61_52 = var_61_50.childCount

				for iter_61_7 = 0, var_61_52 - 1 do
					local var_61_53 = var_61_50:GetChild(iter_61_7)

					if var_61_53.name == "" or not string.find(var_61_53.name, "split") then
						var_61_53.gameObject:SetActive(true)
					else
						var_61_53.gameObject:SetActive(false)
					end
				end
			end

			local var_61_54 = 0.001

			if var_61_51 <= arg_58_1.time_ and arg_58_1.time_ < var_61_51 + var_61_54 then
				local var_61_55 = (arg_58_1.time_ - var_61_51) / var_61_54
				local var_61_56 = Vector3.New(0, -2000, -40)

				var_61_50.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1060, var_61_56, var_61_55)
			end

			if arg_58_1.time_ >= var_61_51 + var_61_54 and arg_58_1.time_ < var_61_51 + var_61_54 + arg_61_0 then
				var_61_50.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_61_57 = 1.93333333333333

			arg_58_1.isInRecall_ = false

			if var_61_57 < arg_58_1.time_ and arg_58_1.time_ <= var_61_57 + arg_61_0 then
				arg_58_1.screenFilterGo_:SetActive(false)

				for iter_61_8, iter_61_9 in pairs(arg_58_1.actors_) do
					local var_61_58 = iter_61_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_61_10, iter_61_11 in ipairs(var_61_58) do
						if iter_61_11.color.r > 0.51 then
							iter_61_11.color = Color.New(1, 1, 1)
						else
							iter_61_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_61_59 = 0.0666666666666667

			if var_61_57 <= arg_58_1.time_ and arg_58_1.time_ < var_61_57 + var_61_59 then
				local var_61_60 = (arg_58_1.time_ - var_61_57) / var_61_59

				arg_58_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_61_60)
			end

			if arg_58_1.time_ >= var_61_57 + var_61_59 and arg_58_1.time_ < var_61_57 + var_61_59 + arg_61_0 then
				arg_58_1.screenFilterEffect_.weight = 0
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_61 = 3.999999999999
			local var_61_62 = 0.3

			if var_61_61 < arg_58_1.time_ and arg_58_1.time_ <= var_61_61 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_63 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_63:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_64 = arg_58_1:FormatText(StoryNameCfg[595].name)

				arg_58_1.leftNameTxt_.text = var_61_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_65 = arg_58_1:GetWordFromCfg(417202014)
				local var_61_66 = arg_58_1:FormatText(var_61_65.content)

				arg_58_1.text_.text = var_61_66

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_67 = 12
				local var_61_68 = utf8.len(var_61_66)
				local var_61_69 = var_61_67 <= 0 and var_61_62 or var_61_62 * (var_61_68 / var_61_67)

				if var_61_69 > 0 and var_61_62 < var_61_69 then
					arg_58_1.talkMaxDuration = var_61_69
					var_61_61 = var_61_61 + 0.3

					if var_61_69 + var_61_61 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_69 + var_61_61
					end
				end

				arg_58_1.text_.text = var_61_66
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202014", "story_v_out_417202.awb") ~= 0 then
					local var_61_70 = manager.audio:GetVoiceLength("story_v_out_417202", "417202014", "story_v_out_417202.awb") / 1000

					if var_61_70 + var_61_61 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_70 + var_61_61
					end

					if var_61_65.prefab_name ~= "" and arg_58_1.actors_[var_61_65.prefab_name] ~= nil then
						local var_61_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_65.prefab_name].transform, "story_v_out_417202", "417202014", "story_v_out_417202.awb")

						arg_58_1:RecordAudio("417202014", var_61_71)
						arg_58_1:RecordAudio("417202014", var_61_71)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417202", "417202014", "story_v_out_417202.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417202", "417202014", "story_v_out_417202.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_72 = var_61_61 + 0.3
			local var_61_73 = math.max(var_61_62, arg_58_1.talkMaxDuration)

			if var_61_72 <= arg_58_1.time_ and arg_58_1.time_ < var_61_72 + var_61_73 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_72) / var_61_73

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_72 + var_61_73 and arg_58_1.time_ < var_61_72 + var_61_73 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play417202015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417202015
		arg_64_1.duration_ = 10.63

		local var_64_0 = {
			zh = 5.866,
			ja = 10.633
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
				arg_64_0:Play417202016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1060"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1060 == nil then
				arg_64_1.var_.actorSpriteComps1060 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1060 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 1, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1060 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1060 = nil
			end

			local var_67_8 = arg_64_1.actors_["10128"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps10128 == nil then
				arg_64_1.var_.actorSpriteComps10128 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps10128 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								local var_67_12 = Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, var_67_11)
								local var_67_13 = Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, var_67_11)
								local var_67_14 = Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, var_67_11)

								iter_67_5.color = Color.New(var_67_12, var_67_13, var_67_14)
							else
								local var_67_15 = Mathf.Lerp(iter_67_5.color.r, 0.5, var_67_11)

								iter_67_5.color = Color.New(var_67_15, var_67_15, var_67_15)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps10128 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10128 = nil
			end

			local var_67_16 = arg_64_1.actors_["10128"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos10128 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10128", 2)

				local var_67_18 = var_67_16.childCount

				for iter_67_8 = 0, var_67_18 - 1 do
					local var_67_19 = var_67_16:GetChild(iter_67_8)

					if var_67_19.name == "split_2" or not string.find(var_67_19.name, "split") then
						var_67_19.gameObject:SetActive(true)
					else
						var_67_19.gameObject:SetActive(false)
					end
				end
			end

			local var_67_20 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_20 then
				local var_67_21 = (arg_64_1.time_ - var_67_17) / var_67_20
				local var_67_22 = Vector3.New(-390, -347, -300)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10128, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_67_23 = arg_64_1.actors_["1060"].transform
			local var_67_24 = 0

			if var_67_24 < arg_64_1.time_ and arg_64_1.time_ <= var_67_24 + arg_67_0 then
				arg_64_1.var_.moveOldPos1060 = var_67_23.localPosition
				var_67_23.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1060", 4)

				local var_67_25 = var_67_23.childCount

				for iter_67_9 = 0, var_67_25 - 1 do
					local var_67_26 = var_67_23:GetChild(iter_67_9)

					if var_67_26.name == "" or not string.find(var_67_26.name, "split") then
						var_67_26.gameObject:SetActive(true)
					else
						var_67_26.gameObject:SetActive(false)
					end
				end
			end

			local var_67_27 = 0.001

			if var_67_24 <= arg_64_1.time_ and arg_64_1.time_ < var_67_24 + var_67_27 then
				local var_67_28 = (arg_64_1.time_ - var_67_24) / var_67_27
				local var_67_29 = Vector3.New(420.9, -430.8, 6.9)

				var_67_23.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1060, var_67_29, var_67_28)
			end

			if arg_64_1.time_ >= var_67_24 + var_67_27 and arg_64_1.time_ < var_67_24 + var_67_27 + arg_67_0 then
				var_67_23.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_67_30 = 0
			local var_67_31 = 0.75

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[584].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(417202015)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 30
				local var_67_36 = utf8.len(var_67_34)
				local var_67_37 = var_67_35 <= 0 and var_67_31 or var_67_31 * (var_67_36 / var_67_35)

				if var_67_37 > 0 and var_67_31 < var_67_37 then
					arg_64_1.talkMaxDuration = var_67_37

					if var_67_37 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_37 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_34
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202015", "story_v_out_417202.awb") ~= 0 then
					local var_67_38 = manager.audio:GetVoiceLength("story_v_out_417202", "417202015", "story_v_out_417202.awb") / 1000

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end

					if var_67_33.prefab_name ~= "" and arg_64_1.actors_[var_67_33.prefab_name] ~= nil then
						local var_67_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_33.prefab_name].transform, "story_v_out_417202", "417202015", "story_v_out_417202.awb")

						arg_64_1:RecordAudio("417202015", var_67_39)
						arg_64_1:RecordAudio("417202015", var_67_39)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417202", "417202015", "story_v_out_417202.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417202", "417202015", "story_v_out_417202.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_40 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_40 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_40

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_40 and arg_64_1.time_ < var_67_30 + var_67_40 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play417202016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417202016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417202017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1060"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1060 == nil then
				arg_68_1.var_.actorSpriteComps1060 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps1060 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								local var_71_4 = Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, var_71_3)
								local var_71_5 = Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, var_71_3)
								local var_71_6 = Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, var_71_3)

								iter_71_1.color = Color.New(var_71_4, var_71_5, var_71_6)
							else
								local var_71_7 = Mathf.Lerp(iter_71_1.color.r, 0.5, var_71_3)

								iter_71_1.color = Color.New(var_71_7, var_71_7, var_71_7)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1060 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps1060 = nil
			end

			local var_71_8 = 0
			local var_71_9 = 0.625

			if var_71_8 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(417202016)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_12 = 25
				local var_71_13 = utf8.len(var_71_11)
				local var_71_14 = var_71_12 <= 0 and var_71_9 or var_71_9 * (var_71_13 / var_71_12)

				if var_71_14 > 0 and var_71_9 < var_71_14 then
					arg_68_1.talkMaxDuration = var_71_14

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_15 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_15

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_15 and arg_68_1.time_ < var_71_8 + var_71_15 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play417202017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417202017
		arg_72_1.duration_ = 7.8

		local var_72_0 = {
			zh = 5.466,
			ja = 7.8
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417202018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1060"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1060 == nil then
				arg_72_1.var_.actorSpriteComps1060 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps1060 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 1, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1060 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1060 = nil
			end

			local var_75_8 = 0
			local var_75_9 = 0.65

			if var_75_8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_10 = arg_72_1:FormatText(StoryNameCfg[584].name)

				arg_72_1.leftNameTxt_.text = var_75_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:GetWordFromCfg(417202017)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 26
				local var_75_14 = utf8.len(var_75_12)
				local var_75_15 = var_75_13 <= 0 and var_75_9 or var_75_9 * (var_75_14 / var_75_13)

				if var_75_15 > 0 and var_75_9 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202017", "story_v_out_417202.awb") ~= 0 then
					local var_75_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202017", "story_v_out_417202.awb") / 1000

					if var_75_16 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_8
					end

					if var_75_11.prefab_name ~= "" and arg_72_1.actors_[var_75_11.prefab_name] ~= nil then
						local var_75_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_11.prefab_name].transform, "story_v_out_417202", "417202017", "story_v_out_417202.awb")

						arg_72_1:RecordAudio("417202017", var_75_17)
						arg_72_1:RecordAudio("417202017", var_75_17)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417202", "417202017", "story_v_out_417202.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417202", "417202017", "story_v_out_417202.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_18 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_18 and arg_72_1.time_ < var_75_8 + var_75_18 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play417202018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417202018
		arg_76_1.duration_ = 3.93

		local var_76_0 = {
			zh = 2.066,
			ja = 3.933
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417202019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10128"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10128 == nil then
				arg_76_1.var_.actorSpriteComps10128 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10128 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 1, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10128 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10128 = nil
			end

			local var_79_8 = arg_76_1.actors_["10128"].transform
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 2)

				local var_79_10 = var_79_8.childCount

				for iter_79_4 = 0, var_79_10 - 1 do
					local var_79_11 = var_79_8:GetChild(iter_79_4)

					if var_79_11.name == "split_1" or not string.find(var_79_11.name, "split") then
						var_79_11.gameObject:SetActive(true)
					else
						var_79_11.gameObject:SetActive(false)
					end
				end
			end

			local var_79_12 = 0.001

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_12 then
				local var_79_13 = (arg_76_1.time_ - var_79_9) / var_79_12
				local var_79_14 = Vector3.New(-390, -347, -300)

				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, var_79_14, var_79_13)
			end

			if arg_76_1.time_ >= var_79_9 + var_79_12 and arg_76_1.time_ < var_79_9 + var_79_12 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_79_15 = arg_76_1.actors_["1060"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos1060 = var_79_15.localPosition
				var_79_15.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1060", 4)

				local var_79_17 = var_79_15.childCount

				for iter_79_5 = 0, var_79_17 - 1 do
					local var_79_18 = var_79_15:GetChild(iter_79_5)

					if var_79_18.name == "" or not string.find(var_79_18.name, "split") then
						var_79_18.gameObject:SetActive(true)
					else
						var_79_18.gameObject:SetActive(false)
					end
				end
			end

			local var_79_19 = 0.001

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_16) / var_79_19
				local var_79_21 = Vector3.New(420.9, -430.8, 6.9)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1060, var_79_21, var_79_20)
			end

			if arg_76_1.time_ >= var_79_16 + var_79_19 and arg_76_1.time_ < var_79_16 + var_79_19 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_79_22 = arg_76_1.actors_["1060"]
			local var_79_23 = 0

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 and not isNil(var_79_22) and arg_76_1.var_.actorSpriteComps1060 == nil then
				arg_76_1.var_.actorSpriteComps1060 = var_79_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_24 = 0.2

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_24 and not isNil(var_79_22) then
				local var_79_25 = (arg_76_1.time_ - var_79_23) / var_79_24

				if arg_76_1.var_.actorSpriteComps1060 then
					for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_79_7 then
							if arg_76_1.isInRecall_ then
								local var_79_26 = Mathf.Lerp(iter_79_7.color.r, arg_76_1.hightColor2.r, var_79_25)
								local var_79_27 = Mathf.Lerp(iter_79_7.color.g, arg_76_1.hightColor2.g, var_79_25)
								local var_79_28 = Mathf.Lerp(iter_79_7.color.b, arg_76_1.hightColor2.b, var_79_25)

								iter_79_7.color = Color.New(var_79_26, var_79_27, var_79_28)
							else
								local var_79_29 = Mathf.Lerp(iter_79_7.color.r, 0.5, var_79_25)

								iter_79_7.color = Color.New(var_79_29, var_79_29, var_79_29)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_23 + var_79_24 and arg_76_1.time_ < var_79_23 + var_79_24 + arg_79_0 and not isNil(var_79_22) and arg_76_1.var_.actorSpriteComps1060 then
				for iter_79_8, iter_79_9 in pairs(arg_76_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_79_9 then
						if arg_76_1.isInRecall_ then
							iter_79_9.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1060 = nil
			end

			local var_79_30 = 0
			local var_79_31 = 0.275

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_32 = arg_76_1:FormatText(StoryNameCfg[595].name)

				arg_76_1.leftNameTxt_.text = var_79_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_33 = arg_76_1:GetWordFromCfg(417202018)
				local var_79_34 = arg_76_1:FormatText(var_79_33.content)

				arg_76_1.text_.text = var_79_34

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_35 = 11
				local var_79_36 = utf8.len(var_79_34)
				local var_79_37 = var_79_35 <= 0 and var_79_31 or var_79_31 * (var_79_36 / var_79_35)

				if var_79_37 > 0 and var_79_31 < var_79_37 then
					arg_76_1.talkMaxDuration = var_79_37

					if var_79_37 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_37 + var_79_30
					end
				end

				arg_76_1.text_.text = var_79_34
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202018", "story_v_out_417202.awb") ~= 0 then
					local var_79_38 = manager.audio:GetVoiceLength("story_v_out_417202", "417202018", "story_v_out_417202.awb") / 1000

					if var_79_38 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_38 + var_79_30
					end

					if var_79_33.prefab_name ~= "" and arg_76_1.actors_[var_79_33.prefab_name] ~= nil then
						local var_79_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_33.prefab_name].transform, "story_v_out_417202", "417202018", "story_v_out_417202.awb")

						arg_76_1:RecordAudio("417202018", var_79_39)
						arg_76_1:RecordAudio("417202018", var_79_39)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417202", "417202018", "story_v_out_417202.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417202", "417202018", "story_v_out_417202.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_40 = math.max(var_79_31, arg_76_1.talkMaxDuration)

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_40 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_30) / var_79_40

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_30 + var_79_40 and arg_76_1.time_ < var_79_30 + var_79_40 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play417202019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417202019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play417202020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10128"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10128 = var_83_0.localPosition
				var_83_0.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10128", 7)

				local var_83_2 = var_83_0.childCount

				for iter_83_0 = 0, var_83_2 - 1 do
					local var_83_3 = var_83_0:GetChild(iter_83_0)

					if var_83_3.name == "" or not string.find(var_83_3.name, "split") then
						var_83_3.gameObject:SetActive(true)
					else
						var_83_3.gameObject:SetActive(false)
					end
				end
			end

			local var_83_4 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_4 then
				local var_83_5 = (arg_80_1.time_ - var_83_1) / var_83_4
				local var_83_6 = Vector3.New(0, -2000, -40)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10128, var_83_6, var_83_5)
			end

			if arg_80_1.time_ >= var_83_1 + var_83_4 and arg_80_1.time_ < var_83_1 + var_83_4 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_83_7 = arg_80_1.actors_["1060"].transform
			local var_83_8 = 0

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.var_.moveOldPos1060 = var_83_7.localPosition
				var_83_7.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1060", 7)

				local var_83_9 = var_83_7.childCount

				for iter_83_1 = 0, var_83_9 - 1 do
					local var_83_10 = var_83_7:GetChild(iter_83_1)

					if var_83_10.name == "" or not string.find(var_83_10.name, "split") then
						var_83_10.gameObject:SetActive(true)
					else
						var_83_10.gameObject:SetActive(false)
					end
				end
			end

			local var_83_11 = 0.001

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_8) / var_83_11
				local var_83_13 = Vector3.New(0, -2000, -40)

				var_83_7.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1060, var_83_13, var_83_12)
			end

			if arg_80_1.time_ >= var_83_8 + var_83_11 and arg_80_1.time_ < var_83_8 + var_83_11 + arg_83_0 then
				var_83_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_83_14 = 0
			local var_83_15 = 0.6

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_16 = arg_80_1:GetWordFromCfg(417202019)
				local var_83_17 = arg_80_1:FormatText(var_83_16.content)

				arg_80_1.text_.text = var_83_17

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_18 = 24
				local var_83_19 = utf8.len(var_83_17)
				local var_83_20 = var_83_18 <= 0 and var_83_15 or var_83_15 * (var_83_19 / var_83_18)

				if var_83_20 > 0 and var_83_15 < var_83_20 then
					arg_80_1.talkMaxDuration = var_83_20

					if var_83_20 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_17
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_21 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_21 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_21

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_21 and arg_80_1.time_ < var_83_14 + var_83_21 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play417202020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417202020
		arg_84_1.duration_ = 10.8

		local var_84_0 = {
			zh = 7.466,
			ja = 10.8
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
				arg_84_0:Play417202021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10128"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10128 == nil then
				arg_84_1.var_.actorSpriteComps10128 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps10128 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 1, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10128 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10128 = nil
			end

			local var_87_8 = arg_84_1.actors_["10128"].transform
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.var_.moveOldPos10128 = var_87_8.localPosition
				var_87_8.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10128", 3)

				local var_87_10 = var_87_8.childCount

				for iter_87_4 = 0, var_87_10 - 1 do
					local var_87_11 = var_87_8:GetChild(iter_87_4)

					if var_87_11.name == "" or not string.find(var_87_11.name, "split") then
						var_87_11.gameObject:SetActive(true)
					else
						var_87_11.gameObject:SetActive(false)
					end
				end
			end

			local var_87_12 = 0.001

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_9) / var_87_12
				local var_87_14 = Vector3.New(0, -347, -300)

				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10128, var_87_14, var_87_13)
			end

			if arg_84_1.time_ >= var_87_9 + var_87_12 and arg_84_1.time_ < var_87_9 + var_87_12 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_87_15 = 0
			local var_87_16 = 0.975

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[595].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(417202020)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202020", "story_v_out_417202.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_out_417202", "417202020", "story_v_out_417202.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_out_417202", "417202020", "story_v_out_417202.awb")

						arg_84_1:RecordAudio("417202020", var_87_24)
						arg_84_1:RecordAudio("417202020", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417202", "417202020", "story_v_out_417202.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417202", "417202020", "story_v_out_417202.awb")
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play417202021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417202021
		arg_88_1.duration_ = 5.27

		local var_88_0 = {
			zh = 4,
			ja = 5.266
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
				arg_88_0:Play417202022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10128"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10128 == nil then
				arg_88_1.var_.actorSpriteComps10128 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps10128 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 0.5, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10128 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10128 = nil
			end

			local var_91_8 = arg_88_1.actors_["10128"].transform
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 then
				arg_88_1.var_.moveOldPos10128 = var_91_8.localPosition
				var_91_8.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10128", 2)

				local var_91_10 = var_91_8.childCount

				for iter_91_4 = 0, var_91_10 - 1 do
					local var_91_11 = var_91_8:GetChild(iter_91_4)

					if var_91_11.name == "" or not string.find(var_91_11.name, "split") then
						var_91_11.gameObject:SetActive(true)
					else
						var_91_11.gameObject:SetActive(false)
					end
				end
			end

			local var_91_12 = 0.001

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_12 then
				local var_91_13 = (arg_88_1.time_ - var_91_9) / var_91_12
				local var_91_14 = Vector3.New(-390, -347, -300)

				var_91_8.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10128, var_91_14, var_91_13)
			end

			if arg_88_1.time_ >= var_91_9 + var_91_12 and arg_88_1.time_ < var_91_9 + var_91_12 + arg_91_0 then
				var_91_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_91_15 = arg_88_1.actors_["1060"].transform
			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.var_.moveOldPos1060 = var_91_15.localPosition
				var_91_15.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("1060", 4)

				local var_91_17 = var_91_15.childCount

				for iter_91_5 = 0, var_91_17 - 1 do
					local var_91_18 = var_91_15:GetChild(iter_91_5)

					if var_91_18.name == "" or not string.find(var_91_18.name, "split") then
						var_91_18.gameObject:SetActive(true)
					else
						var_91_18.gameObject:SetActive(false)
					end
				end
			end

			local var_91_19 = 0.001

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_16) / var_91_19
				local var_91_21 = Vector3.New(420.9, -430.8, 6.9)

				var_91_15.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1060, var_91_21, var_91_20)
			end

			if arg_88_1.time_ >= var_91_16 + var_91_19 and arg_88_1.time_ < var_91_16 + var_91_19 + arg_91_0 then
				var_91_15.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_91_22 = arg_88_1.actors_["1060"]
			local var_91_23 = 0

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 and not isNil(var_91_22) and arg_88_1.var_.actorSpriteComps1060 == nil then
				arg_88_1.var_.actorSpriteComps1060 = var_91_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_24 = 0.2

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_24 and not isNil(var_91_22) then
				local var_91_25 = (arg_88_1.time_ - var_91_23) / var_91_24

				if arg_88_1.var_.actorSpriteComps1060 then
					for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_91_7 then
							if arg_88_1.isInRecall_ then
								local var_91_26 = Mathf.Lerp(iter_91_7.color.r, arg_88_1.hightColor1.r, var_91_25)
								local var_91_27 = Mathf.Lerp(iter_91_7.color.g, arg_88_1.hightColor1.g, var_91_25)
								local var_91_28 = Mathf.Lerp(iter_91_7.color.b, arg_88_1.hightColor1.b, var_91_25)

								iter_91_7.color = Color.New(var_91_26, var_91_27, var_91_28)
							else
								local var_91_29 = Mathf.Lerp(iter_91_7.color.r, 1, var_91_25)

								iter_91_7.color = Color.New(var_91_29, var_91_29, var_91_29)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_23 + var_91_24 and arg_88_1.time_ < var_91_23 + var_91_24 + arg_91_0 and not isNil(var_91_22) and arg_88_1.var_.actorSpriteComps1060 then
				for iter_91_8, iter_91_9 in pairs(arg_88_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_91_9 then
						if arg_88_1.isInRecall_ then
							iter_91_9.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1060 = nil
			end

			local var_91_30 = 0
			local var_91_31 = 0.475

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_32 = arg_88_1:FormatText(StoryNameCfg[584].name)

				arg_88_1.leftNameTxt_.text = var_91_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_33 = arg_88_1:GetWordFromCfg(417202021)
				local var_91_34 = arg_88_1:FormatText(var_91_33.content)

				arg_88_1.text_.text = var_91_34

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_35 = 19
				local var_91_36 = utf8.len(var_91_34)
				local var_91_37 = var_91_35 <= 0 and var_91_31 or var_91_31 * (var_91_36 / var_91_35)

				if var_91_37 > 0 and var_91_31 < var_91_37 then
					arg_88_1.talkMaxDuration = var_91_37

					if var_91_37 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_30
					end
				end

				arg_88_1.text_.text = var_91_34
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202021", "story_v_out_417202.awb") ~= 0 then
					local var_91_38 = manager.audio:GetVoiceLength("story_v_out_417202", "417202021", "story_v_out_417202.awb") / 1000

					if var_91_38 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_38 + var_91_30
					end

					if var_91_33.prefab_name ~= "" and arg_88_1.actors_[var_91_33.prefab_name] ~= nil then
						local var_91_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_33.prefab_name].transform, "story_v_out_417202", "417202021", "story_v_out_417202.awb")

						arg_88_1:RecordAudio("417202021", var_91_39)
						arg_88_1:RecordAudio("417202021", var_91_39)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417202", "417202021", "story_v_out_417202.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417202", "417202021", "story_v_out_417202.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_40 = math.max(var_91_31, arg_88_1.talkMaxDuration)

			if var_91_30 <= arg_88_1.time_ and arg_88_1.time_ < var_91_30 + var_91_40 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_30) / var_91_40

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_30 + var_91_40 and arg_88_1.time_ < var_91_30 + var_91_40 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play417202022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417202022
		arg_92_1.duration_ = 2.33

		local var_92_0 = {
			zh = 2.333,
			ja = 2.066
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
				arg_92_0:Play417202023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10128"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10128 == nil then
				arg_92_1.var_.actorSpriteComps10128 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10128 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 1, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10128 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10128 = nil
			end

			local var_95_8 = arg_92_1.actors_["1060"]
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1060 == nil then
				arg_92_1.var_.actorSpriteComps1060 = var_95_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_10 = 0.2

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_10 and not isNil(var_95_8) then
				local var_95_11 = (arg_92_1.time_ - var_95_9) / var_95_10

				if arg_92_1.var_.actorSpriteComps1060 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								local var_95_12 = Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor2.r, var_95_11)
								local var_95_13 = Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor2.g, var_95_11)
								local var_95_14 = Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor2.b, var_95_11)

								iter_95_5.color = Color.New(var_95_12, var_95_13, var_95_14)
							else
								local var_95_15 = Mathf.Lerp(iter_95_5.color.r, 0.5, var_95_11)

								iter_95_5.color = Color.New(var_95_15, var_95_15, var_95_15)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_9 + var_95_10 and arg_92_1.time_ < var_95_9 + var_95_10 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1060 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_95_7 then
						if arg_92_1.isInRecall_ then
							iter_95_7.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1060 = nil
			end

			local var_95_16 = arg_92_1.actors_["10128"].transform
			local var_95_17 = 0

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.var_.moveOldPos10128 = var_95_16.localPosition
				var_95_16.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10128", 2)

				local var_95_18 = var_95_16.childCount

				for iter_95_8 = 0, var_95_18 - 1 do
					local var_95_19 = var_95_16:GetChild(iter_95_8)

					if var_95_19.name == "split_2" or not string.find(var_95_19.name, "split") then
						var_95_19.gameObject:SetActive(true)
					else
						var_95_19.gameObject:SetActive(false)
					end
				end
			end

			local var_95_20 = 0.001

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_20 then
				local var_95_21 = (arg_92_1.time_ - var_95_17) / var_95_20
				local var_95_22 = Vector3.New(-390, -347, -300)

				var_95_16.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10128, var_95_22, var_95_21)
			end

			if arg_92_1.time_ >= var_95_17 + var_95_20 and arg_92_1.time_ < var_95_17 + var_95_20 + arg_95_0 then
				var_95_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_95_23 = 0
			local var_95_24 = 0.225

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_25 = arg_92_1:FormatText(StoryNameCfg[595].name)

				arg_92_1.leftNameTxt_.text = var_95_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(417202022)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 9
				local var_95_29 = utf8.len(var_95_27)
				local var_95_30 = var_95_28 <= 0 and var_95_24 or var_95_24 * (var_95_29 / var_95_28)

				if var_95_30 > 0 and var_95_24 < var_95_30 then
					arg_92_1.talkMaxDuration = var_95_30

					if var_95_30 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_23
					end
				end

				arg_92_1.text_.text = var_95_27
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202022", "story_v_out_417202.awb") ~= 0 then
					local var_95_31 = manager.audio:GetVoiceLength("story_v_out_417202", "417202022", "story_v_out_417202.awb") / 1000

					if var_95_31 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_23
					end

					if var_95_26.prefab_name ~= "" and arg_92_1.actors_[var_95_26.prefab_name] ~= nil then
						local var_95_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_26.prefab_name].transform, "story_v_out_417202", "417202022", "story_v_out_417202.awb")

						arg_92_1:RecordAudio("417202022", var_95_32)
						arg_92_1:RecordAudio("417202022", var_95_32)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417202", "417202022", "story_v_out_417202.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417202", "417202022", "story_v_out_417202.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_24, arg_92_1.talkMaxDuration)

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_23) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_23 + var_95_33 and arg_92_1.time_ < var_95_23 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play417202023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417202023
		arg_96_1.duration_ = 14.07

		local var_96_0 = {
			zh = 10.233,
			ja = 14.066
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
				arg_96_0:Play417202024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10128"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10128 == nil then
				arg_96_1.var_.actorSpriteComps10128 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10128 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10128 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10128 = nil
			end

			local var_99_8 = arg_96_1.actors_["1060"]
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps1060 == nil then
				arg_96_1.var_.actorSpriteComps1060 = var_99_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_10 = 0.2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 and not isNil(var_99_8) then
				local var_99_11 = (arg_96_1.time_ - var_99_9) / var_99_10

				if arg_96_1.var_.actorSpriteComps1060 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								local var_99_12 = Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor1.r, var_99_11)
								local var_99_13 = Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor1.g, var_99_11)
								local var_99_14 = Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor1.b, var_99_11)

								iter_99_5.color = Color.New(var_99_12, var_99_13, var_99_14)
							else
								local var_99_15 = Mathf.Lerp(iter_99_5.color.r, 1, var_99_11)

								iter_99_5.color = Color.New(var_99_15, var_99_15, var_99_15)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps1060 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_99_7 then
						if arg_96_1.isInRecall_ then
							iter_99_7.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1060 = nil
			end

			local var_99_16 = 0
			local var_99_17 = 1.225

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_18 = arg_96_1:FormatText(StoryNameCfg[584].name)

				arg_96_1.leftNameTxt_.text = var_99_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(417202023)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 49
				local var_99_22 = utf8.len(var_99_20)
				local var_99_23 = var_99_21 <= 0 and var_99_17 or var_99_17 * (var_99_22 / var_99_21)

				if var_99_23 > 0 and var_99_17 < var_99_23 then
					arg_96_1.talkMaxDuration = var_99_23

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202023", "story_v_out_417202.awb") ~= 0 then
					local var_99_24 = manager.audio:GetVoiceLength("story_v_out_417202", "417202023", "story_v_out_417202.awb") / 1000

					if var_99_24 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_417202", "417202023", "story_v_out_417202.awb")

						arg_96_1:RecordAudio("417202023", var_99_25)
						arg_96_1:RecordAudio("417202023", var_99_25)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417202", "417202023", "story_v_out_417202.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417202", "417202023", "story_v_out_417202.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_26 and arg_96_1.time_ < var_99_16 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play417202024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417202024
		arg_100_1.duration_ = 7

		local var_100_0 = {
			zh = 7,
			ja = 6.6
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
				arg_100_0:Play417202025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.825

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[584].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(417202024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 33
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202024", "story_v_out_417202.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202024", "story_v_out_417202.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_417202", "417202024", "story_v_out_417202.awb")

						arg_100_1:RecordAudio("417202024", var_103_9)
						arg_100_1:RecordAudio("417202024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417202", "417202024", "story_v_out_417202.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417202", "417202024", "story_v_out_417202.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play417202025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417202025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417202026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10128"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos10128 = var_107_0.localPosition
				var_107_0.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10128", 7)

				local var_107_2 = var_107_0.childCount

				for iter_107_0 = 0, var_107_2 - 1 do
					local var_107_3 = var_107_0:GetChild(iter_107_0)

					if var_107_3.name == "" or not string.find(var_107_3.name, "split") then
						var_107_3.gameObject:SetActive(true)
					else
						var_107_3.gameObject:SetActive(false)
					end
				end
			end

			local var_107_4 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_4 then
				local var_107_5 = (arg_104_1.time_ - var_107_1) / var_107_4
				local var_107_6 = Vector3.New(0, -2000, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10128, var_107_6, var_107_5)
			end

			if arg_104_1.time_ >= var_107_1 + var_107_4 and arg_104_1.time_ < var_107_1 + var_107_4 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_7 = arg_104_1.actors_["1060"].transform
			local var_107_8 = 0

			if var_107_8 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.var_.moveOldPos1060 = var_107_7.localPosition
				var_107_7.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1060", 7)

				local var_107_9 = var_107_7.childCount

				for iter_107_1 = 0, var_107_9 - 1 do
					local var_107_10 = var_107_7:GetChild(iter_107_1)

					if var_107_10.name == "" or not string.find(var_107_10.name, "split") then
						var_107_10.gameObject:SetActive(true)
					else
						var_107_10.gameObject:SetActive(false)
					end
				end
			end

			local var_107_11 = 0.001

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_11 then
				local var_107_12 = (arg_104_1.time_ - var_107_8) / var_107_11
				local var_107_13 = Vector3.New(0, -2000, -40)

				var_107_7.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1060, var_107_13, var_107_12)
			end

			if arg_104_1.time_ >= var_107_8 + var_107_11 and arg_104_1.time_ < var_107_8 + var_107_11 + arg_107_0 then
				var_107_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_107_14 = 0
			local var_107_15 = 0.775

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_16 = arg_104_1:GetWordFromCfg(417202025)
				local var_107_17 = arg_104_1:FormatText(var_107_16.content)

				arg_104_1.text_.text = var_107_17

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_18 = 31
				local var_107_19 = utf8.len(var_107_17)
				local var_107_20 = var_107_18 <= 0 and var_107_15 or var_107_15 * (var_107_19 / var_107_18)

				if var_107_20 > 0 and var_107_15 < var_107_20 then
					arg_104_1.talkMaxDuration = var_107_20

					if var_107_20 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_14
					end
				end

				arg_104_1.text_.text = var_107_17
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_15, arg_104_1.talkMaxDuration)

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_14) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_14 + var_107_21 and arg_104_1.time_ < var_107_14 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play417202026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417202026
		arg_108_1.duration_ = 2.53

		local var_108_0 = {
			zh = 1.333,
			ja = 2.533
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
				arg_108_0:Play417202027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1060"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1060 = var_111_0.localPosition
				var_111_0.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1060", 3)

				local var_111_2 = var_111_0.childCount

				for iter_111_0 = 0, var_111_2 - 1 do
					local var_111_3 = var_111_0:GetChild(iter_111_0)

					if var_111_3.name == "split_5" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_4 then
				local var_111_5 = (arg_108_1.time_ - var_111_1) / var_111_4
				local var_111_6 = Vector3.New(33.4, -430.8, 6.9)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1060, var_111_6, var_111_5)
			end

			if arg_108_1.time_ >= var_111_1 + var_111_4 and arg_108_1.time_ < var_111_1 + var_111_4 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_111_7 = arg_108_1.actors_["1060"]
			local var_111_8 = 0

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.actorSpriteComps1060 == nil then
				arg_108_1.var_.actorSpriteComps1060 = var_111_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_9 = 0.2

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_9 and not isNil(var_111_7) then
				local var_111_10 = (arg_108_1.time_ - var_111_8) / var_111_9

				if arg_108_1.var_.actorSpriteComps1060 then
					for iter_111_1, iter_111_2 in pairs(arg_108_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_111_2 then
							if arg_108_1.isInRecall_ then
								local var_111_11 = Mathf.Lerp(iter_111_2.color.r, arg_108_1.hightColor1.r, var_111_10)
								local var_111_12 = Mathf.Lerp(iter_111_2.color.g, arg_108_1.hightColor1.g, var_111_10)
								local var_111_13 = Mathf.Lerp(iter_111_2.color.b, arg_108_1.hightColor1.b, var_111_10)

								iter_111_2.color = Color.New(var_111_11, var_111_12, var_111_13)
							else
								local var_111_14 = Mathf.Lerp(iter_111_2.color.r, 1, var_111_10)

								iter_111_2.color = Color.New(var_111_14, var_111_14, var_111_14)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_8 + var_111_9 and arg_108_1.time_ < var_111_8 + var_111_9 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.actorSpriteComps1060 then
				for iter_111_3, iter_111_4 in pairs(arg_108_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_111_4 then
						if arg_108_1.isInRecall_ then
							iter_111_4.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1060 = nil
			end

			local var_111_15 = 0
			local var_111_16 = 0.075

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[584].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(417202026)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 3
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202026", "story_v_out_417202.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_417202", "417202026", "story_v_out_417202.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_417202", "417202026", "story_v_out_417202.awb")

						arg_108_1:RecordAudio("417202026", var_111_24)
						arg_108_1:RecordAudio("417202026", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417202", "417202026", "story_v_out_417202.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417202", "417202026", "story_v_out_417202.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play417202027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417202027
		arg_112_1.duration_ = 6.13

		local var_112_0 = {
			zh = 5.9,
			ja = 6.133
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417202028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10128"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10128 == nil then
				arg_112_1.var_.actorSpriteComps10128 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps10128 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10128 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10128 = nil
			end

			local var_115_8 = arg_112_1.actors_["1060"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos1060 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1060", 7)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "" or not string.find(var_115_11.name, "split") then
						var_115_11.gameObject:SetActive(true)
					else
						var_115_11.gameObject:SetActive(false)
					end
				end
			end

			local var_115_12 = 0.001

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(0, -2000, -40)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1060, var_115_14, var_115_13)
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_115_15 = arg_112_1.actors_["10128"].transform
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.var_.moveOldPos10128 = var_115_15.localPosition
				var_115_15.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10128", 3)

				local var_115_17 = var_115_15.childCount

				for iter_115_5 = 0, var_115_17 - 1 do
					local var_115_18 = var_115_15:GetChild(iter_115_5)

					if var_115_18.name == "split_6" or not string.find(var_115_18.name, "split") then
						var_115_18.gameObject:SetActive(true)
					else
						var_115_18.gameObject:SetActive(false)
					end
				end
			end

			local var_115_19 = 0.001

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_19 then
				local var_115_20 = (arg_112_1.time_ - var_115_16) / var_115_19
				local var_115_21 = Vector3.New(0, -347, -300)

				var_115_15.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10128, var_115_21, var_115_20)
			end

			if arg_112_1.time_ >= var_115_16 + var_115_19 and arg_112_1.time_ < var_115_16 + var_115_19 + arg_115_0 then
				var_115_15.localPosition = Vector3.New(0, -347, -300)
			end

			local var_115_22 = 0
			local var_115_23 = 0.75

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_24 = arg_112_1:FormatText(StoryNameCfg[595].name)

				arg_112_1.leftNameTxt_.text = var_115_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_25 = arg_112_1:GetWordFromCfg(417202027)
				local var_115_26 = arg_112_1:FormatText(var_115_25.content)

				arg_112_1.text_.text = var_115_26

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_27 = 30
				local var_115_28 = utf8.len(var_115_26)
				local var_115_29 = var_115_27 <= 0 and var_115_23 or var_115_23 * (var_115_28 / var_115_27)

				if var_115_29 > 0 and var_115_23 < var_115_29 then
					arg_112_1.talkMaxDuration = var_115_29

					if var_115_29 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_22
					end
				end

				arg_112_1.text_.text = var_115_26
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202027", "story_v_out_417202.awb") ~= 0 then
					local var_115_30 = manager.audio:GetVoiceLength("story_v_out_417202", "417202027", "story_v_out_417202.awb") / 1000

					if var_115_30 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_22
					end

					if var_115_25.prefab_name ~= "" and arg_112_1.actors_[var_115_25.prefab_name] ~= nil then
						local var_115_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_25.prefab_name].transform, "story_v_out_417202", "417202027", "story_v_out_417202.awb")

						arg_112_1:RecordAudio("417202027", var_115_31)
						arg_112_1:RecordAudio("417202027", var_115_31)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417202", "417202027", "story_v_out_417202.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417202", "417202027", "story_v_out_417202.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_32 = math.max(var_115_23, arg_112_1.talkMaxDuration)

			if var_115_22 <= arg_112_1.time_ and arg_112_1.time_ < var_115_22 + var_115_32 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_22) / var_115_32

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_22 + var_115_32 and arg_112_1.time_ < var_115_22 + var_115_32 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play417202028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417202028
		arg_116_1.duration_ = 10.33

		local var_116_0 = {
			zh = 5.933,
			ja = 10.333
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
				arg_116_0:Play417202029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.75

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[595].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(417202028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 30
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202028", "story_v_out_417202.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202028", "story_v_out_417202.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_417202", "417202028", "story_v_out_417202.awb")

						arg_116_1:RecordAudio("417202028", var_119_9)
						arg_116_1:RecordAudio("417202028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417202", "417202028", "story_v_out_417202.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417202", "417202028", "story_v_out_417202.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417202029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417202029
		arg_120_1.duration_ = 4.07

		local var_120_0 = {
			zh = 2.733,
			ja = 4.066
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417202030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.35

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[595].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(417202029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 14
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202029", "story_v_out_417202.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202029", "story_v_out_417202.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_417202", "417202029", "story_v_out_417202.awb")

						arg_120_1:RecordAudio("417202029", var_123_9)
						arg_120_1:RecordAudio("417202029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417202", "417202029", "story_v_out_417202.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417202", "417202029", "story_v_out_417202.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417202030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417202030
		arg_124_1.duration_ = 8.97

		local var_124_0 = {
			zh = 8.1,
			ja = 8.966
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417202031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10128"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 == nil then
				arg_124_1.var_.actorSpriteComps10128 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10128 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_8 = arg_124_1.actors_["10128"].transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.moveOldPos10128 = var_127_8.localPosition
				var_127_8.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10128", 2)

				local var_127_10 = var_127_8.childCount

				for iter_127_4 = 0, var_127_10 - 1 do
					local var_127_11 = var_127_8:GetChild(iter_127_4)

					if var_127_11.name == "" or not string.find(var_127_11.name, "split") then
						var_127_11.gameObject:SetActive(true)
					else
						var_127_11.gameObject:SetActive(false)
					end
				end
			end

			local var_127_12 = 0.001

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_12 then
				local var_127_13 = (arg_124_1.time_ - var_127_9) / var_127_12
				local var_127_14 = Vector3.New(-390, -347, -300)

				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10128, var_127_14, var_127_13)
			end

			if arg_124_1.time_ >= var_127_9 + var_127_12 and arg_124_1.time_ < var_127_9 + var_127_12 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_127_15 = arg_124_1.actors_["1060"].transform
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.var_.moveOldPos1060 = var_127_15.localPosition
				var_127_15.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1060", 4)

				local var_127_17 = var_127_15.childCount

				for iter_127_5 = 0, var_127_17 - 1 do
					local var_127_18 = var_127_15:GetChild(iter_127_5)

					if var_127_18.name == "split_1" or not string.find(var_127_18.name, "split") then
						var_127_18.gameObject:SetActive(true)
					else
						var_127_18.gameObject:SetActive(false)
					end
				end
			end

			local var_127_19 = 0.001

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_16) / var_127_19
				local var_127_21 = Vector3.New(420.9, -430.8, 6.9)

				var_127_15.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1060, var_127_21, var_127_20)
			end

			if arg_124_1.time_ >= var_127_16 + var_127_19 and arg_124_1.time_ < var_127_16 + var_127_19 + arg_127_0 then
				var_127_15.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_127_22 = arg_124_1.actors_["1060"]
			local var_127_23 = 0

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 and not isNil(var_127_22) and arg_124_1.var_.actorSpriteComps1060 == nil then
				arg_124_1.var_.actorSpriteComps1060 = var_127_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_24 = 0.2

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_24 and not isNil(var_127_22) then
				local var_127_25 = (arg_124_1.time_ - var_127_23) / var_127_24

				if arg_124_1.var_.actorSpriteComps1060 then
					for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_127_7 then
							if arg_124_1.isInRecall_ then
								local var_127_26 = Mathf.Lerp(iter_127_7.color.r, arg_124_1.hightColor1.r, var_127_25)
								local var_127_27 = Mathf.Lerp(iter_127_7.color.g, arg_124_1.hightColor1.g, var_127_25)
								local var_127_28 = Mathf.Lerp(iter_127_7.color.b, arg_124_1.hightColor1.b, var_127_25)

								iter_127_7.color = Color.New(var_127_26, var_127_27, var_127_28)
							else
								local var_127_29 = Mathf.Lerp(iter_127_7.color.r, 1, var_127_25)

								iter_127_7.color = Color.New(var_127_29, var_127_29, var_127_29)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_23 + var_127_24 and arg_124_1.time_ < var_127_23 + var_127_24 + arg_127_0 and not isNil(var_127_22) and arg_124_1.var_.actorSpriteComps1060 then
				for iter_127_8, iter_127_9 in pairs(arg_124_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_127_9 then
						if arg_124_1.isInRecall_ then
							iter_127_9.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1060 = nil
			end

			local var_127_30 = 0
			local var_127_31 = 0.95

			if var_127_30 < arg_124_1.time_ and arg_124_1.time_ <= var_127_30 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_32 = arg_124_1:FormatText(StoryNameCfg[584].name)

				arg_124_1.leftNameTxt_.text = var_127_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_33 = arg_124_1:GetWordFromCfg(417202030)
				local var_127_34 = arg_124_1:FormatText(var_127_33.content)

				arg_124_1.text_.text = var_127_34

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_35 = 38
				local var_127_36 = utf8.len(var_127_34)
				local var_127_37 = var_127_35 <= 0 and var_127_31 or var_127_31 * (var_127_36 / var_127_35)

				if var_127_37 > 0 and var_127_31 < var_127_37 then
					arg_124_1.talkMaxDuration = var_127_37

					if var_127_37 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_37 + var_127_30
					end
				end

				arg_124_1.text_.text = var_127_34
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202030", "story_v_out_417202.awb") ~= 0 then
					local var_127_38 = manager.audio:GetVoiceLength("story_v_out_417202", "417202030", "story_v_out_417202.awb") / 1000

					if var_127_38 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_38 + var_127_30
					end

					if var_127_33.prefab_name ~= "" and arg_124_1.actors_[var_127_33.prefab_name] ~= nil then
						local var_127_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_33.prefab_name].transform, "story_v_out_417202", "417202030", "story_v_out_417202.awb")

						arg_124_1:RecordAudio("417202030", var_127_39)
						arg_124_1:RecordAudio("417202030", var_127_39)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417202", "417202030", "story_v_out_417202.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417202", "417202030", "story_v_out_417202.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_40 = math.max(var_127_31, arg_124_1.talkMaxDuration)

			if var_127_30 <= arg_124_1.time_ and arg_124_1.time_ < var_127_30 + var_127_40 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_30) / var_127_40

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_30 + var_127_40 and arg_124_1.time_ < var_127_30 + var_127_40 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play417202031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417202031
		arg_128_1.duration_ = 3.33

		local var_128_0 = {
			zh = 2.2,
			ja = 3.333
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417202032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10128"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 == nil then
				arg_128_1.var_.actorSpriteComps10128 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps10128 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 1, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_8 = arg_128_1.actors_["1060"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps1060 == nil then
				arg_128_1.var_.actorSpriteComps1060 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.2

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps1060 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								local var_131_12 = Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor2.r, var_131_11)
								local var_131_13 = Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor2.g, var_131_11)
								local var_131_14 = Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor2.b, var_131_11)

								iter_131_5.color = Color.New(var_131_12, var_131_13, var_131_14)
							else
								local var_131_15 = Mathf.Lerp(iter_131_5.color.r, 0.5, var_131_11)

								iter_131_5.color = Color.New(var_131_15, var_131_15, var_131_15)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps1060 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1060 = nil
			end

			local var_131_16 = 0
			local var_131_17 = 0.25

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_18 = arg_128_1:FormatText(StoryNameCfg[595].name)

				arg_128_1.leftNameTxt_.text = var_131_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_19 = arg_128_1:GetWordFromCfg(417202031)
				local var_131_20 = arg_128_1:FormatText(var_131_19.content)

				arg_128_1.text_.text = var_131_20

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_21 = 10
				local var_131_22 = utf8.len(var_131_20)
				local var_131_23 = var_131_21 <= 0 and var_131_17 or var_131_17 * (var_131_22 / var_131_21)

				if var_131_23 > 0 and var_131_17 < var_131_23 then
					arg_128_1.talkMaxDuration = var_131_23

					if var_131_23 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_16
					end
				end

				arg_128_1.text_.text = var_131_20
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202031", "story_v_out_417202.awb") ~= 0 then
					local var_131_24 = manager.audio:GetVoiceLength("story_v_out_417202", "417202031", "story_v_out_417202.awb") / 1000

					if var_131_24 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_16
					end

					if var_131_19.prefab_name ~= "" and arg_128_1.actors_[var_131_19.prefab_name] ~= nil then
						local var_131_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_19.prefab_name].transform, "story_v_out_417202", "417202031", "story_v_out_417202.awb")

						arg_128_1:RecordAudio("417202031", var_131_25)
						arg_128_1:RecordAudio("417202031", var_131_25)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417202", "417202031", "story_v_out_417202.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417202", "417202031", "story_v_out_417202.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_26 = math.max(var_131_17, arg_128_1.talkMaxDuration)

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_26 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_16) / var_131_26

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_16 + var_131_26 and arg_128_1.time_ < var_131_16 + var_131_26 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417202032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417202032
		arg_132_1.duration_ = 10.17

		local var_132_0 = {
			zh = 9.2,
			ja = 10.166
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
				arg_132_0:Play417202033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10128"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10128 == nil then
				arg_132_1.var_.actorSpriteComps10128 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10128 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 0.5, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_8 = arg_132_1.actors_["1060"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1060 == nil then
				arg_132_1.var_.actorSpriteComps1060 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1060 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor1.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor1.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor1.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 1, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1060 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1060 = nil
			end

			local var_135_16 = 0
			local var_135_17 = 1.1

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_18 = arg_132_1:FormatText(StoryNameCfg[584].name)

				arg_132_1.leftNameTxt_.text = var_135_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_19 = arg_132_1:GetWordFromCfg(417202032)
				local var_135_20 = arg_132_1:FormatText(var_135_19.content)

				arg_132_1.text_.text = var_135_20

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_21 = 44
				local var_135_22 = utf8.len(var_135_20)
				local var_135_23 = var_135_21 <= 0 and var_135_17 or var_135_17 * (var_135_22 / var_135_21)

				if var_135_23 > 0 and var_135_17 < var_135_23 then
					arg_132_1.talkMaxDuration = var_135_23

					if var_135_23 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_16
					end
				end

				arg_132_1.text_.text = var_135_20
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202032", "story_v_out_417202.awb") ~= 0 then
					local var_135_24 = manager.audio:GetVoiceLength("story_v_out_417202", "417202032", "story_v_out_417202.awb") / 1000

					if var_135_24 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_24 + var_135_16
					end

					if var_135_19.prefab_name ~= "" and arg_132_1.actors_[var_135_19.prefab_name] ~= nil then
						local var_135_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_19.prefab_name].transform, "story_v_out_417202", "417202032", "story_v_out_417202.awb")

						arg_132_1:RecordAudio("417202032", var_135_25)
						arg_132_1:RecordAudio("417202032", var_135_25)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417202", "417202032", "story_v_out_417202.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417202", "417202032", "story_v_out_417202.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_26 = math.max(var_135_17, arg_132_1.talkMaxDuration)

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_26 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_16) / var_135_26

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_16 + var_135_26 and arg_132_1.time_ < var_135_16 + var_135_26 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417202033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417202033
		arg_136_1.duration_ = 2.13

		local var_136_0 = {
			zh = 2.133,
			ja = 2.066
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
				arg_136_0:Play417202034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10128"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10128 == nil then
				arg_136_1.var_.actorSpriteComps10128 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps10128 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 1, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10128 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10128 = nil
			end

			local var_139_8 = arg_136_1.actors_["1060"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1060 == nil then
				arg_136_1.var_.actorSpriteComps1060 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 0.2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps1060 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								local var_139_12 = Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor2.r, var_139_11)
								local var_139_13 = Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor2.g, var_139_11)
								local var_139_14 = Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor2.b, var_139_11)

								iter_139_5.color = Color.New(var_139_12, var_139_13, var_139_14)
							else
								local var_139_15 = Mathf.Lerp(iter_139_5.color.r, 0.5, var_139_11)

								iter_139_5.color = Color.New(var_139_15, var_139_15, var_139_15)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1060 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1060 = nil
			end

			local var_139_16 = 0
			local var_139_17 = 0.25

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_18 = arg_136_1:FormatText(StoryNameCfg[595].name)

				arg_136_1.leftNameTxt_.text = var_139_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_19 = arg_136_1:GetWordFromCfg(417202033)
				local var_139_20 = arg_136_1:FormatText(var_139_19.content)

				arg_136_1.text_.text = var_139_20

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_21 = 10
				local var_139_22 = utf8.len(var_139_20)
				local var_139_23 = var_139_21 <= 0 and var_139_17 or var_139_17 * (var_139_22 / var_139_21)

				if var_139_23 > 0 and var_139_17 < var_139_23 then
					arg_136_1.talkMaxDuration = var_139_23

					if var_139_23 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_16
					end
				end

				arg_136_1.text_.text = var_139_20
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202033", "story_v_out_417202.awb") ~= 0 then
					local var_139_24 = manager.audio:GetVoiceLength("story_v_out_417202", "417202033", "story_v_out_417202.awb") / 1000

					if var_139_24 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_16
					end

					if var_139_19.prefab_name ~= "" and arg_136_1.actors_[var_139_19.prefab_name] ~= nil then
						local var_139_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_19.prefab_name].transform, "story_v_out_417202", "417202033", "story_v_out_417202.awb")

						arg_136_1:RecordAudio("417202033", var_139_25)
						arg_136_1:RecordAudio("417202033", var_139_25)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417202", "417202033", "story_v_out_417202.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417202", "417202033", "story_v_out_417202.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_26 = math.max(var_139_17, arg_136_1.talkMaxDuration)

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_26 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_16) / var_139_26

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_16 + var_139_26 and arg_136_1.time_ < var_139_16 + var_139_26 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417202034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417202034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417202035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10128"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10128 = var_143_0.localPosition
				var_143_0.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10128", 7)

				local var_143_2 = var_143_0.childCount

				for iter_143_0 = 0, var_143_2 - 1 do
					local var_143_3 = var_143_0:GetChild(iter_143_0)

					if var_143_3.name == "split_6" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_4 then
				local var_143_5 = (arg_140_1.time_ - var_143_1) / var_143_4
				local var_143_6 = Vector3.New(0, -2000, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10128, var_143_6, var_143_5)
			end

			if arg_140_1.time_ >= var_143_1 + var_143_4 and arg_140_1.time_ < var_143_1 + var_143_4 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_7 = arg_140_1.actors_["1060"].transform
			local var_143_8 = 0

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.var_.moveOldPos1060 = var_143_7.localPosition
				var_143_7.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1060", 7)

				local var_143_9 = var_143_7.childCount

				for iter_143_1 = 0, var_143_9 - 1 do
					local var_143_10 = var_143_7:GetChild(iter_143_1)

					if var_143_10.name == "" or not string.find(var_143_10.name, "split") then
						var_143_10.gameObject:SetActive(true)
					else
						var_143_10.gameObject:SetActive(false)
					end
				end
			end

			local var_143_11 = 0.001

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_11 then
				local var_143_12 = (arg_140_1.time_ - var_143_8) / var_143_11
				local var_143_13 = Vector3.New(0, -2000, -40)

				var_143_7.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1060, var_143_13, var_143_12)
			end

			if arg_140_1.time_ >= var_143_8 + var_143_11 and arg_140_1.time_ < var_143_8 + var_143_11 + arg_143_0 then
				var_143_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_143_14 = 0
			local var_143_15 = 0.8

			if var_143_14 < arg_140_1.time_ and arg_140_1.time_ <= var_143_14 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_16 = arg_140_1:GetWordFromCfg(417202034)
				local var_143_17 = arg_140_1:FormatText(var_143_16.content)

				arg_140_1.text_.text = var_143_17

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_18 = 32
				local var_143_19 = utf8.len(var_143_17)
				local var_143_20 = var_143_18 <= 0 and var_143_15 or var_143_15 * (var_143_19 / var_143_18)

				if var_143_20 > 0 and var_143_15 < var_143_20 then
					arg_140_1.talkMaxDuration = var_143_20

					if var_143_20 + var_143_14 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_14
					end
				end

				arg_140_1.text_.text = var_143_17
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_21 = math.max(var_143_15, arg_140_1.talkMaxDuration)

			if var_143_14 <= arg_140_1.time_ and arg_140_1.time_ < var_143_14 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_14) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_14 + var_143_21 and arg_140_1.time_ < var_143_14 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play417202035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417202035
		arg_144_1.duration_ = 5.73

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417202036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_1 = 1

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_1 then
				local var_147_2 = (arg_144_1.time_ - var_147_0) / var_147_1
				local var_147_3 = Color.New(0, 0, 0)

				var_147_3.a = Mathf.Lerp(0, 1, var_147_2)
				arg_144_1.mask_.color = var_147_3
			end

			if arg_144_1.time_ >= var_147_0 + var_147_1 and arg_144_1.time_ < var_147_0 + var_147_1 + arg_147_0 then
				local var_147_4 = Color.New(0, 0, 0)

				var_147_4.a = 1
				arg_144_1.mask_.color = var_147_4
			end

			local var_147_5 = 1

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_6 = 1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6
				local var_147_8 = Color.New(0, 0, 0)

				var_147_8.a = Mathf.Lerp(1, 0, var_147_7)
				arg_144_1.mask_.color = var_147_8
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 then
				local var_147_9 = Color.New(0, 0, 0)
				local var_147_10 = 0

				arg_144_1.mask_.enabled = false
				var_147_9.a = var_147_10
				arg_144_1.mask_.color = var_147_9
			end

			local var_147_11 = "STblack"

			if arg_144_1.bgs_[var_147_11] == nil then
				local var_147_12 = Object.Instantiate(arg_144_1.paintGo_)

				var_147_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_147_11)
				var_147_12.name = var_147_11
				var_147_12.transform.parent = arg_144_1.stage_.transform
				var_147_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.bgs_[var_147_11] = var_147_12
			end

			local var_147_13 = 1

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				local var_147_14 = manager.ui.mainCamera.transform.localPosition
				local var_147_15 = Vector3.New(0, 0, 10) + Vector3.New(var_147_14.x, var_147_14.y, 0)
				local var_147_16 = arg_144_1.bgs_.STblack

				var_147_16.transform.localPosition = var_147_15
				var_147_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_17 = var_147_16:GetComponent("SpriteRenderer")

				if var_147_17 and var_147_17.sprite then
					local var_147_18 = (var_147_16.transform.localPosition - var_147_14).z
					local var_147_19 = manager.ui.mainCameraCom_
					local var_147_20 = 2 * var_147_18 * Mathf.Tan(var_147_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_147_21 = var_147_20 * var_147_19.aspect
					local var_147_22 = var_147_17.sprite.bounds.size.x
					local var_147_23 = var_147_17.sprite.bounds.size.y
					local var_147_24 = var_147_21 / var_147_22
					local var_147_25 = var_147_20 / var_147_23
					local var_147_26 = var_147_25 < var_147_24 and var_147_24 or var_147_25

					var_147_16.transform.localScale = Vector3.New(var_147_26, var_147_26, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "STblack" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_147_27 = 1

			if var_147_27 < arg_144_1.time_ and arg_144_1.time_ <= var_147_27 + arg_147_0 then
				arg_144_1.fswbg_:SetActive(true)
				arg_144_1.dialog_:SetActive(false)

				arg_144_1.fswtw_.percent = 0

				local var_147_28 = arg_144_1:GetWordFromCfg(417202035)
				local var_147_29 = arg_144_1:FormatText(var_147_28.content)

				arg_144_1.fswt_.text = var_147_29

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.fswt_)

				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_144_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_144_1.fswtw_:SetDirty()

				arg_144_1.typewritterCharCountI18N = 0

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_30 = 1.43333333333333

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1.var_.oldValueTypewriter = arg_144_1.fswtw_.percent

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_31 = 21
			local var_147_32 = 1.2
			local var_147_33 = arg_144_1:GetWordFromCfg(417202035)
			local var_147_34 = arg_144_1:FormatText(var_147_33.content)
			local var_147_35, var_147_36 = arg_144_1:GetPercentByPara(var_147_34, 1)

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				local var_147_37 = var_147_31 <= 0 and var_147_32 or var_147_32 * ((var_147_36 - arg_144_1.typewritterCharCountI18N) / var_147_31)

				if var_147_37 > 0 and var_147_32 < var_147_37 then
					arg_144_1.talkMaxDuration = var_147_37

					if var_147_37 + var_147_30 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_37 + var_147_30
					end
				end
			end

			local var_147_38 = 1.2
			local var_147_39 = math.max(var_147_38, arg_144_1.talkMaxDuration)

			if var_147_30 <= arg_144_1.time_ and arg_144_1.time_ < var_147_30 + var_147_39 then
				local var_147_40 = (arg_144_1.time_ - var_147_30) / var_147_39

				arg_144_1.fswtw_.percent = Mathf.Lerp(arg_144_1.var_.oldValueTypewriter, var_147_35, var_147_40)
				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.fswtw_:SetDirty()
			end

			if arg_144_1.time_ >= var_147_30 + var_147_39 and arg_144_1.time_ < var_147_30 + var_147_39 + arg_147_0 then
				arg_144_1.fswtw_.percent = var_147_35

				arg_144_1.fswtw_:SetDirty()
				arg_144_1:ShowNextGo(true)

				arg_144_1.typewritterCharCountI18N = var_147_36
			end

			local var_147_41 = 1.01666666666667

			if var_147_41 < arg_144_1.time_ and arg_144_1.time_ <= var_147_41 + arg_147_0 then
				local var_147_42 = arg_144_1.fswbg_.transform:Find("textbox/adapt/content") or arg_144_1.fswbg_.transform:Find("textbox/content")
				local var_147_43 = arg_144_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_147_44 = var_147_42:GetComponent("Text")
				local var_147_45 = var_147_42:GetComponent("RectTransform")

				var_147_44.alignment = UnityEngine.TextAnchor.LowerCenter
				var_147_45.offsetMin = Vector2.New(0, 0)
				var_147_45.offsetMax = Vector2.New(0, 0)
			end

			local var_147_46 = 1

			if var_147_46 < arg_144_1.time_ and arg_144_1.time_ <= var_147_46 + arg_147_0 then
				arg_144_1.cswbg_:SetActive(true)

				local var_147_47 = arg_144_1.cswt_:GetComponent("RectTransform")

				arg_144_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_147_47.offsetMin = Vector2.New(0, 0)
				var_147_47.offsetMax = Vector2.New(0, 0)

				local var_147_48 = arg_144_1:GetWordFromCfg(419110)
				local var_147_49 = arg_144_1:FormatText(var_147_48.content)

				arg_144_1.cswt_.text = var_147_49

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.cswt_)

				arg_144_1.cswt_.fontSize = 120
				arg_144_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_144_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_147_50 = 1.43333333333333
			local var_147_51 = 4.3
			local var_147_52 = manager.audio:GetVoiceLength("story_v_out_417202", "417202035", "") / 1000

			if var_147_52 > 0 and var_147_51 < var_147_52 and var_147_52 + var_147_50 > arg_144_1.duration_ then
				local var_147_53 = var_147_52

				arg_144_1.duration_ = var_147_52 + var_147_50
			end

			if var_147_50 < arg_144_1.time_ and arg_144_1.time_ <= var_147_50 + arg_147_0 then
				local var_147_54 = "play"
				local var_147_55 = "voice"

				arg_144_1:AudioAction(var_147_54, var_147_55, "story_v_out_417202", "417202035", "")
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417202036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417202036
		arg_148_1.duration_ = 2.49

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417202037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.fswbg_:SetActive(true)
				arg_148_1.dialog_:SetActive(false)

				arg_148_1.fswtw_.percent = 0

				local var_151_1 = arg_148_1:GetWordFromCfg(417202036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.fswt_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.fswt_)

				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_148_1.fswtw_:SetDirty()

				arg_148_1.typewritterCharCountI18N = 0

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_3 = 0.0999999999999999

			if var_151_3 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_4 = 12
			local var_151_5 = 0.6
			local var_151_6 = arg_148_1:GetWordFromCfg(417202036)
			local var_151_7 = arg_148_1:FormatText(var_151_6.content)
			local var_151_8, var_151_9 = arg_148_1:GetPercentByPara(var_151_7, 1)

			if var_151_3 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_10 = var_151_4 <= 0 and var_151_5 or var_151_5 * ((var_151_9 - arg_148_1.typewritterCharCountI18N) / var_151_4)

				if var_151_10 > 0 and var_151_5 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_3
					end
				end
			end

			local var_151_11 = 0.6
			local var_151_12 = math.max(var_151_11, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_3) / var_151_12

				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_8, var_151_13)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_12 and arg_148_1.time_ < var_151_3 + var_151_12 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_8

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_9
			end

			local var_151_14 = 0.0872775018215179
			local var_151_15 = 2.4
			local var_151_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202036", "") / 1000

			if var_151_16 > 0 and var_151_15 < var_151_16 and var_151_16 + var_151_14 > arg_148_1.duration_ then
				local var_151_17 = var_151_16

				arg_148_1.duration_ = var_151_16 + var_151_14
			end

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				local var_151_18 = "play"
				local var_151_19 = "voice"

				arg_148_1:AudioAction(var_151_18, var_151_19, "story_v_out_417202", "417202036", "")
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play417202037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417202037
		arg_152_1.duration_ = 8.23

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417202038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.fswbg_:SetActive(true)
				arg_152_1.dialog_:SetActive(false)

				arg_152_1.fswtw_.percent = 0

				local var_155_1 = arg_152_1:GetWordFromCfg(417202037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.fswt_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.fswt_)

				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_152_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_152_1.fswtw_:SetDirty()

				arg_152_1.typewritterCharCountI18N = 0

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_3 = 0.0999999999999999

			if var_155_3 < arg_152_1.time_ and arg_152_1.time_ <= var_155_3 + arg_155_0 then
				arg_152_1.var_.oldValueTypewriter = arg_152_1.fswtw_.percent

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_4 = 43
			local var_155_5 = 2.66666666666667
			local var_155_6 = arg_152_1:GetWordFromCfg(417202037)
			local var_155_7 = arg_152_1:FormatText(var_155_6.content)
			local var_155_8, var_155_9 = arg_152_1:GetPercentByPara(var_155_7, 1)

			if var_155_3 < arg_152_1.time_ and arg_152_1.time_ <= var_155_3 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				local var_155_10 = var_155_4 <= 0 and var_155_5 or var_155_5 * ((var_155_9 - arg_152_1.typewritterCharCountI18N) / var_155_4)

				if var_155_10 > 0 and var_155_5 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_3 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_3
					end
				end
			end

			local var_155_11 = 2.66666666666667
			local var_155_12 = math.max(var_155_11, arg_152_1.talkMaxDuration)

			if var_155_3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_3 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_3) / var_155_12

				arg_152_1.fswtw_.percent = Mathf.Lerp(arg_152_1.var_.oldValueTypewriter, var_155_8, var_155_13)
				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_152_1.fswtw_:SetDirty()
			end

			if arg_152_1.time_ >= var_155_3 + var_155_12 and arg_152_1.time_ < var_155_3 + var_155_12 + arg_155_0 then
				arg_152_1.fswtw_.percent = var_155_8

				arg_152_1.fswtw_:SetDirty()
				arg_152_1:ShowNextGo(true)

				arg_152_1.typewritterCharCountI18N = var_155_9
			end

			local var_155_14 = 0.0999999999999999
			local var_155_15 = 8.133
			local var_155_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202037", "") / 1000

			if var_155_16 > 0 and var_155_15 < var_155_16 and var_155_16 + var_155_14 > arg_152_1.duration_ then
				local var_155_17 = var_155_16

				arg_152_1.duration_ = var_155_16 + var_155_14
			end

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				local var_155_18 = "play"
				local var_155_19 = "voice"

				arg_152_1:AudioAction(var_155_18, var_155_19, "story_v_out_417202", "417202037", "")
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417202038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417202038
		arg_156_1.duration_ = 8.09

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417202039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.fswbg_:SetActive(true)
				arg_156_1.dialog_:SetActive(false)

				arg_156_1.fswtw_.percent = 0

				local var_159_1 = arg_156_1:GetWordFromCfg(417202038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.fswt_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.fswt_)

				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_156_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_156_1.fswtw_:SetDirty()

				arg_156_1.typewritterCharCountI18N = 0

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_3 = 0.0999999999999999

			if var_159_3 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_4 = 40
			local var_159_5 = 2.66666666666667
			local var_159_6 = arg_156_1:GetWordFromCfg(417202038)
			local var_159_7 = arg_156_1:FormatText(var_159_6.content)
			local var_159_8, var_159_9 = arg_156_1:GetPercentByPara(var_159_7, 1)

			if var_159_3 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_10 = var_159_4 <= 0 and var_159_5 or var_159_5 * ((var_159_9 - arg_156_1.typewritterCharCountI18N) / var_159_4)

				if var_159_10 > 0 and var_159_5 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_3
					end
				end
			end

			local var_159_11 = 2.66666666666667
			local var_159_12 = math.max(var_159_11, arg_156_1.talkMaxDuration)

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_12 then
				local var_159_13 = (arg_156_1.time_ - var_159_3) / var_159_12

				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_8, var_159_13)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= var_159_3 + var_159_12 and arg_156_1.time_ < var_159_3 + var_159_12 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_8

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_9
			end

			local var_159_14 = 0.0853788033127785
			local var_159_15 = 8
			local var_159_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202038", "") / 1000

			if var_159_16 > 0 and var_159_15 < var_159_16 and var_159_16 + var_159_14 > arg_156_1.duration_ then
				local var_159_17 = var_159_16

				arg_156_1.duration_ = var_159_16 + var_159_14
			end

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				local var_159_18 = "play"
				local var_159_19 = "voice"

				arg_156_1:AudioAction(var_159_18, var_159_19, "story_v_out_417202", "417202038", "")
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417202039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417202039
		arg_160_1.duration_ = 2.59

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0

				local var_163_1 = arg_160_1:GetWordFromCfg(417202039)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.fswt_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_3 = 0.0999999999999999

			if var_163_3 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_4 = 17
			local var_163_5 = 0.933333333333333
			local var_163_6 = arg_160_1:GetWordFromCfg(417202039)
			local var_163_7 = arg_160_1:FormatText(var_163_6.content)
			local var_163_8, var_163_9 = arg_160_1:GetPercentByPara(var_163_7, 1)

			if var_163_3 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_10 = var_163_4 <= 0 and var_163_5 or var_163_5 * ((var_163_9 - arg_160_1.typewritterCharCountI18N) / var_163_4)

				if var_163_10 > 0 and var_163_5 < var_163_10 then
					arg_160_1.talkMaxDuration = var_163_10

					if var_163_10 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_3
					end
				end
			end

			local var_163_11 = 0.933333333333333
			local var_163_12 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_3) / var_163_12

				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_8, var_163_13)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_12 and arg_160_1.time_ < var_163_3 + var_163_12 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_8

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_9
			end

			local var_163_14 = 0.0889083966612816
			local var_163_15 = 2.5
			local var_163_16 = manager.audio:GetVoiceLength("story_v_out_417202", "417202039", "") / 1000

			if var_163_16 > 0 and var_163_15 < var_163_16 and var_163_16 + var_163_14 > arg_160_1.duration_ then
				local var_163_17 = var_163_16

				arg_160_1.duration_ = var_163_16 + var_163_14
			end

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				local var_163_18 = "play"
				local var_163_19 = "voice"

				arg_160_1:AudioAction(var_163_18, var_163_19, "story_v_out_417202", "417202039", "")
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05c",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417202.awb"
	}
}
