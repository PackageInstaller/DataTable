return {
	Play417131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417131001
		arg_1_1.duration_ = 10.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2105a"

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
				local var_4_5 = arg_1_1.bgs_.ST2105a

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
					if iter_4_0 ~= "ST2105a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 5.4

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = manager.ui.mainCamera.transform
			local var_4_19 = 4.18791796957764

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				local var_4_20 = arg_1_1.var_.effect809
				local var_4_21
				local var_4_22 = var_4_18

				if not var_4_20 then
					var_4_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), var_4_22)
					var_4_20.name = "809"
					arg_1_1.var_.effect809 = var_4_20
				else
					var_4_20.transform:SetParent(var_4_22)
				end

				var_4_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_23 = manager.ui.mainCameraCom_
				local var_4_24 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_25 = var_4_20.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_4_26 = 15
				local var_4_27 = 2 * var_4_26 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_4_23.aspect
				local var_4_28 = 1
				local var_4_29 = 1.7777777777777777

				if var_4_29 < var_4_23.aspect then
					var_4_28 = var_4_27 / (2 * var_4_26 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_4_29)
				end

				for iter_4_2, iter_4_3 in ipairs(var_4_25) do
					local var_4_30 = iter_4_3.transform.localScale

					iter_4_3.transform.localScale = Vector3.New(var_4_30.x / var_4_24 * var_4_28, var_4_30.y / var_4_24, var_4_30.z)
				end
			end

			local var_4_31 = 0.0430384017527103
			local var_4_32 = 1

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "effect"

				arg_1_1:AudioAction(var_4_33, var_4_34, "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			local var_4_35 = 0
			local var_4_36 = 0.2

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "music"

				arg_1_1:AudioAction(var_4_37, var_4_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_39 = ""
				local var_4_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_40 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_40 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_40

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_40
						arg_1_1.bgmTxt2_.text = var_4_40
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

			local var_4_41 = 0.466666666666667
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0
			local var_4_48 = 3
			local var_4_49 = "ST2105a"

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_49)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_50 = arg_1_1:GetWordFromCfg(501043)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_timeText_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_52 = arg_1_1:GetWordFromCfg(501044)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_siteText_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_54 = 3

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_55 = 1.2

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				local var_4_56 = (arg_1_1.time_ - var_4_54) / var_4_55
				local var_4_57 = Color.New(0, 0, 0)

				var_4_57.a = Mathf.Lerp(0, 1, var_4_56)
				arg_1_1.mask_.color = var_4_57
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				local var_4_58 = Color.New(0, 0, 0)

				var_4_58.a = 1
				arg_1_1.mask_.color = var_4_58
			end

			local var_4_59 = 4.2

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_60 = 1.2

			if var_4_59 <= arg_1_1.time_ and arg_1_1.time_ < var_4_59 + var_4_60 then
				local var_4_61 = (arg_1_1.time_ - var_4_59) / var_4_60
				local var_4_62 = Color.New(0, 0, 0)

				var_4_62.a = Mathf.Lerp(1, 0, var_4_61)
				arg_1_1.mask_.color = var_4_62
			end

			if arg_1_1.time_ >= var_4_59 + var_4_60 and arg_1_1.time_ < var_4_59 + var_4_60 + arg_4_0 then
				local var_4_63 = Color.New(0, 0, 0)
				local var_4_64 = 0

				arg_1_1.mask_.enabled = false
				var_4_63.a = var_4_64
				arg_1_1.mask_.color = var_4_63
			end

			local var_4_65 = 0

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_66 = 1

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				local var_4_67 = (arg_1_1.time_ - var_4_65) / var_4_66
				local var_4_68 = Color.New(0, 0, 0)

				var_4_68.a = Mathf.Lerp(1, 0, var_4_67)
				arg_1_1.mask_.color = var_4_68
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				local var_4_69 = Color.New(0, 0, 0)
				local var_4_70 = 0

				arg_1_1.mask_.enabled = false
				var_4_69.a = var_4_70
				arg_1_1.mask_.color = var_4_69
			end

			local var_4_71 = 0

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_72 = 3

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_73 = 5.4
			local var_4_74 = 1.3

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_75 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_75:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_76 = arg_1_1:GetWordFromCfg(417131001)
				local var_4_77 = arg_1_1:FormatText(var_4_76.content)

				arg_1_1.text_.text = var_4_77

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_78 = 52
				local var_4_79 = utf8.len(var_4_77)
				local var_4_80 = var_4_78 <= 0 and var_4_74 or var_4_74 * (var_4_79 / var_4_78)

				if var_4_80 > 0 and var_4_74 < var_4_80 then
					arg_1_1.talkMaxDuration = var_4_80
					var_4_73 = var_4_73 + 0.3

					if var_4_80 + var_4_73 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_73
					end
				end

				arg_1_1.text_.text = var_4_77
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_81 = var_4_73 + 0.3
			local var_4_82 = math.max(var_4_74, arg_1_1.talkMaxDuration)

			if var_4_81 <= arg_1_1.time_ and arg_1_1.time_ < var_4_81 + var_4_82 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_81) / var_4_82

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_81 + var_4_82 and arg_1_1.time_ < var_4_81 + var_4_82 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417131002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417131002
		arg_10_1.duration_ = 9.87

		local var_10_0 = {
			zh = 5.333,
			ja = 9.866
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417131003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1034"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(var_13_1, arg_10_1.canvasGo_.transform)

					var_13_2.transform:SetSiblingIndex(1)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs(var_13_3) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_4 = arg_10_1.actors_["1034"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								local var_13_8 = Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor1.r, var_13_7)
								local var_13_9 = Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor1.g, var_13_7)
								local var_13_10 = Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor1.b, var_13_7)

								iter_13_3.color = Color.New(var_13_8, var_13_9, var_13_10)
							else
								local var_13_11 = Mathf.Lerp(iter_13_3.color.r, 1, var_13_7)

								iter_13_3.color = Color.New(var_13_11, var_13_11, var_13_11)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_13_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_12 = arg_10_1.actors_["1034"].transform
			local var_13_13 = 0

			if var_13_13 < arg_10_1.time_ and arg_10_1.time_ <= var_13_13 + arg_13_0 then
				arg_10_1.var_.moveOldPos1034 = var_13_12.localPosition
				var_13_12.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1034", 2)

				local var_13_14 = var_13_12.childCount

				for iter_13_6 = 0, var_13_14 - 1 do
					local var_13_15 = var_13_12:GetChild(iter_13_6)

					if var_13_15.name == "split_4" or not string.find(var_13_15.name, "split") then
						var_13_15.gameObject:SetActive(true)
					else
						var_13_15.gameObject:SetActive(false)
					end
				end
			end

			local var_13_16 = 0.001

			if var_13_13 <= arg_10_1.time_ and arg_10_1.time_ < var_13_13 + var_13_16 then
				local var_13_17 = (arg_10_1.time_ - var_13_13) / var_13_16
				local var_13_18 = Vector3.New(-390, -331.9, -324)

				var_13_12.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, var_13_18, var_13_17)
			end

			if arg_10_1.time_ >= var_13_13 + var_13_16 and arg_10_1.time_ < var_13_13 + var_13_16 + arg_13_0 then
				var_13_12.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_13_19 = 0
			local var_13_20 = 0.725

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_21 = arg_10_1:FormatText(StoryNameCfg[1109].name)

				arg_10_1.leftNameTxt_.text = var_13_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_22 = arg_10_1:GetWordFromCfg(417131002)
				local var_13_23 = arg_10_1:FormatText(var_13_22.content)

				arg_10_1.text_.text = var_13_23

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_24 = 29
				local var_13_25 = utf8.len(var_13_23)
				local var_13_26 = var_13_24 <= 0 and var_13_20 or var_13_20 * (var_13_25 / var_13_24)

				if var_13_26 > 0 and var_13_20 < var_13_26 then
					arg_10_1.talkMaxDuration = var_13_26

					if var_13_26 + var_13_19 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_26 + var_13_19
					end
				end

				arg_10_1.text_.text = var_13_23
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131002", "story_v_out_417131.awb") ~= 0 then
					local var_13_27 = manager.audio:GetVoiceLength("story_v_out_417131", "417131002", "story_v_out_417131.awb") / 1000

					if var_13_27 + var_13_19 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_27 + var_13_19
					end

					if var_13_22.prefab_name ~= "" and arg_10_1.actors_[var_13_22.prefab_name] ~= nil then
						local var_13_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_22.prefab_name].transform, "story_v_out_417131", "417131002", "story_v_out_417131.awb")

						arg_10_1:RecordAudio("417131002", var_13_28)
						arg_10_1:RecordAudio("417131002", var_13_28)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417131", "417131002", "story_v_out_417131.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417131", "417131002", "story_v_out_417131.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_29 = math.max(var_13_20, arg_10_1.talkMaxDuration)

			if var_13_19 <= arg_10_1.time_ and arg_10_1.time_ < var_13_19 + var_13_29 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_19) / var_13_29

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_19 + var_13_29 and arg_10_1.time_ < var_13_19 + var_13_29 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play417131003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417131003
		arg_14_1.duration_ = 10

		local var_14_0 = {
			zh = 10,
			ja = 8.433
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
				arg_14_0:Play417131004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "10115"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

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

			local var_17_4 = arg_14_1.actors_["10115"]
			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10115 == nil then
				arg_14_1.var_.actorSpriteComps10115 = var_17_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_6 = 0.2

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 and not isNil(var_17_4) then
				local var_17_7 = (arg_14_1.time_ - var_17_5) / var_17_6

				if arg_14_1.var_.actorSpriteComps10115 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								local var_17_8 = Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, var_17_7)
								local var_17_9 = Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, var_17_7)
								local var_17_10 = Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, var_17_7)

								iter_17_3.color = Color.New(var_17_8, var_17_9, var_17_10)
							else
								local var_17_11 = Mathf.Lerp(iter_17_3.color.r, 1, var_17_7)

								iter_17_3.color = Color.New(var_17_11, var_17_11, var_17_11)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10115 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_17_5 then
						if arg_14_1.isInRecall_ then
							iter_17_5.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps10115 = nil
			end

			local var_17_12 = arg_14_1.actors_["1034"]
			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_14 = 0.2

			if var_17_13 <= arg_14_1.time_ and arg_14_1.time_ < var_17_13 + var_17_14 and not isNil(var_17_12) then
				local var_17_15 = (arg_14_1.time_ - var_17_13) / var_17_14

				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_7 then
							if arg_14_1.isInRecall_ then
								local var_17_16 = Mathf.Lerp(iter_17_7.color.r, arg_14_1.hightColor2.r, var_17_15)
								local var_17_17 = Mathf.Lerp(iter_17_7.color.g, arg_14_1.hightColor2.g, var_17_15)
								local var_17_18 = Mathf.Lerp(iter_17_7.color.b, arg_14_1.hightColor2.b, var_17_15)

								iter_17_7.color = Color.New(var_17_16, var_17_17, var_17_18)
							else
								local var_17_19 = Mathf.Lerp(iter_17_7.color.r, 0.5, var_17_15)

								iter_17_7.color = Color.New(var_17_19, var_17_19, var_17_19)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_13 + var_17_14 and arg_14_1.time_ < var_17_13 + var_17_14 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_9 then
						if arg_14_1.isInRecall_ then
							iter_17_9.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_20 = arg_14_1.actors_["10115"].transform
			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1.var_.moveOldPos10115 = var_17_20.localPosition
				var_17_20.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10115", 4)

				local var_17_22 = var_17_20.childCount

				for iter_17_10 = 0, var_17_22 - 1 do
					local var_17_23 = var_17_20:GetChild(iter_17_10)

					if var_17_23.name == "" or not string.find(var_17_23.name, "split") then
						var_17_23.gameObject:SetActive(true)
					else
						var_17_23.gameObject:SetActive(false)
					end
				end
			end

			local var_17_24 = 0.001

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_24 then
				local var_17_25 = (arg_14_1.time_ - var_17_21) / var_17_24
				local var_17_26 = Vector3.New(390, -387.3, -246.2)

				var_17_20.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10115, var_17_26, var_17_25)
			end

			if arg_14_1.time_ >= var_17_21 + var_17_24 and arg_14_1.time_ < var_17_21 + var_17_24 + arg_17_0 then
				var_17_20.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_17_27 = 0
			local var_17_28 = 1.15

			if var_17_27 < arg_14_1.time_ and arg_14_1.time_ <= var_17_27 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_29 = arg_14_1:FormatText(StoryNameCfg[1113].name)

				arg_14_1.leftNameTxt_.text = var_17_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_30 = arg_14_1:GetWordFromCfg(417131003)
				local var_17_31 = arg_14_1:FormatText(var_17_30.content)

				arg_14_1.text_.text = var_17_31

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_32 = 46
				local var_17_33 = utf8.len(var_17_31)
				local var_17_34 = var_17_32 <= 0 and var_17_28 or var_17_28 * (var_17_33 / var_17_32)

				if var_17_34 > 0 and var_17_28 < var_17_34 then
					arg_14_1.talkMaxDuration = var_17_34

					if var_17_34 + var_17_27 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_34 + var_17_27
					end
				end

				arg_14_1.text_.text = var_17_31
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131003", "story_v_out_417131.awb") ~= 0 then
					local var_17_35 = manager.audio:GetVoiceLength("story_v_out_417131", "417131003", "story_v_out_417131.awb") / 1000

					if var_17_35 + var_17_27 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_35 + var_17_27
					end

					if var_17_30.prefab_name ~= "" and arg_14_1.actors_[var_17_30.prefab_name] ~= nil then
						local var_17_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_30.prefab_name].transform, "story_v_out_417131", "417131003", "story_v_out_417131.awb")

						arg_14_1:RecordAudio("417131003", var_17_36)
						arg_14_1:RecordAudio("417131003", var_17_36)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417131", "417131003", "story_v_out_417131.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417131", "417131003", "story_v_out_417131.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_37 = math.max(var_17_28, arg_14_1.talkMaxDuration)

			if var_17_27 <= arg_14_1.time_ and arg_14_1.time_ < var_17_27 + var_17_37 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_27) / var_17_37

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_27 + var_17_37 and arg_14_1.time_ < var_17_27 + var_17_37 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417131004
		arg_18_1.duration_ = 8.1

		local var_18_0 = {
			zh = 5.5,
			ja = 8.1
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417131005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.625

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[1113].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(417131004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 25
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131004", "story_v_out_417131.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131004", "story_v_out_417131.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417131", "417131004", "story_v_out_417131.awb")

						arg_18_1:RecordAudio("417131004", var_21_9)
						arg_18_1:RecordAudio("417131004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417131", "417131004", "story_v_out_417131.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417131", "417131004", "story_v_out_417131.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417131005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417131005
		arg_22_1.duration_ = 7.27

		local var_22_0 = {
			zh = 2.566,
			ja = 7.266
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
				arg_22_0:Play417131006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1034"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_8 = arg_22_1.actors_["10115"]
			local var_25_9 = 0

			if var_25_9 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 and not isNil(var_25_8) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = var_25_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_10 = 0.2

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_10 and not isNil(var_25_8) then
				local var_25_11 = (arg_22_1.time_ - var_25_9) / var_25_10

				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_25_5 then
							if arg_22_1.isInRecall_ then
								local var_25_12 = Mathf.Lerp(iter_25_5.color.r, arg_22_1.hightColor2.r, var_25_11)
								local var_25_13 = Mathf.Lerp(iter_25_5.color.g, arg_22_1.hightColor2.g, var_25_11)
								local var_25_14 = Mathf.Lerp(iter_25_5.color.b, arg_22_1.hightColor2.b, var_25_11)

								iter_25_5.color = Color.New(var_25_12, var_25_13, var_25_14)
							else
								local var_25_15 = Mathf.Lerp(iter_25_5.color.r, 0.5, var_25_11)

								iter_25_5.color = Color.New(var_25_15, var_25_15, var_25_15)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_9 + var_25_10 and arg_22_1.time_ < var_25_9 + var_25_10 + arg_25_0 and not isNil(var_25_8) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_6, iter_25_7 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_7 then
						if arg_22_1.isInRecall_ then
							iter_25_7.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_16 = 0
			local var_25_17 = 0.375

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_18 = arg_22_1:FormatText(StoryNameCfg[1109].name)

				arg_22_1.leftNameTxt_.text = var_25_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_19 = arg_22_1:GetWordFromCfg(417131005)
				local var_25_20 = arg_22_1:FormatText(var_25_19.content)

				arg_22_1.text_.text = var_25_20

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_21 = 15
				local var_25_22 = utf8.len(var_25_20)
				local var_25_23 = var_25_21 <= 0 and var_25_17 or var_25_17 * (var_25_22 / var_25_21)

				if var_25_23 > 0 and var_25_17 < var_25_23 then
					arg_22_1.talkMaxDuration = var_25_23

					if var_25_23 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_23 + var_25_16
					end
				end

				arg_22_1.text_.text = var_25_20
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131005", "story_v_out_417131.awb") ~= 0 then
					local var_25_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131005", "story_v_out_417131.awb") / 1000

					if var_25_24 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_24 + var_25_16
					end

					if var_25_19.prefab_name ~= "" and arg_22_1.actors_[var_25_19.prefab_name] ~= nil then
						local var_25_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_19.prefab_name].transform, "story_v_out_417131", "417131005", "story_v_out_417131.awb")

						arg_22_1:RecordAudio("417131005", var_25_25)
						arg_22_1:RecordAudio("417131005", var_25_25)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417131", "417131005", "story_v_out_417131.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417131", "417131005", "story_v_out_417131.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_26 = math.max(var_25_17, arg_22_1.talkMaxDuration)

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_26 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_16) / var_25_26

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_16 + var_25_26 and arg_22_1.time_ < var_25_16 + var_25_26 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417131006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417131006
		arg_26_1.duration_ = 6.53

		local var_26_0 = {
			zh = 2.066,
			ja = 6.533
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
				arg_26_0:Play417131007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10115"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps10115 == nil then
				arg_26_1.var_.actorSpriteComps10115 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps10115 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								local var_29_4 = Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, var_29_3)
								local var_29_5 = Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, var_29_3)
								local var_29_6 = Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, var_29_3)

								iter_29_1.color = Color.New(var_29_4, var_29_5, var_29_6)
							else
								local var_29_7 = Mathf.Lerp(iter_29_1.color.r, 1, var_29_3)

								iter_29_1.color = Color.New(var_29_7, var_29_7, var_29_7)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps10115 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps10115 = nil
			end

			local var_29_8 = arg_26_1.actors_["1034"]
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1034 == nil then
				arg_26_1.var_.actorSpriteComps1034 = var_29_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_10 = 0.2

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_10 and not isNil(var_29_8) then
				local var_29_11 = (arg_26_1.time_ - var_29_9) / var_29_10

				if arg_26_1.var_.actorSpriteComps1034 then
					for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_29_5 then
							if arg_26_1.isInRecall_ then
								local var_29_12 = Mathf.Lerp(iter_29_5.color.r, arg_26_1.hightColor2.r, var_29_11)
								local var_29_13 = Mathf.Lerp(iter_29_5.color.g, arg_26_1.hightColor2.g, var_29_11)
								local var_29_14 = Mathf.Lerp(iter_29_5.color.b, arg_26_1.hightColor2.b, var_29_11)

								iter_29_5.color = Color.New(var_29_12, var_29_13, var_29_14)
							else
								local var_29_15 = Mathf.Lerp(iter_29_5.color.r, 0.5, var_29_11)

								iter_29_5.color = Color.New(var_29_15, var_29_15, var_29_15)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_9 + var_29_10 and arg_26_1.time_ < var_29_9 + var_29_10 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1034 then
				for iter_29_6, iter_29_7 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_29_7 then
						if arg_26_1.isInRecall_ then
							iter_29_7.color = arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_29_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1034 = nil
			end

			local var_29_16 = arg_26_1.actors_["10115"].transform
			local var_29_17 = 0

			if var_29_17 < arg_26_1.time_ and arg_26_1.time_ <= var_29_17 + arg_29_0 then
				arg_26_1.var_.moveOldPos10115 = var_29_16.localPosition
				var_29_16.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10115", 4)

				local var_29_18 = var_29_16.childCount

				for iter_29_8 = 0, var_29_18 - 1 do
					local var_29_19 = var_29_16:GetChild(iter_29_8)

					if var_29_19.name == "split_4" or not string.find(var_29_19.name, "split") then
						var_29_19.gameObject:SetActive(true)
					else
						var_29_19.gameObject:SetActive(false)
					end
				end
			end

			local var_29_20 = 0.001

			if var_29_17 <= arg_26_1.time_ and arg_26_1.time_ < var_29_17 + var_29_20 then
				local var_29_21 = (arg_26_1.time_ - var_29_17) / var_29_20
				local var_29_22 = Vector3.New(390, -387.3, -246.2)

				var_29_16.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10115, var_29_22, var_29_21)
			end

			if arg_26_1.time_ >= var_29_17 + var_29_20 and arg_26_1.time_ < var_29_17 + var_29_20 + arg_29_0 then
				var_29_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_29_23 = 0
			local var_29_24 = 0.25

			if var_29_23 < arg_26_1.time_ and arg_26_1.time_ <= var_29_23 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_25 = arg_26_1:FormatText(StoryNameCfg[1113].name)

				arg_26_1.leftNameTxt_.text = var_29_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_26 = arg_26_1:GetWordFromCfg(417131006)
				local var_29_27 = arg_26_1:FormatText(var_29_26.content)

				arg_26_1.text_.text = var_29_27

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_28 = 10
				local var_29_29 = utf8.len(var_29_27)
				local var_29_30 = var_29_28 <= 0 and var_29_24 or var_29_24 * (var_29_29 / var_29_28)

				if var_29_30 > 0 and var_29_24 < var_29_30 then
					arg_26_1.talkMaxDuration = var_29_30

					if var_29_30 + var_29_23 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_30 + var_29_23
					end
				end

				arg_26_1.text_.text = var_29_27
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131006", "story_v_out_417131.awb") ~= 0 then
					local var_29_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131006", "story_v_out_417131.awb") / 1000

					if var_29_31 + var_29_23 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_31 + var_29_23
					end

					if var_29_26.prefab_name ~= "" and arg_26_1.actors_[var_29_26.prefab_name] ~= nil then
						local var_29_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_26.prefab_name].transform, "story_v_out_417131", "417131006", "story_v_out_417131.awb")

						arg_26_1:RecordAudio("417131006", var_29_32)
						arg_26_1:RecordAudio("417131006", var_29_32)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417131", "417131006", "story_v_out_417131.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417131", "417131006", "story_v_out_417131.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_33 = math.max(var_29_24, arg_26_1.talkMaxDuration)

			if var_29_23 <= arg_26_1.time_ and arg_26_1.time_ < var_29_23 + var_29_33 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_23) / var_29_33

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_23 + var_29_33 and arg_26_1.time_ < var_29_23 + var_29_33 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play417131007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417131007
		arg_30_1.duration_ = 5.9

		local var_30_0 = {
			zh = 4.266,
			ja = 5.9
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
				arg_30_0:Play417131008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1034"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 1, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_8 = arg_30_1.actors_["10115"]
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps10115 == nil then
				arg_30_1.var_.actorSpriteComps10115 = var_33_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_10 = 0.2

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_10 and not isNil(var_33_8) then
				local var_33_11 = (arg_30_1.time_ - var_33_9) / var_33_10

				if arg_30_1.var_.actorSpriteComps10115 then
					for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_33_5 then
							if arg_30_1.isInRecall_ then
								local var_33_12 = Mathf.Lerp(iter_33_5.color.r, arg_30_1.hightColor2.r, var_33_11)
								local var_33_13 = Mathf.Lerp(iter_33_5.color.g, arg_30_1.hightColor2.g, var_33_11)
								local var_33_14 = Mathf.Lerp(iter_33_5.color.b, arg_30_1.hightColor2.b, var_33_11)

								iter_33_5.color = Color.New(var_33_12, var_33_13, var_33_14)
							else
								local var_33_15 = Mathf.Lerp(iter_33_5.color.r, 0.5, var_33_11)

								iter_33_5.color = Color.New(var_33_15, var_33_15, var_33_15)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_9 + var_33_10 and arg_30_1.time_ < var_33_9 + var_33_10 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps10115 then
				for iter_33_6, iter_33_7 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_33_7 then
						if arg_30_1.isInRecall_ then
							iter_33_7.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps10115 = nil
			end

			local var_33_16 = arg_30_1.actors_["1034"].transform
			local var_33_17 = 0

			if var_33_17 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_16.localPosition
				var_33_16.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 2)

				local var_33_18 = var_33_16.childCount

				for iter_33_8 = 0, var_33_18 - 1 do
					local var_33_19 = var_33_16:GetChild(iter_33_8)

					if var_33_19.name == "split_3" or not string.find(var_33_19.name, "split") then
						var_33_19.gameObject:SetActive(true)
					else
						var_33_19.gameObject:SetActive(false)
					end
				end
			end

			local var_33_20 = 0.001

			if var_33_17 <= arg_30_1.time_ and arg_30_1.time_ < var_33_17 + var_33_20 then
				local var_33_21 = (arg_30_1.time_ - var_33_17) / var_33_20
				local var_33_22 = Vector3.New(-390, -331.9, -324)

				var_33_16.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, var_33_22, var_33_21)
			end

			if arg_30_1.time_ >= var_33_17 + var_33_20 and arg_30_1.time_ < var_33_17 + var_33_20 + arg_33_0 then
				var_33_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_33_23 = 0
			local var_33_24 = 0.575

			if var_33_23 < arg_30_1.time_ and arg_30_1.time_ <= var_33_23 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_25 = arg_30_1:FormatText(StoryNameCfg[1109].name)

				arg_30_1.leftNameTxt_.text = var_33_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_26 = arg_30_1:GetWordFromCfg(417131007)
				local var_33_27 = arg_30_1:FormatText(var_33_26.content)

				arg_30_1.text_.text = var_33_27

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_28 = 23
				local var_33_29 = utf8.len(var_33_27)
				local var_33_30 = var_33_28 <= 0 and var_33_24 or var_33_24 * (var_33_29 / var_33_28)

				if var_33_30 > 0 and var_33_24 < var_33_30 then
					arg_30_1.talkMaxDuration = var_33_30

					if var_33_30 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_30 + var_33_23
					end
				end

				arg_30_1.text_.text = var_33_27
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131007", "story_v_out_417131.awb") ~= 0 then
					local var_33_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131007", "story_v_out_417131.awb") / 1000

					if var_33_31 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_31 + var_33_23
					end

					if var_33_26.prefab_name ~= "" and arg_30_1.actors_[var_33_26.prefab_name] ~= nil then
						local var_33_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_26.prefab_name].transform, "story_v_out_417131", "417131007", "story_v_out_417131.awb")

						arg_30_1:RecordAudio("417131007", var_33_32)
						arg_30_1:RecordAudio("417131007", var_33_32)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417131", "417131007", "story_v_out_417131.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417131", "417131007", "story_v_out_417131.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_33 = math.max(var_33_24, arg_30_1.talkMaxDuration)

			if var_33_23 <= arg_30_1.time_ and arg_30_1.time_ < var_33_23 + var_33_33 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_23) / var_33_33

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_23 + var_33_33 and arg_30_1.time_ < var_33_23 + var_33_33 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play417131008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417131008
		arg_34_1.duration_ = 9.37

		local var_34_0 = {
			zh = 9.2,
			ja = 9.366
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
				arg_34_0:Play417131009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.95

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[1109].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:GetWordFromCfg(417131008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 38
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131008", "story_v_out_417131.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131008", "story_v_out_417131.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_417131", "417131008", "story_v_out_417131.awb")

						arg_34_1:RecordAudio("417131008", var_37_9)
						arg_34_1:RecordAudio("417131008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417131", "417131008", "story_v_out_417131.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417131", "417131008", "story_v_out_417131.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417131009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417131009
		arg_38_1.duration_ = 9.93

		local var_38_0 = {
			zh = 4.1,
			ja = 9.933
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
				arg_38_0:Play417131010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10115"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10115 == nil then
				arg_38_1.var_.actorSpriteComps10115 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps10115 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 1, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10115 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10115 = nil
			end

			local var_41_8 = arg_38_1.actors_["1034"]
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_10 = 0.2

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_10 and not isNil(var_41_8) then
				local var_41_11 = (arg_38_1.time_ - var_41_9) / var_41_10

				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								local var_41_12 = Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, var_41_11)
								local var_41_13 = Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, var_41_11)
								local var_41_14 = Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, var_41_11)

								iter_41_5.color = Color.New(var_41_12, var_41_13, var_41_14)
							else
								local var_41_15 = Mathf.Lerp(iter_41_5.color.r, 0.5, var_41_11)

								iter_41_5.color = Color.New(var_41_15, var_41_15, var_41_15)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_9 + var_41_10 and arg_38_1.time_ < var_41_9 + var_41_10 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_7 then
						if arg_38_1.isInRecall_ then
							iter_41_7.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_16 = arg_38_1.actors_["10115"].transform
			local var_41_17 = 0

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 then
				arg_38_1.var_.moveOldPos10115 = var_41_16.localPosition
				var_41_16.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10115", 4)

				local var_41_18 = var_41_16.childCount

				for iter_41_8 = 0, var_41_18 - 1 do
					local var_41_19 = var_41_16:GetChild(iter_41_8)

					if var_41_19.name == "split_6" or not string.find(var_41_19.name, "split") then
						var_41_19.gameObject:SetActive(true)
					else
						var_41_19.gameObject:SetActive(false)
					end
				end
			end

			local var_41_20 = 0.001

			if var_41_17 <= arg_38_1.time_ and arg_38_1.time_ < var_41_17 + var_41_20 then
				local var_41_21 = (arg_38_1.time_ - var_41_17) / var_41_20
				local var_41_22 = Vector3.New(390, -387.3, -246.2)

				var_41_16.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10115, var_41_22, var_41_21)
			end

			if arg_38_1.time_ >= var_41_17 + var_41_20 and arg_38_1.time_ < var_41_17 + var_41_20 + arg_41_0 then
				var_41_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_41_23 = 0
			local var_41_24 = 0.475

			if var_41_23 < arg_38_1.time_ and arg_38_1.time_ <= var_41_23 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_25 = arg_38_1:FormatText(StoryNameCfg[1113].name)

				arg_38_1.leftNameTxt_.text = var_41_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_26 = arg_38_1:GetWordFromCfg(417131009)
				local var_41_27 = arg_38_1:FormatText(var_41_26.content)

				arg_38_1.text_.text = var_41_27

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_28 = 19
				local var_41_29 = utf8.len(var_41_27)
				local var_41_30 = var_41_28 <= 0 and var_41_24 or var_41_24 * (var_41_29 / var_41_28)

				if var_41_30 > 0 and var_41_24 < var_41_30 then
					arg_38_1.talkMaxDuration = var_41_30

					if var_41_30 + var_41_23 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_30 + var_41_23
					end
				end

				arg_38_1.text_.text = var_41_27
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131009", "story_v_out_417131.awb") ~= 0 then
					local var_41_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131009", "story_v_out_417131.awb") / 1000

					if var_41_31 + var_41_23 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_31 + var_41_23
					end

					if var_41_26.prefab_name ~= "" and arg_38_1.actors_[var_41_26.prefab_name] ~= nil then
						local var_41_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_26.prefab_name].transform, "story_v_out_417131", "417131009", "story_v_out_417131.awb")

						arg_38_1:RecordAudio("417131009", var_41_32)
						arg_38_1:RecordAudio("417131009", var_41_32)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417131", "417131009", "story_v_out_417131.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417131", "417131009", "story_v_out_417131.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_33 = math.max(var_41_24, arg_38_1.talkMaxDuration)

			if var_41_23 <= arg_38_1.time_ and arg_38_1.time_ < var_41_23 + var_41_33 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_23) / var_41_33

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_23 + var_41_33 and arg_38_1.time_ < var_41_23 + var_41_33 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417131010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417131010
		arg_42_1.duration_ = 3.13

		local var_42_0 = {
			zh = 3.133,
			ja = 2.8
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
				arg_42_0:Play417131011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1034"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 1, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_8 = arg_42_1.actors_["10115"]
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps10115 == nil then
				arg_42_1.var_.actorSpriteComps10115 = var_45_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_10 = 0.2

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_10 and not isNil(var_45_8) then
				local var_45_11 = (arg_42_1.time_ - var_45_9) / var_45_10

				if arg_42_1.var_.actorSpriteComps10115 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								local var_45_12 = Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, var_45_11)
								local var_45_13 = Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, var_45_11)
								local var_45_14 = Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, var_45_11)

								iter_45_5.color = Color.New(var_45_12, var_45_13, var_45_14)
							else
								local var_45_15 = Mathf.Lerp(iter_45_5.color.r, 0.5, var_45_11)

								iter_45_5.color = Color.New(var_45_15, var_45_15, var_45_15)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_9 + var_45_10 and arg_42_1.time_ < var_45_9 + var_45_10 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps10115 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_45_7 then
						if arg_42_1.isInRecall_ then
							iter_45_7.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10115 = nil
			end

			local var_45_16 = arg_42_1.actors_["1034"].transform
			local var_45_17 = 0

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = var_45_16.localPosition
				var_45_16.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 2)

				local var_45_18 = var_45_16.childCount

				for iter_45_8 = 0, var_45_18 - 1 do
					local var_45_19 = var_45_16:GetChild(iter_45_8)

					if var_45_19.name == "split_6" or not string.find(var_45_19.name, "split") then
						var_45_19.gameObject:SetActive(true)
					else
						var_45_19.gameObject:SetActive(false)
					end
				end
			end

			local var_45_20 = 0.001

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_20 then
				local var_45_21 = (arg_42_1.time_ - var_45_17) / var_45_20
				local var_45_22 = Vector3.New(-390, -331.9, -324)

				var_45_16.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, var_45_22, var_45_21)
			end

			if arg_42_1.time_ >= var_45_17 + var_45_20 and arg_42_1.time_ < var_45_17 + var_45_20 + arg_45_0 then
				var_45_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_45_23 = 0
			local var_45_24 = 0.2

			if var_45_23 < arg_42_1.time_ and arg_42_1.time_ <= var_45_23 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_25 = arg_42_1:FormatText(StoryNameCfg[1109].name)

				arg_42_1.leftNameTxt_.text = var_45_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_26 = arg_42_1:GetWordFromCfg(417131010)
				local var_45_27 = arg_42_1:FormatText(var_45_26.content)

				arg_42_1.text_.text = var_45_27

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_28 = 8
				local var_45_29 = utf8.len(var_45_27)
				local var_45_30 = var_45_28 <= 0 and var_45_24 or var_45_24 * (var_45_29 / var_45_28)

				if var_45_30 > 0 and var_45_24 < var_45_30 then
					arg_42_1.talkMaxDuration = var_45_30

					if var_45_30 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_30 + var_45_23
					end
				end

				arg_42_1.text_.text = var_45_27
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131010", "story_v_out_417131.awb") ~= 0 then
					local var_45_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131010", "story_v_out_417131.awb") / 1000

					if var_45_31 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_31 + var_45_23
					end

					if var_45_26.prefab_name ~= "" and arg_42_1.actors_[var_45_26.prefab_name] ~= nil then
						local var_45_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_26.prefab_name].transform, "story_v_out_417131", "417131010", "story_v_out_417131.awb")

						arg_42_1:RecordAudio("417131010", var_45_32)
						arg_42_1:RecordAudio("417131010", var_45_32)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417131", "417131010", "story_v_out_417131.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417131", "417131010", "story_v_out_417131.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_33 = math.max(var_45_24, arg_42_1.talkMaxDuration)

			if var_45_23 <= arg_42_1.time_ and arg_42_1.time_ < var_45_23 + var_45_33 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_23) / var_45_33

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_23 + var_45_33 and arg_42_1.time_ < var_45_23 + var_45_33 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play417131011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417131011
		arg_46_1.duration_ = 6.27

		local var_46_0 = {
			zh = 5.066,
			ja = 6.266
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
				arg_46_0:Play417131012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.625

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[1109].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(417131011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131011", "story_v_out_417131.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131011", "story_v_out_417131.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_417131", "417131011", "story_v_out_417131.awb")

						arg_46_1:RecordAudio("417131011", var_49_9)
						arg_46_1:RecordAudio("417131011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417131", "417131011", "story_v_out_417131.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417131", "417131011", "story_v_out_417131.awb")
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
	Play417131012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417131012
		arg_50_1.duration_ = 6.43

		local var_50_0 = {
			zh = 6,
			ja = 6.433
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
				arg_50_0:Play417131013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10115"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10115 == nil then
				arg_50_1.var_.actorSpriteComps10115 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps10115 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10115 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10115 = nil
			end

			local var_53_8 = arg_50_1.actors_["1034"]
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps1034 == nil then
				arg_50_1.var_.actorSpriteComps1034 = var_53_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_10 = 0.2

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_10 and not isNil(var_53_8) then
				local var_53_11 = (arg_50_1.time_ - var_53_9) / var_53_10

				if arg_50_1.var_.actorSpriteComps1034 then
					for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_53_5 then
							if arg_50_1.isInRecall_ then
								local var_53_12 = Mathf.Lerp(iter_53_5.color.r, arg_50_1.hightColor2.r, var_53_11)
								local var_53_13 = Mathf.Lerp(iter_53_5.color.g, arg_50_1.hightColor2.g, var_53_11)
								local var_53_14 = Mathf.Lerp(iter_53_5.color.b, arg_50_1.hightColor2.b, var_53_11)

								iter_53_5.color = Color.New(var_53_12, var_53_13, var_53_14)
							else
								local var_53_15 = Mathf.Lerp(iter_53_5.color.r, 0.5, var_53_11)

								iter_53_5.color = Color.New(var_53_15, var_53_15, var_53_15)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_9 + var_53_10 and arg_50_1.time_ < var_53_9 + var_53_10 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps1034 then
				for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_53_7 then
						if arg_50_1.isInRecall_ then
							iter_53_7.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps1034 = nil
			end

			local var_53_16 = 0
			local var_53_17 = 0.65

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_18 = arg_50_1:FormatText(StoryNameCfg[1113].name)

				arg_50_1.leftNameTxt_.text = var_53_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_19 = arg_50_1:GetWordFromCfg(417131012)
				local var_53_20 = arg_50_1:FormatText(var_53_19.content)

				arg_50_1.text_.text = var_53_20

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_21 = 26
				local var_53_22 = utf8.len(var_53_20)
				local var_53_23 = var_53_21 <= 0 and var_53_17 or var_53_17 * (var_53_22 / var_53_21)

				if var_53_23 > 0 and var_53_17 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23

					if var_53_23 + var_53_16 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_16
					end
				end

				arg_50_1.text_.text = var_53_20
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131012", "story_v_out_417131.awb") ~= 0 then
					local var_53_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131012", "story_v_out_417131.awb") / 1000

					if var_53_24 + var_53_16 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_16
					end

					if var_53_19.prefab_name ~= "" and arg_50_1.actors_[var_53_19.prefab_name] ~= nil then
						local var_53_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_19.prefab_name].transform, "story_v_out_417131", "417131012", "story_v_out_417131.awb")

						arg_50_1:RecordAudio("417131012", var_53_25)
						arg_50_1:RecordAudio("417131012", var_53_25)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417131", "417131012", "story_v_out_417131.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417131", "417131012", "story_v_out_417131.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_26 = math.max(var_53_17, arg_50_1.talkMaxDuration)

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_26 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_16) / var_53_26

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_16 + var_53_26 and arg_50_1.time_ < var_53_16 + var_53_26 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417131013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417131013
		arg_54_1.duration_ = 6.63

		local var_54_0 = {
			zh = 4.533,
			ja = 6.633
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
				arg_54_0:Play417131014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1034"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								local var_57_4 = Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, var_57_3)
								local var_57_5 = Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, var_57_3)
								local var_57_6 = Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, var_57_3)

								iter_57_1.color = Color.New(var_57_4, var_57_5, var_57_6)
							else
								local var_57_7 = Mathf.Lerp(iter_57_1.color.r, 1, var_57_3)

								iter_57_1.color = Color.New(var_57_7, var_57_7, var_57_7)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_8 = arg_54_1.actors_["10115"]
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10115 == nil then
				arg_54_1.var_.actorSpriteComps10115 = var_57_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_10 = 0.2

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_10 and not isNil(var_57_8) then
				local var_57_11 = (arg_54_1.time_ - var_57_9) / var_57_10

				if arg_54_1.var_.actorSpriteComps10115 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_57_5 then
							if arg_54_1.isInRecall_ then
								local var_57_12 = Mathf.Lerp(iter_57_5.color.r, arg_54_1.hightColor2.r, var_57_11)
								local var_57_13 = Mathf.Lerp(iter_57_5.color.g, arg_54_1.hightColor2.g, var_57_11)
								local var_57_14 = Mathf.Lerp(iter_57_5.color.b, arg_54_1.hightColor2.b, var_57_11)

								iter_57_5.color = Color.New(var_57_12, var_57_13, var_57_14)
							else
								local var_57_15 = Mathf.Lerp(iter_57_5.color.r, 0.5, var_57_11)

								iter_57_5.color = Color.New(var_57_15, var_57_15, var_57_15)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_9 + var_57_10 and arg_54_1.time_ < var_57_9 + var_57_10 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10115 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_57_7 then
						if arg_54_1.isInRecall_ then
							iter_57_7.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10115 = nil
			end

			local var_57_16 = 0
			local var_57_17 = 0.55

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_18 = arg_54_1:FormatText(StoryNameCfg[1109].name)

				arg_54_1.leftNameTxt_.text = var_57_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_19 = arg_54_1:GetWordFromCfg(417131013)
				local var_57_20 = arg_54_1:FormatText(var_57_19.content)

				arg_54_1.text_.text = var_57_20

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_21 = 22
				local var_57_22 = utf8.len(var_57_20)
				local var_57_23 = var_57_21 <= 0 and var_57_17 or var_57_17 * (var_57_22 / var_57_21)

				if var_57_23 > 0 and var_57_17 < var_57_23 then
					arg_54_1.talkMaxDuration = var_57_23

					if var_57_23 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_16
					end
				end

				arg_54_1.text_.text = var_57_20
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131013", "story_v_out_417131.awb") ~= 0 then
					local var_57_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131013", "story_v_out_417131.awb") / 1000

					if var_57_24 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_24 + var_57_16
					end

					if var_57_19.prefab_name ~= "" and arg_54_1.actors_[var_57_19.prefab_name] ~= nil then
						local var_57_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_19.prefab_name].transform, "story_v_out_417131", "417131013", "story_v_out_417131.awb")

						arg_54_1:RecordAudio("417131013", var_57_25)
						arg_54_1:RecordAudio("417131013", var_57_25)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417131", "417131013", "story_v_out_417131.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417131", "417131013", "story_v_out_417131.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_26 = math.max(var_57_17, arg_54_1.talkMaxDuration)

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_26 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_16) / var_57_26

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_16 + var_57_26 and arg_54_1.time_ < var_57_16 + var_57_26 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417131014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417131014
		arg_58_1.duration_ = 12.1

		local var_58_0 = {
			zh = 9.9,
			ja = 12.1
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
				arg_58_0:Play417131015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10115"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10115 == nil then
				arg_58_1.var_.actorSpriteComps10115 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps10115 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 1, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10115 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10115 = nil
			end

			local var_61_8 = arg_58_1.actors_["1034"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								local var_61_12 = Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, var_61_11)
								local var_61_13 = Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, var_61_11)
								local var_61_14 = Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, var_61_11)

								iter_61_5.color = Color.New(var_61_12, var_61_13, var_61_14)
							else
								local var_61_15 = Mathf.Lerp(iter_61_5.color.r, 0.5, var_61_11)

								iter_61_5.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_16 = arg_58_1.actors_["10115"].transform
			local var_61_17 = 0

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 then
				arg_58_1.var_.moveOldPos10115 = var_61_16.localPosition
				var_61_16.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10115", 4)

				local var_61_18 = var_61_16.childCount

				for iter_61_8 = 0, var_61_18 - 1 do
					local var_61_19 = var_61_16:GetChild(iter_61_8)

					if var_61_19.name == "split_4" or not string.find(var_61_19.name, "split") then
						var_61_19.gameObject:SetActive(true)
					else
						var_61_19.gameObject:SetActive(false)
					end
				end
			end

			local var_61_20 = 0.001

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_20 then
				local var_61_21 = (arg_58_1.time_ - var_61_17) / var_61_20
				local var_61_22 = Vector3.New(390, -387.3, -246.2)

				var_61_16.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10115, var_61_22, var_61_21)
			end

			if arg_58_1.time_ >= var_61_17 + var_61_20 and arg_58_1.time_ < var_61_17 + var_61_20 + arg_61_0 then
				var_61_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_61_23 = 0
			local var_61_24 = 1.2

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_25 = arg_58_1:FormatText(StoryNameCfg[1113].name)

				arg_58_1.leftNameTxt_.text = var_61_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_26 = arg_58_1:GetWordFromCfg(417131014)
				local var_61_27 = arg_58_1:FormatText(var_61_26.content)

				arg_58_1.text_.text = var_61_27

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_28 = 48
				local var_61_29 = utf8.len(var_61_27)
				local var_61_30 = var_61_28 <= 0 and var_61_24 or var_61_24 * (var_61_29 / var_61_28)

				if var_61_30 > 0 and var_61_24 < var_61_30 then
					arg_58_1.talkMaxDuration = var_61_30

					if var_61_30 + var_61_23 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_30 + var_61_23
					end
				end

				arg_58_1.text_.text = var_61_27
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131014", "story_v_out_417131.awb") ~= 0 then
					local var_61_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131014", "story_v_out_417131.awb") / 1000

					if var_61_31 + var_61_23 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_31 + var_61_23
					end

					if var_61_26.prefab_name ~= "" and arg_58_1.actors_[var_61_26.prefab_name] ~= nil then
						local var_61_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_26.prefab_name].transform, "story_v_out_417131", "417131014", "story_v_out_417131.awb")

						arg_58_1:RecordAudio("417131014", var_61_32)
						arg_58_1:RecordAudio("417131014", var_61_32)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417131", "417131014", "story_v_out_417131.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417131", "417131014", "story_v_out_417131.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_33 = math.max(var_61_24, arg_58_1.talkMaxDuration)

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_33 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_23) / var_61_33

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_23 + var_61_33 and arg_58_1.time_ < var_61_23 + var_61_33 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play417131015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417131015
		arg_62_1.duration_ = 10.8

		local var_62_0 = {
			zh = 10.433,
			ja = 10.8
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play417131016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10115"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos10115 = var_65_0.localPosition
				var_65_0.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10115", 4)

				local var_65_2 = var_65_0.childCount

				for iter_65_0 = 0, var_65_2 - 1 do
					local var_65_3 = var_65_0:GetChild(iter_65_0)

					if var_65_3.name == "split_6" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_4 then
				local var_65_5 = (arg_62_1.time_ - var_65_1) / var_65_4
				local var_65_6 = Vector3.New(390, -387.3, -246.2)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10115, var_65_6, var_65_5)
			end

			if arg_62_1.time_ >= var_65_1 + var_65_4 and arg_62_1.time_ < var_65_1 + var_65_4 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_65_7 = 0
			local var_65_8 = 1.325

			if var_65_7 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_9 = arg_62_1:FormatText(StoryNameCfg[1113].name)

				arg_62_1.leftNameTxt_.text = var_65_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(417131015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_12 = 53
				local var_65_13 = utf8.len(var_65_11)
				local var_65_14 = var_65_12 <= 0 and var_65_8 or var_65_8 * (var_65_13 / var_65_12)

				if var_65_14 > 0 and var_65_8 < var_65_14 then
					arg_62_1.talkMaxDuration = var_65_14

					if var_65_14 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_7
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131015", "story_v_out_417131.awb") ~= 0 then
					local var_65_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131015", "story_v_out_417131.awb") / 1000

					if var_65_15 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_15 + var_65_7
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_417131", "417131015", "story_v_out_417131.awb")

						arg_62_1:RecordAudio("417131015", var_65_16)
						arg_62_1:RecordAudio("417131015", var_65_16)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417131", "417131015", "story_v_out_417131.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417131", "417131015", "story_v_out_417131.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_17 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_17 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_17

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_17 and arg_62_1.time_ < var_65_7 + var_65_17 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play417131016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417131016
		arg_66_1.duration_ = 8.8

		local var_66_0 = {
			zh = 8.8,
			ja = 8.533
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417131017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.1

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1113].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(417131016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 44
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131016", "story_v_out_417131.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131016", "story_v_out_417131.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_417131", "417131016", "story_v_out_417131.awb")

						arg_66_1:RecordAudio("417131016", var_69_9)
						arg_66_1:RecordAudio("417131016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417131", "417131016", "story_v_out_417131.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417131", "417131016", "story_v_out_417131.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417131017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417131017
		arg_70_1.duration_ = 5.1

		local var_70_0 = {
			zh = 4.3,
			ja = 5.1
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417131018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1034"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			local var_73_8 = arg_70_1.actors_["10115"]
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10115 == nil then
				arg_70_1.var_.actorSpriteComps10115 = var_73_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_10 = 0.2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 and not isNil(var_73_8) then
				local var_73_11 = (arg_70_1.time_ - var_73_9) / var_73_10

				if arg_70_1.var_.actorSpriteComps10115 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_12 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, var_73_11)
								local var_73_13 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, var_73_11)
								local var_73_14 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, var_73_11)

								iter_73_5.color = Color.New(var_73_12, var_73_13, var_73_14)
							else
								local var_73_15 = Mathf.Lerp(iter_73_5.color.r, 0.5, var_73_11)

								iter_73_5.color = Color.New(var_73_15, var_73_15, var_73_15)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10115 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10115 = nil
			end

			local var_73_16 = arg_70_1.actors_["1034"].transform
			local var_73_17 = 0

			if var_73_17 < arg_70_1.time_ and arg_70_1.time_ <= var_73_17 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_16.localPosition
				var_73_16.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 2)

				local var_73_18 = var_73_16.childCount

				for iter_73_8 = 0, var_73_18 - 1 do
					local var_73_19 = var_73_16:GetChild(iter_73_8)

					if var_73_19.name == "split_4" or not string.find(var_73_19.name, "split") then
						var_73_19.gameObject:SetActive(true)
					else
						var_73_19.gameObject:SetActive(false)
					end
				end
			end

			local var_73_20 = 0.001

			if var_73_17 <= arg_70_1.time_ and arg_70_1.time_ < var_73_17 + var_73_20 then
				local var_73_21 = (arg_70_1.time_ - var_73_17) / var_73_20
				local var_73_22 = Vector3.New(-390, -331.9, -324)

				var_73_16.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, var_73_22, var_73_21)
			end

			if arg_70_1.time_ >= var_73_17 + var_73_20 and arg_70_1.time_ < var_73_17 + var_73_20 + arg_73_0 then
				var_73_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_73_23 = 0
			local var_73_24 = 0.25

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_25 = arg_70_1:FormatText(StoryNameCfg[1109].name)

				arg_70_1.leftNameTxt_.text = var_73_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_26 = arg_70_1:GetWordFromCfg(417131017)
				local var_73_27 = arg_70_1:FormatText(var_73_26.content)

				arg_70_1.text_.text = var_73_27

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_28 = 10
				local var_73_29 = utf8.len(var_73_27)
				local var_73_30 = var_73_28 <= 0 and var_73_24 or var_73_24 * (var_73_29 / var_73_28)

				if var_73_30 > 0 and var_73_24 < var_73_30 then
					arg_70_1.talkMaxDuration = var_73_30

					if var_73_30 + var_73_23 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_30 + var_73_23
					end
				end

				arg_70_1.text_.text = var_73_27
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131017", "story_v_out_417131.awb") ~= 0 then
					local var_73_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131017", "story_v_out_417131.awb") / 1000

					if var_73_31 + var_73_23 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_31 + var_73_23
					end

					if var_73_26.prefab_name ~= "" and arg_70_1.actors_[var_73_26.prefab_name] ~= nil then
						local var_73_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_26.prefab_name].transform, "story_v_out_417131", "417131017", "story_v_out_417131.awb")

						arg_70_1:RecordAudio("417131017", var_73_32)
						arg_70_1:RecordAudio("417131017", var_73_32)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417131", "417131017", "story_v_out_417131.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417131", "417131017", "story_v_out_417131.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_33 = math.max(var_73_24, arg_70_1.talkMaxDuration)

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_33 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_23) / var_73_33

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_23 + var_73_33 and arg_70_1.time_ < var_73_23 + var_73_33 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play417131018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417131018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417131019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1034"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 == nil then
				arg_74_1.var_.actorSpriteComps1034 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1034 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 0.5, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			local var_77_8 = 0
			local var_77_9 = 1.35

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_10 = arg_74_1:GetWordFromCfg(417131018)
				local var_77_11 = arg_74_1:FormatText(var_77_10.content)

				arg_74_1.text_.text = var_77_11

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_12 = 54
				local var_77_13 = utf8.len(var_77_11)
				local var_77_14 = var_77_12 <= 0 and var_77_9 or var_77_9 * (var_77_13 / var_77_12)

				if var_77_14 > 0 and var_77_9 < var_77_14 then
					arg_74_1.talkMaxDuration = var_77_14

					if var_77_14 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_11
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_15 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_15 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_15

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_15 and arg_74_1.time_ < var_77_8 + var_77_15 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417131019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417131019
		arg_78_1.duration_ = 12.17

		local var_78_0 = {
			zh = 12.166,
			ja = 9.366
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
				arg_78_0:Play417131020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1034"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 1, var_81_3)

								iter_81_1.color = Color.New(var_81_7, var_81_7, var_81_7)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_8 = arg_78_1.actors_["1034"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 2)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "split_6" or not string.find(var_81_11.name, "split") then
						var_81_11.gameObject:SetActive(true)
					else
						var_81_11.gameObject:SetActive(false)
					end
				end
			end

			local var_81_12 = 0.001

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(-390, -331.9, -324)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, var_81_14, var_81_13)
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_81_15 = 0
			local var_81_16 = 1

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[1109].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(417131019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 40
				local var_81_21 = utf8.len(var_81_19)
				local var_81_22 = var_81_20 <= 0 and var_81_16 or var_81_16 * (var_81_21 / var_81_20)

				if var_81_22 > 0 and var_81_16 < var_81_22 then
					arg_78_1.talkMaxDuration = var_81_22

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131019", "story_v_out_417131.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_417131", "417131019", "story_v_out_417131.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_417131", "417131019", "story_v_out_417131.awb")

						arg_78_1:RecordAudio("417131019", var_81_24)
						arg_78_1:RecordAudio("417131019", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417131", "417131019", "story_v_out_417131.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417131", "417131019", "story_v_out_417131.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_25 and arg_78_1.time_ < var_81_15 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play417131020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417131020
		arg_82_1.duration_ = 11.37

		local var_82_0 = {
			zh = 11.366,
			ja = 10.566
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417131021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.4

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1109].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(417131020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 56
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131020", "story_v_out_417131.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131020", "story_v_out_417131.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_417131", "417131020", "story_v_out_417131.awb")

						arg_82_1:RecordAudio("417131020", var_85_9)
						arg_82_1:RecordAudio("417131020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417131", "417131020", "story_v_out_417131.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417131", "417131020", "story_v_out_417131.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417131021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417131021
		arg_86_1.duration_ = 9.77

		local var_86_0 = {
			zh = 9.766,
			ja = 9.4
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417131022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.2

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[1109].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(417131021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 48
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131021", "story_v_out_417131.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131021", "story_v_out_417131.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_417131", "417131021", "story_v_out_417131.awb")

						arg_86_1:RecordAudio("417131021", var_89_9)
						arg_86_1:RecordAudio("417131021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417131", "417131021", "story_v_out_417131.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417131", "417131021", "story_v_out_417131.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417131022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417131022
		arg_90_1.duration_ = 4.3

		local var_90_0 = {
			zh = 4.3,
			ja = 2.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417131023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10115"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10115 == nil then
				arg_90_1.var_.actorSpriteComps10115 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps10115 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10115 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10115 = nil
			end

			local var_93_8 = arg_90_1.actors_["1034"]
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps1034 == nil then
				arg_90_1.var_.actorSpriteComps1034 = var_93_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_10 = 0.2

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_10 and not isNil(var_93_8) then
				local var_93_11 = (arg_90_1.time_ - var_93_9) / var_93_10

				if arg_90_1.var_.actorSpriteComps1034 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								local var_93_12 = Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor2.r, var_93_11)
								local var_93_13 = Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor2.g, var_93_11)
								local var_93_14 = Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor2.b, var_93_11)

								iter_93_5.color = Color.New(var_93_12, var_93_13, var_93_14)
							else
								local var_93_15 = Mathf.Lerp(iter_93_5.color.r, 0.5, var_93_11)

								iter_93_5.color = Color.New(var_93_15, var_93_15, var_93_15)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_9 + var_93_10 and arg_90_1.time_ < var_93_9 + var_93_10 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps1034 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_93_7 then
						if arg_90_1.isInRecall_ then
							iter_93_7.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1034 = nil
			end

			local var_93_16 = arg_90_1.actors_["10115"].transform
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.var_.moveOldPos10115 = var_93_16.localPosition
				var_93_16.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10115", 4)

				local var_93_18 = var_93_16.childCount

				for iter_93_8 = 0, var_93_18 - 1 do
					local var_93_19 = var_93_16:GetChild(iter_93_8)

					if var_93_19.name == "split_4" or not string.find(var_93_19.name, "split") then
						var_93_19.gameObject:SetActive(true)
					else
						var_93_19.gameObject:SetActive(false)
					end
				end
			end

			local var_93_20 = 0.001

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_20 then
				local var_93_21 = (arg_90_1.time_ - var_93_17) / var_93_20
				local var_93_22 = Vector3.New(390, -387.3, -246.2)

				var_93_16.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10115, var_93_22, var_93_21)
			end

			if arg_90_1.time_ >= var_93_17 + var_93_20 and arg_90_1.time_ < var_93_17 + var_93_20 + arg_93_0 then
				var_93_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_93_23 = 0
			local var_93_24 = 1

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_25 = arg_90_1:FormatText(StoryNameCfg[1113].name)

				arg_90_1.leftNameTxt_.text = var_93_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_26 = arg_90_1:GetWordFromCfg(417131022)
				local var_93_27 = arg_90_1:FormatText(var_93_26.content)

				arg_90_1.text_.text = var_93_27

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_28 = 17
				local var_93_29 = utf8.len(var_93_27)
				local var_93_30 = var_93_28 <= 0 and var_93_24 or var_93_24 * (var_93_29 / var_93_28)

				if var_93_30 > 0 and var_93_24 < var_93_30 then
					arg_90_1.talkMaxDuration = var_93_30

					if var_93_30 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_30 + var_93_23
					end
				end

				arg_90_1.text_.text = var_93_27
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131022", "story_v_out_417131.awb") ~= 0 then
					local var_93_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131022", "story_v_out_417131.awb") / 1000

					if var_93_31 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_31 + var_93_23
					end

					if var_93_26.prefab_name ~= "" and arg_90_1.actors_[var_93_26.prefab_name] ~= nil then
						local var_93_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_26.prefab_name].transform, "story_v_out_417131", "417131022", "story_v_out_417131.awb")

						arg_90_1:RecordAudio("417131022", var_93_32)
						arg_90_1:RecordAudio("417131022", var_93_32)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417131", "417131022", "story_v_out_417131.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417131", "417131022", "story_v_out_417131.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_33 = math.max(var_93_24, arg_90_1.talkMaxDuration)

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_33 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_23) / var_93_33

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_23 + var_93_33 and arg_90_1.time_ < var_93_23 + var_93_33 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play417131023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417131023
		arg_94_1.duration_ = 7.13

		local var_94_0 = {
			zh = 5.933,
			ja = 7.133
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417131024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1034"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1034 == nil then
				arg_94_1.var_.actorSpriteComps1034 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps1034 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 1, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			local var_97_8 = arg_94_1.actors_["10115"]
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps10115 == nil then
				arg_94_1.var_.actorSpriteComps10115 = var_97_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_10 = 0.2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 and not isNil(var_97_8) then
				local var_97_11 = (arg_94_1.time_ - var_97_9) / var_97_10

				if arg_94_1.var_.actorSpriteComps10115 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								local var_97_12 = Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor2.r, var_97_11)
								local var_97_13 = Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor2.g, var_97_11)
								local var_97_14 = Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor2.b, var_97_11)

								iter_97_5.color = Color.New(var_97_12, var_97_13, var_97_14)
							else
								local var_97_15 = Mathf.Lerp(iter_97_5.color.r, 0.5, var_97_11)

								iter_97_5.color = Color.New(var_97_15, var_97_15, var_97_15)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps10115 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_97_7 then
						if arg_94_1.isInRecall_ then
							iter_97_7.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps10115 = nil
			end

			local var_97_16 = arg_94_1.actors_["1034"].transform
			local var_97_17 = 0

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				arg_94_1.var_.moveOldPos1034 = var_97_16.localPosition
				var_97_16.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1034", 2)

				local var_97_18 = var_97_16.childCount

				for iter_97_8 = 0, var_97_18 - 1 do
					local var_97_19 = var_97_16:GetChild(iter_97_8)

					if var_97_19.name == "split_3" or not string.find(var_97_19.name, "split") then
						var_97_19.gameObject:SetActive(true)
					else
						var_97_19.gameObject:SetActive(false)
					end
				end
			end

			local var_97_20 = 0.001

			if var_97_17 <= arg_94_1.time_ and arg_94_1.time_ < var_97_17 + var_97_20 then
				local var_97_21 = (arg_94_1.time_ - var_97_17) / var_97_20
				local var_97_22 = Vector3.New(-390, -331.9, -324)

				var_97_16.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1034, var_97_22, var_97_21)
			end

			if arg_94_1.time_ >= var_97_17 + var_97_20 and arg_94_1.time_ < var_97_17 + var_97_20 + arg_97_0 then
				var_97_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_97_23 = 0
			local var_97_24 = 0.55

			if var_97_23 < arg_94_1.time_ and arg_94_1.time_ <= var_97_23 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_25 = arg_94_1:FormatText(StoryNameCfg[1109].name)

				arg_94_1.leftNameTxt_.text = var_97_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_26 = arg_94_1:GetWordFromCfg(417131023)
				local var_97_27 = arg_94_1:FormatText(var_97_26.content)

				arg_94_1.text_.text = var_97_27

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_28 = 22
				local var_97_29 = utf8.len(var_97_27)
				local var_97_30 = var_97_28 <= 0 and var_97_24 or var_97_24 * (var_97_29 / var_97_28)

				if var_97_30 > 0 and var_97_24 < var_97_30 then
					arg_94_1.talkMaxDuration = var_97_30

					if var_97_30 + var_97_23 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_30 + var_97_23
					end
				end

				arg_94_1.text_.text = var_97_27
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131023", "story_v_out_417131.awb") ~= 0 then
					local var_97_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131023", "story_v_out_417131.awb") / 1000

					if var_97_31 + var_97_23 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_31 + var_97_23
					end

					if var_97_26.prefab_name ~= "" and arg_94_1.actors_[var_97_26.prefab_name] ~= nil then
						local var_97_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_26.prefab_name].transform, "story_v_out_417131", "417131023", "story_v_out_417131.awb")

						arg_94_1:RecordAudio("417131023", var_97_32)
						arg_94_1:RecordAudio("417131023", var_97_32)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417131", "417131023", "story_v_out_417131.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417131", "417131023", "story_v_out_417131.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_33 = math.max(var_97_24, arg_94_1.talkMaxDuration)

			if var_97_23 <= arg_94_1.time_ and arg_94_1.time_ < var_97_23 + var_97_33 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_23) / var_97_33

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_23 + var_97_33 and arg_94_1.time_ < var_97_23 + var_97_33 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play417131024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417131024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417131025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1034"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1034 == nil then
				arg_98_1.var_.actorSpriteComps1034 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps1034 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor2.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor2.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor2.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 0.5, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1034 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1034 = nil
			end

			local var_101_8 = arg_98_1.actors_["1034"].transform
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.var_.moveOldPos1034 = var_101_8.localPosition
				var_101_8.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1034", 2)

				local var_101_10 = var_101_8.childCount

				for iter_101_4 = 0, var_101_10 - 1 do
					local var_101_11 = var_101_8:GetChild(iter_101_4)

					if var_101_11.name == "split_6" or not string.find(var_101_11.name, "split") then
						var_101_11.gameObject:SetActive(true)
					else
						var_101_11.gameObject:SetActive(false)
					end
				end
			end

			local var_101_12 = 0.001

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_9) / var_101_12
				local var_101_14 = Vector3.New(-390, -331.9, -324)

				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1034, var_101_14, var_101_13)
			end

			if arg_98_1.time_ >= var_101_9 + var_101_12 and arg_98_1.time_ < var_101_9 + var_101_12 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_101_15 = 0
			local var_101_16 = 1.55

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_17 = arg_98_1:GetWordFromCfg(417131024)
				local var_101_18 = arg_98_1:FormatText(var_101_17.content)

				arg_98_1.text_.text = var_101_18

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_19 = 62
				local var_101_20 = utf8.len(var_101_18)
				local var_101_21 = var_101_19 <= 0 and var_101_16 or var_101_16 * (var_101_20 / var_101_19)

				if var_101_21 > 0 and var_101_16 < var_101_21 then
					arg_98_1.talkMaxDuration = var_101_21

					if var_101_21 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_21 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_18
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_22 and arg_98_1.time_ < var_101_15 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play417131025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417131025
		arg_102_1.duration_ = 10.3

		local var_102_0 = {
			zh = 7.1,
			ja = 10.3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417131026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1034"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1034 == nil then
				arg_102_1.var_.actorSpriteComps1034 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps1034 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 1, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1034 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1034 = nil
			end

			local var_105_8 = 0
			local var_105_9 = 0.55

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[1109].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_11 = arg_102_1:GetWordFromCfg(417131025)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 22
				local var_105_14 = utf8.len(var_105_12)
				local var_105_15 = var_105_13 <= 0 and var_105_9 or var_105_9 * (var_105_14 / var_105_13)

				if var_105_15 > 0 and var_105_9 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_12
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131025", "story_v_out_417131.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_417131", "417131025", "story_v_out_417131.awb") / 1000

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end

					if var_105_11.prefab_name ~= "" and arg_102_1.actors_[var_105_11.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_11.prefab_name].transform, "story_v_out_417131", "417131025", "story_v_out_417131.awb")

						arg_102_1:RecordAudio("417131025", var_105_17)
						arg_102_1:RecordAudio("417131025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417131", "417131025", "story_v_out_417131.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417131", "417131025", "story_v_out_417131.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_18 and arg_102_1.time_ < var_105_8 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417131026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417131026
		arg_106_1.duration_ = 4.43

		local var_106_0 = {
			zh = 4.066,
			ja = 4.433
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
				arg_106_0:Play417131027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.35

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[1109].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(417131026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131026", "story_v_out_417131.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131026", "story_v_out_417131.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_417131", "417131026", "story_v_out_417131.awb")

						arg_106_1:RecordAudio("417131026", var_109_9)
						arg_106_1:RecordAudio("417131026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417131", "417131026", "story_v_out_417131.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417131", "417131026", "story_v_out_417131.awb")
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
	Play417131027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417131027
		arg_110_1.duration_ = 7.8

		local var_110_0 = {
			zh = 5.8,
			ja = 7.8
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play417131028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10115"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps10115 == nil then
				arg_110_1.var_.actorSpriteComps10115 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps10115 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 1, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps10115 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps10115 = nil
			end

			local var_113_8 = arg_110_1.actors_["1034"]
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps1034 == nil then
				arg_110_1.var_.actorSpriteComps1034 = var_113_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_10 = 0.2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 and not isNil(var_113_8) then
				local var_113_11 = (arg_110_1.time_ - var_113_9) / var_113_10

				if arg_110_1.var_.actorSpriteComps1034 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								local var_113_12 = Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor2.r, var_113_11)
								local var_113_13 = Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor2.g, var_113_11)
								local var_113_14 = Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor2.b, var_113_11)

								iter_113_5.color = Color.New(var_113_12, var_113_13, var_113_14)
							else
								local var_113_15 = Mathf.Lerp(iter_113_5.color.r, 0.5, var_113_11)

								iter_113_5.color = Color.New(var_113_15, var_113_15, var_113_15)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps1034 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_113_7 then
						if arg_110_1.isInRecall_ then
							iter_113_7.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1034 = nil
			end

			local var_113_16 = arg_110_1.actors_["10115"].transform
			local var_113_17 = 0

			if var_113_17 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.var_.moveOldPos10115 = var_113_16.localPosition
				var_113_16.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10115", 4)

				local var_113_18 = var_113_16.childCount

				for iter_113_8 = 0, var_113_18 - 1 do
					local var_113_19 = var_113_16:GetChild(iter_113_8)

					if var_113_19.name == "split_6" or not string.find(var_113_19.name, "split") then
						var_113_19.gameObject:SetActive(true)
					else
						var_113_19.gameObject:SetActive(false)
					end
				end
			end

			local var_113_20 = 0.001

			if var_113_17 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_20 then
				local var_113_21 = (arg_110_1.time_ - var_113_17) / var_113_20
				local var_113_22 = Vector3.New(390, -387.3, -246.2)

				var_113_16.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10115, var_113_22, var_113_21)
			end

			if arg_110_1.time_ >= var_113_17 + var_113_20 and arg_110_1.time_ < var_113_17 + var_113_20 + arg_113_0 then
				var_113_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_113_23 = 0
			local var_113_24 = 0.725

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_25 = arg_110_1:FormatText(StoryNameCfg[1113].name)

				arg_110_1.leftNameTxt_.text = var_113_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_26 = arg_110_1:GetWordFromCfg(417131027)
				local var_113_27 = arg_110_1:FormatText(var_113_26.content)

				arg_110_1.text_.text = var_113_27

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_28 = 29
				local var_113_29 = utf8.len(var_113_27)
				local var_113_30 = var_113_28 <= 0 and var_113_24 or var_113_24 * (var_113_29 / var_113_28)

				if var_113_30 > 0 and var_113_24 < var_113_30 then
					arg_110_1.talkMaxDuration = var_113_30

					if var_113_30 + var_113_23 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_30 + var_113_23
					end
				end

				arg_110_1.text_.text = var_113_27
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131027", "story_v_out_417131.awb") ~= 0 then
					local var_113_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131027", "story_v_out_417131.awb") / 1000

					if var_113_31 + var_113_23 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_23
					end

					if var_113_26.prefab_name ~= "" and arg_110_1.actors_[var_113_26.prefab_name] ~= nil then
						local var_113_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_26.prefab_name].transform, "story_v_out_417131", "417131027", "story_v_out_417131.awb")

						arg_110_1:RecordAudio("417131027", var_113_32)
						arg_110_1:RecordAudio("417131027", var_113_32)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417131", "417131027", "story_v_out_417131.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417131", "417131027", "story_v_out_417131.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_33 = math.max(var_113_24, arg_110_1.talkMaxDuration)

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_33 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_23) / var_113_33

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_23 + var_113_33 and arg_110_1.time_ < var_113_23 + var_113_33 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play417131028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417131028
		arg_114_1.duration_ = 20.4

		local var_114_0 = {
			zh = 15.6,
			ja = 20.4
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417131029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.9

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1113].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(417131028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 76
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131028", "story_v_out_417131.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131028", "story_v_out_417131.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_417131", "417131028", "story_v_out_417131.awb")

						arg_114_1:RecordAudio("417131028", var_117_9)
						arg_114_1:RecordAudio("417131028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417131", "417131028", "story_v_out_417131.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417131", "417131028", "story_v_out_417131.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play417131029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417131029
		arg_118_1.duration_ = 9.7

		local var_118_0 = {
			zh = 6.5,
			ja = 9.7
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
				arg_118_0:Play417131030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10115"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos10115 = var_121_0.localPosition
				var_121_0.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10115", 4)

				local var_121_2 = var_121_0.childCount

				for iter_121_0 = 0, var_121_2 - 1 do
					local var_121_3 = var_121_0:GetChild(iter_121_0)

					if var_121_3.name == "split_4" or not string.find(var_121_3.name, "split") then
						var_121_3.gameObject:SetActive(true)
					else
						var_121_3.gameObject:SetActive(false)
					end
				end
			end

			local var_121_4 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_4 then
				local var_121_5 = (arg_118_1.time_ - var_121_1) / var_121_4
				local var_121_6 = Vector3.New(390, -387.3, -246.2)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10115, var_121_6, var_121_5)
			end

			if arg_118_1.time_ >= var_121_1 + var_121_4 and arg_118_1.time_ < var_121_1 + var_121_4 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_121_7 = 0
			local var_121_8 = 0.85

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_9 = arg_118_1:FormatText(StoryNameCfg[1113].name)

				arg_118_1.leftNameTxt_.text = var_121_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:GetWordFromCfg(417131029)
				local var_121_11 = arg_118_1:FormatText(var_121_10.content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_12 = 34
				local var_121_13 = utf8.len(var_121_11)
				local var_121_14 = var_121_12 <= 0 and var_121_8 or var_121_8 * (var_121_13 / var_121_12)

				if var_121_14 > 0 and var_121_8 < var_121_14 then
					arg_118_1.talkMaxDuration = var_121_14

					if var_121_14 + var_121_7 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_7
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131029", "story_v_out_417131.awb") ~= 0 then
					local var_121_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131029", "story_v_out_417131.awb") / 1000

					if var_121_15 + var_121_7 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_7
					end

					if var_121_10.prefab_name ~= "" and arg_118_1.actors_[var_121_10.prefab_name] ~= nil then
						local var_121_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_10.prefab_name].transform, "story_v_out_417131", "417131029", "story_v_out_417131.awb")

						arg_118_1:RecordAudio("417131029", var_121_16)
						arg_118_1:RecordAudio("417131029", var_121_16)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417131", "417131029", "story_v_out_417131.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417131", "417131029", "story_v_out_417131.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_17 = math.max(var_121_8, arg_118_1.talkMaxDuration)

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_17 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_7) / var_121_17

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_7 + var_121_17 and arg_118_1.time_ < var_121_7 + var_121_17 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play417131030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417131030
		arg_122_1.duration_ = 13.33

		local var_122_0 = {
			zh = 12.5,
			ja = 13.333
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417131031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1.15

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[1113].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(417131030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 46
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131030", "story_v_out_417131.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131030", "story_v_out_417131.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_417131", "417131030", "story_v_out_417131.awb")

						arg_122_1:RecordAudio("417131030", var_125_9)
						arg_122_1:RecordAudio("417131030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417131", "417131030", "story_v_out_417131.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417131", "417131030", "story_v_out_417131.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417131031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417131031
		arg_126_1.duration_ = 6.7

		local var_126_0 = {
			zh = 6.266,
			ja = 6.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417131032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1034"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1034 == nil then
				arg_126_1.var_.actorSpriteComps1034 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps1034 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								local var_129_4 = Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, var_129_3)
								local var_129_5 = Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, var_129_3)
								local var_129_6 = Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, var_129_3)

								iter_129_1.color = Color.New(var_129_4, var_129_5, var_129_6)
							else
								local var_129_7 = Mathf.Lerp(iter_129_1.color.r, 1, var_129_3)

								iter_129_1.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1034 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1034 = nil
			end

			local var_129_8 = arg_126_1.actors_["10115"]
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps10115 == nil then
				arg_126_1.var_.actorSpriteComps10115 = var_129_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_10 = 0.2

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_10 and not isNil(var_129_8) then
				local var_129_11 = (arg_126_1.time_ - var_129_9) / var_129_10

				if arg_126_1.var_.actorSpriteComps10115 then
					for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_129_5 then
							if arg_126_1.isInRecall_ then
								local var_129_12 = Mathf.Lerp(iter_129_5.color.r, arg_126_1.hightColor2.r, var_129_11)
								local var_129_13 = Mathf.Lerp(iter_129_5.color.g, arg_126_1.hightColor2.g, var_129_11)
								local var_129_14 = Mathf.Lerp(iter_129_5.color.b, arg_126_1.hightColor2.b, var_129_11)

								iter_129_5.color = Color.New(var_129_12, var_129_13, var_129_14)
							else
								local var_129_15 = Mathf.Lerp(iter_129_5.color.r, 0.5, var_129_11)

								iter_129_5.color = Color.New(var_129_15, var_129_15, var_129_15)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_9 + var_129_10 and arg_126_1.time_ < var_129_9 + var_129_10 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps10115 then
				for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_129_7 then
						if arg_126_1.isInRecall_ then
							iter_129_7.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps10115 = nil
			end

			local var_129_16 = 0
			local var_129_17 = 0.4

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_18 = arg_126_1:FormatText(StoryNameCfg[1109].name)

				arg_126_1.leftNameTxt_.text = var_129_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_19 = arg_126_1:GetWordFromCfg(417131031)
				local var_129_20 = arg_126_1:FormatText(var_129_19.content)

				arg_126_1.text_.text = var_129_20

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_21 = 16
				local var_129_22 = utf8.len(var_129_20)
				local var_129_23 = var_129_21 <= 0 and var_129_17 or var_129_17 * (var_129_22 / var_129_21)

				if var_129_23 > 0 and var_129_17 < var_129_23 then
					arg_126_1.talkMaxDuration = var_129_23

					if var_129_23 + var_129_16 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_16
					end
				end

				arg_126_1.text_.text = var_129_20
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131031", "story_v_out_417131.awb") ~= 0 then
					local var_129_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131031", "story_v_out_417131.awb") / 1000

					if var_129_24 + var_129_16 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_24 + var_129_16
					end

					if var_129_19.prefab_name ~= "" and arg_126_1.actors_[var_129_19.prefab_name] ~= nil then
						local var_129_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_19.prefab_name].transform, "story_v_out_417131", "417131031", "story_v_out_417131.awb")

						arg_126_1:RecordAudio("417131031", var_129_25)
						arg_126_1:RecordAudio("417131031", var_129_25)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417131", "417131031", "story_v_out_417131.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417131", "417131031", "story_v_out_417131.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_26 = math.max(var_129_17, arg_126_1.talkMaxDuration)

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_26 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_16) / var_129_26

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_16 + var_129_26 and arg_126_1.time_ < var_129_16 + var_129_26 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417131032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417131032
		arg_130_1.duration_ = 9.53

		local var_130_0 = {
			zh = 4.2,
			ja = 9.533
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417131033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10115"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10115 == nil then
				arg_130_1.var_.actorSpriteComps10115 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps10115 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 1, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10115 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_133_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps10115 = nil
			end

			local var_133_8 = arg_130_1.actors_["1034"]
			local var_133_9 = 0

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.actorSpriteComps1034 == nil then
				arg_130_1.var_.actorSpriteComps1034 = var_133_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_10 = 0.2

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_10 and not isNil(var_133_8) then
				local var_133_11 = (arg_130_1.time_ - var_133_9) / var_133_10

				if arg_130_1.var_.actorSpriteComps1034 then
					for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_133_5 then
							if arg_130_1.isInRecall_ then
								local var_133_12 = Mathf.Lerp(iter_133_5.color.r, arg_130_1.hightColor2.r, var_133_11)
								local var_133_13 = Mathf.Lerp(iter_133_5.color.g, arg_130_1.hightColor2.g, var_133_11)
								local var_133_14 = Mathf.Lerp(iter_133_5.color.b, arg_130_1.hightColor2.b, var_133_11)

								iter_133_5.color = Color.New(var_133_12, var_133_13, var_133_14)
							else
								local var_133_15 = Mathf.Lerp(iter_133_5.color.r, 0.5, var_133_11)

								iter_133_5.color = Color.New(var_133_15, var_133_15, var_133_15)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_9 + var_133_10 and arg_130_1.time_ < var_133_9 + var_133_10 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.actorSpriteComps1034 then
				for iter_133_6, iter_133_7 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_133_7 then
						if arg_130_1.isInRecall_ then
							iter_133_7.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1034 = nil
			end

			local var_133_16 = 0
			local var_133_17 = 0.55

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_18 = arg_130_1:FormatText(StoryNameCfg[1113].name)

				arg_130_1.leftNameTxt_.text = var_133_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_19 = arg_130_1:GetWordFromCfg(417131032)
				local var_133_20 = arg_130_1:FormatText(var_133_19.content)

				arg_130_1.text_.text = var_133_20

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_21 = 22
				local var_133_22 = utf8.len(var_133_20)
				local var_133_23 = var_133_21 <= 0 and var_133_17 or var_133_17 * (var_133_22 / var_133_21)

				if var_133_23 > 0 and var_133_17 < var_133_23 then
					arg_130_1.talkMaxDuration = var_133_23

					if var_133_23 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_16
					end
				end

				arg_130_1.text_.text = var_133_20
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131032", "story_v_out_417131.awb") ~= 0 then
					local var_133_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131032", "story_v_out_417131.awb") / 1000

					if var_133_24 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_16
					end

					if var_133_19.prefab_name ~= "" and arg_130_1.actors_[var_133_19.prefab_name] ~= nil then
						local var_133_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_19.prefab_name].transform, "story_v_out_417131", "417131032", "story_v_out_417131.awb")

						arg_130_1:RecordAudio("417131032", var_133_25)
						arg_130_1:RecordAudio("417131032", var_133_25)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417131", "417131032", "story_v_out_417131.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417131", "417131032", "story_v_out_417131.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_17, arg_130_1.talkMaxDuration)

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_16) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_16 + var_133_26 and arg_130_1.time_ < var_133_16 + var_133_26 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417131033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417131033
		arg_134_1.duration_ = 10.67

		local var_134_0 = {
			zh = 8.633,
			ja = 10.666
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417131034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1034"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1034 == nil then
				arg_134_1.var_.actorSpriteComps1034 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps1034 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 1, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1034 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1034 = nil
			end

			local var_137_8 = arg_134_1.actors_["10115"]
			local var_137_9 = 0

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps10115 == nil then
				arg_134_1.var_.actorSpriteComps10115 = var_137_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_10 = 0.2

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_10 and not isNil(var_137_8) then
				local var_137_11 = (arg_134_1.time_ - var_137_9) / var_137_10

				if arg_134_1.var_.actorSpriteComps10115 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_137_5 then
							if arg_134_1.isInRecall_ then
								local var_137_12 = Mathf.Lerp(iter_137_5.color.r, arg_134_1.hightColor2.r, var_137_11)
								local var_137_13 = Mathf.Lerp(iter_137_5.color.g, arg_134_1.hightColor2.g, var_137_11)
								local var_137_14 = Mathf.Lerp(iter_137_5.color.b, arg_134_1.hightColor2.b, var_137_11)

								iter_137_5.color = Color.New(var_137_12, var_137_13, var_137_14)
							else
								local var_137_15 = Mathf.Lerp(iter_137_5.color.r, 0.5, var_137_11)

								iter_137_5.color = Color.New(var_137_15, var_137_15, var_137_15)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_9 + var_137_10 and arg_134_1.time_ < var_137_9 + var_137_10 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps10115 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_137_7 then
						if arg_134_1.isInRecall_ then
							iter_137_7.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10115 = nil
			end

			local var_137_16 = 0
			local var_137_17 = 1

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_18 = arg_134_1:FormatText(StoryNameCfg[1109].name)

				arg_134_1.leftNameTxt_.text = var_137_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_19 = arg_134_1:GetWordFromCfg(417131033)
				local var_137_20 = arg_134_1:FormatText(var_137_19.content)

				arg_134_1.text_.text = var_137_20

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_21 = 40
				local var_137_22 = utf8.len(var_137_20)
				local var_137_23 = var_137_21 <= 0 and var_137_17 or var_137_17 * (var_137_22 / var_137_21)

				if var_137_23 > 0 and var_137_17 < var_137_23 then
					arg_134_1.talkMaxDuration = var_137_23

					if var_137_23 + var_137_16 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_16
					end
				end

				arg_134_1.text_.text = var_137_20
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131033", "story_v_out_417131.awb") ~= 0 then
					local var_137_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131033", "story_v_out_417131.awb") / 1000

					if var_137_24 + var_137_16 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_24 + var_137_16
					end

					if var_137_19.prefab_name ~= "" and arg_134_1.actors_[var_137_19.prefab_name] ~= nil then
						local var_137_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_19.prefab_name].transform, "story_v_out_417131", "417131033", "story_v_out_417131.awb")

						arg_134_1:RecordAudio("417131033", var_137_25)
						arg_134_1:RecordAudio("417131033", var_137_25)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417131", "417131033", "story_v_out_417131.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417131", "417131033", "story_v_out_417131.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_26 = math.max(var_137_17, arg_134_1.talkMaxDuration)

			if var_137_16 <= arg_134_1.time_ and arg_134_1.time_ < var_137_16 + var_137_26 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_16) / var_137_26

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_16 + var_137_26 and arg_134_1.time_ < var_137_16 + var_137_26 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417131034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417131034
		arg_138_1.duration_ = 11.73

		local var_138_0 = {
			zh = 10.1,
			ja = 11.733
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417131035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10115"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10115 == nil then
				arg_138_1.var_.actorSpriteComps10115 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps10115 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 1, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10115 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10115 = nil
			end

			local var_141_8 = arg_138_1.actors_["1034"]
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1034 == nil then
				arg_138_1.var_.actorSpriteComps1034 = var_141_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_10 = 0.2

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_10 and not isNil(var_141_8) then
				local var_141_11 = (arg_138_1.time_ - var_141_9) / var_141_10

				if arg_138_1.var_.actorSpriteComps1034 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								local var_141_12 = Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor2.r, var_141_11)
								local var_141_13 = Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor2.g, var_141_11)
								local var_141_14 = Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor2.b, var_141_11)

								iter_141_5.color = Color.New(var_141_12, var_141_13, var_141_14)
							else
								local var_141_15 = Mathf.Lerp(iter_141_5.color.r, 0.5, var_141_11)

								iter_141_5.color = Color.New(var_141_15, var_141_15, var_141_15)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_9 + var_141_10 and arg_138_1.time_ < var_141_9 + var_141_10 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1034 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_141_7 then
						if arg_138_1.isInRecall_ then
							iter_141_7.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1034 = nil
			end

			local var_141_16 = 0
			local var_141_17 = 1.05

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_18 = arg_138_1:FormatText(StoryNameCfg[1113].name)

				arg_138_1.leftNameTxt_.text = var_141_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_19 = arg_138_1:GetWordFromCfg(417131034)
				local var_141_20 = arg_138_1:FormatText(var_141_19.content)

				arg_138_1.text_.text = var_141_20

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_21 = 42
				local var_141_22 = utf8.len(var_141_20)
				local var_141_23 = var_141_21 <= 0 and var_141_17 or var_141_17 * (var_141_22 / var_141_21)

				if var_141_23 > 0 and var_141_17 < var_141_23 then
					arg_138_1.talkMaxDuration = var_141_23

					if var_141_23 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_16
					end
				end

				arg_138_1.text_.text = var_141_20
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131034", "story_v_out_417131.awb") ~= 0 then
					local var_141_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131034", "story_v_out_417131.awb") / 1000

					if var_141_24 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_24 + var_141_16
					end

					if var_141_19.prefab_name ~= "" and arg_138_1.actors_[var_141_19.prefab_name] ~= nil then
						local var_141_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_19.prefab_name].transform, "story_v_out_417131", "417131034", "story_v_out_417131.awb")

						arg_138_1:RecordAudio("417131034", var_141_25)
						arg_138_1:RecordAudio("417131034", var_141_25)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417131", "417131034", "story_v_out_417131.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417131", "417131034", "story_v_out_417131.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_26 = math.max(var_141_17, arg_138_1.talkMaxDuration)

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_26 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_16) / var_141_26

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_16 + var_141_26 and arg_138_1.time_ < var_141_16 + var_141_26 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417131035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417131035
		arg_142_1.duration_ = 9.57

		local var_142_0 = {
			zh = 6.766,
			ja = 9.566
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417131036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10115"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos10115 = var_145_0.localPosition
				var_145_0.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10115", 4)

				local var_145_2 = var_145_0.childCount

				for iter_145_0 = 0, var_145_2 - 1 do
					local var_145_3 = var_145_0:GetChild(iter_145_0)

					if var_145_3.name == "split_6" or not string.find(var_145_3.name, "split") then
						var_145_3.gameObject:SetActive(true)
					else
						var_145_3.gameObject:SetActive(false)
					end
				end
			end

			local var_145_4 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_4 then
				local var_145_5 = (arg_142_1.time_ - var_145_1) / var_145_4
				local var_145_6 = Vector3.New(390, -387.3, -246.2)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10115, var_145_6, var_145_5)
			end

			if arg_142_1.time_ >= var_145_1 + var_145_4 and arg_142_1.time_ < var_145_1 + var_145_4 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_145_7 = 0
			local var_145_8 = 0.875

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_9 = arg_142_1:FormatText(StoryNameCfg[1113].name)

				arg_142_1.leftNameTxt_.text = var_145_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_10 = arg_142_1:GetWordFromCfg(417131035)
				local var_145_11 = arg_142_1:FormatText(var_145_10.content)

				arg_142_1.text_.text = var_145_11

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_12 = 35
				local var_145_13 = utf8.len(var_145_11)
				local var_145_14 = var_145_12 <= 0 and var_145_8 or var_145_8 * (var_145_13 / var_145_12)

				if var_145_14 > 0 and var_145_8 < var_145_14 then
					arg_142_1.talkMaxDuration = var_145_14

					if var_145_14 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_7
					end
				end

				arg_142_1.text_.text = var_145_11
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131035", "story_v_out_417131.awb") ~= 0 then
					local var_145_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131035", "story_v_out_417131.awb") / 1000

					if var_145_15 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_7
					end

					if var_145_10.prefab_name ~= "" and arg_142_1.actors_[var_145_10.prefab_name] ~= nil then
						local var_145_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_10.prefab_name].transform, "story_v_out_417131", "417131035", "story_v_out_417131.awb")

						arg_142_1:RecordAudio("417131035", var_145_16)
						arg_142_1:RecordAudio("417131035", var_145_16)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417131", "417131035", "story_v_out_417131.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417131", "417131035", "story_v_out_417131.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_17 = math.max(var_145_8, arg_142_1.talkMaxDuration)

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_17 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_7) / var_145_17

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_7 + var_145_17 and arg_142_1.time_ < var_145_7 + var_145_17 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play417131036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417131036
		arg_146_1.duration_ = 11.63

		local var_146_0 = {
			zh = 6.733,
			ja = 11.633
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417131037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.85

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[1113].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:GetWordFromCfg(417131036)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 34
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131036", "story_v_out_417131.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131036", "story_v_out_417131.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_417131", "417131036", "story_v_out_417131.awb")

						arg_146_1:RecordAudio("417131036", var_149_9)
						arg_146_1:RecordAudio("417131036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417131", "417131036", "story_v_out_417131.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417131", "417131036", "story_v_out_417131.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417131037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417131037
		arg_150_1.duration_ = 4.73

		local var_150_0 = {
			zh = 1.433,
			ja = 4.733
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417131038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1034"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps1034 == nil then
				arg_150_1.var_.actorSpriteComps1034 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps1034 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 1, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps1034 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps1034 = nil
			end

			local var_153_8 = arg_150_1.actors_["10115"]
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps10115 == nil then
				arg_150_1.var_.actorSpriteComps10115 = var_153_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_10 = 0.2

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 and not isNil(var_153_8) then
				local var_153_11 = (arg_150_1.time_ - var_153_9) / var_153_10

				if arg_150_1.var_.actorSpriteComps10115 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								local var_153_12 = Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, var_153_11)
								local var_153_13 = Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, var_153_11)
								local var_153_14 = Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, var_153_11)

								iter_153_5.color = Color.New(var_153_12, var_153_13, var_153_14)
							else
								local var_153_15 = Mathf.Lerp(iter_153_5.color.r, 0.5, var_153_11)

								iter_153_5.color = Color.New(var_153_15, var_153_15, var_153_15)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps10115 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_153_7 then
						if arg_150_1.isInRecall_ then
							iter_153_7.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10115 = nil
			end

			local var_153_16 = 0
			local var_153_17 = 0.175

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_18 = arg_150_1:FormatText(StoryNameCfg[1109].name)

				arg_150_1.leftNameTxt_.text = var_153_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_19 = arg_150_1:GetWordFromCfg(417131037)
				local var_153_20 = arg_150_1:FormatText(var_153_19.content)

				arg_150_1.text_.text = var_153_20

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_21 = 7
				local var_153_22 = utf8.len(var_153_20)
				local var_153_23 = var_153_21 <= 0 and var_153_17 or var_153_17 * (var_153_22 / var_153_21)

				if var_153_23 > 0 and var_153_17 < var_153_23 then
					arg_150_1.talkMaxDuration = var_153_23

					if var_153_23 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_16
					end
				end

				arg_150_1.text_.text = var_153_20
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131037", "story_v_out_417131.awb") ~= 0 then
					local var_153_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131037", "story_v_out_417131.awb") / 1000

					if var_153_24 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_16
					end

					if var_153_19.prefab_name ~= "" and arg_150_1.actors_[var_153_19.prefab_name] ~= nil then
						local var_153_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_19.prefab_name].transform, "story_v_out_417131", "417131037", "story_v_out_417131.awb")

						arg_150_1:RecordAudio("417131037", var_153_25)
						arg_150_1:RecordAudio("417131037", var_153_25)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417131", "417131037", "story_v_out_417131.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417131", "417131037", "story_v_out_417131.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_26 = math.max(var_153_17, arg_150_1.talkMaxDuration)

			if var_153_16 <= arg_150_1.time_ and arg_150_1.time_ < var_153_16 + var_153_26 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_16) / var_153_26

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_16 + var_153_26 and arg_150_1.time_ < var_153_16 + var_153_26 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417131038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417131038
		arg_154_1.duration_ = 13.87

		local var_154_0 = {
			zh = 13.866,
			ja = 12.566
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417131039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1034"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = var_157_0.localPosition
				var_157_0.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 2)

				local var_157_2 = var_157_0.childCount

				for iter_157_0 = 0, var_157_2 - 1 do
					local var_157_3 = var_157_0:GetChild(iter_157_0)

					if var_157_3.name == "" or not string.find(var_157_3.name, "split") then
						var_157_3.gameObject:SetActive(true)
					else
						var_157_3.gameObject:SetActive(false)
					end
				end
			end

			local var_157_4 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_4 then
				local var_157_5 = (arg_154_1.time_ - var_157_1) / var_157_4
				local var_157_6 = Vector3.New(-390, -331.9, -324)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, var_157_6, var_157_5)
			end

			if arg_154_1.time_ >= var_157_1 + var_157_4 and arg_154_1.time_ < var_157_1 + var_157_4 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_157_7 = 0
			local var_157_8 = 1.55

			if var_157_7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_7 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_9 = arg_154_1:FormatText(StoryNameCfg[1109].name)

				arg_154_1.leftNameTxt_.text = var_157_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_10 = arg_154_1:GetWordFromCfg(417131038)
				local var_157_11 = arg_154_1:FormatText(var_157_10.content)

				arg_154_1.text_.text = var_157_11

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_12 = 62
				local var_157_13 = utf8.len(var_157_11)
				local var_157_14 = var_157_12 <= 0 and var_157_8 or var_157_8 * (var_157_13 / var_157_12)

				if var_157_14 > 0 and var_157_8 < var_157_14 then
					arg_154_1.talkMaxDuration = var_157_14

					if var_157_14 + var_157_7 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_7
					end
				end

				arg_154_1.text_.text = var_157_11
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131038", "story_v_out_417131.awb") ~= 0 then
					local var_157_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131038", "story_v_out_417131.awb") / 1000

					if var_157_15 + var_157_7 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_7
					end

					if var_157_10.prefab_name ~= "" and arg_154_1.actors_[var_157_10.prefab_name] ~= nil then
						local var_157_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_10.prefab_name].transform, "story_v_out_417131", "417131038", "story_v_out_417131.awb")

						arg_154_1:RecordAudio("417131038", var_157_16)
						arg_154_1:RecordAudio("417131038", var_157_16)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417131", "417131038", "story_v_out_417131.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417131", "417131038", "story_v_out_417131.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_17 = math.max(var_157_8, arg_154_1.talkMaxDuration)

			if var_157_7 <= arg_154_1.time_ and arg_154_1.time_ < var_157_7 + var_157_17 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_7) / var_157_17

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_7 + var_157_17 and arg_154_1.time_ < var_157_7 + var_157_17 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play417131039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417131039
		arg_158_1.duration_ = 8.73

		local var_158_0 = {
			zh = 5.766,
			ja = 8.733
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417131040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.725

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[1109].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(417131039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 29
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131039", "story_v_out_417131.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131039", "story_v_out_417131.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_417131", "417131039", "story_v_out_417131.awb")

						arg_158_1:RecordAudio("417131039", var_161_9)
						arg_158_1:RecordAudio("417131039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_417131", "417131039", "story_v_out_417131.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_417131", "417131039", "story_v_out_417131.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417131040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417131040
		arg_162_1.duration_ = 10.87

		local var_162_0 = {
			zh = 6.8,
			ja = 10.866
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417131041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.625

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[1109].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(417131040)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 25
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131040", "story_v_out_417131.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131040", "story_v_out_417131.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_417131", "417131040", "story_v_out_417131.awb")

						arg_162_1:RecordAudio("417131040", var_165_9)
						arg_162_1:RecordAudio("417131040", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417131", "417131040", "story_v_out_417131.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417131", "417131040", "story_v_out_417131.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417131041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417131041
		arg_166_1.duration_ = 6

		local var_166_0 = {
			zh = 6,
			ja = 5.266
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417131042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10115"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10115 == nil then
				arg_166_1.var_.actorSpriteComps10115 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10115 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 1, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10115 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10115 = nil
			end

			local var_169_8 = arg_166_1.actors_["1034"]
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1034 == nil then
				arg_166_1.var_.actorSpriteComps1034 = var_169_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_10 = 0.2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 and not isNil(var_169_8) then
				local var_169_11 = (arg_166_1.time_ - var_169_9) / var_169_10

				if arg_166_1.var_.actorSpriteComps1034 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								local var_169_12 = Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor2.r, var_169_11)
								local var_169_13 = Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor2.g, var_169_11)
								local var_169_14 = Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor2.b, var_169_11)

								iter_169_5.color = Color.New(var_169_12, var_169_13, var_169_14)
							else
								local var_169_15 = Mathf.Lerp(iter_169_5.color.r, 0.5, var_169_11)

								iter_169_5.color = Color.New(var_169_15, var_169_15, var_169_15)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1034 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_169_7 then
						if arg_166_1.isInRecall_ then
							iter_169_7.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1034 = nil
			end

			local var_169_16 = arg_166_1.actors_["10115"].transform
			local var_169_17 = 0

			if var_169_17 < arg_166_1.time_ and arg_166_1.time_ <= var_169_17 + arg_169_0 then
				arg_166_1.var_.moveOldPos10115 = var_169_16.localPosition
				var_169_16.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10115", 4)

				local var_169_18 = var_169_16.childCount

				for iter_169_8 = 0, var_169_18 - 1 do
					local var_169_19 = var_169_16:GetChild(iter_169_8)

					if var_169_19.name == "split_6" or not string.find(var_169_19.name, "split") then
						var_169_19.gameObject:SetActive(true)
					else
						var_169_19.gameObject:SetActive(false)
					end
				end
			end

			local var_169_20 = 0.001

			if var_169_17 <= arg_166_1.time_ and arg_166_1.time_ < var_169_17 + var_169_20 then
				local var_169_21 = (arg_166_1.time_ - var_169_17) / var_169_20
				local var_169_22 = Vector3.New(390, -387.3, -246.2)

				var_169_16.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10115, var_169_22, var_169_21)
			end

			if arg_166_1.time_ >= var_169_17 + var_169_20 and arg_166_1.time_ < var_169_17 + var_169_20 + arg_169_0 then
				var_169_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_169_23 = 0
			local var_169_24 = 0.75

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_25 = arg_166_1:FormatText(StoryNameCfg[1113].name)

				arg_166_1.leftNameTxt_.text = var_169_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_26 = arg_166_1:GetWordFromCfg(417131041)
				local var_169_27 = arg_166_1:FormatText(var_169_26.content)

				arg_166_1.text_.text = var_169_27

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_28 = 30
				local var_169_29 = utf8.len(var_169_27)
				local var_169_30 = var_169_28 <= 0 and var_169_24 or var_169_24 * (var_169_29 / var_169_28)

				if var_169_30 > 0 and var_169_24 < var_169_30 then
					arg_166_1.talkMaxDuration = var_169_30

					if var_169_30 + var_169_23 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_30 + var_169_23
					end
				end

				arg_166_1.text_.text = var_169_27
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131041", "story_v_out_417131.awb") ~= 0 then
					local var_169_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131041", "story_v_out_417131.awb") / 1000

					if var_169_31 + var_169_23 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_31 + var_169_23
					end

					if var_169_26.prefab_name ~= "" and arg_166_1.actors_[var_169_26.prefab_name] ~= nil then
						local var_169_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_26.prefab_name].transform, "story_v_out_417131", "417131041", "story_v_out_417131.awb")

						arg_166_1:RecordAudio("417131041", var_169_32)
						arg_166_1:RecordAudio("417131041", var_169_32)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417131", "417131041", "story_v_out_417131.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417131", "417131041", "story_v_out_417131.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_33 = math.max(var_169_24, arg_166_1.talkMaxDuration)

			if var_169_23 <= arg_166_1.time_ and arg_166_1.time_ < var_169_23 + var_169_33 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_23) / var_169_33

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_23 + var_169_33 and arg_166_1.time_ < var_169_23 + var_169_33 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play417131042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417131042
		arg_170_1.duration_ = 9.9

		local var_170_0 = {
			zh = 9.9,
			ja = 6.133
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417131043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.125

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[1113].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(417131042)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 45
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131042", "story_v_out_417131.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131042", "story_v_out_417131.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_417131", "417131042", "story_v_out_417131.awb")

						arg_170_1:RecordAudio("417131042", var_173_9)
						arg_170_1:RecordAudio("417131042", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417131", "417131042", "story_v_out_417131.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417131", "417131042", "story_v_out_417131.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417131043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417131043
		arg_174_1.duration_ = 11.9

		local var_174_0 = {
			zh = 10.5,
			ja = 11.9
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417131044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10115"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos10115 = var_177_0.localPosition
				var_177_0.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10115", 4)

				local var_177_2 = var_177_0.childCount

				for iter_177_0 = 0, var_177_2 - 1 do
					local var_177_3 = var_177_0:GetChild(iter_177_0)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_4 then
				local var_177_5 = (arg_174_1.time_ - var_177_1) / var_177_4
				local var_177_6 = Vector3.New(390, -387.3, -246.2)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10115, var_177_6, var_177_5)
			end

			if arg_174_1.time_ >= var_177_1 + var_177_4 and arg_174_1.time_ < var_177_1 + var_177_4 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_177_7 = 0
			local var_177_8 = 1.275

			if var_177_7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_9 = arg_174_1:FormatText(StoryNameCfg[1113].name)

				arg_174_1.leftNameTxt_.text = var_177_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(417131043)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 51
				local var_177_13 = utf8.len(var_177_11)
				local var_177_14 = var_177_12 <= 0 and var_177_8 or var_177_8 * (var_177_13 / var_177_12)

				if var_177_14 > 0 and var_177_8 < var_177_14 then
					arg_174_1.talkMaxDuration = var_177_14

					if var_177_14 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_7
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131043", "story_v_out_417131.awb") ~= 0 then
					local var_177_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131043", "story_v_out_417131.awb") / 1000

					if var_177_15 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_7
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_417131", "417131043", "story_v_out_417131.awb")

						arg_174_1:RecordAudio("417131043", var_177_16)
						arg_174_1:RecordAudio("417131043", var_177_16)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417131", "417131043", "story_v_out_417131.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417131", "417131043", "story_v_out_417131.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_17 = math.max(var_177_8, arg_174_1.talkMaxDuration)

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_17 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_7) / var_177_17

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_7 + var_177_17 and arg_174_1.time_ < var_177_7 + var_177_17 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play417131044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417131044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417131045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10115"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10115 == nil then
				arg_178_1.var_.actorSpriteComps10115 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps10115 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor2.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor2.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor2.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 0.5, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10115 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10115 = nil
			end

			local var_181_8 = arg_178_1.actors_["10115"].transform
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.var_.moveOldPos10115 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10115", 7)

				local var_181_10 = var_181_8.childCount

				for iter_181_4 = 0, var_181_10 - 1 do
					local var_181_11 = var_181_8:GetChild(iter_181_4)

					if var_181_11.name == "" or not string.find(var_181_11.name, "split") then
						var_181_11.gameObject:SetActive(true)
					else
						var_181_11.gameObject:SetActive(false)
					end
				end
			end

			local var_181_12 = 0.001

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_12 then
				local var_181_13 = (arg_178_1.time_ - var_181_9) / var_181_12
				local var_181_14 = Vector3.New(0, -2000, 0)

				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10115, var_181_14, var_181_13)
			end

			if arg_178_1.time_ >= var_181_9 + var_181_12 and arg_178_1.time_ < var_181_9 + var_181_12 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_15 = arg_178_1.actors_["1034"].transform
			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.var_.moveOldPos1034 = var_181_15.localPosition
				var_181_15.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1034", 7)

				local var_181_17 = var_181_15.childCount

				for iter_181_5 = 0, var_181_17 - 1 do
					local var_181_18 = var_181_15:GetChild(iter_181_5)

					if var_181_18.name == "" or not string.find(var_181_18.name, "split") then
						var_181_18.gameObject:SetActive(true)
					else
						var_181_18.gameObject:SetActive(false)
					end
				end
			end

			local var_181_19 = 0.001

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_19 then
				local var_181_20 = (arg_178_1.time_ - var_181_16) / var_181_19
				local var_181_21 = Vector3.New(0, -2000, 0)

				var_181_15.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1034, var_181_21, var_181_20)
			end

			if arg_178_1.time_ >= var_181_16 + var_181_19 and arg_178_1.time_ < var_181_16 + var_181_19 + arg_181_0 then
				var_181_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_22 = 0
			local var_181_23 = 1.55

			if var_181_22 < arg_178_1.time_ and arg_178_1.time_ <= var_181_22 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_24 = arg_178_1:GetWordFromCfg(417131044)
				local var_181_25 = arg_178_1:FormatText(var_181_24.content)

				arg_178_1.text_.text = var_181_25

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_26 = 62
				local var_181_27 = utf8.len(var_181_25)
				local var_181_28 = var_181_26 <= 0 and var_181_23 or var_181_23 * (var_181_27 / var_181_26)

				if var_181_28 > 0 and var_181_23 < var_181_28 then
					arg_178_1.talkMaxDuration = var_181_28

					if var_181_28 + var_181_22 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_28 + var_181_22
					end
				end

				arg_178_1.text_.text = var_181_25
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_29 = math.max(var_181_23, arg_178_1.talkMaxDuration)

			if var_181_22 <= arg_178_1.time_ and arg_178_1.time_ < var_181_22 + var_181_29 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_22) / var_181_29

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_22 + var_181_29 and arg_178_1.time_ < var_181_22 + var_181_29 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417131045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417131045
		arg_182_1.duration_ = 15.33

		local var_182_0 = {
			zh = 7.266,
			ja = 15.333
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
				arg_182_0:Play417131046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1034"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1034 == nil then
				arg_182_1.var_.actorSpriteComps1034 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps1034 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1034 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1034 = nil
			end

			local var_185_8 = arg_182_1.actors_["1034"].transform
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 then
				arg_182_1.var_.moveOldPos1034 = var_185_8.localPosition
				var_185_8.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1034", 2)

				local var_185_10 = var_185_8.childCount

				for iter_185_4 = 0, var_185_10 - 1 do
					local var_185_11 = var_185_8:GetChild(iter_185_4)

					if var_185_11.name == "split_6" or not string.find(var_185_11.name, "split") then
						var_185_11.gameObject:SetActive(true)
					else
						var_185_11.gameObject:SetActive(false)
					end
				end
			end

			local var_185_12 = 0.001

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_12 then
				local var_185_13 = (arg_182_1.time_ - var_185_9) / var_185_12
				local var_185_14 = Vector3.New(-390, -331.9, -324)

				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1034, var_185_14, var_185_13)
			end

			if arg_182_1.time_ >= var_185_9 + var_185_12 and arg_182_1.time_ < var_185_9 + var_185_12 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_185_15 = 0
			local var_185_16 = 0.625

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_17 = arg_182_1:FormatText(StoryNameCfg[1109].name)

				arg_182_1.leftNameTxt_.text = var_185_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_18 = arg_182_1:GetWordFromCfg(417131045)
				local var_185_19 = arg_182_1:FormatText(var_185_18.content)

				arg_182_1.text_.text = var_185_19

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_20 = 25
				local var_185_21 = utf8.len(var_185_19)
				local var_185_22 = var_185_20 <= 0 and var_185_16 or var_185_16 * (var_185_21 / var_185_20)

				if var_185_22 > 0 and var_185_16 < var_185_22 then
					arg_182_1.talkMaxDuration = var_185_22

					if var_185_22 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_22 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_19
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131045", "story_v_out_417131.awb") ~= 0 then
					local var_185_23 = manager.audio:GetVoiceLength("story_v_out_417131", "417131045", "story_v_out_417131.awb") / 1000

					if var_185_23 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_15
					end

					if var_185_18.prefab_name ~= "" and arg_182_1.actors_[var_185_18.prefab_name] ~= nil then
						local var_185_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_18.prefab_name].transform, "story_v_out_417131", "417131045", "story_v_out_417131.awb")

						arg_182_1:RecordAudio("417131045", var_185_24)
						arg_182_1:RecordAudio("417131045", var_185_24)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417131", "417131045", "story_v_out_417131.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417131", "417131045", "story_v_out_417131.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_25 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_25 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_25

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_25 and arg_182_1.time_ < var_185_15 + var_185_25 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play417131046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417131046
		arg_186_1.duration_ = 8.6

		local var_186_0 = {
			zh = 4.8,
			ja = 8.6
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play417131047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10115"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10115 == nil then
				arg_186_1.var_.actorSpriteComps10115 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10115 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 1, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10115 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10115 = nil
			end

			local var_189_8 = arg_186_1.actors_["1034"]
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps1034 == nil then
				arg_186_1.var_.actorSpriteComps1034 = var_189_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_10 = 0.2

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 and not isNil(var_189_8) then
				local var_189_11 = (arg_186_1.time_ - var_189_9) / var_189_10

				if arg_186_1.var_.actorSpriteComps1034 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								local var_189_12 = Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, var_189_11)
								local var_189_13 = Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, var_189_11)
								local var_189_14 = Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, var_189_11)

								iter_189_5.color = Color.New(var_189_12, var_189_13, var_189_14)
							else
								local var_189_15 = Mathf.Lerp(iter_189_5.color.r, 0.5, var_189_11)

								iter_189_5.color = Color.New(var_189_15, var_189_15, var_189_15)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps1034 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_189_7 then
						if arg_186_1.isInRecall_ then
							iter_189_7.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1034 = nil
			end

			local var_189_16 = arg_186_1.actors_["10115"].transform
			local var_189_17 = 0

			if var_189_17 < arg_186_1.time_ and arg_186_1.time_ <= var_189_17 + arg_189_0 then
				arg_186_1.var_.moveOldPos10115 = var_189_16.localPosition
				var_189_16.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10115", 4)

				local var_189_18 = var_189_16.childCount

				for iter_189_8 = 0, var_189_18 - 1 do
					local var_189_19 = var_189_16:GetChild(iter_189_8)

					if var_189_19.name == "split_4" or not string.find(var_189_19.name, "split") then
						var_189_19.gameObject:SetActive(true)
					else
						var_189_19.gameObject:SetActive(false)
					end
				end
			end

			local var_189_20 = 0.001

			if var_189_17 <= arg_186_1.time_ and arg_186_1.time_ < var_189_17 + var_189_20 then
				local var_189_21 = (arg_186_1.time_ - var_189_17) / var_189_20
				local var_189_22 = Vector3.New(390, -387.3, -246.2)

				var_189_16.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10115, var_189_22, var_189_21)
			end

			if arg_186_1.time_ >= var_189_17 + var_189_20 and arg_186_1.time_ < var_189_17 + var_189_20 + arg_189_0 then
				var_189_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_189_23 = 0
			local var_189_24 = 0.625

			if var_189_23 < arg_186_1.time_ and arg_186_1.time_ <= var_189_23 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_25 = arg_186_1:FormatText(StoryNameCfg[1113].name)

				arg_186_1.leftNameTxt_.text = var_189_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_26 = arg_186_1:GetWordFromCfg(417131046)
				local var_189_27 = arg_186_1:FormatText(var_189_26.content)

				arg_186_1.text_.text = var_189_27

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_28 = 25
				local var_189_29 = utf8.len(var_189_27)
				local var_189_30 = var_189_28 <= 0 and var_189_24 or var_189_24 * (var_189_29 / var_189_28)

				if var_189_30 > 0 and var_189_24 < var_189_30 then
					arg_186_1.talkMaxDuration = var_189_30

					if var_189_30 + var_189_23 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_30 + var_189_23
					end
				end

				arg_186_1.text_.text = var_189_27
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131046", "story_v_out_417131.awb") ~= 0 then
					local var_189_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131046", "story_v_out_417131.awb") / 1000

					if var_189_31 + var_189_23 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_31 + var_189_23
					end

					if var_189_26.prefab_name ~= "" and arg_186_1.actors_[var_189_26.prefab_name] ~= nil then
						local var_189_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_26.prefab_name].transform, "story_v_out_417131", "417131046", "story_v_out_417131.awb")

						arg_186_1:RecordAudio("417131046", var_189_32)
						arg_186_1:RecordAudio("417131046", var_189_32)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417131", "417131046", "story_v_out_417131.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417131", "417131046", "story_v_out_417131.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_33 = math.max(var_189_24, arg_186_1.talkMaxDuration)

			if var_189_23 <= arg_186_1.time_ and arg_186_1.time_ < var_189_23 + var_189_33 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_23) / var_189_33

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_23 + var_189_33 and arg_186_1.time_ < var_189_23 + var_189_33 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play417131047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417131047
		arg_190_1.duration_ = 15.33

		local var_190_0 = {
			zh = 13.833,
			ja = 15.333
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
				arg_190_0:Play417131048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 1.625

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[1113].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:GetWordFromCfg(417131047)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 65
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131047", "story_v_out_417131.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131047", "story_v_out_417131.awb") / 1000

					if var_193_8 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_0
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_417131", "417131047", "story_v_out_417131.awb")

						arg_190_1:RecordAudio("417131047", var_193_9)
						arg_190_1:RecordAudio("417131047", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_417131", "417131047", "story_v_out_417131.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_417131", "417131047", "story_v_out_417131.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_10 and arg_190_1.time_ < var_193_0 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417131048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417131048
		arg_194_1.duration_ = 14.8

		local var_194_0 = {
			zh = 7.7,
			ja = 14.8
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417131049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1034"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 == nil then
				arg_194_1.var_.actorSpriteComps1034 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps1034 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 1, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps1034 = nil
			end

			local var_197_8 = arg_194_1.actors_["10115"]
			local var_197_9 = 0

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.actorSpriteComps10115 == nil then
				arg_194_1.var_.actorSpriteComps10115 = var_197_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_10 = 0.2

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_10 and not isNil(var_197_8) then
				local var_197_11 = (arg_194_1.time_ - var_197_9) / var_197_10

				if arg_194_1.var_.actorSpriteComps10115 then
					for iter_197_4, iter_197_5 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_197_5 then
							if arg_194_1.isInRecall_ then
								local var_197_12 = Mathf.Lerp(iter_197_5.color.r, arg_194_1.hightColor2.r, var_197_11)
								local var_197_13 = Mathf.Lerp(iter_197_5.color.g, arg_194_1.hightColor2.g, var_197_11)
								local var_197_14 = Mathf.Lerp(iter_197_5.color.b, arg_194_1.hightColor2.b, var_197_11)

								iter_197_5.color = Color.New(var_197_12, var_197_13, var_197_14)
							else
								local var_197_15 = Mathf.Lerp(iter_197_5.color.r, 0.5, var_197_11)

								iter_197_5.color = Color.New(var_197_15, var_197_15, var_197_15)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_9 + var_197_10 and arg_194_1.time_ < var_197_9 + var_197_10 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.actorSpriteComps10115 then
				for iter_197_6, iter_197_7 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_197_7 then
						if arg_194_1.isInRecall_ then
							iter_197_7.color = arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_197_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps10115 = nil
			end

			local var_197_16 = arg_194_1.actors_["1034"].transform
			local var_197_17 = 0

			if var_197_17 < arg_194_1.time_ and arg_194_1.time_ <= var_197_17 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034 = var_197_16.localPosition
				var_197_16.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1034", 2)

				local var_197_18 = var_197_16.childCount

				for iter_197_8 = 0, var_197_18 - 1 do
					local var_197_19 = var_197_16:GetChild(iter_197_8)

					if var_197_19.name == "split_4" or not string.find(var_197_19.name, "split") then
						var_197_19.gameObject:SetActive(true)
					else
						var_197_19.gameObject:SetActive(false)
					end
				end
			end

			local var_197_20 = 0.001

			if var_197_17 <= arg_194_1.time_ and arg_194_1.time_ < var_197_17 + var_197_20 then
				local var_197_21 = (arg_194_1.time_ - var_197_17) / var_197_20
				local var_197_22 = Vector3.New(-390, -331.9, -324)

				var_197_16.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034, var_197_22, var_197_21)
			end

			if arg_194_1.time_ >= var_197_17 + var_197_20 and arg_194_1.time_ < var_197_17 + var_197_20 + arg_197_0 then
				var_197_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_197_23 = 0
			local var_197_24 = 0.825

			if var_197_23 < arg_194_1.time_ and arg_194_1.time_ <= var_197_23 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_25 = arg_194_1:FormatText(StoryNameCfg[1109].name)

				arg_194_1.leftNameTxt_.text = var_197_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_26 = arg_194_1:GetWordFromCfg(417131048)
				local var_197_27 = arg_194_1:FormatText(var_197_26.content)

				arg_194_1.text_.text = var_197_27

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_28 = 33
				local var_197_29 = utf8.len(var_197_27)
				local var_197_30 = var_197_28 <= 0 and var_197_24 or var_197_24 * (var_197_29 / var_197_28)

				if var_197_30 > 0 and var_197_24 < var_197_30 then
					arg_194_1.talkMaxDuration = var_197_30

					if var_197_30 + var_197_23 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_30 + var_197_23
					end
				end

				arg_194_1.text_.text = var_197_27
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131048", "story_v_out_417131.awb") ~= 0 then
					local var_197_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131048", "story_v_out_417131.awb") / 1000

					if var_197_31 + var_197_23 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_31 + var_197_23
					end

					if var_197_26.prefab_name ~= "" and arg_194_1.actors_[var_197_26.prefab_name] ~= nil then
						local var_197_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_26.prefab_name].transform, "story_v_out_417131", "417131048", "story_v_out_417131.awb")

						arg_194_1:RecordAudio("417131048", var_197_32)
						arg_194_1:RecordAudio("417131048", var_197_32)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417131", "417131048", "story_v_out_417131.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417131", "417131048", "story_v_out_417131.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_33 = math.max(var_197_24, arg_194_1.talkMaxDuration)

			if var_197_23 <= arg_194_1.time_ and arg_194_1.time_ < var_197_23 + var_197_33 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_23) / var_197_33

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_23 + var_197_33 and arg_194_1.time_ < var_197_23 + var_197_33 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play417131049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417131049
		arg_198_1.duration_ = 10.23

		local var_198_0 = {
			zh = 10.233,
			ja = 8.333
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417131050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 1.175

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[1109].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:GetWordFromCfg(417131049)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 47
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131049", "story_v_out_417131.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131049", "story_v_out_417131.awb") / 1000

					if var_201_8 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_0
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_417131", "417131049", "story_v_out_417131.awb")

						arg_198_1:RecordAudio("417131049", var_201_9)
						arg_198_1:RecordAudio("417131049", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417131", "417131049", "story_v_out_417131.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417131", "417131049", "story_v_out_417131.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_10 and arg_198_1.time_ < var_201_0 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417131050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417131050
		arg_202_1.duration_ = 5.63

		local var_202_0 = {
			zh = 4.1,
			ja = 5.633
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417131051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10115"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10115 == nil then
				arg_202_1.var_.actorSpriteComps10115 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps10115 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 1, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10115 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10115 = nil
			end

			local var_205_8 = arg_202_1.actors_["1034"]
			local var_205_9 = 0

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 and not isNil(var_205_8) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = var_205_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_10 = 0.2

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_10 and not isNil(var_205_8) then
				local var_205_11 = (arg_202_1.time_ - var_205_9) / var_205_10

				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_5 then
							if arg_202_1.isInRecall_ then
								local var_205_12 = Mathf.Lerp(iter_205_5.color.r, arg_202_1.hightColor2.r, var_205_11)
								local var_205_13 = Mathf.Lerp(iter_205_5.color.g, arg_202_1.hightColor2.g, var_205_11)
								local var_205_14 = Mathf.Lerp(iter_205_5.color.b, arg_202_1.hightColor2.b, var_205_11)

								iter_205_5.color = Color.New(var_205_12, var_205_13, var_205_14)
							else
								local var_205_15 = Mathf.Lerp(iter_205_5.color.r, 0.5, var_205_11)

								iter_205_5.color = Color.New(var_205_15, var_205_15, var_205_15)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_9 + var_205_10 and arg_202_1.time_ < var_205_9 + var_205_10 + arg_205_0 and not isNil(var_205_8) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_7 then
						if arg_202_1.isInRecall_ then
							iter_205_7.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_16 = arg_202_1.actors_["10115"].transform
			local var_205_17 = 0

			if var_205_17 < arg_202_1.time_ and arg_202_1.time_ <= var_205_17 + arg_205_0 then
				arg_202_1.var_.moveOldPos10115 = var_205_16.localPosition
				var_205_16.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10115", 4)

				local var_205_18 = var_205_16.childCount

				for iter_205_8 = 0, var_205_18 - 1 do
					local var_205_19 = var_205_16:GetChild(iter_205_8)

					if var_205_19.name == "split_4" or not string.find(var_205_19.name, "split") then
						var_205_19.gameObject:SetActive(true)
					else
						var_205_19.gameObject:SetActive(false)
					end
				end
			end

			local var_205_20 = 0.001

			if var_205_17 <= arg_202_1.time_ and arg_202_1.time_ < var_205_17 + var_205_20 then
				local var_205_21 = (arg_202_1.time_ - var_205_17) / var_205_20
				local var_205_22 = Vector3.New(390, -387.3, -246.2)

				var_205_16.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10115, var_205_22, var_205_21)
			end

			if arg_202_1.time_ >= var_205_17 + var_205_20 and arg_202_1.time_ < var_205_17 + var_205_20 + arg_205_0 then
				var_205_16.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_205_23 = 0
			local var_205_24 = 0.5

			if var_205_23 < arg_202_1.time_ and arg_202_1.time_ <= var_205_23 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_25 = arg_202_1:FormatText(StoryNameCfg[1113].name)

				arg_202_1.leftNameTxt_.text = var_205_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_26 = arg_202_1:GetWordFromCfg(417131050)
				local var_205_27 = arg_202_1:FormatText(var_205_26.content)

				arg_202_1.text_.text = var_205_27

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_28 = 20
				local var_205_29 = utf8.len(var_205_27)
				local var_205_30 = var_205_28 <= 0 and var_205_24 or var_205_24 * (var_205_29 / var_205_28)

				if var_205_30 > 0 and var_205_24 < var_205_30 then
					arg_202_1.talkMaxDuration = var_205_30

					if var_205_30 + var_205_23 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_30 + var_205_23
					end
				end

				arg_202_1.text_.text = var_205_27
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131050", "story_v_out_417131.awb") ~= 0 then
					local var_205_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131050", "story_v_out_417131.awb") / 1000

					if var_205_31 + var_205_23 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_31 + var_205_23
					end

					if var_205_26.prefab_name ~= "" and arg_202_1.actors_[var_205_26.prefab_name] ~= nil then
						local var_205_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_26.prefab_name].transform, "story_v_out_417131", "417131050", "story_v_out_417131.awb")

						arg_202_1:RecordAudio("417131050", var_205_32)
						arg_202_1:RecordAudio("417131050", var_205_32)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417131", "417131050", "story_v_out_417131.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417131", "417131050", "story_v_out_417131.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_33 = math.max(var_205_24, arg_202_1.talkMaxDuration)

			if var_205_23 <= arg_202_1.time_ and arg_202_1.time_ < var_205_23 + var_205_33 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_23) / var_205_33

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_23 + var_205_33 and arg_202_1.time_ < var_205_23 + var_205_33 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play417131051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417131051
		arg_206_1.duration_ = 12.53

		local var_206_0 = {
			zh = 11.9,
			ja = 12.533
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417131052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1034"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_8 = arg_206_1.actors_["10115"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps10115 == nil then
				arg_206_1.var_.actorSpriteComps10115 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps10115 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps10115 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10115 = nil
			end

			local var_209_16 = arg_206_1.actors_["1034"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 2)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "split_3" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(-390, -331.9, -324)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_209_23 = 0
			local var_209_24 = 1.175

			if var_209_23 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_25 = arg_206_1:FormatText(StoryNameCfg[1109].name)

				arg_206_1.leftNameTxt_.text = var_209_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_26 = arg_206_1:GetWordFromCfg(417131051)
				local var_209_27 = arg_206_1:FormatText(var_209_26.content)

				arg_206_1.text_.text = var_209_27

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_28 = 47
				local var_209_29 = utf8.len(var_209_27)
				local var_209_30 = var_209_28 <= 0 and var_209_24 or var_209_24 * (var_209_29 / var_209_28)

				if var_209_30 > 0 and var_209_24 < var_209_30 then
					arg_206_1.talkMaxDuration = var_209_30

					if var_209_30 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_30 + var_209_23
					end
				end

				arg_206_1.text_.text = var_209_27
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131051", "story_v_out_417131.awb") ~= 0 then
					local var_209_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131051", "story_v_out_417131.awb") / 1000

					if var_209_31 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_31 + var_209_23
					end

					if var_209_26.prefab_name ~= "" and arg_206_1.actors_[var_209_26.prefab_name] ~= nil then
						local var_209_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_26.prefab_name].transform, "story_v_out_417131", "417131051", "story_v_out_417131.awb")

						arg_206_1:RecordAudio("417131051", var_209_32)
						arg_206_1:RecordAudio("417131051", var_209_32)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417131", "417131051", "story_v_out_417131.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417131", "417131051", "story_v_out_417131.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_33 = math.max(var_209_24, arg_206_1.talkMaxDuration)

			if var_209_23 <= arg_206_1.time_ and arg_206_1.time_ < var_209_23 + var_209_33 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_23) / var_209_33

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_23 + var_209_33 and arg_206_1.time_ < var_209_23 + var_209_33 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play417131052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417131052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417131053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1034"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_8 = arg_210_1.actors_["10115"].transform
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1.var_.moveOldPos10115 = var_213_8.localPosition
				var_213_8.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10115", 7)

				local var_213_10 = var_213_8.childCount

				for iter_213_4 = 0, var_213_10 - 1 do
					local var_213_11 = var_213_8:GetChild(iter_213_4)

					if var_213_11.name == "" or not string.find(var_213_11.name, "split") then
						var_213_11.gameObject:SetActive(true)
					else
						var_213_11.gameObject:SetActive(false)
					end
				end
			end

			local var_213_12 = 0.001

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_12 then
				local var_213_13 = (arg_210_1.time_ - var_213_9) / var_213_12
				local var_213_14 = Vector3.New(0, -2000, 0)

				var_213_8.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10115, var_213_14, var_213_13)
			end

			if arg_210_1.time_ >= var_213_9 + var_213_12 and arg_210_1.time_ < var_213_9 + var_213_12 + arg_213_0 then
				var_213_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_15 = arg_210_1.actors_["1034"].transform
			local var_213_16 = 0

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.var_.moveOldPos1034 = var_213_15.localPosition
				var_213_15.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1034", 7)

				local var_213_17 = var_213_15.childCount

				for iter_213_5 = 0, var_213_17 - 1 do
					local var_213_18 = var_213_15:GetChild(iter_213_5)

					if var_213_18.name == "" or not string.find(var_213_18.name, "split") then
						var_213_18.gameObject:SetActive(true)
					else
						var_213_18.gameObject:SetActive(false)
					end
				end
			end

			local var_213_19 = 0.001

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_19 then
				local var_213_20 = (arg_210_1.time_ - var_213_16) / var_213_19
				local var_213_21 = Vector3.New(0, -2000, 0)

				var_213_15.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1034, var_213_21, var_213_20)
			end

			if arg_210_1.time_ >= var_213_16 + var_213_19 and arg_210_1.time_ < var_213_16 + var_213_19 + arg_213_0 then
				var_213_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_22 = 0
			local var_213_23 = 1.325

			if var_213_22 < arg_210_1.time_ and arg_210_1.time_ <= var_213_22 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_24 = arg_210_1:GetWordFromCfg(417131052)
				local var_213_25 = arg_210_1:FormatText(var_213_24.content)

				arg_210_1.text_.text = var_213_25

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_26 = 53
				local var_213_27 = utf8.len(var_213_25)
				local var_213_28 = var_213_26 <= 0 and var_213_23 or var_213_23 * (var_213_27 / var_213_26)

				if var_213_28 > 0 and var_213_23 < var_213_28 then
					arg_210_1.talkMaxDuration = var_213_28

					if var_213_28 + var_213_22 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_28 + var_213_22
					end
				end

				arg_210_1.text_.text = var_213_25
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_29 = math.max(var_213_23, arg_210_1.talkMaxDuration)

			if var_213_22 <= arg_210_1.time_ and arg_210_1.time_ < var_213_22 + var_213_29 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_22) / var_213_29

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_22 + var_213_29 and arg_210_1.time_ < var_213_22 + var_213_29 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play417131053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417131053
		arg_214_1.duration_ = 5.17

		local var_214_0 = {
			zh = 2.4,
			ja = 5.166
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417131054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.25

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1113].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_4")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(417131053)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 10
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131053", "story_v_out_417131.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131053", "story_v_out_417131.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_417131", "417131053", "story_v_out_417131.awb")

						arg_214_1:RecordAudio("417131053", var_217_9)
						arg_214_1:RecordAudio("417131053", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417131", "417131053", "story_v_out_417131.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417131", "417131053", "story_v_out_417131.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417131054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417131054
		arg_218_1.duration_ = 4.4

		local var_218_0 = {
			zh = 3.266,
			ja = 4.4
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417131055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1034"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1034 == nil then
				arg_218_1.var_.actorSpriteComps1034 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps1034 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 1, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1034 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps1034 = nil
			end

			local var_221_8 = arg_218_1.actors_["10115"]
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10115 == nil then
				arg_218_1.var_.actorSpriteComps10115 = var_221_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_10 = 0.2

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_10 and not isNil(var_221_8) then
				local var_221_11 = (arg_218_1.time_ - var_221_9) / var_221_10

				if arg_218_1.var_.actorSpriteComps10115 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								local var_221_12 = Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, var_221_11)
								local var_221_13 = Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, var_221_11)
								local var_221_14 = Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, var_221_11)

								iter_221_5.color = Color.New(var_221_12, var_221_13, var_221_14)
							else
								local var_221_15 = Mathf.Lerp(iter_221_5.color.r, 0.5, var_221_11)

								iter_221_5.color = Color.New(var_221_15, var_221_15, var_221_15)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_9 + var_221_10 and arg_218_1.time_ < var_221_9 + var_221_10 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10115 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_221_7 then
						if arg_218_1.isInRecall_ then
							iter_221_7.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10115 = nil
			end

			local var_221_16 = arg_218_1.actors_["1034"].transform
			local var_221_17 = 0

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				arg_218_1.var_.moveOldPos1034 = var_221_16.localPosition
				var_221_16.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1034", 3)

				local var_221_18 = var_221_16.childCount

				for iter_221_8 = 0, var_221_18 - 1 do
					local var_221_19 = var_221_16:GetChild(iter_221_8)

					if var_221_19.name == "split_6" or not string.find(var_221_19.name, "split") then
						var_221_19.gameObject:SetActive(true)
					else
						var_221_19.gameObject:SetActive(false)
					end
				end
			end

			local var_221_20 = 0.001

			if var_221_17 <= arg_218_1.time_ and arg_218_1.time_ < var_221_17 + var_221_20 then
				local var_221_21 = (arg_218_1.time_ - var_221_17) / var_221_20
				local var_221_22 = Vector3.New(0, -331.9, -324)

				var_221_16.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1034, var_221_22, var_221_21)
			end

			if arg_218_1.time_ >= var_221_17 + var_221_20 and arg_218_1.time_ < var_221_17 + var_221_20 + arg_221_0 then
				var_221_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_221_23 = 0
			local var_221_24 = 0.35

			if var_221_23 < arg_218_1.time_ and arg_218_1.time_ <= var_221_23 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_25 = arg_218_1:FormatText(StoryNameCfg[1109].name)

				arg_218_1.leftNameTxt_.text = var_221_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_26 = arg_218_1:GetWordFromCfg(417131054)
				local var_221_27 = arg_218_1:FormatText(var_221_26.content)

				arg_218_1.text_.text = var_221_27

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_28 = 14
				local var_221_29 = utf8.len(var_221_27)
				local var_221_30 = var_221_28 <= 0 and var_221_24 or var_221_24 * (var_221_29 / var_221_28)

				if var_221_30 > 0 and var_221_24 < var_221_30 then
					arg_218_1.talkMaxDuration = var_221_30

					if var_221_30 + var_221_23 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_30 + var_221_23
					end
				end

				arg_218_1.text_.text = var_221_27
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131054", "story_v_out_417131.awb") ~= 0 then
					local var_221_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131054", "story_v_out_417131.awb") / 1000

					if var_221_31 + var_221_23 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_31 + var_221_23
					end

					if var_221_26.prefab_name ~= "" and arg_218_1.actors_[var_221_26.prefab_name] ~= nil then
						local var_221_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_26.prefab_name].transform, "story_v_out_417131", "417131054", "story_v_out_417131.awb")

						arg_218_1:RecordAudio("417131054", var_221_32)
						arg_218_1:RecordAudio("417131054", var_221_32)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417131", "417131054", "story_v_out_417131.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417131", "417131054", "story_v_out_417131.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_33 = math.max(var_221_24, arg_218_1.talkMaxDuration)

			if var_221_23 <= arg_218_1.time_ and arg_218_1.time_ < var_221_23 + var_221_33 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_23) / var_221_33

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_23 + var_221_33 and arg_218_1.time_ < var_221_23 + var_221_33 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play417131055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417131055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417131056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1034"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1034 == nil then
				arg_222_1.var_.actorSpriteComps1034 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1034 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 0.5, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1034 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1034 = nil
			end

			local var_225_8 = arg_222_1.actors_["1034"].transform
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.var_.moveOldPos1034 = var_225_8.localPosition
				var_225_8.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1034", 7)

				local var_225_10 = var_225_8.childCount

				for iter_225_4 = 0, var_225_10 - 1 do
					local var_225_11 = var_225_8:GetChild(iter_225_4)

					if var_225_11.name == "" or not string.find(var_225_11.name, "split") then
						var_225_11.gameObject:SetActive(true)
					else
						var_225_11.gameObject:SetActive(false)
					end
				end
			end

			local var_225_12 = 0.001

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_12 then
				local var_225_13 = (arg_222_1.time_ - var_225_9) / var_225_12
				local var_225_14 = Vector3.New(0, -2000, 0)

				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1034, var_225_14, var_225_13)
			end

			if arg_222_1.time_ >= var_225_9 + var_225_12 and arg_222_1.time_ < var_225_9 + var_225_12 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_225_15 = arg_222_1.actors_["10115"].transform
			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.var_.moveOldPos10115 = var_225_15.localPosition
				var_225_15.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10115", 7)

				local var_225_17 = var_225_15.childCount

				for iter_225_5 = 0, var_225_17 - 1 do
					local var_225_18 = var_225_15:GetChild(iter_225_5)

					if var_225_18.name == "" or not string.find(var_225_18.name, "split") then
						var_225_18.gameObject:SetActive(true)
					else
						var_225_18.gameObject:SetActive(false)
					end
				end
			end

			local var_225_19 = 0.001

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_19 then
				local var_225_20 = (arg_222_1.time_ - var_225_16) / var_225_19
				local var_225_21 = Vector3.New(0, -2000, 0)

				var_225_15.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10115, var_225_21, var_225_20)
			end

			if arg_222_1.time_ >= var_225_16 + var_225_19 and arg_222_1.time_ < var_225_16 + var_225_19 + arg_225_0 then
				var_225_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_225_22 = 1
			local var_225_23 = 1

			if var_225_22 < arg_222_1.time_ and arg_222_1.time_ <= var_225_22 + arg_225_0 then
				local var_225_24 = "play"
				local var_225_25 = "effect"

				arg_222_1:AudioAction(var_225_24, var_225_25, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_225_26 = 0
			local var_225_27 = 1.1

			if var_225_26 < arg_222_1.time_ and arg_222_1.time_ <= var_225_26 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_28 = arg_222_1:GetWordFromCfg(417131055)
				local var_225_29 = arg_222_1:FormatText(var_225_28.content)

				arg_222_1.text_.text = var_225_29

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_30 = 44
				local var_225_31 = utf8.len(var_225_29)
				local var_225_32 = var_225_30 <= 0 and var_225_27 or var_225_27 * (var_225_31 / var_225_30)

				if var_225_32 > 0 and var_225_27 < var_225_32 then
					arg_222_1.talkMaxDuration = var_225_32

					if var_225_32 + var_225_26 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_32 + var_225_26
					end
				end

				arg_222_1.text_.text = var_225_29
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_33 = math.max(var_225_27, arg_222_1.talkMaxDuration)

			if var_225_26 <= arg_222_1.time_ and arg_222_1.time_ < var_225_26 + var_225_33 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_26) / var_225_33

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_26 + var_225_33 and arg_222_1.time_ < var_225_26 + var_225_33 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play417131056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417131056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417131057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.65

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(417131056)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 26
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417131057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417131057
		arg_230_1.duration_ = 8.97

		local var_230_0 = {
			zh = 8.36666666666667,
			ja = 8.96666666666667
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417131058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = "B02f"

			if arg_230_1.bgs_[var_233_0] == nil then
				local var_233_1 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_233_0)
				var_233_1.name = var_233_0
				var_233_1.transform.parent = arg_230_1.stage_.transform
				var_233_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_[var_233_0] = var_233_1
			end

			local var_233_2 = 1.66666666666667

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				local var_233_3 = manager.ui.mainCamera.transform.localPosition
				local var_233_4 = Vector3.New(0, 0, 10) + Vector3.New(var_233_3.x, var_233_3.y, 0)
				local var_233_5 = arg_230_1.bgs_.B02f

				var_233_5.transform.localPosition = var_233_4
				var_233_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_6 = var_233_5:GetComponent("SpriteRenderer")

				if var_233_6 and var_233_6.sprite then
					local var_233_7 = (var_233_5.transform.localPosition - var_233_3).z
					local var_233_8 = manager.ui.mainCameraCom_
					local var_233_9 = 2 * var_233_7 * Mathf.Tan(var_233_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_10 = var_233_9 * var_233_8.aspect
					local var_233_11 = var_233_6.sprite.bounds.size.x
					local var_233_12 = var_233_6.sprite.bounds.size.y
					local var_233_13 = var_233_10 / var_233_11
					local var_233_14 = var_233_9 / var_233_12
					local var_233_15 = var_233_14 < var_233_13 and var_233_13 or var_233_14

					var_233_5.transform.localScale = Vector3.New(var_233_15, var_233_15, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "B02f" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_17 = 0.3

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_18 = 0

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_19 = 1.66666666666667

			if var_233_18 <= arg_230_1.time_ and arg_230_1.time_ < var_233_18 + var_233_19 then
				local var_233_20 = (arg_230_1.time_ - var_233_18) / var_233_19
				local var_233_21 = Color.New(0, 0, 0)

				var_233_21.a = Mathf.Lerp(0, 1, var_233_20)
				arg_230_1.mask_.color = var_233_21
			end

			if arg_230_1.time_ >= var_233_18 + var_233_19 and arg_230_1.time_ < var_233_18 + var_233_19 + arg_233_0 then
				local var_233_22 = Color.New(0, 0, 0)

				var_233_22.a = 1
				arg_230_1.mask_.color = var_233_22
			end

			local var_233_23 = 1.66666666666667

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_24 = 2

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_24 then
				local var_233_25 = (arg_230_1.time_ - var_233_23) / var_233_24
				local var_233_26 = Color.New(0, 0, 0)

				var_233_26.a = Mathf.Lerp(1, 0, var_233_25)
				arg_230_1.mask_.color = var_233_26
			end

			if arg_230_1.time_ >= var_233_23 + var_233_24 and arg_230_1.time_ < var_233_23 + var_233_24 + arg_233_0 then
				local var_233_27 = Color.New(0, 0, 0)
				local var_233_28 = 0

				arg_230_1.mask_.enabled = false
				var_233_27.a = var_233_28
				arg_230_1.mask_.color = var_233_27
			end

			local var_233_29 = manager.ui.mainCamera.transform
			local var_233_30 = 1.66666666666667

			if var_233_30 < arg_230_1.time_ and arg_230_1.time_ <= var_233_30 + arg_233_0 then
				local var_233_31 = arg_230_1.var_.effect809

				if var_233_31 then
					Object.Destroy(var_233_31)

					arg_230_1.var_.effect809 = nil
				end
			end

			local var_233_32 = 1.66666666666667

			arg_230_1.isInRecall_ = true

			if var_233_32 < arg_230_1.time_ and arg_230_1.time_ <= var_233_32 + arg_233_0 then
				arg_230_1.screenFilterGo_:SetActive(true)

				arg_230_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_230_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_230_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_233_2, iter_233_3 in pairs(arg_230_1.actors_) do
					local var_233_33 = iter_233_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_233_4, iter_233_5 in ipairs(var_233_33) do
						if iter_233_5.color.r > 0.51 then
							iter_233_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_233_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_233_34 = 0.0166666666666667

			if var_233_32 <= arg_230_1.time_ and arg_230_1.time_ < var_233_32 + var_233_34 then
				local var_233_35 = (arg_230_1.time_ - var_233_32) / var_233_34

				arg_230_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_233_35)
			end

			if arg_230_1.time_ >= var_233_32 + var_233_34 and arg_230_1.time_ < var_233_32 + var_233_34 + arg_233_0 then
				arg_230_1.screenFilterEffect_.weight = 1
			end

			local var_233_36 = 0.3
			local var_233_37 = 1

			if var_233_36 < arg_230_1.time_ and arg_230_1.time_ <= var_233_36 + arg_233_0 then
				local var_233_38 = "stop"
				local var_233_39 = "effect"

				arg_230_1:AudioAction(var_233_38, var_233_39, "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_40 = 3.16666666666667
			local var_233_41 = 0.4

			if var_233_40 < arg_230_1.time_ and arg_230_1.time_ <= var_233_40 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_42 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_42:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_43 = arg_230_1:FormatText(StoryNameCfg[672].name)

				arg_230_1.leftNameTxt_.text = var_233_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_44 = arg_230_1:GetWordFromCfg(417131057)
				local var_233_45 = arg_230_1:FormatText(var_233_44.content)

				arg_230_1.text_.text = var_233_45

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_46 = 16
				local var_233_47 = utf8.len(var_233_45)
				local var_233_48 = var_233_46 <= 0 and var_233_41 or var_233_41 * (var_233_47 / var_233_46)

				if var_233_48 > 0 and var_233_41 < var_233_48 then
					arg_230_1.talkMaxDuration = var_233_48
					var_233_40 = var_233_40 + 0.3

					if var_233_48 + var_233_40 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_48 + var_233_40
					end
				end

				arg_230_1.text_.text = var_233_45
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131057", "story_v_out_417131.awb") ~= 0 then
					local var_233_49 = manager.audio:GetVoiceLength("story_v_out_417131", "417131057", "story_v_out_417131.awb") / 1000

					if var_233_49 + var_233_40 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_49 + var_233_40
					end

					if var_233_44.prefab_name ~= "" and arg_230_1.actors_[var_233_44.prefab_name] ~= nil then
						local var_233_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_44.prefab_name].transform, "story_v_out_417131", "417131057", "story_v_out_417131.awb")

						arg_230_1:RecordAudio("417131057", var_233_50)
						arg_230_1:RecordAudio("417131057", var_233_50)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417131", "417131057", "story_v_out_417131.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417131", "417131057", "story_v_out_417131.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_51 = var_233_40 + 0.3
			local var_233_52 = math.max(var_233_41, arg_230_1.talkMaxDuration)

			if var_233_51 <= arg_230_1.time_ and arg_230_1.time_ < var_233_51 + var_233_52 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_51) / var_233_52

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_51 + var_233_52 and arg_230_1.time_ < var_233_51 + var_233_52 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417131058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417131058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417131059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.1
			local var_239_1 = 1

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				local var_239_2 = "play"
				local var_239_3 = "effect"

				arg_236_1:AudioAction(var_239_2, var_239_3, "se_story_130", "se_story_130__holographic", "")
			end

			local var_239_4 = 0
			local var_239_5 = 1.4

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(417131058)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_8 = 56
				local var_239_9 = utf8.len(var_239_7)
				local var_239_10 = var_239_8 <= 0 and var_239_5 or var_239_5 * (var_239_9 / var_239_8)

				if var_239_10 > 0 and var_239_5 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_11 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_11 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_11

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_11 and arg_236_1.time_ < var_239_4 + var_239_11 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417131059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417131059
		arg_240_1.duration_ = 1.57

		local var_240_0 = {
			zh = 1.233,
			ja = 1.566
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
				arg_240_0:Play417131060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10115"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10115 == nil then
				arg_240_1.var_.actorSpriteComps10115 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps10115 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10115 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_243_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10115 = nil
			end

			local var_243_8 = arg_240_1.actors_["10115"].transform
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.var_.moveOldPos10115 = var_243_8.localPosition
				var_243_8.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10115", 4)

				local var_243_10 = var_243_8.childCount

				for iter_243_4 = 0, var_243_10 - 1 do
					local var_243_11 = var_243_8:GetChild(iter_243_4)

					if var_243_11.name == "" or not string.find(var_243_11.name, "split") then
						var_243_11.gameObject:SetActive(true)
					else
						var_243_11.gameObject:SetActive(false)
					end
				end
			end

			local var_243_12 = 0.001

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_12 then
				local var_243_13 = (arg_240_1.time_ - var_243_9) / var_243_12
				local var_243_14 = Vector3.New(390, -387.3, -246.2)

				var_243_8.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10115, var_243_14, var_243_13)
			end

			if arg_240_1.time_ >= var_243_9 + var_243_12 and arg_240_1.time_ < var_243_9 + var_243_12 + arg_243_0 then
				var_243_8.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_243_15 = 0
			local var_243_16 = 0.1

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_17 = arg_240_1:FormatText(StoryNameCfg[1113].name)

				arg_240_1.leftNameTxt_.text = var_243_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_18 = arg_240_1:GetWordFromCfg(417131059)
				local var_243_19 = arg_240_1:FormatText(var_243_18.content)

				arg_240_1.text_.text = var_243_19

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_20 = 4
				local var_243_21 = utf8.len(var_243_19)
				local var_243_22 = var_243_20 <= 0 and var_243_16 or var_243_16 * (var_243_21 / var_243_20)

				if var_243_22 > 0 and var_243_16 < var_243_22 then
					arg_240_1.talkMaxDuration = var_243_22

					if var_243_22 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_22 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_19
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131059", "story_v_out_417131.awb") ~= 0 then
					local var_243_23 = manager.audio:GetVoiceLength("story_v_out_417131", "417131059", "story_v_out_417131.awb") / 1000

					if var_243_23 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_15
					end

					if var_243_18.prefab_name ~= "" and arg_240_1.actors_[var_243_18.prefab_name] ~= nil then
						local var_243_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_18.prefab_name].transform, "story_v_out_417131", "417131059", "story_v_out_417131.awb")

						arg_240_1:RecordAudio("417131059", var_243_24)
						arg_240_1:RecordAudio("417131059", var_243_24)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417131", "417131059", "story_v_out_417131.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417131", "417131059", "story_v_out_417131.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_25 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_25 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_25

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_25 and arg_240_1.time_ < var_243_15 + var_243_25 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417131060
		arg_244_1.duration_ = 4.53

		local var_244_0 = {
			zh = 1.4,
			ja = 4.533
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
				arg_244_0:Play417131061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1034"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1034 == nil then
				arg_244_1.var_.actorSpriteComps1034 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps1034 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1034 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1034 = nil
			end

			local var_247_8 = arg_244_1.actors_["10115"]
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps10115 == nil then
				arg_244_1.var_.actorSpriteComps10115 = var_247_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_10 = 0.2

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 and not isNil(var_247_8) then
				local var_247_11 = (arg_244_1.time_ - var_247_9) / var_247_10

				if arg_244_1.var_.actorSpriteComps10115 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps10115 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_247_7 then
						if arg_244_1.isInRecall_ then
							iter_247_7.color = arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_247_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10115 = nil
			end

			local var_247_16 = arg_244_1.actors_["1034"].transform
			local var_247_17 = 0

			if var_247_17 < arg_244_1.time_ and arg_244_1.time_ <= var_247_17 + arg_247_0 then
				arg_244_1.var_.moveOldPos1034 = var_247_16.localPosition
				var_247_16.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1034", 2)

				local var_247_18 = var_247_16.childCount

				for iter_247_8 = 0, var_247_18 - 1 do
					local var_247_19 = var_247_16:GetChild(iter_247_8)

					if var_247_19.name == "" or not string.find(var_247_19.name, "split") then
						var_247_19.gameObject:SetActive(true)
					else
						var_247_19.gameObject:SetActive(false)
					end
				end
			end

			local var_247_20 = 0.001

			if var_247_17 <= arg_244_1.time_ and arg_244_1.time_ < var_247_17 + var_247_20 then
				local var_247_21 = (arg_244_1.time_ - var_247_17) / var_247_20
				local var_247_22 = Vector3.New(-390, -331.9, -324)

				var_247_16.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1034, var_247_22, var_247_21)
			end

			if arg_244_1.time_ >= var_247_17 + var_247_20 and arg_244_1.time_ < var_247_17 + var_247_20 + arg_247_0 then
				var_247_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_247_23 = 0
			local var_247_24 = 0.175

			if var_247_23 < arg_244_1.time_ and arg_244_1.time_ <= var_247_23 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_25 = arg_244_1:FormatText(StoryNameCfg[1109].name)

				arg_244_1.leftNameTxt_.text = var_247_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_26 = arg_244_1:GetWordFromCfg(417131060)
				local var_247_27 = arg_244_1:FormatText(var_247_26.content)

				arg_244_1.text_.text = var_247_27

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_28 = 7
				local var_247_29 = utf8.len(var_247_27)
				local var_247_30 = var_247_28 <= 0 and var_247_24 or var_247_24 * (var_247_29 / var_247_28)

				if var_247_30 > 0 and var_247_24 < var_247_30 then
					arg_244_1.talkMaxDuration = var_247_30

					if var_247_30 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_30 + var_247_23
					end
				end

				arg_244_1.text_.text = var_247_27
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131060", "story_v_out_417131.awb") ~= 0 then
					local var_247_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131060", "story_v_out_417131.awb") / 1000

					if var_247_31 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_31 + var_247_23
					end

					if var_247_26.prefab_name ~= "" and arg_244_1.actors_[var_247_26.prefab_name] ~= nil then
						local var_247_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_26.prefab_name].transform, "story_v_out_417131", "417131060", "story_v_out_417131.awb")

						arg_244_1:RecordAudio("417131060", var_247_32)
						arg_244_1:RecordAudio("417131060", var_247_32)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417131", "417131060", "story_v_out_417131.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417131", "417131060", "story_v_out_417131.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_33 = math.max(var_247_24, arg_244_1.talkMaxDuration)

			if var_247_23 <= arg_244_1.time_ and arg_244_1.time_ < var_247_23 + var_247_33 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_23) / var_247_33

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_23 + var_247_33 and arg_244_1.time_ < var_247_23 + var_247_33 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play417131061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417131061
		arg_248_1.duration_ = 7

		local var_248_0 = {
			zh = 3.866,
			ja = 7
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
				arg_248_0:Play417131062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10115"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10115 == nil then
				arg_248_1.var_.actorSpriteComps10115 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps10115 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 1, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10115 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_251_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps10115 = nil
			end

			local var_251_8 = arg_248_1.actors_["1034"]
			local var_251_9 = 0

			if var_251_9 < arg_248_1.time_ and arg_248_1.time_ <= var_251_9 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1034 == nil then
				arg_248_1.var_.actorSpriteComps1034 = var_251_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_10 = 0.2

			if var_251_9 <= arg_248_1.time_ and arg_248_1.time_ < var_251_9 + var_251_10 and not isNil(var_251_8) then
				local var_251_11 = (arg_248_1.time_ - var_251_9) / var_251_10

				if arg_248_1.var_.actorSpriteComps1034 then
					for iter_251_4, iter_251_5 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_251_5 then
							if arg_248_1.isInRecall_ then
								local var_251_12 = Mathf.Lerp(iter_251_5.color.r, arg_248_1.hightColor2.r, var_251_11)
								local var_251_13 = Mathf.Lerp(iter_251_5.color.g, arg_248_1.hightColor2.g, var_251_11)
								local var_251_14 = Mathf.Lerp(iter_251_5.color.b, arg_248_1.hightColor2.b, var_251_11)

								iter_251_5.color = Color.New(var_251_12, var_251_13, var_251_14)
							else
								local var_251_15 = Mathf.Lerp(iter_251_5.color.r, 0.5, var_251_11)

								iter_251_5.color = Color.New(var_251_15, var_251_15, var_251_15)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_9 + var_251_10 and arg_248_1.time_ < var_251_9 + var_251_10 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1034 then
				for iter_251_6, iter_251_7 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_251_7 then
						if arg_248_1.isInRecall_ then
							iter_251_7.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1034 = nil
			end

			local var_251_16 = 0
			local var_251_17 = 0.4

			if var_251_16 < arg_248_1.time_ and arg_248_1.time_ <= var_251_16 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_18 = arg_248_1:FormatText(StoryNameCfg[1113].name)

				arg_248_1.leftNameTxt_.text = var_251_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_19 = arg_248_1:GetWordFromCfg(417131061)
				local var_251_20 = arg_248_1:FormatText(var_251_19.content)

				arg_248_1.text_.text = var_251_20

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_21 = 16
				local var_251_22 = utf8.len(var_251_20)
				local var_251_23 = var_251_21 <= 0 and var_251_17 or var_251_17 * (var_251_22 / var_251_21)

				if var_251_23 > 0 and var_251_17 < var_251_23 then
					arg_248_1.talkMaxDuration = var_251_23

					if var_251_23 + var_251_16 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_23 + var_251_16
					end
				end

				arg_248_1.text_.text = var_251_20
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131061", "story_v_out_417131.awb") ~= 0 then
					local var_251_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131061", "story_v_out_417131.awb") / 1000

					if var_251_24 + var_251_16 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_24 + var_251_16
					end

					if var_251_19.prefab_name ~= "" and arg_248_1.actors_[var_251_19.prefab_name] ~= nil then
						local var_251_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_19.prefab_name].transform, "story_v_out_417131", "417131061", "story_v_out_417131.awb")

						arg_248_1:RecordAudio("417131061", var_251_25)
						arg_248_1:RecordAudio("417131061", var_251_25)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417131", "417131061", "story_v_out_417131.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417131", "417131061", "story_v_out_417131.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_26 = math.max(var_251_17, arg_248_1.talkMaxDuration)

			if var_251_16 <= arg_248_1.time_ and arg_248_1.time_ < var_251_16 + var_251_26 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_16) / var_251_26

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_16 + var_251_26 and arg_248_1.time_ < var_251_16 + var_251_26 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417131062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417131062
		arg_252_1.duration_ = 6.2

		local var_252_0 = {
			zh = 5.166,
			ja = 6.2
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
				arg_252_0:Play417131063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1034"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1034 == nil then
				arg_252_1.var_.actorSpriteComps1034 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps1034 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1034 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps1034 = nil
			end

			local var_255_8 = arg_252_1.actors_["10115"]
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10115 == nil then
				arg_252_1.var_.actorSpriteComps10115 = var_255_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_10 = 0.2

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 and not isNil(var_255_8) then
				local var_255_11 = (arg_252_1.time_ - var_255_9) / var_255_10

				if arg_252_1.var_.actorSpriteComps10115 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10115 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_255_7 then
						if arg_252_1.isInRecall_ then
							iter_255_7.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10115 = nil
			end

			local var_255_16 = arg_252_1.actors_["1034"].transform
			local var_255_17 = 0

			if var_255_17 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.var_.moveOldPos1034 = var_255_16.localPosition
				var_255_16.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("1034", 2)

				local var_255_18 = var_255_16.childCount

				for iter_255_8 = 0, var_255_18 - 1 do
					local var_255_19 = var_255_16:GetChild(iter_255_8)

					if var_255_19.name == "split_7" or not string.find(var_255_19.name, "split") then
						var_255_19.gameObject:SetActive(true)
					else
						var_255_19.gameObject:SetActive(false)
					end
				end
			end

			local var_255_20 = 0.001

			if var_255_17 <= arg_252_1.time_ and arg_252_1.time_ < var_255_17 + var_255_20 then
				local var_255_21 = (arg_252_1.time_ - var_255_17) / var_255_20
				local var_255_22 = Vector3.New(-390, -331.9, -324)

				var_255_16.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1034, var_255_22, var_255_21)
			end

			if arg_252_1.time_ >= var_255_17 + var_255_20 and arg_252_1.time_ < var_255_17 + var_255_20 + arg_255_0 then
				var_255_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_255_23 = 0
			local var_255_24 = 0.65

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_25 = arg_252_1:FormatText(StoryNameCfg[1109].name)

				arg_252_1.leftNameTxt_.text = var_255_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_26 = arg_252_1:GetWordFromCfg(417131062)
				local var_255_27 = arg_252_1:FormatText(var_255_26.content)

				arg_252_1.text_.text = var_255_27

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_28 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131062", "story_v_out_417131.awb") ~= 0 then
					local var_255_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131062", "story_v_out_417131.awb") / 1000

					if var_255_31 + var_255_23 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_31 + var_255_23
					end

					if var_255_26.prefab_name ~= "" and arg_252_1.actors_[var_255_26.prefab_name] ~= nil then
						local var_255_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_26.prefab_name].transform, "story_v_out_417131", "417131062", "story_v_out_417131.awb")

						arg_252_1:RecordAudio("417131062", var_255_32)
						arg_252_1:RecordAudio("417131062", var_255_32)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417131", "417131062", "story_v_out_417131.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417131", "417131062", "story_v_out_417131.awb")
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
				actorName = "1034",
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
	Play417131063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417131063
		arg_256_1.duration_ = 6.67

		local var_256_0 = {
			zh = 4.133,
			ja = 6.666
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
				arg_256_0:Play417131064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10115"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10115 == nil then
				arg_256_1.var_.actorSpriteComps10115 = var_259_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.actorSpriteComps10115 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								local var_259_4 = Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor1.r, var_259_3)
								local var_259_5 = Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor1.g, var_259_3)
								local var_259_6 = Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor1.b, var_259_3)

								iter_259_1.color = Color.New(var_259_4, var_259_5, var_259_6)
							else
								local var_259_7 = Mathf.Lerp(iter_259_1.color.r, 1, var_259_3)

								iter_259_1.color = Color.New(var_259_7, var_259_7, var_259_7)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10115 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_259_3 then
						if arg_256_1.isInRecall_ then
							iter_259_3.color = arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_259_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps10115 = nil
			end

			local var_259_8 = arg_256_1.actors_["1034"]
			local var_259_9 = 0

			if var_259_9 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 and not isNil(var_259_8) and arg_256_1.var_.actorSpriteComps1034 == nil then
				arg_256_1.var_.actorSpriteComps1034 = var_259_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_10 = 0.2

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 and not isNil(var_259_8) then
				local var_259_11 = (arg_256_1.time_ - var_259_9) / var_259_10

				if arg_256_1.var_.actorSpriteComps1034 then
					for iter_259_4, iter_259_5 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_259_5 then
							if arg_256_1.isInRecall_ then
								local var_259_12 = Mathf.Lerp(iter_259_5.color.r, arg_256_1.hightColor2.r, var_259_11)
								local var_259_13 = Mathf.Lerp(iter_259_5.color.g, arg_256_1.hightColor2.g, var_259_11)
								local var_259_14 = Mathf.Lerp(iter_259_5.color.b, arg_256_1.hightColor2.b, var_259_11)

								iter_259_5.color = Color.New(var_259_12, var_259_13, var_259_14)
							else
								local var_259_15 = Mathf.Lerp(iter_259_5.color.r, 0.5, var_259_11)

								iter_259_5.color = Color.New(var_259_15, var_259_15, var_259_15)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 and not isNil(var_259_8) and arg_256_1.var_.actorSpriteComps1034 then
				for iter_259_6, iter_259_7 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_259_7 then
						if arg_256_1.isInRecall_ then
							iter_259_7.color = arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_259_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps1034 = nil
			end

			local var_259_16 = 0
			local var_259_17 = 0.525

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_18 = arg_256_1:FormatText(StoryNameCfg[1113].name)

				arg_256_1.leftNameTxt_.text = var_259_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_19 = arg_256_1:GetWordFromCfg(417131063)
				local var_259_20 = arg_256_1:FormatText(var_259_19.content)

				arg_256_1.text_.text = var_259_20

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_21 = 21
				local var_259_22 = utf8.len(var_259_20)
				local var_259_23 = var_259_21 <= 0 and var_259_17 or var_259_17 * (var_259_22 / var_259_21)

				if var_259_23 > 0 and var_259_17 < var_259_23 then
					arg_256_1.talkMaxDuration = var_259_23

					if var_259_23 + var_259_16 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_23 + var_259_16
					end
				end

				arg_256_1.text_.text = var_259_20
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131063", "story_v_out_417131.awb") ~= 0 then
					local var_259_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131063", "story_v_out_417131.awb") / 1000

					if var_259_24 + var_259_16 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_24 + var_259_16
					end

					if var_259_19.prefab_name ~= "" and arg_256_1.actors_[var_259_19.prefab_name] ~= nil then
						local var_259_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_19.prefab_name].transform, "story_v_out_417131", "417131063", "story_v_out_417131.awb")

						arg_256_1:RecordAudio("417131063", var_259_25)
						arg_256_1:RecordAudio("417131063", var_259_25)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417131", "417131063", "story_v_out_417131.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417131", "417131063", "story_v_out_417131.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_26 = math.max(var_259_17, arg_256_1.talkMaxDuration)

			if var_259_16 <= arg_256_1.time_ and arg_256_1.time_ < var_259_16 + var_259_26 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_16) / var_259_26

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_16 + var_259_26 and arg_256_1.time_ < var_259_16 + var_259_26 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417131064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417131064
		arg_260_1.duration_ = 12.03

		local var_260_0 = {
			zh = 8.566,
			ja = 12.033
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
				arg_260_0:Play417131065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10115"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos10115 = var_263_0.localPosition
				var_263_0.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10115", 4)

				local var_263_2 = var_263_0.childCount

				for iter_263_0 = 0, var_263_2 - 1 do
					local var_263_3 = var_263_0:GetChild(iter_263_0)

					if var_263_3.name == "" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_4 then
				local var_263_5 = (arg_260_1.time_ - var_263_1) / var_263_4
				local var_263_6 = Vector3.New(390, -387.3, -246.2)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10115, var_263_6, var_263_5)
			end

			if arg_260_1.time_ >= var_263_1 + var_263_4 and arg_260_1.time_ < var_263_1 + var_263_4 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_263_7 = 0
			local var_263_8 = 0.925

			if var_263_7 < arg_260_1.time_ and arg_260_1.time_ <= var_263_7 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_9 = arg_260_1:FormatText(StoryNameCfg[1113].name)

				arg_260_1.leftNameTxt_.text = var_263_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_10 = arg_260_1:GetWordFromCfg(417131064)
				local var_263_11 = arg_260_1:FormatText(var_263_10.content)

				arg_260_1.text_.text = var_263_11

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_12 = 37
				local var_263_13 = utf8.len(var_263_11)
				local var_263_14 = var_263_12 <= 0 and var_263_8 or var_263_8 * (var_263_13 / var_263_12)

				if var_263_14 > 0 and var_263_8 < var_263_14 then
					arg_260_1.talkMaxDuration = var_263_14

					if var_263_14 + var_263_7 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_7
					end
				end

				arg_260_1.text_.text = var_263_11
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131064", "story_v_out_417131.awb") ~= 0 then
					local var_263_15 = manager.audio:GetVoiceLength("story_v_out_417131", "417131064", "story_v_out_417131.awb") / 1000

					if var_263_15 + var_263_7 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_15 + var_263_7
					end

					if var_263_10.prefab_name ~= "" and arg_260_1.actors_[var_263_10.prefab_name] ~= nil then
						local var_263_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_10.prefab_name].transform, "story_v_out_417131", "417131064", "story_v_out_417131.awb")

						arg_260_1:RecordAudio("417131064", var_263_16)
						arg_260_1:RecordAudio("417131064", var_263_16)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417131", "417131064", "story_v_out_417131.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417131", "417131064", "story_v_out_417131.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_17 = math.max(var_263_8, arg_260_1.talkMaxDuration)

			if var_263_7 <= arg_260_1.time_ and arg_260_1.time_ < var_263_7 + var_263_17 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_7) / var_263_17

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_7 + var_263_17 and arg_260_1.time_ < var_263_7 + var_263_17 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play417131065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417131065
		arg_264_1.duration_ = 4.9

		local var_264_0 = {
			zh = 4.6,
			ja = 4.9
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
				arg_264_0:Play417131066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1034"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1034 == nil then
				arg_264_1.var_.actorSpriteComps1034 = var_267_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.actorSpriteComps1034 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								local var_267_4 = Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, var_267_3)
								local var_267_5 = Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, var_267_3)
								local var_267_6 = Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, var_267_3)

								iter_267_1.color = Color.New(var_267_4, var_267_5, var_267_6)
							else
								local var_267_7 = Mathf.Lerp(iter_267_1.color.r, 1, var_267_3)

								iter_267_1.color = Color.New(var_267_7, var_267_7, var_267_7)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1034 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_267_3 then
						if arg_264_1.isInRecall_ then
							iter_267_3.color = arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_267_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps1034 = nil
			end

			local var_267_8 = arg_264_1.actors_["10115"]
			local var_267_9 = 0

			if var_267_9 < arg_264_1.time_ and arg_264_1.time_ <= var_267_9 + arg_267_0 and not isNil(var_267_8) and arg_264_1.var_.actorSpriteComps10115 == nil then
				arg_264_1.var_.actorSpriteComps10115 = var_267_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_10 = 0.2

			if var_267_9 <= arg_264_1.time_ and arg_264_1.time_ < var_267_9 + var_267_10 and not isNil(var_267_8) then
				local var_267_11 = (arg_264_1.time_ - var_267_9) / var_267_10

				if arg_264_1.var_.actorSpriteComps10115 then
					for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_267_5 then
							if arg_264_1.isInRecall_ then
								local var_267_12 = Mathf.Lerp(iter_267_5.color.r, arg_264_1.hightColor2.r, var_267_11)
								local var_267_13 = Mathf.Lerp(iter_267_5.color.g, arg_264_1.hightColor2.g, var_267_11)
								local var_267_14 = Mathf.Lerp(iter_267_5.color.b, arg_264_1.hightColor2.b, var_267_11)

								iter_267_5.color = Color.New(var_267_12, var_267_13, var_267_14)
							else
								local var_267_15 = Mathf.Lerp(iter_267_5.color.r, 0.5, var_267_11)

								iter_267_5.color = Color.New(var_267_15, var_267_15, var_267_15)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_9 + var_267_10 and arg_264_1.time_ < var_267_9 + var_267_10 + arg_267_0 and not isNil(var_267_8) and arg_264_1.var_.actorSpriteComps10115 then
				for iter_267_6, iter_267_7 in pairs(arg_264_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_267_7 then
						if arg_264_1.isInRecall_ then
							iter_267_7.color = arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_267_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps10115 = nil
			end

			local var_267_16 = arg_264_1.actors_["1034"].transform
			local var_267_17 = 0

			if var_267_17 < arg_264_1.time_ and arg_264_1.time_ <= var_267_17 + arg_267_0 then
				arg_264_1.var_.moveOldPos1034 = var_267_16.localPosition
				var_267_16.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1034", 2)

				local var_267_18 = var_267_16.childCount

				for iter_267_8 = 0, var_267_18 - 1 do
					local var_267_19 = var_267_16:GetChild(iter_267_8)

					if var_267_19.name == "" or not string.find(var_267_19.name, "split") then
						var_267_19.gameObject:SetActive(true)
					else
						var_267_19.gameObject:SetActive(false)
					end
				end
			end

			local var_267_20 = 0.001

			if var_267_17 <= arg_264_1.time_ and arg_264_1.time_ < var_267_17 + var_267_20 then
				local var_267_21 = (arg_264_1.time_ - var_267_17) / var_267_20
				local var_267_22 = Vector3.New(-390, -331.9, -324)

				var_267_16.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1034, var_267_22, var_267_21)
			end

			if arg_264_1.time_ >= var_267_17 + var_267_20 and arg_264_1.time_ < var_267_17 + var_267_20 + arg_267_0 then
				var_267_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_267_23 = 0
			local var_267_24 = 0.6

			if var_267_23 < arg_264_1.time_ and arg_264_1.time_ <= var_267_23 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_25 = arg_264_1:FormatText(StoryNameCfg[1109].name)

				arg_264_1.leftNameTxt_.text = var_267_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_26 = arg_264_1:GetWordFromCfg(417131065)
				local var_267_27 = arg_264_1:FormatText(var_267_26.content)

				arg_264_1.text_.text = var_267_27

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_28 = 24
				local var_267_29 = utf8.len(var_267_27)
				local var_267_30 = var_267_28 <= 0 and var_267_24 or var_267_24 * (var_267_29 / var_267_28)

				if var_267_30 > 0 and var_267_24 < var_267_30 then
					arg_264_1.talkMaxDuration = var_267_30

					if var_267_30 + var_267_23 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_30 + var_267_23
					end
				end

				arg_264_1.text_.text = var_267_27
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131065", "story_v_out_417131.awb") ~= 0 then
					local var_267_31 = manager.audio:GetVoiceLength("story_v_out_417131", "417131065", "story_v_out_417131.awb") / 1000

					if var_267_31 + var_267_23 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_31 + var_267_23
					end

					if var_267_26.prefab_name ~= "" and arg_264_1.actors_[var_267_26.prefab_name] ~= nil then
						local var_267_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_26.prefab_name].transform, "story_v_out_417131", "417131065", "story_v_out_417131.awb")

						arg_264_1:RecordAudio("417131065", var_267_32)
						arg_264_1:RecordAudio("417131065", var_267_32)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417131", "417131065", "story_v_out_417131.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417131", "417131065", "story_v_out_417131.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_33 = math.max(var_267_24, arg_264_1.talkMaxDuration)

			if var_267_23 <= arg_264_1.time_ and arg_264_1.time_ < var_267_23 + var_267_33 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_23) / var_267_33

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_23 + var_267_33 and arg_264_1.time_ < var_267_23 + var_267_33 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play417131066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 417131066
		arg_268_1.duration_ = 11.23

		local var_268_0 = {
			zh = 5.5,
			ja = 11.233
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
				arg_268_0:Play417131067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.725

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[1109].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(417131066)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 29
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131066", "story_v_out_417131.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131066", "story_v_out_417131.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_417131", "417131066", "story_v_out_417131.awb")

						arg_268_1:RecordAudio("417131066", var_271_9)
						arg_268_1:RecordAudio("417131066", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_417131", "417131066", "story_v_out_417131.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_417131", "417131066", "story_v_out_417131.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play417131067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 417131067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play417131068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1034"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.actorSpriteComps1034 == nil then
				arg_272_1.var_.actorSpriteComps1034 = var_275_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_2 = 0.2

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.actorSpriteComps1034 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								local var_275_4 = Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor2.r, var_275_3)
								local var_275_5 = Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor2.g, var_275_3)
								local var_275_6 = Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor2.b, var_275_3)

								iter_275_1.color = Color.New(var_275_4, var_275_5, var_275_6)
							else
								local var_275_7 = Mathf.Lerp(iter_275_1.color.r, 0.5, var_275_3)

								iter_275_1.color = Color.New(var_275_7, var_275_7, var_275_7)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.actorSpriteComps1034 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_275_3 then
						if arg_272_1.isInRecall_ then
							iter_275_3.color = arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_275_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_272_1.var_.actorSpriteComps1034 = nil
			end

			local var_275_8 = arg_272_1.actors_["1034"].transform
			local var_275_9 = 0

			if var_275_9 < arg_272_1.time_ and arg_272_1.time_ <= var_275_9 + arg_275_0 then
				arg_272_1.var_.moveOldPos1034 = var_275_8.localPosition
				var_275_8.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("1034", 7)

				local var_275_10 = var_275_8.childCount

				for iter_275_4 = 0, var_275_10 - 1 do
					local var_275_11 = var_275_8:GetChild(iter_275_4)

					if var_275_11.name == "" or not string.find(var_275_11.name, "split") then
						var_275_11.gameObject:SetActive(true)
					else
						var_275_11.gameObject:SetActive(false)
					end
				end
			end

			local var_275_12 = 0.001

			if var_275_9 <= arg_272_1.time_ and arg_272_1.time_ < var_275_9 + var_275_12 then
				local var_275_13 = (arg_272_1.time_ - var_275_9) / var_275_12
				local var_275_14 = Vector3.New(0, -2000, 0)

				var_275_8.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1034, var_275_14, var_275_13)
			end

			if arg_272_1.time_ >= var_275_9 + var_275_12 and arg_272_1.time_ < var_275_9 + var_275_12 + arg_275_0 then
				var_275_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_275_15 = arg_272_1.actors_["10115"].transform
			local var_275_16 = 0

			if var_275_16 < arg_272_1.time_ and arg_272_1.time_ <= var_275_16 + arg_275_0 then
				arg_272_1.var_.moveOldPos10115 = var_275_15.localPosition
				var_275_15.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10115", 7)

				local var_275_17 = var_275_15.childCount

				for iter_275_5 = 0, var_275_17 - 1 do
					local var_275_18 = var_275_15:GetChild(iter_275_5)

					if var_275_18.name == "" or not string.find(var_275_18.name, "split") then
						var_275_18.gameObject:SetActive(true)
					else
						var_275_18.gameObject:SetActive(false)
					end
				end
			end

			local var_275_19 = 0.001

			if var_275_16 <= arg_272_1.time_ and arg_272_1.time_ < var_275_16 + var_275_19 then
				local var_275_20 = (arg_272_1.time_ - var_275_16) / var_275_19
				local var_275_21 = Vector3.New(0, -2000, 0)

				var_275_15.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10115, var_275_21, var_275_20)
			end

			if arg_272_1.time_ >= var_275_16 + var_275_19 and arg_272_1.time_ < var_275_16 + var_275_19 + arg_275_0 then
				var_275_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_275_22 = 0.3
			local var_275_23 = 1

			if var_275_22 < arg_272_1.time_ and arg_272_1.time_ <= var_275_22 + arg_275_0 then
				local var_275_24 = "play"
				local var_275_25 = "effect"

				arg_272_1:AudioAction(var_275_24, var_275_25, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_275_26 = 0
			local var_275_27 = 1.3

			if var_275_26 < arg_272_1.time_ and arg_272_1.time_ <= var_275_26 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_28 = arg_272_1:GetWordFromCfg(417131067)
				local var_275_29 = arg_272_1:FormatText(var_275_28.content)

				arg_272_1.text_.text = var_275_29

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_30 = 52
				local var_275_31 = utf8.len(var_275_29)
				local var_275_32 = var_275_30 <= 0 and var_275_27 or var_275_27 * (var_275_31 / var_275_30)

				if var_275_32 > 0 and var_275_27 < var_275_32 then
					arg_272_1.talkMaxDuration = var_275_32

					if var_275_32 + var_275_26 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_32 + var_275_26
					end
				end

				arg_272_1.text_.text = var_275_29
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_33 = math.max(var_275_27, arg_272_1.talkMaxDuration)

			if var_275_26 <= arg_272_1.time_ and arg_272_1.time_ < var_275_26 + var_275_33 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_26) / var_275_33

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_26 + var_275_33 and arg_272_1.time_ < var_275_26 + var_275_33 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 417131068
		arg_276_1.duration_ = 2.8

		local var_276_0 = {
			zh = 2.8,
			ja = 2.1
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play417131069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.3

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[1113].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_4")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(417131068)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 12
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131068", "story_v_out_417131.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131068", "story_v_out_417131.awb") / 1000

					if var_279_8 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_0
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_417131", "417131068", "story_v_out_417131.awb")

						arg_276_1:RecordAudio("417131068", var_279_9)
						arg_276_1:RecordAudio("417131068", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_417131", "417131068", "story_v_out_417131.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_417131", "417131068", "story_v_out_417131.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_10 and arg_276_1.time_ < var_279_0 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play417131069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 417131069
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play417131070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.8
			local var_283_1 = 1

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				local var_283_2 = "play"
				local var_283_3 = "effect"

				arg_280_1:AudioAction(var_283_2, var_283_3, "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_283_4 = 0
			local var_283_5 = 1.575

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0

				arg_280_1.dialog_:SetActive(true)

				arg_280_1.dialogCg_.alpha = 0

				local var_283_6 = LeanTween.value(arg_280_1.dialog_, 0, 1, 0.3)

				var_283_6:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_280_1.dialogCg_.alpha = arg_284_0
				end))
				var_283_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_280_1.dialog_)
					var_283_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_280_1.duration_ = arg_280_1.duration_ + 0.3

				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_7 = arg_280_1:GetWordFromCfg(417131069)
				local var_283_8 = arg_280_1:FormatText(var_283_7.content)

				arg_280_1.text_.text = var_283_8

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 63
				local var_283_10 = utf8.len(var_283_8)
				local var_283_11 = var_283_9 <= 0 and var_283_5 or var_283_5 * (var_283_10 / var_283_9)

				if var_283_11 > 0 and var_283_5 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11
					var_283_4 = var_283_4 + 0.3

					if var_283_11 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_8
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = var_283_4 + 0.3
			local var_283_13 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_12 <= arg_280_1.time_ and arg_280_1.time_ < var_283_12 + var_283_13 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_12) / var_283_13

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_12 + var_283_13 and arg_280_1.time_ < var_283_12 + var_283_13 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play417131070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417131070
		arg_286_1.duration_ = 8.43

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417131071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 1.56666666666667

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_1 = manager.ui.mainCamera.transform.localPosition
				local var_289_2 = Vector3.New(0, 0, 10) + Vector3.New(var_289_1.x, var_289_1.y, 0)
				local var_289_3 = arg_286_1.bgs_.ST2105a

				var_289_3.transform.localPosition = var_289_2
				var_289_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_4 = var_289_3:GetComponent("SpriteRenderer")

				if var_289_4 and var_289_4.sprite then
					local var_289_5 = (var_289_3.transform.localPosition - var_289_1).z
					local var_289_6 = manager.ui.mainCameraCom_
					local var_289_7 = 2 * var_289_5 * Mathf.Tan(var_289_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_289_8 = var_289_7 * var_289_6.aspect
					local var_289_9 = var_289_4.sprite.bounds.size.x
					local var_289_10 = var_289_4.sprite.bounds.size.y
					local var_289_11 = var_289_8 / var_289_9
					local var_289_12 = var_289_7 / var_289_10
					local var_289_13 = var_289_12 < var_289_11 and var_289_11 or var_289_12

					var_289_3.transform.localScale = Vector3.New(var_289_13, var_289_13, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "ST2105a" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			local var_289_15 = 0.3

			if arg_286_1.time_ >= var_289_14 + var_289_15 and arg_286_1.time_ < var_289_14 + var_289_15 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_16 = 0

			if var_289_16 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_17 = 1.56666666666667

			if var_289_16 <= arg_286_1.time_ and arg_286_1.time_ < var_289_16 + var_289_17 then
				local var_289_18 = (arg_286_1.time_ - var_289_16) / var_289_17
				local var_289_19 = Color.New(0, 0, 0)

				var_289_19.a = Mathf.Lerp(0, 1, var_289_18)
				arg_286_1.mask_.color = var_289_19
			end

			if arg_286_1.time_ >= var_289_16 + var_289_17 and arg_286_1.time_ < var_289_16 + var_289_17 + arg_289_0 then
				local var_289_20 = Color.New(0, 0, 0)

				var_289_20.a = 1
				arg_286_1.mask_.color = var_289_20
			end

			local var_289_21 = 1.56666666666667

			if var_289_21 < arg_286_1.time_ and arg_286_1.time_ <= var_289_21 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_22 = 2

			if var_289_21 <= arg_286_1.time_ and arg_286_1.time_ < var_289_21 + var_289_22 then
				local var_289_23 = (arg_286_1.time_ - var_289_21) / var_289_22
				local var_289_24 = Color.New(0, 0, 0)

				var_289_24.a = Mathf.Lerp(1, 0, var_289_23)
				arg_286_1.mask_.color = var_289_24
			end

			if arg_286_1.time_ >= var_289_21 + var_289_22 and arg_286_1.time_ < var_289_21 + var_289_22 + arg_289_0 then
				local var_289_25 = Color.New(0, 0, 0)
				local var_289_26 = 0

				arg_286_1.mask_.enabled = false
				var_289_25.a = var_289_26
				arg_286_1.mask_.color = var_289_25
			end

			local var_289_27 = 1.53333333333333

			arg_286_1.isInRecall_ = false

			if var_289_27 < arg_286_1.time_ and arg_286_1.time_ <= var_289_27 + arg_289_0 then
				arg_286_1.screenFilterGo_:SetActive(false)

				for iter_289_2, iter_289_3 in pairs(arg_286_1.actors_) do
					local var_289_28 = iter_289_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_289_4, iter_289_5 in ipairs(var_289_28) do
						if iter_289_5.color.r > 0.51 then
							iter_289_5.color = Color.New(1, 1, 1)
						else
							iter_289_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_289_29 = 0.0333333333333332

			if var_289_27 <= arg_286_1.time_ and arg_286_1.time_ < var_289_27 + var_289_29 then
				local var_289_30 = (arg_286_1.time_ - var_289_27) / var_289_29

				arg_286_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_289_30)
			end

			if arg_286_1.time_ >= var_289_27 + var_289_29 and arg_286_1.time_ < var_289_27 + var_289_29 + arg_289_0 then
				arg_286_1.screenFilterEffect_.weight = 0
			end

			local var_289_31 = manager.ui.mainCamera.transform
			local var_289_32 = 2.43333333333333

			if var_289_32 < arg_286_1.time_ and arg_286_1.time_ <= var_289_32 + arg_289_0 then
				local var_289_33 = arg_286_1.var_.effect7456
				local var_289_34
				local var_289_35 = var_289_31

				if not var_289_33 then
					var_289_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_289_35)
					var_289_33.name = "7456"
					arg_286_1.var_.effect7456 = var_289_33
				else
					var_289_33.transform:SetParent(var_289_35)
				end

				var_289_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_289_33.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_289_36 = manager.ui.mainCameraCom_
				local var_289_37 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_289_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_289_38 = var_289_33.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_289_39 = 15
				local var_289_40 = 2 * var_289_39 * Mathf.Tan(var_289_36.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_289_36.aspect
				local var_289_41 = 1
				local var_289_42 = 1.7777777777777777

				if var_289_42 < var_289_36.aspect then
					var_289_41 = var_289_40 / (2 * var_289_39 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_289_42)
				end

				for iter_289_6, iter_289_7 in ipairs(var_289_38) do
					local var_289_43 = iter_289_7.transform.localScale

					iter_289_7.transform.localScale = Vector3.New(var_289_43.x / var_289_37 * var_289_41, var_289_43.y / var_289_37, var_289_43.z)
				end
			end

			local var_289_44 = manager.ui.mainCamera.transform
			local var_289_45 = 1.56666666666667

			if var_289_45 < arg_286_1.time_ and arg_286_1.time_ <= var_289_45 + arg_289_0 then
				local var_289_46 = arg_286_1.var_.effect811
				local var_289_47
				local var_289_48 = var_289_44

				if not var_289_46 then
					var_289_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_289_48)
					var_289_46.name = "811"
					arg_286_1.var_.effect811 = var_289_46
				else
					var_289_46.transform:SetParent(var_289_48)
				end

				var_289_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_289_46.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_289_49 = manager.ui.mainCameraCom_
				local var_289_50 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_289_49.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_289_51 = var_289_46.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_289_52 = 15
				local var_289_53 = 2 * var_289_52 * Mathf.Tan(var_289_49.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_289_49.aspect
				local var_289_54 = 1
				local var_289_55 = 1.7777777777777777

				if var_289_55 < var_289_49.aspect then
					var_289_54 = var_289_53 / (2 * var_289_52 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_289_55)
				end

				for iter_289_8, iter_289_9 in ipairs(var_289_51) do
					local var_289_56 = iter_289_9.transform.localScale

					iter_289_9.transform.localScale = Vector3.New(var_289_56.x / var_289_50 * var_289_54, var_289_56.y / var_289_50, var_289_56.z)
				end
			end

			local var_289_57 = 1.43333333333333
			local var_289_58 = 1

			if var_289_57 < arg_286_1.time_ and arg_286_1.time_ <= var_289_57 + arg_289_0 then
				local var_289_59 = "play"
				local var_289_60 = "effect"

				arg_286_1:AudioAction(var_289_59, var_289_60, "se_story_121_04", "se_story_121_04_crisis02_loop", "")
			end

			local var_289_61 = 2.4
			local var_289_62 = 1

			if var_289_61 < arg_286_1.time_ and arg_286_1.time_ <= var_289_61 + arg_289_0 then
				local var_289_63 = "play"
				local var_289_64 = "effect"

				arg_286_1:AudioAction(var_289_63, var_289_64, "se_story_139", "se_story_139_metalhit02", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_65 = 3.43333333333333
			local var_289_66 = 1.25

			if var_289_65 < arg_286_1.time_ and arg_286_1.time_ <= var_289_65 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_67 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_67:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_68 = arg_286_1:GetWordFromCfg(417131070)
				local var_289_69 = arg_286_1:FormatText(var_289_68.content)

				arg_286_1.text_.text = var_289_69

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_70 = 50
				local var_289_71 = utf8.len(var_289_69)
				local var_289_72 = var_289_70 <= 0 and var_289_66 or var_289_66 * (var_289_71 / var_289_70)

				if var_289_72 > 0 and var_289_66 < var_289_72 then
					arg_286_1.talkMaxDuration = var_289_72
					var_289_65 = var_289_65 + 0.3

					if var_289_72 + var_289_65 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_72 + var_289_65
					end
				end

				arg_286_1.text_.text = var_289_69
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_73 = var_289_65 + 0.3
			local var_289_74 = math.max(var_289_66, arg_286_1.talkMaxDuration)

			if var_289_73 <= arg_286_1.time_ and arg_286_1.time_ < var_289_73 + var_289_74 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_73) / var_289_74

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_73 + var_289_74 and arg_286_1.time_ < var_289_73 + var_289_74 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417131071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417131071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417131072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = manager.ui.mainCamera.transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				local var_295_2 = arg_292_1.var_.effect7456

				if var_295_2 then
					Object.Destroy(var_295_2)

					arg_292_1.var_.effect7456 = nil
				end
			end

			local var_295_3 = 0.05
			local var_295_4 = 1

			if var_295_3 < arg_292_1.time_ and arg_292_1.time_ <= var_295_3 + arg_295_0 then
				local var_295_5 = "play"
				local var_295_6 = "effect"

				arg_292_1:AudioAction(var_295_5, var_295_6, "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_295_7 = 0
			local var_295_8 = 1.025

			if var_295_7 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:GetWordFromCfg(417131071)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 41
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_8 or var_295_8 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_8 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_14 and arg_292_1.time_ < var_295_7 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417131072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417131072
		arg_296_1.duration_ = 4.87

		local var_296_0 = {
			zh = 3.666,
			ja = 4.866
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play417131073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10115"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10115 == nil then
				arg_296_1.var_.actorSpriteComps10115 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps10115 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								local var_299_4 = Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor1.r, var_299_3)
								local var_299_5 = Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor1.g, var_299_3)
								local var_299_6 = Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor1.b, var_299_3)

								iter_299_1.color = Color.New(var_299_4, var_299_5, var_299_6)
							else
								local var_299_7 = Mathf.Lerp(iter_299_1.color.r, 1, var_299_3)

								iter_299_1.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10115 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10115 = nil
			end

			local var_299_8 = 0
			local var_299_9 = 0.45

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_10 = arg_296_1:FormatText(StoryNameCfg[1113].name)

				arg_296_1.leftNameTxt_.text = var_299_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_6")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_11 = arg_296_1:GetWordFromCfg(417131072)
				local var_299_12 = arg_296_1:FormatText(var_299_11.content)

				arg_296_1.text_.text = var_299_12

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 18
				local var_299_14 = utf8.len(var_299_12)
				local var_299_15 = var_299_13 <= 0 and var_299_9 or var_299_9 * (var_299_14 / var_299_13)

				if var_299_15 > 0 and var_299_9 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_12
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131072", "story_v_out_417131.awb") ~= 0 then
					local var_299_16 = manager.audio:GetVoiceLength("story_v_out_417131", "417131072", "story_v_out_417131.awb") / 1000

					if var_299_16 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_8
					end

					if var_299_11.prefab_name ~= "" and arg_296_1.actors_[var_299_11.prefab_name] ~= nil then
						local var_299_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_11.prefab_name].transform, "story_v_out_417131", "417131072", "story_v_out_417131.awb")

						arg_296_1:RecordAudio("417131072", var_299_17)
						arg_296_1:RecordAudio("417131072", var_299_17)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417131", "417131072", "story_v_out_417131.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417131", "417131072", "story_v_out_417131.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_18 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_18 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_18

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_18 and arg_296_1.time_ < var_299_8 + var_299_18 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play417131073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417131073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417131074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10115"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10115 == nil then
				arg_300_1.var_.actorSpriteComps10115 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps10115 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 0.5, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10115 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10115 = nil
			end

			local var_303_8 = 0.05
			local var_303_9 = 1

			if var_303_8 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				local var_303_10 = "play"
				local var_303_11 = "effect"

				arg_300_1:AudioAction(var_303_10, var_303_11, "se_story_139", "se_story_139_metalhit03", "")
			end

			local var_303_12 = 0
			local var_303_13 = 0.475

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_14 = arg_300_1:GetWordFromCfg(417131073)
				local var_303_15 = arg_300_1:FormatText(var_303_14.content)

				arg_300_1.text_.text = var_303_15

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_16 = 19
				local var_303_17 = utf8.len(var_303_15)
				local var_303_18 = var_303_16 <= 0 and var_303_13 or var_303_13 * (var_303_17 / var_303_16)

				if var_303_18 > 0 and var_303_13 < var_303_18 then
					arg_300_1.talkMaxDuration = var_303_18

					if var_303_18 + var_303_12 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_18 + var_303_12
					end
				end

				arg_300_1.text_.text = var_303_15
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_19 = math.max(var_303_13, arg_300_1.talkMaxDuration)

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_19 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_12) / var_303_19

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_12 + var_303_19 and arg_300_1.time_ < var_303_12 + var_303_19 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play417131074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 417131074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play417131075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.525

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(417131074)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 61
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play417131075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 417131075
		arg_308_1.duration_ = 9.93

		local var_308_0 = {
			zh = 8.633,
			ja = 9.933
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play417131076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10115"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10115 == nil then
				arg_308_1.var_.actorSpriteComps10115 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps10115 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10115 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps10115 = nil
			end

			local var_311_8 = arg_308_1.actors_["10115"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos10115 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10115", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_6" or not string.find(var_311_11.name, "split") then
						var_311_11.gameObject:SetActive(true)
					else
						var_311_11.gameObject:SetActive(false)
					end
				end
			end

			local var_311_12 = 0.001

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(0, -387.3, -246.2)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10115, var_311_14, var_311_13)
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_311_15 = 0
			local var_311_16 = 0.925

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[1113].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(417131075)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 37
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131075", "story_v_out_417131.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_417131", "417131075", "story_v_out_417131.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_417131", "417131075", "story_v_out_417131.awb")

						arg_308_1:RecordAudio("417131075", var_311_24)
						arg_308_1:RecordAudio("417131075", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_417131", "417131075", "story_v_out_417131.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_417131", "417131075", "story_v_out_417131.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play417131076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 417131076
		arg_312_1.duration_ = 5.1

		local var_312_0 = {
			zh = 5.1,
			ja = 4.833
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play417131077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1034"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1034 == nil then
				arg_312_1.var_.actorSpriteComps1034 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1034 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 1, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1034 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1034 = nil
			end

			local var_315_8 = arg_312_1.actors_["10115"]
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps10115 == nil then
				arg_312_1.var_.actorSpriteComps10115 = var_315_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_10 = 0.2

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_10 and not isNil(var_315_8) then
				local var_315_11 = (arg_312_1.time_ - var_315_9) / var_315_10

				if arg_312_1.var_.actorSpriteComps10115 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								local var_315_12 = Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor2.r, var_315_11)
								local var_315_13 = Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor2.g, var_315_11)
								local var_315_14 = Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor2.b, var_315_11)

								iter_315_5.color = Color.New(var_315_12, var_315_13, var_315_14)
							else
								local var_315_15 = Mathf.Lerp(iter_315_5.color.r, 0.5, var_315_11)

								iter_315_5.color = Color.New(var_315_15, var_315_15, var_315_15)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_9 + var_315_10 and arg_312_1.time_ < var_315_9 + var_315_10 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps10115 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_315_7 then
						if arg_312_1.isInRecall_ then
							iter_315_7.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps10115 = nil
			end

			local var_315_16 = arg_312_1.actors_["10115"].transform
			local var_315_17 = 0

			if var_315_17 < arg_312_1.time_ and arg_312_1.time_ <= var_315_17 + arg_315_0 then
				arg_312_1.var_.moveOldPos10115 = var_315_16.localPosition
				var_315_16.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10115", 7)

				local var_315_18 = var_315_16.childCount

				for iter_315_8 = 0, var_315_18 - 1 do
					local var_315_19 = var_315_16:GetChild(iter_315_8)

					if var_315_19.name == "" or not string.find(var_315_19.name, "split") then
						var_315_19.gameObject:SetActive(true)
					else
						var_315_19.gameObject:SetActive(false)
					end
				end
			end

			local var_315_20 = 0.001

			if var_315_17 <= arg_312_1.time_ and arg_312_1.time_ < var_315_17 + var_315_20 then
				local var_315_21 = (arg_312_1.time_ - var_315_17) / var_315_20
				local var_315_22 = Vector3.New(0, -2000, 0)

				var_315_16.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10115, var_315_22, var_315_21)
			end

			if arg_312_1.time_ >= var_315_17 + var_315_20 and arg_312_1.time_ < var_315_17 + var_315_20 + arg_315_0 then
				var_315_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_23 = arg_312_1.actors_["1034"].transform
			local var_315_24 = 0

			if var_315_24 < arg_312_1.time_ and arg_312_1.time_ <= var_315_24 + arg_315_0 then
				arg_312_1.var_.moveOldPos1034 = var_315_23.localPosition
				var_315_23.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1034", 3)

				local var_315_25 = var_315_23.childCount

				for iter_315_9 = 0, var_315_25 - 1 do
					local var_315_26 = var_315_23:GetChild(iter_315_9)

					if var_315_26.name == "split_6" or not string.find(var_315_26.name, "split") then
						var_315_26.gameObject:SetActive(true)
					else
						var_315_26.gameObject:SetActive(false)
					end
				end
			end

			local var_315_27 = 0.001

			if var_315_24 <= arg_312_1.time_ and arg_312_1.time_ < var_315_24 + var_315_27 then
				local var_315_28 = (arg_312_1.time_ - var_315_24) / var_315_27
				local var_315_29 = Vector3.New(0, -331.9, -324)

				var_315_23.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1034, var_315_29, var_315_28)
			end

			if arg_312_1.time_ >= var_315_24 + var_315_27 and arg_312_1.time_ < var_315_24 + var_315_27 + arg_315_0 then
				var_315_23.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_315_30 = 0
			local var_315_31 = 0.675

			if var_315_30 < arg_312_1.time_ and arg_312_1.time_ <= var_315_30 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_32 = arg_312_1:FormatText(StoryNameCfg[1109].name)

				arg_312_1.leftNameTxt_.text = var_315_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_33 = arg_312_1:GetWordFromCfg(417131076)
				local var_315_34 = arg_312_1:FormatText(var_315_33.content)

				arg_312_1.text_.text = var_315_34

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_35 = 27
				local var_315_36 = utf8.len(var_315_34)
				local var_315_37 = var_315_35 <= 0 and var_315_31 or var_315_31 * (var_315_36 / var_315_35)

				if var_315_37 > 0 and var_315_31 < var_315_37 then
					arg_312_1.talkMaxDuration = var_315_37

					if var_315_37 + var_315_30 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_37 + var_315_30
					end
				end

				arg_312_1.text_.text = var_315_34
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131076", "story_v_out_417131.awb") ~= 0 then
					local var_315_38 = manager.audio:GetVoiceLength("story_v_out_417131", "417131076", "story_v_out_417131.awb") / 1000

					if var_315_38 + var_315_30 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_38 + var_315_30
					end

					if var_315_33.prefab_name ~= "" and arg_312_1.actors_[var_315_33.prefab_name] ~= nil then
						local var_315_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_33.prefab_name].transform, "story_v_out_417131", "417131076", "story_v_out_417131.awb")

						arg_312_1:RecordAudio("417131076", var_315_39)
						arg_312_1:RecordAudio("417131076", var_315_39)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_417131", "417131076", "story_v_out_417131.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_417131", "417131076", "story_v_out_417131.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_40 = math.max(var_315_31, arg_312_1.talkMaxDuration)

			if var_315_30 <= arg_312_1.time_ and arg_312_1.time_ < var_315_30 + var_315_40 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_30) / var_315_40

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_30 + var_315_40 and arg_312_1.time_ < var_315_30 + var_315_40 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play417131077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 417131077
		arg_316_1.duration_ = 8.23

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play417131078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1034"]
			local var_319_1 = 1.16666666666667

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1034 == nil then
				arg_316_1.var_.actorSpriteComps1034 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps1034 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor2.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor2.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor2.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 0.5, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1034 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_319_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1034 = nil
			end

			local var_319_8 = arg_316_1.actors_["1034"].transform
			local var_319_9 = 1.16666666666667

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 then
				arg_316_1.var_.moveOldPos1034 = var_319_8.localPosition
				var_319_8.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("1034", 7)

				local var_319_10 = var_319_8.childCount

				for iter_319_4 = 0, var_319_10 - 1 do
					local var_319_11 = var_319_8:GetChild(iter_319_4)

					if var_319_11.name == "" or not string.find(var_319_11.name, "split") then
						var_319_11.gameObject:SetActive(true)
					else
						var_319_11.gameObject:SetActive(false)
					end
				end
			end

			local var_319_12 = 0.001

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_12 then
				local var_319_13 = (arg_316_1.time_ - var_319_9) / var_319_12
				local var_319_14 = Vector3.New(0, -2000, 0)

				var_319_8.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1034, var_319_14, var_319_13)
			end

			if arg_316_1.time_ >= var_319_9 + var_319_12 and arg_316_1.time_ < var_319_9 + var_319_12 + arg_319_0 then
				var_319_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_319_15 = manager.ui.mainCamera.transform
			local var_319_16 = 2.26666666666667

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				local var_319_17 = arg_316_1.var_.effect798
				local var_319_18
				local var_319_19 = var_319_15

				if not var_319_17 then
					var_319_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), var_319_19)
					var_319_17.name = "798"
					arg_316_1.var_.effect798 = var_319_17
				else
					var_319_17.transform:SetParent(var_319_19)
				end

				var_319_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_319_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_319_20 = manager.ui.mainCameraCom_
				local var_319_21 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_319_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_319_22 = var_319_17.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_319_23 = 15
				local var_319_24 = 2 * var_319_23 * Mathf.Tan(var_319_20.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_319_20.aspect
				local var_319_25 = 1
				local var_319_26 = 1.7777777777777777

				if var_319_26 < var_319_20.aspect then
					var_319_25 = var_319_24 / (2 * var_319_23 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_319_26)
				end

				for iter_319_5, iter_319_6 in ipairs(var_319_22) do
					local var_319_27 = iter_319_6.transform.localScale

					iter_319_6.transform.localScale = Vector3.New(var_319_27.x / var_319_21 * var_319_25, var_319_27.y / var_319_21, var_319_27.z)
				end
			end

			local var_319_28 = 1.16666666666667

			if var_319_28 < arg_316_1.time_ and arg_316_1.time_ <= var_319_28 + arg_319_0 then
				arg_316_1.allBtn_.enabled = false
			end

			local var_319_29 = 1.76666666666667

			if arg_316_1.time_ >= var_319_28 + var_319_29 and arg_316_1.time_ < var_319_28 + var_319_29 + arg_319_0 then
				arg_316_1.allBtn_.enabled = true
			end

			local var_319_30 = 1.7
			local var_319_31 = 1

			if var_319_30 < arg_316_1.time_ and arg_316_1.time_ <= var_319_30 + arg_319_0 then
				local var_319_32 = "play"
				local var_319_33 = "effect"

				arg_316_1:AudioAction(var_319_32, var_319_33, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_319_34 = 0

			if var_319_34 < arg_316_1.time_ and arg_316_1.time_ <= var_319_34 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_35 = 1.23333333333333

			if var_319_34 <= arg_316_1.time_ and arg_316_1.time_ < var_319_34 + var_319_35 then
				local var_319_36 = (arg_316_1.time_ - var_319_34) / var_319_35
				local var_319_37 = Color.New(0, 0, 0)

				var_319_37.a = Mathf.Lerp(0, 1, var_319_36)
				arg_316_1.mask_.color = var_319_37
			end

			if arg_316_1.time_ >= var_319_34 + var_319_35 and arg_316_1.time_ < var_319_34 + var_319_35 + arg_319_0 then
				local var_319_38 = Color.New(0, 0, 0)

				var_319_38.a = 1
				arg_316_1.mask_.color = var_319_38
			end

			local var_319_39 = 1.23333333333333

			if var_319_39 < arg_316_1.time_ and arg_316_1.time_ <= var_319_39 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_40 = 2

			if var_319_39 <= arg_316_1.time_ and arg_316_1.time_ < var_319_39 + var_319_40 then
				local var_319_41 = (arg_316_1.time_ - var_319_39) / var_319_40
				local var_319_42 = Color.New(0, 0, 0)

				var_319_42.a = Mathf.Lerp(1, 0, var_319_41)
				arg_316_1.mask_.color = var_319_42
			end

			if arg_316_1.time_ >= var_319_39 + var_319_40 and arg_316_1.time_ < var_319_39 + var_319_40 + arg_319_0 then
				local var_319_43 = Color.New(0, 0, 0)
				local var_319_44 = 0

				arg_316_1.mask_.enabled = false
				var_319_43.a = var_319_44
				arg_316_1.mask_.color = var_319_43
			end

			local var_319_45 = "STblack"

			if arg_316_1.bgs_[var_319_45] == nil then
				local var_319_46 = Object.Instantiate(arg_316_1.paintGo_)

				var_319_46:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_319_45)
				var_319_46.name = var_319_45
				var_319_46.transform.parent = arg_316_1.stage_.transform
				var_319_46.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.bgs_[var_319_45] = var_319_46
			end

			local var_319_47 = 1.23333333333333

			if var_319_47 < arg_316_1.time_ and arg_316_1.time_ <= var_319_47 + arg_319_0 then
				local var_319_48 = manager.ui.mainCamera.transform.localPosition
				local var_319_49 = Vector3.New(0, 0, 10) + Vector3.New(var_319_48.x, var_319_48.y, 0)
				local var_319_50 = arg_316_1.bgs_.STblack

				var_319_50.transform.localPosition = var_319_49
				var_319_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_51 = var_319_50:GetComponent("SpriteRenderer")

				if var_319_51 and var_319_51.sprite then
					local var_319_52 = (var_319_50.transform.localPosition - var_319_48).z
					local var_319_53 = manager.ui.mainCameraCom_
					local var_319_54 = 2 * var_319_52 * Mathf.Tan(var_319_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_319_55 = var_319_54 * var_319_53.aspect
					local var_319_56 = var_319_51.sprite.bounds.size.x
					local var_319_57 = var_319_51.sprite.bounds.size.y
					local var_319_58 = var_319_55 / var_319_56
					local var_319_59 = var_319_54 / var_319_57
					local var_319_60 = var_319_59 < var_319_58 and var_319_58 or var_319_59

					var_319_50.transform.localScale = Vector3.New(var_319_60, var_319_60, 0)
				end

				for iter_319_7, iter_319_8 in pairs(arg_316_1.bgs_) do
					if iter_319_7 ~= "STblack" then
						iter_319_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_61 = 3.23333333333333
			local var_319_62 = 1.5

			if var_319_61 < arg_316_1.time_ and arg_316_1.time_ <= var_319_61 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_63 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_63:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_64 = arg_316_1:GetWordFromCfg(417131077)
				local var_319_65 = arg_316_1:FormatText(var_319_64.content)

				arg_316_1.text_.text = var_319_65

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_66 = 60
				local var_319_67 = utf8.len(var_319_65)
				local var_319_68 = var_319_66 <= 0 and var_319_62 or var_319_62 * (var_319_67 / var_319_66)

				if var_319_68 > 0 and var_319_62 < var_319_68 then
					arg_316_1.talkMaxDuration = var_319_68
					var_319_61 = var_319_61 + 0.3

					if var_319_68 + var_319_61 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_68 + var_319_61
					end
				end

				arg_316_1.text_.text = var_319_65
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_69 = var_319_61 + 0.3
			local var_319_70 = math.max(var_319_62, arg_316_1.talkMaxDuration)

			if var_319_69 <= arg_316_1.time_ and arg_316_1.time_ < var_319_69 + var_319_70 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_69) / var_319_70

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_69 + var_319_70 and arg_316_1.time_ < var_319_69 + var_319_70 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play417131078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417131078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417131079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = manager.ui.mainCamera.transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				local var_325_2 = arg_322_1.var_.effect798

				if var_325_2 then
					Object.Destroy(var_325_2)

					arg_322_1.var_.effect798 = nil
				end
			end

			local var_325_3 = 0
			local var_325_4 = 1.125

			if var_325_3 < arg_322_1.time_ and arg_322_1.time_ <= var_325_3 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_5 = arg_322_1:GetWordFromCfg(417131078)
				local var_325_6 = arg_322_1:FormatText(var_325_5.content)

				arg_322_1.text_.text = var_325_6

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 45
				local var_325_8 = utf8.len(var_325_6)
				local var_325_9 = var_325_7 <= 0 and var_325_4 or var_325_4 * (var_325_8 / var_325_7)

				if var_325_9 > 0 and var_325_4 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_3 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_3
					end
				end

				arg_322_1.text_.text = var_325_6
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_4, arg_322_1.talkMaxDuration)

			if var_325_3 <= arg_322_1.time_ and arg_322_1.time_ < var_325_3 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_3) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_3 + var_325_10 and arg_322_1.time_ < var_325_3 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417131079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417131079
		arg_326_1.duration_ = 1.88

		local var_326_0 = {
			zh = 1.78333333333333,
			ja = 1.88333333333333
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417131080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = manager.ui.mainCamera.transform
			local var_329_1 = 0.2

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				local var_329_2 = arg_326_1.var_.effect1236
				local var_329_3
				local var_329_4 = var_329_0

				if not var_329_2 then
					var_329_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_329_4)
					var_329_2.name = "1236"
					arg_326_1.var_.effect1236 = var_329_2
				else
					var_329_2.transform:SetParent(var_329_4)
				end

				var_329_2.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_329_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_329_5 = manager.ui.mainCameraCom_
				local var_329_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_329_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_329_7 = var_329_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_329_8 = 15
				local var_329_9 = 2 * var_329_8 * Mathf.Tan(var_329_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_329_5.aspect
				local var_329_10 = 1
				local var_329_11 = 1.7777777777777777

				if var_329_11 < var_329_5.aspect then
					var_329_10 = var_329_9 / (2 * var_329_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_329_11)
				end

				for iter_329_0, iter_329_1 in ipairs(var_329_7) do
					local var_329_12 = iter_329_1.transform.localScale

					iter_329_1.transform.localScale = Vector3.New(var_329_12.x / var_329_6 * var_329_10, var_329_12.y / var_329_6, var_329_12.z)
				end
			end

			local var_329_13 = 0

			if var_329_13 < arg_326_1.time_ and arg_326_1.time_ <= var_329_13 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = false

				arg_326_1:SetGaussion(false)
			end

			local var_329_14 = 0.3

			if var_329_13 <= arg_326_1.time_ and arg_326_1.time_ < var_329_13 + var_329_14 then
				local var_329_15 = (arg_326_1.time_ - var_329_13) / var_329_14
				local var_329_16 = Color.New(1, 1, 1)

				var_329_16.a = Mathf.Lerp(1, 0, var_329_15)
				arg_326_1.mask_.color = var_329_16
			end

			if arg_326_1.time_ >= var_329_13 + var_329_14 and arg_326_1.time_ < var_329_13 + var_329_14 + arg_329_0 then
				local var_329_17 = Color.New(1, 1, 1)
				local var_329_18 = 0

				arg_326_1.mask_.enabled = false
				var_329_17.a = var_329_18
				arg_326_1.mask_.color = var_329_17
			end

			local var_329_19 = 0.233333333333333
			local var_329_20 = 1

			if var_329_19 < arg_326_1.time_ and arg_326_1.time_ <= var_329_19 + arg_329_0 then
				local var_329_21 = "play"
				local var_329_22 = "effect"

				arg_326_1:AudioAction(var_329_21, var_329_22, "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_23 = 0.583333333333333
			local var_329_24 = 0.05

			if var_329_23 < arg_326_1.time_ and arg_326_1.time_ <= var_329_23 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_25 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_25:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_26 = arg_326_1:FormatText(StoryNameCfg[1109].name)

				arg_326_1.leftNameTxt_.text = var_329_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_27 = arg_326_1:GetWordFromCfg(417131079)
				local var_329_28 = arg_326_1:FormatText(var_329_27.content)

				arg_326_1.text_.text = var_329_28

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_29 = 2
				local var_329_30 = utf8.len(var_329_28)
				local var_329_31 = var_329_29 <= 0 and var_329_24 or var_329_24 * (var_329_30 / var_329_29)

				if var_329_31 > 0 and var_329_24 < var_329_31 then
					arg_326_1.talkMaxDuration = var_329_31
					var_329_23 = var_329_23 + 0.3

					if var_329_31 + var_329_23 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_31 + var_329_23
					end
				end

				arg_326_1.text_.text = var_329_28
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131079", "story_v_out_417131.awb") ~= 0 then
					local var_329_32 = manager.audio:GetVoiceLength("story_v_out_417131", "417131079", "story_v_out_417131.awb") / 1000

					if var_329_32 + var_329_23 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_32 + var_329_23
					end

					if var_329_27.prefab_name ~= "" and arg_326_1.actors_[var_329_27.prefab_name] ~= nil then
						local var_329_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_27.prefab_name].transform, "story_v_out_417131", "417131079", "story_v_out_417131.awb")

						arg_326_1:RecordAudio("417131079", var_329_33)
						arg_326_1:RecordAudio("417131079", var_329_33)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417131", "417131079", "story_v_out_417131.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417131", "417131079", "story_v_out_417131.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_34 = var_329_23 + 0.3
			local var_329_35 = math.max(var_329_24, arg_326_1.talkMaxDuration)

			if var_329_34 <= arg_326_1.time_ and arg_326_1.time_ < var_329_34 + var_329_35 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_34) / var_329_35

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_34 + var_329_35 and arg_326_1.time_ < var_329_34 + var_329_35 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417131080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 417131080
		arg_332_1.duration_ = 6.75

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play417131081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1034"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1034 == nil then
				arg_332_1.var_.actorSpriteComps1034 = var_335_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.actorSpriteComps1034 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								local var_335_4 = Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor2.r, var_335_3)
								local var_335_5 = Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor2.g, var_335_3)
								local var_335_6 = Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor2.b, var_335_3)

								iter_335_1.color = Color.New(var_335_4, var_335_5, var_335_6)
							else
								local var_335_7 = Mathf.Lerp(iter_335_1.color.r, 0.5, var_335_3)

								iter_335_1.color = Color.New(var_335_7, var_335_7, var_335_7)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1034 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_335_3 then
						if arg_332_1.isInRecall_ then
							iter_335_3.color = arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_335_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps1034 = nil
			end

			local var_335_8 = manager.ui.mainCamera.transform
			local var_335_9 = 0

			if var_335_9 < arg_332_1.time_ and arg_332_1.time_ <= var_335_9 + arg_335_0 then
				local var_335_10 = arg_332_1.var_.effect1236

				if var_335_10 then
					Object.Destroy(var_335_10)

					arg_332_1.var_.effect1236 = nil
				end
			end

			local var_335_11 = 1.1

			if var_335_11 < arg_332_1.time_ and arg_332_1.time_ <= var_335_11 + arg_335_0 then
				local var_335_12 = manager.ui.mainCamera.transform.localPosition
				local var_335_13 = Vector3.New(0, 0, 10) + Vector3.New(var_335_12.x, var_335_12.y, 0)
				local var_335_14 = arg_332_1.bgs_.ST2105a

				var_335_14.transform.localPosition = var_335_13
				var_335_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_15 = var_335_14:GetComponent("SpriteRenderer")

				if var_335_15 and var_335_15.sprite then
					local var_335_16 = (var_335_14.transform.localPosition - var_335_12).z
					local var_335_17 = manager.ui.mainCameraCom_
					local var_335_18 = 2 * var_335_16 * Mathf.Tan(var_335_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_335_19 = var_335_18 * var_335_17.aspect
					local var_335_20 = var_335_15.sprite.bounds.size.x
					local var_335_21 = var_335_15.sprite.bounds.size.y
					local var_335_22 = var_335_19 / var_335_20
					local var_335_23 = var_335_18 / var_335_21
					local var_335_24 = var_335_23 < var_335_22 and var_335_22 or var_335_23

					var_335_14.transform.localScale = Vector3.New(var_335_24, var_335_24, 0)
				end

				for iter_335_4, iter_335_5 in pairs(arg_332_1.bgs_) do
					if iter_335_4 ~= "ST2105a" then
						iter_335_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_25 = 0

			if var_335_25 < arg_332_1.time_ and arg_332_1.time_ <= var_335_25 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_26 = 1.1

			if var_335_25 <= arg_332_1.time_ and arg_332_1.time_ < var_335_25 + var_335_26 then
				local var_335_27 = (arg_332_1.time_ - var_335_25) / var_335_26
				local var_335_28 = Color.New(0, 0, 0)

				var_335_28.a = Mathf.Lerp(0, 1, var_335_27)
				arg_332_1.mask_.color = var_335_28
			end

			if arg_332_1.time_ >= var_335_25 + var_335_26 and arg_332_1.time_ < var_335_25 + var_335_26 + arg_335_0 then
				local var_335_29 = Color.New(0, 0, 0)

				var_335_29.a = 1
				arg_332_1.mask_.color = var_335_29
			end

			local var_335_30 = 1.1

			if var_335_30 < arg_332_1.time_ and arg_332_1.time_ <= var_335_30 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_31 = 0.933333333333333

			if var_335_30 <= arg_332_1.time_ and arg_332_1.time_ < var_335_30 + var_335_31 then
				local var_335_32 = (arg_332_1.time_ - var_335_30) / var_335_31
				local var_335_33 = Color.New(0, 0, 0)

				var_335_33.a = Mathf.Lerp(1, 0, var_335_32)
				arg_332_1.mask_.color = var_335_33
			end

			if arg_332_1.time_ >= var_335_30 + var_335_31 and arg_332_1.time_ < var_335_30 + var_335_31 + arg_335_0 then
				local var_335_34 = Color.New(0, 0, 0)
				local var_335_35 = 0

				arg_332_1.mask_.enabled = false
				var_335_34.a = var_335_35
				arg_332_1.mask_.color = var_335_34
			end

			local var_335_36 = 1.74848109856248
			local var_335_37 = 1.525

			if var_335_36 < arg_332_1.time_ and arg_332_1.time_ <= var_335_36 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_38 = arg_332_1:GetWordFromCfg(417131080)
				local var_335_39 = arg_332_1:FormatText(var_335_38.content)

				arg_332_1.text_.text = var_335_39

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_40 = 61
				local var_335_41 = utf8.len(var_335_39)
				local var_335_42 = var_335_40 <= 0 and var_335_37 or var_335_37 * (var_335_41 / var_335_40)

				if var_335_42 > 0 and var_335_37 < var_335_42 then
					arg_332_1.talkMaxDuration = var_335_42

					if var_335_42 + var_335_36 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_42 + var_335_36
					end
				end

				arg_332_1.text_.text = var_335_39
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_43 = math.max(var_335_37, arg_332_1.talkMaxDuration)

			if var_335_36 <= arg_332_1.time_ and arg_332_1.time_ < var_335_36 + var_335_43 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_36) / var_335_43

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_36 + var_335_43 and arg_332_1.time_ < var_335_36 + var_335_43 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play417131081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 417131081
		arg_336_1.duration_ = 3.2

		local var_336_0 = {
			zh = 3.2,
			ja = 1.5
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play417131082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.325

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[1113].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_3")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(417131081)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 13
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131081", "story_v_out_417131.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131081", "story_v_out_417131.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_417131", "417131081", "story_v_out_417131.awb")

						arg_336_1:RecordAudio("417131081", var_339_9)
						arg_336_1:RecordAudio("417131081", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_417131", "417131081", "story_v_out_417131.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_417131", "417131081", "story_v_out_417131.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play417131082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 417131082
		arg_340_1.duration_ = 8.69

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play417131083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = "SS1705"

			if arg_340_1.bgs_[var_343_0] == nil then
				local var_343_1 = Object.Instantiate(arg_340_1.paintGo_)

				var_343_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_343_0)
				var_343_1.name = var_343_0
				var_343_1.transform.parent = arg_340_1.stage_.transform
				var_343_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.bgs_[var_343_0] = var_343_1
			end

			local var_343_2 = 1.96666666666667

			if var_343_2 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				local var_343_3 = manager.ui.mainCamera.transform.localPosition
				local var_343_4 = Vector3.New(0, 0, 10) + Vector3.New(var_343_3.x, var_343_3.y, 0)
				local var_343_5 = arg_340_1.bgs_.SS1705

				var_343_5.transform.localPosition = var_343_4
				var_343_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_343_6 = var_343_5:GetComponent("SpriteRenderer")

				if var_343_6 and var_343_6.sprite then
					local var_343_7 = (var_343_5.transform.localPosition - var_343_3).z
					local var_343_8 = manager.ui.mainCameraCom_
					local var_343_9 = 2 * var_343_7 * Mathf.Tan(var_343_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_343_10 = var_343_9 * var_343_8.aspect
					local var_343_11 = var_343_6.sprite.bounds.size.x
					local var_343_12 = var_343_6.sprite.bounds.size.y
					local var_343_13 = var_343_10 / var_343_11
					local var_343_14 = var_343_9 / var_343_12
					local var_343_15 = var_343_14 < var_343_13 and var_343_13 or var_343_14

					var_343_5.transform.localScale = Vector3.New(var_343_15, var_343_15, 0)
				end

				for iter_343_0, iter_343_1 in pairs(arg_340_1.bgs_) do
					if iter_343_0 ~= "SS1705" then
						iter_343_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_343_16 = 1.96666666666667

			if var_343_16 < arg_340_1.time_ and arg_340_1.time_ <= var_343_16 + arg_343_0 then
				arg_340_1.allBtn_.enabled = false
			end

			local var_343_17 = 0.3

			if arg_340_1.time_ >= var_343_16 + var_343_17 and arg_340_1.time_ < var_343_16 + var_343_17 + arg_343_0 then
				arg_340_1.allBtn_.enabled = true
			end

			local var_343_18 = 0

			if var_343_18 < arg_340_1.time_ and arg_340_1.time_ <= var_343_18 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_19 = 2

			if var_343_18 <= arg_340_1.time_ and arg_340_1.time_ < var_343_18 + var_343_19 then
				local var_343_20 = (arg_340_1.time_ - var_343_18) / var_343_19
				local var_343_21 = Color.New(0, 0, 0)

				var_343_21.a = Mathf.Lerp(0, 1, var_343_20)
				arg_340_1.mask_.color = var_343_21
			end

			if arg_340_1.time_ >= var_343_18 + var_343_19 and arg_340_1.time_ < var_343_18 + var_343_19 + arg_343_0 then
				local var_343_22 = Color.New(0, 0, 0)

				var_343_22.a = 1
				arg_340_1.mask_.color = var_343_22
			end

			local var_343_23 = 2.00066666666667

			if var_343_23 < arg_340_1.time_ and arg_340_1.time_ <= var_343_23 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_24 = 2

			if var_343_23 <= arg_340_1.time_ and arg_340_1.time_ < var_343_23 + var_343_24 then
				local var_343_25 = (arg_340_1.time_ - var_343_23) / var_343_24
				local var_343_26 = Color.New(0, 0, 0)

				var_343_26.a = Mathf.Lerp(1, 0, var_343_25)
				arg_340_1.mask_.color = var_343_26
			end

			if arg_340_1.time_ >= var_343_23 + var_343_24 and arg_340_1.time_ < var_343_23 + var_343_24 + arg_343_0 then
				local var_343_27 = Color.New(0, 0, 0)
				local var_343_28 = 0

				arg_340_1.mask_.enabled = false
				var_343_27.a = var_343_28
				arg_340_1.mask_.color = var_343_27
			end

			local var_343_29 = arg_340_1.actors_["10115"]
			local var_343_30 = 1.96666666666667

			if var_343_30 < arg_340_1.time_ and arg_340_1.time_ <= var_343_30 + arg_343_0 and not isNil(var_343_29) and arg_340_1.var_.actorSpriteComps10115 == nil then
				arg_340_1.var_.actorSpriteComps10115 = var_343_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_31 = 0.2

			if var_343_30 <= arg_340_1.time_ and arg_340_1.time_ < var_343_30 + var_343_31 and not isNil(var_343_29) then
				local var_343_32 = (arg_340_1.time_ - var_343_30) / var_343_31

				if arg_340_1.var_.actorSpriteComps10115 then
					for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_343_3 then
							if arg_340_1.isInRecall_ then
								local var_343_33 = Mathf.Lerp(iter_343_3.color.r, arg_340_1.hightColor2.r, var_343_32)
								local var_343_34 = Mathf.Lerp(iter_343_3.color.g, arg_340_1.hightColor2.g, var_343_32)
								local var_343_35 = Mathf.Lerp(iter_343_3.color.b, arg_340_1.hightColor2.b, var_343_32)

								iter_343_3.color = Color.New(var_343_33, var_343_34, var_343_35)
							else
								local var_343_36 = Mathf.Lerp(iter_343_3.color.r, 0.5, var_343_32)

								iter_343_3.color = Color.New(var_343_36, var_343_36, var_343_36)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_30 + var_343_31 and arg_340_1.time_ < var_343_30 + var_343_31 + arg_343_0 and not isNil(var_343_29) and arg_340_1.var_.actorSpriteComps10115 then
				for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_343_5 then
						if arg_340_1.isInRecall_ then
							iter_343_5.color = arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_343_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps10115 = nil
			end

			local var_343_37 = arg_340_1.actors_["10115"].transform
			local var_343_38 = 1.96666666666667

			if var_343_38 < arg_340_1.time_ and arg_340_1.time_ <= var_343_38 + arg_343_0 then
				arg_340_1.var_.moveOldPos10115 = var_343_37.localPosition
				var_343_37.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10115", 7)

				local var_343_39 = var_343_37.childCount

				for iter_343_6 = 0, var_343_39 - 1 do
					local var_343_40 = var_343_37:GetChild(iter_343_6)

					if var_343_40.name == "" or not string.find(var_343_40.name, "split") then
						var_343_40.gameObject:SetActive(true)
					else
						var_343_40.gameObject:SetActive(false)
					end
				end
			end

			local var_343_41 = 0.001

			if var_343_38 <= arg_340_1.time_ and arg_340_1.time_ < var_343_38 + var_343_41 then
				local var_343_42 = (arg_340_1.time_ - var_343_38) / var_343_41
				local var_343_43 = Vector3.New(0, -2000, 0)

				var_343_37.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10115, var_343_43, var_343_42)
			end

			if arg_340_1.time_ >= var_343_38 + var_343_41 and arg_340_1.time_ < var_343_38 + var_343_41 + arg_343_0 then
				var_343_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_343_44 = 3.33333333333333
			local var_343_45 = 1

			if var_343_44 < arg_340_1.time_ and arg_340_1.time_ <= var_343_44 + arg_343_0 then
				local var_343_46 = "play"
				local var_343_47 = "effect"

				arg_340_1:AudioAction(var_343_46, var_343_47, "se_story_1310", "se_story_1310_footstep05", "")
			end

			if arg_340_1.frameCnt_ <= 1 then
				arg_340_1.dialog_:SetActive(false)
			end

			local var_343_48 = 3.68519694558345
			local var_343_49 = 1.275

			if var_343_48 < arg_340_1.time_ and arg_340_1.time_ <= var_343_48 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0

				arg_340_1.dialog_:SetActive(true)

				arg_340_1.dialogCg_.alpha = 0

				local var_343_50 = LeanTween.value(arg_340_1.dialog_, 0, 1, 0.3)

				var_343_50:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_340_1.dialogCg_.alpha = arg_344_0
				end))
				var_343_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_340_1.dialog_)
					var_343_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_340_1.duration_ = arg_340_1.duration_ + 0.3

				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_51 = arg_340_1:GetWordFromCfg(417131082)
				local var_343_52 = arg_340_1:FormatText(var_343_51.content)

				arg_340_1.text_.text = var_343_52

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_53 = 51
				local var_343_54 = utf8.len(var_343_52)
				local var_343_55 = var_343_53 <= 0 and var_343_49 or var_343_49 * (var_343_54 / var_343_53)

				if var_343_55 > 0 and var_343_49 < var_343_55 then
					arg_340_1.talkMaxDuration = var_343_55
					var_343_48 = var_343_48 + 0.3

					if var_343_55 + var_343_48 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_55 + var_343_48
					end
				end

				arg_340_1.text_.text = var_343_52
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_56 = var_343_48 + 0.3
			local var_343_57 = math.max(var_343_49, arg_340_1.talkMaxDuration)

			if var_343_56 <= arg_340_1.time_ and arg_340_1.time_ < var_343_56 + var_343_57 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_56) / var_343_57

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_56 + var_343_57 and arg_340_1.time_ < var_343_56 + var_343_57 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play417131083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417131083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play417131084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 1.025

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

				local var_349_2 = arg_346_1:GetWordFromCfg(417131083)
				local var_349_3 = arg_346_1:FormatText(var_349_2.content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 41
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
	Play417131084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417131084
		arg_350_1.duration_ = 6.67

		local var_350_0 = {
			zh = 4.3,
			ja = 6.666
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417131085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1034"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1034 == nil then
				arg_350_1.var_.actorSpriteComps1034 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps1034 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 1, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1034 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps1034 = nil
			end

			local var_353_8 = 0
			local var_353_9 = 0.225

			if var_353_8 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_10 = arg_350_1:FormatText(StoryNameCfg[1109].name)

				arg_350_1.leftNameTxt_.text = var_353_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_11 = arg_350_1:GetWordFromCfg(417131084)
				local var_353_12 = arg_350_1:FormatText(var_353_11.content)

				arg_350_1.text_.text = var_353_12

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_13 = 9
				local var_353_14 = utf8.len(var_353_12)
				local var_353_15 = var_353_13 <= 0 and var_353_9 or var_353_9 * (var_353_14 / var_353_13)

				if var_353_15 > 0 and var_353_9 < var_353_15 then
					arg_350_1.talkMaxDuration = var_353_15

					if var_353_15 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_15 + var_353_8
					end
				end

				arg_350_1.text_.text = var_353_12
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131084", "story_v_out_417131.awb") ~= 0 then
					local var_353_16 = manager.audio:GetVoiceLength("story_v_out_417131", "417131084", "story_v_out_417131.awb") / 1000

					if var_353_16 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_16 + var_353_8
					end

					if var_353_11.prefab_name ~= "" and arg_350_1.actors_[var_353_11.prefab_name] ~= nil then
						local var_353_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_11.prefab_name].transform, "story_v_out_417131", "417131084", "story_v_out_417131.awb")

						arg_350_1:RecordAudio("417131084", var_353_17)
						arg_350_1:RecordAudio("417131084", var_353_17)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417131", "417131084", "story_v_out_417131.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417131", "417131084", "story_v_out_417131.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_18 = math.max(var_353_9, arg_350_1.talkMaxDuration)

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_18 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_8) / var_353_18

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_8 + var_353_18 and arg_350_1.time_ < var_353_8 + var_353_18 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417131085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417131085
		arg_354_1.duration_ = 6.13

		local var_354_0 = {
			zh = 4.033,
			ja = 6.133
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417131086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10115"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10115 == nil then
				arg_354_1.var_.actorSpriteComps10115 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps10115 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 1, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10115 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_357_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps10115 = nil
			end

			local var_357_8 = arg_354_1.actors_["1034"]
			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 and not isNil(var_357_8) and arg_354_1.var_.actorSpriteComps1034 == nil then
				arg_354_1.var_.actorSpriteComps1034 = var_357_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_10 = 0.2

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_10 and not isNil(var_357_8) then
				local var_357_11 = (arg_354_1.time_ - var_357_9) / var_357_10

				if arg_354_1.var_.actorSpriteComps1034 then
					for iter_357_4, iter_357_5 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_357_5 then
							if arg_354_1.isInRecall_ then
								local var_357_12 = Mathf.Lerp(iter_357_5.color.r, arg_354_1.hightColor2.r, var_357_11)
								local var_357_13 = Mathf.Lerp(iter_357_5.color.g, arg_354_1.hightColor2.g, var_357_11)
								local var_357_14 = Mathf.Lerp(iter_357_5.color.b, arg_354_1.hightColor2.b, var_357_11)

								iter_357_5.color = Color.New(var_357_12, var_357_13, var_357_14)
							else
								local var_357_15 = Mathf.Lerp(iter_357_5.color.r, 0.5, var_357_11)

								iter_357_5.color = Color.New(var_357_15, var_357_15, var_357_15)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_9 + var_357_10 and arg_354_1.time_ < var_357_9 + var_357_10 + arg_357_0 and not isNil(var_357_8) and arg_354_1.var_.actorSpriteComps1034 then
				for iter_357_6, iter_357_7 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_357_7 then
						if arg_354_1.isInRecall_ then
							iter_357_7.color = arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_357_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps1034 = nil
			end

			local var_357_16 = 0
			local var_357_17 = 0.375

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_18 = arg_354_1:FormatText(StoryNameCfg[1113].name)

				arg_354_1.leftNameTxt_.text = var_357_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_19 = arg_354_1:GetWordFromCfg(417131085)
				local var_357_20 = arg_354_1:FormatText(var_357_19.content)

				arg_354_1.text_.text = var_357_20

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_21 = 15
				local var_357_22 = utf8.len(var_357_20)
				local var_357_23 = var_357_21 <= 0 and var_357_17 or var_357_17 * (var_357_22 / var_357_21)

				if var_357_23 > 0 and var_357_17 < var_357_23 then
					arg_354_1.talkMaxDuration = var_357_23

					if var_357_23 + var_357_16 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_16
					end
				end

				arg_354_1.text_.text = var_357_20
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131085", "story_v_out_417131.awb") ~= 0 then
					local var_357_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131085", "story_v_out_417131.awb") / 1000

					if var_357_24 + var_357_16 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_24 + var_357_16
					end

					if var_357_19.prefab_name ~= "" and arg_354_1.actors_[var_357_19.prefab_name] ~= nil then
						local var_357_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_19.prefab_name].transform, "story_v_out_417131", "417131085", "story_v_out_417131.awb")

						arg_354_1:RecordAudio("417131085", var_357_25)
						arg_354_1:RecordAudio("417131085", var_357_25)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417131", "417131085", "story_v_out_417131.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417131", "417131085", "story_v_out_417131.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_26 = math.max(var_357_17, arg_354_1.talkMaxDuration)

			if var_357_16 <= arg_354_1.time_ and arg_354_1.time_ < var_357_16 + var_357_26 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_16) / var_357_26

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_16 + var_357_26 and arg_354_1.time_ < var_357_16 + var_357_26 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417131086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417131086
		arg_358_1.duration_ = 9.03

		local var_358_0 = {
			zh = 7.066,
			ja = 9.033
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417131087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1034"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1034 == nil then
				arg_358_1.var_.actorSpriteComps1034 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps1034 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 1, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1034 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1034 = nil
			end

			local var_361_8 = arg_358_1.actors_["10115"]
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps10115 == nil then
				arg_358_1.var_.actorSpriteComps10115 = var_361_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_10 = 0.2

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_10 and not isNil(var_361_8) then
				local var_361_11 = (arg_358_1.time_ - var_361_9) / var_361_10

				if arg_358_1.var_.actorSpriteComps10115 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								local var_361_12 = Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, var_361_11)
								local var_361_13 = Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, var_361_11)
								local var_361_14 = Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, var_361_11)

								iter_361_5.color = Color.New(var_361_12, var_361_13, var_361_14)
							else
								local var_361_15 = Mathf.Lerp(iter_361_5.color.r, 0.5, var_361_11)

								iter_361_5.color = Color.New(var_361_15, var_361_15, var_361_15)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_9 + var_361_10 and arg_358_1.time_ < var_361_9 + var_361_10 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps10115 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_361_7 then
						if arg_358_1.isInRecall_ then
							iter_361_7.color = arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_361_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps10115 = nil
			end

			local var_361_16 = 0
			local var_361_17 = 0.525

			if var_361_16 < arg_358_1.time_ and arg_358_1.time_ <= var_361_16 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_18 = arg_358_1:FormatText(StoryNameCfg[1109].name)

				arg_358_1.leftNameTxt_.text = var_361_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_19 = arg_358_1:GetWordFromCfg(417131086)
				local var_361_20 = arg_358_1:FormatText(var_361_19.content)

				arg_358_1.text_.text = var_361_20

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_21 = 21
				local var_361_22 = utf8.len(var_361_20)
				local var_361_23 = var_361_21 <= 0 and var_361_17 or var_361_17 * (var_361_22 / var_361_21)

				if var_361_23 > 0 and var_361_17 < var_361_23 then
					arg_358_1.talkMaxDuration = var_361_23

					if var_361_23 + var_361_16 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_23 + var_361_16
					end
				end

				arg_358_1.text_.text = var_361_20
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131086", "story_v_out_417131.awb") ~= 0 then
					local var_361_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131086", "story_v_out_417131.awb") / 1000

					if var_361_24 + var_361_16 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_24 + var_361_16
					end

					if var_361_19.prefab_name ~= "" and arg_358_1.actors_[var_361_19.prefab_name] ~= nil then
						local var_361_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_19.prefab_name].transform, "story_v_out_417131", "417131086", "story_v_out_417131.awb")

						arg_358_1:RecordAudio("417131086", var_361_25)
						arg_358_1:RecordAudio("417131086", var_361_25)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417131", "417131086", "story_v_out_417131.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417131", "417131086", "story_v_out_417131.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_26 = math.max(var_361_17, arg_358_1.talkMaxDuration)

			if var_361_16 <= arg_358_1.time_ and arg_358_1.time_ < var_361_16 + var_361_26 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_16) / var_361_26

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_16 + var_361_26 and arg_358_1.time_ < var_361_16 + var_361_26 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417131087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417131087
		arg_362_1.duration_ = 9.7

		local var_362_0 = {
			zh = 8.433,
			ja = 9.7
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417131088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10115"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10115 == nil then
				arg_362_1.var_.actorSpriteComps10115 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.2

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps10115 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								local var_365_4 = Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, var_365_3)
								local var_365_5 = Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, var_365_3)
								local var_365_6 = Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, var_365_3)

								iter_365_1.color = Color.New(var_365_4, var_365_5, var_365_6)
							else
								local var_365_7 = Mathf.Lerp(iter_365_1.color.r, 1, var_365_3)

								iter_365_1.color = Color.New(var_365_7, var_365_7, var_365_7)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10115 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps10115 = nil
			end

			local var_365_8 = arg_362_1.actors_["1034"]
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1034 == nil then
				arg_362_1.var_.actorSpriteComps1034 = var_365_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_10 = 0.2

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_10 and not isNil(var_365_8) then
				local var_365_11 = (arg_362_1.time_ - var_365_9) / var_365_10

				if arg_362_1.var_.actorSpriteComps1034 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								local var_365_12 = Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, var_365_11)
								local var_365_13 = Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, var_365_11)
								local var_365_14 = Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, var_365_11)

								iter_365_5.color = Color.New(var_365_12, var_365_13, var_365_14)
							else
								local var_365_15 = Mathf.Lerp(iter_365_5.color.r, 0.5, var_365_11)

								iter_365_5.color = Color.New(var_365_15, var_365_15, var_365_15)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_9 + var_365_10 and arg_362_1.time_ < var_365_9 + var_365_10 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1034 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_365_7 then
						if arg_362_1.isInRecall_ then
							iter_365_7.color = arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_365_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1034 = nil
			end

			local var_365_16 = 0
			local var_365_17 = 0.95

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_18 = arg_362_1:FormatText(StoryNameCfg[1113].name)

				arg_362_1.leftNameTxt_.text = var_365_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_19 = arg_362_1:GetWordFromCfg(417131087)
				local var_365_20 = arg_362_1:FormatText(var_365_19.content)

				arg_362_1.text_.text = var_365_20

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_21 = 38
				local var_365_22 = utf8.len(var_365_20)
				local var_365_23 = var_365_21 <= 0 and var_365_17 or var_365_17 * (var_365_22 / var_365_21)

				if var_365_23 > 0 and var_365_17 < var_365_23 then
					arg_362_1.talkMaxDuration = var_365_23

					if var_365_23 + var_365_16 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_16
					end
				end

				arg_362_1.text_.text = var_365_20
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131087", "story_v_out_417131.awb") ~= 0 then
					local var_365_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131087", "story_v_out_417131.awb") / 1000

					if var_365_24 + var_365_16 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_24 + var_365_16
					end

					if var_365_19.prefab_name ~= "" and arg_362_1.actors_[var_365_19.prefab_name] ~= nil then
						local var_365_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_19.prefab_name].transform, "story_v_out_417131", "417131087", "story_v_out_417131.awb")

						arg_362_1:RecordAudio("417131087", var_365_25)
						arg_362_1:RecordAudio("417131087", var_365_25)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_417131", "417131087", "story_v_out_417131.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_417131", "417131087", "story_v_out_417131.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_26 = math.max(var_365_17, arg_362_1.talkMaxDuration)

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_26 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_16) / var_365_26

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_16 + var_365_26 and arg_362_1.time_ < var_365_16 + var_365_26 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417131088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417131088
		arg_366_1.duration_ = 5

		local var_366_0 = {
			zh = 3.833,
			ja = 5
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417131089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 0.525

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_2 = arg_366_1:FormatText(StoryNameCfg[1113].name)

				arg_366_1.leftNameTxt_.text = var_369_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_3 = arg_366_1:GetWordFromCfg(417131088)
				local var_369_4 = arg_366_1:FormatText(var_369_3.content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 21
				local var_369_6 = utf8.len(var_369_4)
				local var_369_7 = var_369_5 <= 0 and var_369_1 or var_369_1 * (var_369_6 / var_369_5)

				if var_369_7 > 0 and var_369_1 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131088", "story_v_out_417131.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131088", "story_v_out_417131.awb") / 1000

					if var_369_8 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_0
					end

					if var_369_3.prefab_name ~= "" and arg_366_1.actors_[var_369_3.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_3.prefab_name].transform, "story_v_out_417131", "417131088", "story_v_out_417131.awb")

						arg_366_1:RecordAudio("417131088", var_369_9)
						arg_366_1:RecordAudio("417131088", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417131", "417131088", "story_v_out_417131.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417131", "417131088", "story_v_out_417131.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_10 and arg_366_1.time_ < var_369_0 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play417131089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417131089
		arg_370_1.duration_ = 6.73

		local var_370_0 = {
			zh = 3.46633333333333,
			ja = 6.73333333333333
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417131090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1034"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1034 == nil then
				arg_370_1.var_.actorSpriteComps1034 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps1034 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								local var_373_4 = Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, var_373_3)
								local var_373_5 = Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, var_373_3)
								local var_373_6 = Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, var_373_3)

								iter_373_1.color = Color.New(var_373_4, var_373_5, var_373_6)
							else
								local var_373_7 = Mathf.Lerp(iter_373_1.color.r, 1, var_373_3)

								iter_373_1.color = Color.New(var_373_7, var_373_7, var_373_7)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1034 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1034 = nil
			end

			local var_373_8 = arg_370_1.actors_["10115"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10115 == nil then
				arg_370_1.var_.actorSpriteComps10115 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps10115 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								local var_373_12 = Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, var_373_11)
								local var_373_13 = Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, var_373_11)
								local var_373_14 = Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, var_373_11)

								iter_373_5.color = Color.New(var_373_12, var_373_13, var_373_14)
							else
								local var_373_15 = Mathf.Lerp(iter_373_5.color.r, 0.5, var_373_11)

								iter_373_5.color = Color.New(var_373_15, var_373_15, var_373_15)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10115 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10115 = nil
			end

			local var_373_16 = arg_370_1.bgs_.SS1705.transform
			local var_373_17 = 0

			if var_373_17 < arg_370_1.time_ and arg_370_1.time_ <= var_373_17 + arg_373_0 then
				arg_370_1.var_.moveOldPosSS1705 = var_373_16.localPosition
			end

			local var_373_18 = 0.001

			if var_373_17 <= arg_370_1.time_ and arg_370_1.time_ < var_373_17 + var_373_18 then
				local var_373_19 = (arg_370_1.time_ - var_373_17) / var_373_18
				local var_373_20 = Vector3.New(0, 1, 10)

				var_373_16.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPosSS1705, var_373_20, var_373_19)
			end

			if arg_370_1.time_ >= var_373_17 + var_373_18 and arg_370_1.time_ < var_373_17 + var_373_18 + arg_373_0 then
				var_373_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_373_21 = arg_370_1.bgs_.SS1705.transform
			local var_373_22 = 0.0166666666666667

			if var_373_22 < arg_370_1.time_ and arg_370_1.time_ <= var_373_22 + arg_373_0 then
				arg_370_1.var_.moveOldPosSS1705 = var_373_21.localPosition
			end

			local var_373_23 = 2.61666666666667

			if var_373_22 <= arg_370_1.time_ and arg_370_1.time_ < var_373_22 + var_373_23 then
				local var_373_24 = (arg_370_1.time_ - var_373_22) / var_373_23
				local var_373_25 = Vector3.New(0, 0.82, 8.38)

				var_373_21.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPosSS1705, var_373_25, var_373_24)
			end

			if arg_370_1.time_ >= var_373_22 + var_373_23 and arg_370_1.time_ < var_373_22 + var_373_23 + arg_373_0 then
				var_373_21.localPosition = Vector3.New(0, 0.82, 8.38)
			end

			local var_373_26 = 0

			if var_373_26 < arg_370_1.time_ and arg_370_1.time_ <= var_373_26 + arg_373_0 then
				arg_370_1.allBtn_.enabled = false
			end

			local var_373_27 = 2.51666666666667

			if arg_370_1.time_ >= var_373_26 + var_373_27 and arg_370_1.time_ < var_373_26 + var_373_27 + arg_373_0 then
				arg_370_1.allBtn_.enabled = true
			end

			if arg_370_1.frameCnt_ <= 1 then
				arg_370_1.dialog_:SetActive(false)
			end

			local var_373_28 = 1.63333333333333
			local var_373_29 = 0.275

			if var_373_28 < arg_370_1.time_ and arg_370_1.time_ <= var_373_28 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				arg_370_1.dialog_:SetActive(true)

				arg_370_1.dialogCg_.alpha = 0

				local var_373_30 = LeanTween.value(arg_370_1.dialog_, 0, 1, 0.3)

				var_373_30:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_370_1.dialogCg_.alpha = arg_374_0
				end))
				var_373_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_370_1.dialog_)
					var_373_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_370_1.duration_ = arg_370_1.duration_ + 0.3

				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_31 = arg_370_1:FormatText(StoryNameCfg[1109].name)

				arg_370_1.leftNameTxt_.text = var_373_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_32 = arg_370_1:GetWordFromCfg(417131089)
				local var_373_33 = arg_370_1:FormatText(var_373_32.content)

				arg_370_1.text_.text = var_373_33

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_34 = 11
				local var_373_35 = utf8.len(var_373_33)
				local var_373_36 = var_373_34 <= 0 and var_373_29 or var_373_29 * (var_373_35 / var_373_34)

				if var_373_36 > 0 and var_373_29 < var_373_36 then
					arg_370_1.talkMaxDuration = var_373_36
					var_373_28 = var_373_28 + 0.3

					if var_373_36 + var_373_28 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_36 + var_373_28
					end
				end

				arg_370_1.text_.text = var_373_33
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131089", "story_v_out_417131.awb") ~= 0 then
					local var_373_37 = manager.audio:GetVoiceLength("story_v_out_417131", "417131089", "story_v_out_417131.awb") / 1000

					if var_373_37 + var_373_28 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_37 + var_373_28
					end

					if var_373_32.prefab_name ~= "" and arg_370_1.actors_[var_373_32.prefab_name] ~= nil then
						local var_373_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_32.prefab_name].transform, "story_v_out_417131", "417131089", "story_v_out_417131.awb")

						arg_370_1:RecordAudio("417131089", var_373_38)
						arg_370_1:RecordAudio("417131089", var_373_38)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417131", "417131089", "story_v_out_417131.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417131", "417131089", "story_v_out_417131.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_39 = var_373_28 + 0.3
			local var_373_40 = math.max(var_373_29, arg_370_1.talkMaxDuration)

			if var_373_39 <= arg_370_1.time_ and arg_370_1.time_ < var_373_39 + var_373_40 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_39) / var_373_40

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_39 + var_373_40 and arg_370_1.time_ < var_373_39 + var_373_40 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1705",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1705",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.61666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play417131090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 417131090
		arg_376_1.duration_ = 3.27

		local var_376_0 = {
			zh = 2.1,
			ja = 3.266
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play417131091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10115"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps10115 == nil then
				arg_376_1.var_.actorSpriteComps10115 = var_379_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.actorSpriteComps10115 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								local var_379_4 = Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, var_379_3)
								local var_379_5 = Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, var_379_3)
								local var_379_6 = Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, var_379_3)

								iter_379_1.color = Color.New(var_379_4, var_379_5, var_379_6)
							else
								local var_379_7 = Mathf.Lerp(iter_379_1.color.r, 1, var_379_3)

								iter_379_1.color = Color.New(var_379_7, var_379_7, var_379_7)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps10115 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_379_3 then
						if arg_376_1.isInRecall_ then
							iter_379_3.color = arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_379_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps10115 = nil
			end

			local var_379_8 = arg_376_1.actors_["1034"]
			local var_379_9 = 0

			if var_379_9 < arg_376_1.time_ and arg_376_1.time_ <= var_379_9 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps1034 == nil then
				arg_376_1.var_.actorSpriteComps1034 = var_379_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_10 = 0.2

			if var_379_9 <= arg_376_1.time_ and arg_376_1.time_ < var_379_9 + var_379_10 and not isNil(var_379_8) then
				local var_379_11 = (arg_376_1.time_ - var_379_9) / var_379_10

				if arg_376_1.var_.actorSpriteComps1034 then
					for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_379_5 then
							if arg_376_1.isInRecall_ then
								local var_379_12 = Mathf.Lerp(iter_379_5.color.r, arg_376_1.hightColor2.r, var_379_11)
								local var_379_13 = Mathf.Lerp(iter_379_5.color.g, arg_376_1.hightColor2.g, var_379_11)
								local var_379_14 = Mathf.Lerp(iter_379_5.color.b, arg_376_1.hightColor2.b, var_379_11)

								iter_379_5.color = Color.New(var_379_12, var_379_13, var_379_14)
							else
								local var_379_15 = Mathf.Lerp(iter_379_5.color.r, 0.5, var_379_11)

								iter_379_5.color = Color.New(var_379_15, var_379_15, var_379_15)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_9 + var_379_10 and arg_376_1.time_ < var_379_9 + var_379_10 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps1034 then
				for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_379_7 then
						if arg_376_1.isInRecall_ then
							iter_379_7.color = arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_379_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps1034 = nil
			end

			local var_379_16 = 0
			local var_379_17 = 0.25

			if var_379_16 < arg_376_1.time_ and arg_376_1.time_ <= var_379_16 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_18 = arg_376_1:FormatText(StoryNameCfg[1113].name)

				arg_376_1.leftNameTxt_.text = var_379_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_19 = arg_376_1:GetWordFromCfg(417131090)
				local var_379_20 = arg_376_1:FormatText(var_379_19.content)

				arg_376_1.text_.text = var_379_20

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_21 = 10
				local var_379_22 = utf8.len(var_379_20)
				local var_379_23 = var_379_21 <= 0 and var_379_17 or var_379_17 * (var_379_22 / var_379_21)

				if var_379_23 > 0 and var_379_17 < var_379_23 then
					arg_376_1.talkMaxDuration = var_379_23

					if var_379_23 + var_379_16 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_23 + var_379_16
					end
				end

				arg_376_1.text_.text = var_379_20
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131090", "story_v_out_417131.awb") ~= 0 then
					local var_379_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131090", "story_v_out_417131.awb") / 1000

					if var_379_24 + var_379_16 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_24 + var_379_16
					end

					if var_379_19.prefab_name ~= "" and arg_376_1.actors_[var_379_19.prefab_name] ~= nil then
						local var_379_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_19.prefab_name].transform, "story_v_out_417131", "417131090", "story_v_out_417131.awb")

						arg_376_1:RecordAudio("417131090", var_379_25)
						arg_376_1:RecordAudio("417131090", var_379_25)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_417131", "417131090", "story_v_out_417131.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_417131", "417131090", "story_v_out_417131.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_26 = math.max(var_379_17, arg_376_1.talkMaxDuration)

			if var_379_16 <= arg_376_1.time_ and arg_376_1.time_ < var_379_16 + var_379_26 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_16) / var_379_26

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_16 + var_379_26 and arg_376_1.time_ < var_379_16 + var_379_26 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play417131091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417131091
		arg_380_1.duration_ = 7.13

		local var_380_0 = {
			zh = 7.133,
			ja = 6.6
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play417131092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1034"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1034 == nil then
				arg_380_1.var_.actorSpriteComps1034 = var_383_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_2 = 0.2

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.actorSpriteComps1034 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								local var_383_4 = Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor1.r, var_383_3)
								local var_383_5 = Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor1.g, var_383_3)
								local var_383_6 = Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor1.b, var_383_3)

								iter_383_1.color = Color.New(var_383_4, var_383_5, var_383_6)
							else
								local var_383_7 = Mathf.Lerp(iter_383_1.color.r, 1, var_383_3)

								iter_383_1.color = Color.New(var_383_7, var_383_7, var_383_7)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1034 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_383_3 then
						if arg_380_1.isInRecall_ then
							iter_383_3.color = arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_383_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps1034 = nil
			end

			local var_383_8 = arg_380_1.actors_["10115"]
			local var_383_9 = 0

			if var_383_9 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps10115 == nil then
				arg_380_1.var_.actorSpriteComps10115 = var_383_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_10 = 0.2

			if var_383_9 <= arg_380_1.time_ and arg_380_1.time_ < var_383_9 + var_383_10 and not isNil(var_383_8) then
				local var_383_11 = (arg_380_1.time_ - var_383_9) / var_383_10

				if arg_380_1.var_.actorSpriteComps10115 then
					for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_383_5 then
							if arg_380_1.isInRecall_ then
								local var_383_12 = Mathf.Lerp(iter_383_5.color.r, arg_380_1.hightColor2.r, var_383_11)
								local var_383_13 = Mathf.Lerp(iter_383_5.color.g, arg_380_1.hightColor2.g, var_383_11)
								local var_383_14 = Mathf.Lerp(iter_383_5.color.b, arg_380_1.hightColor2.b, var_383_11)

								iter_383_5.color = Color.New(var_383_12, var_383_13, var_383_14)
							else
								local var_383_15 = Mathf.Lerp(iter_383_5.color.r, 0.5, var_383_11)

								iter_383_5.color = Color.New(var_383_15, var_383_15, var_383_15)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_9 + var_383_10 and arg_380_1.time_ < var_383_9 + var_383_10 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps10115 then
				for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_383_7 then
						if arg_380_1.isInRecall_ then
							iter_383_7.color = arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_383_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps10115 = nil
			end

			local var_383_16 = 0
			local var_383_17 = 0.6

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_18 = arg_380_1:FormatText(StoryNameCfg[1109].name)

				arg_380_1.leftNameTxt_.text = var_383_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_19 = arg_380_1:GetWordFromCfg(417131091)
				local var_383_20 = arg_380_1:FormatText(var_383_19.content)

				arg_380_1.text_.text = var_383_20

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_21 = 24
				local var_383_22 = utf8.len(var_383_20)
				local var_383_23 = var_383_21 <= 0 and var_383_17 or var_383_17 * (var_383_22 / var_383_21)

				if var_383_23 > 0 and var_383_17 < var_383_23 then
					arg_380_1.talkMaxDuration = var_383_23

					if var_383_23 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_23 + var_383_16
					end
				end

				arg_380_1.text_.text = var_383_20
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131091", "story_v_out_417131.awb") ~= 0 then
					local var_383_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131091", "story_v_out_417131.awb") / 1000

					if var_383_24 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_24 + var_383_16
					end

					if var_383_19.prefab_name ~= "" and arg_380_1.actors_[var_383_19.prefab_name] ~= nil then
						local var_383_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_19.prefab_name].transform, "story_v_out_417131", "417131091", "story_v_out_417131.awb")

						arg_380_1:RecordAudio("417131091", var_383_25)
						arg_380_1:RecordAudio("417131091", var_383_25)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_417131", "417131091", "story_v_out_417131.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_417131", "417131091", "story_v_out_417131.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_26 = math.max(var_383_17, arg_380_1.talkMaxDuration)

			if var_383_16 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_26 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_16) / var_383_26

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_16 + var_383_26 and arg_380_1.time_ < var_383_16 + var_383_26 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play417131092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417131092
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417131093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1034"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1034 == nil then
				arg_384_1.var_.actorSpriteComps1034 = var_387_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.actorSpriteComps1034 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								local var_387_4 = Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor2.r, var_387_3)
								local var_387_5 = Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor2.g, var_387_3)
								local var_387_6 = Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor2.b, var_387_3)

								iter_387_1.color = Color.New(var_387_4, var_387_5, var_387_6)
							else
								local var_387_7 = Mathf.Lerp(iter_387_1.color.r, 0.5, var_387_3)

								iter_387_1.color = Color.New(var_387_7, var_387_7, var_387_7)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1034 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_387_3 then
						if arg_384_1.isInRecall_ then
							iter_387_3.color = arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_387_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_384_1.var_.actorSpriteComps1034 = nil
			end

			local var_387_8 = 0
			local var_387_9 = 1.1

			if var_387_8 < arg_384_1.time_ and arg_384_1.time_ <= var_387_8 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_10 = arg_384_1:GetWordFromCfg(417131092)
				local var_387_11 = arg_384_1:FormatText(var_387_10.content)

				arg_384_1.text_.text = var_387_11

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_12 = 44
				local var_387_13 = utf8.len(var_387_11)
				local var_387_14 = var_387_12 <= 0 and var_387_9 or var_387_9 * (var_387_13 / var_387_12)

				if var_387_14 > 0 and var_387_9 < var_387_14 then
					arg_384_1.talkMaxDuration = var_387_14

					if var_387_14 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_8
					end
				end

				arg_384_1.text_.text = var_387_11
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_15 = math.max(var_387_9, arg_384_1.talkMaxDuration)

			if var_387_8 <= arg_384_1.time_ and arg_384_1.time_ < var_387_8 + var_387_15 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_8) / var_387_15

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_8 + var_387_15 and arg_384_1.time_ < var_387_8 + var_387_15 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play417131093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417131093
		arg_388_1.duration_ = 7.23

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play417131094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1034"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1034 == nil then
				arg_388_1.var_.actorSpriteComps1034 = var_391_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.actorSpriteComps1034 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								local var_391_4 = Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor1.r, var_391_3)
								local var_391_5 = Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor1.g, var_391_3)
								local var_391_6 = Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor1.b, var_391_3)

								iter_391_1.color = Color.New(var_391_4, var_391_5, var_391_6)
							else
								local var_391_7 = Mathf.Lerp(iter_391_1.color.r, 1, var_391_3)

								iter_391_1.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1034 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_391_3 then
						if arg_388_1.isInRecall_ then
							iter_391_3.color = arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_391_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps1034 = nil
			end

			local var_391_8 = 1.3

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				local var_391_9 = arg_388_1.fswbg_.transform:Find("textbox/adapt/content") or arg_388_1.fswbg_.transform:Find("textbox/content")
				local var_391_10 = arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_391_11 = var_391_9:GetComponent("Text")
				local var_391_12 = var_391_9:GetComponent("RectTransform")

				var_391_11.alignment = UnityEngine.TextAnchor.LowerCenter
				var_391_12.offsetMin = Vector2.New(0, 0)
				var_391_12.offsetMax = Vector2.New(0, 0)
			end

			local var_391_13 = 1.3

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1.fswbg_:SetActive(true)
				arg_388_1.dialog_:SetActive(false)

				arg_388_1.fswtw_.percent = 0

				local var_391_14 = arg_388_1:GetWordFromCfg(417131093)
				local var_391_15 = arg_388_1:FormatText(var_391_14.content)

				arg_388_1.fswt_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.fswt_)

				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_388_1.fswtw_:SetDirty()

				arg_388_1.typewritterCharCountI18N = 0

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_16 = 2.3

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.var_.oldValueTypewriter = arg_388_1.fswtw_.percent

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_17 = 16
			local var_391_18 = 1.06666666666667
			local var_391_19 = arg_388_1:GetWordFromCfg(417131093)
			local var_391_20 = arg_388_1:FormatText(var_391_19.content)
			local var_391_21, var_391_22 = arg_388_1:GetPercentByPara(var_391_20, 1)

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				local var_391_23 = var_391_17 <= 0 and var_391_18 or var_391_18 * ((var_391_22 - arg_388_1.typewritterCharCountI18N) / var_391_17)

				if var_391_23 > 0 and var_391_18 < var_391_23 then
					arg_388_1.talkMaxDuration = var_391_23

					if var_391_23 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_16
					end
				end
			end

			local var_391_24 = 1.06666666666667
			local var_391_25 = math.max(var_391_24, arg_388_1.talkMaxDuration)

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_25 then
				local var_391_26 = (arg_388_1.time_ - var_391_16) / var_391_25

				arg_388_1.fswtw_.percent = Mathf.Lerp(arg_388_1.var_.oldValueTypewriter, var_391_21, var_391_26)
				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.fswtw_:SetDirty()
			end

			if arg_388_1.time_ >= var_391_16 + var_391_25 and arg_388_1.time_ < var_391_16 + var_391_25 + arg_391_0 then
				arg_388_1.fswtw_.percent = var_391_21

				arg_388_1.fswtw_:SetDirty()
				arg_388_1:ShowNextGo(true)

				arg_388_1.typewritterCharCountI18N = var_391_22
			end

			local var_391_27 = 0

			if var_391_27 < arg_388_1.time_ and arg_388_1.time_ <= var_391_27 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_28 = 1.3

			if var_391_27 <= arg_388_1.time_ and arg_388_1.time_ < var_391_27 + var_391_28 then
				local var_391_29 = (arg_388_1.time_ - var_391_27) / var_391_28
				local var_391_30 = Color.New(0, 0, 0)

				var_391_30.a = Mathf.Lerp(0, 1, var_391_29)
				arg_388_1.mask_.color = var_391_30
			end

			if arg_388_1.time_ >= var_391_27 + var_391_28 and arg_388_1.time_ < var_391_27 + var_391_28 + arg_391_0 then
				local var_391_31 = Color.New(0, 0, 0)

				var_391_31.a = 1
				arg_388_1.mask_.color = var_391_31
			end

			local var_391_32 = 1.3

			if var_391_32 < arg_388_1.time_ and arg_388_1.time_ <= var_391_32 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_33 = 2

			if var_391_32 <= arg_388_1.time_ and arg_388_1.time_ < var_391_32 + var_391_33 then
				local var_391_34 = (arg_388_1.time_ - var_391_32) / var_391_33
				local var_391_35 = Color.New(0, 0, 0)

				var_391_35.a = Mathf.Lerp(1, 0, var_391_34)
				arg_388_1.mask_.color = var_391_35
			end

			if arg_388_1.time_ >= var_391_32 + var_391_33 and arg_388_1.time_ < var_391_32 + var_391_33 + arg_391_0 then
				local var_391_36 = Color.New(0, 0, 0)
				local var_391_37 = 0

				arg_388_1.mask_.enabled = false
				var_391_36.a = var_391_37
				arg_388_1.mask_.color = var_391_36
			end

			local var_391_38 = 1.3

			if var_391_38 < arg_388_1.time_ and arg_388_1.time_ <= var_391_38 + arg_391_0 then
				local var_391_39 = manager.ui.mainCamera.transform.localPosition
				local var_391_40 = Vector3.New(0, 0, 10) + Vector3.New(var_391_39.x, var_391_39.y, 0)
				local var_391_41 = arg_388_1.bgs_.STblack

				var_391_41.transform.localPosition = var_391_40
				var_391_41.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_42 = var_391_41:GetComponent("SpriteRenderer")

				if var_391_42 and var_391_42.sprite then
					local var_391_43 = (var_391_41.transform.localPosition - var_391_39).z
					local var_391_44 = manager.ui.mainCameraCom_
					local var_391_45 = 2 * var_391_43 * Mathf.Tan(var_391_44.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_391_46 = var_391_45 * var_391_44.aspect
					local var_391_47 = var_391_42.sprite.bounds.size.x
					local var_391_48 = var_391_42.sprite.bounds.size.y
					local var_391_49 = var_391_46 / var_391_47
					local var_391_50 = var_391_45 / var_391_48
					local var_391_51 = var_391_50 < var_391_49 and var_391_49 or var_391_50

					var_391_41.transform.localScale = Vector3.New(var_391_51, var_391_51, 0)
				end

				for iter_391_4, iter_391_5 in pairs(arg_388_1.bgs_) do
					if iter_391_4 ~= "STblack" then
						iter_391_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_52 = 1.3

			if var_391_52 < arg_388_1.time_ and arg_388_1.time_ <= var_391_52 + arg_391_0 then
				arg_388_1.cswbg_:SetActive(true)

				local var_391_53 = arg_388_1.cswt_:GetComponent("RectTransform")

				arg_388_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_391_53.offsetMin = Vector2.New(400, 105)
				var_391_53.offsetMax = Vector2.New(-400, -200)

				local var_391_54 = arg_388_1:GetWordFromCfg(419106)
				local var_391_55 = arg_388_1:FormatText(var_391_54.content)

				arg_388_1.cswt_.text = var_391_55

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.cswt_)

				arg_388_1.cswt_.fontSize = 92
				arg_388_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_388_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_391_56 = manager.ui.mainCamera.transform
			local var_391_57 = 1.3

			if var_391_57 < arg_388_1.time_ and arg_388_1.time_ <= var_391_57 + arg_391_0 then
				local var_391_58 = arg_388_1.var_.effect811

				if var_391_58 then
					Object.Destroy(var_391_58)

					arg_388_1.var_.effect811 = nil
				end
			end

			local var_391_59 = 0.466666666666667
			local var_391_60 = 0.2

			if var_391_59 < arg_388_1.time_ and arg_388_1.time_ <= var_391_59 + arg_391_0 then
				local var_391_61 = "play"
				local var_391_62 = "music"

				arg_388_1:AudioAction(var_391_61, var_391_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_391_63 = ""
				local var_391_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_391_64 ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_64 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_64

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_64
						arg_388_1.bgmTxt2_.text = var_391_64
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_391_65 = 2.3
			local var_391_66 = 4.933
			local var_391_67 = manager.audio:GetVoiceLength("story_v_out_417131", "417131093", "") / 1000

			if var_391_67 > 0 and var_391_66 < var_391_67 and var_391_67 + var_391_65 > arg_388_1.duration_ then
				local var_391_68 = var_391_67

				arg_388_1.duration_ = var_391_67 + var_391_65
			end

			if var_391_65 < arg_388_1.time_ and arg_388_1.time_ <= var_391_65 + arg_391_0 then
				local var_391_69 = "play"
				local var_391_70 = "voice"

				arg_388_1:AudioAction(var_391_69, var_391_70, "story_v_out_417131", "417131093", "")
			end

			local var_391_71 = 2.53333333333333

			if var_391_71 < arg_388_1.time_ and arg_388_1.time_ <= var_391_71 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_72 = 2.63333333333333

			if arg_388_1.time_ >= var_391_71 + var_391_72 and arg_388_1.time_ < var_391_71 + var_391_72 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play417131094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 417131094
		arg_393_1.duration_ = 5.3

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play417131095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.4

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				local var_396_1 = manager.ui.mainCamera.transform.localPosition
				local var_396_2 = Vector3.New(0, 0, 10) + Vector3.New(var_396_1.x, var_396_1.y, 0)
				local var_396_3 = arg_393_1.bgs_.STblack

				var_396_3.transform.localPosition = var_396_2
				var_396_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_4 = var_396_3:GetComponent("SpriteRenderer")

				if var_396_4 and var_396_4.sprite then
					local var_396_5 = (var_396_3.transform.localPosition - var_396_1).z
					local var_396_6 = manager.ui.mainCameraCom_
					local var_396_7 = 2 * var_396_5 * Mathf.Tan(var_396_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_396_8 = var_396_7 * var_396_6.aspect
					local var_396_9 = var_396_4.sprite.bounds.size.x
					local var_396_10 = var_396_4.sprite.bounds.size.y
					local var_396_11 = var_396_8 / var_396_9
					local var_396_12 = var_396_7 / var_396_10
					local var_396_13 = var_396_12 < var_396_11 and var_396_11 or var_396_12

					var_396_3.transform.localScale = Vector3.New(var_396_13, var_396_13, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STblack" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			local var_396_15 = 0.3

			if arg_393_1.time_ >= var_396_14 + var_396_15 and arg_393_1.time_ < var_396_14 + var_396_15 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_16 = 0

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_17 = 1.4

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_17 then
				local var_396_18 = (arg_393_1.time_ - var_396_16) / var_396_17
				local var_396_19 = Color.New(1, 1, 1)

				var_396_19.a = Mathf.Lerp(0, 1, var_396_18)
				arg_393_1.mask_.color = var_396_19
			end

			if arg_393_1.time_ >= var_396_16 + var_396_17 and arg_393_1.time_ < var_396_16 + var_396_17 + arg_396_0 then
				local var_396_20 = Color.New(1, 1, 1)

				var_396_20.a = 1
				arg_393_1.mask_.color = var_396_20
			end

			local var_396_21 = 1.4

			if var_396_21 < arg_393_1.time_ and arg_393_1.time_ <= var_396_21 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_22 = 2

			if var_396_21 <= arg_393_1.time_ and arg_393_1.time_ < var_396_21 + var_396_22 then
				local var_396_23 = (arg_393_1.time_ - var_396_21) / var_396_22
				local var_396_24 = Color.New(1, 1, 1)

				var_396_24.a = Mathf.Lerp(1, 0, var_396_23)
				arg_393_1.mask_.color = var_396_24
			end

			if arg_393_1.time_ >= var_396_21 + var_396_22 and arg_393_1.time_ < var_396_21 + var_396_22 + arg_396_0 then
				local var_396_25 = Color.New(1, 1, 1)
				local var_396_26 = 0

				arg_393_1.mask_.enabled = false
				var_396_25.a = var_396_26
				arg_393_1.mask_.color = var_396_25
			end

			local var_396_27 = 1.4

			if var_396_27 < arg_393_1.time_ and arg_393_1.time_ <= var_396_27 + arg_396_0 then
				arg_393_1.fswbg_:SetActive(true)
				arg_393_1.dialog_:SetActive(false)

				arg_393_1.fswtw_.percent = 0

				local var_396_28 = arg_393_1:GetWordFromCfg(417131094)
				local var_396_29 = arg_393_1:FormatText(var_396_28.content)

				arg_393_1.fswt_.text = var_396_29

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.fswt_)

				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_393_1.fswtw_:SetDirty()

				arg_393_1.typewritterCharCountI18N = 0

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_30 = 2.63333333333333

			if var_396_30 < arg_393_1.time_ and arg_393_1.time_ <= var_396_30 + arg_396_0 then
				arg_393_1.var_.oldValueTypewriter = arg_393_1.fswtw_.percent

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_31 = 40
			local var_396_32 = 2.66666666666667
			local var_396_33 = arg_393_1:GetWordFromCfg(417131094)
			local var_396_34 = arg_393_1:FormatText(var_396_33.content)
			local var_396_35, var_396_36 = arg_393_1:GetPercentByPara(var_396_34, 1)

			if var_396_30 < arg_393_1.time_ and arg_393_1.time_ <= var_396_30 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				local var_396_37 = var_396_31 <= 0 and var_396_32 or var_396_32 * ((var_396_36 - arg_393_1.typewritterCharCountI18N) / var_396_31)

				if var_396_37 > 0 and var_396_32 < var_396_37 then
					arg_393_1.talkMaxDuration = var_396_37

					if var_396_37 + var_396_30 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_37 + var_396_30
					end
				end
			end

			local var_396_38 = 2.66666666666667
			local var_396_39 = math.max(var_396_38, arg_393_1.talkMaxDuration)

			if var_396_30 <= arg_393_1.time_ and arg_393_1.time_ < var_396_30 + var_396_39 then
				local var_396_40 = (arg_393_1.time_ - var_396_30) / var_396_39

				arg_393_1.fswtw_.percent = Mathf.Lerp(arg_393_1.var_.oldValueTypewriter, var_396_35, var_396_40)
				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_393_1.fswtw_:SetDirty()
			end

			if arg_393_1.time_ >= var_396_30 + var_396_39 and arg_393_1.time_ < var_396_30 + var_396_39 + arg_396_0 then
				arg_393_1.fswtw_.percent = var_396_35

				arg_393_1.fswtw_:SetDirty()
				arg_393_1:ShowNextGo(true)

				arg_393_1.typewritterCharCountI18N = var_396_36
			end

			local var_396_41 = 1.4

			if var_396_41 < arg_393_1.time_ and arg_393_1.time_ <= var_396_41 + arg_396_0 then
				local var_396_42 = arg_393_1.fswbg_.transform:Find("textbox/adapt/content") or arg_393_1.fswbg_.transform:Find("textbox/content")
				local var_396_43 = arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_396_44 = var_396_42:GetComponent("Text")
				local var_396_45 = var_396_42:GetComponent("RectTransform")

				var_396_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_396_45.offsetMin = Vector2.New(0, 0)
				var_396_45.offsetMax = Vector2.New(0, 0)
			end

			local var_396_46 = 1.4

			if var_396_46 < arg_393_1.time_ and arg_393_1.time_ <= var_396_46 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			local var_396_47 = 2.5

			if arg_393_1.time_ >= var_396_46 + var_396_47 and arg_393_1.time_ < var_396_46 + var_396_47 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_48 = 1.4

			if var_396_48 < arg_393_1.time_ and arg_393_1.time_ <= var_396_48 + arg_396_0 then
				arg_393_1.cswbg_:SetActive(false)
			end

			local var_396_49 = manager.ui.mainCamera.transform
			local var_396_50 = 1.4

			if var_396_50 < arg_393_1.time_ and arg_393_1.time_ <= var_396_50 + arg_396_0 then
				local var_396_51 = arg_393_1.var_.effect820
				local var_396_52
				local var_396_53 = var_396_49

				if not var_396_51 then
					var_396_51 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_396_53)
					var_396_51.name = "820"
					arg_393_1.var_.effect820 = var_396_51
				else
					var_396_51.transform:SetParent(var_396_53)
				end

				var_396_51.transform.localPosition = Vector3.New(0, 0, 0)
				var_396_51.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_396_54 = manager.ui.mainCameraCom_
				local var_396_55 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_396_54.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_396_56 = var_396_51.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_396_57 = 15
				local var_396_58 = 2 * var_396_57 * Mathf.Tan(var_396_54.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_396_54.aspect
				local var_396_59 = 1
				local var_396_60 = 1.7777777777777777

				if var_396_60 < var_396_54.aspect then
					var_396_59 = var_396_58 / (2 * var_396_57 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_396_60)
				end

				for iter_396_2, iter_396_3 in ipairs(var_396_56) do
					local var_396_61 = iter_396_3.transform.localScale

					iter_396_3.transform.localScale = Vector3.New(var_396_61.x / var_396_55 * var_396_59, var_396_61.y / var_396_55, var_396_61.z)
				end
			end

			local var_396_62 = 0.01
			local var_396_63 = 1

			if var_396_62 < arg_393_1.time_ and arg_393_1.time_ <= var_396_62 + arg_396_0 then
				local var_396_64 = "play"
				local var_396_65 = "effect"

				arg_393_1:AudioAction(var_396_64, var_396_65, "se_story_1310", "se_story_1310_flashgun", "")
			end

			local var_396_66 = 0.01
			local var_396_67 = 1

			if var_396_66 < arg_393_1.time_ and arg_393_1.time_ <= var_396_66 + arg_396_0 then
				local var_396_68 = "play"
				local var_396_69 = "effect"

				arg_393_1:AudioAction(var_396_68, var_396_69, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play417131095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 417131095
		arg_397_1.duration_ = 8.2

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play417131096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.4

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				local var_400_1 = manager.ui.mainCamera.transform.localPosition
				local var_400_2 = Vector3.New(0, 0, 10) + Vector3.New(var_400_1.x, var_400_1.y, 0)
				local var_400_3 = arg_397_1.bgs_.ST2105a

				var_400_3.transform.localPosition = var_400_2
				var_400_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_4 = var_400_3:GetComponent("SpriteRenderer")

				if var_400_4 and var_400_4.sprite then
					local var_400_5 = (var_400_3.transform.localPosition - var_400_1).z
					local var_400_6 = manager.ui.mainCameraCom_
					local var_400_7 = 2 * var_400_5 * Mathf.Tan(var_400_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_400_8 = var_400_7 * var_400_6.aspect
					local var_400_9 = var_400_4.sprite.bounds.size.x
					local var_400_10 = var_400_4.sprite.bounds.size.y
					local var_400_11 = var_400_8 / var_400_9
					local var_400_12 = var_400_7 / var_400_10
					local var_400_13 = var_400_12 < var_400_11 and var_400_11 or var_400_12

					var_400_3.transform.localScale = Vector3.New(var_400_13, var_400_13, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "ST2105a" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_14 = 0

			if var_400_14 < arg_397_1.time_ and arg_397_1.time_ <= var_400_14 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			local var_400_15 = 0.3

			if arg_397_1.time_ >= var_400_14 + var_400_15 and arg_397_1.time_ < var_400_14 + var_400_15 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_16 = 0

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_17 = 1.434

			if var_400_16 <= arg_397_1.time_ and arg_397_1.time_ < var_400_16 + var_400_17 then
				local var_400_18 = (arg_397_1.time_ - var_400_16) / var_400_17
				local var_400_19 = Color.New(0, 0, 0)

				var_400_19.a = Mathf.Lerp(0, 1, var_400_18)
				arg_397_1.mask_.color = var_400_19
			end

			if arg_397_1.time_ >= var_400_16 + var_400_17 and arg_397_1.time_ < var_400_16 + var_400_17 + arg_400_0 then
				local var_400_20 = Color.New(0, 0, 0)

				var_400_20.a = 1
				arg_397_1.mask_.color = var_400_20
			end

			local var_400_21 = 1.434

			if var_400_21 < arg_397_1.time_ and arg_397_1.time_ <= var_400_21 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_22 = 2

			if var_400_21 <= arg_397_1.time_ and arg_397_1.time_ < var_400_21 + var_400_22 then
				local var_400_23 = (arg_397_1.time_ - var_400_21) / var_400_22
				local var_400_24 = Color.New(0, 0, 0)

				var_400_24.a = Mathf.Lerp(1, 0, var_400_23)
				arg_397_1.mask_.color = var_400_24
			end

			if arg_397_1.time_ >= var_400_21 + var_400_22 and arg_397_1.time_ < var_400_21 + var_400_22 + arg_400_0 then
				local var_400_25 = Color.New(0, 0, 0)
				local var_400_26 = 0

				arg_397_1.mask_.enabled = false
				var_400_25.a = var_400_26
				arg_397_1.mask_.color = var_400_25
			end

			local var_400_27 = 1.4

			if var_400_27 < arg_397_1.time_ and arg_397_1.time_ <= var_400_27 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(false)
				arg_397_1.dialog_:SetActive(false)
				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_28 = 1.434

			if var_400_28 < arg_397_1.time_ and arg_397_1.time_ <= var_400_28 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(false)
				arg_397_1.dialog_:SetActive(false)
				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_29 = manager.ui.mainCamera.transform
			local var_400_30 = 1.434

			if var_400_30 < arg_397_1.time_ and arg_397_1.time_ <= var_400_30 + arg_400_0 then
				local var_400_31 = arg_397_1.var_.effect811

				if var_400_31 then
					Object.Destroy(var_400_31)

					arg_397_1.var_.effect811 = nil
				end
			end

			local var_400_32 = manager.ui.mainCamera.transform
			local var_400_33 = 1.434

			if var_400_33 < arg_397_1.time_ and arg_397_1.time_ <= var_400_33 + arg_400_0 then
				local var_400_34 = arg_397_1.var_.effect809
				local var_400_35
				local var_400_36 = var_400_32

				if not var_400_34 then
					var_400_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), var_400_36)
					var_400_34.name = "809"
					arg_397_1.var_.effect809 = var_400_34
				else
					var_400_34.transform:SetParent(var_400_36)
				end

				var_400_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_400_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_400_37 = manager.ui.mainCameraCom_
				local var_400_38 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_400_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_400_39 = var_400_34.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_400_40 = 15
				local var_400_41 = 2 * var_400_40 * Mathf.Tan(var_400_37.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_400_37.aspect
				local var_400_42 = 1
				local var_400_43 = 1.7777777777777777

				if var_400_43 < var_400_37.aspect then
					var_400_42 = var_400_41 / (2 * var_400_40 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_400_43)
				end

				for iter_400_2, iter_400_3 in ipairs(var_400_39) do
					local var_400_44 = iter_400_3.transform.localScale

					iter_400_3.transform.localScale = Vector3.New(var_400_44.x / var_400_38 * var_400_42, var_400_44.y / var_400_38, var_400_44.z)
				end
			end

			local var_400_45 = manager.ui.mainCamera.transform
			local var_400_46 = 1.434

			if var_400_46 < arg_397_1.time_ and arg_397_1.time_ <= var_400_46 + arg_400_0 then
				local var_400_47 = arg_397_1.var_.effect811

				if var_400_47 then
					Object.Destroy(var_400_47)

					arg_397_1.var_.effect811 = nil
				end
			end

			local var_400_48 = manager.ui.mainCamera.transform
			local var_400_49 = 1.434

			if var_400_49 < arg_397_1.time_ and arg_397_1.time_ <= var_400_49 + arg_400_0 then
				local var_400_50 = arg_397_1.var_.effect820

				if var_400_50 then
					Object.Destroy(var_400_50)

					arg_397_1.var_.effect820 = nil
				end
			end

			local var_400_51 = 1.4
			local var_400_52 = 1

			if var_400_51 < arg_397_1.time_ and arg_397_1.time_ <= var_400_51 + arg_400_0 then
				local var_400_53 = "play"
				local var_400_54 = "effect"

				arg_397_1:AudioAction(var_400_53, var_400_54, "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			local var_400_55 = 4.06666666666667
			local var_400_56 = 1

			if var_400_55 < arg_397_1.time_ and arg_397_1.time_ <= var_400_55 + arg_400_0 then
				local var_400_57 = "play"
				local var_400_58 = "effect"

				arg_397_1:AudioAction(var_400_57, var_400_58, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_400_59 = 0.05
			local var_400_60 = 1

			if var_400_59 < arg_397_1.time_ and arg_397_1.time_ <= var_400_59 + arg_400_0 then
				local var_400_61 = "stop"
				local var_400_62 = "effect"

				arg_397_1:AudioAction(var_400_61, var_400_62, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_63 = 3.2
			local var_400_64 = 0.95

			if var_400_63 < arg_397_1.time_ and arg_397_1.time_ <= var_400_63 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_65 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_65:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_66 = arg_397_1:GetWordFromCfg(417131095)
				local var_400_67 = arg_397_1:FormatText(var_400_66.content)

				arg_397_1.text_.text = var_400_67

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_68 = 38
				local var_400_69 = utf8.len(var_400_67)
				local var_400_70 = var_400_68 <= 0 and var_400_64 or var_400_64 * (var_400_69 / var_400_68)

				if var_400_70 > 0 and var_400_64 < var_400_70 then
					arg_397_1.talkMaxDuration = var_400_70
					var_400_63 = var_400_63 + 0.3

					if var_400_70 + var_400_63 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_70 + var_400_63
					end
				end

				arg_397_1.text_.text = var_400_67
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_71 = var_400_63 + 0.3
			local var_400_72 = math.max(var_400_64, arg_397_1.talkMaxDuration)

			if var_400_71 <= arg_397_1.time_ and arg_397_1.time_ < var_400_71 + var_400_72 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_71) / var_400_72

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_71 + var_400_72 and arg_397_1.time_ < var_400_71 + var_400_72 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play417131096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 417131096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play417131097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 0.75

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_2 = arg_403_1:GetWordFromCfg(417131096)
				local var_406_3 = arg_403_1:FormatText(var_406_2.content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 30
				local var_406_5 = utf8.len(var_406_3)
				local var_406_6 = var_406_4 <= 0 and var_406_1 or var_406_1 * (var_406_5 / var_406_4)

				if var_406_6 > 0 and var_406_1 < var_406_6 then
					arg_403_1.talkMaxDuration = var_406_6

					if var_406_6 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_6 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_7 and arg_403_1.time_ < var_406_0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play417131097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 417131097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play417131098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 1.5

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(417131097)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 60
				local var_410_5 = utf8.len(var_410_3)
				local var_410_6 = var_410_4 <= 0 and var_410_1 or var_410_1 * (var_410_5 / var_410_4)

				if var_410_6 > 0 and var_410_1 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_7 and arg_407_1.time_ < var_410_0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play417131098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 417131098
		arg_411_1.duration_ = 5.67

		local var_411_0 = {
			zh = 4.566,
			ja = 5.666
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play417131099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10115"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps10115 == nil then
				arg_411_1.var_.actorSpriteComps10115 = var_414_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.actorSpriteComps10115 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								local var_414_4 = Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor1.r, var_414_3)
								local var_414_5 = Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor1.g, var_414_3)
								local var_414_6 = Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor1.b, var_414_3)

								iter_414_1.color = Color.New(var_414_4, var_414_5, var_414_6)
							else
								local var_414_7 = Mathf.Lerp(iter_414_1.color.r, 1, var_414_3)

								iter_414_1.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps10115 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_414_3 then
						if arg_411_1.isInRecall_ then
							iter_414_3.color = arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_414_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10115 = nil
			end

			local var_414_8 = arg_411_1.actors_["10115"].transform
			local var_414_9 = 0

			if var_414_9 < arg_411_1.time_ and arg_411_1.time_ <= var_414_9 + arg_414_0 then
				arg_411_1.var_.moveOldPos10115 = var_414_8.localPosition
				var_414_8.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10115", 3)

				local var_414_10 = var_414_8.childCount

				for iter_414_4 = 0, var_414_10 - 1 do
					local var_414_11 = var_414_8:GetChild(iter_414_4)

					if var_414_11.name == "split_6" or not string.find(var_414_11.name, "split") then
						var_414_11.gameObject:SetActive(true)
					else
						var_414_11.gameObject:SetActive(false)
					end
				end
			end

			local var_414_12 = 0.001

			if var_414_9 <= arg_411_1.time_ and arg_411_1.time_ < var_414_9 + var_414_12 then
				local var_414_13 = (arg_411_1.time_ - var_414_9) / var_414_12
				local var_414_14 = Vector3.New(0, -387.3, -246.2)

				var_414_8.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10115, var_414_14, var_414_13)
			end

			if arg_411_1.time_ >= var_414_9 + var_414_12 and arg_411_1.time_ < var_414_9 + var_414_12 + arg_414_0 then
				var_414_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_414_15 = 0
			local var_414_16 = 0.525

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_17 = arg_411_1:FormatText(StoryNameCfg[1113].name)

				arg_411_1.leftNameTxt_.text = var_414_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_18 = arg_411_1:GetWordFromCfg(417131098)
				local var_414_19 = arg_411_1:FormatText(var_414_18.content)

				arg_411_1.text_.text = var_414_19

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_20 = 21
				local var_414_21 = utf8.len(var_414_19)
				local var_414_22 = var_414_20 <= 0 and var_414_16 or var_414_16 * (var_414_21 / var_414_20)

				if var_414_22 > 0 and var_414_16 < var_414_22 then
					arg_411_1.talkMaxDuration = var_414_22

					if var_414_22 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_22 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_19
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131098", "story_v_out_417131.awb") ~= 0 then
					local var_414_23 = manager.audio:GetVoiceLength("story_v_out_417131", "417131098", "story_v_out_417131.awb") / 1000

					if var_414_23 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_15
					end

					if var_414_18.prefab_name ~= "" and arg_411_1.actors_[var_414_18.prefab_name] ~= nil then
						local var_414_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_18.prefab_name].transform, "story_v_out_417131", "417131098", "story_v_out_417131.awb")

						arg_411_1:RecordAudio("417131098", var_414_24)
						arg_411_1:RecordAudio("417131098", var_414_24)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_417131", "417131098", "story_v_out_417131.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_417131", "417131098", "story_v_out_417131.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_25 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_25 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_25

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_25 and arg_411_1.time_ < var_414_15 + var_414_25 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play417131099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 417131099
		arg_415_1.duration_ = 4

		local var_415_0 = {
			zh = 3.333,
			ja = 4
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
			arg_415_1.auto_ = false
		end

		function arg_415_1.playNext_(arg_417_0)
			arg_415_1.onStoryFinished_()
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.2
			local var_418_1 = 1

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				local var_418_2 = "play"
				local var_418_3 = "effect"

				arg_415_1:AudioAction(var_418_2, var_418_3, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_418_4 = 0
			local var_418_5 = 0.2

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_6 = arg_415_1:FormatText(StoryNameCfg[1113].name)

				arg_415_1.leftNameTxt_.text = var_418_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_7 = arg_415_1:GetWordFromCfg(417131099)
				local var_418_8 = arg_415_1:FormatText(var_418_7.content)

				arg_415_1.text_.text = var_418_8

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 8
				local var_418_10 = utf8.len(var_418_8)
				local var_418_11 = var_418_9 <= 0 and var_418_5 or var_418_5 * (var_418_10 / var_418_9)

				if var_418_11 > 0 and var_418_5 < var_418_11 then
					arg_415_1.talkMaxDuration = var_418_11

					if var_418_11 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_11 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_8
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131099", "story_v_out_417131.awb") ~= 0 then
					local var_418_12 = manager.audio:GetVoiceLength("story_v_out_417131", "417131099", "story_v_out_417131.awb") / 1000

					if var_418_12 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_12 + var_418_4
					end

					if var_418_7.prefab_name ~= "" and arg_415_1.actors_[var_418_7.prefab_name] ~= nil then
						local var_418_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_7.prefab_name].transform, "story_v_out_417131", "417131099", "story_v_out_417131.awb")

						arg_415_1:RecordAudio("417131099", var_418_13)
						arg_415_1:RecordAudio("417131099", var_418_13)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_417131", "417131099", "story_v_out_417131.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_417131", "417131099", "story_v_out_417131.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_14 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_14 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_14

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_14 and arg_415_1.time_ < var_418_4 + var_418_14 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2105a",
		"TextureConfig/Background/B02f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS1705"
	},
	voices = {
		"story_v_out_417131.awb"
	}
}
