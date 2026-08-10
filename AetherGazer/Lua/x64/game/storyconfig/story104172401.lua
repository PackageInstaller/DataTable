return {
	Play417241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417241001
		arg_1_1.duration_ = 12.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 5
			local var_4_2 = "ST73"

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_3 = arg_1_1:GetWordFromCfg(501071)
				local var_4_4 = arg_1_1:FormatText(var_4_3.content)

				arg_1_1.text_timeText_.text = var_4_4

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_5 = arg_1_1:GetWordFromCfg(501072)
				local var_4_6 = arg_1_1:FormatText(var_4_5.content)

				arg_1_1.text_siteText_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_7 = 5

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_8 = 1.2

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_8 then
				local var_4_9 = (arg_1_1.time_ - var_4_7) / var_4_8
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(0, 1, var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_7 + var_4_8 and arg_1_1.time_ < var_4_7 + var_4_8 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = 1
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = 6.2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_13 = 1.2

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13
				local var_4_15 = Color.New(0, 0, 0)

				var_4_15.a = Mathf.Lerp(1, 0, var_4_14)
				arg_1_1.mask_.color = var_4_15
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				local var_4_16 = Color.New(0, 0, 0)
				local var_4_17 = 0

				arg_1_1.mask_.enabled = false
				var_4_16.a = var_4_17
				arg_1_1.mask_.color = var_4_16
			end

			local var_4_18 = "ST73"

			if arg_1_1.bgs_[var_4_18] == nil then
				local var_4_19 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_18)
				var_4_19.name = var_4_18
				var_4_19.transform.parent = arg_1_1.stage_.transform
				var_4_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_18] = var_4_19
			end

			local var_4_20 = 0

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_21 = manager.ui.mainCamera.transform.localPosition
				local var_4_22 = Vector3.New(0, 0, 10) + Vector3.New(var_4_21.x, var_4_21.y, 0)
				local var_4_23 = arg_1_1.bgs_.ST73

				var_4_23.transform.localPosition = var_4_22
				var_4_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_24 = var_4_23:GetComponent("SpriteRenderer")

				if var_4_24 and var_4_24.sprite then
					local var_4_25 = (var_4_23.transform.localPosition - var_4_21).z
					local var_4_26 = manager.ui.mainCameraCom_
					local var_4_27 = 2 * var_4_25 * Mathf.Tan(var_4_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_28 = var_4_27 * var_4_26.aspect
					local var_4_29 = var_4_24.sprite.bounds.size.x
					local var_4_30 = var_4_24.sprite.bounds.size.y
					local var_4_31 = var_4_28 / var_4_29
					local var_4_32 = var_4_27 / var_4_30
					local var_4_33 = var_4_32 < var_4_31 and var_4_31 or var_4_32

					var_4_23.transform.localScale = Vector3.New(var_4_33, var_4_33, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_35 = 6.2

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_36 = "10115"

			if arg_1_1.actors_[var_4_36] == nil then
				local var_4_37 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_4_37) then
					local var_4_38 = Object.Instantiate(var_4_37, arg_1_1.canvasGo_.transform)

					var_4_38.transform:SetSiblingIndex(1)

					var_4_38.name = var_4_36
					var_4_38.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_36] = var_4_38

					local var_4_39 = var_4_38:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_39) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["10115"].transform
			local var_4_41 = 7.08333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos10115 = var_4_40.localPosition
				var_4_40.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10115", 3)

				local var_4_42 = var_4_40.childCount

				for iter_4_4 = 0, var_4_42 - 1 do
					local var_4_43 = var_4_40:GetChild(iter_4_4)

					if var_4_43.name == "split_6" or not string.find(var_4_43.name, "split") then
						var_4_43.gameObject:SetActive(true)
					else
						var_4_43.gameObject:SetActive(false)
					end
				end
			end

			local var_4_44 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_41) / var_4_44
				local var_4_46 = Vector3.New(0, -387.3, -246.2)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10115, var_4_46, var_4_45)
			end

			if arg_1_1.time_ >= var_4_41 + var_4_44 and arg_1_1.time_ < var_4_41 + var_4_44 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_4_47 = arg_1_1.actors_["10115"]
			local var_4_48 = 7.08333333333333

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.actorSpriteComps10115 == nil then
				arg_1_1.var_.actorSpriteComps10115 = var_4_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_49 = 0.2

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 and not isNil(var_4_47) then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49

				if arg_1_1.var_.actorSpriteComps10115 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_51 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_50)
								local var_4_52 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_50)
								local var_4_53 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_50)

								iter_4_6.color = Color.New(var_4_51, var_4_52, var_4_53)
							else
								local var_4_54 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_50)

								iter_4_6.color = Color.New(var_4_54, var_4_54, var_4_54)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.actorSpriteComps10115 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10115 = nil
			end

			local var_4_55 = arg_1_1.actors_["10115"]
			local var_4_56 = 7.08333333333333

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_57 = var_4_55:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_57 then
					arg_1_1.var_.alphaOldValue10115 = var_4_57.alpha
					arg_1_1.var_.characterEffect10115 = var_4_57
				end

				arg_1_1.var_.alphaOldValue10115 = 0
			end

			local var_4_58 = 0.316666666666666

			if var_4_56 <= arg_1_1.time_ and arg_1_1.time_ < var_4_56 + var_4_58 then
				local var_4_59 = (arg_1_1.time_ - var_4_56) / var_4_58
				local var_4_60 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10115, 1, var_4_59)

				if arg_1_1.var_.characterEffect10115 then
					arg_1_1.var_.characterEffect10115.alpha = var_4_60
				end
			end

			if arg_1_1.time_ >= var_4_56 + var_4_58 and arg_1_1.time_ < var_4_56 + var_4_58 + arg_4_0 and arg_1_1.var_.characterEffect10115 then
				arg_1_1.var_.characterEffect10115.alpha = 1
			end

			local var_4_61 = 0

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_62 = 1

			if var_4_61 <= arg_1_1.time_ and arg_1_1.time_ < var_4_61 + var_4_62 then
				local var_4_63 = (arg_1_1.time_ - var_4_61) / var_4_62
				local var_4_64 = Color.New(0, 0, 0)

				var_4_64.a = Mathf.Lerp(1, 0, var_4_63)
				arg_1_1.mask_.color = var_4_64
			end

			if arg_1_1.time_ >= var_4_61 + var_4_62 and arg_1_1.time_ < var_4_61 + var_4_62 + arg_4_0 then
				local var_4_65 = Color.New(0, 0, 0)
				local var_4_66 = 0

				arg_1_1.mask_.enabled = false
				var_4_65.a = var_4_66
				arg_1_1.mask_.color = var_4_65
			end

			local var_4_67 = 0
			local var_4_68 = 0.2

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "music"

				arg_1_1:AudioAction(var_4_69, var_4_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_71 = ""
				local var_4_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_72 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_72 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_72

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_72
						arg_1_1.bgmTxt2_.text = var_4_72
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

			local var_4_73 = 5.73333333333333
			local var_4_74 = 1

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				local var_4_75 = "play"
				local var_4_76 = "music"

				arg_1_1:AudioAction(var_4_75, var_4_76, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_77 = ""
				local var_4_78 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_4_78 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_78 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_78

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_78
						arg_1_1.bgmTxt2_.text = var_4_78
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

			local var_4_79 = 6.2
			local var_4_80 = 1

			if var_4_79 < arg_1_1.time_ and arg_1_1.time_ <= var_4_79 + arg_4_0 then
				local var_4_81 = "play"
				local var_4_82 = "effect"

				arg_1_1:AudioAction(var_4_81, var_4_82, "se_story_1311", "se_story_1311_vibrate", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_83 = 7.4
			local var_4_84 = 0.05

			if var_4_83 < arg_1_1.time_ and arg_1_1.time_ <= var_4_83 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_85 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_85:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_85:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_85:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_86 = arg_1_1:FormatText(StoryNameCfg[1113].name)

				arg_1_1.leftNameTxt_.text = var_4_86

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_87 = arg_1_1:GetWordFromCfg(417241001)
				local var_4_88 = arg_1_1:FormatText(var_4_87.content)

				arg_1_1.text_.text = var_4_88

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_89 = 2
				local var_4_90 = utf8.len(var_4_88)
				local var_4_91 = var_4_89 <= 0 and var_4_84 or var_4_84 * (var_4_90 / var_4_89)

				if var_4_91 > 0 and var_4_84 < var_4_91 then
					arg_1_1.talkMaxDuration = var_4_91
					var_4_83 = var_4_83 + 0.3

					if var_4_91 + var_4_83 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_91 + var_4_83
					end
				end

				arg_1_1.text_.text = var_4_88
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_92 = var_4_83 + 0.3
			local var_4_93 = math.max(var_4_84, arg_1_1.talkMaxDuration)

			if var_4_92 <= arg_1_1.time_ and arg_1_1.time_ < var_4_92 + var_4_93 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_92) / var_4_93

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_92 + var_4_93 and arg_1_1.time_ < var_4_92 + var_4_93 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.08333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417241002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417241002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417241003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["10115"]
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.actorSpriteComps10115 == nil then
				arg_10_1.var_.actorSpriteComps10115 = var_13_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_2 = 0.2

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 and not isNil(var_13_0) then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2

				if arg_10_1.var_.actorSpriteComps10115 then
					for iter_13_0, iter_13_1 in pairs(arg_10_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_13_1 then
							if arg_10_1.isInRecall_ then
								local var_13_4 = Mathf.Lerp(iter_13_1.color.r, arg_10_1.hightColor2.r, var_13_3)
								local var_13_5 = Mathf.Lerp(iter_13_1.color.g, arg_10_1.hightColor2.g, var_13_3)
								local var_13_6 = Mathf.Lerp(iter_13_1.color.b, arg_10_1.hightColor2.b, var_13_3)

								iter_13_1.color = Color.New(var_13_4, var_13_5, var_13_6)
							else
								local var_13_7 = Mathf.Lerp(iter_13_1.color.r, 0.5, var_13_3)

								iter_13_1.color = Color.New(var_13_7, var_13_7, var_13_7)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.actorSpriteComps10115 then
				for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_13_3 then
						if arg_10_1.isInRecall_ then
							iter_13_3.color = arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_13_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps10115 = nil
			end

			local var_13_8 = 0.02
			local var_13_9 = 1

			if var_13_8 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				local var_13_10 = "play"
				local var_13_11 = "effect"

				arg_10_1:AudioAction(var_13_10, var_13_11, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_13_12 = 0
			local var_13_13 = 1.125

			if var_13_12 < arg_10_1.time_ and arg_10_1.time_ <= var_13_12 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_14 = arg_10_1:GetWordFromCfg(417241002)
				local var_13_15 = arg_10_1:FormatText(var_13_14.content)

				arg_10_1.text_.text = var_13_15

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_16 = 45
				local var_13_17 = utf8.len(var_13_15)
				local var_13_18 = var_13_16 <= 0 and var_13_13 or var_13_13 * (var_13_17 / var_13_16)

				if var_13_18 > 0 and var_13_13 < var_13_18 then
					arg_10_1.talkMaxDuration = var_13_18

					if var_13_18 + var_13_12 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_18 + var_13_12
					end
				end

				arg_10_1.text_.text = var_13_15
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_19 = math.max(var_13_13, arg_10_1.talkMaxDuration)

			if var_13_12 <= arg_10_1.time_ and arg_10_1.time_ < var_13_12 + var_13_19 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_12) / var_13_19

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_12 + var_13_19 and arg_10_1.time_ < var_13_12 + var_13_19 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417241003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417241003
		arg_14_1.duration_ = 1.3

		local var_14_0 = {
			zh = 0.999999999999,
			ja = 1.3
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
				arg_14_0:Play417241004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["10115"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps10115 == nil then
				arg_14_1.var_.actorSpriteComps10115 = var_17_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.actorSpriteComps10115 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								local var_17_4 = Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor1.r, var_17_3)
								local var_17_5 = Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor1.g, var_17_3)
								local var_17_6 = Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor1.b, var_17_3)

								iter_17_1.color = Color.New(var_17_4, var_17_5, var_17_6)
							else
								local var_17_7 = Mathf.Lerp(iter_17_1.color.r, 1, var_17_3)

								iter_17_1.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps10115 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_17_3 then
						if arg_14_1.isInRecall_ then
							iter_17_3.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps10115 = nil
			end

			local var_17_8 = arg_14_1.actors_["10115"].transform
			local var_17_9 = 0

			if var_17_9 < arg_14_1.time_ and arg_14_1.time_ <= var_17_9 + arg_17_0 then
				arg_14_1.var_.moveOldPos10115 = var_17_8.localPosition
				var_17_8.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10115", 3)

				local var_17_10 = var_17_8.childCount

				for iter_17_4 = 0, var_17_10 - 1 do
					local var_17_11 = var_17_8:GetChild(iter_17_4)

					if var_17_11.name == "split_6" or not string.find(var_17_11.name, "split") then
						var_17_11.gameObject:SetActive(true)
					else
						var_17_11.gameObject:SetActive(false)
					end
				end
			end

			local var_17_12 = 0.001

			if var_17_9 <= arg_14_1.time_ and arg_14_1.time_ < var_17_9 + var_17_12 then
				local var_17_13 = (arg_14_1.time_ - var_17_9) / var_17_12
				local var_17_14 = Vector3.New(0, -387.3, -246.2)

				var_17_8.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10115, var_17_14, var_17_13)
			end

			if arg_14_1.time_ >= var_17_9 + var_17_12 and arg_14_1.time_ < var_17_9 + var_17_12 + arg_17_0 then
				var_17_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_17_15 = 0
			local var_17_16 = 0.05

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_17 = arg_14_1:FormatText(StoryNameCfg[1113].name)

				arg_14_1.leftNameTxt_.text = var_17_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(417241003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 2
				local var_17_21 = utf8.len(var_17_19)
				local var_17_22 = var_17_20 <= 0 and var_17_16 or var_17_16 * (var_17_21 / var_17_20)

				if var_17_22 > 0 and var_17_16 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241003", "story_v_out_417241.awb") ~= 0 then
					local var_17_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241003", "story_v_out_417241.awb") / 1000

					if var_17_23 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_23 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_417241", "417241003", "story_v_out_417241.awb")

						arg_14_1:RecordAudio("417241003", var_17_24)
						arg_14_1:RecordAudio("417241003", var_17_24)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417241", "417241003", "story_v_out_417241.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417241", "417241003", "story_v_out_417241.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_25 and arg_14_1.time_ < var_17_15 + var_17_25 + arg_17_0 then
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
	Play417241004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417241004
		arg_18_1.duration_ = 3.87

		local var_18_0 = {
			zh = 2.833,
			ja = 3.866
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
				arg_18_0:Play417241005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10115"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps10115 == nil then
				arg_18_1.var_.actorSpriteComps10115 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps10115 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor2.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor2.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor2.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 0.5, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps10115 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_21_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps10115 = nil
			end

			local var_21_8 = 0
			local var_21_9 = 0.4

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_10 = arg_18_1:FormatText(StoryNameCfg[1153].name)

				arg_18_1.leftNameTxt_.text = var_21_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_18_1.callingController_:SetSelectedState("calling")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_11 = arg_18_1:GetWordFromCfg(417241004)
				local var_21_12 = arg_18_1:FormatText(var_21_11.content)

				arg_18_1.text_.text = var_21_12

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 16
				local var_21_14 = utf8.len(var_21_12)
				local var_21_15 = var_21_13 <= 0 and var_21_9 or var_21_9 * (var_21_14 / var_21_13)

				if var_21_15 > 0 and var_21_9 < var_21_15 then
					arg_18_1.talkMaxDuration = var_21_15

					if var_21_15 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_15 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_12
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241004", "story_v_out_417241.awb") ~= 0 then
					local var_21_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241004", "story_v_out_417241.awb") / 1000

					if var_21_16 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_16 + var_21_8
					end

					if var_21_11.prefab_name ~= "" and arg_18_1.actors_[var_21_11.prefab_name] ~= nil then
						local var_21_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_11.prefab_name].transform, "story_v_out_417241", "417241004", "story_v_out_417241.awb")

						arg_18_1:RecordAudio("417241004", var_21_17)
						arg_18_1:RecordAudio("417241004", var_21_17)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417241", "417241004", "story_v_out_417241.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417241", "417241004", "story_v_out_417241.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_18 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_18 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_8) / var_21_18

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_18 and arg_18_1.time_ < var_21_8 + var_21_18 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417241005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417241005
		arg_22_1.duration_ = 5.7

		local var_22_0 = {
			zh = 5.033,
			ja = 5.7
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
				arg_22_0:Play417241006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10115"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_8 = arg_22_1.actors_["10115"].transform
			local var_25_9 = 0

			if var_25_9 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.var_.moveOldPos10115 = var_25_8.localPosition
				var_25_8.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10115", 3)

				local var_25_10 = var_25_8.childCount

				for iter_25_4 = 0, var_25_10 - 1 do
					local var_25_11 = var_25_8:GetChild(iter_25_4)

					if var_25_11.name == "split_4" or not string.find(var_25_11.name, "split") then
						var_25_11.gameObject:SetActive(true)
					else
						var_25_11.gameObject:SetActive(false)
					end
				end
			end

			local var_25_12 = 0.001

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_12 then
				local var_25_13 = (arg_22_1.time_ - var_25_9) / var_25_12
				local var_25_14 = Vector3.New(0, -387.3, -246.2)

				var_25_8.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10115, var_25_14, var_25_13)
			end

			if arg_22_1.time_ >= var_25_9 + var_25_12 and arg_22_1.time_ < var_25_9 + var_25_12 + arg_25_0 then
				var_25_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_25_15 = 0
			local var_25_16 = 0.425

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_17 = arg_22_1:FormatText(StoryNameCfg[1113].name)

				arg_22_1.leftNameTxt_.text = var_25_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_18 = arg_22_1:GetWordFromCfg(417241005)
				local var_25_19 = arg_22_1:FormatText(var_25_18.content)

				arg_22_1.text_.text = var_25_19

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241005", "story_v_out_417241.awb") ~= 0 then
					local var_25_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241005", "story_v_out_417241.awb") / 1000

					if var_25_23 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_23 + var_25_15
					end

					if var_25_18.prefab_name ~= "" and arg_22_1.actors_[var_25_18.prefab_name] ~= nil then
						local var_25_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_18.prefab_name].transform, "story_v_out_417241", "417241005", "story_v_out_417241.awb")

						arg_22_1:RecordAudio("417241005", var_25_24)
						arg_22_1:RecordAudio("417241005", var_25_24)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417241", "417241005", "story_v_out_417241.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417241", "417241005", "story_v_out_417241.awb")
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
				actorName = "10115",
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
	Play417241006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417241006
		arg_26_1.duration_ = 7.2

		local var_26_0 = {
			zh = 4.066,
			ja = 7.2
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
				arg_26_0:Play417241007(arg_26_1)
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
								local var_29_4 = Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor2.r, var_29_3)
								local var_29_5 = Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor2.g, var_29_3)
								local var_29_6 = Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor2.b, var_29_3)

								iter_29_1.color = Color.New(var_29_4, var_29_5, var_29_6)
							else
								local var_29_7 = Mathf.Lerp(iter_29_1.color.r, 0.5, var_29_3)

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
							iter_29_3.color = arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_29_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps10115 = nil
			end

			local var_29_8 = 0
			local var_29_9 = 0.575

			if var_29_8 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_10 = arg_26_1:FormatText(StoryNameCfg[1153].name)

				arg_26_1.leftNameTxt_.text = var_29_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_26_1.callingController_:SetSelectedState("calling")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_11 = arg_26_1:GetWordFromCfg(417241006)
				local var_29_12 = arg_26_1:FormatText(var_29_11.content)

				arg_26_1.text_.text = var_29_12

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 23
				local var_29_14 = utf8.len(var_29_12)
				local var_29_15 = var_29_13 <= 0 and var_29_9 or var_29_9 * (var_29_14 / var_29_13)

				if var_29_15 > 0 and var_29_9 < var_29_15 then
					arg_26_1.talkMaxDuration = var_29_15

					if var_29_15 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_15 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_12
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241006", "story_v_out_417241.awb") ~= 0 then
					local var_29_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241006", "story_v_out_417241.awb") / 1000

					if var_29_16 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_16 + var_29_8
					end

					if var_29_11.prefab_name ~= "" and arg_26_1.actors_[var_29_11.prefab_name] ~= nil then
						local var_29_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_11.prefab_name].transform, "story_v_out_417241", "417241006", "story_v_out_417241.awb")

						arg_26_1:RecordAudio("417241006", var_29_17)
						arg_26_1:RecordAudio("417241006", var_29_17)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417241", "417241006", "story_v_out_417241.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417241", "417241006", "story_v_out_417241.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_18 = math.max(var_29_9, arg_26_1.talkMaxDuration)

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_18 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_8) / var_29_18

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_8 + var_29_18 and arg_26_1.time_ < var_29_8 + var_29_18 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417241007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417241007
		arg_30_1.duration_ = 5.47

		local var_30_0 = {
			zh = 4.6,
			ja = 5.466
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
				arg_30_0:Play417241008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10115"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10115 == nil then
				arg_30_1.var_.actorSpriteComps10115 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps10115 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10115 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps10115 = nil
			end

			local var_33_8 = arg_30_1.actors_["10115"].transform
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.var_.moveOldPos10115 = var_33_8.localPosition
				var_33_8.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10115", 3)

				local var_33_10 = var_33_8.childCount

				for iter_33_4 = 0, var_33_10 - 1 do
					local var_33_11 = var_33_8:GetChild(iter_33_4)

					if var_33_11.name == "split_6" or not string.find(var_33_11.name, "split") then
						var_33_11.gameObject:SetActive(true)
					else
						var_33_11.gameObject:SetActive(false)
					end
				end
			end

			local var_33_12 = 0.001

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_9) / var_33_12
				local var_33_14 = Vector3.New(0, -387.3, -246.2)

				var_33_8.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10115, var_33_14, var_33_13)
			end

			if arg_30_1.time_ >= var_33_9 + var_33_12 and arg_30_1.time_ < var_33_9 + var_33_12 + arg_33_0 then
				var_33_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_33_15 = 0
			local var_33_16 = 0.6

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[1113].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(417241007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 24
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241007", "story_v_out_417241.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241007", "story_v_out_417241.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_417241", "417241007", "story_v_out_417241.awb")

						arg_30_1:RecordAudio("417241007", var_33_24)
						arg_30_1:RecordAudio("417241007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417241", "417241007", "story_v_out_417241.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417241", "417241007", "story_v_out_417241.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417241008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417241008
		arg_34_1.duration_ = 6.37

		local var_34_0 = {
			zh = 4.933,
			ja = 6.366
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
				arg_34_0:Play417241009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "SS1710"

			if arg_34_1.bgs_[var_37_0] == nil then
				local var_37_1 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_37_0)
				var_37_1.name = var_37_0
				var_37_1.transform.parent = arg_34_1.stage_.transform
				var_37_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_[var_37_0] = var_37_1
			end

			local var_37_2 = 2

			if var_37_2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				local var_37_3 = manager.ui.mainCamera.transform.localPosition
				local var_37_4 = Vector3.New(0, 0, 10) + Vector3.New(var_37_3.x, var_37_3.y, 0)
				local var_37_5 = arg_34_1.bgs_.SS1710

				var_37_5.transform.localPosition = var_37_4
				var_37_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_6 = var_37_5:GetComponent("SpriteRenderer")

				if var_37_6 and var_37_6.sprite then
					local var_37_7 = (var_37_5.transform.localPosition - var_37_3).z
					local var_37_8 = manager.ui.mainCameraCom_
					local var_37_9 = 2 * var_37_7 * Mathf.Tan(var_37_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_37_10 = var_37_9 * var_37_8.aspect
					local var_37_11 = var_37_6.sprite.bounds.size.x
					local var_37_12 = var_37_6.sprite.bounds.size.y
					local var_37_13 = var_37_10 / var_37_11
					local var_37_14 = var_37_9 / var_37_12
					local var_37_15 = var_37_14 < var_37_13 and var_37_13 or var_37_14

					var_37_5.transform.localScale = Vector3.New(var_37_15, var_37_15, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "SS1710" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_16 = 4

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			local var_37_17 = 0.0999999999999996

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_18 = 0

			if var_37_18 < arg_34_1.time_ and arg_34_1.time_ <= var_37_18 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_19 = 2

			if var_37_18 <= arg_34_1.time_ and arg_34_1.time_ < var_37_18 + var_37_19 then
				local var_37_20 = (arg_34_1.time_ - var_37_18) / var_37_19
				local var_37_21 = Color.New(0, 0, 0)

				var_37_21.a = Mathf.Lerp(0, 1, var_37_20)
				arg_34_1.mask_.color = var_37_21
			end

			if arg_34_1.time_ >= var_37_18 + var_37_19 and arg_34_1.time_ < var_37_18 + var_37_19 + arg_37_0 then
				local var_37_22 = Color.New(0, 0, 0)

				var_37_22.a = 1
				arg_34_1.mask_.color = var_37_22
			end

			local var_37_23 = 2

			if var_37_23 < arg_34_1.time_ and arg_34_1.time_ <= var_37_23 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_24 = 2

			if var_37_23 <= arg_34_1.time_ and arg_34_1.time_ < var_37_23 + var_37_24 then
				local var_37_25 = (arg_34_1.time_ - var_37_23) / var_37_24
				local var_37_26 = Color.New(0, 0, 0)

				var_37_26.a = Mathf.Lerp(1, 0, var_37_25)
				arg_34_1.mask_.color = var_37_26
			end

			if arg_34_1.time_ >= var_37_23 + var_37_24 and arg_34_1.time_ < var_37_23 + var_37_24 + arg_37_0 then
				local var_37_27 = Color.New(0, 0, 0)
				local var_37_28 = 0

				arg_34_1.mask_.enabled = false
				var_37_27.a = var_37_28
				arg_34_1.mask_.color = var_37_27
			end

			local var_37_29 = arg_34_1.actors_["10115"].transform
			local var_37_30 = 1.966

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1.var_.moveOldPos10115 = var_37_29.localPosition
				var_37_29.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10115", 7)

				local var_37_31 = var_37_29.childCount

				for iter_37_2 = 0, var_37_31 - 1 do
					local var_37_32 = var_37_29:GetChild(iter_37_2)

					if var_37_32.name == "" or not string.find(var_37_32.name, "split") then
						var_37_32.gameObject:SetActive(true)
					else
						var_37_32.gameObject:SetActive(false)
					end
				end
			end

			local var_37_33 = 0.001

			if var_37_30 <= arg_34_1.time_ and arg_34_1.time_ < var_37_30 + var_37_33 then
				local var_37_34 = (arg_34_1.time_ - var_37_30) / var_37_33
				local var_37_35 = Vector3.New(0, -2000, 0)

				var_37_29.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10115, var_37_35, var_37_34)
			end

			if arg_34_1.time_ >= var_37_30 + var_37_33 and arg_34_1.time_ < var_37_30 + var_37_33 + arg_37_0 then
				var_37_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_36 = 4
			local var_37_37 = 0.1

			if var_37_36 < arg_34_1.time_ and arg_34_1.time_ <= var_37_36 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_38 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_38:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_39 = arg_34_1:FormatText(StoryNameCfg[1125].name)

				arg_34_1.leftNameTxt_.text = var_37_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_34_1.callingController_:SetSelectedState("calling")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_40 = arg_34_1:GetWordFromCfg(417241008)
				local var_37_41 = arg_34_1:FormatText(var_37_40.content)

				arg_34_1.text_.text = var_37_41

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_42 = 4
				local var_37_43 = utf8.len(var_37_41)
				local var_37_44 = var_37_42 <= 0 and var_37_37 or var_37_37 * (var_37_43 / var_37_42)

				if var_37_44 > 0 and var_37_37 < var_37_44 then
					arg_34_1.talkMaxDuration = var_37_44
					var_37_36 = var_37_36 + 0.3

					if var_37_44 + var_37_36 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_44 + var_37_36
					end
				end

				arg_34_1.text_.text = var_37_41
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241008", "story_v_out_417241.awb") ~= 0 then
					local var_37_45 = manager.audio:GetVoiceLength("story_v_out_417241", "417241008", "story_v_out_417241.awb") / 1000

					if var_37_45 + var_37_36 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_45 + var_37_36
					end

					if var_37_40.prefab_name ~= "" and arg_34_1.actors_[var_37_40.prefab_name] ~= nil then
						local var_37_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_40.prefab_name].transform, "story_v_out_417241", "417241008", "story_v_out_417241.awb")

						arg_34_1:RecordAudio("417241008", var_37_46)
						arg_34_1:RecordAudio("417241008", var_37_46)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417241", "417241008", "story_v_out_417241.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417241", "417241008", "story_v_out_417241.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_47 = var_37_36 + 0.3
			local var_37_48 = math.max(var_37_37, arg_34_1.talkMaxDuration)

			if var_37_47 <= arg_34_1.time_ and arg_34_1.time_ < var_37_47 + var_37_48 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_47) / var_37_48

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_47 + var_37_48 and arg_34_1.time_ < var_37_47 + var_37_48 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417241009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 417241009
		arg_40_1.duration_ = 5.2

		local var_40_0 = {
			zh = 2.6,
			ja = 5.2
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play417241010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.325

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1109].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(417241009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 13
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241009", "story_v_out_417241.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241009", "story_v_out_417241.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_417241", "417241009", "story_v_out_417241.awb")

						arg_40_1:RecordAudio("417241009", var_43_9)
						arg_40_1:RecordAudio("417241009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_417241", "417241009", "story_v_out_417241.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_417241", "417241009", "story_v_out_417241.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play417241010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 417241010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play417241011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.425

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(417241010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 57
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play417241011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417241011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play417241012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.05

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(417241011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 42
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play417241012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417241012
		arg_52_1.duration_ = 6.43

		local var_52_0 = {
			zh = 4.1,
			ja = 6.433
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
				arg_52_0:Play417241013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "SS1710$naive"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = arg_52_1.bgs_["SS1710$naive"].transform
			local var_55_3 = 0

			if var_55_3 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.var_.moveOldPosSS1710_naive = var_55_2.localPosition
			end

			local var_55_4 = 0.001

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_4 then
				local var_55_5 = (arg_52_1.time_ - var_55_3) / var_55_4
				local var_55_6 = Vector3.New(0, 1, 10)

				var_55_2.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosSS1710_naive, var_55_6, var_55_5)
			end

			if arg_52_1.time_ >= var_55_3 + var_55_4 and arg_52_1.time_ < var_55_3 + var_55_4 + arg_55_0 then
				var_55_2.localPosition = Vector3.New(0, 1, 10)
			end

			local var_55_7 = arg_52_1.bgs_["SS1710$naive"].transform
			local var_55_8 = 0.0339999999999999

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.var_.moveOldPosSS1710_naive = var_55_7.localPosition
			end

			local var_55_9 = 1.966

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_9 then
				local var_55_10 = (arg_52_1.time_ - var_55_8) / var_55_9
				local var_55_11 = Vector3.New(-0.2, 1, 10)

				var_55_7.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosSS1710_naive, var_55_11, var_55_10)
			end

			if arg_52_1.time_ >= var_55_8 + var_55_9 and arg_52_1.time_ < var_55_8 + var_55_9 + arg_55_0 then
				var_55_7.localPosition = Vector3.New(-0.2, 1, 10)
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_12 = 2
			local var_55_13 = 0.275

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_14 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_14:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_15 = arg_52_1:FormatText(StoryNameCfg[1109].name)

				arg_52_1.leftNameTxt_.text = var_55_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_16 = arg_52_1:GetWordFromCfg(417241012)
				local var_55_17 = arg_52_1:FormatText(var_55_16.content)

				arg_52_1.text_.text = var_55_17

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_18 = 11
				local var_55_19 = utf8.len(var_55_17)
				local var_55_20 = var_55_18 <= 0 and var_55_13 or var_55_13 * (var_55_19 / var_55_18)

				if var_55_20 > 0 and var_55_13 < var_55_20 then
					arg_52_1.talkMaxDuration = var_55_20
					var_55_12 = var_55_12 + 0.3

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_17
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241012", "story_v_out_417241.awb") ~= 0 then
					local var_55_21 = manager.audio:GetVoiceLength("story_v_out_417241", "417241012", "story_v_out_417241.awb") / 1000

					if var_55_21 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_21 + var_55_12
					end

					if var_55_16.prefab_name ~= "" and arg_52_1.actors_[var_55_16.prefab_name] ~= nil then
						local var_55_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_16.prefab_name].transform, "story_v_out_417241", "417241012", "story_v_out_417241.awb")

						arg_52_1:RecordAudio("417241012", var_55_22)
						arg_52_1:RecordAudio("417241012", var_55_22)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417241", "417241012", "story_v_out_417241.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417241", "417241012", "story_v_out_417241.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_23 = var_55_12 + 0.3
			local var_55_24 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_23) / var_55_24

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1710$naive",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1710$naive",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play417241013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417241013
		arg_58_1.duration_ = 9.9

		local var_58_0 = {
			zh = 4.9,
			ja = 9.9
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
				arg_58_0:Play417241014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.575

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1125].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_58_1.callingController_:SetSelectedState("calling")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(417241013)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 23
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241013", "story_v_out_417241.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241013", "story_v_out_417241.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_417241", "417241013", "story_v_out_417241.awb")

						arg_58_1:RecordAudio("417241013", var_61_9)
						arg_58_1:RecordAudio("417241013", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417241", "417241013", "story_v_out_417241.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417241", "417241013", "story_v_out_417241.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417241014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417241014
		arg_62_1.duration_ = 8.83

		local var_62_0 = {
			zh = 7.466,
			ja = 8.833
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
				arg_62_0:Play417241015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.05

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[1109].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:GetWordFromCfg(417241014)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 42
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241014", "story_v_out_417241.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241014", "story_v_out_417241.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_417241", "417241014", "story_v_out_417241.awb")

						arg_62_1:RecordAudio("417241014", var_65_9)
						arg_62_1:RecordAudio("417241014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417241", "417241014", "story_v_out_417241.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417241", "417241014", "story_v_out_417241.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417241015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417241015
		arg_66_1.duration_ = 3.33

		local var_66_0 = {
			zh = 3,
			ja = 3.333
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
				arg_66_0:Play417241016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.4

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1125].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_66_1.callingController_:SetSelectedState("calling")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(417241015)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241015", "story_v_out_417241.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241015", "story_v_out_417241.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_417241", "417241015", "story_v_out_417241.awb")

						arg_66_1:RecordAudio("417241015", var_69_9)
						arg_66_1:RecordAudio("417241015", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417241", "417241015", "story_v_out_417241.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417241", "417241015", "story_v_out_417241.awb")
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
	Play417241016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417241016
		arg_70_1.duration_ = 10.03

		local var_70_0 = {
			zh = 9.633,
			ja = 10.033
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
				arg_70_0:Play417241017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.125

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1109].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(417241016)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 45
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241016", "story_v_out_417241.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241016", "story_v_out_417241.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_417241", "417241016", "story_v_out_417241.awb")

						arg_70_1:RecordAudio("417241016", var_73_9)
						arg_70_1:RecordAudio("417241016", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417241", "417241016", "story_v_out_417241.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417241", "417241016", "story_v_out_417241.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417241017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417241017
		arg_74_1.duration_ = 4.87

		local var_74_0 = {
			zh = 2.5,
			ja = 4.866
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417241018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.4

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1109].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(417241017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 16
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241017", "story_v_out_417241.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241017", "story_v_out_417241.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_417241", "417241017", "story_v_out_417241.awb")

						arg_74_1:RecordAudio("417241017", var_77_9)
						arg_74_1:RecordAudio("417241017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417241", "417241017", "story_v_out_417241.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417241", "417241017", "story_v_out_417241.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417241018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417241018
		arg_78_1.duration_ = 7.2

		local var_78_0 = {
			zh = 4.1,
			ja = 7.2
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
				arg_78_0:Play417241019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.45

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1125].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_78_1.callingController_:SetSelectedState("calling")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(417241018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 18
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241018", "story_v_out_417241.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241018", "story_v_out_417241.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_417241", "417241018", "story_v_out_417241.awb")

						arg_78_1:RecordAudio("417241018", var_81_9)
						arg_78_1:RecordAudio("417241018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417241", "417241018", "story_v_out_417241.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417241", "417241018", "story_v_out_417241.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417241019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417241019
		arg_82_1.duration_ = 3.67

		local var_82_0 = {
			zh = 2.933,
			ja = 3.666
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
				arg_82_0:Play417241020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.325

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

				local var_85_3 = arg_82_1:GetWordFromCfg(417241019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241019", "story_v_out_417241.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241019", "story_v_out_417241.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_417241", "417241019", "story_v_out_417241.awb")

						arg_82_1:RecordAudio("417241019", var_85_9)
						arg_82_1:RecordAudio("417241019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417241", "417241019", "story_v_out_417241.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417241", "417241019", "story_v_out_417241.awb")
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
	Play417241020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417241020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417241021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.02
			local var_89_1 = 1

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				local var_89_2 = "play"
				local var_89_3 = "effect"

				arg_86_1:AudioAction(var_89_2, var_89_3, "se_story_1311", "se_story_1311_uav01", "")
			end

			local var_89_4 = 0
			local var_89_5 = 1.2

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(417241020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_8 = 48
				local var_89_9 = utf8.len(var_89_7)
				local var_89_10 = var_89_8 <= 0 and var_89_5 or var_89_5 * (var_89_9 / var_89_8)

				if var_89_10 > 0 and var_89_5 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_11 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_11 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_11

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_11 and arg_86_1.time_ < var_89_4 + var_89_11 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417241021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417241021
		arg_90_1.duration_ = 7.13

		local var_90_0 = {
			zh = 3.366,
			ja = 7.133
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
				arg_90_0:Play417241022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.425

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[1109].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(417241021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 17
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241021", "story_v_out_417241.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241021", "story_v_out_417241.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_417241", "417241021", "story_v_out_417241.awb")

						arg_90_1:RecordAudio("417241021", var_93_9)
						arg_90_1:RecordAudio("417241021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417241", "417241021", "story_v_out_417241.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417241", "417241021", "story_v_out_417241.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417241022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417241022
		arg_94_1.duration_ = 8.2

		local var_94_0 = {
			zh = 3.5,
			ja = 8.2
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
				arg_94_0:Play417241023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.5

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1113].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_94_1.callingController_:SetSelectedState("calling")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(417241022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 20
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241022", "story_v_out_417241.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241022", "story_v_out_417241.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_417241", "417241022", "story_v_out_417241.awb")

						arg_94_1:RecordAudio("417241022", var_97_9)
						arg_94_1:RecordAudio("417241022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417241", "417241022", "story_v_out_417241.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417241", "417241022", "story_v_out_417241.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417241023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417241023
		arg_98_1.duration_ = 7.27

		local var_98_0 = {
			zh = 2.5,
			ja = 7.266
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417241024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.325

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[1109].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(417241023)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 13
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241023", "story_v_out_417241.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241023", "story_v_out_417241.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_417241", "417241023", "story_v_out_417241.awb")

						arg_98_1:RecordAudio("417241023", var_101_9)
						arg_98_1:RecordAudio("417241023", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417241", "417241023", "story_v_out_417241.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417241", "417241023", "story_v_out_417241.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417241024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417241024
		arg_102_1.duration_ = 3.3

		local var_102_0 = {
			zh = 2.2,
			ja = 3.3
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
				arg_102_0:Play417241025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.275

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[1113].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_2")

				arg_102_1.callingController_:SetSelectedState("calling")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(417241024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 11
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241024", "story_v_out_417241.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241024", "story_v_out_417241.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_417241", "417241024", "story_v_out_417241.awb")

						arg_102_1:RecordAudio("417241024", var_105_9)
						arg_102_1:RecordAudio("417241024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417241", "417241024", "story_v_out_417241.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417241", "417241024", "story_v_out_417241.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417241025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417241025
		arg_106_1.duration_ = 7.3

		local var_106_0 = {
			zh = 5.1,
			ja = 7.3
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
				arg_106_0:Play417241026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.525

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

				local var_109_3 = arg_106_1:GetWordFromCfg(417241025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241025", "story_v_out_417241.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241025", "story_v_out_417241.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_417241", "417241025", "story_v_out_417241.awb")

						arg_106_1:RecordAudio("417241025", var_109_9)
						arg_106_1:RecordAudio("417241025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417241", "417241025", "story_v_out_417241.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417241", "417241025", "story_v_out_417241.awb")
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
	Play417241026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417241026
		arg_110_1.duration_ = 9.57

		local var_110_0 = {
			zh = 6.7,
			ja = 9.566
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
				arg_110_0:Play417241027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.9

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[1109].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(417241026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 36
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241026", "story_v_out_417241.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241026", "story_v_out_417241.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_417241", "417241026", "story_v_out_417241.awb")

						arg_110_1:RecordAudio("417241026", var_113_9)
						arg_110_1:RecordAudio("417241026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417241", "417241026", "story_v_out_417241.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417241", "417241026", "story_v_out_417241.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417241027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417241027
		arg_114_1.duration_ = 6.4

		local var_114_0 = {
			zh = 4.066,
			ja = 6.4
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
				arg_114_0:Play417241028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.55

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
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_114_1.callingController_:SetSelectedState("calling")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(417241027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241027", "story_v_out_417241.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241027", "story_v_out_417241.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_417241", "417241027", "story_v_out_417241.awb")

						arg_114_1:RecordAudio("417241027", var_117_9)
						arg_114_1:RecordAudio("417241027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417241", "417241027", "story_v_out_417241.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417241", "417241027", "story_v_out_417241.awb")
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
	Play417241028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417241028
		arg_118_1.duration_ = 6.2

		local var_118_0 = {
			zh = 3.466,
			ja = 6.2
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
				arg_118_0:Play417241029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.45

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[1109].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(417241028)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 18
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241028", "story_v_out_417241.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241028", "story_v_out_417241.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_417241", "417241028", "story_v_out_417241.awb")

						arg_118_1:RecordAudio("417241028", var_121_9)
						arg_118_1:RecordAudio("417241028", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417241", "417241028", "story_v_out_417241.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417241", "417241028", "story_v_out_417241.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play417241029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417241029
		arg_122_1.duration_ = 3.8

		local var_122_0 = {
			zh = 2.5,
			ja = 3.8
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
				arg_122_0:Play417241030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.375

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_2 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_2:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_3 = arg_122_1:FormatText(StoryNameCfg[1113].name)

				arg_122_1.leftNameTxt_.text = var_125_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_122_1.callingController_:SetSelectedState("calling")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_4 = arg_122_1:GetWordFromCfg(417241029)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 15
				local var_125_7 = utf8.len(var_125_5)
				local var_125_8 = var_125_6 <= 0 and var_125_1 or var_125_1 * (var_125_7 / var_125_6)

				if var_125_8 > 0 and var_125_1 < var_125_8 then
					arg_122_1.talkMaxDuration = var_125_8
					var_125_0 = var_125_0 + 0.3

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241029", "story_v_out_417241.awb") ~= 0 then
					local var_125_9 = manager.audio:GetVoiceLength("story_v_out_417241", "417241029", "story_v_out_417241.awb") / 1000

					if var_125_9 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_0
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_417241", "417241029", "story_v_out_417241.awb")

						arg_122_1:RecordAudio("417241029", var_125_10)
						arg_122_1:RecordAudio("417241029", var_125_10)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417241", "417241029", "story_v_out_417241.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417241", "417241029", "story_v_out_417241.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = var_125_0 + 0.3
			local var_125_12 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_12 and arg_122_1.time_ < var_125_11 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417241030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417241030
		arg_128_1.duration_ = 7.87

		local var_128_0 = {
			zh = 6.766,
			ja = 7.866
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
				arg_128_0:Play417241031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.825

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[1109].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(417241030)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 33
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241030", "story_v_out_417241.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241030", "story_v_out_417241.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_417241", "417241030", "story_v_out_417241.awb")

						arg_128_1:RecordAudio("417241030", var_131_9)
						arg_128_1:RecordAudio("417241030", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417241", "417241030", "story_v_out_417241.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417241", "417241030", "story_v_out_417241.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417241031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417241031
		arg_132_1.duration_ = 9.17

		local var_132_0 = {
			zh = 5.133,
			ja = 9.166
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
				arg_132_0:Play417241032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.575

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[1109].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(417241031)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 23
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241031", "story_v_out_417241.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241031", "story_v_out_417241.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_417241", "417241031", "story_v_out_417241.awb")

						arg_132_1:RecordAudio("417241031", var_135_9)
						arg_132_1:RecordAudio("417241031", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417241", "417241031", "story_v_out_417241.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417241", "417241031", "story_v_out_417241.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417241032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417241032
		arg_136_1.duration_ = 9

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417241033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 4

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_1 = 0.833333333333333

			if arg_136_1.time_ >= var_139_0 + var_139_1 and arg_136_1.time_ < var_139_0 + var_139_1 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_2 = "I17f"

			if arg_136_1.bgs_[var_139_2] == nil then
				local var_139_3 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_139_2)
				var_139_3.name = var_139_2
				var_139_3.transform.parent = arg_136_1.stage_.transform
				var_139_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_[var_139_2] = var_139_3
			end

			local var_139_4 = 2

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				local var_139_5 = manager.ui.mainCamera.transform.localPosition
				local var_139_6 = Vector3.New(0, 0, 10) + Vector3.New(var_139_5.x, var_139_5.y, 0)
				local var_139_7 = arg_136_1.bgs_.I17f

				var_139_7.transform.localPosition = var_139_6
				var_139_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_8 = var_139_7:GetComponent("SpriteRenderer")

				if var_139_8 and var_139_8.sprite then
					local var_139_9 = (var_139_7.transform.localPosition - var_139_5).z
					local var_139_10 = manager.ui.mainCameraCom_
					local var_139_11 = 2 * var_139_9 * Mathf.Tan(var_139_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_139_12 = var_139_11 * var_139_10.aspect
					local var_139_13 = var_139_8.sprite.bounds.size.x
					local var_139_14 = var_139_8.sprite.bounds.size.y
					local var_139_15 = var_139_12 / var_139_13
					local var_139_16 = var_139_11 / var_139_14
					local var_139_17 = var_139_16 < var_139_15 and var_139_15 or var_139_16

					var_139_7.transform.localScale = Vector3.New(var_139_17, var_139_17, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "I17f" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_18 = 0

			if var_139_18 < arg_136_1.time_ and arg_136_1.time_ <= var_139_18 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_19 = 2

			if var_139_18 <= arg_136_1.time_ and arg_136_1.time_ < var_139_18 + var_139_19 then
				local var_139_20 = (arg_136_1.time_ - var_139_18) / var_139_19
				local var_139_21 = Color.New(0, 0, 0)

				var_139_21.a = Mathf.Lerp(0, 1, var_139_20)
				arg_136_1.mask_.color = var_139_21
			end

			if arg_136_1.time_ >= var_139_18 + var_139_19 and arg_136_1.time_ < var_139_18 + var_139_19 + arg_139_0 then
				local var_139_22 = Color.New(0, 0, 0)

				var_139_22.a = 1
				arg_136_1.mask_.color = var_139_22
			end

			local var_139_23 = 2

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_24 = 2

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24
				local var_139_26 = Color.New(0, 0, 0)

				var_139_26.a = Mathf.Lerp(1, 0, var_139_25)
				arg_136_1.mask_.color = var_139_26
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 then
				local var_139_27 = Color.New(0, 0, 0)
				local var_139_28 = 0

				arg_136_1.mask_.enabled = false
				var_139_27.a = var_139_28
				arg_136_1.mask_.color = var_139_27
			end

			local var_139_29 = "1034"

			if arg_136_1.actors_[var_139_29] == nil then
				local var_139_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_139_30) then
					local var_139_31 = Object.Instantiate(var_139_30, arg_136_1.canvasGo_.transform)

					var_139_31.transform:SetSiblingIndex(1)

					var_139_31.name = var_139_29
					var_139_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_136_1.actors_[var_139_29] = var_139_31

					local var_139_32 = var_139_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_136_1.isInRecall_ then
						for iter_139_2, iter_139_3 in ipairs(var_139_32) do
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_139_33 = arg_136_1.actors_["1034"].transform
			local var_139_34 = 1.966

			if var_139_34 < arg_136_1.time_ and arg_136_1.time_ <= var_139_34 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_33.localPosition
				var_139_33.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 7)

				local var_139_35 = var_139_33.childCount

				for iter_139_4 = 0, var_139_35 - 1 do
					local var_139_36 = var_139_33:GetChild(iter_139_4)

					if var_139_36.name == "" or not string.find(var_139_36.name, "split") then
						var_139_36.gameObject:SetActive(true)
					else
						var_139_36.gameObject:SetActive(false)
					end
				end
			end

			local var_139_37 = 0.001

			if var_139_34 <= arg_136_1.time_ and arg_136_1.time_ < var_139_34 + var_139_37 then
				local var_139_38 = (arg_136_1.time_ - var_139_34) / var_139_37
				local var_139_39 = Vector3.New(0, -2000, 0)

				var_139_33.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, var_139_39, var_139_38)
			end

			if arg_136_1.time_ >= var_139_34 + var_139_37 and arg_136_1.time_ < var_139_34 + var_139_37 + arg_139_0 then
				var_139_33.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_139_40 = arg_136_1.actors_["10115"].transform
			local var_139_41 = 1.966

			if var_139_41 < arg_136_1.time_ and arg_136_1.time_ <= var_139_41 + arg_139_0 then
				arg_136_1.var_.moveOldPos10115 = var_139_40.localPosition
				var_139_40.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("10115", 7)

				local var_139_42 = var_139_40.childCount

				for iter_139_5 = 0, var_139_42 - 1 do
					local var_139_43 = var_139_40:GetChild(iter_139_5)

					if var_139_43.name == "" or not string.find(var_139_43.name, "split") then
						var_139_43.gameObject:SetActive(true)
					else
						var_139_43.gameObject:SetActive(false)
					end
				end
			end

			local var_139_44 = 0.001

			if var_139_41 <= arg_136_1.time_ and arg_136_1.time_ < var_139_41 + var_139_44 then
				local var_139_45 = (arg_136_1.time_ - var_139_41) / var_139_44
				local var_139_46 = Vector3.New(0, -2000, 0)

				var_139_40.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10115, var_139_46, var_139_45)
			end

			if arg_136_1.time_ >= var_139_41 + var_139_44 and arg_136_1.time_ < var_139_41 + var_139_44 + arg_139_0 then
				var_139_40.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_139_47 = 4
			local var_139_48 = 1

			if var_139_47 < arg_136_1.time_ and arg_136_1.time_ <= var_139_47 + arg_139_0 then
				local var_139_49 = "play"
				local var_139_50 = "effect"

				arg_136_1:AudioAction(var_139_49, var_139_50, "se_story_1311", "se_story_1311_uav01", "")
			end

			local var_139_51 = 1.66666666666667
			local var_139_52 = 1

			if var_139_51 < arg_136_1.time_ and arg_136_1.time_ <= var_139_51 + arg_139_0 then
				local var_139_53 = "play"
				local var_139_54 = "effect"

				arg_136_1:AudioAction(var_139_53, var_139_54, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_139_55 = 0
			local var_139_56 = 0.2

			if var_139_55 < arg_136_1.time_ and arg_136_1.time_ <= var_139_55 + arg_139_0 then
				local var_139_57 = "play"
				local var_139_58 = "music"

				arg_136_1:AudioAction(var_139_57, var_139_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_139_59 = ""
				local var_139_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_139_60 ~= "" then
					if arg_136_1.bgmTxt_.text ~= var_139_60 and arg_136_1.bgmTxt_.text ~= "" then
						if arg_136_1.bgmTxt2_.text ~= "" then
							arg_136_1.bgmTxt_.text = arg_136_1.bgmTxt2_.text
						end

						arg_136_1.bgmTxt2_.text = var_139_60

						arg_136_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_136_1.bgmTxt_.text = var_139_60
						arg_136_1.bgmTxt2_.text = var_139_60
					end

					if arg_136_1.bgmTimer then
						arg_136_1.bgmTimer:Stop()

						arg_136_1.bgmTimer = nil
					end

					if arg_136_1.settingData.show_music_name == 1 then
						arg_136_1.musicController:SetSelectedState("show")
						arg_136_1.musicAnimator_:Play("open", 0, 0)

						if arg_136_1.settingData.music_time ~= 0 then
							arg_136_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_136_1.settingData.music_time), function()
								if arg_136_1 == nil or isNil(arg_136_1.bgmTxt_) then
									return
								end

								arg_136_1.musicController:SetSelectedState("hide")
								arg_136_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_139_61 = 1.66666666666667
			local var_139_62 = 1

			if var_139_61 < arg_136_1.time_ and arg_136_1.time_ <= var_139_61 + arg_139_0 then
				local var_139_63 = "play"
				local var_139_64 = "music"

				arg_136_1:AudioAction(var_139_63, var_139_64, "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_139_65 = ""
				local var_139_66 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if var_139_66 ~= "" then
					if arg_136_1.bgmTxt_.text ~= var_139_66 and arg_136_1.bgmTxt_.text ~= "" then
						if arg_136_1.bgmTxt2_.text ~= "" then
							arg_136_1.bgmTxt_.text = arg_136_1.bgmTxt2_.text
						end

						arg_136_1.bgmTxt2_.text = var_139_66

						arg_136_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_136_1.bgmTxt_.text = var_139_66
						arg_136_1.bgmTxt2_.text = var_139_66
					end

					if arg_136_1.bgmTimer then
						arg_136_1.bgmTimer:Stop()

						arg_136_1.bgmTimer = nil
					end

					if arg_136_1.settingData.show_music_name == 1 then
						arg_136_1.musicController:SetSelectedState("show")
						arg_136_1.musicAnimator_:Play("open", 0, 0)

						if arg_136_1.settingData.music_time ~= 0 then
							arg_136_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_136_1.settingData.music_time), function()
								if arg_136_1 == nil or isNil(arg_136_1.bgmTxt_) then
									return
								end

								arg_136_1.musicController:SetSelectedState("hide")
								arg_136_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_67 = 4
			local var_139_68 = 1.3

			if var_139_67 < arg_136_1.time_ and arg_136_1.time_ <= var_139_67 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_69 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_69:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_136_1.dialogCg_.alpha = arg_142_0
				end))
				var_139_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_70 = arg_136_1:GetWordFromCfg(417241032)
				local var_139_71 = arg_136_1:FormatText(var_139_70.content)

				arg_136_1.text_.text = var_139_71

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_72 = 52
				local var_139_73 = utf8.len(var_139_71)
				local var_139_74 = var_139_72 <= 0 and var_139_68 or var_139_68 * (var_139_73 / var_139_72)

				if var_139_74 > 0 and var_139_68 < var_139_74 then
					arg_136_1.talkMaxDuration = var_139_74
					var_139_67 = var_139_67 + 0.3

					if var_139_74 + var_139_67 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_74 + var_139_67
					end
				end

				arg_136_1.text_.text = var_139_71
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_75 = var_139_67 + 0.3
			local var_139_76 = math.max(var_139_68, arg_136_1.talkMaxDuration)

			if var_139_75 <= arg_136_1.time_ and arg_136_1.time_ < var_139_75 + var_139_76 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_75) / var_139_76

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_75 + var_139_76 and arg_136_1.time_ < var_139_75 + var_139_76 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play417241033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417241033
		arg_144_1.duration_ = 9.27

		local var_144_0 = {
			zh = 3.733,
			ja = 9.266
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
				arg_144_0:Play417241034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.375

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[1125].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_144_1.callingController_:SetSelectedState("calling")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(417241033)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 15
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241033", "story_v_out_417241.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241033", "story_v_out_417241.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_417241", "417241033", "story_v_out_417241.awb")

						arg_144_1:RecordAudio("417241033", var_147_9)
						arg_144_1:RecordAudio("417241033", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417241", "417241033", "story_v_out_417241.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417241", "417241033", "story_v_out_417241.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417241034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417241034
		arg_148_1.duration_ = 9.3

		local var_148_0 = {
			zh = 9,
			ja = 9.3
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
				arg_148_0:Play417241035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1034"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_8 = arg_148_1.actors_["1034"].transform
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.var_.moveOldPos1034 = var_151_8.localPosition
				var_151_8.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1034", 3)

				local var_151_10 = var_151_8.childCount

				for iter_151_4 = 0, var_151_10 - 1 do
					local var_151_11 = var_151_8:GetChild(iter_151_4)

					if var_151_11.name == "" or not string.find(var_151_11.name, "split") then
						var_151_11.gameObject:SetActive(true)
					else
						var_151_11.gameObject:SetActive(false)
					end
				end
			end

			local var_151_12 = 0.001

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_9) / var_151_12
				local var_151_14 = Vector3.New(0, -331.9, -324)

				var_151_8.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1034, var_151_14, var_151_13)
			end

			if arg_148_1.time_ >= var_151_9 + var_151_12 and arg_148_1.time_ < var_151_9 + var_151_12 + arg_151_0 then
				var_151_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_151_15 = 0
			local var_151_16 = 1.075

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[1109].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(417241034)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 43
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241034", "story_v_out_417241.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241034", "story_v_out_417241.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_417241", "417241034", "story_v_out_417241.awb")

						arg_148_1:RecordAudio("417241034", var_151_24)
						arg_148_1:RecordAudio("417241034", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417241", "417241034", "story_v_out_417241.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417241", "417241034", "story_v_out_417241.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417241035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417241035
		arg_152_1.duration_ = 6.27

		local var_152_0 = {
			zh = 3.9,
			ja = 6.266
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
				arg_152_0:Play417241036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.525

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1109].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(417241035)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 21
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241035", "story_v_out_417241.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241035", "story_v_out_417241.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_417241", "417241035", "story_v_out_417241.awb")

						arg_152_1:RecordAudio("417241035", var_155_9)
						arg_152_1:RecordAudio("417241035", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417241", "417241035", "story_v_out_417241.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417241", "417241035", "story_v_out_417241.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417241036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417241036
		arg_156_1.duration_ = 8.4

		local var_156_0 = {
			zh = 7.566,
			ja = 8.4
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
				arg_156_0:Play417241037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1034"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 0.5, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_8 = 0
			local var_159_9 = 0.775

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_10 = arg_156_1:FormatText(StoryNameCfg[1125].name)

				arg_156_1.leftNameTxt_.text = var_159_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_156_1.callingController_:SetSelectedState("calling")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_11 = arg_156_1:GetWordFromCfg(417241036)
				local var_159_12 = arg_156_1:FormatText(var_159_11.content)

				arg_156_1.text_.text = var_159_12

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 31
				local var_159_14 = utf8.len(var_159_12)
				local var_159_15 = var_159_13 <= 0 and var_159_9 or var_159_9 * (var_159_14 / var_159_13)

				if var_159_15 > 0 and var_159_9 < var_159_15 then
					arg_156_1.talkMaxDuration = var_159_15

					if var_159_15 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_15 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_12
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241036", "story_v_out_417241.awb") ~= 0 then
					local var_159_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241036", "story_v_out_417241.awb") / 1000

					if var_159_16 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_16 + var_159_8
					end

					if var_159_11.prefab_name ~= "" and arg_156_1.actors_[var_159_11.prefab_name] ~= nil then
						local var_159_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_11.prefab_name].transform, "story_v_out_417241", "417241036", "story_v_out_417241.awb")

						arg_156_1:RecordAudio("417241036", var_159_17)
						arg_156_1:RecordAudio("417241036", var_159_17)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417241", "417241036", "story_v_out_417241.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417241", "417241036", "story_v_out_417241.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_18 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_18 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_18

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_18 and arg_156_1.time_ < var_159_8 + var_159_18 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417241037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417241037
		arg_160_1.duration_ = 8

		local var_160_0 = {
			zh = 7.4,
			ja = 8
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
				arg_160_0:Play417241038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1034"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1034 == nil then
				arg_160_1.var_.actorSpriteComps1034 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps1034 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								local var_163_4 = Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor1.r, var_163_3)
								local var_163_5 = Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor1.g, var_163_3)
								local var_163_6 = Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor1.b, var_163_3)

								iter_163_1.color = Color.New(var_163_4, var_163_5, var_163_6)
							else
								local var_163_7 = Mathf.Lerp(iter_163_1.color.r, 1, var_163_3)

								iter_163_1.color = Color.New(var_163_7, var_163_7, var_163_7)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1034 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_163_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps1034 = nil
			end

			local var_163_8 = "10111"

			if arg_160_1.actors_[var_163_8] == nil then
				local var_163_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

				if not isNil(var_163_9) then
					local var_163_10 = Object.Instantiate(var_163_9, arg_160_1.canvasGo_.transform)

					var_163_10.transform:SetSiblingIndex(1)

					var_163_10.name = var_163_8
					var_163_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_160_1.actors_[var_163_8] = var_163_10

					local var_163_11 = var_163_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_160_1.isInRecall_ then
						for iter_163_4, iter_163_5 in ipairs(var_163_11) do
							iter_163_5.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_163_12 = arg_160_1.actors_["10111"]
			local var_163_13 = 0

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 and not isNil(var_163_12) and arg_160_1.var_.actorSpriteComps10111 == nil then
				arg_160_1.var_.actorSpriteComps10111 = var_163_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_14 = 0.2

			if var_163_13 <= arg_160_1.time_ and arg_160_1.time_ < var_163_13 + var_163_14 and not isNil(var_163_12) then
				local var_163_15 = (arg_160_1.time_ - var_163_13) / var_163_14

				if arg_160_1.var_.actorSpriteComps10111 then
					for iter_163_6, iter_163_7 in pairs(arg_160_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_163_7 then
							if arg_160_1.isInRecall_ then
								local var_163_16 = Mathf.Lerp(iter_163_7.color.r, arg_160_1.hightColor2.r, var_163_15)
								local var_163_17 = Mathf.Lerp(iter_163_7.color.g, arg_160_1.hightColor2.g, var_163_15)
								local var_163_18 = Mathf.Lerp(iter_163_7.color.b, arg_160_1.hightColor2.b, var_163_15)

								iter_163_7.color = Color.New(var_163_16, var_163_17, var_163_18)
							else
								local var_163_19 = Mathf.Lerp(iter_163_7.color.r, 0.5, var_163_15)

								iter_163_7.color = Color.New(var_163_19, var_163_19, var_163_19)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_13 + var_163_14 and arg_160_1.time_ < var_163_13 + var_163_14 + arg_163_0 and not isNil(var_163_12) and arg_160_1.var_.actorSpriteComps10111 then
				for iter_163_8, iter_163_9 in pairs(arg_160_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_163_9 then
						if arg_160_1.isInRecall_ then
							iter_163_9.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10111 = nil
			end

			local var_163_20 = 0
			local var_163_21 = 0.9

			if var_163_20 < arg_160_1.time_ and arg_160_1.time_ <= var_163_20 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_22 = arg_160_1:FormatText(StoryNameCfg[1109].name)

				arg_160_1.leftNameTxt_.text = var_163_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_23 = arg_160_1:GetWordFromCfg(417241037)
				local var_163_24 = arg_160_1:FormatText(var_163_23.content)

				arg_160_1.text_.text = var_163_24

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_25 = 36
				local var_163_26 = utf8.len(var_163_24)
				local var_163_27 = var_163_25 <= 0 and var_163_21 or var_163_21 * (var_163_26 / var_163_25)

				if var_163_27 > 0 and var_163_21 < var_163_27 then
					arg_160_1.talkMaxDuration = var_163_27

					if var_163_27 + var_163_20 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_27 + var_163_20
					end
				end

				arg_160_1.text_.text = var_163_24
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241037", "story_v_out_417241.awb") ~= 0 then
					local var_163_28 = manager.audio:GetVoiceLength("story_v_out_417241", "417241037", "story_v_out_417241.awb") / 1000

					if var_163_28 + var_163_20 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_28 + var_163_20
					end

					if var_163_23.prefab_name ~= "" and arg_160_1.actors_[var_163_23.prefab_name] ~= nil then
						local var_163_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_23.prefab_name].transform, "story_v_out_417241", "417241037", "story_v_out_417241.awb")

						arg_160_1:RecordAudio("417241037", var_163_29)
						arg_160_1:RecordAudio("417241037", var_163_29)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417241", "417241037", "story_v_out_417241.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417241", "417241037", "story_v_out_417241.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_30 = math.max(var_163_21, arg_160_1.talkMaxDuration)

			if var_163_20 <= arg_160_1.time_ and arg_160_1.time_ < var_163_20 + var_163_30 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_20) / var_163_30

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_20 + var_163_30 and arg_160_1.time_ < var_163_20 + var_163_30 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417241038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417241038
		arg_164_1.duration_ = 7.37

		local var_164_0 = {
			zh = 4.966,
			ja = 7.366
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
				arg_164_0:Play417241039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.65

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1109].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(417241038)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 26
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241038", "story_v_out_417241.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241038", "story_v_out_417241.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_417241", "417241038", "story_v_out_417241.awb")

						arg_164_1:RecordAudio("417241038", var_167_9)
						arg_164_1:RecordAudio("417241038", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417241", "417241038", "story_v_out_417241.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417241", "417241038", "story_v_out_417241.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417241039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417241039
		arg_168_1.duration_ = 9.1

		local var_168_0 = {
			zh = 7.966,
			ja = 9.1
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
				arg_168_0:Play417241040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1034"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								local var_171_4 = Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor2.r, var_171_3)
								local var_171_5 = Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor2.g, var_171_3)
								local var_171_6 = Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor2.b, var_171_3)

								iter_171_1.color = Color.New(var_171_4, var_171_5, var_171_6)
							else
								local var_171_7 = Mathf.Lerp(iter_171_1.color.r, 0.5, var_171_3)

								iter_171_1.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_8 = 0
			local var_171_9 = 0.9

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_10 = arg_168_1:FormatText(StoryNameCfg[1125].name)

				arg_168_1.leftNameTxt_.text = var_171_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_168_1.callingController_:SetSelectedState("calling")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_11 = arg_168_1:GetWordFromCfg(417241039)
				local var_171_12 = arg_168_1:FormatText(var_171_11.content)

				arg_168_1.text_.text = var_171_12

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 36
				local var_171_14 = utf8.len(var_171_12)
				local var_171_15 = var_171_13 <= 0 and var_171_9 or var_171_9 * (var_171_14 / var_171_13)

				if var_171_15 > 0 and var_171_9 < var_171_15 then
					arg_168_1.talkMaxDuration = var_171_15

					if var_171_15 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_15 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_12
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241039", "story_v_out_417241.awb") ~= 0 then
					local var_171_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241039", "story_v_out_417241.awb") / 1000

					if var_171_16 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_8
					end

					if var_171_11.prefab_name ~= "" and arg_168_1.actors_[var_171_11.prefab_name] ~= nil then
						local var_171_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_11.prefab_name].transform, "story_v_out_417241", "417241039", "story_v_out_417241.awb")

						arg_168_1:RecordAudio("417241039", var_171_17)
						arg_168_1:RecordAudio("417241039", var_171_17)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417241", "417241039", "story_v_out_417241.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417241", "417241039", "story_v_out_417241.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_18 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_18 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_18

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_18 and arg_168_1.time_ < var_171_8 + var_171_18 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play417241040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417241040
		arg_172_1.duration_ = 7.6

		local var_172_0 = {
			zh = 6.6,
			ja = 7.6
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
				arg_172_0:Play417241041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.775

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[1125].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_172_1.callingController_:SetSelectedState("calling")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(417241040)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241040", "story_v_out_417241.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241040", "story_v_out_417241.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_417241", "417241040", "story_v_out_417241.awb")

						arg_172_1:RecordAudio("417241040", var_175_9)
						arg_172_1:RecordAudio("417241040", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417241", "417241040", "story_v_out_417241.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417241", "417241040", "story_v_out_417241.awb")
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
	Play417241041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417241041
		arg_176_1.duration_ = 8.23

		local var_176_0 = {
			zh = 4.633,
			ja = 8.233
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
				arg_176_0:Play417241042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1034"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 1, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_8 = arg_176_1.actors_["10111"]
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10111 == nil then
				arg_176_1.var_.actorSpriteComps10111 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_10 = 0.2

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 and not isNil(var_179_8) then
				local var_179_11 = (arg_176_1.time_ - var_179_9) / var_179_10

				if arg_176_1.var_.actorSpriteComps10111 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								local var_179_12 = Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, var_179_11)
								local var_179_13 = Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, var_179_11)
								local var_179_14 = Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, var_179_11)

								iter_179_5.color = Color.New(var_179_12, var_179_13, var_179_14)
							else
								local var_179_15 = Mathf.Lerp(iter_179_5.color.r, 0.5, var_179_11)

								iter_179_5.color = Color.New(var_179_15, var_179_15, var_179_15)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10111 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_179_7 then
						if arg_176_1.isInRecall_ then
							iter_179_7.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10111 = nil
			end

			local var_179_16 = 0
			local var_179_17 = 0.475

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_18 = arg_176_1:FormatText(StoryNameCfg[1109].name)

				arg_176_1.leftNameTxt_.text = var_179_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_19 = arg_176_1:GetWordFromCfg(417241041)
				local var_179_20 = arg_176_1:FormatText(var_179_19.content)

				arg_176_1.text_.text = var_179_20

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_21 = 19
				local var_179_22 = utf8.len(var_179_20)
				local var_179_23 = var_179_21 <= 0 and var_179_17 or var_179_17 * (var_179_22 / var_179_21)

				if var_179_23 > 0 and var_179_17 < var_179_23 then
					arg_176_1.talkMaxDuration = var_179_23

					if var_179_23 + var_179_16 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_16
					end
				end

				arg_176_1.text_.text = var_179_20
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241041", "story_v_out_417241.awb") ~= 0 then
					local var_179_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241041", "story_v_out_417241.awb") / 1000

					if var_179_24 + var_179_16 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_24 + var_179_16
					end

					if var_179_19.prefab_name ~= "" and arg_176_1.actors_[var_179_19.prefab_name] ~= nil then
						local var_179_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_19.prefab_name].transform, "story_v_out_417241", "417241041", "story_v_out_417241.awb")

						arg_176_1:RecordAudio("417241041", var_179_25)
						arg_176_1:RecordAudio("417241041", var_179_25)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417241", "417241041", "story_v_out_417241.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417241", "417241041", "story_v_out_417241.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_26 = math.max(var_179_17, arg_176_1.talkMaxDuration)

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_26 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_16) / var_179_26

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_16 + var_179_26 and arg_176_1.time_ < var_179_16 + var_179_26 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417241042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417241042
		arg_180_1.duration_ = 8.53

		local var_180_0 = {
			zh = 5.9,
			ja = 8.533
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
				arg_180_0:Play417241043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1034"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 0.5, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 0.65

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_10 = arg_180_1:FormatText(StoryNameCfg[1125].name)

				arg_180_1.leftNameTxt_.text = var_183_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_180_1.callingController_:SetSelectedState("calling")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_11 = arg_180_1:GetWordFromCfg(417241042)
				local var_183_12 = arg_180_1:FormatText(var_183_11.content)

				arg_180_1.text_.text = var_183_12

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 26
				local var_183_14 = utf8.len(var_183_12)
				local var_183_15 = var_183_13 <= 0 and var_183_9 or var_183_9 * (var_183_14 / var_183_13)

				if var_183_15 > 0 and var_183_9 < var_183_15 then
					arg_180_1.talkMaxDuration = var_183_15

					if var_183_15 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_15 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_12
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241042", "story_v_out_417241.awb") ~= 0 then
					local var_183_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241042", "story_v_out_417241.awb") / 1000

					if var_183_16 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_8
					end

					if var_183_11.prefab_name ~= "" and arg_180_1.actors_[var_183_11.prefab_name] ~= nil then
						local var_183_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_11.prefab_name].transform, "story_v_out_417241", "417241042", "story_v_out_417241.awb")

						arg_180_1:RecordAudio("417241042", var_183_17)
						arg_180_1:RecordAudio("417241042", var_183_17)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417241", "417241042", "story_v_out_417241.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417241", "417241042", "story_v_out_417241.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_18 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_18 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_18

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_18 and arg_180_1.time_ < var_183_8 + var_183_18 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417241043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417241043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417241044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10111"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10111 == nil then
				arg_184_1.var_.actorSpriteComps10111 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps10111 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 0.5, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10111 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10111 = nil
			end

			local var_187_8 = arg_184_1.actors_["1034"].transform
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 then
				arg_184_1.var_.moveOldPos1034 = var_187_8.localPosition
				var_187_8.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("1034", 7)

				local var_187_10 = var_187_8.childCount

				for iter_187_4 = 0, var_187_10 - 1 do
					local var_187_11 = var_187_8:GetChild(iter_187_4)

					if var_187_11.name == "" or not string.find(var_187_11.name, "split") then
						var_187_11.gameObject:SetActive(true)
					else
						var_187_11.gameObject:SetActive(false)
					end
				end
			end

			local var_187_12 = 0.001

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_12 then
				local var_187_13 = (arg_184_1.time_ - var_187_9) / var_187_12
				local var_187_14 = Vector3.New(0, -2000, 0)

				var_187_8.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1034, var_187_14, var_187_13)
			end

			if arg_184_1.time_ >= var_187_9 + var_187_12 and arg_184_1.time_ < var_187_9 + var_187_12 + arg_187_0 then
				var_187_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_187_15 = arg_184_1.actors_["10111"].transform
			local var_187_16 = 0

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.var_.moveOldPos10111 = var_187_15.localPosition
				var_187_15.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10111", 7)

				local var_187_17 = var_187_15.childCount

				for iter_187_5 = 0, var_187_17 - 1 do
					local var_187_18 = var_187_15:GetChild(iter_187_5)

					if var_187_18.name == "" or not string.find(var_187_18.name, "split") then
						var_187_18.gameObject:SetActive(true)
					else
						var_187_18.gameObject:SetActive(false)
					end
				end
			end

			local var_187_19 = 0.001

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_19 then
				local var_187_20 = (arg_184_1.time_ - var_187_16) / var_187_19
				local var_187_21 = Vector3.New(0, -2000, 0)

				var_187_15.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10111, var_187_21, var_187_20)
			end

			if arg_184_1.time_ >= var_187_16 + var_187_19 and arg_184_1.time_ < var_187_16 + var_187_19 + arg_187_0 then
				var_187_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_187_22 = 0.1
			local var_187_23 = 1

			if var_187_22 < arg_184_1.time_ and arg_184_1.time_ <= var_187_22 + arg_187_0 then
				local var_187_24 = "play"
				local var_187_25 = "effect"

				arg_184_1:AudioAction(var_187_24, var_187_25, "se_story_1311", "se_story_1311_door", "")
			end

			local var_187_26 = 0
			local var_187_27 = 0.925

			if var_187_26 < arg_184_1.time_ and arg_184_1.time_ <= var_187_26 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_28 = arg_184_1:GetWordFromCfg(417241043)
				local var_187_29 = arg_184_1:FormatText(var_187_28.content)

				arg_184_1.text_.text = var_187_29

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_30 = 37
				local var_187_31 = utf8.len(var_187_29)
				local var_187_32 = var_187_30 <= 0 and var_187_27 or var_187_27 * (var_187_31 / var_187_30)

				if var_187_32 > 0 and var_187_27 < var_187_32 then
					arg_184_1.talkMaxDuration = var_187_32

					if var_187_32 + var_187_26 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_32 + var_187_26
					end
				end

				arg_184_1.text_.text = var_187_29
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_33 = math.max(var_187_27, arg_184_1.talkMaxDuration)

			if var_187_26 <= arg_184_1.time_ and arg_184_1.time_ < var_187_26 + var_187_33 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_26) / var_187_33

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_26 + var_187_33 and arg_184_1.time_ < var_187_26 + var_187_33 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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
				actorName = "10111",
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
	Play417241044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417241044
		arg_188_1.duration_ = 3.43

		local var_188_0 = {
			zh = 1.366,
			ja = 3.433
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
				arg_188_0:Play417241045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.175

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[1125].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_2")

				arg_188_1.callingController_:SetSelectedState("calling")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:GetWordFromCfg(417241044)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 7
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241044", "story_v_out_417241.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241044", "story_v_out_417241.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_417241", "417241044", "story_v_out_417241.awb")

						arg_188_1:RecordAudio("417241044", var_191_9)
						arg_188_1:RecordAudio("417241044", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417241", "417241044", "story_v_out_417241.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417241", "417241044", "story_v_out_417241.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417241045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417241045
		arg_192_1.duration_ = 2.57

		local var_192_0 = {
			zh = 1.4,
			ja = 2.566
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
				arg_192_0:Play417241046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1034"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_8 = arg_192_1.actors_["1034"].transform
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_8.localPosition
				var_195_8.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 3)

				local var_195_10 = var_195_8.childCount

				for iter_195_4 = 0, var_195_10 - 1 do
					local var_195_11 = var_195_8:GetChild(iter_195_4)

					if var_195_11.name == "split_6" or not string.find(var_195_11.name, "split") then
						var_195_11.gameObject:SetActive(true)
					else
						var_195_11.gameObject:SetActive(false)
					end
				end
			end

			local var_195_12 = 0.001

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_12 then
				local var_195_13 = (arg_192_1.time_ - var_195_9) / var_195_12
				local var_195_14 = Vector3.New(0, -331.9, -324)

				var_195_8.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1034, var_195_14, var_195_13)
			end

			if arg_192_1.time_ >= var_195_9 + var_195_12 and arg_192_1.time_ < var_195_9 + var_195_12 + arg_195_0 then
				var_195_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_195_15 = 0
			local var_195_16 = 0.15

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_17 = arg_192_1:FormatText(StoryNameCfg[1109].name)

				arg_192_1.leftNameTxt_.text = var_195_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_18 = arg_192_1:GetWordFromCfg(417241045)
				local var_195_19 = arg_192_1:FormatText(var_195_18.content)

				arg_192_1.text_.text = var_195_19

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_20 = 6
				local var_195_21 = utf8.len(var_195_19)
				local var_195_22 = var_195_20 <= 0 and var_195_16 or var_195_16 * (var_195_21 / var_195_20)

				if var_195_22 > 0 and var_195_16 < var_195_22 then
					arg_192_1.talkMaxDuration = var_195_22

					if var_195_22 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_22 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_19
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241045", "story_v_out_417241.awb") ~= 0 then
					local var_195_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241045", "story_v_out_417241.awb") / 1000

					if var_195_23 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_23 + var_195_15
					end

					if var_195_18.prefab_name ~= "" and arg_192_1.actors_[var_195_18.prefab_name] ~= nil then
						local var_195_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_18.prefab_name].transform, "story_v_out_417241", "417241045", "story_v_out_417241.awb")

						arg_192_1:RecordAudio("417241045", var_195_24)
						arg_192_1:RecordAudio("417241045", var_195_24)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417241", "417241045", "story_v_out_417241.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417241", "417241045", "story_v_out_417241.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_25 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_25 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_25

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_25 and arg_192_1.time_ < var_195_15 + var_195_25 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play417241046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417241046
		arg_196_1.duration_ = 7.8

		local var_196_0 = {
			zh = 4.766,
			ja = 7.8
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
				arg_196_0:Play417241047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1034"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps1034 == nil then
				arg_196_1.var_.actorSpriteComps1034 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps1034 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor2.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor2.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor2.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 0.5, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps1034 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps1034 = nil
			end

			local var_199_8 = 0
			local var_199_9 = 0.55

			if var_199_8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_10 = arg_196_1:FormatText(StoryNameCfg[1125].name)

				arg_196_1.leftNameTxt_.text = var_199_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_196_1.callingController_:SetSelectedState("calling")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_11 = arg_196_1:GetWordFromCfg(417241046)
				local var_199_12 = arg_196_1:FormatText(var_199_11.content)

				arg_196_1.text_.text = var_199_12

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 22
				local var_199_14 = utf8.len(var_199_12)
				local var_199_15 = var_199_13 <= 0 and var_199_9 or var_199_9 * (var_199_14 / var_199_13)

				if var_199_15 > 0 and var_199_9 < var_199_15 then
					arg_196_1.talkMaxDuration = var_199_15

					if var_199_15 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_15 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_12
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241046", "story_v_out_417241.awb") ~= 0 then
					local var_199_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241046", "story_v_out_417241.awb") / 1000

					if var_199_16 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_16 + var_199_8
					end

					if var_199_11.prefab_name ~= "" and arg_196_1.actors_[var_199_11.prefab_name] ~= nil then
						local var_199_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_11.prefab_name].transform, "story_v_out_417241", "417241046", "story_v_out_417241.awb")

						arg_196_1:RecordAudio("417241046", var_199_17)
						arg_196_1:RecordAudio("417241046", var_199_17)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417241", "417241046", "story_v_out_417241.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417241", "417241046", "story_v_out_417241.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_18 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_18 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_18

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_18 and arg_196_1.time_ < var_199_8 + var_199_18 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417241047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417241047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417241048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10111"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10111 == nil then
				arg_200_1.var_.actorSpriteComps10111 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps10111 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 0.5, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10111 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10111 = nil
			end

			local var_203_8 = arg_200_1.actors_["1034"].transform
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 then
				arg_200_1.var_.moveOldPos1034 = var_203_8.localPosition
				var_203_8.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1034", 7)

				local var_203_10 = var_203_8.childCount

				for iter_203_4 = 0, var_203_10 - 1 do
					local var_203_11 = var_203_8:GetChild(iter_203_4)

					if var_203_11.name == "" or not string.find(var_203_11.name, "split") then
						var_203_11.gameObject:SetActive(true)
					else
						var_203_11.gameObject:SetActive(false)
					end
				end
			end

			local var_203_12 = 0.001

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_12 then
				local var_203_13 = (arg_200_1.time_ - var_203_9) / var_203_12
				local var_203_14 = Vector3.New(0, -2000, 0)

				var_203_8.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1034, var_203_14, var_203_13)
			end

			if arg_200_1.time_ >= var_203_9 + var_203_12 and arg_200_1.time_ < var_203_9 + var_203_12 + arg_203_0 then
				var_203_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_15 = arg_200_1.actors_["10111"].transform
			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.var_.moveOldPos10111 = var_203_15.localPosition
				var_203_15.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10111", 7)

				local var_203_17 = var_203_15.childCount

				for iter_203_5 = 0, var_203_17 - 1 do
					local var_203_18 = var_203_15:GetChild(iter_203_5)

					if var_203_18.name == "" or not string.find(var_203_18.name, "split") then
						var_203_18.gameObject:SetActive(true)
					else
						var_203_18.gameObject:SetActive(false)
					end
				end
			end

			local var_203_19 = 0.001

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_19 then
				local var_203_20 = (arg_200_1.time_ - var_203_16) / var_203_19
				local var_203_21 = Vector3.New(0, -2000, 0)

				var_203_15.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10111, var_203_21, var_203_20)
			end

			if arg_200_1.time_ >= var_203_16 + var_203_19 and arg_200_1.time_ < var_203_16 + var_203_19 + arg_203_0 then
				var_203_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_22 = 0
			local var_203_23 = 1.425

			if var_203_22 < arg_200_1.time_ and arg_200_1.time_ <= var_203_22 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_24 = arg_200_1:GetWordFromCfg(417241047)
				local var_203_25 = arg_200_1:FormatText(var_203_24.content)

				arg_200_1.text_.text = var_203_25

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_26 = 57
				local var_203_27 = utf8.len(var_203_25)
				local var_203_28 = var_203_26 <= 0 and var_203_23 or var_203_23 * (var_203_27 / var_203_26)

				if var_203_28 > 0 and var_203_23 < var_203_28 then
					arg_200_1.talkMaxDuration = var_203_28

					if var_203_28 + var_203_22 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_28 + var_203_22
					end
				end

				arg_200_1.text_.text = var_203_25
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_29 = math.max(var_203_23, arg_200_1.talkMaxDuration)

			if var_203_22 <= arg_200_1.time_ and arg_200_1.time_ < var_203_22 + var_203_29 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_22) / var_203_29

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_22 + var_203_29 and arg_200_1.time_ < var_203_22 + var_203_29 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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
				actorName = "10111",
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
	Play417241048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417241048
		arg_204_1.duration_ = 6.13

		local var_204_0 = {
			zh = 2.8,
			ja = 6.133
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
				arg_204_0:Play417241049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1034"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1034 == nil then
				arg_204_1.var_.actorSpriteComps1034 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps1034 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								local var_207_4 = Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, var_207_3)
								local var_207_5 = Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, var_207_3)
								local var_207_6 = Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, var_207_3)

								iter_207_1.color = Color.New(var_207_4, var_207_5, var_207_6)
							else
								local var_207_7 = Mathf.Lerp(iter_207_1.color.r, 1, var_207_3)

								iter_207_1.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1034 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps1034 = nil
			end

			local var_207_8 = arg_204_1.actors_["1034"].transform
			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.var_.moveOldPos1034 = var_207_8.localPosition
				var_207_8.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("1034", 3)

				local var_207_10 = var_207_8.childCount

				for iter_207_4 = 0, var_207_10 - 1 do
					local var_207_11 = var_207_8:GetChild(iter_207_4)

					if var_207_11.name == "split_3" or not string.find(var_207_11.name, "split") then
						var_207_11.gameObject:SetActive(true)
					else
						var_207_11.gameObject:SetActive(false)
					end
				end
			end

			local var_207_12 = 0.001

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_12 then
				local var_207_13 = (arg_204_1.time_ - var_207_9) / var_207_12
				local var_207_14 = Vector3.New(0, -331.9, -324)

				var_207_8.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1034, var_207_14, var_207_13)
			end

			if arg_204_1.time_ >= var_207_9 + var_207_12 and arg_204_1.time_ < var_207_9 + var_207_12 + arg_207_0 then
				var_207_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_207_15 = 0
			local var_207_16 = 0.35

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[1109].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(417241048)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 14
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241048", "story_v_out_417241.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241048", "story_v_out_417241.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_417241", "417241048", "story_v_out_417241.awb")

						arg_204_1:RecordAudio("417241048", var_207_24)
						arg_204_1:RecordAudio("417241048", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417241", "417241048", "story_v_out_417241.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417241", "417241048", "story_v_out_417241.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417241049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417241049
		arg_208_1.duration_ = 5.7

		local var_208_0 = {
			zh = 5.199999999999,
			ja = 5.699999999999
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
				arg_208_0:Play417241050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 3.999999999999

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_1 = 0.0666666666676665

			if arg_208_1.time_ >= var_211_0 + var_211_1 and arg_208_1.time_ < var_211_0 + var_211_1 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_2 = "ST75"

			if arg_208_1.bgs_[var_211_2] == nil then
				local var_211_3 = Object.Instantiate(arg_208_1.paintGo_)

				var_211_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_211_2)
				var_211_3.name = var_211_2
				var_211_3.transform.parent = arg_208_1.stage_.transform
				var_211_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.bgs_[var_211_2] = var_211_3
			end

			local var_211_4 = 1.999999999999

			if var_211_4 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				local var_211_5 = manager.ui.mainCamera.transform.localPosition
				local var_211_6 = Vector3.New(0, 0, 10) + Vector3.New(var_211_5.x, var_211_5.y, 0)
				local var_211_7 = arg_208_1.bgs_.ST75

				var_211_7.transform.localPosition = var_211_6
				var_211_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_8 = var_211_7:GetComponent("SpriteRenderer")

				if var_211_8 and var_211_8.sprite then
					local var_211_9 = (var_211_7.transform.localPosition - var_211_5).z
					local var_211_10 = manager.ui.mainCameraCom_
					local var_211_11 = 2 * var_211_9 * Mathf.Tan(var_211_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_211_12 = var_211_11 * var_211_10.aspect
					local var_211_13 = var_211_8.sprite.bounds.size.x
					local var_211_14 = var_211_8.sprite.bounds.size.y
					local var_211_15 = var_211_12 / var_211_13
					local var_211_16 = var_211_11 / var_211_14
					local var_211_17 = var_211_16 < var_211_15 and var_211_15 or var_211_16

					var_211_7.transform.localScale = Vector3.New(var_211_17, var_211_17, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST75" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_18 = 0

			if var_211_18 < arg_208_1.time_ and arg_208_1.time_ <= var_211_18 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_19 = 2

			if var_211_18 <= arg_208_1.time_ and arg_208_1.time_ < var_211_18 + var_211_19 then
				local var_211_20 = (arg_208_1.time_ - var_211_18) / var_211_19
				local var_211_21 = Color.New(0, 0, 0)

				var_211_21.a = Mathf.Lerp(0, 1, var_211_20)
				arg_208_1.mask_.color = var_211_21
			end

			if arg_208_1.time_ >= var_211_18 + var_211_19 and arg_208_1.time_ < var_211_18 + var_211_19 + arg_211_0 then
				local var_211_22 = Color.New(0, 0, 0)

				var_211_22.a = 1
				arg_208_1.mask_.color = var_211_22
			end

			local var_211_23 = 2

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_24 = 2

			if var_211_23 <= arg_208_1.time_ and arg_208_1.time_ < var_211_23 + var_211_24 then
				local var_211_25 = (arg_208_1.time_ - var_211_23) / var_211_24
				local var_211_26 = Color.New(0, 0, 0)

				var_211_26.a = Mathf.Lerp(1, 0, var_211_25)
				arg_208_1.mask_.color = var_211_26
			end

			if arg_208_1.time_ >= var_211_23 + var_211_24 and arg_208_1.time_ < var_211_23 + var_211_24 + arg_211_0 then
				local var_211_27 = Color.New(0, 0, 0)
				local var_211_28 = 0

				arg_208_1.mask_.enabled = false
				var_211_27.a = var_211_28
				arg_208_1.mask_.color = var_211_27
			end

			local var_211_29 = "10128"

			if arg_208_1.actors_[var_211_29] == nil then
				local var_211_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_211_30) then
					local var_211_31 = Object.Instantiate(var_211_30, arg_208_1.canvasGo_.transform)

					var_211_31.transform:SetSiblingIndex(1)

					var_211_31.name = var_211_29
					var_211_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_208_1.actors_[var_211_29] = var_211_31

					local var_211_32 = var_211_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_208_1.isInRecall_ then
						for iter_211_2, iter_211_3 in ipairs(var_211_32) do
							iter_211_3.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_211_33 = arg_208_1.actors_["10128"]
			local var_211_34 = 3.66666666666667

			if var_211_34 < arg_208_1.time_ and arg_208_1.time_ <= var_211_34 + arg_211_0 and not isNil(var_211_33) and arg_208_1.var_.actorSpriteComps10128 == nil then
				arg_208_1.var_.actorSpriteComps10128 = var_211_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_35 = 0.2

			if var_211_34 <= arg_208_1.time_ and arg_208_1.time_ < var_211_34 + var_211_35 and not isNil(var_211_33) then
				local var_211_36 = (arg_208_1.time_ - var_211_34) / var_211_35

				if arg_208_1.var_.actorSpriteComps10128 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								local var_211_37 = Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor1.r, var_211_36)
								local var_211_38 = Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor1.g, var_211_36)
								local var_211_39 = Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor1.b, var_211_36)

								iter_211_5.color = Color.New(var_211_37, var_211_38, var_211_39)
							else
								local var_211_40 = Mathf.Lerp(iter_211_5.color.r, 1, var_211_36)

								iter_211_5.color = Color.New(var_211_40, var_211_40, var_211_40)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_34 + var_211_35 and arg_208_1.time_ < var_211_34 + var_211_35 + arg_211_0 and not isNil(var_211_33) and arg_208_1.var_.actorSpriteComps10128 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_211_7 then
						if arg_208_1.isInRecall_ then
							iter_211_7.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10128 = nil
			end

			local var_211_41 = arg_208_1.actors_["1034"].transform
			local var_211_42 = 2

			if var_211_42 < arg_208_1.time_ and arg_208_1.time_ <= var_211_42 + arg_211_0 then
				arg_208_1.var_.moveOldPos1034 = var_211_41.localPosition
				var_211_41.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("1034", 7)

				local var_211_43 = var_211_41.childCount

				for iter_211_8 = 0, var_211_43 - 1 do
					local var_211_44 = var_211_41:GetChild(iter_211_8)

					if var_211_44.name == "" or not string.find(var_211_44.name, "split") then
						var_211_44.gameObject:SetActive(true)
					else
						var_211_44.gameObject:SetActive(false)
					end
				end
			end

			local var_211_45 = 0.001

			if var_211_42 <= arg_208_1.time_ and arg_208_1.time_ < var_211_42 + var_211_45 then
				local var_211_46 = (arg_208_1.time_ - var_211_42) / var_211_45
				local var_211_47 = Vector3.New(0, -2000, 0)

				var_211_41.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1034, var_211_47, var_211_46)
			end

			if arg_208_1.time_ >= var_211_42 + var_211_45 and arg_208_1.time_ < var_211_42 + var_211_45 + arg_211_0 then
				var_211_41.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_48 = arg_208_1.actors_["10128"].transform
			local var_211_49 = 3.66666666666667

			if var_211_49 < arg_208_1.time_ and arg_208_1.time_ <= var_211_49 + arg_211_0 then
				arg_208_1.var_.moveOldPos10128 = var_211_48.localPosition
				var_211_48.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10128", 3)

				local var_211_50 = var_211_48.childCount

				for iter_211_9 = 0, var_211_50 - 1 do
					local var_211_51 = var_211_48:GetChild(iter_211_9)

					if var_211_51.name == "split_5" or not string.find(var_211_51.name, "split") then
						var_211_51.gameObject:SetActive(true)
					else
						var_211_51.gameObject:SetActive(false)
					end
				end
			end

			local var_211_52 = 0.001

			if var_211_49 <= arg_208_1.time_ and arg_208_1.time_ < var_211_49 + var_211_52 then
				local var_211_53 = (arg_208_1.time_ - var_211_49) / var_211_52
				local var_211_54 = Vector3.New(0, -347, -300)

				var_211_48.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10128, var_211_54, var_211_53)
			end

			if arg_208_1.time_ >= var_211_49 + var_211_52 and arg_208_1.time_ < var_211_49 + var_211_52 + arg_211_0 then
				var_211_48.localPosition = Vector3.New(0, -347, -300)
			end

			local var_211_55 = arg_208_1.actors_["10128"]
			local var_211_56 = 3.66666666666667

			if var_211_56 < arg_208_1.time_ and arg_208_1.time_ <= var_211_56 + arg_211_0 then
				local var_211_57 = var_211_55:GetComponentInChildren(typeof(CanvasGroup))

				if var_211_57 then
					arg_208_1.var_.alphaOldValue10128 = var_211_57.alpha
					arg_208_1.var_.characterEffect10128 = var_211_57
				end

				arg_208_1.var_.alphaOldValue10128 = 0
			end

			local var_211_58 = 0.333333333333333

			if var_211_56 <= arg_208_1.time_ and arg_208_1.time_ < var_211_56 + var_211_58 then
				local var_211_59 = (arg_208_1.time_ - var_211_56) / var_211_58
				local var_211_60 = Mathf.Lerp(arg_208_1.var_.alphaOldValue10128, 1, var_211_59)

				if arg_208_1.var_.characterEffect10128 then
					arg_208_1.var_.characterEffect10128.alpha = var_211_60
				end
			end

			if arg_208_1.time_ >= var_211_56 + var_211_58 and arg_208_1.time_ < var_211_56 + var_211_58 + arg_211_0 and arg_208_1.var_.characterEffect10128 then
				arg_208_1.var_.characterEffect10128.alpha = 1
			end

			local var_211_61 = 1.53333333333333
			local var_211_62 = 1

			if var_211_61 < arg_208_1.time_ and arg_208_1.time_ <= var_211_61 + arg_211_0 then
				local var_211_63 = "play"
				local var_211_64 = "effect"

				arg_208_1:AudioAction(var_211_63, var_211_64, "se_story_1311", "se_story_1311_wind_loop03", "")
			end

			local var_211_65 = 0.2
			local var_211_66 = 1

			if var_211_65 < arg_208_1.time_ and arg_208_1.time_ <= var_211_65 + arg_211_0 then
				local var_211_67 = "stop"
				local var_211_68 = "effect"

				arg_208_1:AudioAction(var_211_67, var_211_68, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_211_69 = 0
			local var_211_70 = 0.2

			if var_211_69 < arg_208_1.time_ and arg_208_1.time_ <= var_211_69 + arg_211_0 then
				local var_211_71 = "play"
				local var_211_72 = "music"

				arg_208_1:AudioAction(var_211_71, var_211_72, "ui_battle", "ui_battle_stopbgm", "")

				local var_211_73 = ""
				local var_211_74 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_211_74 ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_74 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_74

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_74
						arg_208_1.bgmTxt2_.text = var_211_74
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_211_75 = 1.36666666666667
			local var_211_76 = 1

			if var_211_75 < arg_208_1.time_ and arg_208_1.time_ <= var_211_75 + arg_211_0 then
				local var_211_77 = "play"
				local var_211_78 = "music"

				arg_208_1:AudioAction(var_211_77, var_211_78, "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_211_79 = ""
				local var_211_80 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if var_211_80 ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_80 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_80

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_80
						arg_208_1.bgmTxt2_.text = var_211_80
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_81 = 3.999999999999
			local var_211_82 = 0.15

			if var_211_81 < arg_208_1.time_ and arg_208_1.time_ <= var_211_81 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_83 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_83:setOnUpdate(LuaHelper.FloatAction(function(arg_214_0)
					arg_208_1.dialogCg_.alpha = arg_214_0
				end))
				var_211_83:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_83:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_84 = arg_208_1:FormatText(StoryNameCfg[595].name)

				arg_208_1.leftNameTxt_.text = var_211_84

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_85 = arg_208_1:GetWordFromCfg(417241049)
				local var_211_86 = arg_208_1:FormatText(var_211_85.content)

				arg_208_1.text_.text = var_211_86

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_87 = 6
				local var_211_88 = utf8.len(var_211_86)
				local var_211_89 = var_211_87 <= 0 and var_211_82 or var_211_82 * (var_211_88 / var_211_87)

				if var_211_89 > 0 and var_211_82 < var_211_89 then
					arg_208_1.talkMaxDuration = var_211_89
					var_211_81 = var_211_81 + 0.3

					if var_211_89 + var_211_81 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_89 + var_211_81
					end
				end

				arg_208_1.text_.text = var_211_86
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241049", "story_v_out_417241.awb") ~= 0 then
					local var_211_90 = manager.audio:GetVoiceLength("story_v_out_417241", "417241049", "story_v_out_417241.awb") / 1000

					if var_211_90 + var_211_81 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_90 + var_211_81
					end

					if var_211_85.prefab_name ~= "" and arg_208_1.actors_[var_211_85.prefab_name] ~= nil then
						local var_211_91 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_85.prefab_name].transform, "story_v_out_417241", "417241049", "story_v_out_417241.awb")

						arg_208_1:RecordAudio("417241049", var_211_91)
						arg_208_1:RecordAudio("417241049", var_211_91)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417241", "417241049", "story_v_out_417241.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417241", "417241049", "story_v_out_417241.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_92 = var_211_81 + 0.3
			local var_211_93 = math.max(var_211_82, arg_208_1.talkMaxDuration)

			if var_211_92 <= arg_208_1.time_ and arg_208_1.time_ < var_211_92 + var_211_93 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_92) / var_211_93

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_92 + var_211_93 and arg_208_1.time_ < var_211_92 + var_211_93 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play417241050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417241050
		arg_216_1.duration_ = 7.27

		local var_216_0 = {
			zh = 4.8,
			ja = 7.266
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
				arg_216_0:Play417241051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10128"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10128 = var_219_0.localPosition
				var_219_0.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10128", 3)

				local var_219_2 = var_219_0.childCount

				for iter_219_0 = 0, var_219_2 - 1 do
					local var_219_3 = var_219_0:GetChild(iter_219_0)

					if var_219_3.name == "split_6" or not string.find(var_219_3.name, "split") then
						var_219_3.gameObject:SetActive(true)
					else
						var_219_3.gameObject:SetActive(false)
					end
				end
			end

			local var_219_4 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_4 then
				local var_219_5 = (arg_216_1.time_ - var_219_1) / var_219_4
				local var_219_6 = Vector3.New(0, -347, -300)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10128, var_219_6, var_219_5)
			end

			if arg_216_1.time_ >= var_219_1 + var_219_4 and arg_216_1.time_ < var_219_1 + var_219_4 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -347, -300)
			end

			local var_219_7 = 0
			local var_219_8 = 0.775

			if var_219_7 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_9 = arg_216_1:FormatText(StoryNameCfg[595].name)

				arg_216_1.leftNameTxt_.text = var_219_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(417241050)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_12 = 31
				local var_219_13 = utf8.len(var_219_11)
				local var_219_14 = var_219_12 <= 0 and var_219_8 or var_219_8 * (var_219_13 / var_219_12)

				if var_219_14 > 0 and var_219_8 < var_219_14 then
					arg_216_1.talkMaxDuration = var_219_14

					if var_219_14 + var_219_7 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_7
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241050", "story_v_out_417241.awb") ~= 0 then
					local var_219_15 = manager.audio:GetVoiceLength("story_v_out_417241", "417241050", "story_v_out_417241.awb") / 1000

					if var_219_15 + var_219_7 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_7
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_417241", "417241050", "story_v_out_417241.awb")

						arg_216_1:RecordAudio("417241050", var_219_16)
						arg_216_1:RecordAudio("417241050", var_219_16)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417241", "417241050", "story_v_out_417241.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417241", "417241050", "story_v_out_417241.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_17 = math.max(var_219_8, arg_216_1.talkMaxDuration)

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_17 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_7) / var_219_17

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_7 + var_219_17 and arg_216_1.time_ < var_219_7 + var_219_17 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play417241051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417241051
		arg_220_1.duration_ = 5.4

		local var_220_0 = {
			zh = 3.691999999999,
			ja = 5.4
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
				arg_220_0:Play417241052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 2.56666666666667
			local var_223_1 = 1

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				local var_223_2 = "stop"
				local var_223_3 = "effect"

				arg_220_1:AudioAction(var_223_2, var_223_3, "se_story_1311", "se_story_1311_wind_loop03", "")
			end

			local var_223_4 = 2.692
			local var_223_5 = 1

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				local var_223_6 = "play"
				local var_223_7 = "effect"

				arg_220_1:AudioAction(var_223_6, var_223_7, "se_story_1311", "se_story_1311_wind_loop01", "")
			end

			local var_223_8 = 0
			local var_223_9 = 0.35

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_10 = arg_220_1:FormatText(StoryNameCfg[595].name)

				arg_220_1.leftNameTxt_.text = var_223_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_11 = arg_220_1:GetWordFromCfg(417241051)
				local var_223_12 = arg_220_1:FormatText(var_223_11.content)

				arg_220_1.text_.text = var_223_12

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 14
				local var_223_14 = utf8.len(var_223_12)
				local var_223_15 = var_223_13 <= 0 and var_223_9 or var_223_9 * (var_223_14 / var_223_13)

				if var_223_15 > 0 and var_223_9 < var_223_15 then
					arg_220_1.talkMaxDuration = var_223_15

					if var_223_15 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_15 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_12
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241051", "story_v_out_417241.awb") ~= 0 then
					local var_223_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241051", "story_v_out_417241.awb") / 1000

					if var_223_16 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_16 + var_223_8
					end

					if var_223_11.prefab_name ~= "" and arg_220_1.actors_[var_223_11.prefab_name] ~= nil then
						local var_223_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_11.prefab_name].transform, "story_v_out_417241", "417241051", "story_v_out_417241.awb")

						arg_220_1:RecordAudio("417241051", var_223_17)
						arg_220_1:RecordAudio("417241051", var_223_17)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417241", "417241051", "story_v_out_417241.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417241", "417241051", "story_v_out_417241.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_18 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_18 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_18

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_18 and arg_220_1.time_ < var_223_8 + var_223_18 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play417241052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417241052
		arg_224_1.duration_ = 5.43

		local var_224_0 = {
			zh = 2.3,
			ja = 5.433
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
				arg_224_0:Play417241053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.25

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[595].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:GetWordFromCfg(417241052)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 10
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241052", "story_v_out_417241.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241052", "story_v_out_417241.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_417241", "417241052", "story_v_out_417241.awb")

						arg_224_1:RecordAudio("417241052", var_227_9)
						arg_224_1:RecordAudio("417241052", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417241", "417241052", "story_v_out_417241.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417241", "417241052", "story_v_out_417241.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play417241053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417241053
		arg_228_1.duration_ = 9

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play417241054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 3.999999999999

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			local var_231_1 = 0.3

			if arg_228_1.time_ >= var_231_0 + var_231_1 and arg_228_1.time_ < var_231_0 + var_231_1 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end

			local var_231_2 = "I17l"

			if arg_228_1.bgs_[var_231_2] == nil then
				local var_231_3 = Object.Instantiate(arg_228_1.paintGo_)

				var_231_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_231_2)
				var_231_3.name = var_231_2
				var_231_3.transform.parent = arg_228_1.stage_.transform
				var_231_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.bgs_[var_231_2] = var_231_3
			end

			local var_231_4 = 2

			if var_231_4 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				local var_231_5 = manager.ui.mainCamera.transform.localPosition
				local var_231_6 = Vector3.New(0, 0, 10) + Vector3.New(var_231_5.x, var_231_5.y, 0)
				local var_231_7 = arg_228_1.bgs_.I17l

				var_231_7.transform.localPosition = var_231_6
				var_231_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_231_8 = var_231_7:GetComponent("SpriteRenderer")

				if var_231_8 and var_231_8.sprite then
					local var_231_9 = (var_231_7.transform.localPosition - var_231_5).z
					local var_231_10 = manager.ui.mainCameraCom_
					local var_231_11 = 2 * var_231_9 * Mathf.Tan(var_231_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_231_12 = var_231_11 * var_231_10.aspect
					local var_231_13 = var_231_8.sprite.bounds.size.x
					local var_231_14 = var_231_8.sprite.bounds.size.y
					local var_231_15 = var_231_12 / var_231_13
					local var_231_16 = var_231_11 / var_231_14
					local var_231_17 = var_231_16 < var_231_15 and var_231_15 or var_231_16

					var_231_7.transform.localScale = Vector3.New(var_231_17, var_231_17, 0)
				end

				for iter_231_0, iter_231_1 in pairs(arg_228_1.bgs_) do
					if iter_231_0 ~= "I17l" then
						iter_231_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_231_18 = 0

			if var_231_18 < arg_228_1.time_ and arg_228_1.time_ <= var_231_18 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_19 = 2

			if var_231_18 <= arg_228_1.time_ and arg_228_1.time_ < var_231_18 + var_231_19 then
				local var_231_20 = (arg_228_1.time_ - var_231_18) / var_231_19
				local var_231_21 = Color.New(0, 0, 0)

				var_231_21.a = Mathf.Lerp(0, 1, var_231_20)
				arg_228_1.mask_.color = var_231_21
			end

			if arg_228_1.time_ >= var_231_18 + var_231_19 and arg_228_1.time_ < var_231_18 + var_231_19 + arg_231_0 then
				local var_231_22 = Color.New(0, 0, 0)

				var_231_22.a = 1
				arg_228_1.mask_.color = var_231_22
			end

			local var_231_23 = 2

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_24 = 2

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_24 then
				local var_231_25 = (arg_228_1.time_ - var_231_23) / var_231_24
				local var_231_26 = Color.New(0, 0, 0)

				var_231_26.a = Mathf.Lerp(1, 0, var_231_25)
				arg_228_1.mask_.color = var_231_26
			end

			if arg_228_1.time_ >= var_231_23 + var_231_24 and arg_228_1.time_ < var_231_23 + var_231_24 + arg_231_0 then
				local var_231_27 = Color.New(0, 0, 0)
				local var_231_28 = 0

				arg_228_1.mask_.enabled = false
				var_231_27.a = var_231_28
				arg_228_1.mask_.color = var_231_27
			end

			local var_231_29 = arg_228_1.actors_["10128"].transform
			local var_231_30 = 2

			if var_231_30 < arg_228_1.time_ and arg_228_1.time_ <= var_231_30 + arg_231_0 then
				arg_228_1.var_.moveOldPos10128 = var_231_29.localPosition
				var_231_29.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10128", 7)

				local var_231_31 = var_231_29.childCount

				for iter_231_2 = 0, var_231_31 - 1 do
					local var_231_32 = var_231_29:GetChild(iter_231_2)

					if var_231_32.name == "" or not string.find(var_231_32.name, "split") then
						var_231_32.gameObject:SetActive(true)
					else
						var_231_32.gameObject:SetActive(false)
					end
				end
			end

			local var_231_33 = 0.001

			if var_231_30 <= arg_228_1.time_ and arg_228_1.time_ < var_231_30 + var_231_33 then
				local var_231_34 = (arg_228_1.time_ - var_231_30) / var_231_33
				local var_231_35 = Vector3.New(0, -2000, -300)

				var_231_29.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10128, var_231_35, var_231_34)
			end

			if arg_228_1.time_ >= var_231_30 + var_231_33 and arg_228_1.time_ < var_231_30 + var_231_33 + arg_231_0 then
				var_231_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_231_36 = manager.ui.mainCamera.transform
			local var_231_37 = 2

			if var_231_37 < arg_228_1.time_ and arg_228_1.time_ <= var_231_37 + arg_231_0 then
				local var_231_38 = arg_228_1.var_.effect10531
				local var_231_39
				local var_231_40 = var_231_36

				if not var_231_38 then
					var_231_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), var_231_40)
					var_231_38.name = "10531"
					arg_228_1.var_.effect10531 = var_231_38
				else
					var_231_38.transform:SetParent(var_231_40)
				end

				var_231_38.transform.localPosition = Vector3.New(0, 0, -4.37)
				var_231_38.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_231_41 = manager.ui.mainCameraCom_
				local var_231_42 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_231_41.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_231_43 = var_231_38.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_231_44 = 15
				local var_231_45 = 2 * var_231_44 * Mathf.Tan(var_231_41.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_231_41.aspect
				local var_231_46 = 1
				local var_231_47 = 1.7777777777777777

				if var_231_47 < var_231_41.aspect then
					var_231_46 = var_231_45 / (2 * var_231_44 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_231_47)
				end

				for iter_231_3, iter_231_4 in ipairs(var_231_43) do
					local var_231_48 = iter_231_4.transform.localScale

					iter_231_4.transform.localScale = Vector3.New(var_231_48.x / var_231_42 * var_231_46, var_231_48.y / var_231_42, var_231_48.z)
				end
			end

			local var_231_49 = 5.5
			local var_231_50 = 1

			if var_231_49 < arg_228_1.time_ and arg_228_1.time_ <= var_231_49 + arg_231_0 then
				local var_231_51 = "play"
				local var_231_52 = "effect"

				arg_228_1:AudioAction(var_231_51, var_231_52, "se_story_1311", "se_story_1311_wind_parachuting", "")
			end

			local var_231_53 = 5.91
			local var_231_54 = 1

			if var_231_53 < arg_228_1.time_ and arg_228_1.time_ <= var_231_53 + arg_231_0 then
				local var_231_55 = "stop"
				local var_231_56 = "effect"

				arg_228_1:AudioAction(var_231_55, var_231_56, "se_story_1311", "se_story_1311_wind_loop01", "")
			end

			local var_231_57 = 6.405
			local var_231_58 = 1

			if var_231_57 < arg_228_1.time_ and arg_228_1.time_ <= var_231_57 + arg_231_0 then
				local var_231_59 = "play"
				local var_231_60 = "effect"

				arg_228_1:AudioAction(var_231_59, var_231_60, "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_61 = 3.999999999999
			local var_231_62 = 1.2

			if var_231_61 < arg_228_1.time_ and arg_228_1.time_ <= var_231_61 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_63 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_63:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_64 = arg_228_1:GetWordFromCfg(417241053)
				local var_231_65 = arg_228_1:FormatText(var_231_64.content)

				arg_228_1.text_.text = var_231_65

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_66 = 48
				local var_231_67 = utf8.len(var_231_65)
				local var_231_68 = var_231_66 <= 0 and var_231_62 or var_231_62 * (var_231_67 / var_231_66)

				if var_231_68 > 0 and var_231_62 < var_231_68 then
					arg_228_1.talkMaxDuration = var_231_68
					var_231_61 = var_231_61 + 0.3

					if var_231_68 + var_231_61 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_68 + var_231_61
					end
				end

				arg_228_1.text_.text = var_231_65
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_69 = var_231_61 + 0.3
			local var_231_70 = math.max(var_231_62, arg_228_1.talkMaxDuration)

			if var_231_69 <= arg_228_1.time_ and arg_228_1.time_ < var_231_69 + var_231_70 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_69) / var_231_70

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_69 + var_231_70 and arg_228_1.time_ < var_231_69 + var_231_70 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play417241054 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417241054
		arg_234_1.duration_ = 9.43

		local var_234_0 = {
			zh = 8.666,
			ja = 9.433
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417241055(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 4

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_1 = 0.3

			if arg_234_1.time_ >= var_237_0 + var_237_1 and arg_234_1.time_ < var_237_0 + var_237_1 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_2 = "SS1709"

			if arg_234_1.bgs_[var_237_2] == nil then
				local var_237_3 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_2)
				var_237_3.name = var_237_2
				var_237_3.transform.parent = arg_234_1.stage_.transform
				var_237_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_2] = var_237_3
			end

			local var_237_4 = 2

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				local var_237_5 = manager.ui.mainCamera.transform.localPosition
				local var_237_6 = Vector3.New(0, 0, 10) + Vector3.New(var_237_5.x, var_237_5.y, 0)
				local var_237_7 = arg_234_1.bgs_.SS1709

				var_237_7.transform.localPosition = var_237_6
				var_237_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_8 = var_237_7:GetComponent("SpriteRenderer")

				if var_237_8 and var_237_8.sprite then
					local var_237_9 = (var_237_7.transform.localPosition - var_237_5).z
					local var_237_10 = manager.ui.mainCameraCom_
					local var_237_11 = 2 * var_237_9 * Mathf.Tan(var_237_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_12 = var_237_11 * var_237_10.aspect
					local var_237_13 = var_237_8.sprite.bounds.size.x
					local var_237_14 = var_237_8.sprite.bounds.size.y
					local var_237_15 = var_237_12 / var_237_13
					local var_237_16 = var_237_11 / var_237_14
					local var_237_17 = var_237_16 < var_237_15 and var_237_15 or var_237_16

					var_237_7.transform.localScale = Vector3.New(var_237_17, var_237_17, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS1709" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_18 = 0

			if var_237_18 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_19 = 2

			if var_237_18 <= arg_234_1.time_ and arg_234_1.time_ < var_237_18 + var_237_19 then
				local var_237_20 = (arg_234_1.time_ - var_237_18) / var_237_19
				local var_237_21 = Color.New(0, 0, 0)

				var_237_21.a = Mathf.Lerp(0, 1, var_237_20)
				arg_234_1.mask_.color = var_237_21
			end

			if arg_234_1.time_ >= var_237_18 + var_237_19 and arg_234_1.time_ < var_237_18 + var_237_19 + arg_237_0 then
				local var_237_22 = Color.New(0, 0, 0)

				var_237_22.a = 1
				arg_234_1.mask_.color = var_237_22
			end

			local var_237_23 = 2

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_24 = 2

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_24 then
				local var_237_25 = (arg_234_1.time_ - var_237_23) / var_237_24
				local var_237_26 = Color.New(0, 0, 0)

				var_237_26.a = Mathf.Lerp(1, 0, var_237_25)
				arg_234_1.mask_.color = var_237_26
			end

			if arg_234_1.time_ >= var_237_23 + var_237_24 and arg_234_1.time_ < var_237_23 + var_237_24 + arg_237_0 then
				local var_237_27 = Color.New(0, 0, 0)
				local var_237_28 = 0

				arg_234_1.mask_.enabled = false
				var_237_27.a = var_237_28
				arg_234_1.mask_.color = var_237_27
			end

			local var_237_29 = arg_234_1.bgs_.SS1709.transform
			local var_237_30 = 2

			if var_237_30 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS1709 = var_237_29.localPosition
			end

			local var_237_31 = 0.001

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_31 then
				local var_237_32 = (arg_234_1.time_ - var_237_30) / var_237_31
				local var_237_33 = Vector3.New(0, 1, 10)

				var_237_29.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS1709, var_237_33, var_237_32)
			end

			if arg_234_1.time_ >= var_237_30 + var_237_31 and arg_234_1.time_ < var_237_30 + var_237_31 + arg_237_0 then
				var_237_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_237_34 = arg_234_1.bgs_.SS1709.transform
			local var_237_35 = 2.034

			if var_237_35 < arg_234_1.time_ and arg_234_1.time_ <= var_237_35 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS1709 = var_237_34.localPosition
			end

			local var_237_36 = 1.966

			if var_237_35 <= arg_234_1.time_ and arg_234_1.time_ < var_237_35 + var_237_36 then
				local var_237_37 = (arg_234_1.time_ - var_237_35) / var_237_36
				local var_237_38 = Vector3.New(0, 1, 9.5)

				var_237_34.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS1709, var_237_38, var_237_37)
			end

			if arg_234_1.time_ >= var_237_35 + var_237_36 and arg_234_1.time_ < var_237_35 + var_237_36 + arg_237_0 then
				var_237_34.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_237_39 = manager.ui.mainCamera.transform
			local var_237_40 = 1.98333333333333

			if var_237_40 < arg_234_1.time_ and arg_234_1.time_ <= var_237_40 + arg_237_0 then
				local var_237_41 = arg_234_1.var_.effect10531

				if var_237_41 then
					Object.Destroy(var_237_41)

					arg_234_1.var_.effect10531 = nil
				end
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_42 = 4
			local var_237_43 = 0.65

			if var_237_42 < arg_234_1.time_ and arg_234_1.time_ <= var_237_42 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_44 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_44:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_45 = arg_234_1:FormatText(StoryNameCfg[595].name)

				arg_234_1.leftNameTxt_.text = var_237_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_46 = arg_234_1:GetWordFromCfg(417241054)
				local var_237_47 = arg_234_1:FormatText(var_237_46.content)

				arg_234_1.text_.text = var_237_47

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_48 = 26
				local var_237_49 = utf8.len(var_237_47)
				local var_237_50 = var_237_48 <= 0 and var_237_43 or var_237_43 * (var_237_49 / var_237_48)

				if var_237_50 > 0 and var_237_43 < var_237_50 then
					arg_234_1.talkMaxDuration = var_237_50
					var_237_42 = var_237_42 + 0.3

					if var_237_50 + var_237_42 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_50 + var_237_42
					end
				end

				arg_234_1.text_.text = var_237_47
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241054", "story_v_out_417241.awb") ~= 0 then
					local var_237_51 = manager.audio:GetVoiceLength("story_v_out_417241", "417241054", "story_v_out_417241.awb") / 1000

					if var_237_51 + var_237_42 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_51 + var_237_42
					end

					if var_237_46.prefab_name ~= "" and arg_234_1.actors_[var_237_46.prefab_name] ~= nil then
						local var_237_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_46.prefab_name].transform, "story_v_out_417241", "417241054", "story_v_out_417241.awb")

						arg_234_1:RecordAudio("417241054", var_237_52)
						arg_234_1:RecordAudio("417241054", var_237_52)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417241", "417241054", "story_v_out_417241.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417241", "417241054", "story_v_out_417241.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_53 = var_237_42 + 0.3
			local var_237_54 = math.max(var_237_43, arg_234_1.talkMaxDuration)

			if var_237_53 <= arg_234_1.time_ and arg_234_1.time_ < var_237_53 + var_237_54 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_53) / var_237_54

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_53 + var_237_54 and arg_234_1.time_ < var_237_53 + var_237_54 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1709",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1709",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417241055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417241055
		arg_240_1.duration_ = 7.07

		local var_240_0 = {
			zh = 4.766,
			ja = 7.066
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
				arg_240_0:Play417241056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.675

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[595].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(417241055)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 27
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241055", "story_v_out_417241.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241055", "story_v_out_417241.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_417241", "417241055", "story_v_out_417241.awb")

						arg_240_1:RecordAudio("417241055", var_243_9)
						arg_240_1:RecordAudio("417241055", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417241", "417241055", "story_v_out_417241.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417241", "417241055", "story_v_out_417241.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417241056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417241056
		arg_244_1.duration_ = 1.87

		local var_244_0 = {
			zh = 1.033,
			ja = 1.866
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
				arg_244_0:Play417241057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.075

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[643].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(417241056)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241056", "story_v_out_417241.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241056", "story_v_out_417241.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_417241", "417241056", "story_v_out_417241.awb")

						arg_244_1:RecordAudio("417241056", var_247_9)
						arg_244_1:RecordAudio("417241056", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417241", "417241056", "story_v_out_417241.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417241", "417241056", "story_v_out_417241.awb")
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
	Play417241057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417241057
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417241058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10128"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos10128 = var_251_0.localPosition
				var_251_0.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10128", 7)

				local var_251_2 = var_251_0.childCount

				for iter_251_0 = 0, var_251_2 - 1 do
					local var_251_3 = var_251_0:GetChild(iter_251_0)

					if var_251_3.name == "" or not string.find(var_251_3.name, "split") then
						var_251_3.gameObject:SetActive(true)
					else
						var_251_3.gameObject:SetActive(false)
					end
				end
			end

			local var_251_4 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_4 then
				local var_251_5 = (arg_248_1.time_ - var_251_1) / var_251_4
				local var_251_6 = Vector3.New(0, -2000, -300)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10128, var_251_6, var_251_5)
			end

			if arg_248_1.time_ >= var_251_1 + var_251_4 and arg_248_1.time_ < var_251_1 + var_251_4 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_251_7 = 0.034
			local var_251_8 = 1

			if var_251_7 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				local var_251_9 = "play"
				local var_251_10 = "effect"

				arg_248_1:AudioAction(var_251_9, var_251_10, "se_story_1311", "se_story_1311_beep", "")
			end

			local var_251_11 = 0
			local var_251_12 = 1.175

			if var_251_11 < arg_248_1.time_ and arg_248_1.time_ <= var_251_11 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_13 = arg_248_1:GetWordFromCfg(417241057)
				local var_251_14 = arg_248_1:FormatText(var_251_13.content)

				arg_248_1.text_.text = var_251_14

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_15 = 47
				local var_251_16 = utf8.len(var_251_14)
				local var_251_17 = var_251_15 <= 0 and var_251_12 or var_251_12 * (var_251_16 / var_251_15)

				if var_251_17 > 0 and var_251_12 < var_251_17 then
					arg_248_1.talkMaxDuration = var_251_17

					if var_251_17 + var_251_11 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_17 + var_251_11
					end
				end

				arg_248_1.text_.text = var_251_14
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_18 = math.max(var_251_12, arg_248_1.talkMaxDuration)

			if var_251_11 <= arg_248_1.time_ and arg_248_1.time_ < var_251_11 + var_251_18 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_11) / var_251_18

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_11 + var_251_18 and arg_248_1.time_ < var_251_11 + var_251_18 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play417241058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417241058
		arg_252_1.duration_ = 5.13

		local var_252_0 = {
			zh = 2.566,
			ja = 5.133
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
				arg_252_0:Play417241059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.02
			local var_255_1 = 1

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				local var_255_2 = "play"
				local var_255_3 = "effect"

				arg_252_1:AudioAction(var_255_2, var_255_3, "se_story_1311", "se_story_1311_cannon", "")
			end

			local var_255_4 = 0
			local var_255_5 = 0.35

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_6 = arg_252_1:FormatText(StoryNameCfg[1125].name)

				arg_252_1.leftNameTxt_.text = var_255_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_252_1.callingController_:SetSelectedState("calling")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_7 = arg_252_1:GetWordFromCfg(417241058)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 14
				local var_255_10 = utf8.len(var_255_8)
				local var_255_11 = var_255_9 <= 0 and var_255_5 or var_255_5 * (var_255_10 / var_255_9)

				if var_255_11 > 0 and var_255_5 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241058", "story_v_out_417241.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_417241", "417241058", "story_v_out_417241.awb") / 1000

					if var_255_12 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_4
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_417241", "417241058", "story_v_out_417241.awb")

						arg_252_1:RecordAudio("417241058", var_255_13)
						arg_252_1:RecordAudio("417241058", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417241", "417241058", "story_v_out_417241.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417241", "417241058", "story_v_out_417241.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_14 and arg_252_1.time_ < var_255_4 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417241059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417241059
		arg_256_1.duration_ = 4.37

		local var_256_0 = {
			zh = 2.5,
			ja = 4.366
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
				arg_256_0:Play417241060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.4

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[595].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(417241059)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 16
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241059", "story_v_out_417241.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241059", "story_v_out_417241.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_417241", "417241059", "story_v_out_417241.awb")

						arg_256_1:RecordAudio("417241059", var_259_9)
						arg_256_1:RecordAudio("417241059", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417241", "417241059", "story_v_out_417241.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417241", "417241059", "story_v_out_417241.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417241060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417241060
		arg_260_1.duration_ = 5.53

		local var_260_0 = {
			zh = 2.2,
			ja = 5.533
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
				arg_260_0:Play417241061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.275

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1125].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_260_1.callingController_:SetSelectedState("calling")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:GetWordFromCfg(417241060)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241060", "story_v_out_417241.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241060", "story_v_out_417241.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_417241", "417241060", "story_v_out_417241.awb")

						arg_260_1:RecordAudio("417241060", var_263_9)
						arg_260_1:RecordAudio("417241060", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417241", "417241060", "story_v_out_417241.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417241", "417241060", "story_v_out_417241.awb")
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
	Play417241061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417241061
		arg_264_1.duration_ = 5

		local var_264_0 = {
			zh = 3.066,
			ja = 5
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
				arg_264_0:Play417241062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.45

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[595].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:GetWordFromCfg(417241061)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 18
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241061", "story_v_out_417241.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241061", "story_v_out_417241.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_417241", "417241061", "story_v_out_417241.awb")

						arg_264_1:RecordAudio("417241061", var_267_9)
						arg_264_1:RecordAudio("417241061", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417241", "417241061", "story_v_out_417241.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417241", "417241061", "story_v_out_417241.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417241062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 417241062
		arg_268_1.duration_ = 6.5

		local var_268_0 = {
			zh = 3.466,
			ja = 6.5
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
				arg_268_0:Play417241063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.3

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[595].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(417241062)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241062", "story_v_out_417241.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241062", "story_v_out_417241.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_417241", "417241062", "story_v_out_417241.awb")

						arg_268_1:RecordAudio("417241062", var_271_9)
						arg_268_1:RecordAudio("417241062", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_417241", "417241062", "story_v_out_417241.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_417241", "417241062", "story_v_out_417241.awb")
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
	Play417241063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 417241063
		arg_272_1.duration_ = 2.33

		local var_272_0 = {
			zh = 1.39966666666667,
			ja = 2.33266666666667
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play417241064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = manager.ui.mainCamera.transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.shakeOldPos = var_275_0.localPosition
			end

			local var_275_2 = 0.5

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / 0.066
				local var_275_4, var_275_5 = math.modf(var_275_3)

				var_275_0.localPosition = Vector3.New(var_275_5 * 0.13, var_275_5 * 0.13, var_275_5 * 0.13) + arg_272_1.var_.shakeOldPos
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = arg_272_1.var_.shakeOldPos
			end

			local var_275_6 = 0
			local var_275_7 = 1

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				local var_275_8 = "play"
				local var_275_9 = "effect"

				arg_272_1:AudioAction(var_275_8, var_275_9, "se_story_1311", "se_story_1311_wind_parachuting02", "")
			end

			if arg_272_1.frameCnt_ <= 1 then
				arg_272_1.dialog_:SetActive(false)
			end

			local var_275_10 = 0.566666666666667
			local var_275_11 = 0.075

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0

				arg_272_1.dialog_:SetActive(true)

				arg_272_1.dialogCg_.alpha = 0

				local var_275_12 = LeanTween.value(arg_272_1.dialog_, 0, 1, 0.3)

				var_275_12:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_272_1.dialogCg_.alpha = arg_276_0
				end))
				var_275_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_272_1.dialog_)
					var_275_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_272_1.duration_ = arg_272_1.duration_ + 0.3

				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_13 = arg_272_1:FormatText(StoryNameCfg[595].name)

				arg_272_1.leftNameTxt_.text = var_275_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_14 = arg_272_1:GetWordFromCfg(417241063)
				local var_275_15 = arg_272_1:FormatText(var_275_14.content)

				arg_272_1.text_.text = var_275_15

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_16 = 3
				local var_275_17 = utf8.len(var_275_15)
				local var_275_18 = var_275_16 <= 0 and var_275_11 or var_275_11 * (var_275_17 / var_275_16)

				if var_275_18 > 0 and var_275_11 < var_275_18 then
					arg_272_1.talkMaxDuration = var_275_18
					var_275_10 = var_275_10 + 0.3

					if var_275_18 + var_275_10 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_18 + var_275_10
					end
				end

				arg_272_1.text_.text = var_275_15
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241063", "story_v_out_417241.awb") ~= 0 then
					local var_275_19 = manager.audio:GetVoiceLength("story_v_out_417241", "417241063", "story_v_out_417241.awb") / 1000

					if var_275_19 + var_275_10 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_19 + var_275_10
					end

					if var_275_14.prefab_name ~= "" and arg_272_1.actors_[var_275_14.prefab_name] ~= nil then
						local var_275_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_14.prefab_name].transform, "story_v_out_417241", "417241063", "story_v_out_417241.awb")

						arg_272_1:RecordAudio("417241063", var_275_20)
						arg_272_1:RecordAudio("417241063", var_275_20)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_417241", "417241063", "story_v_out_417241.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_417241", "417241063", "story_v_out_417241.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_21 = var_275_10 + 0.3
			local var_275_22 = math.max(var_275_11, arg_272_1.talkMaxDuration)

			if var_275_21 <= arg_272_1.time_ and arg_272_1.time_ < var_275_21 + var_275_22 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_21) / var_275_22

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_21 + var_275_22 and arg_272_1.time_ < var_275_21 + var_275_22 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play417241064 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417241064
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417241065(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 4

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			local var_281_1 = 1.03333333333333

			if arg_278_1.time_ >= var_281_0 + var_281_1 and arg_278_1.time_ < var_281_0 + var_281_1 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_2 = 2

			if var_281_2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				local var_281_3 = manager.ui.mainCamera.transform.localPosition
				local var_281_4 = Vector3.New(0, 0, 10) + Vector3.New(var_281_3.x, var_281_3.y, 0)
				local var_281_5 = arg_278_1.bgs_.I17f

				var_281_5.transform.localPosition = var_281_4
				var_281_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_6 = var_281_5:GetComponent("SpriteRenderer")

				if var_281_6 and var_281_6.sprite then
					local var_281_7 = (var_281_5.transform.localPosition - var_281_3).z
					local var_281_8 = manager.ui.mainCameraCom_
					local var_281_9 = 2 * var_281_7 * Mathf.Tan(var_281_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_281_10 = var_281_9 * var_281_8.aspect
					local var_281_11 = var_281_6.sprite.bounds.size.x
					local var_281_12 = var_281_6.sprite.bounds.size.y
					local var_281_13 = var_281_10 / var_281_11
					local var_281_14 = var_281_9 / var_281_12
					local var_281_15 = var_281_14 < var_281_13 and var_281_13 or var_281_14

					var_281_5.transform.localScale = Vector3.New(var_281_15, var_281_15, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "I17f" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_17 = 2

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 then
				local var_281_18 = (arg_278_1.time_ - var_281_16) / var_281_17
				local var_281_19 = Color.New(0, 0, 0)

				var_281_19.a = Mathf.Lerp(0, 1, var_281_18)
				arg_278_1.mask_.color = var_281_19
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				local var_281_20 = Color.New(0, 0, 0)

				var_281_20.a = 1
				arg_278_1.mask_.color = var_281_20
			end

			local var_281_21 = 2

			if var_281_21 < arg_278_1.time_ and arg_278_1.time_ <= var_281_21 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_22 = 2

			if var_281_21 <= arg_278_1.time_ and arg_278_1.time_ < var_281_21 + var_281_22 then
				local var_281_23 = (arg_278_1.time_ - var_281_21) / var_281_22
				local var_281_24 = Color.New(0, 0, 0)

				var_281_24.a = Mathf.Lerp(1, 0, var_281_23)
				arg_278_1.mask_.color = var_281_24
			end

			if arg_278_1.time_ >= var_281_21 + var_281_22 and arg_278_1.time_ < var_281_21 + var_281_22 + arg_281_0 then
				local var_281_25 = Color.New(0, 0, 0)
				local var_281_26 = 0

				arg_278_1.mask_.enabled = false
				var_281_25.a = var_281_26
				arg_278_1.mask_.color = var_281_25
			end

			local var_281_27 = arg_278_1.actors_["10128"].transform
			local var_281_28 = 1.96666666666667

			if var_281_28 < arg_278_1.time_ and arg_278_1.time_ <= var_281_28 + arg_281_0 then
				arg_278_1.var_.moveOldPos10128 = var_281_27.localPosition
				var_281_27.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10128", 7)

				local var_281_29 = var_281_27.childCount

				for iter_281_2 = 0, var_281_29 - 1 do
					local var_281_30 = var_281_27:GetChild(iter_281_2)

					if var_281_30.name == "" or not string.find(var_281_30.name, "split") then
						var_281_30.gameObject:SetActive(true)
					else
						var_281_30.gameObject:SetActive(false)
					end
				end
			end

			local var_281_31 = 0.001

			if var_281_28 <= arg_278_1.time_ and arg_278_1.time_ < var_281_28 + var_281_31 then
				local var_281_32 = (arg_278_1.time_ - var_281_28) / var_281_31
				local var_281_33 = Vector3.New(0, -2000, -300)

				var_281_27.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10128, var_281_33, var_281_32)
			end

			if arg_278_1.time_ >= var_281_28 + var_281_31 and arg_278_1.time_ < var_281_28 + var_281_31 + arg_281_0 then
				var_281_27.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_281_34 = arg_278_1.actors_["10111"].transform
			local var_281_35 = 1.96666666666667

			if var_281_35 < arg_278_1.time_ and arg_278_1.time_ <= var_281_35 + arg_281_0 then
				arg_278_1.var_.moveOldPos10111 = var_281_34.localPosition
				var_281_34.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10111", 7)

				local var_281_36 = var_281_34.childCount

				for iter_281_3 = 0, var_281_36 - 1 do
					local var_281_37 = var_281_34:GetChild(iter_281_3)

					if var_281_37.name == "" or not string.find(var_281_37.name, "split") then
						var_281_37.gameObject:SetActive(true)
					else
						var_281_37.gameObject:SetActive(false)
					end
				end
			end

			local var_281_38 = 0.001

			if var_281_35 <= arg_278_1.time_ and arg_278_1.time_ < var_281_35 + var_281_38 then
				local var_281_39 = (arg_278_1.time_ - var_281_35) / var_281_38
				local var_281_40 = Vector3.New(0, -2000, 0)

				var_281_34.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10111, var_281_40, var_281_39)
			end

			if arg_278_1.time_ >= var_281_35 + var_281_38 and arg_278_1.time_ < var_281_35 + var_281_38 + arg_281_0 then
				var_281_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_41 = 0.7
			local var_281_42 = 1

			if var_281_41 < arg_278_1.time_ and arg_278_1.time_ <= var_281_41 + arg_281_0 then
				local var_281_43 = "stop"
				local var_281_44 = "effect"

				arg_278_1:AudioAction(var_281_43, var_281_44, "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			local var_281_45 = 1.46666666666667
			local var_281_46 = 1

			if var_281_45 < arg_278_1.time_ and arg_278_1.time_ <= var_281_45 + arg_281_0 then
				local var_281_47 = "play"
				local var_281_48 = "effect"

				arg_278_1:AudioAction(var_281_47, var_281_48, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_49 = 4
			local var_281_50 = 1.775

			if var_281_49 < arg_278_1.time_ and arg_278_1.time_ <= var_281_49 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_51 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_51:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_52 = arg_278_1:GetWordFromCfg(417241064)
				local var_281_53 = arg_278_1:FormatText(var_281_52.content)

				arg_278_1.text_.text = var_281_53

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_54 = 71
				local var_281_55 = utf8.len(var_281_53)
				local var_281_56 = var_281_54 <= 0 and var_281_50 or var_281_50 * (var_281_55 / var_281_54)

				if var_281_56 > 0 and var_281_50 < var_281_56 then
					arg_278_1.talkMaxDuration = var_281_56
					var_281_49 = var_281_49 + 0.3

					if var_281_56 + var_281_49 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_56 + var_281_49
					end
				end

				arg_278_1.text_.text = var_281_53
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_57 = var_281_49 + 0.3
			local var_281_58 = math.max(var_281_50, arg_278_1.talkMaxDuration)

			if var_281_57 <= arg_278_1.time_ and arg_278_1.time_ < var_281_57 + var_281_58 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_57) / var_281_58

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_57 + var_281_58 and arg_278_1.time_ < var_281_57 + var_281_58 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play417241065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417241065
		arg_284_1.duration_ = 3.47

		local var_284_0 = {
			zh = 2.2,
			ja = 3.466
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
				arg_284_0:Play417241066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 1.16666666666667
			local var_287_1 = 1

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				local var_287_2 = "play"
				local var_287_3 = "effect"

				arg_284_1:AudioAction(var_287_2, var_287_3, "se_story_15", "se_story_15_gun02", "")
			end

			local var_287_4 = 0
			local var_287_5 = 0.225

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_6 = arg_284_1:FormatText(StoryNameCfg[1113].name)

				arg_284_1.leftNameTxt_.text = var_287_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_7 = arg_284_1:GetWordFromCfg(417241065)
				local var_287_8 = arg_284_1:FormatText(var_287_7.content)

				arg_284_1.text_.text = var_287_8

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 9
				local var_287_10 = utf8.len(var_287_8)
				local var_287_11 = var_287_9 <= 0 and var_287_5 or var_287_5 * (var_287_10 / var_287_9)

				if var_287_11 > 0 and var_287_5 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_8
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241065", "story_v_out_417241.awb") ~= 0 then
					local var_287_12 = manager.audio:GetVoiceLength("story_v_out_417241", "417241065", "story_v_out_417241.awb") / 1000

					if var_287_12 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_4
					end

					if var_287_7.prefab_name ~= "" and arg_284_1.actors_[var_287_7.prefab_name] ~= nil then
						local var_287_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_7.prefab_name].transform, "story_v_out_417241", "417241065", "story_v_out_417241.awb")

						arg_284_1:RecordAudio("417241065", var_287_13)
						arg_284_1:RecordAudio("417241065", var_287_13)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_417241", "417241065", "story_v_out_417241.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_417241", "417241065", "story_v_out_417241.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_14 and arg_284_1.time_ < var_287_4 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play417241066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417241066
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play417241067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.5
			local var_291_1 = 1

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				local var_291_2 = "play"
				local var_291_3 = "effect"

				arg_288_1:AudioAction(var_291_2, var_291_3, "se_story_1311", "se_story_1311_car02", "")
			end

			local var_291_4 = 0
			local var_291_5 = 1.4

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(417241066)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_8 = 56
				local var_291_9 = utf8.len(var_291_7)
				local var_291_10 = var_291_8 <= 0 and var_291_5 or var_291_5 * (var_291_9 / var_291_8)

				if var_291_10 > 0 and var_291_5 < var_291_10 then
					arg_288_1.talkMaxDuration = var_291_10

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_11 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_11 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_11

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_11 and arg_288_1.time_ < var_291_4 + var_291_11 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417241067 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417241067
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417241068(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.56666666666667
			local var_295_1 = 1

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				local var_295_2 = "play"
				local var_295_3 = "effect"

				arg_292_1:AudioAction(var_295_2, var_295_3, "se_story_1310", "se_story_1310_metalball", "")
			end

			local var_295_4 = 0
			local var_295_5 = 1.7

			if var_295_4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_6 = arg_292_1:GetWordFromCfg(417241067)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_8 = 68
				local var_295_9 = utf8.len(var_295_7)
				local var_295_10 = var_295_8 <= 0 and var_295_5 or var_295_5 * (var_295_9 / var_295_8)

				if var_295_10 > 0 and var_295_5 < var_295_10 then
					arg_292_1.talkMaxDuration = var_295_10

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_11 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_11 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_11

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_11 and arg_292_1.time_ < var_295_4 + var_295_11 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417241068 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417241068
		arg_296_1.duration_ = 5.03

		local var_296_0 = {
			zh = 3.166,
			ja = 5.033
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
				arg_296_0:Play417241069(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10128"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos10128 = var_299_0.localPosition
				var_299_0.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10128", 3)

				local var_299_2 = var_299_0.childCount

				for iter_299_0 = 0, var_299_2 - 1 do
					local var_299_3 = var_299_0:GetChild(iter_299_0)

					if var_299_3.name == "" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_4 then
				local var_299_5 = (arg_296_1.time_ - var_299_1) / var_299_4
				local var_299_6 = Vector3.New(0, -347, -300)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10128, var_299_6, var_299_5)
			end

			if arg_296_1.time_ >= var_299_1 + var_299_4 and arg_296_1.time_ < var_299_1 + var_299_4 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, -347, -300)
			end

			local var_299_7 = arg_296_1.actors_["10128"]
			local var_299_8 = 0

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps10128 == nil then
				arg_296_1.var_.actorSpriteComps10128 = var_299_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_9 = 0.2

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_9 and not isNil(var_299_7) then
				local var_299_10 = (arg_296_1.time_ - var_299_8) / var_299_9

				if arg_296_1.var_.actorSpriteComps10128 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								local var_299_11 = Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor1.r, var_299_10)
								local var_299_12 = Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor1.g, var_299_10)
								local var_299_13 = Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor1.b, var_299_10)

								iter_299_2.color = Color.New(var_299_11, var_299_12, var_299_13)
							else
								local var_299_14 = Mathf.Lerp(iter_299_2.color.r, 1, var_299_10)

								iter_299_2.color = Color.New(var_299_14, var_299_14, var_299_14)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_8 + var_299_9 and arg_296_1.time_ < var_299_8 + var_299_9 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps10128 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_299_4 then
						if arg_296_1.isInRecall_ then
							iter_299_4.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10128 = nil
			end

			local var_299_15 = 0
			local var_299_16 = 0.45

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_17 = arg_296_1:FormatText(StoryNameCfg[595].name)

				arg_296_1.leftNameTxt_.text = var_299_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:GetWordFromCfg(417241068)
				local var_299_19 = arg_296_1:FormatText(var_299_18.content)

				arg_296_1.text_.text = var_299_19

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_20 = 18
				local var_299_21 = utf8.len(var_299_19)
				local var_299_22 = var_299_20 <= 0 and var_299_16 or var_299_16 * (var_299_21 / var_299_20)

				if var_299_22 > 0 and var_299_16 < var_299_22 then
					arg_296_1.talkMaxDuration = var_299_22

					if var_299_22 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_22 + var_299_15
					end
				end

				arg_296_1.text_.text = var_299_19
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241068", "story_v_out_417241.awb") ~= 0 then
					local var_299_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241068", "story_v_out_417241.awb") / 1000

					if var_299_23 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_23 + var_299_15
					end

					if var_299_18.prefab_name ~= "" and arg_296_1.actors_[var_299_18.prefab_name] ~= nil then
						local var_299_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_18.prefab_name].transform, "story_v_out_417241", "417241068", "story_v_out_417241.awb")

						arg_296_1:RecordAudio("417241068", var_299_24)
						arg_296_1:RecordAudio("417241068", var_299_24)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417241", "417241068", "story_v_out_417241.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417241", "417241068", "story_v_out_417241.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_25 = math.max(var_299_16, arg_296_1.talkMaxDuration)

			if var_299_15 <= arg_296_1.time_ and arg_296_1.time_ < var_299_15 + var_299_25 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_15) / var_299_25

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_15 + var_299_25 and arg_296_1.time_ < var_299_15 + var_299_25 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play417241069 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417241069
		arg_300_1.duration_ = 6.66

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417241070(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10128"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos10128 = var_303_0.localPosition
				var_303_0.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10128", 7)

				local var_303_2 = var_303_0.childCount

				for iter_303_0 = 0, var_303_2 - 1 do
					local var_303_3 = var_303_0:GetChild(iter_303_0)

					if var_303_3.name == "" or not string.find(var_303_3.name, "split") then
						var_303_3.gameObject:SetActive(true)
					else
						var_303_3.gameObject:SetActive(false)
					end
				end
			end

			local var_303_4 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_4 then
				local var_303_5 = (arg_300_1.time_ - var_303_1) / var_303_4
				local var_303_6 = Vector3.New(0, -2000, -300)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10128, var_303_6, var_303_5)
			end

			if arg_300_1.time_ >= var_303_1 + var_303_4 and arg_300_1.time_ < var_303_1 + var_303_4 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_303_7 = manager.ui.mainCamera.transform
			local var_303_8 = 0

			if var_303_8 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				local var_303_9 = arg_300_1.var_.effect1069
				local var_303_10
				local var_303_11 = var_303_7

				if not var_303_9 then
					var_303_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_303_11)
					var_303_9.name = "1069"
					arg_300_1.var_.effect1069 = var_303_9
				else
					var_303_9.transform:SetParent(var_303_11)
				end

				var_303_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_303_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_303_12 = manager.ui.mainCameraCom_
				local var_303_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_303_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_303_14 = var_303_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_303_15 = 15
				local var_303_16 = 2 * var_303_15 * Mathf.Tan(var_303_12.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_303_12.aspect
				local var_303_17 = 1
				local var_303_18 = 1.7777777777777777

				if var_303_18 < var_303_12.aspect then
					var_303_17 = var_303_16 / (2 * var_303_15 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_303_18)
				end

				for iter_303_1, iter_303_2 in ipairs(var_303_14) do
					local var_303_19 = iter_303_2.transform.localScale

					iter_303_2.transform.localScale = Vector3.New(var_303_19.x / var_303_13 * var_303_17, var_303_19.y / var_303_13, var_303_19.z)
				end
			end

			local var_303_20 = manager.ui.mainCamera.transform
			local var_303_21 = 0.166666666666666

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.var_.shakeOldPos = var_303_20.localPosition
			end

			local var_303_22 = 0.866666666666667

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_22 then
				local var_303_23 = (arg_300_1.time_ - var_303_21) / 0.066
				local var_303_24, var_303_25 = math.modf(var_303_23)

				var_303_20.localPosition = Vector3.New(var_303_25 * 0.13, var_303_25 * 0.13, var_303_25 * 0.13) + arg_300_1.var_.shakeOldPos
			end

			if arg_300_1.time_ >= var_303_21 + var_303_22 and arg_300_1.time_ < var_303_21 + var_303_22 + arg_303_0 then
				var_303_20.localPosition = arg_300_1.var_.shakeOldPos
			end

			local var_303_26 = 0.02
			local var_303_27 = 1

			if var_303_26 < arg_300_1.time_ and arg_300_1.time_ <= var_303_26 + arg_303_0 then
				local var_303_28 = "play"
				local var_303_29 = "effect"

				arg_300_1:AudioAction(var_303_28, var_303_29, "se_story_1310", "se_story_1310_explosion02", "")
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_30 = 1.65833333333333
			local var_303_31 = 1.375

			if var_303_30 < arg_300_1.time_ and arg_300_1.time_ <= var_303_30 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_32 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_32:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_33 = arg_300_1:GetWordFromCfg(417241069)
				local var_303_34 = arg_300_1:FormatText(var_303_33.content)

				arg_300_1.text_.text = var_303_34

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_35 = 55
				local var_303_36 = utf8.len(var_303_34)
				local var_303_37 = var_303_35 <= 0 and var_303_31 or var_303_31 * (var_303_36 / var_303_35)

				if var_303_37 > 0 and var_303_31 < var_303_37 then
					arg_300_1.talkMaxDuration = var_303_37
					var_303_30 = var_303_30 + 0.3

					if var_303_37 + var_303_30 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_37 + var_303_30
					end
				end

				arg_300_1.text_.text = var_303_34
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_38 = var_303_30 + 0.3
			local var_303_39 = math.max(var_303_31, arg_300_1.talkMaxDuration)

			if var_303_38 <= arg_300_1.time_ and arg_300_1.time_ < var_303_38 + var_303_39 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_38) / var_303_39

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_38 + var_303_39 and arg_300_1.time_ < var_303_38 + var_303_39 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play417241070 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417241070
		arg_306_1.duration_ = 3.27

		local var_306_0 = {
			zh = 3.266,
			ja = 2.033
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417241071(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10115"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos10115 = var_309_0.localPosition
				var_309_0.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10115", 3)

				local var_309_2 = var_309_0.childCount

				for iter_309_0 = 0, var_309_2 - 1 do
					local var_309_3 = var_309_0:GetChild(iter_309_0)

					if var_309_3.name == "split_2" or not string.find(var_309_3.name, "split") then
						var_309_3.gameObject:SetActive(true)
					else
						var_309_3.gameObject:SetActive(false)
					end
				end
			end

			local var_309_4 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_4 then
				local var_309_5 = (arg_306_1.time_ - var_309_1) / var_309_4
				local var_309_6 = Vector3.New(0, -387.3, -246.2)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10115, var_309_6, var_309_5)
			end

			if arg_306_1.time_ >= var_309_1 + var_309_4 and arg_306_1.time_ < var_309_1 + var_309_4 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_309_7 = arg_306_1.actors_["10115"]
			local var_309_8 = 0

			if var_309_8 < arg_306_1.time_ and arg_306_1.time_ <= var_309_8 + arg_309_0 and not isNil(var_309_7) and arg_306_1.var_.actorSpriteComps10115 == nil then
				arg_306_1.var_.actorSpriteComps10115 = var_309_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_9 = 0.2

			if var_309_8 <= arg_306_1.time_ and arg_306_1.time_ < var_309_8 + var_309_9 and not isNil(var_309_7) then
				local var_309_10 = (arg_306_1.time_ - var_309_8) / var_309_9

				if arg_306_1.var_.actorSpriteComps10115 then
					for iter_309_1, iter_309_2 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_309_2 then
							if arg_306_1.isInRecall_ then
								local var_309_11 = Mathf.Lerp(iter_309_2.color.r, arg_306_1.hightColor1.r, var_309_10)
								local var_309_12 = Mathf.Lerp(iter_309_2.color.g, arg_306_1.hightColor1.g, var_309_10)
								local var_309_13 = Mathf.Lerp(iter_309_2.color.b, arg_306_1.hightColor1.b, var_309_10)

								iter_309_2.color = Color.New(var_309_11, var_309_12, var_309_13)
							else
								local var_309_14 = Mathf.Lerp(iter_309_2.color.r, 1, var_309_10)

								iter_309_2.color = Color.New(var_309_14, var_309_14, var_309_14)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_8 + var_309_9 and arg_306_1.time_ < var_309_8 + var_309_9 + arg_309_0 and not isNil(var_309_7) and arg_306_1.var_.actorSpriteComps10115 then
				for iter_309_3, iter_309_4 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_309_4 then
						if arg_306_1.isInRecall_ then
							iter_309_4.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps10115 = nil
			end

			local var_309_15 = 0
			local var_309_16 = 0.375

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_17 = arg_306_1:FormatText(StoryNameCfg[1113].name)

				arg_306_1.leftNameTxt_.text = var_309_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_18 = arg_306_1:GetWordFromCfg(417241070)
				local var_309_19 = arg_306_1:FormatText(var_309_18.content)

				arg_306_1.text_.text = var_309_19

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_20 = 15
				local var_309_21 = utf8.len(var_309_19)
				local var_309_22 = var_309_20 <= 0 and var_309_16 or var_309_16 * (var_309_21 / var_309_20)

				if var_309_22 > 0 and var_309_16 < var_309_22 then
					arg_306_1.talkMaxDuration = var_309_22

					if var_309_22 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_15
					end
				end

				arg_306_1.text_.text = var_309_19
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241070", "story_v_out_417241.awb") ~= 0 then
					local var_309_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241070", "story_v_out_417241.awb") / 1000

					if var_309_23 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_23 + var_309_15
					end

					if var_309_18.prefab_name ~= "" and arg_306_1.actors_[var_309_18.prefab_name] ~= nil then
						local var_309_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_18.prefab_name].transform, "story_v_out_417241", "417241070", "story_v_out_417241.awb")

						arg_306_1:RecordAudio("417241070", var_309_24)
						arg_306_1:RecordAudio("417241070", var_309_24)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417241", "417241070", "story_v_out_417241.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417241", "417241070", "story_v_out_417241.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_25 = math.max(var_309_16, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_25 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_15) / var_309_25

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_25 and arg_306_1.time_ < var_309_15 + var_309_25 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play417241071 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417241071
		arg_310_1.duration_ = 3.07

		local var_310_0 = {
			zh = 2.133,
			ja = 3.066
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play417241072(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10128"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10128 == nil then
				arg_310_1.var_.actorSpriteComps10128 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps10128 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 1, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10128 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10128 = nil
			end

			local var_313_8 = arg_310_1.actors_["10115"]
			local var_313_9 = 0

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10115 == nil then
				arg_310_1.var_.actorSpriteComps10115 = var_313_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_10 = 0.2

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 and not isNil(var_313_8) then
				local var_313_11 = (arg_310_1.time_ - var_313_9) / var_313_10

				if arg_310_1.var_.actorSpriteComps10115 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								local var_313_12 = Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, var_313_11)
								local var_313_13 = Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, var_313_11)
								local var_313_14 = Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, var_313_11)

								iter_313_5.color = Color.New(var_313_12, var_313_13, var_313_14)
							else
								local var_313_15 = Mathf.Lerp(iter_313_5.color.r, 0.5, var_313_11)

								iter_313_5.color = Color.New(var_313_15, var_313_15, var_313_15)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10115 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_313_7 then
						if arg_310_1.isInRecall_ then
							iter_313_7.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10115 = nil
			end

			local var_313_16 = arg_310_1.actors_["10115"].transform
			local var_313_17 = 0

			if var_313_17 < arg_310_1.time_ and arg_310_1.time_ <= var_313_17 + arg_313_0 then
				arg_310_1.var_.moveOldPos10115 = var_313_16.localPosition
				var_313_16.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10115", 2)

				local var_313_18 = var_313_16.childCount

				for iter_313_8 = 0, var_313_18 - 1 do
					local var_313_19 = var_313_16:GetChild(iter_313_8)

					if var_313_19.name == "split_2" or not string.find(var_313_19.name, "split") then
						var_313_19.gameObject:SetActive(true)
					else
						var_313_19.gameObject:SetActive(false)
					end
				end
			end

			local var_313_20 = 0.001

			if var_313_17 <= arg_310_1.time_ and arg_310_1.time_ < var_313_17 + var_313_20 then
				local var_313_21 = (arg_310_1.time_ - var_313_17) / var_313_20
				local var_313_22 = Vector3.New(-390, -387.3, -246.2)

				var_313_16.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10115, var_313_22, var_313_21)
			end

			if arg_310_1.time_ >= var_313_17 + var_313_20 and arg_310_1.time_ < var_313_17 + var_313_20 + arg_313_0 then
				var_313_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_313_23 = arg_310_1.actors_["10128"].transform
			local var_313_24 = 0

			if var_313_24 < arg_310_1.time_ and arg_310_1.time_ <= var_313_24 + arg_313_0 then
				arg_310_1.var_.moveOldPos10128 = var_313_23.localPosition
				var_313_23.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10128", 4)

				local var_313_25 = var_313_23.childCount

				for iter_313_9 = 0, var_313_25 - 1 do
					local var_313_26 = var_313_23:GetChild(iter_313_9)

					if var_313_26.name == "split_6" or not string.find(var_313_26.name, "split") then
						var_313_26.gameObject:SetActive(true)
					else
						var_313_26.gameObject:SetActive(false)
					end
				end
			end

			local var_313_27 = 0.001

			if var_313_24 <= arg_310_1.time_ and arg_310_1.time_ < var_313_24 + var_313_27 then
				local var_313_28 = (arg_310_1.time_ - var_313_24) / var_313_27
				local var_313_29 = Vector3.New(390, -347, -300)

				var_313_23.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10128, var_313_29, var_313_28)
			end

			if arg_310_1.time_ >= var_313_24 + var_313_27 and arg_310_1.time_ < var_313_24 + var_313_27 + arg_313_0 then
				var_313_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_313_30 = 0
			local var_313_31 = 0.25

			if var_313_30 < arg_310_1.time_ and arg_310_1.time_ <= var_313_30 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_32 = arg_310_1:FormatText(StoryNameCfg[595].name)

				arg_310_1.leftNameTxt_.text = var_313_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_33 = arg_310_1:GetWordFromCfg(417241071)
				local var_313_34 = arg_310_1:FormatText(var_313_33.content)

				arg_310_1.text_.text = var_313_34

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_35 = 10
				local var_313_36 = utf8.len(var_313_34)
				local var_313_37 = var_313_35 <= 0 and var_313_31 or var_313_31 * (var_313_36 / var_313_35)

				if var_313_37 > 0 and var_313_31 < var_313_37 then
					arg_310_1.talkMaxDuration = var_313_37

					if var_313_37 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_37 + var_313_30
					end
				end

				arg_310_1.text_.text = var_313_34
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241071", "story_v_out_417241.awb") ~= 0 then
					local var_313_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241071", "story_v_out_417241.awb") / 1000

					if var_313_38 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_38 + var_313_30
					end

					if var_313_33.prefab_name ~= "" and arg_310_1.actors_[var_313_33.prefab_name] ~= nil then
						local var_313_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_33.prefab_name].transform, "story_v_out_417241", "417241071", "story_v_out_417241.awb")

						arg_310_1:RecordAudio("417241071", var_313_39)
						arg_310_1:RecordAudio("417241071", var_313_39)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417241", "417241071", "story_v_out_417241.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417241", "417241071", "story_v_out_417241.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_40 = math.max(var_313_31, arg_310_1.talkMaxDuration)

			if var_313_30 <= arg_310_1.time_ and arg_310_1.time_ < var_313_30 + var_313_40 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_30) / var_313_40

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_30 + var_313_40 and arg_310_1.time_ < var_313_30 + var_313_40 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play417241072 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417241072
		arg_314_1.duration_ = 5.93

		local var_314_0 = {
			zh = 4.366,
			ja = 5.933
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play417241073(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10115"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10115 == nil then
				arg_314_1.var_.actorSpriteComps10115 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps10115 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 1, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10115 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10115 = nil
			end

			local var_317_8 = arg_314_1.actors_["10128"]
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10128 == nil then
				arg_314_1.var_.actorSpriteComps10128 = var_317_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_10 = 0.2

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_10 and not isNil(var_317_8) then
				local var_317_11 = (arg_314_1.time_ - var_317_9) / var_317_10

				if arg_314_1.var_.actorSpriteComps10128 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								local var_317_12 = Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor2.r, var_317_11)
								local var_317_13 = Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor2.g, var_317_11)
								local var_317_14 = Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor2.b, var_317_11)

								iter_317_5.color = Color.New(var_317_12, var_317_13, var_317_14)
							else
								local var_317_15 = Mathf.Lerp(iter_317_5.color.r, 0.5, var_317_11)

								iter_317_5.color = Color.New(var_317_15, var_317_15, var_317_15)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_9 + var_317_10 and arg_314_1.time_ < var_317_9 + var_317_10 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10128 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_317_7 then
						if arg_314_1.isInRecall_ then
							iter_317_7.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10128 = nil
			end

			local var_317_16 = 0
			local var_317_17 = 0.4

			if var_317_16 < arg_314_1.time_ and arg_314_1.time_ <= var_317_16 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_18 = arg_314_1:FormatText(StoryNameCfg[1113].name)

				arg_314_1.leftNameTxt_.text = var_317_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_19 = arg_314_1:GetWordFromCfg(417241072)
				local var_317_20 = arg_314_1:FormatText(var_317_19.content)

				arg_314_1.text_.text = var_317_20

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_21 = 16
				local var_317_22 = utf8.len(var_317_20)
				local var_317_23 = var_317_21 <= 0 and var_317_17 or var_317_17 * (var_317_22 / var_317_21)

				if var_317_23 > 0 and var_317_17 < var_317_23 then
					arg_314_1.talkMaxDuration = var_317_23

					if var_317_23 + var_317_16 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_23 + var_317_16
					end
				end

				arg_314_1.text_.text = var_317_20
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241072", "story_v_out_417241.awb") ~= 0 then
					local var_317_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241072", "story_v_out_417241.awb") / 1000

					if var_317_24 + var_317_16 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_24 + var_317_16
					end

					if var_317_19.prefab_name ~= "" and arg_314_1.actors_[var_317_19.prefab_name] ~= nil then
						local var_317_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_19.prefab_name].transform, "story_v_out_417241", "417241072", "story_v_out_417241.awb")

						arg_314_1:RecordAudio("417241072", var_317_25)
						arg_314_1:RecordAudio("417241072", var_317_25)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_417241", "417241072", "story_v_out_417241.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_417241", "417241072", "story_v_out_417241.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_26 = math.max(var_317_17, arg_314_1.talkMaxDuration)

			if var_317_16 <= arg_314_1.time_ and arg_314_1.time_ < var_317_16 + var_317_26 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_16) / var_317_26

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_16 + var_317_26 and arg_314_1.time_ < var_317_16 + var_317_26 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417241073 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417241073
		arg_318_1.duration_ = 3.77

		local var_318_0 = {
			zh = 3.166,
			ja = 3.766
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play417241074(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["10128"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps10128 == nil then
				arg_318_1.var_.actorSpriteComps10128 = var_321_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.actorSpriteComps10128 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								local var_321_4 = Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, var_321_3)
								local var_321_5 = Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, var_321_3)
								local var_321_6 = Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, var_321_3)

								iter_321_1.color = Color.New(var_321_4, var_321_5, var_321_6)
							else
								local var_321_7 = Mathf.Lerp(iter_321_1.color.r, 1, var_321_3)

								iter_321_1.color = Color.New(var_321_7, var_321_7, var_321_7)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps10128 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_321_3 then
						if arg_318_1.isInRecall_ then
							iter_321_3.color = arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_321_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps10128 = nil
			end

			local var_321_8 = arg_318_1.actors_["10115"]
			local var_321_9 = 0

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps10115 == nil then
				arg_318_1.var_.actorSpriteComps10115 = var_321_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_10 = 0.2

			if var_321_9 <= arg_318_1.time_ and arg_318_1.time_ < var_321_9 + var_321_10 and not isNil(var_321_8) then
				local var_321_11 = (arg_318_1.time_ - var_321_9) / var_321_10

				if arg_318_1.var_.actorSpriteComps10115 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								local var_321_12 = Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor2.r, var_321_11)
								local var_321_13 = Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor2.g, var_321_11)
								local var_321_14 = Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor2.b, var_321_11)

								iter_321_5.color = Color.New(var_321_12, var_321_13, var_321_14)
							else
								local var_321_15 = Mathf.Lerp(iter_321_5.color.r, 0.5, var_321_11)

								iter_321_5.color = Color.New(var_321_15, var_321_15, var_321_15)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_9 + var_321_10 and arg_318_1.time_ < var_321_9 + var_321_10 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps10115 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_321_7 then
						if arg_318_1.isInRecall_ then
							iter_321_7.color = arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_321_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps10115 = nil
			end

			local var_321_16 = 0
			local var_321_17 = 0.325

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_18 = arg_318_1:FormatText(StoryNameCfg[595].name)

				arg_318_1.leftNameTxt_.text = var_321_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_19 = arg_318_1:GetWordFromCfg(417241073)
				local var_321_20 = arg_318_1:FormatText(var_321_19.content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_21 = 13
				local var_321_22 = utf8.len(var_321_20)
				local var_321_23 = var_321_21 <= 0 and var_321_17 or var_321_17 * (var_321_22 / var_321_21)

				if var_321_23 > 0 and var_321_17 < var_321_23 then
					arg_318_1.talkMaxDuration = var_321_23

					if var_321_23 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_16
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241073", "story_v_out_417241.awb") ~= 0 then
					local var_321_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241073", "story_v_out_417241.awb") / 1000

					if var_321_24 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_16
					end

					if var_321_19.prefab_name ~= "" and arg_318_1.actors_[var_321_19.prefab_name] ~= nil then
						local var_321_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_19.prefab_name].transform, "story_v_out_417241", "417241073", "story_v_out_417241.awb")

						arg_318_1:RecordAudio("417241073", var_321_25)
						arg_318_1:RecordAudio("417241073", var_321_25)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417241", "417241073", "story_v_out_417241.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417241", "417241073", "story_v_out_417241.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_26 = math.max(var_321_17, arg_318_1.talkMaxDuration)

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_26 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_16) / var_321_26

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_16 + var_321_26 and arg_318_1.time_ < var_321_16 + var_321_26 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417241074 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417241074
		arg_322_1.duration_ = 1.6

		local var_322_0 = {
			zh = 1.6,
			ja = 1.566
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417241075(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10115"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10115 == nil then
				arg_322_1.var_.actorSpriteComps10115 = var_325_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.actorSpriteComps10115 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								local var_325_4 = Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, var_325_3)
								local var_325_5 = Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, var_325_3)
								local var_325_6 = Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, var_325_3)

								iter_325_1.color = Color.New(var_325_4, var_325_5, var_325_6)
							else
								local var_325_7 = Mathf.Lerp(iter_325_1.color.r, 1, var_325_3)

								iter_325_1.color = Color.New(var_325_7, var_325_7, var_325_7)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10115 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_325_3 then
						if arg_322_1.isInRecall_ then
							iter_325_3.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_325_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps10115 = nil
			end

			local var_325_8 = arg_322_1.actors_["10128"]
			local var_325_9 = 0

			if var_325_9 < arg_322_1.time_ and arg_322_1.time_ <= var_325_9 + arg_325_0 and not isNil(var_325_8) and arg_322_1.var_.actorSpriteComps10128 == nil then
				arg_322_1.var_.actorSpriteComps10128 = var_325_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_10 = 0.2

			if var_325_9 <= arg_322_1.time_ and arg_322_1.time_ < var_325_9 + var_325_10 and not isNil(var_325_8) then
				local var_325_11 = (arg_322_1.time_ - var_325_9) / var_325_10

				if arg_322_1.var_.actorSpriteComps10128 then
					for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_325_5 then
							if arg_322_1.isInRecall_ then
								local var_325_12 = Mathf.Lerp(iter_325_5.color.r, arg_322_1.hightColor2.r, var_325_11)
								local var_325_13 = Mathf.Lerp(iter_325_5.color.g, arg_322_1.hightColor2.g, var_325_11)
								local var_325_14 = Mathf.Lerp(iter_325_5.color.b, arg_322_1.hightColor2.b, var_325_11)

								iter_325_5.color = Color.New(var_325_12, var_325_13, var_325_14)
							else
								local var_325_15 = Mathf.Lerp(iter_325_5.color.r, 0.5, var_325_11)

								iter_325_5.color = Color.New(var_325_15, var_325_15, var_325_15)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_9 + var_325_10 and arg_322_1.time_ < var_325_9 + var_325_10 + arg_325_0 and not isNil(var_325_8) and arg_322_1.var_.actorSpriteComps10128 then
				for iter_325_6, iter_325_7 in pairs(arg_322_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_325_7 then
						if arg_322_1.isInRecall_ then
							iter_325_7.color = arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_325_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps10128 = nil
			end

			local var_325_16 = 0
			local var_325_17 = 0.2

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_18 = arg_322_1:FormatText(StoryNameCfg[1113].name)

				arg_322_1.leftNameTxt_.text = var_325_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_19 = arg_322_1:GetWordFromCfg(417241074)
				local var_325_20 = arg_322_1:FormatText(var_325_19.content)

				arg_322_1.text_.text = var_325_20

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_21 = 8
				local var_325_22 = utf8.len(var_325_20)
				local var_325_23 = var_325_21 <= 0 and var_325_17 or var_325_17 * (var_325_22 / var_325_21)

				if var_325_23 > 0 and var_325_17 < var_325_23 then
					arg_322_1.talkMaxDuration = var_325_23

					if var_325_23 + var_325_16 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_23 + var_325_16
					end
				end

				arg_322_1.text_.text = var_325_20
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241074", "story_v_out_417241.awb") ~= 0 then
					local var_325_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241074", "story_v_out_417241.awb") / 1000

					if var_325_24 + var_325_16 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_24 + var_325_16
					end

					if var_325_19.prefab_name ~= "" and arg_322_1.actors_[var_325_19.prefab_name] ~= nil then
						local var_325_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_19.prefab_name].transform, "story_v_out_417241", "417241074", "story_v_out_417241.awb")

						arg_322_1:RecordAudio("417241074", var_325_25)
						arg_322_1:RecordAudio("417241074", var_325_25)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417241", "417241074", "story_v_out_417241.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417241", "417241074", "story_v_out_417241.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_26 = math.max(var_325_17, arg_322_1.talkMaxDuration)

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_26 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_16) / var_325_26

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_16 + var_325_26 and arg_322_1.time_ < var_325_16 + var_325_26 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417241075 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417241075
		arg_326_1.duration_ = 7.87

		local var_326_0 = {
			zh = 5.966,
			ja = 7.866
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
				arg_326_0:Play417241076(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10128"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10128 == nil then
				arg_326_1.var_.actorSpriteComps10128 = var_329_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.actorSpriteComps10128 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								local var_329_4 = Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, var_329_3)
								local var_329_5 = Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, var_329_3)
								local var_329_6 = Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, var_329_3)

								iter_329_1.color = Color.New(var_329_4, var_329_5, var_329_6)
							else
								local var_329_7 = Mathf.Lerp(iter_329_1.color.r, 1, var_329_3)

								iter_329_1.color = Color.New(var_329_7, var_329_7, var_329_7)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10128 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_329_3 then
						if arg_326_1.isInRecall_ then
							iter_329_3.color = arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_329_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps10128 = nil
			end

			local var_329_8 = arg_326_1.actors_["10115"]
			local var_329_9 = 0

			if var_329_9 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 and not isNil(var_329_8) and arg_326_1.var_.actorSpriteComps10115 == nil then
				arg_326_1.var_.actorSpriteComps10115 = var_329_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_10 = 0.2

			if var_329_9 <= arg_326_1.time_ and arg_326_1.time_ < var_329_9 + var_329_10 and not isNil(var_329_8) then
				local var_329_11 = (arg_326_1.time_ - var_329_9) / var_329_10

				if arg_326_1.var_.actorSpriteComps10115 then
					for iter_329_4, iter_329_5 in pairs(arg_326_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_329_5 then
							if arg_326_1.isInRecall_ then
								local var_329_12 = Mathf.Lerp(iter_329_5.color.r, arg_326_1.hightColor2.r, var_329_11)
								local var_329_13 = Mathf.Lerp(iter_329_5.color.g, arg_326_1.hightColor2.g, var_329_11)
								local var_329_14 = Mathf.Lerp(iter_329_5.color.b, arg_326_1.hightColor2.b, var_329_11)

								iter_329_5.color = Color.New(var_329_12, var_329_13, var_329_14)
							else
								local var_329_15 = Mathf.Lerp(iter_329_5.color.r, 0.5, var_329_11)

								iter_329_5.color = Color.New(var_329_15, var_329_15, var_329_15)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_9 + var_329_10 and arg_326_1.time_ < var_329_9 + var_329_10 + arg_329_0 and not isNil(var_329_8) and arg_326_1.var_.actorSpriteComps10115 then
				for iter_329_6, iter_329_7 in pairs(arg_326_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_329_7 then
						if arg_326_1.isInRecall_ then
							iter_329_7.color = arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_329_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps10115 = nil
			end

			local var_329_16 = 0
			local var_329_17 = 0.625

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_18 = arg_326_1:FormatText(StoryNameCfg[595].name)

				arg_326_1.leftNameTxt_.text = var_329_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_19 = arg_326_1:GetWordFromCfg(417241075)
				local var_329_20 = arg_326_1:FormatText(var_329_19.content)

				arg_326_1.text_.text = var_329_20

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_21 = 25
				local var_329_22 = utf8.len(var_329_20)
				local var_329_23 = var_329_21 <= 0 and var_329_17 or var_329_17 * (var_329_22 / var_329_21)

				if var_329_23 > 0 and var_329_17 < var_329_23 then
					arg_326_1.talkMaxDuration = var_329_23

					if var_329_23 + var_329_16 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_23 + var_329_16
					end
				end

				arg_326_1.text_.text = var_329_20
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241075", "story_v_out_417241.awb") ~= 0 then
					local var_329_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241075", "story_v_out_417241.awb") / 1000

					if var_329_24 + var_329_16 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_24 + var_329_16
					end

					if var_329_19.prefab_name ~= "" and arg_326_1.actors_[var_329_19.prefab_name] ~= nil then
						local var_329_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_19.prefab_name].transform, "story_v_out_417241", "417241075", "story_v_out_417241.awb")

						arg_326_1:RecordAudio("417241075", var_329_25)
						arg_326_1:RecordAudio("417241075", var_329_25)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417241", "417241075", "story_v_out_417241.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417241", "417241075", "story_v_out_417241.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_26 = math.max(var_329_17, arg_326_1.talkMaxDuration)

			if var_329_16 <= arg_326_1.time_ and arg_326_1.time_ < var_329_16 + var_329_26 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_16) / var_329_26

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_16 + var_329_26 and arg_326_1.time_ < var_329_16 + var_329_26 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417241076 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417241076
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417241077(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10128"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10128 == nil then
				arg_330_1.var_.actorSpriteComps10128 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps10128 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor2.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor2.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor2.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 0.5, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10128 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_333_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps10128 = nil
			end

			local var_333_8 = arg_330_1.actors_["10115"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos10115 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10115", 7)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "" or not string.find(var_333_11.name, "split") then
						var_333_11.gameObject:SetActive(true)
					else
						var_333_11.gameObject:SetActive(false)
					end
				end
			end

			local var_333_12 = 0.001

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(0, -2000, 0)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10115, var_333_14, var_333_13)
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_333_15 = arg_330_1.actors_["10128"].transform
			local var_333_16 = 0

			if var_333_16 < arg_330_1.time_ and arg_330_1.time_ <= var_333_16 + arg_333_0 then
				arg_330_1.var_.moveOldPos10128 = var_333_15.localPosition
				var_333_15.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10128", 7)

				local var_333_17 = var_333_15.childCount

				for iter_333_5 = 0, var_333_17 - 1 do
					local var_333_18 = var_333_15:GetChild(iter_333_5)

					if var_333_18.name == "" or not string.find(var_333_18.name, "split") then
						var_333_18.gameObject:SetActive(true)
					else
						var_333_18.gameObject:SetActive(false)
					end
				end
			end

			local var_333_19 = 0.001

			if var_333_16 <= arg_330_1.time_ and arg_330_1.time_ < var_333_16 + var_333_19 then
				local var_333_20 = (arg_330_1.time_ - var_333_16) / var_333_19
				local var_333_21 = Vector3.New(0, -2000, -300)

				var_333_15.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10128, var_333_21, var_333_20)
			end

			if arg_330_1.time_ >= var_333_16 + var_333_19 and arg_330_1.time_ < var_333_16 + var_333_19 + arg_333_0 then
				var_333_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_333_22 = 1
			local var_333_23 = 1

			if var_333_22 < arg_330_1.time_ and arg_330_1.time_ <= var_333_22 + arg_333_0 then
				local var_333_24 = "play"
				local var_333_25 = "effect"

				arg_330_1:AudioAction(var_333_24, var_333_25, "se_story_1311", "se_story_1311_ui", "")
			end

			local var_333_26 = 0
			local var_333_27 = 1.3

			if var_333_26 < arg_330_1.time_ and arg_330_1.time_ <= var_333_26 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_28 = arg_330_1:GetWordFromCfg(417241076)
				local var_333_29 = arg_330_1:FormatText(var_333_28.content)

				arg_330_1.text_.text = var_333_29

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_30 = 52
				local var_333_31 = utf8.len(var_333_29)
				local var_333_32 = var_333_30 <= 0 and var_333_27 or var_333_27 * (var_333_31 / var_333_30)

				if var_333_32 > 0 and var_333_27 < var_333_32 then
					arg_330_1.talkMaxDuration = var_333_32

					if var_333_32 + var_333_26 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_32 + var_333_26
					end
				end

				arg_330_1.text_.text = var_333_29
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_33 = math.max(var_333_27, arg_330_1.talkMaxDuration)

			if var_333_26 <= arg_330_1.time_ and arg_330_1.time_ < var_333_26 + var_333_33 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_26) / var_333_33

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_26 + var_333_33 and arg_330_1.time_ < var_333_26 + var_333_33 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play417241077 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417241077
		arg_334_1.duration_ = 4.83

		local var_334_0 = {
			zh = 2.7,
			ja = 4.833
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417241078(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.35

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[1110].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(417241077)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 14
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241077", "story_v_out_417241.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241077", "story_v_out_417241.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_417241", "417241077", "story_v_out_417241.awb")

						arg_334_1:RecordAudio("417241077", var_337_9)
						arg_334_1:RecordAudio("417241077", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417241", "417241077", "story_v_out_417241.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417241", "417241077", "story_v_out_417241.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417241078 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417241078
		arg_338_1.duration_ = 9

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417241079(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 3.999999999999

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			local var_341_1 = 0.3

			if arg_338_1.time_ >= var_341_0 + var_341_1 and arg_338_1.time_ < var_341_0 + var_341_1 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end

			local var_341_2 = 2

			if var_341_2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				local var_341_3 = manager.ui.mainCamera.transform.localPosition
				local var_341_4 = Vector3.New(0, 0, 10) + Vector3.New(var_341_3.x, var_341_3.y, 0)
				local var_341_5 = arg_338_1.bgs_.ST73

				var_341_5.transform.localPosition = var_341_4
				var_341_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_6 = var_341_5:GetComponent("SpriteRenderer")

				if var_341_6 and var_341_6.sprite then
					local var_341_7 = (var_341_5.transform.localPosition - var_341_3).z
					local var_341_8 = manager.ui.mainCameraCom_
					local var_341_9 = 2 * var_341_7 * Mathf.Tan(var_341_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_341_10 = var_341_9 * var_341_8.aspect
					local var_341_11 = var_341_6.sprite.bounds.size.x
					local var_341_12 = var_341_6.sprite.bounds.size.y
					local var_341_13 = var_341_10 / var_341_11
					local var_341_14 = var_341_9 / var_341_12
					local var_341_15 = var_341_14 < var_341_13 and var_341_13 or var_341_14

					var_341_5.transform.localScale = Vector3.New(var_341_15, var_341_15, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "ST73" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_17 = 2

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_17 then
				local var_341_18 = (arg_338_1.time_ - var_341_16) / var_341_17
				local var_341_19 = Color.New(0, 0, 0)

				var_341_19.a = Mathf.Lerp(0, 1, var_341_18)
				arg_338_1.mask_.color = var_341_19
			end

			if arg_338_1.time_ >= var_341_16 + var_341_17 and arg_338_1.time_ < var_341_16 + var_341_17 + arg_341_0 then
				local var_341_20 = Color.New(0, 0, 0)

				var_341_20.a = 1
				arg_338_1.mask_.color = var_341_20
			end

			local var_341_21 = 2

			if var_341_21 < arg_338_1.time_ and arg_338_1.time_ <= var_341_21 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_22 = 2

			if var_341_21 <= arg_338_1.time_ and arg_338_1.time_ < var_341_21 + var_341_22 then
				local var_341_23 = (arg_338_1.time_ - var_341_21) / var_341_22
				local var_341_24 = Color.New(0, 0, 0)

				var_341_24.a = Mathf.Lerp(1, 0, var_341_23)
				arg_338_1.mask_.color = var_341_24
			end

			if arg_338_1.time_ >= var_341_21 + var_341_22 and arg_338_1.time_ < var_341_21 + var_341_22 + arg_341_0 then
				local var_341_25 = Color.New(0, 0, 0)
				local var_341_26 = 0

				arg_338_1.mask_.enabled = false
				var_341_25.a = var_341_26
				arg_338_1.mask_.color = var_341_25
			end

			local var_341_27 = 0.9
			local var_341_28 = 1

			if var_341_27 < arg_338_1.time_ and arg_338_1.time_ <= var_341_27 + arg_341_0 then
				local var_341_29 = "stop"
				local var_341_30 = "effect"

				arg_338_1:AudioAction(var_341_29, var_341_30, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_341_31 = 1.63333333333333
			local var_341_32 = 1

			if var_341_31 < arg_338_1.time_ and arg_338_1.time_ <= var_341_31 + arg_341_0 then
				local var_341_33 = "play"
				local var_341_34 = "effect"

				arg_338_1:AudioAction(var_341_33, var_341_34, "se_story_1311", "se_story_1311_riot", "")
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_35 = 3.999999999999
			local var_341_36 = 1.6

			if var_341_35 < arg_338_1.time_ and arg_338_1.time_ <= var_341_35 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_37 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_37:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_338_1.dialogCg_.alpha = arg_342_0
				end))
				var_341_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_38 = arg_338_1:GetWordFromCfg(417241078)
				local var_341_39 = arg_338_1:FormatText(var_341_38.content)

				arg_338_1.text_.text = var_341_39

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_40 = 64
				local var_341_41 = utf8.len(var_341_39)
				local var_341_42 = var_341_40 <= 0 and var_341_36 or var_341_36 * (var_341_41 / var_341_40)

				if var_341_42 > 0 and var_341_36 < var_341_42 then
					arg_338_1.talkMaxDuration = var_341_42
					var_341_35 = var_341_35 + 0.3

					if var_341_42 + var_341_35 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_42 + var_341_35
					end
				end

				arg_338_1.text_.text = var_341_39
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_43 = var_341_35 + 0.3
			local var_341_44 = math.max(var_341_36, arg_338_1.talkMaxDuration)

			if var_341_43 <= arg_338_1.time_ and arg_338_1.time_ < var_341_43 + var_341_44 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_43) / var_341_44

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_43 + var_341_44 and arg_338_1.time_ < var_341_43 + var_341_44 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417241079 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 417241079
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play417241080(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.02
			local var_347_1 = 1

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				local var_347_2 = "play"
				local var_347_3 = "effect"

				arg_344_1:AudioAction(var_347_2, var_347_3, "se_story_1311", "se_story_1311_beetle03", "")
			end

			local var_347_4 = 0
			local var_347_5 = 1.4

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_6 = arg_344_1:GetWordFromCfg(417241079)
				local var_347_7 = arg_344_1:FormatText(var_347_6.content)

				arg_344_1.text_.text = var_347_7

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_8 = 56
				local var_347_9 = utf8.len(var_347_7)
				local var_347_10 = var_347_8 <= 0 and var_347_5 or var_347_5 * (var_347_9 / var_347_8)

				if var_347_10 > 0 and var_347_5 < var_347_10 then
					arg_344_1.talkMaxDuration = var_347_10

					if var_347_10 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_4
					end
				end

				arg_344_1.text_.text = var_347_7
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_11 = math.max(var_347_5, arg_344_1.talkMaxDuration)

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_11 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_4) / var_347_11

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_4 + var_347_11 and arg_344_1.time_ < var_347_4 + var_347_11 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play417241080 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 417241080
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play417241081(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.375
			local var_351_1 = 1

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				local var_351_2 = "play"
				local var_351_3 = "effect"

				arg_348_1:AudioAction(var_351_2, var_351_3, "se_story_1311", "se_story_1311_upload", "")
			end

			local var_351_4 = 0
			local var_351_5 = 0.375

			if var_351_4 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_6 = arg_348_1:GetWordFromCfg(417241080)
				local var_351_7 = arg_348_1:FormatText(var_351_6.content)

				arg_348_1.text_.text = var_351_7

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_8 = 15
				local var_351_9 = utf8.len(var_351_7)
				local var_351_10 = var_351_8 <= 0 and var_351_5 or var_351_5 * (var_351_9 / var_351_8)

				if var_351_10 > 0 and var_351_5 < var_351_10 then
					arg_348_1.talkMaxDuration = var_351_10

					if var_351_10 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_7
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_11 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_11 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_11

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_11 and arg_348_1.time_ < var_351_4 + var_351_11 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play417241081 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 417241081
		arg_352_1.duration_ = 7

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play417241082(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 1

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				local var_355_1 = manager.ui.mainCamera.transform.localPosition
				local var_355_2 = Vector3.New(0, 0, 10) + Vector3.New(var_355_1.x, var_355_1.y, 0)
				local var_355_3 = arg_352_1.bgs_.I17f

				var_355_3.transform.localPosition = var_355_2
				var_355_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_355_4 = var_355_3:GetComponent("SpriteRenderer")

				if var_355_4 and var_355_4.sprite then
					local var_355_5 = (var_355_3.transform.localPosition - var_355_1).z
					local var_355_6 = manager.ui.mainCameraCom_
					local var_355_7 = 2 * var_355_5 * Mathf.Tan(var_355_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_355_8 = var_355_7 * var_355_6.aspect
					local var_355_9 = var_355_4.sprite.bounds.size.x
					local var_355_10 = var_355_4.sprite.bounds.size.y
					local var_355_11 = var_355_8 / var_355_9
					local var_355_12 = var_355_7 / var_355_10
					local var_355_13 = var_355_12 < var_355_11 and var_355_11 or var_355_12

					var_355_3.transform.localScale = Vector3.New(var_355_13, var_355_13, 0)
				end

				for iter_355_0, iter_355_1 in pairs(arg_352_1.bgs_) do
					if iter_355_0 ~= "I17f" then
						iter_355_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_355_14 = 0

			if var_355_14 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_15 = 1

			if var_355_14 <= arg_352_1.time_ and arg_352_1.time_ < var_355_14 + var_355_15 then
				local var_355_16 = (arg_352_1.time_ - var_355_14) / var_355_15
				local var_355_17 = Color.New(0, 0, 0)

				var_355_17.a = Mathf.Lerp(0, 1, var_355_16)
				arg_352_1.mask_.color = var_355_17
			end

			if arg_352_1.time_ >= var_355_14 + var_355_15 and arg_352_1.time_ < var_355_14 + var_355_15 + arg_355_0 then
				local var_355_18 = Color.New(0, 0, 0)

				var_355_18.a = 1
				arg_352_1.mask_.color = var_355_18
			end

			local var_355_19 = 1

			if var_355_19 < arg_352_1.time_ and arg_352_1.time_ <= var_355_19 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_20 = 1

			if var_355_19 <= arg_352_1.time_ and arg_352_1.time_ < var_355_19 + var_355_20 then
				local var_355_21 = (arg_352_1.time_ - var_355_19) / var_355_20
				local var_355_22 = Color.New(0, 0, 0)

				var_355_22.a = Mathf.Lerp(1, 0, var_355_21)
				arg_352_1.mask_.color = var_355_22
			end

			if arg_352_1.time_ >= var_355_19 + var_355_20 and arg_352_1.time_ < var_355_19 + var_355_20 + arg_355_0 then
				local var_355_23 = Color.New(0, 0, 0)
				local var_355_24 = 0

				arg_352_1.mask_.enabled = false
				var_355_23.a = var_355_24
				arg_352_1.mask_.color = var_355_23
			end

			local var_355_25 = 2
			local var_355_26 = 1

			if var_355_25 < arg_352_1.time_ and arg_352_1.time_ <= var_355_25 + arg_355_0 then
				local var_355_27 = "play"
				local var_355_28 = "effect"

				arg_352_1:AudioAction(var_355_27, var_355_28, "se_story_11", "se_story_11_microphone", "")
			end

			local var_355_29 = 0.02
			local var_355_30 = 1

			if var_355_29 < arg_352_1.time_ and arg_352_1.time_ <= var_355_29 + arg_355_0 then
				local var_355_31 = "stop"
				local var_355_32 = "effect"

				arg_352_1:AudioAction(var_355_31, var_355_32, "se_story_1311", "se_story_1311_riot", "")
			end

			local var_355_33 = 0.833333333333333
			local var_355_34 = 1

			if var_355_33 < arg_352_1.time_ and arg_352_1.time_ <= var_355_33 + arg_355_0 then
				local var_355_35 = "play"
				local var_355_36 = "effect"

				arg_352_1:AudioAction(var_355_35, var_355_36, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_352_1.frameCnt_ <= 1 then
				arg_352_1.dialog_:SetActive(false)
			end

			local var_355_37 = 2
			local var_355_38 = 0.05

			if var_355_37 < arg_352_1.time_ and arg_352_1.time_ <= var_355_37 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0

				arg_352_1.dialog_:SetActive(true)

				arg_352_1.dialogCg_.alpha = 0

				local var_355_39 = LeanTween.value(arg_352_1.dialog_, 0, 1, 0.3)

				var_355_39:setOnUpdate(LuaHelper.FloatAction(function(arg_356_0)
					arg_352_1.dialogCg_.alpha = arg_356_0
				end))
				var_355_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_352_1.dialog_)
					var_355_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_352_1.duration_ = arg_352_1.duration_ + 0.3

				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_40 = arg_352_1:FormatText(StoryNameCfg[672].name)

				arg_352_1.leftNameTxt_.text = var_355_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_41 = arg_352_1:GetWordFromCfg(417241081)
				local var_355_42 = arg_352_1:FormatText(var_355_41.content)

				arg_352_1.text_.text = var_355_42

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_43 = 2
				local var_355_44 = utf8.len(var_355_42)
				local var_355_45 = var_355_43 <= 0 and var_355_38 or var_355_38 * (var_355_44 / var_355_43)

				if var_355_45 > 0 and var_355_38 < var_355_45 then
					arg_352_1.talkMaxDuration = var_355_45
					var_355_37 = var_355_37 + 0.3

					if var_355_45 + var_355_37 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_45 + var_355_37
					end
				end

				arg_352_1.text_.text = var_355_42
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_46 = var_355_37 + 0.3
			local var_355_47 = math.max(var_355_38, arg_352_1.talkMaxDuration)

			if var_355_46 <= arg_352_1.time_ and arg_352_1.time_ < var_355_46 + var_355_47 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_46) / var_355_47

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_46 + var_355_47 and arg_352_1.time_ < var_355_46 + var_355_47 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play417241082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417241082
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417241083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.525

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_2 = arg_358_1:GetWordFromCfg(417241082)
				local var_361_3 = arg_358_1:FormatText(var_361_2.content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 61
				local var_361_5 = utf8.len(var_361_3)
				local var_361_6 = var_361_4 <= 0 and var_361_1 or var_361_1 * (var_361_5 / var_361_4)

				if var_361_6 > 0 and var_361_1 < var_361_6 then
					arg_358_1.talkMaxDuration = var_361_6

					if var_361_6 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_6 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_7 and arg_358_1.time_ < var_361_0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417241083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417241083
		arg_362_1.duration_ = 1.87

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417241084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.fswbg_:SetActive(true)
				arg_362_1.dialog_:SetActive(false)

				arg_362_1.fswtw_.percent = 0

				local var_365_1 = arg_362_1:GetWordFromCfg(417241083)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.fswt_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.fswt_)

				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_362_1.fswtw_:SetDirty()

				arg_362_1.typewritterCharCountI18N = 0

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_3 = 0.0999999999999999

			if var_365_3 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.var_.oldValueTypewriter = arg_362_1.fswtw_.percent

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_4 = 9
			local var_365_5 = 0.6
			local var_365_6 = arg_362_1:GetWordFromCfg(417241083)
			local var_365_7 = arg_362_1:FormatText(var_365_6.content)
			local var_365_8, var_365_9 = arg_362_1:GetPercentByPara(var_365_7, 1)

			if var_365_3 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				local var_365_10 = var_365_4 <= 0 and var_365_5 or var_365_5 * ((var_365_9 - arg_362_1.typewritterCharCountI18N) / var_365_4)

				if var_365_10 > 0 and var_365_5 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_3 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_3
					end
				end
			end

			local var_365_11 = 0.6
			local var_365_12 = math.max(var_365_11, arg_362_1.talkMaxDuration)

			if var_365_3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_3 + var_365_12 then
				local var_365_13 = (arg_362_1.time_ - var_365_3) / var_365_12

				arg_362_1.fswtw_.percent = Mathf.Lerp(arg_362_1.var_.oldValueTypewriter, var_365_8, var_365_13)
				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_362_1.fswtw_:SetDirty()
			end

			if arg_362_1.time_ >= var_365_3 + var_365_12 and arg_362_1.time_ < var_365_3 + var_365_12 + arg_365_0 then
				arg_362_1.fswtw_.percent = var_365_8

				arg_362_1.fswtw_:SetDirty()
				arg_362_1:ShowNextGo(true)

				arg_362_1.typewritterCharCountI18N = var_365_9
			end

			local var_365_14 = 0

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				local var_365_15 = arg_362_1.fswbg_.transform:Find("textbox/adapt/content") or arg_362_1.fswbg_.transform:Find("textbox/content")
				local var_365_16 = arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_365_17 = var_365_15:GetComponent("Text")
				local var_365_18 = var_365_15:GetComponent("RectTransform")

				var_365_17.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_365_18.offsetMin = Vector2.New(0, 0)
				var_365_18.offsetMax = Vector2.New(0, 0)
			end

			local var_365_19 = 0.0999999999999999
			local var_365_20 = 1.766
			local var_365_21 = manager.audio:GetVoiceLength("story_v_out_417241", "417241083", "story_v_out_417241.awb") / 1000

			if var_365_21 > 0 and var_365_20 < var_365_21 and var_365_21 + var_365_19 > arg_362_1.duration_ then
				local var_365_22 = var_365_21

				arg_362_1.duration_ = var_365_21 + var_365_19
			end

			if var_365_19 < arg_362_1.time_ and arg_362_1.time_ <= var_365_19 + arg_365_0 then
				local var_365_23 = "play"
				local var_365_24 = "voice"

				arg_362_1:AudioAction(var_365_23, var_365_24, "story_v_out_417241", "417241083", "story_v_out_417241.awb")
			end

			local var_365_25 = arg_362_1.actors_["10831"]
			local var_365_26 = 0

			if var_365_26 < arg_362_1.time_ and arg_362_1.time_ <= var_365_26 + arg_365_0 then
				local var_365_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_27 then
					var_365_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_27.radialBlurScale = 0
					var_365_27.radialBlurGradient = 1
					var_365_27.radialBlurIntensity = 1

					if var_365_25 then
						var_365_27.radialBlurTarget = var_365_25.transform
					end
				end
			end

			local var_365_28 = 1

			if var_365_26 <= arg_362_1.time_ and arg_362_1.time_ < var_365_26 + var_365_28 then
				local var_365_29 = (arg_362_1.time_ - var_365_26) / var_365_28
				local var_365_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_30 then
					var_365_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_30.radialBlurScale = Mathf.Lerp(0, 0, var_365_29)
					var_365_30.radialBlurGradient = Mathf.Lerp(1, 1, var_365_29)
					var_365_30.radialBlurIntensity = Mathf.Lerp(1, 1, var_365_29)
				end
			end

			if arg_362_1.time_ >= var_365_26 + var_365_28 and arg_362_1.time_ < var_365_26 + var_365_28 + arg_365_0 then
				local var_365_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_31 then
					var_365_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_31.radialBlurScale = 0
					var_365_31.radialBlurGradient = 1
					var_365_31.radialBlurIntensity = 1
				end
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417241084 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417241084
		arg_366_1.duration_ = 9.1

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417241085(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.var_.oldValueTypewriter = arg_366_1.fswtw_.percent

				SetActive(arg_366_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_366_1:ShowNextGo(false)
			end

			local var_369_1 = 31
			local var_369_2 = 2.06666666666667
			local var_369_3 = arg_366_1:GetWordFromCfg(417241083)
			local var_369_4 = arg_366_1:FormatText(var_369_3.content)
			local var_369_5, var_369_6 = arg_366_1:GetPercentByPara(var_369_4, 2)

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0

				local var_369_7 = var_369_1 <= 0 and var_369_2 or var_369_2 * ((var_369_6 - arg_366_1.typewritterCharCountI18N) / var_369_1)

				if var_369_7 > 0 and var_369_2 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_0
					end
				end
			end

			local var_369_8 = 2.06666666666667
			local var_369_9 = math.max(var_369_8, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_9 then
				local var_369_10 = (arg_366_1.time_ - var_369_0) / var_369_9

				arg_366_1.fswtw_.percent = Mathf.Lerp(arg_366_1.var_.oldValueTypewriter, var_369_5, var_369_10)
				arg_366_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_366_1.fswtw_:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_9 and arg_366_1.time_ < var_369_0 + var_369_9 + arg_369_0 then
				arg_366_1.fswtw_.percent = var_369_5

				arg_366_1.fswtw_:SetDirty()
				arg_366_1:ShowNextGo(true)

				arg_366_1.typewritterCharCountI18N = var_369_6
			end

			local var_369_11 = 0
			local var_369_12 = 9.1
			local var_369_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241084", "story_v_out_417241.awb") / 1000

			if var_369_13 > 0 and var_369_12 < var_369_13 and var_369_13 + var_369_11 > arg_366_1.duration_ then
				local var_369_14 = var_369_13

				arg_366_1.duration_ = var_369_13 + var_369_11
			end

			if var_369_11 < arg_366_1.time_ and arg_366_1.time_ <= var_369_11 + arg_369_0 then
				local var_369_15 = "play"
				local var_369_16 = "voice"

				arg_366_1:AudioAction(var_369_15, var_369_16, "story_v_out_417241", "417241084", "story_v_out_417241.awb")
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play417241085 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417241085
		arg_370_1.duration_ = 3.47

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417241086(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.var_.oldValueTypewriter = arg_370_1.fswtw_.percent

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_1 = 12
			local var_373_2 = 0.8
			local var_373_3 = arg_370_1:GetWordFromCfg(417241083)
			local var_373_4 = arg_370_1:FormatText(var_373_3.content)
			local var_373_5, var_373_6 = arg_370_1:GetPercentByPara(var_373_4, 3)

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				local var_373_7 = var_373_1 <= 0 and var_373_2 or var_373_2 * ((var_373_6 - arg_370_1.typewritterCharCountI18N) / var_373_1)

				if var_373_7 > 0 and var_373_2 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end
			end

			local var_373_8 = 0.8
			local var_373_9 = math.max(var_373_8, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_9 then
				local var_373_10 = (arg_370_1.time_ - var_373_0) / var_373_9

				arg_370_1.fswtw_.percent = Mathf.Lerp(arg_370_1.var_.oldValueTypewriter, var_373_5, var_373_10)
				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_370_1.fswtw_:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_9 and arg_370_1.time_ < var_373_0 + var_373_9 + arg_373_0 then
				arg_370_1.fswtw_.percent = var_373_5

				arg_370_1.fswtw_:SetDirty()
				arg_370_1:ShowNextGo(true)

				arg_370_1.typewritterCharCountI18N = var_373_6
			end

			local var_373_11 = 0
			local var_373_12 = 1.3
			local var_373_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241085", "story_v_out_417241.awb") / 1000

			if var_373_13 > 0 and var_373_12 < var_373_13 and var_373_13 + var_373_11 > arg_370_1.duration_ then
				local var_373_14 = var_373_13

				arg_370_1.duration_ = var_373_13 + var_373_11
			end

			if var_373_11 < arg_370_1.time_ and arg_370_1.time_ <= var_373_11 + arg_373_0 then
				local var_373_15 = "play"
				local var_373_16 = "voice"

				arg_370_1:AudioAction(var_373_15, var_373_16, "story_v_out_417241", "417241085", "story_v_out_417241.awb")
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play417241086 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417241086
		arg_374_1.duration_ = 12.83

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417241087(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.var_.oldValueTypewriter = arg_374_1.fswtw_.percent

				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_374_1:ShowNextGo(false)
			end

			local var_377_1 = 47
			local var_377_2 = 3.13333333333333
			local var_377_3 = arg_374_1:GetWordFromCfg(417241083)
			local var_377_4 = arg_374_1:FormatText(var_377_3.content)
			local var_377_5, var_377_6 = arg_374_1:GetPercentByPara(var_377_4, 4)

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				local var_377_7 = var_377_1 <= 0 and var_377_2 or var_377_2 * ((var_377_6 - arg_374_1.typewritterCharCountI18N) / var_377_1)

				if var_377_7 > 0 and var_377_2 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end
			end

			local var_377_8 = 3.13333333333333
			local var_377_9 = math.max(var_377_8, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_9 then
				local var_377_10 = (arg_374_1.time_ - var_377_0) / var_377_9

				arg_374_1.fswtw_.percent = Mathf.Lerp(arg_374_1.var_.oldValueTypewriter, var_377_5, var_377_10)
				arg_374_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_374_1.fswtw_:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_9 and arg_374_1.time_ < var_377_0 + var_377_9 + arg_377_0 then
				arg_374_1.fswtw_.percent = var_377_5

				arg_374_1.fswtw_:SetDirty()
				arg_374_1:ShowNextGo(true)

				arg_374_1.typewritterCharCountI18N = var_377_6
			end

			local var_377_11 = 0
			local var_377_12 = 12.833

			if var_377_11 < arg_374_1.time_ and arg_374_1.time_ <= var_377_11 + arg_377_0 then
				local var_377_13 = "play"
				local var_377_14 = "music"

				arg_374_1:AudioAction(var_377_13, var_377_14, "story_v_out_417241", "417241086", "story_v_out_417241.awb")

				local var_377_15 = ""
				local var_377_16 = manager.audio:GetAudioName("story_v_out_417241", "417241086")

				if var_377_16 ~= "" then
					if arg_374_1.bgmTxt_.text ~= var_377_16 and arg_374_1.bgmTxt_.text ~= "" then
						if arg_374_1.bgmTxt2_.text ~= "" then
							arg_374_1.bgmTxt_.text = arg_374_1.bgmTxt2_.text
						end

						arg_374_1.bgmTxt2_.text = var_377_16

						arg_374_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_374_1.bgmTxt_.text = var_377_16
						arg_374_1.bgmTxt2_.text = var_377_16
					end

					if arg_374_1.bgmTimer then
						arg_374_1.bgmTimer:Stop()

						arg_374_1.bgmTimer = nil
					end

					if arg_374_1.settingData.show_music_name == 1 then
						arg_374_1.musicController:SetSelectedState("show")
						arg_374_1.musicAnimator_:Play("open", 0, 0)

						if arg_374_1.settingData.music_time ~= 0 then
							arg_374_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_374_1.settingData.music_time), function()
								if arg_374_1 == nil or isNil(arg_374_1.bgmTxt_) then
									return
								end

								arg_374_1.musicController:SetSelectedState("hide")
								arg_374_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play417241087 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 417241087
		arg_379_1.duration_ = 2.17

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play417241088(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.var_.oldValueTypewriter = arg_379_1.fswtw_.percent

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_1 = 0
			local var_382_2 = 0.8
			local var_382_3 = arg_379_1:GetWordFromCfg(417241083)
			local var_382_4 = arg_379_1:FormatText(var_382_3.content)
			local var_382_5, var_382_6 = arg_379_1:GetPercentByPara(var_382_4, 4)

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				local var_382_7 = var_382_1 <= 0 and var_382_2 or var_382_2 * ((var_382_6 - arg_379_1.typewritterCharCountI18N) / var_382_1)

				if var_382_7 > 0 and var_382_2 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end
			end

			local var_382_8 = 0.8
			local var_382_9 = math.max(var_382_8, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_9 then
				local var_382_10 = (arg_379_1.time_ - var_382_0) / var_382_9

				arg_379_1.fswtw_.percent = Mathf.Lerp(arg_379_1.var_.oldValueTypewriter, var_382_5, var_382_10)
				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_379_1.fswtw_:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_9 and arg_379_1.time_ < var_382_0 + var_382_9 + arg_382_0 then
				arg_379_1.fswtw_.percent = var_382_5

				arg_379_1.fswtw_:SetDirty()
				arg_379_1:ShowNextGo(true)

				arg_379_1.typewritterCharCountI18N = var_382_6
			end

			local var_382_11 = 0
			local var_382_12 = 2.166
			local var_382_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241087", "story_v_out_417241.awb") / 1000

			if var_382_13 > 0 and var_382_12 < var_382_13 and var_382_13 + var_382_11 > arg_379_1.duration_ then
				local var_382_14 = var_382_13

				arg_379_1.duration_ = var_382_13 + var_382_11
			end

			if var_382_11 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				local var_382_15 = "play"
				local var_382_16 = "voice"

				arg_379_1:AudioAction(var_382_15, var_382_16, "story_v_out_417241", "417241087", "story_v_out_417241.awb")
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play417241088 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 417241088
		arg_383_1.duration_ = 3.2

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play417241089(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.var_.oldValueTypewriter = arg_383_1.fswtw_.percent

				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_1 = 27
			local var_386_2 = 1.8
			local var_386_3 = arg_383_1:GetWordFromCfg(417241083)
			local var_386_4 = arg_383_1:FormatText(var_386_3.content)
			local var_386_5, var_386_6 = arg_383_1:GetPercentByPara(var_386_4, 5)

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				local var_386_7 = var_386_1 <= 0 and var_386_2 or var_386_2 * ((var_386_6 - arg_383_1.typewritterCharCountI18N) / var_386_1)

				if var_386_7 > 0 and var_386_2 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end
			end

			local var_386_8 = 1.8
			local var_386_9 = math.max(var_386_8, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_9 then
				local var_386_10 = (arg_383_1.time_ - var_386_0) / var_386_9

				arg_383_1.fswtw_.percent = Mathf.Lerp(arg_383_1.var_.oldValueTypewriter, var_386_5, var_386_10)
				arg_383_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_383_1.fswtw_:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_9 and arg_383_1.time_ < var_386_0 + var_386_9 + arg_386_0 then
				arg_383_1.fswtw_.percent = var_386_5

				arg_383_1.fswtw_:SetDirty()
				arg_383_1:ShowNextGo(true)

				arg_383_1.typewritterCharCountI18N = var_386_6
			end

			local var_386_11 = 0
			local var_386_12 = 3.2
			local var_386_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241088", "story_v_out_417241.awb") / 1000

			if var_386_13 > 0 and var_386_12 < var_386_13 and var_386_13 + var_386_11 > arg_383_1.duration_ then
				local var_386_14 = var_386_13

				arg_383_1.duration_ = var_386_13 + var_386_11
			end

			if var_386_11 < arg_383_1.time_ and arg_383_1.time_ <= var_386_11 + arg_386_0 then
				local var_386_15 = "play"
				local var_386_16 = "voice"

				arg_383_1:AudioAction(var_386_15, var_386_16, "story_v_out_417241", "417241088", "story_v_out_417241.awb")
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play417241089 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 417241089
		arg_387_1.duration_ = 15.17

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play417241090(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.var_.oldValueTypewriter = arg_387_1.fswtw_.percent

				SetActive(arg_387_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_387_1:ShowNextGo(false)
			end

			local var_390_1 = 48
			local var_390_2 = 3.2
			local var_390_3 = arg_387_1:GetWordFromCfg(417241083)
			local var_390_4 = arg_387_1:FormatText(var_390_3.content)
			local var_390_5, var_390_6 = arg_387_1:GetPercentByPara(var_390_4, 6)

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				local var_390_7 = var_390_1 <= 0 and var_390_2 or var_390_2 * ((var_390_6 - arg_387_1.typewritterCharCountI18N) / var_390_1)

				if var_390_7 > 0 and var_390_2 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end
			end

			local var_390_8 = 3.2
			local var_390_9 = math.max(var_390_8, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_9 then
				local var_390_10 = (arg_387_1.time_ - var_390_0) / var_390_9

				arg_387_1.fswtw_.percent = Mathf.Lerp(arg_387_1.var_.oldValueTypewriter, var_390_5, var_390_10)
				arg_387_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_387_1.fswtw_:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_9 and arg_387_1.time_ < var_390_0 + var_390_9 + arg_390_0 then
				arg_387_1.fswtw_.percent = var_390_5

				arg_387_1.fswtw_:SetDirty()
				arg_387_1:ShowNextGo(true)

				arg_387_1.typewritterCharCountI18N = var_390_6
			end

			local var_390_11 = 0
			local var_390_12 = 15.166
			local var_390_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241089", "story_v_out_417241.awb") / 1000

			if var_390_13 > 0 and var_390_12 < var_390_13 and var_390_13 + var_390_11 > arg_387_1.duration_ then
				local var_390_14 = var_390_13

				arg_387_1.duration_ = var_390_13 + var_390_11
			end

			if var_390_11 < arg_387_1.time_ and arg_387_1.time_ <= var_390_11 + arg_390_0 then
				local var_390_15 = "play"
				local var_390_16 = "voice"

				arg_387_1:AudioAction(var_390_15, var_390_16, "story_v_out_417241", "417241089", "story_v_out_417241.awb")
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play417241090 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 417241090
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play417241091(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.fswbg_:SetActive(false)
				arg_391_1.dialog_:SetActive(false)
				SetActive(arg_391_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_391_1:ShowNextGo(false)
			end

			local var_394_1 = arg_391_1.actors_["10831"]
			local var_394_2 = 0

			if var_394_2 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				local var_394_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_3 then
					var_394_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_3.radialBlurScale = 0
					var_394_3.radialBlurGradient = 1
					var_394_3.radialBlurIntensity = 1

					if var_394_1 then
						var_394_3.radialBlurTarget = var_394_1.transform
					end
				end
			end

			local var_394_4 = 0.0166666666666667

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_4 then
				local var_394_5 = (arg_391_1.time_ - var_394_2) / var_394_4
				local var_394_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_6 then
					var_394_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_6.radialBlurScale = Mathf.Lerp(0, 0, var_394_5)
					var_394_6.radialBlurGradient = Mathf.Lerp(1, 1, var_394_5)
					var_394_6.radialBlurIntensity = Mathf.Lerp(1, 1, var_394_5)
				end
			end

			if arg_391_1.time_ >= var_394_2 + var_394_4 and arg_391_1.time_ < var_394_2 + var_394_4 + arg_394_0 then
				local var_394_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_7 then
					var_394_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_7.radialBlurScale = 0
					var_394_7.radialBlurGradient = 1
					var_394_7.radialBlurIntensity = 1
				end
			end

			local var_394_8 = 0
			local var_394_9 = 1.15

			if var_394_8 < arg_391_1.time_ and arg_391_1.time_ <= var_394_8 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_10 = arg_391_1:GetWordFromCfg(417241090)
				local var_394_11 = arg_391_1:FormatText(var_394_10.content)

				arg_391_1.text_.text = var_394_11

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_12 = 46
				local var_394_13 = utf8.len(var_394_11)
				local var_394_14 = var_394_12 <= 0 and var_394_9 or var_394_9 * (var_394_13 / var_394_12)

				if var_394_14 > 0 and var_394_9 < var_394_14 then
					arg_391_1.talkMaxDuration = var_394_14

					if var_394_14 + var_394_8 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_8
					end
				end

				arg_391_1.text_.text = var_394_11
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_15 = math.max(var_394_9, arg_391_1.talkMaxDuration)

			if var_394_8 <= arg_391_1.time_ and arg_391_1.time_ < var_394_8 + var_394_15 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_8) / var_394_15

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_8 + var_394_15 and arg_391_1.time_ < var_394_8 + var_394_15 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play417241091 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 417241091
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play417241092(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.65

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_2 = arg_395_1:GetWordFromCfg(417241091)
				local var_398_3 = arg_395_1:FormatText(var_398_2.content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 26
				local var_398_5 = utf8.len(var_398_3)
				local var_398_6 = var_398_4 <= 0 and var_398_1 or var_398_1 * (var_398_5 / var_398_4)

				if var_398_6 > 0 and var_398_1 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_7 and arg_395_1.time_ < var_398_0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play417241092 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 417241092
		arg_399_1.duration_ = 5.67

		local var_399_0 = {
			zh = 2.6,
			ja = 5.666
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play417241093(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["10115"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps10115 == nil then
				arg_399_1.var_.actorSpriteComps10115 = var_402_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.actorSpriteComps10115 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								local var_402_4 = Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, var_402_3)
								local var_402_5 = Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, var_402_3)
								local var_402_6 = Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, var_402_3)

								iter_402_1.color = Color.New(var_402_4, var_402_5, var_402_6)
							else
								local var_402_7 = Mathf.Lerp(iter_402_1.color.r, 1, var_402_3)

								iter_402_1.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps10115 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_402_3 then
						if arg_399_1.isInRecall_ then
							iter_402_3.color = arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_402_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps10115 = nil
			end

			local var_402_8 = arg_399_1.actors_["10115"].transform
			local var_402_9 = 0

			if var_402_9 < arg_399_1.time_ and arg_399_1.time_ <= var_402_9 + arg_402_0 then
				arg_399_1.var_.moveOldPos10115 = var_402_8.localPosition
				var_402_8.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("10115", 3)

				local var_402_10 = var_402_8.childCount

				for iter_402_4 = 0, var_402_10 - 1 do
					local var_402_11 = var_402_8:GetChild(iter_402_4)

					if var_402_11.name == "" or not string.find(var_402_11.name, "split") then
						var_402_11.gameObject:SetActive(true)
					else
						var_402_11.gameObject:SetActive(false)
					end
				end
			end

			local var_402_12 = 0.001

			if var_402_9 <= arg_399_1.time_ and arg_399_1.time_ < var_402_9 + var_402_12 then
				local var_402_13 = (arg_399_1.time_ - var_402_9) / var_402_12
				local var_402_14 = Vector3.New(0, -387.3, -246.2)

				var_402_8.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos10115, var_402_14, var_402_13)
			end

			if arg_399_1.time_ >= var_402_9 + var_402_12 and arg_399_1.time_ < var_402_9 + var_402_12 + arg_402_0 then
				var_402_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_402_15 = 0
			local var_402_16 = 0.3

			if var_402_15 < arg_399_1.time_ and arg_399_1.time_ <= var_402_15 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_17 = arg_399_1:FormatText(StoryNameCfg[1113].name)

				arg_399_1.leftNameTxt_.text = var_402_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_18 = arg_399_1:GetWordFromCfg(417241092)
				local var_402_19 = arg_399_1:FormatText(var_402_18.content)

				arg_399_1.text_.text = var_402_19

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_20 = 12
				local var_402_21 = utf8.len(var_402_19)
				local var_402_22 = var_402_20 <= 0 and var_402_16 or var_402_16 * (var_402_21 / var_402_20)

				if var_402_22 > 0 and var_402_16 < var_402_22 then
					arg_399_1.talkMaxDuration = var_402_22

					if var_402_22 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_22 + var_402_15
					end
				end

				arg_399_1.text_.text = var_402_19
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241092", "story_v_out_417241.awb") ~= 0 then
					local var_402_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241092", "story_v_out_417241.awb") / 1000

					if var_402_23 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_23 + var_402_15
					end

					if var_402_18.prefab_name ~= "" and arg_399_1.actors_[var_402_18.prefab_name] ~= nil then
						local var_402_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_18.prefab_name].transform, "story_v_out_417241", "417241092", "story_v_out_417241.awb")

						arg_399_1:RecordAudio("417241092", var_402_24)
						arg_399_1:RecordAudio("417241092", var_402_24)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_417241", "417241092", "story_v_out_417241.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_417241", "417241092", "story_v_out_417241.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_25 = math.max(var_402_16, arg_399_1.talkMaxDuration)

			if var_402_15 <= arg_399_1.time_ and arg_399_1.time_ < var_402_15 + var_402_25 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_15) / var_402_25

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_15 + var_402_25 and arg_399_1.time_ < var_402_15 + var_402_25 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
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

		arg_399_1:InitPlayNodeList()
	end,
	Play417241093 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 417241093
		arg_403_1.duration_ = 5.9

		local var_403_0 = {
			zh = 2.866,
			ja = 5.9
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play417241094(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10128"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10128 == nil then
				arg_403_1.var_.actorSpriteComps10128 = var_406_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_2 = 0.2

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.actorSpriteComps10128 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								local var_406_4 = Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, var_406_3)
								local var_406_5 = Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, var_406_3)
								local var_406_6 = Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, var_406_3)

								iter_406_1.color = Color.New(var_406_4, var_406_5, var_406_6)
							else
								local var_406_7 = Mathf.Lerp(iter_406_1.color.r, 1, var_406_3)

								iter_406_1.color = Color.New(var_406_7, var_406_7, var_406_7)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10128 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_406_3 then
						if arg_403_1.isInRecall_ then
							iter_406_3.color = arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_406_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10128 = nil
			end

			local var_406_8 = arg_403_1.actors_["10115"]
			local var_406_9 = 0

			if var_406_9 < arg_403_1.time_ and arg_403_1.time_ <= var_406_9 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps10115 == nil then
				arg_403_1.var_.actorSpriteComps10115 = var_406_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_10 = 0.2

			if var_406_9 <= arg_403_1.time_ and arg_403_1.time_ < var_406_9 + var_406_10 and not isNil(var_406_8) then
				local var_406_11 = (arg_403_1.time_ - var_406_9) / var_406_10

				if arg_403_1.var_.actorSpriteComps10115 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_406_5 then
							if arg_403_1.isInRecall_ then
								local var_406_12 = Mathf.Lerp(iter_406_5.color.r, arg_403_1.hightColor2.r, var_406_11)
								local var_406_13 = Mathf.Lerp(iter_406_5.color.g, arg_403_1.hightColor2.g, var_406_11)
								local var_406_14 = Mathf.Lerp(iter_406_5.color.b, arg_403_1.hightColor2.b, var_406_11)

								iter_406_5.color = Color.New(var_406_12, var_406_13, var_406_14)
							else
								local var_406_15 = Mathf.Lerp(iter_406_5.color.r, 0.5, var_406_11)

								iter_406_5.color = Color.New(var_406_15, var_406_15, var_406_15)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_9 + var_406_10 and arg_403_1.time_ < var_406_9 + var_406_10 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps10115 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_406_7 then
						if arg_403_1.isInRecall_ then
							iter_406_7.color = arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_406_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10115 = nil
			end

			local var_406_16 = arg_403_1.actors_["10115"].transform
			local var_406_17 = 0

			if var_406_17 < arg_403_1.time_ and arg_403_1.time_ <= var_406_17 + arg_406_0 then
				arg_403_1.var_.moveOldPos10115 = var_406_16.localPosition
				var_406_16.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10115", 2)

				local var_406_18 = var_406_16.childCount

				for iter_406_8 = 0, var_406_18 - 1 do
					local var_406_19 = var_406_16:GetChild(iter_406_8)

					if var_406_19.name == "" or not string.find(var_406_19.name, "split") then
						var_406_19.gameObject:SetActive(true)
					else
						var_406_19.gameObject:SetActive(false)
					end
				end
			end

			local var_406_20 = 0.001

			if var_406_17 <= arg_403_1.time_ and arg_403_1.time_ < var_406_17 + var_406_20 then
				local var_406_21 = (arg_403_1.time_ - var_406_17) / var_406_20
				local var_406_22 = Vector3.New(-390, -387.3, -246.2)

				var_406_16.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10115, var_406_22, var_406_21)
			end

			if arg_403_1.time_ >= var_406_17 + var_406_20 and arg_403_1.time_ < var_406_17 + var_406_20 + arg_406_0 then
				var_406_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_406_23 = arg_403_1.actors_["10128"].transform
			local var_406_24 = 0

			if var_406_24 < arg_403_1.time_ and arg_403_1.time_ <= var_406_24 + arg_406_0 then
				arg_403_1.var_.moveOldPos10128 = var_406_23.localPosition
				var_406_23.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10128", 4)

				local var_406_25 = var_406_23.childCount

				for iter_406_9 = 0, var_406_25 - 1 do
					local var_406_26 = var_406_23:GetChild(iter_406_9)

					if var_406_26.name == "" or not string.find(var_406_26.name, "split") then
						var_406_26.gameObject:SetActive(true)
					else
						var_406_26.gameObject:SetActive(false)
					end
				end
			end

			local var_406_27 = 0.001

			if var_406_24 <= arg_403_1.time_ and arg_403_1.time_ < var_406_24 + var_406_27 then
				local var_406_28 = (arg_403_1.time_ - var_406_24) / var_406_27
				local var_406_29 = Vector3.New(390, -347, -300)

				var_406_23.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10128, var_406_29, var_406_28)
			end

			if arg_403_1.time_ >= var_406_24 + var_406_27 and arg_403_1.time_ < var_406_24 + var_406_27 + arg_406_0 then
				var_406_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_406_30 = 0
			local var_406_31 = 0.4

			if var_406_30 < arg_403_1.time_ and arg_403_1.time_ <= var_406_30 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_32 = arg_403_1:FormatText(StoryNameCfg[595].name)

				arg_403_1.leftNameTxt_.text = var_406_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_33 = arg_403_1:GetWordFromCfg(417241093)
				local var_406_34 = arg_403_1:FormatText(var_406_33.content)

				arg_403_1.text_.text = var_406_34

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_35 = 16
				local var_406_36 = utf8.len(var_406_34)
				local var_406_37 = var_406_35 <= 0 and var_406_31 or var_406_31 * (var_406_36 / var_406_35)

				if var_406_37 > 0 and var_406_31 < var_406_37 then
					arg_403_1.talkMaxDuration = var_406_37

					if var_406_37 + var_406_30 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_37 + var_406_30
					end
				end

				arg_403_1.text_.text = var_406_34
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241093", "story_v_out_417241.awb") ~= 0 then
					local var_406_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241093", "story_v_out_417241.awb") / 1000

					if var_406_38 + var_406_30 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_38 + var_406_30
					end

					if var_406_33.prefab_name ~= "" and arg_403_1.actors_[var_406_33.prefab_name] ~= nil then
						local var_406_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_33.prefab_name].transform, "story_v_out_417241", "417241093", "story_v_out_417241.awb")

						arg_403_1:RecordAudio("417241093", var_406_39)
						arg_403_1:RecordAudio("417241093", var_406_39)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_417241", "417241093", "story_v_out_417241.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_417241", "417241093", "story_v_out_417241.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_40 = math.max(var_406_31, arg_403_1.talkMaxDuration)

			if var_406_30 <= arg_403_1.time_ and arg_403_1.time_ < var_406_30 + var_406_40 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_30) / var_406_40

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_30 + var_406_40 and arg_403_1.time_ < var_406_30 + var_406_40 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play417241094 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 417241094
		arg_407_1.duration_ = 1.93

		local var_407_0 = {
			zh = 1.9,
			ja = 1.933
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play417241095(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 0.225

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[595].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:GetWordFromCfg(417241094)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 9
				local var_410_6 = utf8.len(var_410_4)
				local var_410_7 = var_410_5 <= 0 and var_410_1 or var_410_1 * (var_410_6 / var_410_5)

				if var_410_7 > 0 and var_410_1 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241094", "story_v_out_417241.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241094", "story_v_out_417241.awb") / 1000

					if var_410_8 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_0
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_out_417241", "417241094", "story_v_out_417241.awb")

						arg_407_1:RecordAudio("417241094", var_410_9)
						arg_407_1:RecordAudio("417241094", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_417241", "417241094", "story_v_out_417241.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_417241", "417241094", "story_v_out_417241.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_10 and arg_407_1.time_ < var_410_0 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play417241095 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 417241095
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play417241096(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10115"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos10115 = var_414_0.localPosition
				var_414_0.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10115", 7)

				local var_414_2 = var_414_0.childCount

				for iter_414_0 = 0, var_414_2 - 1 do
					local var_414_3 = var_414_0:GetChild(iter_414_0)

					if var_414_3.name == "" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_4 then
				local var_414_5 = (arg_411_1.time_ - var_414_1) / var_414_4
				local var_414_6 = Vector3.New(0, -2000, 0)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10115, var_414_6, var_414_5)
			end

			if arg_411_1.time_ >= var_414_1 + var_414_4 and arg_411_1.time_ < var_414_1 + var_414_4 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_414_7 = arg_411_1.actors_["10128"].transform
			local var_414_8 = 0

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.var_.moveOldPos10128 = var_414_7.localPosition
				var_414_7.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10128", 7)

				local var_414_9 = var_414_7.childCount

				for iter_414_1 = 0, var_414_9 - 1 do
					local var_414_10 = var_414_7:GetChild(iter_414_1)

					if var_414_10.name == "" or not string.find(var_414_10.name, "split") then
						var_414_10.gameObject:SetActive(true)
					else
						var_414_10.gameObject:SetActive(false)
					end
				end
			end

			local var_414_11 = 0.001

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_11 then
				local var_414_12 = (arg_411_1.time_ - var_414_8) / var_414_11
				local var_414_13 = Vector3.New(0, -2000, -300)

				var_414_7.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10128, var_414_13, var_414_12)
			end

			if arg_411_1.time_ >= var_414_8 + var_414_11 and arg_411_1.time_ < var_414_8 + var_414_11 + arg_414_0 then
				var_414_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_414_14 = 0
			local var_414_15 = 0.4

			if var_414_14 < arg_411_1.time_ and arg_411_1.time_ <= var_414_14 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_16 = arg_411_1:GetWordFromCfg(417241095)
				local var_414_17 = arg_411_1:FormatText(var_414_16.content)

				arg_411_1.text_.text = var_414_17

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_18 = 16
				local var_414_19 = utf8.len(var_414_17)
				local var_414_20 = var_414_18 <= 0 and var_414_15 or var_414_15 * (var_414_19 / var_414_18)

				if var_414_20 > 0 and var_414_15 < var_414_20 then
					arg_411_1.talkMaxDuration = var_414_20

					if var_414_20 + var_414_14 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_20 + var_414_14
					end
				end

				arg_411_1.text_.text = var_414_17
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_21 = math.max(var_414_15, arg_411_1.talkMaxDuration)

			if var_414_14 <= arg_411_1.time_ and arg_411_1.time_ < var_414_14 + var_414_21 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_14) / var_414_21

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_14 + var_414_21 and arg_411_1.time_ < var_414_14 + var_414_21 + arg_414_0 then
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

		arg_411_1:InitPlayNodeList()
	end,
	Play417241096 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 417241096
		arg_415_1.duration_ = 7.1

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play417241097(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.fswbg_:SetActive(true)
				arg_415_1.dialog_:SetActive(false)

				arg_415_1.fswtw_.percent = 0

				local var_418_1 = arg_415_1:GetWordFromCfg(417241096)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.fswt_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.fswt_)

				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_415_1.fswtw_:SetDirty()

				arg_415_1.typewritterCharCountI18N = 0

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_3 = 0.0999999999999999

			if var_418_3 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_4 = 37
			local var_418_5 = 2.46666666666667
			local var_418_6 = arg_415_1:GetWordFromCfg(417241096)
			local var_418_7 = arg_415_1:FormatText(var_418_6.content)
			local var_418_8, var_418_9 = arg_415_1:GetPercentByPara(var_418_7, 1)

			if var_418_3 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_10 = var_418_4 <= 0 and var_418_5 or var_418_5 * ((var_418_9 - arg_415_1.typewritterCharCountI18N) / var_418_4)

				if var_418_10 > 0 and var_418_5 < var_418_10 then
					arg_415_1.talkMaxDuration = var_418_10

					if var_418_10 + var_418_3 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_3
					end
				end
			end

			local var_418_11 = 2.46666666666667
			local var_418_12 = math.max(var_418_11, arg_415_1.talkMaxDuration)

			if var_418_3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_3 + var_418_12 then
				local var_418_13 = (arg_415_1.time_ - var_418_3) / var_418_12

				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_8, var_418_13)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_3 + var_418_12 and arg_415_1.time_ < var_418_3 + var_418_12 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_8

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_9
			end

			local var_418_14 = 0

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				local var_418_15 = arg_415_1.fswbg_.transform:Find("textbox/adapt/content") or arg_415_1.fswbg_.transform:Find("textbox/content")
				local var_418_16 = arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_418_17 = var_418_15:GetComponent("Text")
				local var_418_18 = var_418_15:GetComponent("RectTransform")

				var_418_17.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_418_18.offsetMin = Vector2.New(0, 0)
				var_418_18.offsetMax = Vector2.New(0, 0)
			end

			local var_418_19 = 0.0999999999999999
			local var_418_20 = 7
			local var_418_21 = manager.audio:GetVoiceLength("story_v_out_417241", "417241096", "story_v_out_417241.awb") / 1000

			if var_418_21 > 0 and var_418_20 < var_418_21 and var_418_21 + var_418_19 > arg_415_1.duration_ then
				local var_418_22 = var_418_21

				arg_415_1.duration_ = var_418_21 + var_418_19
			end

			if var_418_19 < arg_415_1.time_ and arg_415_1.time_ <= var_418_19 + arg_418_0 then
				local var_418_23 = "play"
				local var_418_24 = "voice"

				arg_415_1:AudioAction(var_418_23, var_418_24, "story_v_out_417241", "417241096", "story_v_out_417241.awb")
			end

			local var_418_25 = arg_415_1.actors_["10832"]
			local var_418_26 = 0

			if var_418_26 < arg_415_1.time_ and arg_415_1.time_ <= var_418_26 + arg_418_0 then
				local var_418_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_27 then
					var_418_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_27.radialBlurScale = 0
					var_418_27.radialBlurGradient = 1
					var_418_27.radialBlurIntensity = 1

					if var_418_25 then
						var_418_27.radialBlurTarget = var_418_25.transform
					end
				end
			end

			local var_418_28 = 0.0999999999999999

			if var_418_26 <= arg_415_1.time_ and arg_415_1.time_ < var_418_26 + var_418_28 then
				local var_418_29 = (arg_415_1.time_ - var_418_26) / var_418_28
				local var_418_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_30 then
					var_418_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_30.radialBlurScale = Mathf.Lerp(0, 0, var_418_29)
					var_418_30.radialBlurGradient = Mathf.Lerp(1, 1, var_418_29)
					var_418_30.radialBlurIntensity = Mathf.Lerp(1, 1, var_418_29)
				end
			end

			if arg_415_1.time_ >= var_418_26 + var_418_28 and arg_415_1.time_ < var_418_26 + var_418_28 + arg_418_0 then
				local var_418_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_31 then
					var_418_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_31.radialBlurScale = 0
					var_418_31.radialBlurGradient = 1
					var_418_31.radialBlurIntensity = 1
				end
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play417241097 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 417241097
		arg_419_1.duration_ = 3.3

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play417241098(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.var_.oldValueTypewriter = arg_419_1.fswtw_.percent

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_1 = 23
			local var_422_2 = 1.53333333333333
			local var_422_3 = arg_419_1:GetWordFromCfg(417241096)
			local var_422_4 = arg_419_1:FormatText(var_422_3.content)
			local var_422_5, var_422_6 = arg_419_1:GetPercentByPara(var_422_4, 2)

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				local var_422_7 = var_422_1 <= 0 and var_422_2 or var_422_2 * ((var_422_6 - arg_419_1.typewritterCharCountI18N) / var_422_1)

				if var_422_7 > 0 and var_422_2 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end
			end

			local var_422_8 = 1.53333333333333
			local var_422_9 = math.max(var_422_8, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_9 then
				local var_422_10 = (arg_419_1.time_ - var_422_0) / var_422_9

				arg_419_1.fswtw_.percent = Mathf.Lerp(arg_419_1.var_.oldValueTypewriter, var_422_5, var_422_10)
				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_419_1.fswtw_:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_9 and arg_419_1.time_ < var_422_0 + var_422_9 + arg_422_0 then
				arg_419_1.fswtw_.percent = var_422_5

				arg_419_1.fswtw_:SetDirty()
				arg_419_1:ShowNextGo(true)

				arg_419_1.typewritterCharCountI18N = var_422_6
			end

			local var_422_11 = 0
			local var_422_12 = 3.3
			local var_422_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241097", "story_v_out_417241.awb") / 1000

			if var_422_13 > 0 and var_422_12 < var_422_13 and var_422_13 + var_422_11 > arg_419_1.duration_ then
				local var_422_14 = var_422_13

				arg_419_1.duration_ = var_422_13 + var_422_11
			end

			if var_422_11 < arg_419_1.time_ and arg_419_1.time_ <= var_422_11 + arg_422_0 then
				local var_422_15 = "play"
				local var_422_16 = "voice"

				arg_419_1:AudioAction(var_422_15, var_422_16, "story_v_out_417241", "417241097", "story_v_out_417241.awb")
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play417241098 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 417241098
		arg_423_1.duration_ = 6.67

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play417241099(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.var_.oldValueTypewriter = arg_423_1.fswtw_.percent

				SetActive(arg_423_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_423_1:ShowNextGo(false)
			end

			local var_426_1 = 38
			local var_426_2 = 2.53333333333333
			local var_426_3 = arg_423_1:GetWordFromCfg(417241096)
			local var_426_4 = arg_423_1:FormatText(var_426_3.content)
			local var_426_5, var_426_6 = arg_423_1:GetPercentByPara(var_426_4, 3)

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				local var_426_7 = var_426_1 <= 0 and var_426_2 or var_426_2 * ((var_426_6 - arg_423_1.typewritterCharCountI18N) / var_426_1)

				if var_426_7 > 0 and var_426_2 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end
			end

			local var_426_8 = 2.53333333333333
			local var_426_9 = math.max(var_426_8, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_9 then
				local var_426_10 = (arg_423_1.time_ - var_426_0) / var_426_9

				arg_423_1.fswtw_.percent = Mathf.Lerp(arg_423_1.var_.oldValueTypewriter, var_426_5, var_426_10)
				arg_423_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_423_1.fswtw_:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_9 and arg_423_1.time_ < var_426_0 + var_426_9 + arg_426_0 then
				arg_423_1.fswtw_.percent = var_426_5

				arg_423_1.fswtw_:SetDirty()
				arg_423_1:ShowNextGo(true)

				arg_423_1.typewritterCharCountI18N = var_426_6
			end

			local var_426_11 = 0
			local var_426_12 = 6.666
			local var_426_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241098", "story_v_out_417241.awb") / 1000

			if var_426_13 > 0 and var_426_12 < var_426_13 and var_426_13 + var_426_11 > arg_423_1.duration_ then
				local var_426_14 = var_426_13

				arg_423_1.duration_ = var_426_13 + var_426_11
			end

			if var_426_11 < arg_423_1.time_ and arg_423_1.time_ <= var_426_11 + arg_426_0 then
				local var_426_15 = "play"
				local var_426_16 = "voice"

				arg_423_1:AudioAction(var_426_15, var_426_16, "story_v_out_417241", "417241098", "story_v_out_417241.awb")
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play417241099 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 417241099
		arg_427_1.duration_ = 4.93

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play417241100(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.var_.oldValueTypewriter = arg_427_1.fswtw_.percent

				SetActive(arg_427_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_427_1:ShowNextGo(false)
			end

			local var_430_1 = 31
			local var_430_2 = 2.06666666666667
			local var_430_3 = arg_427_1:GetWordFromCfg(417241096)
			local var_430_4 = arg_427_1:FormatText(var_430_3.content)
			local var_430_5, var_430_6 = arg_427_1:GetPercentByPara(var_430_4, 4)

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				local var_430_7 = var_430_1 <= 0 and var_430_2 or var_430_2 * ((var_430_6 - arg_427_1.typewritterCharCountI18N) / var_430_1)

				if var_430_7 > 0 and var_430_2 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end
			end

			local var_430_8 = 2.06666666666667
			local var_430_9 = math.max(var_430_8, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_9 then
				local var_430_10 = (arg_427_1.time_ - var_430_0) / var_430_9

				arg_427_1.fswtw_.percent = Mathf.Lerp(arg_427_1.var_.oldValueTypewriter, var_430_5, var_430_10)
				arg_427_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_427_1.fswtw_:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_9 and arg_427_1.time_ < var_430_0 + var_430_9 + arg_430_0 then
				arg_427_1.fswtw_.percent = var_430_5

				arg_427_1.fswtw_:SetDirty()
				arg_427_1:ShowNextGo(true)

				arg_427_1.typewritterCharCountI18N = var_430_6
			end

			local var_430_11 = 0
			local var_430_12 = 4.933
			local var_430_13 = manager.audio:GetVoiceLength("story_v_out_417241", "417241099", "story_v_out_417241.awb") / 1000

			if var_430_13 > 0 and var_430_12 < var_430_13 and var_430_13 + var_430_11 > arg_427_1.duration_ then
				local var_430_14 = var_430_13

				arg_427_1.duration_ = var_430_13 + var_430_11
			end

			if var_430_11 < arg_427_1.time_ and arg_427_1.time_ <= var_430_11 + arg_430_0 then
				local var_430_15 = "play"
				local var_430_16 = "voice"

				arg_427_1:AudioAction(var_430_15, var_430_16, "story_v_out_417241", "417241099", "story_v_out_417241.awb")
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play417241100 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 417241100
		arg_431_1.duration_ = 4.4

		local var_431_0 = {
			zh = 4.4,
			ja = 2.6
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play417241101(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["10128"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps10128 == nil then
				arg_431_1.var_.actorSpriteComps10128 = var_434_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.actorSpriteComps10128 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								local var_434_4 = Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor1.r, var_434_3)
								local var_434_5 = Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor1.g, var_434_3)
								local var_434_6 = Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor1.b, var_434_3)

								iter_434_1.color = Color.New(var_434_4, var_434_5, var_434_6)
							else
								local var_434_7 = Mathf.Lerp(iter_434_1.color.r, 1, var_434_3)

								iter_434_1.color = Color.New(var_434_7, var_434_7, var_434_7)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps10128 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_434_3 then
						if arg_431_1.isInRecall_ then
							iter_434_3.color = arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_434_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_431_1.var_.actorSpriteComps10128 = nil
			end

			local var_434_8 = arg_431_1.actors_["10128"].transform
			local var_434_9 = 0

			if var_434_9 < arg_431_1.time_ and arg_431_1.time_ <= var_434_9 + arg_434_0 then
				arg_431_1.var_.moveOldPos10128 = var_434_8.localPosition
				var_434_8.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10128", 3)

				local var_434_10 = var_434_8.childCount

				for iter_434_4 = 0, var_434_10 - 1 do
					local var_434_11 = var_434_8:GetChild(iter_434_4)

					if var_434_11.name == "" or not string.find(var_434_11.name, "split") then
						var_434_11.gameObject:SetActive(true)
					else
						var_434_11.gameObject:SetActive(false)
					end
				end
			end

			local var_434_12 = 0.001

			if var_434_9 <= arg_431_1.time_ and arg_431_1.time_ < var_434_9 + var_434_12 then
				local var_434_13 = (arg_431_1.time_ - var_434_9) / var_434_12
				local var_434_14 = Vector3.New(0, -347, -300)

				var_434_8.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10128, var_434_14, var_434_13)
			end

			if arg_431_1.time_ >= var_434_9 + var_434_12 and arg_431_1.time_ < var_434_9 + var_434_12 + arg_434_0 then
				var_434_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_434_15 = 0

			if var_434_15 < arg_431_1.time_ and arg_431_1.time_ <= var_434_15 + arg_434_0 then
				arg_431_1.fswbg_:SetActive(false)
				arg_431_1.dialog_:SetActive(false)
				SetActive(arg_431_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_431_1:ShowNextGo(false)
			end

			local var_434_16 = arg_431_1.actors_["10831"]
			local var_434_17 = 0

			if var_434_17 < arg_431_1.time_ and arg_431_1.time_ <= var_434_17 + arg_434_0 then
				local var_434_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_18 then
					var_434_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_18.radialBlurScale = 0
					var_434_18.radialBlurGradient = 1
					var_434_18.radialBlurIntensity = 1

					if var_434_16 then
						var_434_18.radialBlurTarget = var_434_16.transform
					end
				end
			end

			local var_434_19 = 0.0166666666666667

			if var_434_17 <= arg_431_1.time_ and arg_431_1.time_ < var_434_17 + var_434_19 then
				local var_434_20 = (arg_431_1.time_ - var_434_17) / var_434_19
				local var_434_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_21 then
					var_434_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_21.radialBlurScale = Mathf.Lerp(0, 0, var_434_20)
					var_434_21.radialBlurGradient = Mathf.Lerp(1, 1, var_434_20)
					var_434_21.radialBlurIntensity = Mathf.Lerp(1, 1, var_434_20)
				end
			end

			if arg_431_1.time_ >= var_434_17 + var_434_19 and arg_431_1.time_ < var_434_17 + var_434_19 + arg_434_0 then
				local var_434_22 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_22 then
					var_434_22.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_22.radialBlurScale = 0
					var_434_22.radialBlurGradient = 1
					var_434_22.radialBlurIntensity = 1
				end
			end

			local var_434_23 = 0
			local var_434_24 = 0.575

			if var_434_23 < arg_431_1.time_ and arg_431_1.time_ <= var_434_23 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_25 = arg_431_1:FormatText(StoryNameCfg[595].name)

				arg_431_1.leftNameTxt_.text = var_434_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_26 = arg_431_1:GetWordFromCfg(417241100)
				local var_434_27 = arg_431_1:FormatText(var_434_26.content)

				arg_431_1.text_.text = var_434_27

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_28 = 23
				local var_434_29 = utf8.len(var_434_27)
				local var_434_30 = var_434_28 <= 0 and var_434_24 or var_434_24 * (var_434_29 / var_434_28)

				if var_434_30 > 0 and var_434_24 < var_434_30 then
					arg_431_1.talkMaxDuration = var_434_30

					if var_434_30 + var_434_23 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_30 + var_434_23
					end
				end

				arg_431_1.text_.text = var_434_27
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241100", "story_v_out_417241.awb") ~= 0 then
					local var_434_31 = manager.audio:GetVoiceLength("story_v_out_417241", "417241100", "story_v_out_417241.awb") / 1000

					if var_434_31 + var_434_23 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_31 + var_434_23
					end

					if var_434_26.prefab_name ~= "" and arg_431_1.actors_[var_434_26.prefab_name] ~= nil then
						local var_434_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_26.prefab_name].transform, "story_v_out_417241", "417241100", "story_v_out_417241.awb")

						arg_431_1:RecordAudio("417241100", var_434_32)
						arg_431_1:RecordAudio("417241100", var_434_32)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_417241", "417241100", "story_v_out_417241.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_417241", "417241100", "story_v_out_417241.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_33 = math.max(var_434_24, arg_431_1.talkMaxDuration)

			if var_434_23 <= arg_431_1.time_ and arg_431_1.time_ < var_434_23 + var_434_33 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_23) / var_434_33

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_23 + var_434_33 and arg_431_1.time_ < var_434_23 + var_434_33 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
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

		arg_431_1:InitPlayNodeList()
	end,
	Play417241101 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 417241101
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play417241102(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["10128"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps10128 == nil then
				arg_435_1.var_.actorSpriteComps10128 = var_438_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.actorSpriteComps10128 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								local var_438_4 = Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor2.r, var_438_3)
								local var_438_5 = Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor2.g, var_438_3)
								local var_438_6 = Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor2.b, var_438_3)

								iter_438_1.color = Color.New(var_438_4, var_438_5, var_438_6)
							else
								local var_438_7 = Mathf.Lerp(iter_438_1.color.r, 0.5, var_438_3)

								iter_438_1.color = Color.New(var_438_7, var_438_7, var_438_7)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps10128 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_438_3 then
						if arg_435_1.isInRecall_ then
							iter_438_3.color = arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_438_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps10128 = nil
			end

			local var_438_8 = 0
			local var_438_9 = 1.45

			if var_438_8 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_10 = arg_435_1:GetWordFromCfg(417241101)
				local var_438_11 = arg_435_1:FormatText(var_438_10.content)

				arg_435_1.text_.text = var_438_11

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_12 = 58
				local var_438_13 = utf8.len(var_438_11)
				local var_438_14 = var_438_12 <= 0 and var_438_9 or var_438_9 * (var_438_13 / var_438_12)

				if var_438_14 > 0 and var_438_9 < var_438_14 then
					arg_435_1.talkMaxDuration = var_438_14

					if var_438_14 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_14 + var_438_8
					end
				end

				arg_435_1.text_.text = var_438_11
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_15 = math.max(var_438_9, arg_435_1.talkMaxDuration)

			if var_438_8 <= arg_435_1.time_ and arg_435_1.time_ < var_438_8 + var_438_15 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_8) / var_438_15

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_8 + var_438_15 and arg_435_1.time_ < var_438_8 + var_438_15 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play417241102 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 417241102
		arg_439_1.duration_ = 3.4

		local var_439_0 = {
			zh = 3.266,
			ja = 3.4
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play417241103(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["10128"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.actorSpriteComps10128 == nil then
				arg_439_1.var_.actorSpriteComps10128 = var_442_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_2 = 0.2

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.actorSpriteComps10128 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_442_1 then
							if arg_439_1.isInRecall_ then
								local var_442_4 = Mathf.Lerp(iter_442_1.color.r, arg_439_1.hightColor1.r, var_442_3)
								local var_442_5 = Mathf.Lerp(iter_442_1.color.g, arg_439_1.hightColor1.g, var_442_3)
								local var_442_6 = Mathf.Lerp(iter_442_1.color.b, arg_439_1.hightColor1.b, var_442_3)

								iter_442_1.color = Color.New(var_442_4, var_442_5, var_442_6)
							else
								local var_442_7 = Mathf.Lerp(iter_442_1.color.r, 1, var_442_3)

								iter_442_1.color = Color.New(var_442_7, var_442_7, var_442_7)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.actorSpriteComps10128 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_442_3 then
						if arg_439_1.isInRecall_ then
							iter_442_3.color = arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_442_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_439_1.var_.actorSpriteComps10128 = nil
			end

			local var_442_8 = 0
			local var_442_9 = 0.375

			if var_442_8 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_10 = arg_439_1:FormatText(StoryNameCfg[595].name)

				arg_439_1.leftNameTxt_.text = var_442_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_11 = arg_439_1:GetWordFromCfg(417241102)
				local var_442_12 = arg_439_1:FormatText(var_442_11.content)

				arg_439_1.text_.text = var_442_12

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_13 = 15
				local var_442_14 = utf8.len(var_442_12)
				local var_442_15 = var_442_13 <= 0 and var_442_9 or var_442_9 * (var_442_14 / var_442_13)

				if var_442_15 > 0 and var_442_9 < var_442_15 then
					arg_439_1.talkMaxDuration = var_442_15

					if var_442_15 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_15 + var_442_8
					end
				end

				arg_439_1.text_.text = var_442_12
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241102", "story_v_out_417241.awb") ~= 0 then
					local var_442_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241102", "story_v_out_417241.awb") / 1000

					if var_442_16 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_16 + var_442_8
					end

					if var_442_11.prefab_name ~= "" and arg_439_1.actors_[var_442_11.prefab_name] ~= nil then
						local var_442_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_11.prefab_name].transform, "story_v_out_417241", "417241102", "story_v_out_417241.awb")

						arg_439_1:RecordAudio("417241102", var_442_17)
						arg_439_1:RecordAudio("417241102", var_442_17)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_417241", "417241102", "story_v_out_417241.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_417241", "417241102", "story_v_out_417241.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_18 = math.max(var_442_9, arg_439_1.talkMaxDuration)

			if var_442_8 <= arg_439_1.time_ and arg_439_1.time_ < var_442_8 + var_442_18 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_8) / var_442_18

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_8 + var_442_18 and arg_439_1.time_ < var_442_8 + var_442_18 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play417241103 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 417241103
		arg_443_1.duration_ = 8.93

		local var_443_0 = {
			zh = 8.766,
			ja = 8.933
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play417241104(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 1.125

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[595].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:GetWordFromCfg(417241103)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 45
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241103", "story_v_out_417241.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241103", "story_v_out_417241.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_417241", "417241103", "story_v_out_417241.awb")

						arg_443_1:RecordAudio("417241103", var_446_9)
						arg_443_1:RecordAudio("417241103", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_417241", "417241103", "story_v_out_417241.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_417241", "417241103", "story_v_out_417241.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_10 and arg_443_1.time_ < var_446_0 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play417241104 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 417241104
		arg_447_1.duration_ = 6.97

		local var_447_0 = {
			zh = 5.666,
			ja = 6.966
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play417241105(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.625

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[595].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(417241104)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 25
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241104", "story_v_out_417241.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241104", "story_v_out_417241.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_417241", "417241104", "story_v_out_417241.awb")

						arg_447_1:RecordAudio("417241104", var_450_9)
						arg_447_1:RecordAudio("417241104", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_417241", "417241104", "story_v_out_417241.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_417241", "417241104", "story_v_out_417241.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play417241105 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 417241105
		arg_451_1.duration_ = 9.53

		local var_451_0 = {
			zh = 8.233,
			ja = 9.533
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play417241106(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[595].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_3 = arg_451_1:GetWordFromCfg(417241105)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 40
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241105", "story_v_out_417241.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241105", "story_v_out_417241.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_417241", "417241105", "story_v_out_417241.awb")

						arg_451_1:RecordAudio("417241105", var_454_9)
						arg_451_1:RecordAudio("417241105", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_417241", "417241105", "story_v_out_417241.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_417241", "417241105", "story_v_out_417241.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_10 and arg_451_1.time_ < var_454_0 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play417241106 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 417241106
		arg_455_1.duration_ = 16.83

		local var_455_0 = {
			zh = 13.466,
			ja = 16.833
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play417241107(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 1.675

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[595].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_3 = arg_455_1:GetWordFromCfg(417241106)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 67
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241106", "story_v_out_417241.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241106", "story_v_out_417241.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_417241", "417241106", "story_v_out_417241.awb")

						arg_455_1:RecordAudio("417241106", var_458_9)
						arg_455_1:RecordAudio("417241106", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_417241", "417241106", "story_v_out_417241.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_417241", "417241106", "story_v_out_417241.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play417241107 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 417241107
		arg_459_1.duration_ = 14.3

		local var_459_0 = {
			zh = 13.8,
			ja = 14.3
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play417241108(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 1.7

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[595].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:GetWordFromCfg(417241107)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 68
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241107", "story_v_out_417241.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241107", "story_v_out_417241.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_417241", "417241107", "story_v_out_417241.awb")

						arg_459_1:RecordAudio("417241107", var_462_9)
						arg_459_1:RecordAudio("417241107", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_417241", "417241107", "story_v_out_417241.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_417241", "417241107", "story_v_out_417241.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_10 and arg_459_1.time_ < var_462_0 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play417241108 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 417241108
		arg_463_1.duration_ = 8.9

		local var_463_0 = {
			zh = 8.9,
			ja = 8.633
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play417241109(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.9

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[595].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_3 = arg_463_1:GetWordFromCfg(417241108)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 36
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241108", "story_v_out_417241.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241108", "story_v_out_417241.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_417241", "417241108", "story_v_out_417241.awb")

						arg_463_1:RecordAudio("417241108", var_466_9)
						arg_463_1:RecordAudio("417241108", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_417241", "417241108", "story_v_out_417241.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_417241", "417241108", "story_v_out_417241.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_10 and arg_463_1.time_ < var_466_0 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play417241109 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 417241109
		arg_467_1.duration_ = 11.57

		local var_467_0 = {
			zh = 7.966,
			ja = 11.566
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play417241110(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 1.05

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[595].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_3 = arg_467_1:GetWordFromCfg(417241109)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 42
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241109", "story_v_out_417241.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241109", "story_v_out_417241.awb") / 1000

					if var_470_8 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_0
					end

					if var_470_3.prefab_name ~= "" and arg_467_1.actors_[var_470_3.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_3.prefab_name].transform, "story_v_out_417241", "417241109", "story_v_out_417241.awb")

						arg_467_1:RecordAudio("417241109", var_470_9)
						arg_467_1:RecordAudio("417241109", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_417241", "417241109", "story_v_out_417241.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_417241", "417241109", "story_v_out_417241.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_10 and arg_467_1.time_ < var_470_0 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play417241110 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 417241110
		arg_471_1.duration_ = 12.4

		local var_471_0 = {
			zh = 12.4,
			ja = 11.366
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play417241111(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 1.3

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_2 = arg_471_1:FormatText(StoryNameCfg[595].name)

				arg_471_1.leftNameTxt_.text = var_474_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:GetWordFromCfg(417241110)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 52
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_1 or var_474_1 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_1 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241110", "story_v_out_417241.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241110", "story_v_out_417241.awb") / 1000

					if var_474_8 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_0
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_out_417241", "417241110", "story_v_out_417241.awb")

						arg_471_1:RecordAudio("417241110", var_474_9)
						arg_471_1:RecordAudio("417241110", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_417241", "417241110", "story_v_out_417241.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_417241", "417241110", "story_v_out_417241.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_10 and arg_471_1.time_ < var_474_0 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play417241111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 417241111
		arg_475_1.duration_ = 7.53

		local var_475_0 = {
			zh = 4.766,
			ja = 7.533
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play417241112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.525

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[595].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_3 = arg_475_1:GetWordFromCfg(417241111)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 21
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241111", "story_v_out_417241.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241111", "story_v_out_417241.awb") / 1000

					if var_478_8 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_0
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_417241", "417241111", "story_v_out_417241.awb")

						arg_475_1:RecordAudio("417241111", var_478_9)
						arg_475_1:RecordAudio("417241111", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_417241", "417241111", "story_v_out_417241.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_417241", "417241111", "story_v_out_417241.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_10 and arg_475_1.time_ < var_478_0 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play417241112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 417241112
		arg_479_1.duration_ = 8.37

		local var_479_0 = {
			zh = 7.966,
			ja = 8.366
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play417241113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.8

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[595].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_3 = arg_479_1:GetWordFromCfg(417241112)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 32
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241112", "story_v_out_417241.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241112", "story_v_out_417241.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_417241", "417241112", "story_v_out_417241.awb")

						arg_479_1:RecordAudio("417241112", var_482_9)
						arg_479_1:RecordAudio("417241112", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_417241", "417241112", "story_v_out_417241.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_417241", "417241112", "story_v_out_417241.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play417241113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 417241113
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play417241114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["10128"].transform
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.var_.moveOldPos10128 = var_486_0.localPosition
				var_486_0.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10128", 7)

				local var_486_2 = var_486_0.childCount

				for iter_486_0 = 0, var_486_2 - 1 do
					local var_486_3 = var_486_0:GetChild(iter_486_0)

					if var_486_3.name == "" or not string.find(var_486_3.name, "split") then
						var_486_3.gameObject:SetActive(true)
					else
						var_486_3.gameObject:SetActive(false)
					end
				end
			end

			local var_486_4 = 0.001

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_4 then
				local var_486_5 = (arg_483_1.time_ - var_486_1) / var_486_4
				local var_486_6 = Vector3.New(0, -2000, -300)

				var_486_0.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10128, var_486_6, var_486_5)
			end

			if arg_483_1.time_ >= var_486_1 + var_486_4 and arg_483_1.time_ < var_486_1 + var_486_4 + arg_486_0 then
				var_486_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_486_7 = 0.2
			local var_486_8 = 1

			if var_486_7 < arg_483_1.time_ and arg_483_1.time_ <= var_486_7 + arg_486_0 then
				local var_486_9 = "play"
				local var_486_10 = "effect"

				arg_483_1:AudioAction(var_486_9, var_486_10, "se_story_1310", "se_story_1310_plane02", "")
			end

			local var_486_11 = 0
			local var_486_12 = 1.025

			if var_486_11 < arg_483_1.time_ and arg_483_1.time_ <= var_486_11 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_13 = arg_483_1:GetWordFromCfg(417241113)
				local var_486_14 = arg_483_1:FormatText(var_486_13.content)

				arg_483_1.text_.text = var_486_14

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_15 = 41
				local var_486_16 = utf8.len(var_486_14)
				local var_486_17 = var_486_15 <= 0 and var_486_12 or var_486_12 * (var_486_16 / var_486_15)

				if var_486_17 > 0 and var_486_12 < var_486_17 then
					arg_483_1.talkMaxDuration = var_486_17

					if var_486_17 + var_486_11 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_17 + var_486_11
					end
				end

				arg_483_1.text_.text = var_486_14
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_18 = math.max(var_486_12, arg_483_1.talkMaxDuration)

			if var_486_11 <= arg_483_1.time_ and arg_483_1.time_ < var_486_11 + var_486_18 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_11) / var_486_18

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_11 + var_486_18 and arg_483_1.time_ < var_486_11 + var_486_18 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
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

		arg_483_1:InitPlayNodeList()
	end,
	Play417241114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 417241114
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play417241115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 1.675

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_2 = arg_487_1:GetWordFromCfg(417241114)
				local var_490_3 = arg_487_1:FormatText(var_490_2.content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 67
				local var_490_5 = utf8.len(var_490_3)
				local var_490_6 = var_490_4 <= 0 and var_490_1 or var_490_1 * (var_490_5 / var_490_4)

				if var_490_6 > 0 and var_490_1 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_7 and arg_487_1.time_ < var_490_0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play417241115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 417241115
		arg_491_1.duration_ = 12.8

		local var_491_0 = {
			zh = 12.8,
			ja = 11.266
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play417241116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["10111"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps10111 == nil then
				arg_491_1.var_.actorSpriteComps10111 = var_494_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_2 = 0.2

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.actorSpriteComps10111 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								local var_494_4 = Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor1.r, var_494_3)
								local var_494_5 = Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor1.g, var_494_3)
								local var_494_6 = Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor1.b, var_494_3)

								iter_494_1.color = Color.New(var_494_4, var_494_5, var_494_6)
							else
								local var_494_7 = Mathf.Lerp(iter_494_1.color.r, 1, var_494_3)

								iter_494_1.color = Color.New(var_494_7, var_494_7, var_494_7)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps10111 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_494_3 then
						if arg_491_1.isInRecall_ then
							iter_494_3.color = arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_494_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps10111 = nil
			end

			local var_494_8 = arg_491_1.actors_["10111"].transform
			local var_494_9 = 0

			if var_494_9 < arg_491_1.time_ and arg_491_1.time_ <= var_494_9 + arg_494_0 then
				arg_491_1.var_.moveOldPos10111 = var_494_8.localPosition
				var_494_8.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10111", 3)

				local var_494_10 = var_494_8.childCount

				for iter_494_4 = 0, var_494_10 - 1 do
					local var_494_11 = var_494_8:GetChild(iter_494_4)

					if var_494_11.name == "split_6" or not string.find(var_494_11.name, "split") then
						var_494_11.gameObject:SetActive(true)
					else
						var_494_11.gameObject:SetActive(false)
					end
				end
			end

			local var_494_12 = 0.001

			if var_494_9 <= arg_491_1.time_ and arg_491_1.time_ < var_494_9 + var_494_12 then
				local var_494_13 = (arg_491_1.time_ - var_494_9) / var_494_12
				local var_494_14 = Vector3.New(0, -361.1, -274.6)

				var_494_8.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10111, var_494_14, var_494_13)
			end

			if arg_491_1.time_ >= var_494_9 + var_494_12 and arg_491_1.time_ < var_494_9 + var_494_12 + arg_494_0 then
				var_494_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_494_15 = 0
			local var_494_16 = 1.25

			if var_494_15 < arg_491_1.time_ and arg_491_1.time_ <= var_494_15 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_17 = arg_491_1:FormatText(StoryNameCfg[1125].name)

				arg_491_1.leftNameTxt_.text = var_494_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_18 = arg_491_1:GetWordFromCfg(417241115)
				local var_494_19 = arg_491_1:FormatText(var_494_18.content)

				arg_491_1.text_.text = var_494_19

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_20 = 50
				local var_494_21 = utf8.len(var_494_19)
				local var_494_22 = var_494_20 <= 0 and var_494_16 or var_494_16 * (var_494_21 / var_494_20)

				if var_494_22 > 0 and var_494_16 < var_494_22 then
					arg_491_1.talkMaxDuration = var_494_22

					if var_494_22 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_22 + var_494_15
					end
				end

				arg_491_1.text_.text = var_494_19
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241115", "story_v_out_417241.awb") ~= 0 then
					local var_494_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241115", "story_v_out_417241.awb") / 1000

					if var_494_23 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_23 + var_494_15
					end

					if var_494_18.prefab_name ~= "" and arg_491_1.actors_[var_494_18.prefab_name] ~= nil then
						local var_494_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_18.prefab_name].transform, "story_v_out_417241", "417241115", "story_v_out_417241.awb")

						arg_491_1:RecordAudio("417241115", var_494_24)
						arg_491_1:RecordAudio("417241115", var_494_24)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_417241", "417241115", "story_v_out_417241.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_417241", "417241115", "story_v_out_417241.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_25 = math.max(var_494_16, arg_491_1.talkMaxDuration)

			if var_494_15 <= arg_491_1.time_ and arg_491_1.time_ < var_494_15 + var_494_25 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_15) / var_494_25

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_15 + var_494_25 and arg_491_1.time_ < var_494_15 + var_494_25 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play417241116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 417241116
		arg_495_1.duration_ = 10.4

		local var_495_0 = {
			zh = 10.266,
			ja = 10.4
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play417241117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.95

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[1125].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(417241116)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 38
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241116", "story_v_out_417241.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241116", "story_v_out_417241.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_417241", "417241116", "story_v_out_417241.awb")

						arg_495_1:RecordAudio("417241116", var_498_9)
						arg_495_1:RecordAudio("417241116", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_417241", "417241116", "story_v_out_417241.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_417241", "417241116", "story_v_out_417241.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play417241117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 417241117
		arg_499_1.duration_ = 3.73

		local var_499_0 = {
			zh = 3.6,
			ja = 3.733
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play417241118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["10115"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps10115 == nil then
				arg_499_1.var_.actorSpriteComps10115 = var_502_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_2 = 0.2

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.actorSpriteComps10115 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								local var_502_4 = Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, var_502_3)
								local var_502_5 = Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, var_502_3)
								local var_502_6 = Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, var_502_3)

								iter_502_1.color = Color.New(var_502_4, var_502_5, var_502_6)
							else
								local var_502_7 = Mathf.Lerp(iter_502_1.color.r, 1, var_502_3)

								iter_502_1.color = Color.New(var_502_7, var_502_7, var_502_7)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps10115 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_502_3 then
						if arg_499_1.isInRecall_ then
							iter_502_3.color = arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_502_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps10115 = nil
			end

			local var_502_8 = arg_499_1.actors_["10111"]
			local var_502_9 = 0

			if var_502_9 < arg_499_1.time_ and arg_499_1.time_ <= var_502_9 + arg_502_0 and not isNil(var_502_8) and arg_499_1.var_.actorSpriteComps10111 == nil then
				arg_499_1.var_.actorSpriteComps10111 = var_502_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_10 = 0.2

			if var_502_9 <= arg_499_1.time_ and arg_499_1.time_ < var_502_9 + var_502_10 and not isNil(var_502_8) then
				local var_502_11 = (arg_499_1.time_ - var_502_9) / var_502_10

				if arg_499_1.var_.actorSpriteComps10111 then
					for iter_502_4, iter_502_5 in pairs(arg_499_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_502_5 then
							if arg_499_1.isInRecall_ then
								local var_502_12 = Mathf.Lerp(iter_502_5.color.r, arg_499_1.hightColor2.r, var_502_11)
								local var_502_13 = Mathf.Lerp(iter_502_5.color.g, arg_499_1.hightColor2.g, var_502_11)
								local var_502_14 = Mathf.Lerp(iter_502_5.color.b, arg_499_1.hightColor2.b, var_502_11)

								iter_502_5.color = Color.New(var_502_12, var_502_13, var_502_14)
							else
								local var_502_15 = Mathf.Lerp(iter_502_5.color.r, 0.5, var_502_11)

								iter_502_5.color = Color.New(var_502_15, var_502_15, var_502_15)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_9 + var_502_10 and arg_499_1.time_ < var_502_9 + var_502_10 + arg_502_0 and not isNil(var_502_8) and arg_499_1.var_.actorSpriteComps10111 then
				for iter_502_6, iter_502_7 in pairs(arg_499_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_502_7 then
						if arg_499_1.isInRecall_ then
							iter_502_7.color = arg_499_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_502_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps10111 = nil
			end

			local var_502_16 = arg_499_1.actors_["10111"].transform
			local var_502_17 = 0

			if var_502_17 < arg_499_1.time_ and arg_499_1.time_ <= var_502_17 + arg_502_0 then
				arg_499_1.var_.moveOldPos10111 = var_502_16.localPosition
				var_502_16.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10111", 2)

				local var_502_18 = var_502_16.childCount

				for iter_502_8 = 0, var_502_18 - 1 do
					local var_502_19 = var_502_16:GetChild(iter_502_8)

					if var_502_19.name == "" or not string.find(var_502_19.name, "split") then
						var_502_19.gameObject:SetActive(true)
					else
						var_502_19.gameObject:SetActive(false)
					end
				end
			end

			local var_502_20 = 0.001

			if var_502_17 <= arg_499_1.time_ and arg_499_1.time_ < var_502_17 + var_502_20 then
				local var_502_21 = (arg_499_1.time_ - var_502_17) / var_502_20
				local var_502_22 = Vector3.New(-390, -361.1, -274.6)

				var_502_16.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10111, var_502_22, var_502_21)
			end

			if arg_499_1.time_ >= var_502_17 + var_502_20 and arg_499_1.time_ < var_502_17 + var_502_20 + arg_502_0 then
				var_502_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_502_23 = arg_499_1.actors_["10115"].transform
			local var_502_24 = 0

			if var_502_24 < arg_499_1.time_ and arg_499_1.time_ <= var_502_24 + arg_502_0 then
				arg_499_1.var_.moveOldPos10115 = var_502_23.localPosition
				var_502_23.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10115", 4)

				local var_502_25 = var_502_23.childCount

				for iter_502_9 = 0, var_502_25 - 1 do
					local var_502_26 = var_502_23:GetChild(iter_502_9)

					if var_502_26.name == "" or not string.find(var_502_26.name, "split") then
						var_502_26.gameObject:SetActive(true)
					else
						var_502_26.gameObject:SetActive(false)
					end
				end
			end

			local var_502_27 = 0.001

			if var_502_24 <= arg_499_1.time_ and arg_499_1.time_ < var_502_24 + var_502_27 then
				local var_502_28 = (arg_499_1.time_ - var_502_24) / var_502_27
				local var_502_29 = Vector3.New(390, -387.3, -246.2)

				var_502_23.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10115, var_502_29, var_502_28)
			end

			if arg_499_1.time_ >= var_502_24 + var_502_27 and arg_499_1.time_ < var_502_24 + var_502_27 + arg_502_0 then
				var_502_23.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_502_30 = 0
			local var_502_31 = 0.3

			if var_502_30 < arg_499_1.time_ and arg_499_1.time_ <= var_502_30 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_32 = arg_499_1:FormatText(StoryNameCfg[1113].name)

				arg_499_1.leftNameTxt_.text = var_502_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_33 = arg_499_1:GetWordFromCfg(417241117)
				local var_502_34 = arg_499_1:FormatText(var_502_33.content)

				arg_499_1.text_.text = var_502_34

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_35 = 12
				local var_502_36 = utf8.len(var_502_34)
				local var_502_37 = var_502_35 <= 0 and var_502_31 or var_502_31 * (var_502_36 / var_502_35)

				if var_502_37 > 0 and var_502_31 < var_502_37 then
					arg_499_1.talkMaxDuration = var_502_37

					if var_502_37 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_37 + var_502_30
					end
				end

				arg_499_1.text_.text = var_502_34
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241117", "story_v_out_417241.awb") ~= 0 then
					local var_502_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241117", "story_v_out_417241.awb") / 1000

					if var_502_38 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_38 + var_502_30
					end

					if var_502_33.prefab_name ~= "" and arg_499_1.actors_[var_502_33.prefab_name] ~= nil then
						local var_502_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_33.prefab_name].transform, "story_v_out_417241", "417241117", "story_v_out_417241.awb")

						arg_499_1:RecordAudio("417241117", var_502_39)
						arg_499_1:RecordAudio("417241117", var_502_39)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_417241", "417241117", "story_v_out_417241.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_417241", "417241117", "story_v_out_417241.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_40 = math.max(var_502_31, arg_499_1.talkMaxDuration)

			if var_502_30 <= arg_499_1.time_ and arg_499_1.time_ < var_502_30 + var_502_40 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_30) / var_502_40

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_30 + var_502_40 and arg_499_1.time_ < var_502_30 + var_502_40 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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

		arg_499_1:InitPlayNodeList()
	end,
	Play417241118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 417241118
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play417241119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["10115"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10115 == nil then
				arg_503_1.var_.actorSpriteComps10115 = var_506_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_2 = 0.2

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.actorSpriteComps10115 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								local var_506_4 = Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor2.r, var_506_3)
								local var_506_5 = Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor2.g, var_506_3)
								local var_506_6 = Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor2.b, var_506_3)

								iter_506_1.color = Color.New(var_506_4, var_506_5, var_506_6)
							else
								local var_506_7 = Mathf.Lerp(iter_506_1.color.r, 0.5, var_506_3)

								iter_506_1.color = Color.New(var_506_7, var_506_7, var_506_7)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10115 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_506_3 then
						if arg_503_1.isInRecall_ then
							iter_506_3.color = arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_506_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_503_1.var_.actorSpriteComps10115 = nil
			end

			local var_506_8 = arg_503_1.actors_["10111"].transform
			local var_506_9 = 0

			if var_506_9 < arg_503_1.time_ and arg_503_1.time_ <= var_506_9 + arg_506_0 then
				arg_503_1.var_.moveOldPos10111 = var_506_8.localPosition
				var_506_8.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10111", 7)

				local var_506_10 = var_506_8.childCount

				for iter_506_4 = 0, var_506_10 - 1 do
					local var_506_11 = var_506_8:GetChild(iter_506_4)

					if var_506_11.name == "" or not string.find(var_506_11.name, "split") then
						var_506_11.gameObject:SetActive(true)
					else
						var_506_11.gameObject:SetActive(false)
					end
				end
			end

			local var_506_12 = 0.001

			if var_506_9 <= arg_503_1.time_ and arg_503_1.time_ < var_506_9 + var_506_12 then
				local var_506_13 = (arg_503_1.time_ - var_506_9) / var_506_12
				local var_506_14 = Vector3.New(0, -2000, 0)

				var_506_8.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10111, var_506_14, var_506_13)
			end

			if arg_503_1.time_ >= var_506_9 + var_506_12 and arg_503_1.time_ < var_506_9 + var_506_12 + arg_506_0 then
				var_506_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_506_15 = arg_503_1.actors_["10115"].transform
			local var_506_16 = 0

			if var_506_16 < arg_503_1.time_ and arg_503_1.time_ <= var_506_16 + arg_506_0 then
				arg_503_1.var_.moveOldPos10115 = var_506_15.localPosition
				var_506_15.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10115", 7)

				local var_506_17 = var_506_15.childCount

				for iter_506_5 = 0, var_506_17 - 1 do
					local var_506_18 = var_506_15:GetChild(iter_506_5)

					if var_506_18.name == "" or not string.find(var_506_18.name, "split") then
						var_506_18.gameObject:SetActive(true)
					else
						var_506_18.gameObject:SetActive(false)
					end
				end
			end

			local var_506_19 = 0.001

			if var_506_16 <= arg_503_1.time_ and arg_503_1.time_ < var_506_16 + var_506_19 then
				local var_506_20 = (arg_503_1.time_ - var_506_16) / var_506_19
				local var_506_21 = Vector3.New(0, -2000, 0)

				var_506_15.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10115, var_506_21, var_506_20)
			end

			if arg_503_1.time_ >= var_506_16 + var_506_19 and arg_503_1.time_ < var_506_16 + var_506_19 + arg_506_0 then
				var_506_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_506_22 = 0
			local var_506_23 = 0.8

			if var_506_22 < arg_503_1.time_ and arg_503_1.time_ <= var_506_22 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_24 = arg_503_1:GetWordFromCfg(417241118)
				local var_506_25 = arg_503_1:FormatText(var_506_24.content)

				arg_503_1.text_.text = var_506_25

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_26 = 32
				local var_506_27 = utf8.len(var_506_25)
				local var_506_28 = var_506_26 <= 0 and var_506_23 or var_506_23 * (var_506_27 / var_506_26)

				if var_506_28 > 0 and var_506_23 < var_506_28 then
					arg_503_1.talkMaxDuration = var_506_28

					if var_506_28 + var_506_22 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_28 + var_506_22
					end
				end

				arg_503_1.text_.text = var_506_25
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_29 = math.max(var_506_23, arg_503_1.talkMaxDuration)

			if var_506_22 <= arg_503_1.time_ and arg_503_1.time_ < var_506_22 + var_506_29 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_22) / var_506_29

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_22 + var_506_29 and arg_503_1.time_ < var_506_22 + var_506_29 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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

		arg_503_1:InitPlayNodeList()
	end,
	Play417241119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 417241119
		arg_507_1.duration_ = 9.23

		local var_507_0 = {
			zh = 6.766,
			ja = 9.233
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play417241120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["10111"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10111 == nil then
				arg_507_1.var_.actorSpriteComps10111 = var_510_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_2 = 0.2

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.actorSpriteComps10111 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								local var_510_4 = Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor1.r, var_510_3)
								local var_510_5 = Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor1.g, var_510_3)
								local var_510_6 = Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor1.b, var_510_3)

								iter_510_1.color = Color.New(var_510_4, var_510_5, var_510_6)
							else
								local var_510_7 = Mathf.Lerp(iter_510_1.color.r, 1, var_510_3)

								iter_510_1.color = Color.New(var_510_7, var_510_7, var_510_7)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10111 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_510_3 then
						if arg_507_1.isInRecall_ then
							iter_510_3.color = arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_510_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_507_1.var_.actorSpriteComps10111 = nil
			end

			local var_510_8 = arg_507_1.actors_["10111"].transform
			local var_510_9 = 0

			if var_510_9 < arg_507_1.time_ and arg_507_1.time_ <= var_510_9 + arg_510_0 then
				arg_507_1.var_.moveOldPos10111 = var_510_8.localPosition
				var_510_8.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10111", 3)

				local var_510_10 = var_510_8.childCount

				for iter_510_4 = 0, var_510_10 - 1 do
					local var_510_11 = var_510_8:GetChild(iter_510_4)

					if var_510_11.name == "" or not string.find(var_510_11.name, "split") then
						var_510_11.gameObject:SetActive(true)
					else
						var_510_11.gameObject:SetActive(false)
					end
				end
			end

			local var_510_12 = 0.001

			if var_510_9 <= arg_507_1.time_ and arg_507_1.time_ < var_510_9 + var_510_12 then
				local var_510_13 = (arg_507_1.time_ - var_510_9) / var_510_12
				local var_510_14 = Vector3.New(0, -361.1, -274.6)

				var_510_8.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10111, var_510_14, var_510_13)
			end

			if arg_507_1.time_ >= var_510_9 + var_510_12 and arg_507_1.time_ < var_510_9 + var_510_12 + arg_510_0 then
				var_510_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_510_15 = 0
			local var_510_16 = 0.75

			if var_510_15 < arg_507_1.time_ and arg_507_1.time_ <= var_510_15 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_17 = arg_507_1:FormatText(StoryNameCfg[1125].name)

				arg_507_1.leftNameTxt_.text = var_510_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_18 = arg_507_1:GetWordFromCfg(417241119)
				local var_510_19 = arg_507_1:FormatText(var_510_18.content)

				arg_507_1.text_.text = var_510_19

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_20 = 30
				local var_510_21 = utf8.len(var_510_19)
				local var_510_22 = var_510_20 <= 0 and var_510_16 or var_510_16 * (var_510_21 / var_510_20)

				if var_510_22 > 0 and var_510_16 < var_510_22 then
					arg_507_1.talkMaxDuration = var_510_22

					if var_510_22 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_22 + var_510_15
					end
				end

				arg_507_1.text_.text = var_510_19
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241119", "story_v_out_417241.awb") ~= 0 then
					local var_510_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241119", "story_v_out_417241.awb") / 1000

					if var_510_23 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_23 + var_510_15
					end

					if var_510_18.prefab_name ~= "" and arg_507_1.actors_[var_510_18.prefab_name] ~= nil then
						local var_510_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_18.prefab_name].transform, "story_v_out_417241", "417241119", "story_v_out_417241.awb")

						arg_507_1:RecordAudio("417241119", var_510_24)
						arg_507_1:RecordAudio("417241119", var_510_24)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_417241", "417241119", "story_v_out_417241.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_417241", "417241119", "story_v_out_417241.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_25 = math.max(var_510_16, arg_507_1.talkMaxDuration)

			if var_510_15 <= arg_507_1.time_ and arg_507_1.time_ < var_510_15 + var_510_25 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_15) / var_510_25

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_15 + var_510_25 and arg_507_1.time_ < var_510_15 + var_510_25 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play417241120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 417241120
		arg_511_1.duration_ = 6.67

		local var_511_0 = {
			zh = 3.533,
			ja = 6.666
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play417241121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["10115"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps10115 == nil then
				arg_511_1.var_.actorSpriteComps10115 = var_514_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_2 = 0.2

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.actorSpriteComps10115 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								local var_514_4 = Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor1.r, var_514_3)
								local var_514_5 = Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor1.g, var_514_3)
								local var_514_6 = Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor1.b, var_514_3)

								iter_514_1.color = Color.New(var_514_4, var_514_5, var_514_6)
							else
								local var_514_7 = Mathf.Lerp(iter_514_1.color.r, 1, var_514_3)

								iter_514_1.color = Color.New(var_514_7, var_514_7, var_514_7)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps10115 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_514_3 then
						if arg_511_1.isInRecall_ then
							iter_514_3.color = arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_514_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_511_1.var_.actorSpriteComps10115 = nil
			end

			local var_514_8 = arg_511_1.actors_["10111"]
			local var_514_9 = 0

			if var_514_9 < arg_511_1.time_ and arg_511_1.time_ <= var_514_9 + arg_514_0 and not isNil(var_514_8) and arg_511_1.var_.actorSpriteComps10111 == nil then
				arg_511_1.var_.actorSpriteComps10111 = var_514_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_10 = 0.2

			if var_514_9 <= arg_511_1.time_ and arg_511_1.time_ < var_514_9 + var_514_10 and not isNil(var_514_8) then
				local var_514_11 = (arg_511_1.time_ - var_514_9) / var_514_10

				if arg_511_1.var_.actorSpriteComps10111 then
					for iter_514_4, iter_514_5 in pairs(arg_511_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_514_5 then
							if arg_511_1.isInRecall_ then
								local var_514_12 = Mathf.Lerp(iter_514_5.color.r, arg_511_1.hightColor2.r, var_514_11)
								local var_514_13 = Mathf.Lerp(iter_514_5.color.g, arg_511_1.hightColor2.g, var_514_11)
								local var_514_14 = Mathf.Lerp(iter_514_5.color.b, arg_511_1.hightColor2.b, var_514_11)

								iter_514_5.color = Color.New(var_514_12, var_514_13, var_514_14)
							else
								local var_514_15 = Mathf.Lerp(iter_514_5.color.r, 0.5, var_514_11)

								iter_514_5.color = Color.New(var_514_15, var_514_15, var_514_15)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_9 + var_514_10 and arg_511_1.time_ < var_514_9 + var_514_10 + arg_514_0 and not isNil(var_514_8) and arg_511_1.var_.actorSpriteComps10111 then
				for iter_514_6, iter_514_7 in pairs(arg_511_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_514_7 then
						if arg_511_1.isInRecall_ then
							iter_514_7.color = arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_514_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_511_1.var_.actorSpriteComps10111 = nil
			end

			local var_514_16 = arg_511_1.actors_["10111"].transform
			local var_514_17 = 0

			if var_514_17 < arg_511_1.time_ and arg_511_1.time_ <= var_514_17 + arg_514_0 then
				arg_511_1.var_.moveOldPos10111 = var_514_16.localPosition
				var_514_16.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10111", 2)

				local var_514_18 = var_514_16.childCount

				for iter_514_8 = 0, var_514_18 - 1 do
					local var_514_19 = var_514_16:GetChild(iter_514_8)

					if var_514_19.name == "" or not string.find(var_514_19.name, "split") then
						var_514_19.gameObject:SetActive(true)
					else
						var_514_19.gameObject:SetActive(false)
					end
				end
			end

			local var_514_20 = 0.001

			if var_514_17 <= arg_511_1.time_ and arg_511_1.time_ < var_514_17 + var_514_20 then
				local var_514_21 = (arg_511_1.time_ - var_514_17) / var_514_20
				local var_514_22 = Vector3.New(-390, -361.1, -274.6)

				var_514_16.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10111, var_514_22, var_514_21)
			end

			if arg_511_1.time_ >= var_514_17 + var_514_20 and arg_511_1.time_ < var_514_17 + var_514_20 + arg_514_0 then
				var_514_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_514_23 = arg_511_1.actors_["10115"].transform
			local var_514_24 = 0

			if var_514_24 < arg_511_1.time_ and arg_511_1.time_ <= var_514_24 + arg_514_0 then
				arg_511_1.var_.moveOldPos10115 = var_514_23.localPosition
				var_514_23.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10115", 4)

				local var_514_25 = var_514_23.childCount

				for iter_514_9 = 0, var_514_25 - 1 do
					local var_514_26 = var_514_23:GetChild(iter_514_9)

					if var_514_26.name == "" or not string.find(var_514_26.name, "split") then
						var_514_26.gameObject:SetActive(true)
					else
						var_514_26.gameObject:SetActive(false)
					end
				end
			end

			local var_514_27 = 0.001

			if var_514_24 <= arg_511_1.time_ and arg_511_1.time_ < var_514_24 + var_514_27 then
				local var_514_28 = (arg_511_1.time_ - var_514_24) / var_514_27
				local var_514_29 = Vector3.New(390, -387.3, -246.2)

				var_514_23.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10115, var_514_29, var_514_28)
			end

			if arg_511_1.time_ >= var_514_24 + var_514_27 and arg_511_1.time_ < var_514_24 + var_514_27 + arg_514_0 then
				var_514_23.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_514_30 = 0
			local var_514_31 = 0.375

			if var_514_30 < arg_511_1.time_ and arg_511_1.time_ <= var_514_30 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_32 = arg_511_1:FormatText(StoryNameCfg[1113].name)

				arg_511_1.leftNameTxt_.text = var_514_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_33 = arg_511_1:GetWordFromCfg(417241120)
				local var_514_34 = arg_511_1:FormatText(var_514_33.content)

				arg_511_1.text_.text = var_514_34

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_35 = 15
				local var_514_36 = utf8.len(var_514_34)
				local var_514_37 = var_514_35 <= 0 and var_514_31 or var_514_31 * (var_514_36 / var_514_35)

				if var_514_37 > 0 and var_514_31 < var_514_37 then
					arg_511_1.talkMaxDuration = var_514_37

					if var_514_37 + var_514_30 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_37 + var_514_30
					end
				end

				arg_511_1.text_.text = var_514_34
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241120", "story_v_out_417241.awb") ~= 0 then
					local var_514_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241120", "story_v_out_417241.awb") / 1000

					if var_514_38 + var_514_30 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_38 + var_514_30
					end

					if var_514_33.prefab_name ~= "" and arg_511_1.actors_[var_514_33.prefab_name] ~= nil then
						local var_514_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_33.prefab_name].transform, "story_v_out_417241", "417241120", "story_v_out_417241.awb")

						arg_511_1:RecordAudio("417241120", var_514_39)
						arg_511_1:RecordAudio("417241120", var_514_39)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_417241", "417241120", "story_v_out_417241.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_417241", "417241120", "story_v_out_417241.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_40 = math.max(var_514_31, arg_511_1.talkMaxDuration)

			if var_514_30 <= arg_511_1.time_ and arg_511_1.time_ < var_514_30 + var_514_40 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_30) / var_514_40

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_30 + var_514_40 and arg_511_1.time_ < var_514_30 + var_514_40 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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

		arg_511_1:InitPlayNodeList()
	end,
	Play417241121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 417241121
		arg_515_1.duration_ = 2.7

		local var_515_0 = {
			zh = 1.5,
			ja = 2.7
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play417241122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["10111"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps10111 == nil then
				arg_515_1.var_.actorSpriteComps10111 = var_518_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_2 = 0.2

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.actorSpriteComps10111 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								local var_518_4 = Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor1.r, var_518_3)
								local var_518_5 = Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor1.g, var_518_3)
								local var_518_6 = Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor1.b, var_518_3)

								iter_518_1.color = Color.New(var_518_4, var_518_5, var_518_6)
							else
								local var_518_7 = Mathf.Lerp(iter_518_1.color.r, 1, var_518_3)

								iter_518_1.color = Color.New(var_518_7, var_518_7, var_518_7)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps10111 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_518_3 then
						if arg_515_1.isInRecall_ then
							iter_518_3.color = arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_518_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_515_1.var_.actorSpriteComps10111 = nil
			end

			local var_518_8 = arg_515_1.actors_["10115"]
			local var_518_9 = 0

			if var_518_9 < arg_515_1.time_ and arg_515_1.time_ <= var_518_9 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps10115 == nil then
				arg_515_1.var_.actorSpriteComps10115 = var_518_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_10 = 0.2

			if var_518_9 <= arg_515_1.time_ and arg_515_1.time_ < var_518_9 + var_518_10 and not isNil(var_518_8) then
				local var_518_11 = (arg_515_1.time_ - var_518_9) / var_518_10

				if arg_515_1.var_.actorSpriteComps10115 then
					for iter_518_4, iter_518_5 in pairs(arg_515_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_518_5 then
							if arg_515_1.isInRecall_ then
								local var_518_12 = Mathf.Lerp(iter_518_5.color.r, arg_515_1.hightColor2.r, var_518_11)
								local var_518_13 = Mathf.Lerp(iter_518_5.color.g, arg_515_1.hightColor2.g, var_518_11)
								local var_518_14 = Mathf.Lerp(iter_518_5.color.b, arg_515_1.hightColor2.b, var_518_11)

								iter_518_5.color = Color.New(var_518_12, var_518_13, var_518_14)
							else
								local var_518_15 = Mathf.Lerp(iter_518_5.color.r, 0.5, var_518_11)

								iter_518_5.color = Color.New(var_518_15, var_518_15, var_518_15)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= var_518_9 + var_518_10 and arg_515_1.time_ < var_518_9 + var_518_10 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps10115 then
				for iter_518_6, iter_518_7 in pairs(arg_515_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_518_7 then
						if arg_515_1.isInRecall_ then
							iter_518_7.color = arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_518_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_515_1.var_.actorSpriteComps10115 = nil
			end

			local var_518_16 = 0
			local var_518_17 = 0.15

			if var_518_16 < arg_515_1.time_ and arg_515_1.time_ <= var_518_16 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_18 = arg_515_1:FormatText(StoryNameCfg[1125].name)

				arg_515_1.leftNameTxt_.text = var_518_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_19 = arg_515_1:GetWordFromCfg(417241121)
				local var_518_20 = arg_515_1:FormatText(var_518_19.content)

				arg_515_1.text_.text = var_518_20

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_21 = 6
				local var_518_22 = utf8.len(var_518_20)
				local var_518_23 = var_518_21 <= 0 and var_518_17 or var_518_17 * (var_518_22 / var_518_21)

				if var_518_23 > 0 and var_518_17 < var_518_23 then
					arg_515_1.talkMaxDuration = var_518_23

					if var_518_23 + var_518_16 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_23 + var_518_16
					end
				end

				arg_515_1.text_.text = var_518_20
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241121", "story_v_out_417241.awb") ~= 0 then
					local var_518_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241121", "story_v_out_417241.awb") / 1000

					if var_518_24 + var_518_16 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_24 + var_518_16
					end

					if var_518_19.prefab_name ~= "" and arg_515_1.actors_[var_518_19.prefab_name] ~= nil then
						local var_518_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_19.prefab_name].transform, "story_v_out_417241", "417241121", "story_v_out_417241.awb")

						arg_515_1:RecordAudio("417241121", var_518_25)
						arg_515_1:RecordAudio("417241121", var_518_25)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_417241", "417241121", "story_v_out_417241.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_417241", "417241121", "story_v_out_417241.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_26 = math.max(var_518_17, arg_515_1.talkMaxDuration)

			if var_518_16 <= arg_515_1.time_ and arg_515_1.time_ < var_518_16 + var_518_26 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_16) / var_518_26

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_16 + var_518_26 and arg_515_1.time_ < var_518_16 + var_518_26 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play417241122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 417241122
		arg_519_1.duration_ = 5.93

		local var_519_0 = {
			zh = 5.766,
			ja = 5.933
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play417241123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10115"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10115 == nil then
				arg_519_1.var_.actorSpriteComps10115 = var_522_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_2 = 0.2

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.actorSpriteComps10115 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_522_1 then
							if arg_519_1.isInRecall_ then
								local var_522_4 = Mathf.Lerp(iter_522_1.color.r, arg_519_1.hightColor1.r, var_522_3)
								local var_522_5 = Mathf.Lerp(iter_522_1.color.g, arg_519_1.hightColor1.g, var_522_3)
								local var_522_6 = Mathf.Lerp(iter_522_1.color.b, arg_519_1.hightColor1.b, var_522_3)

								iter_522_1.color = Color.New(var_522_4, var_522_5, var_522_6)
							else
								local var_522_7 = Mathf.Lerp(iter_522_1.color.r, 1, var_522_3)

								iter_522_1.color = Color.New(var_522_7, var_522_7, var_522_7)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10115 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_522_3 then
						if arg_519_1.isInRecall_ then
							iter_522_3.color = arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_522_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_519_1.var_.actorSpriteComps10115 = nil
			end

			local var_522_8 = arg_519_1.actors_["10111"]
			local var_522_9 = 0

			if var_522_9 < arg_519_1.time_ and arg_519_1.time_ <= var_522_9 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10111 == nil then
				arg_519_1.var_.actorSpriteComps10111 = var_522_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_10 = 0.2

			if var_522_9 <= arg_519_1.time_ and arg_519_1.time_ < var_522_9 + var_522_10 and not isNil(var_522_8) then
				local var_522_11 = (arg_519_1.time_ - var_522_9) / var_522_10

				if arg_519_1.var_.actorSpriteComps10111 then
					for iter_522_4, iter_522_5 in pairs(arg_519_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_522_5 then
							if arg_519_1.isInRecall_ then
								local var_522_12 = Mathf.Lerp(iter_522_5.color.r, arg_519_1.hightColor2.r, var_522_11)
								local var_522_13 = Mathf.Lerp(iter_522_5.color.g, arg_519_1.hightColor2.g, var_522_11)
								local var_522_14 = Mathf.Lerp(iter_522_5.color.b, arg_519_1.hightColor2.b, var_522_11)

								iter_522_5.color = Color.New(var_522_12, var_522_13, var_522_14)
							else
								local var_522_15 = Mathf.Lerp(iter_522_5.color.r, 0.5, var_522_11)

								iter_522_5.color = Color.New(var_522_15, var_522_15, var_522_15)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= var_522_9 + var_522_10 and arg_519_1.time_ < var_522_9 + var_522_10 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10111 then
				for iter_522_6, iter_522_7 in pairs(arg_519_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_522_7 then
						if arg_519_1.isInRecall_ then
							iter_522_7.color = arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_522_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_519_1.var_.actorSpriteComps10111 = nil
			end

			local var_522_16 = 0
			local var_522_17 = 0.75

			if var_522_16 < arg_519_1.time_ and arg_519_1.time_ <= var_522_16 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_18 = arg_519_1:FormatText(StoryNameCfg[1113].name)

				arg_519_1.leftNameTxt_.text = var_522_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_19 = arg_519_1:GetWordFromCfg(417241122)
				local var_522_20 = arg_519_1:FormatText(var_522_19.content)

				arg_519_1.text_.text = var_522_20

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_21 = 30
				local var_522_22 = utf8.len(var_522_20)
				local var_522_23 = var_522_21 <= 0 and var_522_17 or var_522_17 * (var_522_22 / var_522_21)

				if var_522_23 > 0 and var_522_17 < var_522_23 then
					arg_519_1.talkMaxDuration = var_522_23

					if var_522_23 + var_522_16 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_23 + var_522_16
					end
				end

				arg_519_1.text_.text = var_522_20
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241122", "story_v_out_417241.awb") ~= 0 then
					local var_522_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241122", "story_v_out_417241.awb") / 1000

					if var_522_24 + var_522_16 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_24 + var_522_16
					end

					if var_522_19.prefab_name ~= "" and arg_519_1.actors_[var_522_19.prefab_name] ~= nil then
						local var_522_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_19.prefab_name].transform, "story_v_out_417241", "417241122", "story_v_out_417241.awb")

						arg_519_1:RecordAudio("417241122", var_522_25)
						arg_519_1:RecordAudio("417241122", var_522_25)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_417241", "417241122", "story_v_out_417241.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_417241", "417241122", "story_v_out_417241.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_26 = math.max(var_522_17, arg_519_1.talkMaxDuration)

			if var_522_16 <= arg_519_1.time_ and arg_519_1.time_ < var_522_16 + var_522_26 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_16) / var_522_26

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_16 + var_522_26 and arg_519_1.time_ < var_522_16 + var_522_26 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play417241123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 417241123
		arg_523_1.duration_ = 12.87

		local var_523_0 = {
			zh = 8.133,
			ja = 12.866
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play417241124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1.025

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[1113].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:GetWordFromCfg(417241123)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 41
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241123", "story_v_out_417241.awb") ~= 0 then
					local var_526_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241123", "story_v_out_417241.awb") / 1000

					if var_526_8 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_0
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_417241", "417241123", "story_v_out_417241.awb")

						arg_523_1:RecordAudio("417241123", var_526_9)
						arg_523_1:RecordAudio("417241123", var_526_9)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_417241", "417241123", "story_v_out_417241.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_417241", "417241123", "story_v_out_417241.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_10 and arg_523_1.time_ < var_526_0 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play417241124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 417241124
		arg_527_1.duration_ = 14.1

		local var_527_0 = {
			zh = 9.866,
			ja = 14.1
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play417241125(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 1.3

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[1113].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_3 = arg_527_1:GetWordFromCfg(417241124)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 52
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241124", "story_v_out_417241.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241124", "story_v_out_417241.awb") / 1000

					if var_530_8 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_0
					end

					if var_530_3.prefab_name ~= "" and arg_527_1.actors_[var_530_3.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_3.prefab_name].transform, "story_v_out_417241", "417241124", "story_v_out_417241.awb")

						arg_527_1:RecordAudio("417241124", var_530_9)
						arg_527_1:RecordAudio("417241124", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_417241", "417241124", "story_v_out_417241.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_417241", "417241124", "story_v_out_417241.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_10 and arg_527_1.time_ < var_530_0 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play417241125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 417241125
		arg_531_1.duration_ = 11.2

		local var_531_0 = {
			zh = 7,
			ja = 11.2
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play417241126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["10111"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.actorSpriteComps10111 == nil then
				arg_531_1.var_.actorSpriteComps10111 = var_534_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_2 = 0.2

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.actorSpriteComps10111 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								local var_534_4 = Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor1.r, var_534_3)
								local var_534_5 = Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor1.g, var_534_3)
								local var_534_6 = Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor1.b, var_534_3)

								iter_534_1.color = Color.New(var_534_4, var_534_5, var_534_6)
							else
								local var_534_7 = Mathf.Lerp(iter_534_1.color.r, 1, var_534_3)

								iter_534_1.color = Color.New(var_534_7, var_534_7, var_534_7)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.actorSpriteComps10111 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_534_3 then
						if arg_531_1.isInRecall_ then
							iter_534_3.color = arg_531_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_534_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_531_1.var_.actorSpriteComps10111 = nil
			end

			local var_534_8 = arg_531_1.actors_["10115"]
			local var_534_9 = 0

			if var_534_9 < arg_531_1.time_ and arg_531_1.time_ <= var_534_9 + arg_534_0 and not isNil(var_534_8) and arg_531_1.var_.actorSpriteComps10115 == nil then
				arg_531_1.var_.actorSpriteComps10115 = var_534_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_10 = 0.2

			if var_534_9 <= arg_531_1.time_ and arg_531_1.time_ < var_534_9 + var_534_10 and not isNil(var_534_8) then
				local var_534_11 = (arg_531_1.time_ - var_534_9) / var_534_10

				if arg_531_1.var_.actorSpriteComps10115 then
					for iter_534_4, iter_534_5 in pairs(arg_531_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_534_5 then
							if arg_531_1.isInRecall_ then
								local var_534_12 = Mathf.Lerp(iter_534_5.color.r, arg_531_1.hightColor2.r, var_534_11)
								local var_534_13 = Mathf.Lerp(iter_534_5.color.g, arg_531_1.hightColor2.g, var_534_11)
								local var_534_14 = Mathf.Lerp(iter_534_5.color.b, arg_531_1.hightColor2.b, var_534_11)

								iter_534_5.color = Color.New(var_534_12, var_534_13, var_534_14)
							else
								local var_534_15 = Mathf.Lerp(iter_534_5.color.r, 0.5, var_534_11)

								iter_534_5.color = Color.New(var_534_15, var_534_15, var_534_15)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= var_534_9 + var_534_10 and arg_531_1.time_ < var_534_9 + var_534_10 + arg_534_0 and not isNil(var_534_8) and arg_531_1.var_.actorSpriteComps10115 then
				for iter_534_6, iter_534_7 in pairs(arg_531_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_534_7 then
						if arg_531_1.isInRecall_ then
							iter_534_7.color = arg_531_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_534_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_531_1.var_.actorSpriteComps10115 = nil
			end

			local var_534_16 = 0
			local var_534_17 = 0.775

			if var_534_16 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_18 = arg_531_1:FormatText(StoryNameCfg[1125].name)

				arg_531_1.leftNameTxt_.text = var_534_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_19 = arg_531_1:GetWordFromCfg(417241125)
				local var_534_20 = arg_531_1:FormatText(var_534_19.content)

				arg_531_1.text_.text = var_534_20

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_21 = 31
				local var_534_22 = utf8.len(var_534_20)
				local var_534_23 = var_534_21 <= 0 and var_534_17 or var_534_17 * (var_534_22 / var_534_21)

				if var_534_23 > 0 and var_534_17 < var_534_23 then
					arg_531_1.talkMaxDuration = var_534_23

					if var_534_23 + var_534_16 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_23 + var_534_16
					end
				end

				arg_531_1.text_.text = var_534_20
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241125", "story_v_out_417241.awb") ~= 0 then
					local var_534_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241125", "story_v_out_417241.awb") / 1000

					if var_534_24 + var_534_16 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_24 + var_534_16
					end

					if var_534_19.prefab_name ~= "" and arg_531_1.actors_[var_534_19.prefab_name] ~= nil then
						local var_534_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_19.prefab_name].transform, "story_v_out_417241", "417241125", "story_v_out_417241.awb")

						arg_531_1:RecordAudio("417241125", var_534_25)
						arg_531_1:RecordAudio("417241125", var_534_25)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_417241", "417241125", "story_v_out_417241.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_417241", "417241125", "story_v_out_417241.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_26 = math.max(var_534_17, arg_531_1.talkMaxDuration)

			if var_534_16 <= arg_531_1.time_ and arg_531_1.time_ < var_534_16 + var_534_26 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_16) / var_534_26

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_16 + var_534_26 and arg_531_1.time_ < var_534_16 + var_534_26 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play417241126 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 417241126
		arg_535_1.duration_ = 6.8

		local var_535_0 = {
			zh = 4.266,
			ja = 6.8
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play417241127(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.525

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_2 = arg_535_1:FormatText(StoryNameCfg[1125].name)

				arg_535_1.leftNameTxt_.text = var_538_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:GetWordFromCfg(417241126)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 21
				local var_538_6 = utf8.len(var_538_4)
				local var_538_7 = var_538_5 <= 0 and var_538_1 or var_538_1 * (var_538_6 / var_538_5)

				if var_538_7 > 0 and var_538_1 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241126", "story_v_out_417241.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241126", "story_v_out_417241.awb") / 1000

					if var_538_8 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_0
					end

					if var_538_3.prefab_name ~= "" and arg_535_1.actors_[var_538_3.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_3.prefab_name].transform, "story_v_out_417241", "417241126", "story_v_out_417241.awb")

						arg_535_1:RecordAudio("417241126", var_538_9)
						arg_535_1:RecordAudio("417241126", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_417241", "417241126", "story_v_out_417241.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_417241", "417241126", "story_v_out_417241.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_10 and arg_535_1.time_ < var_538_0 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play417241127 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 417241127
		arg_539_1.duration_ = 5.4

		local var_539_0 = {
			zh = 5.4,
			ja = 5.366
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play417241128(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["10115"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.actorSpriteComps10115 == nil then
				arg_539_1.var_.actorSpriteComps10115 = var_542_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_2 = 0.2

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 and not isNil(var_542_0) then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2

				if arg_539_1.var_.actorSpriteComps10115 then
					for iter_542_0, iter_542_1 in pairs(arg_539_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_542_1 then
							if arg_539_1.isInRecall_ then
								local var_542_4 = Mathf.Lerp(iter_542_1.color.r, arg_539_1.hightColor1.r, var_542_3)
								local var_542_5 = Mathf.Lerp(iter_542_1.color.g, arg_539_1.hightColor1.g, var_542_3)
								local var_542_6 = Mathf.Lerp(iter_542_1.color.b, arg_539_1.hightColor1.b, var_542_3)

								iter_542_1.color = Color.New(var_542_4, var_542_5, var_542_6)
							else
								local var_542_7 = Mathf.Lerp(iter_542_1.color.r, 1, var_542_3)

								iter_542_1.color = Color.New(var_542_7, var_542_7, var_542_7)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.actorSpriteComps10115 then
				for iter_542_2, iter_542_3 in pairs(arg_539_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_542_3 then
						if arg_539_1.isInRecall_ then
							iter_542_3.color = arg_539_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_542_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_539_1.var_.actorSpriteComps10115 = nil
			end

			local var_542_8 = arg_539_1.actors_["10111"]
			local var_542_9 = 0

			if var_542_9 < arg_539_1.time_ and arg_539_1.time_ <= var_542_9 + arg_542_0 and not isNil(var_542_8) and arg_539_1.var_.actorSpriteComps10111 == nil then
				arg_539_1.var_.actorSpriteComps10111 = var_542_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_10 = 0.2

			if var_542_9 <= arg_539_1.time_ and arg_539_1.time_ < var_542_9 + var_542_10 and not isNil(var_542_8) then
				local var_542_11 = (arg_539_1.time_ - var_542_9) / var_542_10

				if arg_539_1.var_.actorSpriteComps10111 then
					for iter_542_4, iter_542_5 in pairs(arg_539_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_542_5 then
							if arg_539_1.isInRecall_ then
								local var_542_12 = Mathf.Lerp(iter_542_5.color.r, arg_539_1.hightColor2.r, var_542_11)
								local var_542_13 = Mathf.Lerp(iter_542_5.color.g, arg_539_1.hightColor2.g, var_542_11)
								local var_542_14 = Mathf.Lerp(iter_542_5.color.b, arg_539_1.hightColor2.b, var_542_11)

								iter_542_5.color = Color.New(var_542_12, var_542_13, var_542_14)
							else
								local var_542_15 = Mathf.Lerp(iter_542_5.color.r, 0.5, var_542_11)

								iter_542_5.color = Color.New(var_542_15, var_542_15, var_542_15)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= var_542_9 + var_542_10 and arg_539_1.time_ < var_542_9 + var_542_10 + arg_542_0 and not isNil(var_542_8) and arg_539_1.var_.actorSpriteComps10111 then
				for iter_542_6, iter_542_7 in pairs(arg_539_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_542_7 then
						if arg_539_1.isInRecall_ then
							iter_542_7.color = arg_539_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_542_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_539_1.var_.actorSpriteComps10111 = nil
			end

			local var_542_16 = 0
			local var_542_17 = 0.45

			if var_542_16 < arg_539_1.time_ and arg_539_1.time_ <= var_542_16 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_18 = arg_539_1:FormatText(StoryNameCfg[1113].name)

				arg_539_1.leftNameTxt_.text = var_542_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_19 = arg_539_1:GetWordFromCfg(417241127)
				local var_542_20 = arg_539_1:FormatText(var_542_19.content)

				arg_539_1.text_.text = var_542_20

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_21 = 18
				local var_542_22 = utf8.len(var_542_20)
				local var_542_23 = var_542_21 <= 0 and var_542_17 or var_542_17 * (var_542_22 / var_542_21)

				if var_542_23 > 0 and var_542_17 < var_542_23 then
					arg_539_1.talkMaxDuration = var_542_23

					if var_542_23 + var_542_16 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_23 + var_542_16
					end
				end

				arg_539_1.text_.text = var_542_20
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241127", "story_v_out_417241.awb") ~= 0 then
					local var_542_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241127", "story_v_out_417241.awb") / 1000

					if var_542_24 + var_542_16 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_24 + var_542_16
					end

					if var_542_19.prefab_name ~= "" and arg_539_1.actors_[var_542_19.prefab_name] ~= nil then
						local var_542_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_19.prefab_name].transform, "story_v_out_417241", "417241127", "story_v_out_417241.awb")

						arg_539_1:RecordAudio("417241127", var_542_25)
						arg_539_1:RecordAudio("417241127", var_542_25)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_417241", "417241127", "story_v_out_417241.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_417241", "417241127", "story_v_out_417241.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_26 = math.max(var_542_17, arg_539_1.talkMaxDuration)

			if var_542_16 <= arg_539_1.time_ and arg_539_1.time_ < var_542_16 + var_542_26 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_16) / var_542_26

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_16 + var_542_26 and arg_539_1.time_ < var_542_16 + var_542_26 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play417241128 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 417241128
		arg_543_1.duration_ = 5.73

		local var_543_0 = {
			zh = 2.033,
			ja = 5.733
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play417241129(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["10111"]
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.actorSpriteComps10111 == nil then
				arg_543_1.var_.actorSpriteComps10111 = var_546_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_2 = 0.2

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 and not isNil(var_546_0) then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2

				if arg_543_1.var_.actorSpriteComps10111 then
					for iter_546_0, iter_546_1 in pairs(arg_543_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_546_1 then
							if arg_543_1.isInRecall_ then
								local var_546_4 = Mathf.Lerp(iter_546_1.color.r, arg_543_1.hightColor1.r, var_546_3)
								local var_546_5 = Mathf.Lerp(iter_546_1.color.g, arg_543_1.hightColor1.g, var_546_3)
								local var_546_6 = Mathf.Lerp(iter_546_1.color.b, arg_543_1.hightColor1.b, var_546_3)

								iter_546_1.color = Color.New(var_546_4, var_546_5, var_546_6)
							else
								local var_546_7 = Mathf.Lerp(iter_546_1.color.r, 1, var_546_3)

								iter_546_1.color = Color.New(var_546_7, var_546_7, var_546_7)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.actorSpriteComps10111 then
				for iter_546_2, iter_546_3 in pairs(arg_543_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_546_3 then
						if arg_543_1.isInRecall_ then
							iter_546_3.color = arg_543_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_546_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_543_1.var_.actorSpriteComps10111 = nil
			end

			local var_546_8 = arg_543_1.actors_["10115"]
			local var_546_9 = 0

			if var_546_9 < arg_543_1.time_ and arg_543_1.time_ <= var_546_9 + arg_546_0 and not isNil(var_546_8) and arg_543_1.var_.actorSpriteComps10115 == nil then
				arg_543_1.var_.actorSpriteComps10115 = var_546_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_10 = 0.2

			if var_546_9 <= arg_543_1.time_ and arg_543_1.time_ < var_546_9 + var_546_10 and not isNil(var_546_8) then
				local var_546_11 = (arg_543_1.time_ - var_546_9) / var_546_10

				if arg_543_1.var_.actorSpriteComps10115 then
					for iter_546_4, iter_546_5 in pairs(arg_543_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_546_5 then
							if arg_543_1.isInRecall_ then
								local var_546_12 = Mathf.Lerp(iter_546_5.color.r, arg_543_1.hightColor2.r, var_546_11)
								local var_546_13 = Mathf.Lerp(iter_546_5.color.g, arg_543_1.hightColor2.g, var_546_11)
								local var_546_14 = Mathf.Lerp(iter_546_5.color.b, arg_543_1.hightColor2.b, var_546_11)

								iter_546_5.color = Color.New(var_546_12, var_546_13, var_546_14)
							else
								local var_546_15 = Mathf.Lerp(iter_546_5.color.r, 0.5, var_546_11)

								iter_546_5.color = Color.New(var_546_15, var_546_15, var_546_15)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= var_546_9 + var_546_10 and arg_543_1.time_ < var_546_9 + var_546_10 + arg_546_0 and not isNil(var_546_8) and arg_543_1.var_.actorSpriteComps10115 then
				for iter_546_6, iter_546_7 in pairs(arg_543_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_546_7 then
						if arg_543_1.isInRecall_ then
							iter_546_7.color = arg_543_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_546_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_543_1.var_.actorSpriteComps10115 = nil
			end

			local var_546_16 = 0
			local var_546_17 = 0.2

			if var_546_16 < arg_543_1.time_ and arg_543_1.time_ <= var_546_16 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_18 = arg_543_1:FormatText(StoryNameCfg[1125].name)

				arg_543_1.leftNameTxt_.text = var_546_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_19 = arg_543_1:GetWordFromCfg(417241128)
				local var_546_20 = arg_543_1:FormatText(var_546_19.content)

				arg_543_1.text_.text = var_546_20

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_21 = 8
				local var_546_22 = utf8.len(var_546_20)
				local var_546_23 = var_546_21 <= 0 and var_546_17 or var_546_17 * (var_546_22 / var_546_21)

				if var_546_23 > 0 and var_546_17 < var_546_23 then
					arg_543_1.talkMaxDuration = var_546_23

					if var_546_23 + var_546_16 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_23 + var_546_16
					end
				end

				arg_543_1.text_.text = var_546_20
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241128", "story_v_out_417241.awb") ~= 0 then
					local var_546_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241128", "story_v_out_417241.awb") / 1000

					if var_546_24 + var_546_16 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_24 + var_546_16
					end

					if var_546_19.prefab_name ~= "" and arg_543_1.actors_[var_546_19.prefab_name] ~= nil then
						local var_546_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_19.prefab_name].transform, "story_v_out_417241", "417241128", "story_v_out_417241.awb")

						arg_543_1:RecordAudio("417241128", var_546_25)
						arg_543_1:RecordAudio("417241128", var_546_25)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_417241", "417241128", "story_v_out_417241.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_417241", "417241128", "story_v_out_417241.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_26 = math.max(var_546_17, arg_543_1.talkMaxDuration)

			if var_546_16 <= arg_543_1.time_ and arg_543_1.time_ < var_546_16 + var_546_26 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_16) / var_546_26

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_16 + var_546_26 and arg_543_1.time_ < var_546_16 + var_546_26 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play417241129 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 417241129
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play417241130(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["10111"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.actorSpriteComps10111 == nil then
				arg_547_1.var_.actorSpriteComps10111 = var_550_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_550_2 = 0.2

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.actorSpriteComps10111 then
					for iter_550_0, iter_550_1 in pairs(arg_547_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_550_1 then
							if arg_547_1.isInRecall_ then
								local var_550_4 = Mathf.Lerp(iter_550_1.color.r, arg_547_1.hightColor2.r, var_550_3)
								local var_550_5 = Mathf.Lerp(iter_550_1.color.g, arg_547_1.hightColor2.g, var_550_3)
								local var_550_6 = Mathf.Lerp(iter_550_1.color.b, arg_547_1.hightColor2.b, var_550_3)

								iter_550_1.color = Color.New(var_550_4, var_550_5, var_550_6)
							else
								local var_550_7 = Mathf.Lerp(iter_550_1.color.r, 0.5, var_550_3)

								iter_550_1.color = Color.New(var_550_7, var_550_7, var_550_7)
							end
						end
					end
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.actorSpriteComps10111 then
				for iter_550_2, iter_550_3 in pairs(arg_547_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_550_3 then
						if arg_547_1.isInRecall_ then
							iter_550_3.color = arg_547_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_550_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_547_1.var_.actorSpriteComps10111 = nil
			end

			local var_550_8 = arg_547_1.actors_["10111"].transform
			local var_550_9 = 0

			if var_550_9 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 then
				arg_547_1.var_.moveOldPos10111 = var_550_8.localPosition
				var_550_8.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10111", 7)

				local var_550_10 = var_550_8.childCount

				for iter_550_4 = 0, var_550_10 - 1 do
					local var_550_11 = var_550_8:GetChild(iter_550_4)

					if var_550_11.name == "" or not string.find(var_550_11.name, "split") then
						var_550_11.gameObject:SetActive(true)
					else
						var_550_11.gameObject:SetActive(false)
					end
				end
			end

			local var_550_12 = 0.001

			if var_550_9 <= arg_547_1.time_ and arg_547_1.time_ < var_550_9 + var_550_12 then
				local var_550_13 = (arg_547_1.time_ - var_550_9) / var_550_12
				local var_550_14 = Vector3.New(0, -2000, 0)

				var_550_8.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10111, var_550_14, var_550_13)
			end

			if arg_547_1.time_ >= var_550_9 + var_550_12 and arg_547_1.time_ < var_550_9 + var_550_12 + arg_550_0 then
				var_550_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_550_15 = arg_547_1.actors_["10115"].transform
			local var_550_16 = 0

			if var_550_16 < arg_547_1.time_ and arg_547_1.time_ <= var_550_16 + arg_550_0 then
				arg_547_1.var_.moveOldPos10115 = var_550_15.localPosition
				var_550_15.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10115", 7)

				local var_550_17 = var_550_15.childCount

				for iter_550_5 = 0, var_550_17 - 1 do
					local var_550_18 = var_550_15:GetChild(iter_550_5)

					if var_550_18.name == "" or not string.find(var_550_18.name, "split") then
						var_550_18.gameObject:SetActive(true)
					else
						var_550_18.gameObject:SetActive(false)
					end
				end
			end

			local var_550_19 = 0.001

			if var_550_16 <= arg_547_1.time_ and arg_547_1.time_ < var_550_16 + var_550_19 then
				local var_550_20 = (arg_547_1.time_ - var_550_16) / var_550_19
				local var_550_21 = Vector3.New(0, -2000, 0)

				var_550_15.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10115, var_550_21, var_550_20)
			end

			if arg_547_1.time_ >= var_550_16 + var_550_19 and arg_547_1.time_ < var_550_16 + var_550_19 + arg_550_0 then
				var_550_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_550_22 = 0.2
			local var_550_23 = 1

			if var_550_22 < arg_547_1.time_ and arg_547_1.time_ <= var_550_22 + arg_550_0 then
				local var_550_24 = "play"
				local var_550_25 = "effect"

				arg_547_1:AudioAction(var_550_24, var_550_25, "se_story_1310", "se_story_1310_car01", "")
			end

			local var_550_26 = 0
			local var_550_27 = 1.55

			if var_550_26 < arg_547_1.time_ and arg_547_1.time_ <= var_550_26 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_28 = arg_547_1:GetWordFromCfg(417241129)
				local var_550_29 = arg_547_1:FormatText(var_550_28.content)

				arg_547_1.text_.text = var_550_29

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_30 = 62
				local var_550_31 = utf8.len(var_550_29)
				local var_550_32 = var_550_30 <= 0 and var_550_27 or var_550_27 * (var_550_31 / var_550_30)

				if var_550_32 > 0 and var_550_27 < var_550_32 then
					arg_547_1.talkMaxDuration = var_550_32

					if var_550_32 + var_550_26 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_32 + var_550_26
					end
				end

				arg_547_1.text_.text = var_550_29
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_33 = math.max(var_550_27, arg_547_1.talkMaxDuration)

			if var_550_26 <= arg_547_1.time_ and arg_547_1.time_ < var_550_26 + var_550_33 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_26) / var_550_33

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_26 + var_550_33 and arg_547_1.time_ < var_550_26 + var_550_33 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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

		arg_547_1:InitPlayNodeList()
	end,
	Play417241130 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 417241130
		arg_551_1.duration_ = 7.57

		local var_551_0 = {
			zh = 4.166,
			ja = 7.566
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play417241131(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["10115"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.actorSpriteComps10115 == nil then
				arg_551_1.var_.actorSpriteComps10115 = var_554_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_554_2 = 0.2

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.actorSpriteComps10115 then
					for iter_554_0, iter_554_1 in pairs(arg_551_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_554_1 then
							if arg_551_1.isInRecall_ then
								local var_554_4 = Mathf.Lerp(iter_554_1.color.r, arg_551_1.hightColor1.r, var_554_3)
								local var_554_5 = Mathf.Lerp(iter_554_1.color.g, arg_551_1.hightColor1.g, var_554_3)
								local var_554_6 = Mathf.Lerp(iter_554_1.color.b, arg_551_1.hightColor1.b, var_554_3)

								iter_554_1.color = Color.New(var_554_4, var_554_5, var_554_6)
							else
								local var_554_7 = Mathf.Lerp(iter_554_1.color.r, 1, var_554_3)

								iter_554_1.color = Color.New(var_554_7, var_554_7, var_554_7)
							end
						end
					end
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.actorSpriteComps10115 then
				for iter_554_2, iter_554_3 in pairs(arg_551_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_554_3 then
						if arg_551_1.isInRecall_ then
							iter_554_3.color = arg_551_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_554_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_551_1.var_.actorSpriteComps10115 = nil
			end

			local var_554_8 = arg_551_1.actors_["10115"].transform
			local var_554_9 = 0

			if var_554_9 < arg_551_1.time_ and arg_551_1.time_ <= var_554_9 + arg_554_0 then
				arg_551_1.var_.moveOldPos10115 = var_554_8.localPosition
				var_554_8.localScale = Vector3.New(1, 1, 1)

				arg_551_1:CheckSpriteTmpPos("10115", 3)

				local var_554_10 = var_554_8.childCount

				for iter_554_4 = 0, var_554_10 - 1 do
					local var_554_11 = var_554_8:GetChild(iter_554_4)

					if var_554_11.name == "split_2" or not string.find(var_554_11.name, "split") then
						var_554_11.gameObject:SetActive(true)
					else
						var_554_11.gameObject:SetActive(false)
					end
				end
			end

			local var_554_12 = 0.001

			if var_554_9 <= arg_551_1.time_ and arg_551_1.time_ < var_554_9 + var_554_12 then
				local var_554_13 = (arg_551_1.time_ - var_554_9) / var_554_12
				local var_554_14 = Vector3.New(0, -387.3, -246.2)

				var_554_8.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos10115, var_554_14, var_554_13)
			end

			if arg_551_1.time_ >= var_554_9 + var_554_12 and arg_551_1.time_ < var_554_9 + var_554_12 + arg_554_0 then
				var_554_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_554_15 = 0
			local var_554_16 = 0.5

			if var_554_15 < arg_551_1.time_ and arg_551_1.time_ <= var_554_15 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_17 = arg_551_1:FormatText(StoryNameCfg[1113].name)

				arg_551_1.leftNameTxt_.text = var_554_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_18 = arg_551_1:GetWordFromCfg(417241130)
				local var_554_19 = arg_551_1:FormatText(var_554_18.content)

				arg_551_1.text_.text = var_554_19

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_20 = 20
				local var_554_21 = utf8.len(var_554_19)
				local var_554_22 = var_554_20 <= 0 and var_554_16 or var_554_16 * (var_554_21 / var_554_20)

				if var_554_22 > 0 and var_554_16 < var_554_22 then
					arg_551_1.talkMaxDuration = var_554_22

					if var_554_22 + var_554_15 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_22 + var_554_15
					end
				end

				arg_551_1.text_.text = var_554_19
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241130", "story_v_out_417241.awb") ~= 0 then
					local var_554_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241130", "story_v_out_417241.awb") / 1000

					if var_554_23 + var_554_15 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_23 + var_554_15
					end

					if var_554_18.prefab_name ~= "" and arg_551_1.actors_[var_554_18.prefab_name] ~= nil then
						local var_554_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_18.prefab_name].transform, "story_v_out_417241", "417241130", "story_v_out_417241.awb")

						arg_551_1:RecordAudio("417241130", var_554_24)
						arg_551_1:RecordAudio("417241130", var_554_24)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_417241", "417241130", "story_v_out_417241.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_417241", "417241130", "story_v_out_417241.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_25 = math.max(var_554_16, arg_551_1.talkMaxDuration)

			if var_554_15 <= arg_551_1.time_ and arg_551_1.time_ < var_554_15 + var_554_25 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_15) / var_554_25

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_15 + var_554_25 and arg_551_1.time_ < var_554_15 + var_554_25 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
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

		arg_551_1:InitPlayNodeList()
	end,
	Play417241131 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 417241131
		arg_555_1.duration_ = 3.3

		local var_555_0 = {
			zh = 2.466,
			ja = 3.3
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play417241132(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1034"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.actorSpriteComps1034 == nil then
				arg_555_1.var_.actorSpriteComps1034 = var_558_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_2 = 0.2

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.actorSpriteComps1034 then
					for iter_558_0, iter_558_1 in pairs(arg_555_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_558_1 then
							if arg_555_1.isInRecall_ then
								local var_558_4 = Mathf.Lerp(iter_558_1.color.r, arg_555_1.hightColor1.r, var_558_3)
								local var_558_5 = Mathf.Lerp(iter_558_1.color.g, arg_555_1.hightColor1.g, var_558_3)
								local var_558_6 = Mathf.Lerp(iter_558_1.color.b, arg_555_1.hightColor1.b, var_558_3)

								iter_558_1.color = Color.New(var_558_4, var_558_5, var_558_6)
							else
								local var_558_7 = Mathf.Lerp(iter_558_1.color.r, 1, var_558_3)

								iter_558_1.color = Color.New(var_558_7, var_558_7, var_558_7)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.actorSpriteComps1034 then
				for iter_558_2, iter_558_3 in pairs(arg_555_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_558_3 then
						if arg_555_1.isInRecall_ then
							iter_558_3.color = arg_555_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_558_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_555_1.var_.actorSpriteComps1034 = nil
			end

			local var_558_8 = arg_555_1.actors_["10115"]
			local var_558_9 = 0

			if var_558_9 < arg_555_1.time_ and arg_555_1.time_ <= var_558_9 + arg_558_0 and not isNil(var_558_8) and arg_555_1.var_.actorSpriteComps10115 == nil then
				arg_555_1.var_.actorSpriteComps10115 = var_558_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_10 = 0.2

			if var_558_9 <= arg_555_1.time_ and arg_555_1.time_ < var_558_9 + var_558_10 and not isNil(var_558_8) then
				local var_558_11 = (arg_555_1.time_ - var_558_9) / var_558_10

				if arg_555_1.var_.actorSpriteComps10115 then
					for iter_558_4, iter_558_5 in pairs(arg_555_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_558_5 then
							if arg_555_1.isInRecall_ then
								local var_558_12 = Mathf.Lerp(iter_558_5.color.r, arg_555_1.hightColor2.r, var_558_11)
								local var_558_13 = Mathf.Lerp(iter_558_5.color.g, arg_555_1.hightColor2.g, var_558_11)
								local var_558_14 = Mathf.Lerp(iter_558_5.color.b, arg_555_1.hightColor2.b, var_558_11)

								iter_558_5.color = Color.New(var_558_12, var_558_13, var_558_14)
							else
								local var_558_15 = Mathf.Lerp(iter_558_5.color.r, 0.5, var_558_11)

								iter_558_5.color = Color.New(var_558_15, var_558_15, var_558_15)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= var_558_9 + var_558_10 and arg_555_1.time_ < var_558_9 + var_558_10 + arg_558_0 and not isNil(var_558_8) and arg_555_1.var_.actorSpriteComps10115 then
				for iter_558_6, iter_558_7 in pairs(arg_555_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_558_7 then
						if arg_555_1.isInRecall_ then
							iter_558_7.color = arg_555_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_558_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_555_1.var_.actorSpriteComps10115 = nil
			end

			local var_558_16 = arg_555_1.actors_["1034"].transform
			local var_558_17 = 0

			if var_558_17 < arg_555_1.time_ and arg_555_1.time_ <= var_558_17 + arg_558_0 then
				arg_555_1.var_.moveOldPos1034 = var_558_16.localPosition
				var_558_16.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("1034", 4)

				local var_558_18 = var_558_16.childCount

				for iter_558_8 = 0, var_558_18 - 1 do
					local var_558_19 = var_558_16:GetChild(iter_558_8)

					if var_558_19.name == "split_6" or not string.find(var_558_19.name, "split") then
						var_558_19.gameObject:SetActive(true)
					else
						var_558_19.gameObject:SetActive(false)
					end
				end
			end

			local var_558_20 = 0.001

			if var_558_17 <= arg_555_1.time_ and arg_555_1.time_ < var_558_17 + var_558_20 then
				local var_558_21 = (arg_555_1.time_ - var_558_17) / var_558_20
				local var_558_22 = Vector3.New(373.7, -331.9, -324)

				var_558_16.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1034, var_558_22, var_558_21)
			end

			if arg_555_1.time_ >= var_558_17 + var_558_20 and arg_555_1.time_ < var_558_17 + var_558_20 + arg_558_0 then
				var_558_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_558_23 = arg_555_1.actors_["10115"].transform
			local var_558_24 = 0

			if var_558_24 < arg_555_1.time_ and arg_555_1.time_ <= var_558_24 + arg_558_0 then
				arg_555_1.var_.moveOldPos10115 = var_558_23.localPosition
				var_558_23.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("10115", 2)

				local var_558_25 = var_558_23.childCount

				for iter_558_9 = 0, var_558_25 - 1 do
					local var_558_26 = var_558_23:GetChild(iter_558_9)

					if var_558_26.name == "split_2" or not string.find(var_558_26.name, "split") then
						var_558_26.gameObject:SetActive(true)
					else
						var_558_26.gameObject:SetActive(false)
					end
				end
			end

			local var_558_27 = 0.001

			if var_558_24 <= arg_555_1.time_ and arg_555_1.time_ < var_558_24 + var_558_27 then
				local var_558_28 = (arg_555_1.time_ - var_558_24) / var_558_27
				local var_558_29 = Vector3.New(-390, -387.3, -246.2)

				var_558_23.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10115, var_558_29, var_558_28)
			end

			if arg_555_1.time_ >= var_558_24 + var_558_27 and arg_555_1.time_ < var_558_24 + var_558_27 + arg_558_0 then
				var_558_23.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_558_30 = 0
			local var_558_31 = 0.325

			if var_558_30 < arg_555_1.time_ and arg_555_1.time_ <= var_558_30 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_32 = arg_555_1:FormatText(StoryNameCfg[1109].name)

				arg_555_1.leftNameTxt_.text = var_558_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_33 = arg_555_1:GetWordFromCfg(417241131)
				local var_558_34 = arg_555_1:FormatText(var_558_33.content)

				arg_555_1.text_.text = var_558_34

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_35 = 13
				local var_558_36 = utf8.len(var_558_34)
				local var_558_37 = var_558_35 <= 0 and var_558_31 or var_558_31 * (var_558_36 / var_558_35)

				if var_558_37 > 0 and var_558_31 < var_558_37 then
					arg_555_1.talkMaxDuration = var_558_37

					if var_558_37 + var_558_30 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_37 + var_558_30
					end
				end

				arg_555_1.text_.text = var_558_34
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241131", "story_v_out_417241.awb") ~= 0 then
					local var_558_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241131", "story_v_out_417241.awb") / 1000

					if var_558_38 + var_558_30 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_38 + var_558_30
					end

					if var_558_33.prefab_name ~= "" and arg_555_1.actors_[var_558_33.prefab_name] ~= nil then
						local var_558_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_33.prefab_name].transform, "story_v_out_417241", "417241131", "story_v_out_417241.awb")

						arg_555_1:RecordAudio("417241131", var_558_39)
						arg_555_1:RecordAudio("417241131", var_558_39)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_417241", "417241131", "story_v_out_417241.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_417241", "417241131", "story_v_out_417241.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_40 = math.max(var_558_31, arg_555_1.talkMaxDuration)

			if var_558_30 <= arg_555_1.time_ and arg_555_1.time_ < var_558_30 + var_558_40 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_30) / var_558_40

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_30 + var_558_40 and arg_555_1.time_ < var_558_30 + var_558_40 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
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

		arg_555_1:InitPlayNodeList()
	end,
	Play417241132 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 417241132
		arg_559_1.duration_ = 6.6

		local var_559_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play417241133(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.675

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[1109].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(417241132)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 27
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241132", "story_v_out_417241.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241132", "story_v_out_417241.awb") / 1000

					if var_562_8 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_0
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_out_417241", "417241132", "story_v_out_417241.awb")

						arg_559_1:RecordAudio("417241132", var_562_9)
						arg_559_1:RecordAudio("417241132", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_417241", "417241132", "story_v_out_417241.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_417241", "417241132", "story_v_out_417241.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_10 and arg_559_1.time_ < var_562_0 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play417241133 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 417241133
		arg_563_1.duration_ = 6.33

		local var_563_0 = {
			zh = 4.233,
			ja = 6.333
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play417241134(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["10115"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.actorSpriteComps10115 == nil then
				arg_563_1.var_.actorSpriteComps10115 = var_566_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_2 = 0.2

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.actorSpriteComps10115 then
					for iter_566_0, iter_566_1 in pairs(arg_563_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_566_1 then
							if arg_563_1.isInRecall_ then
								local var_566_4 = Mathf.Lerp(iter_566_1.color.r, arg_563_1.hightColor1.r, var_566_3)
								local var_566_5 = Mathf.Lerp(iter_566_1.color.g, arg_563_1.hightColor1.g, var_566_3)
								local var_566_6 = Mathf.Lerp(iter_566_1.color.b, arg_563_1.hightColor1.b, var_566_3)

								iter_566_1.color = Color.New(var_566_4, var_566_5, var_566_6)
							else
								local var_566_7 = Mathf.Lerp(iter_566_1.color.r, 1, var_566_3)

								iter_566_1.color = Color.New(var_566_7, var_566_7, var_566_7)
							end
						end
					end
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.actorSpriteComps10115 then
				for iter_566_2, iter_566_3 in pairs(arg_563_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_566_3 then
						if arg_563_1.isInRecall_ then
							iter_566_3.color = arg_563_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_566_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_563_1.var_.actorSpriteComps10115 = nil
			end

			local var_566_8 = arg_563_1.actors_["1034"]
			local var_566_9 = 0

			if var_566_9 < arg_563_1.time_ and arg_563_1.time_ <= var_566_9 + arg_566_0 and not isNil(var_566_8) and arg_563_1.var_.actorSpriteComps1034 == nil then
				arg_563_1.var_.actorSpriteComps1034 = var_566_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_10 = 0.2

			if var_566_9 <= arg_563_1.time_ and arg_563_1.time_ < var_566_9 + var_566_10 and not isNil(var_566_8) then
				local var_566_11 = (arg_563_1.time_ - var_566_9) / var_566_10

				if arg_563_1.var_.actorSpriteComps1034 then
					for iter_566_4, iter_566_5 in pairs(arg_563_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_566_5 then
							if arg_563_1.isInRecall_ then
								local var_566_12 = Mathf.Lerp(iter_566_5.color.r, arg_563_1.hightColor2.r, var_566_11)
								local var_566_13 = Mathf.Lerp(iter_566_5.color.g, arg_563_1.hightColor2.g, var_566_11)
								local var_566_14 = Mathf.Lerp(iter_566_5.color.b, arg_563_1.hightColor2.b, var_566_11)

								iter_566_5.color = Color.New(var_566_12, var_566_13, var_566_14)
							else
								local var_566_15 = Mathf.Lerp(iter_566_5.color.r, 0.5, var_566_11)

								iter_566_5.color = Color.New(var_566_15, var_566_15, var_566_15)
							end
						end
					end
				end
			end

			if arg_563_1.time_ >= var_566_9 + var_566_10 and arg_563_1.time_ < var_566_9 + var_566_10 + arg_566_0 and not isNil(var_566_8) and arg_563_1.var_.actorSpriteComps1034 then
				for iter_566_6, iter_566_7 in pairs(arg_563_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_566_7 then
						if arg_563_1.isInRecall_ then
							iter_566_7.color = arg_563_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_566_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_563_1.var_.actorSpriteComps1034 = nil
			end

			local var_566_16 = arg_563_1.actors_["10115"].transform
			local var_566_17 = 0

			if var_566_17 < arg_563_1.time_ and arg_563_1.time_ <= var_566_17 + arg_566_0 then
				arg_563_1.var_.moveOldPos10115 = var_566_16.localPosition
				var_566_16.localScale = Vector3.New(1, 1, 1)

				arg_563_1:CheckSpriteTmpPos("10115", 2)

				local var_566_18 = var_566_16.childCount

				for iter_566_8 = 0, var_566_18 - 1 do
					local var_566_19 = var_566_16:GetChild(iter_566_8)

					if var_566_19.name == "split_6" or not string.find(var_566_19.name, "split") then
						var_566_19.gameObject:SetActive(true)
					else
						var_566_19.gameObject:SetActive(false)
					end
				end
			end

			local var_566_20 = 0.001

			if var_566_17 <= arg_563_1.time_ and arg_563_1.time_ < var_566_17 + var_566_20 then
				local var_566_21 = (arg_563_1.time_ - var_566_17) / var_566_20
				local var_566_22 = Vector3.New(-390, -387.3, -246.2)

				var_566_16.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos10115, var_566_22, var_566_21)
			end

			if arg_563_1.time_ >= var_566_17 + var_566_20 and arg_563_1.time_ < var_566_17 + var_566_20 + arg_566_0 then
				var_566_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_566_23 = 0
			local var_566_24 = 0.575

			if var_566_23 < arg_563_1.time_ and arg_563_1.time_ <= var_566_23 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_25 = arg_563_1:FormatText(StoryNameCfg[1113].name)

				arg_563_1.leftNameTxt_.text = var_566_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_26 = arg_563_1:GetWordFromCfg(417241133)
				local var_566_27 = arg_563_1:FormatText(var_566_26.content)

				arg_563_1.text_.text = var_566_27

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_28 = 23
				local var_566_29 = utf8.len(var_566_27)
				local var_566_30 = var_566_28 <= 0 and var_566_24 or var_566_24 * (var_566_29 / var_566_28)

				if var_566_30 > 0 and var_566_24 < var_566_30 then
					arg_563_1.talkMaxDuration = var_566_30

					if var_566_30 + var_566_23 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_30 + var_566_23
					end
				end

				arg_563_1.text_.text = var_566_27
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241133", "story_v_out_417241.awb") ~= 0 then
					local var_566_31 = manager.audio:GetVoiceLength("story_v_out_417241", "417241133", "story_v_out_417241.awb") / 1000

					if var_566_31 + var_566_23 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_31 + var_566_23
					end

					if var_566_26.prefab_name ~= "" and arg_563_1.actors_[var_566_26.prefab_name] ~= nil then
						local var_566_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_26.prefab_name].transform, "story_v_out_417241", "417241133", "story_v_out_417241.awb")

						arg_563_1:RecordAudio("417241133", var_566_32)
						arg_563_1:RecordAudio("417241133", var_566_32)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_417241", "417241133", "story_v_out_417241.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_417241", "417241133", "story_v_out_417241.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_33 = math.max(var_566_24, arg_563_1.talkMaxDuration)

			if var_566_23 <= arg_563_1.time_ and arg_563_1.time_ < var_566_23 + var_566_33 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_23) / var_566_33

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_23 + var_566_33 and arg_563_1.time_ < var_566_23 + var_566_33 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
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

		arg_563_1:InitPlayNodeList()
	end,
	Play417241134 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 417241134
		arg_567_1.duration_ = 8.7

		local var_567_0 = {
			zh = 5.433,
			ja = 8.7
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play417241135(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1034"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.actorSpriteComps1034 == nil then
				arg_567_1.var_.actorSpriteComps1034 = var_570_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_2 = 0.2

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 and not isNil(var_570_0) then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.actorSpriteComps1034 then
					for iter_570_0, iter_570_1 in pairs(arg_567_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_570_1 then
							if arg_567_1.isInRecall_ then
								local var_570_4 = Mathf.Lerp(iter_570_1.color.r, arg_567_1.hightColor1.r, var_570_3)
								local var_570_5 = Mathf.Lerp(iter_570_1.color.g, arg_567_1.hightColor1.g, var_570_3)
								local var_570_6 = Mathf.Lerp(iter_570_1.color.b, arg_567_1.hightColor1.b, var_570_3)

								iter_570_1.color = Color.New(var_570_4, var_570_5, var_570_6)
							else
								local var_570_7 = Mathf.Lerp(iter_570_1.color.r, 1, var_570_3)

								iter_570_1.color = Color.New(var_570_7, var_570_7, var_570_7)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.actorSpriteComps1034 then
				for iter_570_2, iter_570_3 in pairs(arg_567_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_570_3 then
						if arg_567_1.isInRecall_ then
							iter_570_3.color = arg_567_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_570_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_567_1.var_.actorSpriteComps1034 = nil
			end

			local var_570_8 = arg_567_1.actors_["10115"]
			local var_570_9 = 0

			if var_570_9 < arg_567_1.time_ and arg_567_1.time_ <= var_570_9 + arg_570_0 and not isNil(var_570_8) and arg_567_1.var_.actorSpriteComps10115 == nil then
				arg_567_1.var_.actorSpriteComps10115 = var_570_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_10 = 0.2

			if var_570_9 <= arg_567_1.time_ and arg_567_1.time_ < var_570_9 + var_570_10 and not isNil(var_570_8) then
				local var_570_11 = (arg_567_1.time_ - var_570_9) / var_570_10

				if arg_567_1.var_.actorSpriteComps10115 then
					for iter_570_4, iter_570_5 in pairs(arg_567_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_570_5 then
							if arg_567_1.isInRecall_ then
								local var_570_12 = Mathf.Lerp(iter_570_5.color.r, arg_567_1.hightColor2.r, var_570_11)
								local var_570_13 = Mathf.Lerp(iter_570_5.color.g, arg_567_1.hightColor2.g, var_570_11)
								local var_570_14 = Mathf.Lerp(iter_570_5.color.b, arg_567_1.hightColor2.b, var_570_11)

								iter_570_5.color = Color.New(var_570_12, var_570_13, var_570_14)
							else
								local var_570_15 = Mathf.Lerp(iter_570_5.color.r, 0.5, var_570_11)

								iter_570_5.color = Color.New(var_570_15, var_570_15, var_570_15)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= var_570_9 + var_570_10 and arg_567_1.time_ < var_570_9 + var_570_10 + arg_570_0 and not isNil(var_570_8) and arg_567_1.var_.actorSpriteComps10115 then
				for iter_570_6, iter_570_7 in pairs(arg_567_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_570_7 then
						if arg_567_1.isInRecall_ then
							iter_570_7.color = arg_567_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_570_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_567_1.var_.actorSpriteComps10115 = nil
			end

			local var_570_16 = 0
			local var_570_17 = 0.7

			if var_570_16 < arg_567_1.time_ and arg_567_1.time_ <= var_570_16 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_18 = arg_567_1:FormatText(StoryNameCfg[1109].name)

				arg_567_1.leftNameTxt_.text = var_570_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_19 = arg_567_1:GetWordFromCfg(417241134)
				local var_570_20 = arg_567_1:FormatText(var_570_19.content)

				arg_567_1.text_.text = var_570_20

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_21 = 28
				local var_570_22 = utf8.len(var_570_20)
				local var_570_23 = var_570_21 <= 0 and var_570_17 or var_570_17 * (var_570_22 / var_570_21)

				if var_570_23 > 0 and var_570_17 < var_570_23 then
					arg_567_1.talkMaxDuration = var_570_23

					if var_570_23 + var_570_16 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_23 + var_570_16
					end
				end

				arg_567_1.text_.text = var_570_20
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241134", "story_v_out_417241.awb") ~= 0 then
					local var_570_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241134", "story_v_out_417241.awb") / 1000

					if var_570_24 + var_570_16 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_24 + var_570_16
					end

					if var_570_19.prefab_name ~= "" and arg_567_1.actors_[var_570_19.prefab_name] ~= nil then
						local var_570_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_19.prefab_name].transform, "story_v_out_417241", "417241134", "story_v_out_417241.awb")

						arg_567_1:RecordAudio("417241134", var_570_25)
						arg_567_1:RecordAudio("417241134", var_570_25)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_417241", "417241134", "story_v_out_417241.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_417241", "417241134", "story_v_out_417241.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_26 = math.max(var_570_17, arg_567_1.talkMaxDuration)

			if var_570_16 <= arg_567_1.time_ and arg_567_1.time_ < var_570_16 + var_570_26 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_16) / var_570_26

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_16 + var_570_26 and arg_567_1.time_ < var_570_16 + var_570_26 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play417241135 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 417241135
		arg_571_1.duration_ = 8.03

		local var_571_0 = {
			zh = 8,
			ja = 8.033
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play417241136(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["10115"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.actorSpriteComps10115 == nil then
				arg_571_1.var_.actorSpriteComps10115 = var_574_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_574_2 = 0.2

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.actorSpriteComps10115 then
					for iter_574_0, iter_574_1 in pairs(arg_571_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_574_1 then
							if arg_571_1.isInRecall_ then
								local var_574_4 = Mathf.Lerp(iter_574_1.color.r, arg_571_1.hightColor1.r, var_574_3)
								local var_574_5 = Mathf.Lerp(iter_574_1.color.g, arg_571_1.hightColor1.g, var_574_3)
								local var_574_6 = Mathf.Lerp(iter_574_1.color.b, arg_571_1.hightColor1.b, var_574_3)

								iter_574_1.color = Color.New(var_574_4, var_574_5, var_574_6)
							else
								local var_574_7 = Mathf.Lerp(iter_574_1.color.r, 1, var_574_3)

								iter_574_1.color = Color.New(var_574_7, var_574_7, var_574_7)
							end
						end
					end
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.actorSpriteComps10115 then
				for iter_574_2, iter_574_3 in pairs(arg_571_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_574_3 then
						if arg_571_1.isInRecall_ then
							iter_574_3.color = arg_571_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_574_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_571_1.var_.actorSpriteComps10115 = nil
			end

			local var_574_8 = arg_571_1.actors_["1034"]
			local var_574_9 = 0

			if var_574_9 < arg_571_1.time_ and arg_571_1.time_ <= var_574_9 + arg_574_0 and not isNil(var_574_8) and arg_571_1.var_.actorSpriteComps1034 == nil then
				arg_571_1.var_.actorSpriteComps1034 = var_574_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_574_10 = 0.2

			if var_574_9 <= arg_571_1.time_ and arg_571_1.time_ < var_574_9 + var_574_10 and not isNil(var_574_8) then
				local var_574_11 = (arg_571_1.time_ - var_574_9) / var_574_10

				if arg_571_1.var_.actorSpriteComps1034 then
					for iter_574_4, iter_574_5 in pairs(arg_571_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_574_5 then
							if arg_571_1.isInRecall_ then
								local var_574_12 = Mathf.Lerp(iter_574_5.color.r, arg_571_1.hightColor2.r, var_574_11)
								local var_574_13 = Mathf.Lerp(iter_574_5.color.g, arg_571_1.hightColor2.g, var_574_11)
								local var_574_14 = Mathf.Lerp(iter_574_5.color.b, arg_571_1.hightColor2.b, var_574_11)

								iter_574_5.color = Color.New(var_574_12, var_574_13, var_574_14)
							else
								local var_574_15 = Mathf.Lerp(iter_574_5.color.r, 0.5, var_574_11)

								iter_574_5.color = Color.New(var_574_15, var_574_15, var_574_15)
							end
						end
					end
				end
			end

			if arg_571_1.time_ >= var_574_9 + var_574_10 and arg_571_1.time_ < var_574_9 + var_574_10 + arg_574_0 and not isNil(var_574_8) and arg_571_1.var_.actorSpriteComps1034 then
				for iter_574_6, iter_574_7 in pairs(arg_571_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_574_7 then
						if arg_571_1.isInRecall_ then
							iter_574_7.color = arg_571_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_574_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_571_1.var_.actorSpriteComps1034 = nil
			end

			local var_574_16 = 0
			local var_574_17 = 0.575

			if var_574_16 < arg_571_1.time_ and arg_571_1.time_ <= var_574_16 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_18 = arg_571_1:FormatText(StoryNameCfg[1113].name)

				arg_571_1.leftNameTxt_.text = var_574_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_19 = arg_571_1:GetWordFromCfg(417241135)
				local var_574_20 = arg_571_1:FormatText(var_574_19.content)

				arg_571_1.text_.text = var_574_20

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_21 = 23
				local var_574_22 = utf8.len(var_574_20)
				local var_574_23 = var_574_21 <= 0 and var_574_17 or var_574_17 * (var_574_22 / var_574_21)

				if var_574_23 > 0 and var_574_17 < var_574_23 then
					arg_571_1.talkMaxDuration = var_574_23

					if var_574_23 + var_574_16 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_23 + var_574_16
					end
				end

				arg_571_1.text_.text = var_574_20
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241135", "story_v_out_417241.awb") ~= 0 then
					local var_574_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241135", "story_v_out_417241.awb") / 1000

					if var_574_24 + var_574_16 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_24 + var_574_16
					end

					if var_574_19.prefab_name ~= "" and arg_571_1.actors_[var_574_19.prefab_name] ~= nil then
						local var_574_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_19.prefab_name].transform, "story_v_out_417241", "417241135", "story_v_out_417241.awb")

						arg_571_1:RecordAudio("417241135", var_574_25)
						arg_571_1:RecordAudio("417241135", var_574_25)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_417241", "417241135", "story_v_out_417241.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_417241", "417241135", "story_v_out_417241.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_26 = math.max(var_574_17, arg_571_1.talkMaxDuration)

			if var_574_16 <= arg_571_1.time_ and arg_571_1.time_ < var_574_16 + var_574_26 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_16) / var_574_26

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_16 + var_574_26 and arg_571_1.time_ < var_574_16 + var_574_26 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play417241136 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 417241136
		arg_575_1.duration_ = 6.43

		local var_575_0 = {
			zh = 4.1,
			ja = 6.433
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play417241137(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.375

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[1113].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_3 = arg_575_1:GetWordFromCfg(417241136)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 15
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241136", "story_v_out_417241.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241136", "story_v_out_417241.awb") / 1000

					if var_578_8 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_0
					end

					if var_578_3.prefab_name ~= "" and arg_575_1.actors_[var_578_3.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_3.prefab_name].transform, "story_v_out_417241", "417241136", "story_v_out_417241.awb")

						arg_575_1:RecordAudio("417241136", var_578_9)
						arg_575_1:RecordAudio("417241136", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_417241", "417241136", "story_v_out_417241.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_417241", "417241136", "story_v_out_417241.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_10 and arg_575_1.time_ < var_578_0 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play417241137 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 417241137
		arg_579_1.duration_ = 4.5

		local var_579_0 = {
			zh = 4.066,
			ja = 4.5
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play417241138(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["1034"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.actorSpriteComps1034 == nil then
				arg_579_1.var_.actorSpriteComps1034 = var_582_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_2 = 0.2

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 and not isNil(var_582_0) then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.actorSpriteComps1034 then
					for iter_582_0, iter_582_1 in pairs(arg_579_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_582_1 then
							if arg_579_1.isInRecall_ then
								local var_582_4 = Mathf.Lerp(iter_582_1.color.r, arg_579_1.hightColor1.r, var_582_3)
								local var_582_5 = Mathf.Lerp(iter_582_1.color.g, arg_579_1.hightColor1.g, var_582_3)
								local var_582_6 = Mathf.Lerp(iter_582_1.color.b, arg_579_1.hightColor1.b, var_582_3)

								iter_582_1.color = Color.New(var_582_4, var_582_5, var_582_6)
							else
								local var_582_7 = Mathf.Lerp(iter_582_1.color.r, 1, var_582_3)

								iter_582_1.color = Color.New(var_582_7, var_582_7, var_582_7)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.actorSpriteComps1034 then
				for iter_582_2, iter_582_3 in pairs(arg_579_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_582_3 then
						if arg_579_1.isInRecall_ then
							iter_582_3.color = arg_579_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_582_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_579_1.var_.actorSpriteComps1034 = nil
			end

			local var_582_8 = arg_579_1.actors_["10115"]
			local var_582_9 = 0

			if var_582_9 < arg_579_1.time_ and arg_579_1.time_ <= var_582_9 + arg_582_0 and not isNil(var_582_8) and arg_579_1.var_.actorSpriteComps10115 == nil then
				arg_579_1.var_.actorSpriteComps10115 = var_582_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_10 = 0.2

			if var_582_9 <= arg_579_1.time_ and arg_579_1.time_ < var_582_9 + var_582_10 and not isNil(var_582_8) then
				local var_582_11 = (arg_579_1.time_ - var_582_9) / var_582_10

				if arg_579_1.var_.actorSpriteComps10115 then
					for iter_582_4, iter_582_5 in pairs(arg_579_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_582_5 then
							if arg_579_1.isInRecall_ then
								local var_582_12 = Mathf.Lerp(iter_582_5.color.r, arg_579_1.hightColor2.r, var_582_11)
								local var_582_13 = Mathf.Lerp(iter_582_5.color.g, arg_579_1.hightColor2.g, var_582_11)
								local var_582_14 = Mathf.Lerp(iter_582_5.color.b, arg_579_1.hightColor2.b, var_582_11)

								iter_582_5.color = Color.New(var_582_12, var_582_13, var_582_14)
							else
								local var_582_15 = Mathf.Lerp(iter_582_5.color.r, 0.5, var_582_11)

								iter_582_5.color = Color.New(var_582_15, var_582_15, var_582_15)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= var_582_9 + var_582_10 and arg_579_1.time_ < var_582_9 + var_582_10 + arg_582_0 and not isNil(var_582_8) and arg_579_1.var_.actorSpriteComps10115 then
				for iter_582_6, iter_582_7 in pairs(arg_579_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_582_7 then
						if arg_579_1.isInRecall_ then
							iter_582_7.color = arg_579_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_582_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_579_1.var_.actorSpriteComps10115 = nil
			end

			local var_582_16 = 0
			local var_582_17 = 0.5

			if var_582_16 < arg_579_1.time_ and arg_579_1.time_ <= var_582_16 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_18 = arg_579_1:FormatText(StoryNameCfg[1109].name)

				arg_579_1.leftNameTxt_.text = var_582_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_19 = arg_579_1:GetWordFromCfg(417241137)
				local var_582_20 = arg_579_1:FormatText(var_582_19.content)

				arg_579_1.text_.text = var_582_20

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_21 = 20
				local var_582_22 = utf8.len(var_582_20)
				local var_582_23 = var_582_21 <= 0 and var_582_17 or var_582_17 * (var_582_22 / var_582_21)

				if var_582_23 > 0 and var_582_17 < var_582_23 then
					arg_579_1.talkMaxDuration = var_582_23

					if var_582_23 + var_582_16 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_23 + var_582_16
					end
				end

				arg_579_1.text_.text = var_582_20
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241137", "story_v_out_417241.awb") ~= 0 then
					local var_582_24 = manager.audio:GetVoiceLength("story_v_out_417241", "417241137", "story_v_out_417241.awb") / 1000

					if var_582_24 + var_582_16 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_24 + var_582_16
					end

					if var_582_19.prefab_name ~= "" and arg_579_1.actors_[var_582_19.prefab_name] ~= nil then
						local var_582_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_19.prefab_name].transform, "story_v_out_417241", "417241137", "story_v_out_417241.awb")

						arg_579_1:RecordAudio("417241137", var_582_25)
						arg_579_1:RecordAudio("417241137", var_582_25)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_417241", "417241137", "story_v_out_417241.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_417241", "417241137", "story_v_out_417241.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_26 = math.max(var_582_17, arg_579_1.talkMaxDuration)

			if var_582_16 <= arg_579_1.time_ and arg_579_1.time_ < var_582_16 + var_582_26 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_16) / var_582_26

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_16 + var_582_26 and arg_579_1.time_ < var_582_16 + var_582_26 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play417241138 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 417241138
		arg_583_1.duration_ = 9.67

		local var_583_0 = {
			zh = 6.1,
			ja = 9.666
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play417241139(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.65

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[1109].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_3 = arg_583_1:GetWordFromCfg(417241138)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 26
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241138", "story_v_out_417241.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241138", "story_v_out_417241.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_out_417241", "417241138", "story_v_out_417241.awb")

						arg_583_1:RecordAudio("417241138", var_586_9)
						arg_583_1:RecordAudio("417241138", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_417241", "417241138", "story_v_out_417241.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_417241", "417241138", "story_v_out_417241.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play417241139 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 417241139
		arg_587_1.duration_ = 5.2

		local var_587_0 = {
			zh = 3.866,
			ja = 5.2
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play417241140(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["10115"]
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.actorSpriteComps10115 == nil then
				arg_587_1.var_.actorSpriteComps10115 = var_590_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_2 = 0.2

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 and not isNil(var_590_0) then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2

				if arg_587_1.var_.actorSpriteComps10115 then
					for iter_590_0, iter_590_1 in pairs(arg_587_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_590_1 then
							if arg_587_1.isInRecall_ then
								local var_590_4 = Mathf.Lerp(iter_590_1.color.r, arg_587_1.hightColor1.r, var_590_3)
								local var_590_5 = Mathf.Lerp(iter_590_1.color.g, arg_587_1.hightColor1.g, var_590_3)
								local var_590_6 = Mathf.Lerp(iter_590_1.color.b, arg_587_1.hightColor1.b, var_590_3)

								iter_590_1.color = Color.New(var_590_4, var_590_5, var_590_6)
							else
								local var_590_7 = Mathf.Lerp(iter_590_1.color.r, 1, var_590_3)

								iter_590_1.color = Color.New(var_590_7, var_590_7, var_590_7)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.actorSpriteComps10115 then
				for iter_590_2, iter_590_3 in pairs(arg_587_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_590_3 then
						if arg_587_1.isInRecall_ then
							iter_590_3.color = arg_587_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_590_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_587_1.var_.actorSpriteComps10115 = nil
			end

			local var_590_8 = arg_587_1.actors_["1034"]
			local var_590_9 = 0

			if var_590_9 < arg_587_1.time_ and arg_587_1.time_ <= var_590_9 + arg_590_0 and not isNil(var_590_8) and arg_587_1.var_.actorSpriteComps1034 == nil then
				arg_587_1.var_.actorSpriteComps1034 = var_590_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_10 = 0.2

			if var_590_9 <= arg_587_1.time_ and arg_587_1.time_ < var_590_9 + var_590_10 and not isNil(var_590_8) then
				local var_590_11 = (arg_587_1.time_ - var_590_9) / var_590_10

				if arg_587_1.var_.actorSpriteComps1034 then
					for iter_590_4, iter_590_5 in pairs(arg_587_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_590_5 then
							if arg_587_1.isInRecall_ then
								local var_590_12 = Mathf.Lerp(iter_590_5.color.r, arg_587_1.hightColor2.r, var_590_11)
								local var_590_13 = Mathf.Lerp(iter_590_5.color.g, arg_587_1.hightColor2.g, var_590_11)
								local var_590_14 = Mathf.Lerp(iter_590_5.color.b, arg_587_1.hightColor2.b, var_590_11)

								iter_590_5.color = Color.New(var_590_12, var_590_13, var_590_14)
							else
								local var_590_15 = Mathf.Lerp(iter_590_5.color.r, 0.5, var_590_11)

								iter_590_5.color = Color.New(var_590_15, var_590_15, var_590_15)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= var_590_9 + var_590_10 and arg_587_1.time_ < var_590_9 + var_590_10 + arg_590_0 and not isNil(var_590_8) and arg_587_1.var_.actorSpriteComps1034 then
				for iter_590_6, iter_590_7 in pairs(arg_587_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_590_7 then
						if arg_587_1.isInRecall_ then
							iter_590_7.color = arg_587_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_590_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_587_1.var_.actorSpriteComps1034 = nil
			end

			local var_590_16 = arg_587_1.actors_["1034"].transform
			local var_590_17 = 0

			if var_590_17 < arg_587_1.time_ and arg_587_1.time_ <= var_590_17 + arg_590_0 then
				arg_587_1.var_.moveOldPos1034 = var_590_16.localPosition
				var_590_16.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("1034", 7)

				local var_590_18 = var_590_16.childCount

				for iter_590_8 = 0, var_590_18 - 1 do
					local var_590_19 = var_590_16:GetChild(iter_590_8)

					if var_590_19.name == "" or not string.find(var_590_19.name, "split") then
						var_590_19.gameObject:SetActive(true)
					else
						var_590_19.gameObject:SetActive(false)
					end
				end
			end

			local var_590_20 = 0.001

			if var_590_17 <= arg_587_1.time_ and arg_587_1.time_ < var_590_17 + var_590_20 then
				local var_590_21 = (arg_587_1.time_ - var_590_17) / var_590_20
				local var_590_22 = Vector3.New(0, -2000, 0)

				var_590_16.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1034, var_590_22, var_590_21)
			end

			if arg_587_1.time_ >= var_590_17 + var_590_20 and arg_587_1.time_ < var_590_17 + var_590_20 + arg_590_0 then
				var_590_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_590_23 = arg_587_1.actors_["10115"].transform
			local var_590_24 = 0

			if var_590_24 < arg_587_1.time_ and arg_587_1.time_ <= var_590_24 + arg_590_0 then
				arg_587_1.var_.moveOldPos10115 = var_590_23.localPosition
				var_590_23.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("10115", 3)

				local var_590_25 = var_590_23.childCount

				for iter_590_9 = 0, var_590_25 - 1 do
					local var_590_26 = var_590_23:GetChild(iter_590_9)

					if var_590_26.name == "split_6" or not string.find(var_590_26.name, "split") then
						var_590_26.gameObject:SetActive(true)
					else
						var_590_26.gameObject:SetActive(false)
					end
				end
			end

			local var_590_27 = 0.001

			if var_590_24 <= arg_587_1.time_ and arg_587_1.time_ < var_590_24 + var_590_27 then
				local var_590_28 = (arg_587_1.time_ - var_590_24) / var_590_27
				local var_590_29 = Vector3.New(0, -387.3, -246.2)

				var_590_23.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10115, var_590_29, var_590_28)
			end

			if arg_587_1.time_ >= var_590_24 + var_590_27 and arg_587_1.time_ < var_590_24 + var_590_27 + arg_590_0 then
				var_590_23.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_590_30 = 0
			local var_590_31 = 0.35

			if var_590_30 < arg_587_1.time_ and arg_587_1.time_ <= var_590_30 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_32 = arg_587_1:FormatText(StoryNameCfg[1113].name)

				arg_587_1.leftNameTxt_.text = var_590_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_33 = arg_587_1:GetWordFromCfg(417241139)
				local var_590_34 = arg_587_1:FormatText(var_590_33.content)

				arg_587_1.text_.text = var_590_34

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_35 = 14
				local var_590_36 = utf8.len(var_590_34)
				local var_590_37 = var_590_35 <= 0 and var_590_31 or var_590_31 * (var_590_36 / var_590_35)

				if var_590_37 > 0 and var_590_31 < var_590_37 then
					arg_587_1.talkMaxDuration = var_590_37

					if var_590_37 + var_590_30 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_37 + var_590_30
					end
				end

				arg_587_1.text_.text = var_590_34
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241139", "story_v_out_417241.awb") ~= 0 then
					local var_590_38 = manager.audio:GetVoiceLength("story_v_out_417241", "417241139", "story_v_out_417241.awb") / 1000

					if var_590_38 + var_590_30 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_38 + var_590_30
					end

					if var_590_33.prefab_name ~= "" and arg_587_1.actors_[var_590_33.prefab_name] ~= nil then
						local var_590_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_33.prefab_name].transform, "story_v_out_417241", "417241139", "story_v_out_417241.awb")

						arg_587_1:RecordAudio("417241139", var_590_39)
						arg_587_1:RecordAudio("417241139", var_590_39)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_417241", "417241139", "story_v_out_417241.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_417241", "417241139", "story_v_out_417241.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_40 = math.max(var_590_31, arg_587_1.talkMaxDuration)

			if var_590_30 <= arg_587_1.time_ and arg_587_1.time_ < var_590_30 + var_590_40 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_30) / var_590_40

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_30 + var_590_40 and arg_587_1.time_ < var_590_30 + var_590_40 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
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

		arg_587_1:InitPlayNodeList()
	end,
	Play417241140 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 417241140
		arg_591_1.duration_ = 2.8

		local var_591_0 = {
			zh = 2.8,
			ja = 1.866
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
			arg_591_1.auto_ = false
		end

		function arg_591_1.playNext_(arg_593_0)
			arg_591_1.onStoryFinished_()
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["10115"].transform
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.var_.moveOldPos10115 = var_594_0.localPosition
				var_594_0.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("10115", 3)

				local var_594_2 = var_594_0.childCount

				for iter_594_0 = 0, var_594_2 - 1 do
					local var_594_3 = var_594_0:GetChild(iter_594_0)

					if var_594_3.name == "split_6" or not string.find(var_594_3.name, "split") then
						var_594_3.gameObject:SetActive(true)
					else
						var_594_3.gameObject:SetActive(false)
					end
				end
			end

			local var_594_4 = 0.001

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_4 then
				local var_594_5 = (arg_591_1.time_ - var_594_1) / var_594_4
				local var_594_6 = Vector3.New(0, -387.3, -246.2)

				var_594_0.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos10115, var_594_6, var_594_5)
			end

			if arg_591_1.time_ >= var_594_1 + var_594_4 and arg_591_1.time_ < var_594_1 + var_594_4 + arg_594_0 then
				var_594_0.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_594_7 = 0
			local var_594_8 = 0.225

			if var_594_7 < arg_591_1.time_ and arg_591_1.time_ <= var_594_7 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_9 = arg_591_1:FormatText(StoryNameCfg[1113].name)

				arg_591_1.leftNameTxt_.text = var_594_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_10 = arg_591_1:GetWordFromCfg(417241140)
				local var_594_11 = arg_591_1:FormatText(var_594_10.content)

				arg_591_1.text_.text = var_594_11

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_12 = 9
				local var_594_13 = utf8.len(var_594_11)
				local var_594_14 = var_594_12 <= 0 and var_594_8 or var_594_8 * (var_594_13 / var_594_12)

				if var_594_14 > 0 and var_594_8 < var_594_14 then
					arg_591_1.talkMaxDuration = var_594_14

					if var_594_14 + var_594_7 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_14 + var_594_7
					end
				end

				arg_591_1.text_.text = var_594_11
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241140", "story_v_out_417241.awb") ~= 0 then
					local var_594_15 = manager.audio:GetVoiceLength("story_v_out_417241", "417241140", "story_v_out_417241.awb") / 1000

					if var_594_15 + var_594_7 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_15 + var_594_7
					end

					if var_594_10.prefab_name ~= "" and arg_591_1.actors_[var_594_10.prefab_name] ~= nil then
						local var_594_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_10.prefab_name].transform, "story_v_out_417241", "417241140", "story_v_out_417241.awb")

						arg_591_1:RecordAudio("417241140", var_594_16)
						arg_591_1:RecordAudio("417241140", var_594_16)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_417241", "417241140", "story_v_out_417241.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_417241", "417241140", "story_v_out_417241.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_17 = math.max(var_594_8, arg_591_1.talkMaxDuration)

			if var_594_7 <= arg_591_1.time_ and arg_591_1.time_ < var_594_7 + var_594_17 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_7) / var_594_17

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_7 + var_594_17 and arg_591_1.time_ < var_594_7 + var_594_17 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
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

		arg_591_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/SS1710",
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/I17l",
		"TextureConfig/Background/SS1709"
	},
	voices = {
		"story_v_out_417241.awb"
	}
}
