return {
	Play938021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0119"

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
				local var_4_5 = arg_1_1.bgs_.ST0119

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
					if iter_4_0 ~= "ST0119" then
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

			local var_4_24 = "128404"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_["128404"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_36 = arg_1_1.actors_["128404"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 2)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_5" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-428.5, -356, -362.3)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos128404, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_4_43 = 0.3
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_4_47 = 1
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 0
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "effect"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 2
			local var_4_58 = 0.225

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(938021001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 9
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_57 + 0.3
			local var_4_67 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play938021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938021002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "108301"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

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

			local var_11_4 = arg_8_1.actors_["108301"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps108301 == nil then
				arg_8_1.var_.actorSpriteComps108301 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps108301 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps108301 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps108301 = nil
			end

			local var_11_12 = arg_8_1.actors_["128404"]
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps128404 == nil then
				arg_8_1.var_.actorSpriteComps128404 = var_11_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_14 = 0.2

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_14 and not isNil(var_11_12) then
				local var_11_15 = (arg_8_1.time_ - var_11_13) / var_11_14

				if arg_8_1.var_.actorSpriteComps128404 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_11_7 then
							if arg_8_1.isInRecall_ then
								local var_11_16 = Mathf.Lerp(iter_11_7.color.r, arg_8_1.hightColor2.r, var_11_15)
								local var_11_17 = Mathf.Lerp(iter_11_7.color.g, arg_8_1.hightColor2.g, var_11_15)
								local var_11_18 = Mathf.Lerp(iter_11_7.color.b, arg_8_1.hightColor2.b, var_11_15)

								iter_11_7.color = Color.New(var_11_16, var_11_17, var_11_18)
							else
								local var_11_19 = Mathf.Lerp(iter_11_7.color.r, 0.5, var_11_15)

								iter_11_7.color = Color.New(var_11_19, var_11_19, var_11_19)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_13 + var_11_14 and arg_8_1.time_ < var_11_13 + var_11_14 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps128404 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_11_9 then
						if arg_8_1.isInRecall_ then
							iter_11_9.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps128404 = nil
			end

			local var_11_20 = arg_8_1.actors_["108301"].transform
			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.var_.moveOldPos108301 = var_11_20.localPosition
				var_11_20.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("108301", 4)

				local var_11_22 = var_11_20.childCount

				for iter_11_10 = 0, var_11_22 - 1 do
					local var_11_23 = var_11_20:GetChild(iter_11_10)

					if var_11_23.name == "split_4" or not string.find(var_11_23.name, "split") then
						var_11_23.gameObject:SetActive(true)
					else
						var_11_23.gameObject:SetActive(false)
					end
				end
			end

			local var_11_24 = 0.001

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_24 then
				local var_11_25 = (arg_8_1.time_ - var_11_21) / var_11_24
				local var_11_26 = Vector3.New(460, -360, -195)

				var_11_20.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos108301, var_11_26, var_11_25)
			end

			if arg_8_1.time_ >= var_11_21 + var_11_24 and arg_8_1.time_ < var_11_21 + var_11_24 + arg_11_0 then
				var_11_20.localPosition = Vector3.New(460, -360, -195)
			end

			local var_11_27 = 0
			local var_11_28 = 0.625

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_29 = arg_8_1:FormatText(StoryNameCfg[1332].name)

				arg_8_1.leftNameTxt_.text = var_11_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_30 = arg_8_1:GetWordFromCfg(938021002)
				local var_11_31 = arg_8_1:FormatText(var_11_30.content)

				arg_8_1.text_.text = var_11_31

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_32 = 25
				local var_11_33 = utf8.len(var_11_31)
				local var_11_34 = var_11_32 <= 0 and var_11_28 or var_11_28 * (var_11_33 / var_11_32)

				if var_11_34 > 0 and var_11_28 < var_11_34 then
					arg_8_1.talkMaxDuration = var_11_34

					if var_11_34 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_27
					end
				end

				arg_8_1.text_.text = var_11_31
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_35 = math.max(var_11_28, arg_8_1.talkMaxDuration)

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_35 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_27) / var_11_35

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_27 + var_11_35 and arg_8_1.time_ < var_11_27 + var_11_35 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["108301"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps108301 == nil then
				arg_12_1.var_.actorSpriteComps108301 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps108301 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor2.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor2.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor2.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 0.5, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps108301 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps108301 = nil
			end

			local var_15_8 = arg_12_1.actors_["108301"].transform
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.var_.moveOldPos108301 = var_15_8.localPosition
				var_15_8.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("108301", 7)

				local var_15_10 = var_15_8.childCount

				for iter_15_4 = 0, var_15_10 - 1 do
					local var_15_11 = var_15_8:GetChild(iter_15_4)

					if var_15_11.name == "" or not string.find(var_15_11.name, "split") then
						var_15_11.gameObject:SetActive(true)
					else
						var_15_11.gameObject:SetActive(false)
					end
				end
			end

			local var_15_12 = 0.001

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_9) / var_15_12
				local var_15_14 = Vector3.New(0, -2000, 0)

				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos108301, var_15_14, var_15_13)
			end

			if arg_12_1.time_ >= var_15_9 + var_15_12 and arg_12_1.time_ < var_15_9 + var_15_12 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_15 = arg_12_1.actors_["128404"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos128404 = var_15_15.localPosition
				var_15_15.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("128404", 7)

				local var_15_17 = var_15_15.childCount

				for iter_15_5 = 0, var_15_17 - 1 do
					local var_15_18 = var_15_15:GetChild(iter_15_5)

					if var_15_18.name == "" or not string.find(var_15_18.name, "split") then
						var_15_18.gameObject:SetActive(true)
					else
						var_15_18.gameObject:SetActive(false)
					end
				end
			end

			local var_15_19 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_16) / var_15_19
				local var_15_21 = Vector3.New(0, -2000, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos128404, var_15_21, var_15_20)
			end

			if arg_12_1.time_ >= var_15_16 + var_15_19 and arg_12_1.time_ < var_15_16 + var_15_19 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_22 = "10144"

			if arg_12_1.actors_[var_15_22] == nil then
				local var_15_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_15_23) then
					local var_15_24 = Object.Instantiate(var_15_23, arg_12_1.canvasGo_.transform)

					var_15_24.transform:SetSiblingIndex(1)

					var_15_24.name = var_15_22
					var_15_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_[var_15_22] = var_15_24

					local var_15_25 = var_15_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_12_1.isInRecall_ then
						for iter_15_6, iter_15_7 in ipairs(var_15_25) do
							iter_15_7.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_26 = arg_12_1.actors_["10144"].transform
			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.var_.moveOldPos10144 = var_15_26.localPosition
				var_15_26.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10144", 7)

				local var_15_28 = var_15_26.childCount

				for iter_15_8 = 0, var_15_28 - 1 do
					local var_15_29 = var_15_26:GetChild(iter_15_8)

					if var_15_29.name == "" or not string.find(var_15_29.name, "split") then
						var_15_29.gameObject:SetActive(true)
					else
						var_15_29.gameObject:SetActive(false)
					end
				end
			end

			local var_15_30 = 0.001

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_30 then
				local var_15_31 = (arg_12_1.time_ - var_15_27) / var_15_30
				local var_15_32 = Vector3.New(0, -2000, 0)

				var_15_26.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10144, var_15_32, var_15_31)
			end

			if arg_12_1.time_ >= var_15_27 + var_15_30 and arg_12_1.time_ < var_15_27 + var_15_30 + arg_15_0 then
				var_15_26.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_33 = 0
			local var_15_34 = 1.175

			if var_15_33 < arg_12_1.time_ and arg_12_1.time_ <= var_15_33 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_35 = arg_12_1:GetWordFromCfg(938021003)
				local var_15_36 = arg_12_1:FormatText(var_15_35.content)

				arg_12_1.text_.text = var_15_36

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_37 = 47
				local var_15_38 = utf8.len(var_15_36)
				local var_15_39 = var_15_37 <= 0 and var_15_34 or var_15_34 * (var_15_38 / var_15_37)

				if var_15_39 > 0 and var_15_34 < var_15_39 then
					arg_12_1.talkMaxDuration = var_15_39

					if var_15_39 + var_15_33 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_39 + var_15_33
					end
				end

				arg_12_1.text_.text = var_15_36
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_40 = math.max(var_15_34, arg_12_1.talkMaxDuration)

			if var_15_33 <= arg_12_1.time_ and arg_12_1.time_ < var_15_33 + var_15_40 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_33) / var_15_40

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_33 + var_15_40 and arg_12_1.time_ < var_15_33 + var_15_40 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play938021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10144"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 == nil then
				arg_16_1.var_.actorSpriteComps10144 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps10144 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor1.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor1.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor1.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 1, var_19_3)

								iter_19_1.color = Color.New(var_19_7, var_19_7, var_19_7)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_8 = arg_16_1.actors_["10144"].transform
			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.var_.moveOldPos10144 = var_19_8.localPosition
				var_19_8.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10144", 3)

				local var_19_10 = var_19_8.childCount

				for iter_19_4 = 0, var_19_10 - 1 do
					local var_19_11 = var_19_8:GetChild(iter_19_4)

					if var_19_11.name == "split_2" or not string.find(var_19_11.name, "split") then
						var_19_11.gameObject:SetActive(true)
					else
						var_19_11.gameObject:SetActive(false)
					end
				end
			end

			local var_19_12 = 0.001

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_9) / var_19_12
				local var_19_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10144, var_19_14, var_19_13)
			end

			if arg_16_1.time_ >= var_19_9 + var_19_12 and arg_16_1.time_ < var_19_9 + var_19_12 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_19_15 = 0
			local var_19_16 = 1.5

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[1297].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(938021004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 60
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_23 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_23 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_23

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_23 and arg_16_1.time_ < var_19_15 + var_19_23 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play938021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.725

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[1297].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(938021005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 29
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10144"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10144 = var_27_0.localPosition
				var_27_0.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10144", 3)

				local var_27_2 = var_27_0.childCount

				for iter_27_0 = 0, var_27_2 - 1 do
					local var_27_3 = var_27_0:GetChild(iter_27_0)

					if var_27_3.name == "" or not string.find(var_27_3.name, "split") then
						var_27_3.gameObject:SetActive(true)
					else
						var_27_3.gameObject:SetActive(false)
					end
				end
			end

			local var_27_4 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_4 then
				local var_27_5 = (arg_24_1.time_ - var_27_1) / var_27_4
				local var_27_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10144, var_27_6, var_27_5)
			end

			if arg_24_1.time_ >= var_27_1 + var_27_4 and arg_24_1.time_ < var_27_1 + var_27_4 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_27_7 = 0
			local var_27_8 = 0.275

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_9 = arg_24_1:FormatText(StoryNameCfg[1297].name)

				arg_24_1.leftNameTxt_.text = var_27_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_10 = arg_24_1:GetWordFromCfg(938021006)
				local var_27_11 = arg_24_1:FormatText(var_27_10.content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_12 = 11
				local var_27_13 = utf8.len(var_27_11)
				local var_27_14 = var_27_12 <= 0 and var_27_8 or var_27_8 * (var_27_13 / var_27_12)

				if var_27_14 > 0 and var_27_8 < var_27_14 then
					arg_24_1.talkMaxDuration = var_27_14

					if var_27_14 + var_27_7 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_7
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = math.max(var_27_8, arg_24_1.talkMaxDuration)

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_7) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_7 + var_27_15 and arg_24_1.time_ < var_27_7 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play938021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10144"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos10144 = var_31_0.localPosition
				var_31_0.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10144", 3)

				local var_31_2 = var_31_0.childCount

				for iter_31_0 = 0, var_31_2 - 1 do
					local var_31_3 = var_31_0:GetChild(iter_31_0)

					if var_31_3.name == "" or not string.find(var_31_3.name, "split") then
						var_31_3.gameObject:SetActive(true)
					else
						var_31_3.gameObject:SetActive(false)
					end
				end
			end

			local var_31_4 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_4 then
				local var_31_5 = (arg_28_1.time_ - var_31_1) / var_31_4
				local var_31_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10144, var_31_6, var_31_5)
			end

			if arg_28_1.time_ >= var_31_1 + var_31_4 and arg_28_1.time_ < var_31_1 + var_31_4 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_31_7 = 0
			local var_31_8 = 1.35

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_9 = arg_28_1:FormatText(StoryNameCfg[1297].name)

				arg_28_1.leftNameTxt_.text = var_31_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(938021007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_12 = 54
				local var_31_13 = utf8.len(var_31_11)
				local var_31_14 = var_31_12 <= 0 and var_31_8 or var_31_8 * (var_31_13 / var_31_12)

				if var_31_14 > 0 and var_31_8 < var_31_14 then
					arg_28_1.talkMaxDuration = var_31_14

					if var_31_14 + var_31_7 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_7
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_8, arg_28_1.talkMaxDuration)

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_7) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_7 + var_31_15 and arg_28_1.time_ < var_31_7 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938021008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "104902"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(var_35_1, arg_32_1.canvasGo_.transform)

					var_35_2.transform:SetSiblingIndex(1)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_32_1.isInRecall_ then
						for iter_35_0, iter_35_1 in ipairs(var_35_3) do
							iter_35_1.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_35_4 = arg_32_1.actors_["104902"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.actorSpriteComps104902 == nil then
				arg_32_1.var_.actorSpriteComps104902 = var_35_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_6 = 0.2

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.actorSpriteComps104902 then
					for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_35_3 then
							if arg_32_1.isInRecall_ then
								local var_35_8 = Mathf.Lerp(iter_35_3.color.r, arg_32_1.hightColor1.r, var_35_7)
								local var_35_9 = Mathf.Lerp(iter_35_3.color.g, arg_32_1.hightColor1.g, var_35_7)
								local var_35_10 = Mathf.Lerp(iter_35_3.color.b, arg_32_1.hightColor1.b, var_35_7)

								iter_35_3.color = Color.New(var_35_8, var_35_9, var_35_10)
							else
								local var_35_11 = Mathf.Lerp(iter_35_3.color.r, 1, var_35_7)

								iter_35_3.color = Color.New(var_35_11, var_35_11, var_35_11)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.actorSpriteComps104902 then
				for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_35_5 then
						if arg_32_1.isInRecall_ then
							iter_35_5.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps104902 = nil
			end

			local var_35_12 = arg_32_1.actors_["10144"]
			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 and not isNil(var_35_12) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = var_35_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_14 = 0.2

			if var_35_13 <= arg_32_1.time_ and arg_32_1.time_ < var_35_13 + var_35_14 and not isNil(var_35_12) then
				local var_35_15 = (arg_32_1.time_ - var_35_13) / var_35_14

				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_35_7 then
							if arg_32_1.isInRecall_ then
								local var_35_16 = Mathf.Lerp(iter_35_7.color.r, arg_32_1.hightColor2.r, var_35_15)
								local var_35_17 = Mathf.Lerp(iter_35_7.color.g, arg_32_1.hightColor2.g, var_35_15)
								local var_35_18 = Mathf.Lerp(iter_35_7.color.b, arg_32_1.hightColor2.b, var_35_15)

								iter_35_7.color = Color.New(var_35_16, var_35_17, var_35_18)
							else
								local var_35_19 = Mathf.Lerp(iter_35_7.color.r, 0.5, var_35_15)

								iter_35_7.color = Color.New(var_35_19, var_35_19, var_35_19)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_13 + var_35_14 and arg_32_1.time_ < var_35_13 + var_35_14 + arg_35_0 and not isNil(var_35_12) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_8, iter_35_9 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_9 then
						if arg_32_1.isInRecall_ then
							iter_35_9.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_20 = arg_32_1.actors_["10144"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos10144 = var_35_20.localPosition
				var_35_20.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10144", 7)

				local var_35_22 = var_35_20.childCount

				for iter_35_10 = 0, var_35_22 - 1 do
					local var_35_23 = var_35_20:GetChild(iter_35_10)

					if var_35_23.name == "" or not string.find(var_35_23.name, "split") then
						var_35_23.gameObject:SetActive(true)
					else
						var_35_23.gameObject:SetActive(false)
					end
				end
			end

			local var_35_24 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_24 then
				local var_35_25 = (arg_32_1.time_ - var_35_21) / var_35_24
				local var_35_26 = Vector3.New(0, -2000, 0)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10144, var_35_26, var_35_25)
			end

			if arg_32_1.time_ >= var_35_21 + var_35_24 and arg_32_1.time_ < var_35_21 + var_35_24 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_35_27 = arg_32_1.actors_["104902"].transform
			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				arg_32_1.var_.moveOldPos104902 = var_35_27.localPosition
				var_35_27.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("104902", 2)

				local var_35_29 = var_35_27.childCount

				for iter_35_11 = 0, var_35_29 - 1 do
					local var_35_30 = var_35_27:GetChild(iter_35_11)

					if var_35_30.name == "" or not string.find(var_35_30.name, "split") then
						var_35_30.gameObject:SetActive(true)
					else
						var_35_30.gameObject:SetActive(false)
					end
				end
			end

			local var_35_31 = 0.001

			if var_35_28 <= arg_32_1.time_ and arg_32_1.time_ < var_35_28 + var_35_31 then
				local var_35_32 = (arg_32_1.time_ - var_35_28) / var_35_31
				local var_35_33 = Vector3.New(-390, -335, -360)

				var_35_27.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos104902, var_35_33, var_35_32)
			end

			if arg_32_1.time_ >= var_35_28 + var_35_31 and arg_32_1.time_ < var_35_28 + var_35_31 + arg_35_0 then
				var_35_27.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_35_34 = 0
			local var_35_35 = 0.175

			if var_35_34 < arg_32_1.time_ and arg_32_1.time_ <= var_35_34 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_36 = arg_32_1:FormatText(StoryNameCfg[562].name)

				arg_32_1.leftNameTxt_.text = var_35_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_37 = arg_32_1:GetWordFromCfg(938021008)
				local var_35_38 = arg_32_1:FormatText(var_35_37.content)

				arg_32_1.text_.text = var_35_38

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_39 = 7
				local var_35_40 = utf8.len(var_35_38)
				local var_35_41 = var_35_39 <= 0 and var_35_35 or var_35_35 * (var_35_40 / var_35_39)

				if var_35_41 > 0 and var_35_35 < var_35_41 then
					arg_32_1.talkMaxDuration = var_35_41

					if var_35_41 + var_35_34 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_41 + var_35_34
					end
				end

				arg_32_1.text_.text = var_35_38
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_42 = math.max(var_35_35, arg_32_1.talkMaxDuration)

			if var_35_34 <= arg_32_1.time_ and arg_32_1.time_ < var_35_34 + var_35_42 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_34) / var_35_42

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_34 + var_35_42 and arg_32_1.time_ < var_35_34 + var_35_42 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play938021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938021009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "106603"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(var_39_1, arg_36_1.canvasGo_.transform)

					var_39_2.transform:SetSiblingIndex(1)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_36_1.isInRecall_ then
						for iter_39_0, iter_39_1 in ipairs(var_39_3) do
							iter_39_1.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_39_4 = arg_36_1.actors_["106603"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_6 = 0.2

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_39_3 then
							if arg_36_1.isInRecall_ then
								local var_39_8 = Mathf.Lerp(iter_39_3.color.r, arg_36_1.hightColor1.r, var_39_7)
								local var_39_9 = Mathf.Lerp(iter_39_3.color.g, arg_36_1.hightColor1.g, var_39_7)
								local var_39_10 = Mathf.Lerp(iter_39_3.color.b, arg_36_1.hightColor1.b, var_39_7)

								iter_39_3.color = Color.New(var_39_8, var_39_9, var_39_10)
							else
								local var_39_11 = Mathf.Lerp(iter_39_3.color.r, 1, var_39_7)

								iter_39_3.color = Color.New(var_39_11, var_39_11, var_39_11)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_5 then
						if arg_36_1.isInRecall_ then
							iter_39_5.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_12 = arg_36_1.actors_["104902"]
			local var_39_13 = 0

			if var_39_13 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 and not isNil(var_39_12) and arg_36_1.var_.actorSpriteComps104902 == nil then
				arg_36_1.var_.actorSpriteComps104902 = var_39_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_14 = 0.2

			if var_39_13 <= arg_36_1.time_ and arg_36_1.time_ < var_39_13 + var_39_14 and not isNil(var_39_12) then
				local var_39_15 = (arg_36_1.time_ - var_39_13) / var_39_14

				if arg_36_1.var_.actorSpriteComps104902 then
					for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_39_7 then
							if arg_36_1.isInRecall_ then
								local var_39_16 = Mathf.Lerp(iter_39_7.color.r, arg_36_1.hightColor2.r, var_39_15)
								local var_39_17 = Mathf.Lerp(iter_39_7.color.g, arg_36_1.hightColor2.g, var_39_15)
								local var_39_18 = Mathf.Lerp(iter_39_7.color.b, arg_36_1.hightColor2.b, var_39_15)

								iter_39_7.color = Color.New(var_39_16, var_39_17, var_39_18)
							else
								local var_39_19 = Mathf.Lerp(iter_39_7.color.r, 0.5, var_39_15)

								iter_39_7.color = Color.New(var_39_19, var_39_19, var_39_19)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_13 + var_39_14 and arg_36_1.time_ < var_39_13 + var_39_14 + arg_39_0 and not isNil(var_39_12) and arg_36_1.var_.actorSpriteComps104902 then
				for iter_39_8, iter_39_9 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_39_9 then
						if arg_36_1.isInRecall_ then
							iter_39_9.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps104902 = nil
			end

			local var_39_20 = arg_36_1.actors_["106603"].transform
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_20.localPosition
				var_39_20.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 4)

				local var_39_22 = var_39_20.childCount

				for iter_39_10 = 0, var_39_22 - 1 do
					local var_39_23 = var_39_20:GetChild(iter_39_10)

					if var_39_23.name == "" or not string.find(var_39_23.name, "split") then
						var_39_23.gameObject:SetActive(true)
					else
						var_39_23.gameObject:SetActive(false)
					end
				end
			end

			local var_39_24 = 0.001

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_21) / var_39_24
				local var_39_26 = Vector3.New(453.9, -399.1, -303.3)

				var_39_20.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, var_39_26, var_39_25)
			end

			if arg_36_1.time_ >= var_39_21 + var_39_24 and arg_36_1.time_ < var_39_21 + var_39_24 + arg_39_0 then
				var_39_20.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_39_27 = 0
			local var_39_28 = 0.625

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_29 = arg_36_1:FormatText(StoryNameCfg[32].name)

				arg_36_1.leftNameTxt_.text = var_39_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_30 = arg_36_1:GetWordFromCfg(938021009)
				local var_39_31 = arg_36_1:FormatText(var_39_30.content)

				arg_36_1.text_.text = var_39_31

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_32 = 25
				local var_39_33 = utf8.len(var_39_31)
				local var_39_34 = var_39_32 <= 0 and var_39_28 or var_39_28 * (var_39_33 / var_39_32)

				if var_39_34 > 0 and var_39_28 < var_39_34 then
					arg_36_1.talkMaxDuration = var_39_34

					if var_39_34 + var_39_27 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_34 + var_39_27
					end
				end

				arg_36_1.text_.text = var_39_31
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_35 = math.max(var_39_28, arg_36_1.talkMaxDuration)

			if var_39_27 <= arg_36_1.time_ and arg_36_1.time_ < var_39_27 + var_39_35 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_27) / var_39_35

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_27 + var_39_35 and arg_36_1.time_ < var_39_27 + var_39_35 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play938021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938021010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10144"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10144 == nil then
				arg_40_1.var_.actorSpriteComps10144 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10144 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 1, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10144 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10144 = nil
			end

			local var_43_8 = arg_40_1.actors_["106603"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps106603 == nil then
				arg_40_1.var_.actorSpriteComps106603 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps106603 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								local var_43_12 = Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor2.r, var_43_11)
								local var_43_13 = Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor2.g, var_43_11)
								local var_43_14 = Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor2.b, var_43_11)

								iter_43_5.color = Color.New(var_43_12, var_43_13, var_43_14)
							else
								local var_43_15 = Mathf.Lerp(iter_43_5.color.r, 0.5, var_43_11)

								iter_43_5.color = Color.New(var_43_15, var_43_15, var_43_15)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps106603 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps106603 = nil
			end

			local var_43_16 = arg_40_1.actors_["10144"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos10144 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10144", 3)

				local var_43_18 = var_43_16.childCount

				for iter_43_8 = 0, var_43_18 - 1 do
					local var_43_19 = var_43_16:GetChild(iter_43_8)

					if var_43_19.name == "" or not string.find(var_43_19.name, "split") then
						var_43_19.gameObject:SetActive(true)
					else
						var_43_19.gameObject:SetActive(false)
					end
				end
			end

			local var_43_20 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_20 then
				local var_43_21 = (arg_40_1.time_ - var_43_17) / var_43_20
				local var_43_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10144, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_43_23 = arg_40_1.actors_["106603"].transform
			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1.var_.moveOldPos106603 = var_43_23.localPosition
				var_43_23.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("106603", 7)

				local var_43_25 = var_43_23.childCount

				for iter_43_9 = 0, var_43_25 - 1 do
					local var_43_26 = var_43_23:GetChild(iter_43_9)

					if var_43_26.name == "" or not string.find(var_43_26.name, "split") then
						var_43_26.gameObject:SetActive(true)
					else
						var_43_26.gameObject:SetActive(false)
					end
				end
			end

			local var_43_27 = 0.001

			if var_43_24 <= arg_40_1.time_ and arg_40_1.time_ < var_43_24 + var_43_27 then
				local var_43_28 = (arg_40_1.time_ - var_43_24) / var_43_27
				local var_43_29 = Vector3.New(0, -2000, 0)

				var_43_23.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos106603, var_43_29, var_43_28)
			end

			if arg_40_1.time_ >= var_43_24 + var_43_27 and arg_40_1.time_ < var_43_24 + var_43_27 + arg_43_0 then
				var_43_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_30 = arg_40_1.actors_["104902"].transform
			local var_43_31 = 0

			if var_43_31 < arg_40_1.time_ and arg_40_1.time_ <= var_43_31 + arg_43_0 then
				arg_40_1.var_.moveOldPos104902 = var_43_30.localPosition
				var_43_30.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("104902", 7)

				local var_43_32 = var_43_30.childCount

				for iter_43_10 = 0, var_43_32 - 1 do
					local var_43_33 = var_43_30:GetChild(iter_43_10)

					if var_43_33.name == "" or not string.find(var_43_33.name, "split") then
						var_43_33.gameObject:SetActive(true)
					else
						var_43_33.gameObject:SetActive(false)
					end
				end
			end

			local var_43_34 = 0.001

			if var_43_31 <= arg_40_1.time_ and arg_40_1.time_ < var_43_31 + var_43_34 then
				local var_43_35 = (arg_40_1.time_ - var_43_31) / var_43_34
				local var_43_36 = Vector3.New(0, -2000, -360)

				var_43_30.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos104902, var_43_36, var_43_35)
			end

			if arg_40_1.time_ >= var_43_31 + var_43_34 and arg_40_1.time_ < var_43_31 + var_43_34 + arg_43_0 then
				var_43_30.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_43_37 = 0
			local var_43_38 = 1.525

			if var_43_37 < arg_40_1.time_ and arg_40_1.time_ <= var_43_37 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_39 = arg_40_1:FormatText(StoryNameCfg[1297].name)

				arg_40_1.leftNameTxt_.text = var_43_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_40 = arg_40_1:GetWordFromCfg(938021010)
				local var_43_41 = arg_40_1:FormatText(var_43_40.content)

				arg_40_1.text_.text = var_43_41

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_42 = 61
				local var_43_43 = utf8.len(var_43_41)
				local var_43_44 = var_43_42 <= 0 and var_43_38 or var_43_38 * (var_43_43 / var_43_42)

				if var_43_44 > 0 and var_43_38 < var_43_44 then
					arg_40_1.talkMaxDuration = var_43_44

					if var_43_44 + var_43_37 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_44 + var_43_37
					end
				end

				arg_40_1.text_.text = var_43_41
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_45 = math.max(var_43_38, arg_40_1.talkMaxDuration)

			if var_43_37 <= arg_40_1.time_ and arg_40_1.time_ < var_43_37 + var_43_45 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_37) / var_43_45

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_37 + var_43_45 and arg_40_1.time_ < var_43_37 + var_43_45 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play938021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938021011
		arg_44_1.duration_ = 6.4

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "ST0108"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 0.866666666666667

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.ST0108

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "ST0108" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0.866666666666667

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_17 = 0.133333333333333

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_18 = manager.ui.mainCamera.transform
			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				local var_47_20 = arg_44_1.var_.effectzhuanchang12312
				local var_47_21
				local var_47_22 = var_47_18

				if not var_47_20 then
					var_47_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_47_22)
					var_47_20.name = "zhuanchang12312"
					arg_44_1.var_.effectzhuanchang12312 = var_47_20
				else
					var_47_20.transform:SetParent(var_47_22)
				end

				var_47_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_47_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_47_23 = 1.7777777777777777
				local var_47_24 = Screen.width / Screen.height
				local var_47_25 = var_47_24 / var_47_23
				local var_47_26 = Mathf.Max(var_47_23 / var_47_24, 1)

				var_47_20.transform.localScale = Vector3.New(var_47_20.transform.localScale.x * var_47_25, var_47_20.transform.localScale.y * var_47_26, var_47_20.transform.localScale.z)
			end

			local var_47_27 = arg_44_1.actors_["10144"]
			local var_47_28 = 0.866666666666667

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.actorSpriteComps10144 == nil then
				arg_44_1.var_.actorSpriteComps10144 = var_47_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_29 = 0.133333333333333

			if var_47_28 <= arg_44_1.time_ and arg_44_1.time_ < var_47_28 + var_47_29 and not isNil(var_47_27) then
				local var_47_30 = (arg_44_1.time_ - var_47_28) / var_47_29

				if arg_44_1.var_.actorSpriteComps10144 then
					for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_47_3 then
							if arg_44_1.isInRecall_ then
								local var_47_31 = Mathf.Lerp(iter_47_3.color.r, arg_44_1.hightColor2.r, var_47_30)
								local var_47_32 = Mathf.Lerp(iter_47_3.color.g, arg_44_1.hightColor2.g, var_47_30)
								local var_47_33 = Mathf.Lerp(iter_47_3.color.b, arg_44_1.hightColor2.b, var_47_30)

								iter_47_3.color = Color.New(var_47_31, var_47_32, var_47_33)
							else
								local var_47_34 = Mathf.Lerp(iter_47_3.color.r, 0.5, var_47_30)

								iter_47_3.color = Color.New(var_47_34, var_47_34, var_47_34)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_28 + var_47_29 and arg_44_1.time_ < var_47_28 + var_47_29 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.actorSpriteComps10144 then
				for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_47_5 then
						if arg_44_1.isInRecall_ then
							iter_47_5.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10144 = nil
			end

			local var_47_35 = arg_44_1.actors_["10144"].transform
			local var_47_36 = 0

			if var_47_36 < arg_44_1.time_ and arg_44_1.time_ <= var_47_36 + arg_47_0 then
				arg_44_1.var_.moveOldPos10144 = var_47_35.localPosition
				var_47_35.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10144", 7)

				local var_47_37 = var_47_35.childCount

				for iter_47_6 = 0, var_47_37 - 1 do
					local var_47_38 = var_47_35:GetChild(iter_47_6)

					if var_47_38.name == "" or not string.find(var_47_38.name, "split") then
						var_47_38.gameObject:SetActive(true)
					else
						var_47_38.gameObject:SetActive(false)
					end
				end
			end

			local var_47_39 = 0.001

			if var_47_36 <= arg_44_1.time_ and arg_44_1.time_ < var_47_36 + var_47_39 then
				local var_47_40 = (arg_44_1.time_ - var_47_36) / var_47_39
				local var_47_41 = Vector3.New(0, -2000, 0)

				var_47_35.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10144, var_47_41, var_47_40)
			end

			if arg_44_1.time_ >= var_47_36 + var_47_39 and arg_44_1.time_ < var_47_36 + var_47_39 + arg_47_0 then
				var_47_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_47_42 = 1
			local var_47_43 = 1

			if var_47_42 < arg_44_1.time_ and arg_44_1.time_ <= var_47_42 + arg_47_0 then
				local var_47_44 = "play"
				local var_47_45 = "effect"

				arg_44_1:AudioAction(var_47_44, var_47_45, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_47_46 = 0.3
			local var_47_47 = 1

			if var_47_46 < arg_44_1.time_ and arg_44_1.time_ <= var_47_46 + arg_47_0 then
				local var_47_48 = "stop"
				local var_47_49 = "effect"

				arg_44_1:AudioAction(var_47_48, var_47_49, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_47_50 = 0.1
			local var_47_51 = 1

			if var_47_50 < arg_44_1.time_ and arg_44_1.time_ <= var_47_50 + arg_47_0 then
				local var_47_52 = "play"
				local var_47_53 = "effect"

				arg_44_1:AudioAction(var_47_52, var_47_53, "se_story_140", "se_story_140_snap", "")
			end

			local var_47_54 = manager.ui.mainCamera.transform
			local var_47_55 = 0.866666666666667

			if var_47_55 < arg_44_1.time_ and arg_44_1.time_ <= var_47_55 + arg_47_0 then
				local var_47_56 = arg_44_1.var_.effectshujuliuzhuanchang1
				local var_47_57
				local var_47_58 = var_47_54

				if not var_47_56 then
					var_47_56 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_47_58)
					var_47_56.name = "shujuliuzhuanchang1"
					arg_44_1.var_.effectshujuliuzhuanchang1 = var_47_56
				else
					var_47_56.transform:SetParent(var_47_58)
				end

				var_47_56.transform.localPosition = Vector3.New(0, 0, 0)
				var_47_56.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_59 = 1.4
			local var_47_60 = 0.6

			if var_47_59 < arg_44_1.time_ and arg_44_1.time_ <= var_47_59 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_61 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_61:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_62 = arg_44_1:GetWordFromCfg(938021011)
				local var_47_63 = arg_44_1:FormatText(var_47_62.content)

				arg_44_1.text_.text = var_47_63

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_64 = 24
				local var_47_65 = utf8.len(var_47_63)
				local var_47_66 = var_47_64 <= 0 and var_47_60 or var_47_60 * (var_47_65 / var_47_64)

				if var_47_66 > 0 and var_47_60 < var_47_66 then
					arg_44_1.talkMaxDuration = var_47_66
					var_47_59 = var_47_59 + 0.3

					if var_47_66 + var_47_59 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_66 + var_47_59
					end
				end

				arg_44_1.text_.text = var_47_63
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_67 = var_47_59 + 0.3
			local var_47_68 = math.max(var_47_60, arg_44_1.talkMaxDuration)

			if var_47_67 <= arg_44_1.time_ and arg_44_1.time_ < var_47_67 + var_47_68 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_67) / var_47_68

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_67 + var_47_68 and arg_44_1.time_ < var_47_67 + var_47_68 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play938021012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938021012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938021013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.65

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(938021012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 66
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play938021013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938021013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938021014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["128404"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps128404 == nil then
				arg_54_1.var_.actorSpriteComps128404 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps128404 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps128404 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps128404 = nil
			end

			local var_57_8 = arg_54_1.actors_["128404"].transform
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				local var_57_10 = var_57_8.childCount

				for iter_57_4 = 0, var_57_10 - 1 do
					local var_57_11 = var_57_8:GetChild(iter_57_4)

					if var_57_11.name == "split_5" or not string.find(var_57_11.name, "split") then
						var_57_11.gameObject:SetActive(true)
					else
						var_57_11.gameObject:SetActive(false)
					end
				end
			end

			local var_57_12 = 0.001

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_12 then
				local var_57_13 = (arg_54_1.time_ - var_57_9) / var_57_12
				local var_57_14 = Vector3.New(-428.5, -356, -362.3)

				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, var_57_14, var_57_13)
			end

			if arg_54_1.time_ >= var_57_9 + var_57_12 and arg_54_1.time_ < var_57_9 + var_57_12 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_57_15 = manager.ui.mainCamera.transform
			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				local var_57_17 = arg_54_1.var_.effectshujuliuzhuanchang1

				if var_57_17 then
					Object.Destroy(var_57_17)

					arg_54_1.var_.effectshujuliuzhuanchang1 = nil
				end
			end

			local var_57_18 = 0
			local var_57_19 = 0.325

			if var_57_18 < arg_54_1.time_ and arg_54_1.time_ <= var_57_18 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_20 = arg_54_1:FormatText(StoryNameCfg[6].name)

				arg_54_1.leftNameTxt_.text = var_57_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_21 = arg_54_1:GetWordFromCfg(938021013)
				local var_57_22 = arg_54_1:FormatText(var_57_21.content)

				arg_54_1.text_.text = var_57_22

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_23 = 13
				local var_57_24 = utf8.len(var_57_22)
				local var_57_25 = var_57_23 <= 0 and var_57_19 or var_57_19 * (var_57_24 / var_57_23)

				if var_57_25 > 0 and var_57_19 < var_57_25 then
					arg_54_1.talkMaxDuration = var_57_25

					if var_57_25 + var_57_18 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_25 + var_57_18
					end
				end

				arg_54_1.text_.text = var_57_22
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_26 = math.max(var_57_19, arg_54_1.talkMaxDuration)

			if var_57_18 <= arg_54_1.time_ and arg_54_1.time_ < var_57_18 + var_57_26 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_18) / var_57_26

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_18 + var_57_26 and arg_54_1.time_ < var_57_18 + var_57_26 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938021014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938021015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10144"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10144 == nil then
				arg_58_1.var_.actorSpriteComps10144 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps10144 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10144 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10144 = nil
			end

			local var_61_8 = arg_58_1.actors_["128404"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_16 = arg_58_1.actors_["10144"].transform
			local var_61_17 = 0

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 then
				arg_58_1.var_.moveOldPos10144 = var_61_16.localPosition
				var_61_16.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10144", 4)

				local var_61_18 = var_61_16.childCount

				for iter_61_8 = 0, var_61_18 - 1 do
					local var_61_19 = var_61_16:GetChild(iter_61_8)

					if var_61_19.name == "split_1" or not string.find(var_61_19.name, "split") then
						var_61_19.gameObject:SetActive(true)
					else
						var_61_19.gameObject:SetActive(false)
					end
				end
			end

			local var_61_20 = 0.001

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_20 then
				local var_61_21 = (arg_58_1.time_ - var_61_17) / var_61_20
				local var_61_22 = Vector3.New(435.8, -381.1, -285.9)

				var_61_16.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10144, var_61_22, var_61_21)
			end

			if arg_58_1.time_ >= var_61_17 + var_61_20 and arg_58_1.time_ < var_61_17 + var_61_20 + arg_61_0 then
				var_61_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_61_23 = 0
			local var_61_24 = 1.75

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_25 = arg_58_1:FormatText(StoryNameCfg[1297].name)

				arg_58_1.leftNameTxt_.text = var_61_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_26 = arg_58_1:GetWordFromCfg(938021014)
				local var_61_27 = arg_58_1:FormatText(var_61_26.content)

				arg_58_1.text_.text = var_61_27

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_28 = 70
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
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_31 = math.max(var_61_24, arg_58_1.talkMaxDuration)

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_31 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_23) / var_61_31

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_23 + var_61_31 and arg_58_1.time_ < var_61_23 + var_61_31 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938021015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938021016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10144"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos10144 = var_65_0.localPosition
				var_65_0.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10144", 4)

				local var_65_2 = var_65_0.childCount

				for iter_65_0 = 0, var_65_2 - 1 do
					local var_65_3 = var_65_0:GetChild(iter_65_0)

					if var_65_3.name == "" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_4 then
				local var_65_5 = (arg_62_1.time_ - var_65_1) / var_65_4
				local var_65_6 = Vector3.New(435.8, -381.1, -285.9)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10144, var_65_6, var_65_5)
			end

			if arg_62_1.time_ >= var_65_1 + var_65_4 and arg_62_1.time_ < var_65_1 + var_65_4 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_65_7 = 0
			local var_65_8 = 1.35

			if var_65_7 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_9 = arg_62_1:FormatText(StoryNameCfg[1297].name)

				arg_62_1.leftNameTxt_.text = var_65_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(938021015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_12 = 54
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
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_15 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_15 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_15

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_15 and arg_62_1.time_ < var_65_7 + var_65_15 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938021016
		arg_66_1.duration_ = 6.1

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938021017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.934

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				local var_69_1 = manager.ui.mainCamera.transform.localPosition
				local var_69_2 = Vector3.New(0, 0, 10) + Vector3.New(var_69_1.x, var_69_1.y, 0)
				local var_69_3 = arg_66_1.bgs_.ST0119

				var_69_3.transform.localPosition = var_69_2
				var_69_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_4 = var_69_3:GetComponent("SpriteRenderer")

				if var_69_4 and var_69_4.sprite then
					local var_69_5 = (var_69_3.transform.localPosition - var_69_1).z
					local var_69_6 = manager.ui.mainCameraCom_
					local var_69_7 = 2 * var_69_5 * Mathf.Tan(var_69_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_8 = var_69_7 * var_69_6.aspect
					local var_69_9 = var_69_4.sprite.bounds.size.x
					local var_69_10 = var_69_4.sprite.bounds.size.y
					local var_69_11 = var_69_8 / var_69_9
					local var_69_12 = var_69_7 / var_69_10
					local var_69_13 = var_69_12 < var_69_11 and var_69_11 or var_69_12

					var_69_3.transform.localScale = Vector3.New(var_69_13, var_69_13, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST0119" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_14 = 0.934

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_15 = 0.3

			if arg_66_1.time_ >= var_69_14 + var_69_15 and arg_66_1.time_ < var_69_14 + var_69_15 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_16 = manager.ui.mainCamera.transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				local var_69_18 = arg_66_1.var_.effecthuanchangjing123
				local var_69_19
				local var_69_20 = var_69_16

				if not var_69_18 then
					var_69_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_69_20)
					var_69_18.name = "huanchangjing123"
					arg_66_1.var_.effecthuanchangjing123 = var_69_18
				else
					var_69_18.transform:SetParent(var_69_20)
				end

				var_69_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_69_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_69_21 = arg_66_1.actors_["10144"]
			local var_69_22 = 0

			if var_69_22 < arg_66_1.time_ and arg_66_1.time_ <= var_69_22 + arg_69_0 and not isNil(var_69_21) and arg_66_1.var_.actorSpriteComps10144 == nil then
				arg_66_1.var_.actorSpriteComps10144 = var_69_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_23 = 0.034

			if var_69_22 <= arg_66_1.time_ and arg_66_1.time_ < var_69_22 + var_69_23 and not isNil(var_69_21) then
				local var_69_24 = (arg_66_1.time_ - var_69_22) / var_69_23

				if arg_66_1.var_.actorSpriteComps10144 then
					for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_69_3 then
							if arg_66_1.isInRecall_ then
								local var_69_25 = Mathf.Lerp(iter_69_3.color.r, arg_66_1.hightColor2.r, var_69_24)
								local var_69_26 = Mathf.Lerp(iter_69_3.color.g, arg_66_1.hightColor2.g, var_69_24)
								local var_69_27 = Mathf.Lerp(iter_69_3.color.b, arg_66_1.hightColor2.b, var_69_24)

								iter_69_3.color = Color.New(var_69_25, var_69_26, var_69_27)
							else
								local var_69_28 = Mathf.Lerp(iter_69_3.color.r, 0.5, var_69_24)

								iter_69_3.color = Color.New(var_69_28, var_69_28, var_69_28)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_22 + var_69_23 and arg_66_1.time_ < var_69_22 + var_69_23 + arg_69_0 and not isNil(var_69_21) and arg_66_1.var_.actorSpriteComps10144 then
				for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_69_5 then
						if arg_66_1.isInRecall_ then
							iter_69_5.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps10144 = nil
			end

			local var_69_29 = arg_66_1.actors_["128404"].transform
			local var_69_30 = 0

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				arg_66_1.var_.moveOldPos128404 = var_69_29.localPosition
				var_69_29.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("128404", 7)

				local var_69_31 = var_69_29.childCount

				for iter_69_6 = 0, var_69_31 - 1 do
					local var_69_32 = var_69_29:GetChild(iter_69_6)

					if var_69_32.name == "" or not string.find(var_69_32.name, "split") then
						var_69_32.gameObject:SetActive(true)
					else
						var_69_32.gameObject:SetActive(false)
					end
				end
			end

			local var_69_33 = 0.001

			if var_69_30 <= arg_66_1.time_ and arg_66_1.time_ < var_69_30 + var_69_33 then
				local var_69_34 = (arg_66_1.time_ - var_69_30) / var_69_33
				local var_69_35 = Vector3.New(0, -2000, 0)

				var_69_29.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos128404, var_69_35, var_69_34)
			end

			if arg_66_1.time_ >= var_69_30 + var_69_33 and arg_66_1.time_ < var_69_30 + var_69_33 + arg_69_0 then
				var_69_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_69_36 = arg_66_1.actors_["10144"].transform
			local var_69_37 = 0

			if var_69_37 < arg_66_1.time_ and arg_66_1.time_ <= var_69_37 + arg_69_0 then
				arg_66_1.var_.moveOldPos10144 = var_69_36.localPosition
				var_69_36.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("10144", 7)

				local var_69_38 = var_69_36.childCount

				for iter_69_7 = 0, var_69_38 - 1 do
					local var_69_39 = var_69_36:GetChild(iter_69_7)

					if var_69_39.name == "" or not string.find(var_69_39.name, "split") then
						var_69_39.gameObject:SetActive(true)
					else
						var_69_39.gameObject:SetActive(false)
					end
				end
			end

			local var_69_40 = 0.001

			if var_69_37 <= arg_66_1.time_ and arg_66_1.time_ < var_69_37 + var_69_40 then
				local var_69_41 = (arg_66_1.time_ - var_69_37) / var_69_40
				local var_69_42 = Vector3.New(0, -2000, 0)

				var_69_36.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10144, var_69_42, var_69_41)
			end

			if arg_66_1.time_ >= var_69_37 + var_69_40 and arg_66_1.time_ < var_69_37 + var_69_40 + arg_69_0 then
				var_69_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_69_43 = 1
			local var_69_44 = 1

			if var_69_43 < arg_66_1.time_ and arg_66_1.time_ <= var_69_43 + arg_69_0 then
				local var_69_45 = "play"
				local var_69_46 = "effect"

				arg_66_1:AudioAction(var_69_45, var_69_46, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_69_47 = 0.3
			local var_69_48 = 1

			if var_69_47 < arg_66_1.time_ and arg_66_1.time_ <= var_69_47 + arg_69_0 then
				local var_69_49 = "stop"
				local var_69_50 = "effect"

				arg_66_1:AudioAction(var_69_49, var_69_50, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_69_51 = 1.1
			local var_69_52 = 1

			if var_69_51 < arg_66_1.time_ and arg_66_1.time_ <= var_69_51 + arg_69_0 then
				local var_69_53 = "play"
				local var_69_54 = "effect"

				arg_66_1:AudioAction(var_69_53, var_69_54, "se_story_140", "se_story_140_snap", "")
			end

			local var_69_55 = 0

			if var_69_55 < arg_66_1.time_ and arg_66_1.time_ <= var_69_55 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_56 = 2.1

			if arg_66_1.time_ >= var_69_55 + var_69_56 and arg_66_1.time_ < var_69_55 + var_69_56 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_57 = 1.1
			local var_69_58 = 1.25

			if var_69_57 < arg_66_1.time_ and arg_66_1.time_ <= var_69_57 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_59 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_59:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_60 = arg_66_1:GetWordFromCfg(938021016)
				local var_69_61 = arg_66_1:FormatText(var_69_60.content)

				arg_66_1.text_.text = var_69_61

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_62 = 50
				local var_69_63 = utf8.len(var_69_61)
				local var_69_64 = var_69_62 <= 0 and var_69_58 or var_69_58 * (var_69_63 / var_69_62)

				if var_69_64 > 0 and var_69_58 < var_69_64 then
					arg_66_1.talkMaxDuration = var_69_64
					var_69_57 = var_69_57 + 0.3

					if var_69_64 + var_69_57 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_64 + var_69_57
					end
				end

				arg_66_1.text_.text = var_69_61
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_65 = var_69_57 + 0.3
			local var_69_66 = math.max(var_69_58, arg_66_1.talkMaxDuration)

			if var_69_65 <= arg_66_1.time_ and arg_66_1.time_ < var_69_65 + var_69_66 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_65) / var_69_66

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_65 + var_69_66 and arg_66_1.time_ < var_69_65 + var_69_66 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play938021017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938021017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938021018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10144"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10144 == nil then
				arg_72_1.var_.actorSpriteComps10144 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps10144 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10144 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10144 = nil
			end

			local var_75_8 = arg_72_1.actors_["10144"].transform
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.var_.moveOldPos10144 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10144", 3)

				local var_75_10 = var_75_8.childCount

				for iter_75_4 = 0, var_75_10 - 1 do
					local var_75_11 = var_75_8:GetChild(iter_75_4)

					if var_75_11.name == "split_2" or not string.find(var_75_11.name, "split") then
						var_75_11.gameObject:SetActive(true)
					else
						var_75_11.gameObject:SetActive(false)
					end
				end
			end

			local var_75_12 = 0.001

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_9) / var_75_12
				local var_75_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10144, var_75_14, var_75_13)
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_75_15 = arg_72_1.actors_["10144"]
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				local var_75_17 = var_75_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_75_17 then
					arg_72_1.var_.alphaOldValue10144 = var_75_17.alpha
					arg_72_1.var_.characterEffect10144 = var_75_17
				end

				arg_72_1.var_.alphaOldValue10144 = 0
			end

			local var_75_18 = 0.0166666666666667

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_18 then
				local var_75_19 = (arg_72_1.time_ - var_75_16) / var_75_18
				local var_75_20 = Mathf.Lerp(arg_72_1.var_.alphaOldValue10144, 1, var_75_19)

				if arg_72_1.var_.characterEffect10144 then
					arg_72_1.var_.characterEffect10144.alpha = var_75_20
				end
			end

			if arg_72_1.time_ >= var_75_16 + var_75_18 and arg_72_1.time_ < var_75_16 + var_75_18 + arg_75_0 and arg_72_1.var_.characterEffect10144 then
				arg_72_1.var_.characterEffect10144.alpha = 1
			end

			local var_75_21 = 0
			local var_75_22 = 1.175

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_23 = arg_72_1:FormatText(StoryNameCfg[1297].name)

				arg_72_1.leftNameTxt_.text = var_75_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_24 = arg_72_1:GetWordFromCfg(938021017)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 47
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_22 or var_75_22 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_22 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_21
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_29 = math.max(var_75_22, arg_72_1.talkMaxDuration)

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_29 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_21) / var_75_29

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_21 + var_75_29 and arg_72_1.time_ < var_75_21 + var_75_29 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938021018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938021018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938021019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10144"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10144 == nil then
				arg_76_1.var_.actorSpriteComps10144 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10144 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 0.5, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10144 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10144 = nil
			end

			local var_79_8 = arg_76_1.actors_["10144"].transform
			local var_79_9 = 0.366666666666667

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10144", 7)

				local var_79_10 = var_79_8.childCount

				for iter_79_4 = 0, var_79_10 - 1 do
					local var_79_11 = var_79_8:GetChild(iter_79_4)

					if var_79_11.name == "" or not string.find(var_79_11.name, "split") then
						var_79_11.gameObject:SetActive(true)
					else
						var_79_11.gameObject:SetActive(false)
					end
				end
			end

			local var_79_12 = 0.001

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_12 then
				local var_79_13 = (arg_76_1.time_ - var_79_9) / var_79_12
				local var_79_14 = Vector3.New(0, -2000, 0)

				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, var_79_14, var_79_13)
			end

			if arg_76_1.time_ >= var_79_9 + var_79_12 and arg_76_1.time_ < var_79_9 + var_79_12 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_15 = arg_76_1.actors_["10144"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_15.localPosition
				var_79_15.localScale = Vector3.New(1, 1, 1)

				local var_79_17 = var_79_15.childCount

				for iter_79_5 = 0, var_79_17 - 1 do
					local var_79_18 = var_79_15:GetChild(iter_79_5)

					if var_79_18.name == "split_2" or not string.find(var_79_18.name, "split") then
						var_79_18.gameObject:SetActive(true)
					else
						var_79_18.gameObject:SetActive(false)
					end
				end
			end

			local var_79_19 = 0.366666666666667

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_16) / var_79_19
				local var_79_21 = Vector3.New(-31.5, -500, -285.9)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, var_79_21, var_79_20)
			end

			if arg_76_1.time_ >= var_79_16 + var_79_19 and arg_76_1.time_ < var_79_16 + var_79_19 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(-31.5, -500, -285.9)
			end

			local var_79_22 = 0

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_23 = 0.5

			if arg_76_1.time_ >= var_79_22 + var_79_23 and arg_76_1.time_ < var_79_22 + var_79_23 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_24 = 0
			local var_79_25 = 1.35

			if var_79_24 < arg_76_1.time_ and arg_76_1.time_ <= var_79_24 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(938021018)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 54
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_25 or var_79_25 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_25 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_24 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_24
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_25, arg_76_1.talkMaxDuration)

			if var_79_24 <= arg_76_1.time_ and arg_76_1.time_ < var_79_24 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_24) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_24 + var_79_31 and arg_76_1.time_ < var_79_24 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.366666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-31.5, -381.1, -285.9),
					endPos = Vector3.New(-31.5, -500, -285.9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play938021019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938021019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938021020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_2 = "play"
				local var_83_3 = "effect"

				arg_80_1:AudioAction(var_83_2, var_83_3, "se_story_152", "se_story_152_crowd", "")
			end

			local var_83_4 = 0
			local var_83_5 = 1.625

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

				local var_83_6 = arg_80_1:GetWordFromCfg(938021019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_8 = 65
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
	Play938021020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 938021020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play938021021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["108301"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps108301 == nil then
				arg_84_1.var_.actorSpriteComps108301 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps108301 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps108301 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps108301 = nil
			end

			local var_87_8 = arg_84_1.actors_["108301"].transform
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.var_.moveOldPos108301 = var_87_8.localPosition
				var_87_8.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("108301", 2)

				local var_87_10 = var_87_8.childCount

				for iter_87_4 = 0, var_87_10 - 1 do
					local var_87_11 = var_87_8:GetChild(iter_87_4)

					if var_87_11.name == "split_3" or not string.find(var_87_11.name, "split") then
						var_87_11.gameObject:SetActive(true)
					else
						var_87_11.gameObject:SetActive(false)
					end
				end
			end

			local var_87_12 = 0.001

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_9) / var_87_12
				local var_87_14 = Vector3.New(-420, -360, -195)

				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos108301, var_87_14, var_87_13)
			end

			if arg_84_1.time_ >= var_87_9 + var_87_12 and arg_84_1.time_ < var_87_9 + var_87_12 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_87_15 = 0
			local var_87_16 = 0.975

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[1332].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(938021020)
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
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_23 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_23 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_23

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_23 and arg_84_1.time_ < var_87_15 + var_87_23 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 938021021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play938021022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["128404"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps128404 == nil then
				arg_88_1.var_.actorSpriteComps128404 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps128404 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 1, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps128404 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps128404 = nil
			end

			local var_91_8 = arg_88_1.actors_["108301"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps108301 == nil then
				arg_88_1.var_.actorSpriteComps108301 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps108301 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								local var_91_12 = Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, var_91_11)
								local var_91_13 = Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, var_91_11)
								local var_91_14 = Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, var_91_11)

								iter_91_5.color = Color.New(var_91_12, var_91_13, var_91_14)
							else
								local var_91_15 = Mathf.Lerp(iter_91_5.color.r, 0.5, var_91_11)

								iter_91_5.color = Color.New(var_91_15, var_91_15, var_91_15)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps108301 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps108301 = nil
			end

			local var_91_16 = arg_88_1.actors_["128404"].transform
			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.var_.moveOldPos128404 = var_91_16.localPosition
				var_91_16.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("128404", 4)

				local var_91_18 = var_91_16.childCount

				for iter_91_8 = 0, var_91_18 - 1 do
					local var_91_19 = var_91_16:GetChild(iter_91_8)

					if var_91_19.name == "split_2" or not string.find(var_91_19.name, "split") then
						var_91_19.gameObject:SetActive(true)
					else
						var_91_19.gameObject:SetActive(false)
					end
				end
			end

			local var_91_20 = 0.001

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_17) / var_91_20
				local var_91_22 = Vector3.New(390.2, -356, -362.3)

				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos128404, var_91_22, var_91_21)
			end

			if arg_88_1.time_ >= var_91_17 + var_91_20 and arg_88_1.time_ < var_91_17 + var_91_20 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_91_23 = 0
			local var_91_24 = 0.825

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_25 = arg_88_1:FormatText(StoryNameCfg[6].name)

				arg_88_1.leftNameTxt_.text = var_91_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_26 = arg_88_1:GetWordFromCfg(938021021)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.text_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_28 = 33
				local var_91_29 = utf8.len(var_91_27)
				local var_91_30 = var_91_28 <= 0 and var_91_24 or var_91_24 * (var_91_29 / var_91_28)

				if var_91_30 > 0 and var_91_24 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30

					if var_91_30 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_23
					end
				end

				arg_88_1.text_.text = var_91_27
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_31 = math.max(var_91_24, arg_88_1.talkMaxDuration)

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_31 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_23) / var_91_31

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_23 + var_91_31 and arg_88_1.time_ < var_91_23 + var_91_31 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 938021022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play938021023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["128404"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps128404 == nil then
				arg_92_1.var_.actorSpriteComps128404 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps128404 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 0.5, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps128404 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps128404 = nil
			end

			local var_95_8 = 0
			local var_95_9 = 0.525

			if var_95_8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_10 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_11 = arg_92_1:GetWordFromCfg(938021022)
				local var_95_12 = arg_92_1:FormatText(var_95_11.content)

				arg_92_1.text_.text = var_95_12

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 21
				local var_95_14 = utf8.len(var_95_12)
				local var_95_15 = var_95_13 <= 0 and var_95_9 or var_95_9 * (var_95_14 / var_95_13)

				if var_95_15 > 0 and var_95_9 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_12
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play938021023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 938021023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play938021024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["128404"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps128404 == nil then
				arg_96_1.var_.actorSpriteComps128404 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps128404 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 1, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps128404 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps128404 = nil
			end

			local var_99_8 = arg_96_1.actors_["128404"].transform
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.var_.moveOldPos128404 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("128404", 4)

				local var_99_10 = var_99_8.childCount

				for iter_99_4 = 0, var_99_10 - 1 do
					local var_99_11 = var_99_8:GetChild(iter_99_4)

					if var_99_11.name == "" or not string.find(var_99_11.name, "split") then
						var_99_11.gameObject:SetActive(true)
					else
						var_99_11.gameObject:SetActive(false)
					end
				end
			end

			local var_99_12 = 0.001

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_9) / var_99_12
				local var_99_14 = Vector3.New(390.2, -356, -362.3)

				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos128404, var_99_14, var_99_13)
			end

			if arg_96_1.time_ >= var_99_9 + var_99_12 and arg_96_1.time_ < var_99_9 + var_99_12 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_99_15 = 0
			local var_99_16 = 1.275

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[6].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(938021023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 51
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_23 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_23 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_23

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_23 and arg_96_1.time_ < var_99_15 + var_99_23 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play938021024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 938021024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play938021025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["128404"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps128404 == nil then
				arg_100_1.var_.actorSpriteComps128404 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps128404 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 0.5, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps128404 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps128404 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 1.05

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_11 = arg_100_1:GetWordFromCfg(938021024)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 42
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play938021025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 938021025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play938021026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["128404"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps128404 == nil then
				arg_104_1.var_.actorSpriteComps128404 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps128404 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 1, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps128404 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps128404 = nil
			end

			local var_107_8 = arg_104_1.actors_["128404"].transform
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.var_.moveOldPos128404 = var_107_8.localPosition
				var_107_8.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("128404", 4)

				local var_107_10 = var_107_8.childCount

				for iter_107_4 = 0, var_107_10 - 1 do
					local var_107_11 = var_107_8:GetChild(iter_107_4)

					if var_107_11.name == "split_4" then
						var_107_11:SetAsLastSibling()
						var_107_11.gameObject:SetActive(true)

						arg_104_1.var_.actorSpriteSplit128404 = var_107_11.gameObject:GetComponent(typeof(Image))

						arg_104_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_107_12 = 0.5

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_12 then
				local var_107_13 = (arg_104_1.time_ - var_107_9) / var_107_12
				local var_107_14 = Vector3.New(390.2, -356, -362.3)

				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos128404, var_107_14, var_107_13)

				if arg_104_1.var_.actorSpriteSplit128404 ~= nil then
					arg_104_1.var_.actorSpriteSplit128404:SetAlpha(var_107_13)
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_12 and arg_104_1.time_ < var_107_9 + var_107_12 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_104_1.var_.actorSpriteSplit128404 ~= nil then
					arg_104_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_107_15 = 0
			local var_107_16 = 0.525

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_17 = arg_104_1:FormatText(StoryNameCfg[6].name)

				arg_104_1.leftNameTxt_.text = var_107_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(938021025)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 21
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_16 or var_107_16 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_16 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_23 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_23 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_23

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_23 and arg_104_1.time_ < var_107_15 + var_107_23 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play938021026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 938021026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play938021027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["128404"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps128404 == nil then
				arg_108_1.var_.actorSpriteComps128404 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps128404 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 0.5, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps128404 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps128404 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.1

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_11 = arg_108_1:GetWordFromCfg(938021026)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 4
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play938021027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 938021027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play938021028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["128404"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps128404 == nil then
				arg_112_1.var_.actorSpriteComps128404 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps128404 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps128404 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps128404 = nil
			end

			local var_115_8 = arg_112_1.actors_["128404"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos128404 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("128404", 4)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "" then
						var_115_11:SetAsLastSibling()
						var_115_11.gameObject:SetActive(true)

						arg_112_1.var_.actorSpriteSplit128404 = var_115_11.gameObject:GetComponent(typeof(Image))

						arg_112_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_115_12 = 0.5

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(390.2, -356, -362.3)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos128404, var_115_14, var_115_13)

				if arg_112_1.var_.actorSpriteSplit128404 ~= nil then
					arg_112_1.var_.actorSpriteSplit128404:SetAlpha(var_115_13)
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_112_1.var_.actorSpriteSplit128404 ~= nil then
					arg_112_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_115_15 = 0
			local var_115_16 = 0.4

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(938021027)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 16
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_23 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_23 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_23

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_23 and arg_112_1.time_ < var_115_15 + var_115_23 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play938021028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 938021028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play938021029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["104902"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps104902 == nil then
				arg_116_1.var_.actorSpriteComps104902 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps104902 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps104902 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps104902 = nil
			end

			local var_119_8 = arg_116_1.actors_["128404"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps128404 == nil then
				arg_116_1.var_.actorSpriteComps128404 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps128404 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								local var_119_12 = Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, var_119_11)
								local var_119_13 = Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, var_119_11)
								local var_119_14 = Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, var_119_11)

								iter_119_5.color = Color.New(var_119_12, var_119_13, var_119_14)
							else
								local var_119_15 = Mathf.Lerp(iter_119_5.color.r, 0.5, var_119_11)

								iter_119_5.color = Color.New(var_119_15, var_119_15, var_119_15)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps128404 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps128404 = nil
			end

			local var_119_16 = arg_116_1.actors_["104902"].transform
			local var_119_17 = 0

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.var_.moveOldPos104902 = var_119_16.localPosition
				var_119_16.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("104902", 2)

				local var_119_18 = var_119_16.childCount

				for iter_119_8 = 0, var_119_18 - 1 do
					local var_119_19 = var_119_16:GetChild(iter_119_8)

					if var_119_19.name == "" or not string.find(var_119_19.name, "split") then
						var_119_19.gameObject:SetActive(true)
					else
						var_119_19.gameObject:SetActive(false)
					end
				end
			end

			local var_119_20 = 0.001

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_20 then
				local var_119_21 = (arg_116_1.time_ - var_119_17) / var_119_20
				local var_119_22 = Vector3.New(-390, -335, -360)

				var_119_16.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos104902, var_119_22, var_119_21)
			end

			if arg_116_1.time_ >= var_119_17 + var_119_20 and arg_116_1.time_ < var_119_17 + var_119_20 + arg_119_0 then
				var_119_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_119_23 = arg_116_1.actors_["108301"].transform
			local var_119_24 = 0

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1.var_.moveOldPos108301 = var_119_23.localPosition
				var_119_23.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("108301", 7)

				local var_119_25 = var_119_23.childCount

				for iter_119_9 = 0, var_119_25 - 1 do
					local var_119_26 = var_119_23:GetChild(iter_119_9)

					if var_119_26.name == "" or not string.find(var_119_26.name, "split") then
						var_119_26.gameObject:SetActive(true)
					else
						var_119_26.gameObject:SetActive(false)
					end
				end
			end

			local var_119_27 = 0.001

			if var_119_24 <= arg_116_1.time_ and arg_116_1.time_ < var_119_24 + var_119_27 then
				local var_119_28 = (arg_116_1.time_ - var_119_24) / var_119_27
				local var_119_29 = Vector3.New(0, -2000, 0)

				var_119_23.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos108301, var_119_29, var_119_28)
			end

			if arg_116_1.time_ >= var_119_24 + var_119_27 and arg_116_1.time_ < var_119_24 + var_119_27 + arg_119_0 then
				var_119_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_30 = 0
			local var_119_31 = 1.05

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_32 = arg_116_1:FormatText(StoryNameCfg[562].name)

				arg_116_1.leftNameTxt_.text = var_119_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_33 = arg_116_1:GetWordFromCfg(938021028)
				local var_119_34 = arg_116_1:FormatText(var_119_33.content)

				arg_116_1.text_.text = var_119_34

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_35 = 42
				local var_119_36 = utf8.len(var_119_34)
				local var_119_37 = var_119_35 <= 0 and var_119_31 or var_119_31 * (var_119_36 / var_119_35)

				if var_119_37 > 0 and var_119_31 < var_119_37 then
					arg_116_1.talkMaxDuration = var_119_37

					if var_119_37 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_37 + var_119_30
					end
				end

				arg_116_1.text_.text = var_119_34
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_38 = math.max(var_119_31, arg_116_1.talkMaxDuration)

			if var_119_30 <= arg_116_1.time_ and arg_116_1.time_ < var_119_30 + var_119_38 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_30) / var_119_38

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_30 + var_119_38 and arg_116_1.time_ < var_119_30 + var_119_38 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play938021029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 938021029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play938021030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["106603"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps106603 == nil then
				arg_120_1.var_.actorSpriteComps106603 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps106603 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps106603 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps106603 = nil
			end

			local var_123_8 = arg_120_1.actors_["104902"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps104902 == nil then
				arg_120_1.var_.actorSpriteComps104902 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps104902 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps104902 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps104902 = nil
			end

			local var_123_16 = arg_120_1.actors_["106603"].transform
			local var_123_17 = 0

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				arg_120_1.var_.moveOldPos106603 = var_123_16.localPosition
				var_123_16.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("106603", 2)

				local var_123_18 = var_123_16.childCount

				for iter_123_8 = 0, var_123_18 - 1 do
					local var_123_19 = var_123_16:GetChild(iter_123_8)

					if var_123_19.name == "" or not string.find(var_123_19.name, "split") then
						var_123_19.gameObject:SetActive(true)
					else
						var_123_19.gameObject:SetActive(false)
					end
				end
			end

			local var_123_20 = 0.001

			if var_123_17 <= arg_120_1.time_ and arg_120_1.time_ < var_123_17 + var_123_20 then
				local var_123_21 = (arg_120_1.time_ - var_123_17) / var_123_20
				local var_123_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_123_16.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos106603, var_123_22, var_123_21)
			end

			if arg_120_1.time_ >= var_123_17 + var_123_20 and arg_120_1.time_ < var_123_17 + var_123_20 + arg_123_0 then
				var_123_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_123_23 = arg_120_1.actors_["104902"].transform
			local var_123_24 = 0

			if var_123_24 < arg_120_1.time_ and arg_120_1.time_ <= var_123_24 + arg_123_0 then
				arg_120_1.var_.moveOldPos104902 = var_123_23.localPosition
				var_123_23.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("104902", 7)

				local var_123_25 = var_123_23.childCount

				for iter_123_9 = 0, var_123_25 - 1 do
					local var_123_26 = var_123_23:GetChild(iter_123_9)

					if var_123_26.name == "" or not string.find(var_123_26.name, "split") then
						var_123_26.gameObject:SetActive(true)
					else
						var_123_26.gameObject:SetActive(false)
					end
				end
			end

			local var_123_27 = 0.001

			if var_123_24 <= arg_120_1.time_ and arg_120_1.time_ < var_123_24 + var_123_27 then
				local var_123_28 = (arg_120_1.time_ - var_123_24) / var_123_27
				local var_123_29 = Vector3.New(0, -2000, -360)

				var_123_23.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos104902, var_123_29, var_123_28)
			end

			if arg_120_1.time_ >= var_123_24 + var_123_27 and arg_120_1.time_ < var_123_24 + var_123_27 + arg_123_0 then
				var_123_23.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_123_30 = 0
			local var_123_31 = 0.5

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_32 = arg_120_1:FormatText(StoryNameCfg[32].name)

				arg_120_1.leftNameTxt_.text = var_123_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_33 = arg_120_1:GetWordFromCfg(938021029)
				local var_123_34 = arg_120_1:FormatText(var_123_33.content)

				arg_120_1.text_.text = var_123_34

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_35 = 20
				local var_123_36 = utf8.len(var_123_34)
				local var_123_37 = var_123_35 <= 0 and var_123_31 or var_123_31 * (var_123_36 / var_123_35)

				if var_123_37 > 0 and var_123_31 < var_123_37 then
					arg_120_1.talkMaxDuration = var_123_37

					if var_123_37 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_37 + var_123_30
					end
				end

				arg_120_1.text_.text = var_123_34
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_38 = math.max(var_123_31, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_38 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_38

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_38 and arg_120_1.time_ < var_123_30 + var_123_38 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play938021030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 938021030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play938021031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["128404"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps128404 == nil then
				arg_124_1.var_.actorSpriteComps128404 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps128404 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 1, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps128404 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps128404 = nil
			end

			local var_127_8 = arg_124_1.actors_["106603"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps106603 == nil then
				arg_124_1.var_.actorSpriteComps106603 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps106603 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 0.5, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps106603 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps106603 = nil
			end

			local var_127_16 = arg_124_1.actors_["128404"].transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPos128404 = var_127_16.localPosition
				var_127_16.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("128404", 4)

				local var_127_18 = var_127_16.childCount

				for iter_127_8 = 0, var_127_18 - 1 do
					local var_127_19 = var_127_16:GetChild(iter_127_8)

					if var_127_19.name == "split_6" or not string.find(var_127_19.name, "split") then
						var_127_19.gameObject:SetActive(true)
					else
						var_127_19.gameObject:SetActive(false)
					end
				end
			end

			local var_127_20 = 0.001

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_17) / var_127_20
				local var_127_22 = Vector3.New(390.2, -356, -362.3)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos128404, var_127_22, var_127_21)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_20 and arg_124_1.time_ < var_127_17 + var_127_20 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_127_23 = 0
			local var_127_24 = 0.525

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[6].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(938021030)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 21
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_31 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_31 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_31

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_31 and arg_124_1.time_ < var_127_23 + var_127_31 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 938021031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play938021032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["106603"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps106603 == nil then
				arg_128_1.var_.actorSpriteComps106603 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps106603 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps106603 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps106603 = nil
			end

			local var_131_8 = arg_128_1.actors_["128404"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps128404 == nil then
				arg_128_1.var_.actorSpriteComps128404 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.2

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps128404 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps128404 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps128404 = nil
			end

			local var_131_16 = arg_128_1.actors_["106603"].transform
			local var_131_17 = 0

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.var_.moveOldPos106603 = var_131_16.localPosition
				var_131_16.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("106603", 2)

				local var_131_18 = var_131_16.childCount

				for iter_131_8 = 0, var_131_18 - 1 do
					local var_131_19 = var_131_16:GetChild(iter_131_8)

					if var_131_19.name == "split_6" or not string.find(var_131_19.name, "split") then
						var_131_19.gameObject:SetActive(true)
					else
						var_131_19.gameObject:SetActive(false)
					end
				end
			end

			local var_131_20 = 0.001

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_20 then
				local var_131_21 = (arg_128_1.time_ - var_131_17) / var_131_20
				local var_131_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_131_16.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos106603, var_131_22, var_131_21)
			end

			if arg_128_1.time_ >= var_131_17 + var_131_20 and arg_128_1.time_ < var_131_17 + var_131_20 + arg_131_0 then
				var_131_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_131_23 = 0
			local var_131_24 = 1.45

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_25 = arg_128_1:FormatText(StoryNameCfg[32].name)

				arg_128_1.leftNameTxt_.text = var_131_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_26 = arg_128_1:GetWordFromCfg(938021031)
				local var_131_27 = arg_128_1:FormatText(var_131_26.content)

				arg_128_1.text_.text = var_131_27

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_28 = 58
				local var_131_29 = utf8.len(var_131_27)
				local var_131_30 = var_131_28 <= 0 and var_131_24 or var_131_24 * (var_131_29 / var_131_28)

				if var_131_30 > 0 and var_131_24 < var_131_30 then
					arg_128_1.talkMaxDuration = var_131_30

					if var_131_30 + var_131_23 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_30 + var_131_23
					end
				end

				arg_128_1.text_.text = var_131_27
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_31 = math.max(var_131_24, arg_128_1.talkMaxDuration)

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_31 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_23) / var_131_31

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_23 + var_131_31 and arg_128_1.time_ < var_131_23 + var_131_31 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play938021032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 938021032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play938021033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["104902"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps104902 == nil then
				arg_132_1.var_.actorSpriteComps104902 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps104902 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps104902 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps104902 = nil
			end

			local var_135_8 = arg_132_1.actors_["106603"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps106603 == nil then
				arg_132_1.var_.actorSpriteComps106603 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps106603 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 0.5, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps106603 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps106603 = nil
			end

			local var_135_16 = arg_132_1.actors_["104902"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos104902 = var_135_16.localPosition
				var_135_16.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("104902", 2)

				local var_135_18 = var_135_16.childCount

				for iter_135_8 = 0, var_135_18 - 1 do
					local var_135_19 = var_135_16:GetChild(iter_135_8)

					if var_135_19.name == "split_2" or not string.find(var_135_19.name, "split") then
						var_135_19.gameObject:SetActive(true)
					else
						var_135_19.gameObject:SetActive(false)
					end
				end
			end

			local var_135_20 = 0.001

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_20 then
				local var_135_21 = (arg_132_1.time_ - var_135_17) / var_135_20
				local var_135_22 = Vector3.New(-390, -335, -360)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos104902, var_135_22, var_135_21)
			end

			if arg_132_1.time_ >= var_135_17 + var_135_20 and arg_132_1.time_ < var_135_17 + var_135_20 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_135_23 = arg_132_1.actors_["106603"].transform
			local var_135_24 = 0

			if var_135_24 < arg_132_1.time_ and arg_132_1.time_ <= var_135_24 + arg_135_0 then
				arg_132_1.var_.moveOldPos106603 = var_135_23.localPosition
				var_135_23.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("106603", 7)

				local var_135_25 = var_135_23.childCount

				for iter_135_9 = 0, var_135_25 - 1 do
					local var_135_26 = var_135_23:GetChild(iter_135_9)

					if var_135_26.name == "" or not string.find(var_135_26.name, "split") then
						var_135_26.gameObject:SetActive(true)
					else
						var_135_26.gameObject:SetActive(false)
					end
				end
			end

			local var_135_27 = 0.001

			if var_135_24 <= arg_132_1.time_ and arg_132_1.time_ < var_135_24 + var_135_27 then
				local var_135_28 = (arg_132_1.time_ - var_135_24) / var_135_27
				local var_135_29 = Vector3.New(0, -2000, 0)

				var_135_23.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos106603, var_135_29, var_135_28)
			end

			if arg_132_1.time_ >= var_135_24 + var_135_27 and arg_132_1.time_ < var_135_24 + var_135_27 + arg_135_0 then
				var_135_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_30 = 0
			local var_135_31 = 0.275

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_32 = arg_132_1:FormatText(StoryNameCfg[562].name)

				arg_132_1.leftNameTxt_.text = var_135_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_33 = arg_132_1:GetWordFromCfg(938021032)
				local var_135_34 = arg_132_1:FormatText(var_135_33.content)

				arg_132_1.text_.text = var_135_34

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_35 = 11
				local var_135_36 = utf8.len(var_135_34)
				local var_135_37 = var_135_35 <= 0 and var_135_31 or var_135_31 * (var_135_36 / var_135_35)

				if var_135_37 > 0 and var_135_31 < var_135_37 then
					arg_132_1.talkMaxDuration = var_135_37

					if var_135_37 + var_135_30 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_37 + var_135_30
					end
				end

				arg_132_1.text_.text = var_135_34
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_38 = math.max(var_135_31, arg_132_1.talkMaxDuration)

			if var_135_30 <= arg_132_1.time_ and arg_132_1.time_ < var_135_30 + var_135_38 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_30) / var_135_38

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_30 + var_135_38 and arg_132_1.time_ < var_135_30 + var_135_38 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play938021033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938021033
		arg_136_1.duration_ = 1

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"

			SetActive(arg_136_1.choicesGo_, true)

			for iter_137_0, iter_137_1 in ipairs(arg_136_1.choices_) do
				local var_137_0 = iter_137_0 <= 2

				SetActive(iter_137_1.go, var_137_0)
			end

			arg_136_1.choices_[1].txt.text = arg_136_1:FormatText(StoryChoiceCfg[1780].name)
			arg_136_1.choices_[2].txt.text = arg_136_1:FormatText(StoryChoiceCfg[1781].name)
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938021034(arg_136_1)
			end

			if arg_138_0 == 2 then
				arg_136_0:Play938021034(arg_136_1)
			end

			arg_136_1:RecordChoiceLog(938021033, 1780, 1781)
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["104902"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps104902 == nil then
				arg_136_1.var_.actorSpriteComps104902 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps104902 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 0.5, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps104902 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps104902 = nil
			end

			local var_139_8 = 0

			if var_139_8 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_9 = 0.6

			if arg_136_1.time_ >= var_139_8 + var_139_9 and arg_136_1.time_ < var_139_8 + var_139_9 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play938021034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938021034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938021035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.65

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(938021034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 26
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play938021035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938021035
		arg_144_1.duration_ = 9

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938021036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 2

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				local var_147_1 = manager.ui.mainCamera.transform.localPosition
				local var_147_2 = Vector3.New(0, 0, 10) + Vector3.New(var_147_1.x, var_147_1.y, 0)
				local var_147_3 = arg_144_1.bgs_.ST0119

				var_147_3.transform.localPosition = var_147_2
				var_147_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_4 = var_147_3:GetComponent("SpriteRenderer")

				if var_147_4 and var_147_4.sprite then
					local var_147_5 = (var_147_3.transform.localPosition - var_147_1).z
					local var_147_6 = manager.ui.mainCameraCom_
					local var_147_7 = 2 * var_147_5 * Mathf.Tan(var_147_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_147_8 = var_147_7 * var_147_6.aspect
					local var_147_9 = var_147_4.sprite.bounds.size.x
					local var_147_10 = var_147_4.sprite.bounds.size.y
					local var_147_11 = var_147_8 / var_147_9
					local var_147_12 = var_147_7 / var_147_10
					local var_147_13 = var_147_12 < var_147_11 and var_147_11 or var_147_12

					var_147_3.transform.localScale = Vector3.New(var_147_13, var_147_13, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "ST0119" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_147_14 = 4

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			local var_147_15 = 0.3

			if arg_144_1.time_ >= var_147_14 + var_147_15 and arg_144_1.time_ < var_147_14 + var_147_15 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_17 = 2

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_17 then
				local var_147_18 = (arg_144_1.time_ - var_147_16) / var_147_17
				local var_147_19 = Color.New(0, 0, 0)

				var_147_19.a = Mathf.Lerp(0, 1, var_147_18)
				arg_144_1.mask_.color = var_147_19
			end

			if arg_144_1.time_ >= var_147_16 + var_147_17 and arg_144_1.time_ < var_147_16 + var_147_17 + arg_147_0 then
				local var_147_20 = Color.New(0, 0, 0)

				var_147_20.a = 1
				arg_144_1.mask_.color = var_147_20
			end

			local var_147_21 = 2

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_22 = 2

			if var_147_21 <= arg_144_1.time_ and arg_144_1.time_ < var_147_21 + var_147_22 then
				local var_147_23 = (arg_144_1.time_ - var_147_21) / var_147_22
				local var_147_24 = Color.New(0, 0, 0)

				var_147_24.a = Mathf.Lerp(1, 0, var_147_23)
				arg_144_1.mask_.color = var_147_24
			end

			if arg_144_1.time_ >= var_147_21 + var_147_22 and arg_144_1.time_ < var_147_21 + var_147_22 + arg_147_0 then
				local var_147_25 = Color.New(0, 0, 0)
				local var_147_26 = 0

				arg_144_1.mask_.enabled = false
				var_147_25.a = var_147_26
				arg_144_1.mask_.color = var_147_25
			end

			local var_147_27 = arg_144_1.actors_["104902"].transform
			local var_147_28 = 1.966

			if var_147_28 < arg_144_1.time_ and arg_144_1.time_ <= var_147_28 + arg_147_0 then
				arg_144_1.var_.moveOldPos104902 = var_147_27.localPosition
				var_147_27.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("104902", 7)

				local var_147_29 = var_147_27.childCount

				for iter_147_2 = 0, var_147_29 - 1 do
					local var_147_30 = var_147_27:GetChild(iter_147_2)

					if var_147_30.name == "" or not string.find(var_147_30.name, "split") then
						var_147_30.gameObject:SetActive(true)
					else
						var_147_30.gameObject:SetActive(false)
					end
				end
			end

			local var_147_31 = 0.001

			if var_147_28 <= arg_144_1.time_ and arg_144_1.time_ < var_147_28 + var_147_31 then
				local var_147_32 = (arg_144_1.time_ - var_147_28) / var_147_31
				local var_147_33 = Vector3.New(0, -2000, -360)

				var_147_27.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos104902, var_147_33, var_147_32)
			end

			if arg_144_1.time_ >= var_147_28 + var_147_31 and arg_144_1.time_ < var_147_28 + var_147_31 + arg_147_0 then
				var_147_27.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_147_34 = arg_144_1.actors_["128404"].transform
			local var_147_35 = 1.966

			if var_147_35 < arg_144_1.time_ and arg_144_1.time_ <= var_147_35 + arg_147_0 then
				arg_144_1.var_.moveOldPos128404 = var_147_34.localPosition
				var_147_34.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("128404", 7)

				local var_147_36 = var_147_34.childCount

				for iter_147_3 = 0, var_147_36 - 1 do
					local var_147_37 = var_147_34:GetChild(iter_147_3)

					if var_147_37.name == "" or not string.find(var_147_37.name, "split") then
						var_147_37.gameObject:SetActive(true)
					else
						var_147_37.gameObject:SetActive(false)
					end
				end
			end

			local var_147_38 = 0.001

			if var_147_35 <= arg_144_1.time_ and arg_144_1.time_ < var_147_35 + var_147_38 then
				local var_147_39 = (arg_144_1.time_ - var_147_35) / var_147_38
				local var_147_40 = Vector3.New(0, -2000, 0)

				var_147_34.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos128404, var_147_40, var_147_39)
			end

			if arg_144_1.time_ >= var_147_35 + var_147_38 and arg_144_1.time_ < var_147_35 + var_147_38 + arg_147_0 then
				var_147_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_41 = 4
			local var_147_42 = 1.25

			if var_147_41 < arg_144_1.time_ and arg_144_1.time_ <= var_147_41 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_43 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_43:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_44 = arg_144_1:GetWordFromCfg(938021035)
				local var_147_45 = arg_144_1:FormatText(var_147_44.content)

				arg_144_1.text_.text = var_147_45

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_46 = 50
				local var_147_47 = utf8.len(var_147_45)
				local var_147_48 = var_147_46 <= 0 and var_147_42 or var_147_42 * (var_147_47 / var_147_46)

				if var_147_48 > 0 and var_147_42 < var_147_48 then
					arg_144_1.talkMaxDuration = var_147_48
					var_147_41 = var_147_41 + 0.3

					if var_147_48 + var_147_41 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_48 + var_147_41
					end
				end

				arg_144_1.text_.text = var_147_45
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_49 = var_147_41 + 0.3
			local var_147_50 = math.max(var_147_42, arg_144_1.talkMaxDuration)

			if var_147_49 <= arg_144_1.time_ and arg_144_1.time_ < var_147_49 + var_147_50 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_49) / var_147_50

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_49 + var_147_50 and arg_144_1.time_ < var_147_49 + var_147_50 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play938021036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 938021036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play938021037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10144"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10144 == nil then
				arg_150_1.var_.actorSpriteComps10144 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10144 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10144 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10144 = nil
			end

			local var_153_8 = arg_150_1.actors_["10144"].transform
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.var_.moveOldPos10144 = var_153_8.localPosition
				var_153_8.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("10144", 3)

				local var_153_10 = var_153_8.childCount

				for iter_153_4 = 0, var_153_10 - 1 do
					local var_153_11 = var_153_8:GetChild(iter_153_4)

					if var_153_11.name == "split_2" or not string.find(var_153_11.name, "split") then
						var_153_11.gameObject:SetActive(true)
					else
						var_153_11.gameObject:SetActive(false)
					end
				end
			end

			local var_153_12 = 0.001

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_9) / var_153_12
				local var_153_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10144, var_153_14, var_153_13)
			end

			if arg_150_1.time_ >= var_153_9 + var_153_12 and arg_150_1.time_ < var_153_9 + var_153_12 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_153_15 = arg_150_1.actors_["10144"]
			local var_153_16 = 0

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				local var_153_17 = var_153_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_153_17 then
					arg_150_1.var_.alphaOldValue10144 = var_153_17.alpha
					arg_150_1.var_.characterEffect10144 = var_153_17
				end

				arg_150_1.var_.alphaOldValue10144 = 0
			end

			local var_153_18 = 0.0333333333333333

			if var_153_16 <= arg_150_1.time_ and arg_150_1.time_ < var_153_16 + var_153_18 then
				local var_153_19 = (arg_150_1.time_ - var_153_16) / var_153_18
				local var_153_20 = Mathf.Lerp(arg_150_1.var_.alphaOldValue10144, 1, var_153_19)

				if arg_150_1.var_.characterEffect10144 then
					arg_150_1.var_.characterEffect10144.alpha = var_153_20
				end
			end

			if arg_150_1.time_ >= var_153_16 + var_153_18 and arg_150_1.time_ < var_153_16 + var_153_18 + arg_153_0 and arg_150_1.var_.characterEffect10144 then
				arg_150_1.var_.characterEffect10144.alpha = 1
			end

			local var_153_21 = 0
			local var_153_22 = 0.95

			if var_153_21 < arg_150_1.time_ and arg_150_1.time_ <= var_153_21 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_23 = arg_150_1:FormatText(StoryNameCfg[1297].name)

				arg_150_1.leftNameTxt_.text = var_153_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_24 = arg_150_1:GetWordFromCfg(938021036)
				local var_153_25 = arg_150_1:FormatText(var_153_24.content)

				arg_150_1.text_.text = var_153_25

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_26 = 38
				local var_153_27 = utf8.len(var_153_25)
				local var_153_28 = var_153_26 <= 0 and var_153_22 or var_153_22 * (var_153_27 / var_153_26)

				if var_153_28 > 0 and var_153_22 < var_153_28 then
					arg_150_1.talkMaxDuration = var_153_28

					if var_153_28 + var_153_21 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_28 + var_153_21
					end
				end

				arg_150_1.text_.text = var_153_25
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_29 = math.max(var_153_22, arg_150_1.talkMaxDuration)

			if var_153_21 <= arg_150_1.time_ and arg_150_1.time_ < var_153_21 + var_153_29 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_21) / var_153_29

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_21 + var_153_29 and arg_150_1.time_ < var_153_21 + var_153_29 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play938021037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938021037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938021038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10144"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos10144 = var_157_0.localPosition
				var_157_0.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("10144", 3)

				local var_157_2 = var_157_0.childCount

				for iter_157_0 = 0, var_157_2 - 1 do
					local var_157_3 = var_157_0:GetChild(iter_157_0)

					if var_157_3.name == "split_1" then
						var_157_3:SetAsLastSibling()
						var_157_3.gameObject:SetActive(true)

						arg_154_1.var_.actorSpriteSplit10144 = var_157_3.gameObject:GetComponent(typeof(Image))

						arg_154_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_157_4 = 0.5

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_4 then
				local var_157_5 = (arg_154_1.time_ - var_157_1) / var_157_4
				local var_157_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10144, var_157_6, var_157_5)

				if arg_154_1.var_.actorSpriteSplit10144 ~= nil then
					arg_154_1.var_.actorSpriteSplit10144:SetAlpha(var_157_5)
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_4 and arg_154_1.time_ < var_157_1 + var_157_4 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_154_1.var_.actorSpriteSplit10144 ~= nil then
					arg_154_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_157_7 = 0
			local var_157_8 = 0.625

			if var_157_7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_7 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_9 = arg_154_1:FormatText(StoryNameCfg[1297].name)

				arg_154_1.leftNameTxt_.text = var_157_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_10 = arg_154_1:GetWordFromCfg(938021037)
				local var_157_11 = arg_154_1:FormatText(var_157_10.content)

				arg_154_1.text_.text = var_157_11

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_12 = 25
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
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_15 = math.max(var_157_8, arg_154_1.talkMaxDuration)

			if var_157_7 <= arg_154_1.time_ and arg_154_1.time_ < var_157_7 + var_157_15 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_7) / var_157_15

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_7 + var_157_15 and arg_154_1.time_ < var_157_7 + var_157_15 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play938021038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938021038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938021039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10144"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10144 == nil then
				arg_158_1.var_.actorSpriteComps10144 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps10144 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 0.5, var_161_3)

								iter_161_1.color = Color.New(var_161_7, var_161_7, var_161_7)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10144 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps10144 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.125

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_10 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_11 = arg_158_1:GetWordFromCfg(938021038)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 5
				local var_161_14 = utf8.len(var_161_12)
				local var_161_15 = var_161_13 <= 0 and var_161_9 or var_161_9 * (var_161_14 / var_161_13)

				if var_161_15 > 0 and var_161_9 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_12
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play938021039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938021039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938021040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.35

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(938021039)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 54
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938021040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938021040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938021041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10144"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10144 == nil then
				arg_166_1.var_.actorSpriteComps10144 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10144 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10144 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10144 = nil
			end

			local var_169_8 = arg_166_1.actors_["10144"].transform
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.var_.moveOldPos10144 = var_169_8.localPosition
				var_169_8.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10144", 3)

				local var_169_10 = var_169_8.childCount

				for iter_169_4 = 0, var_169_10 - 1 do
					local var_169_11 = var_169_8:GetChild(iter_169_4)

					if var_169_11.name == "" or not string.find(var_169_11.name, "split") then
						var_169_11.gameObject:SetActive(true)
					else
						var_169_11.gameObject:SetActive(false)
					end
				end
			end

			local var_169_12 = 0.001

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_9) / var_169_12
				local var_169_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, var_169_14, var_169_13)
			end

			if arg_166_1.time_ >= var_169_9 + var_169_12 and arg_166_1.time_ < var_169_9 + var_169_12 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_169_15 = 0
			local var_169_16 = 0.975

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[1297].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(938021040)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 39
				local var_169_21 = utf8.len(var_169_19)
				local var_169_22 = var_169_20 <= 0 and var_169_16 or var_169_16 * (var_169_21 / var_169_20)

				if var_169_22 > 0 and var_169_16 < var_169_22 then
					arg_166_1.talkMaxDuration = var_169_22

					if var_169_22 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_15
					end
				end

				arg_166_1.text_.text = var_169_19
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_23 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_23 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_23

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_23 and arg_166_1.time_ < var_169_15 + var_169_23 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938021041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938021042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10144"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10144 == nil then
				arg_170_1.var_.actorSpriteComps10144 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10144 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor2.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor2.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor2.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 0.5, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10144 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10144 = nil
			end

			local var_173_8 = 0
			local var_173_9 = 0.225

			if var_173_8 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_10 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_11 = arg_170_1:GetWordFromCfg(938021041)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 9
				local var_173_14 = utf8.len(var_173_12)
				local var_173_15 = var_173_13 <= 0 and var_173_9 or var_173_9 * (var_173_14 / var_173_13)

				if var_173_15 > 0 and var_173_9 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play938021042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938021042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938021043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10144"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10144 == nil then
				arg_174_1.var_.actorSpriteComps10144 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps10144 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 1, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10144 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_8 = arg_174_1.actors_["10144"].transform
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.var_.moveOldPos10144 = var_177_8.localPosition
				var_177_8.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10144", 3)

				local var_177_10 = var_177_8.childCount

				for iter_177_4 = 0, var_177_10 - 1 do
					local var_177_11 = var_177_8:GetChild(iter_177_4)

					if var_177_11.name == "" or not string.find(var_177_11.name, "split") then
						var_177_11.gameObject:SetActive(true)
					else
						var_177_11.gameObject:SetActive(false)
					end
				end
			end

			local var_177_12 = 0.001

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_12 then
				local var_177_13 = (arg_174_1.time_ - var_177_9) / var_177_12
				local var_177_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_177_8.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10144, var_177_14, var_177_13)
			end

			if arg_174_1.time_ >= var_177_9 + var_177_12 and arg_174_1.time_ < var_177_9 + var_177_12 + arg_177_0 then
				var_177_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_177_15 = 0
			local var_177_16 = 1.6

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_17 = arg_174_1:FormatText(StoryNameCfg[1297].name)

				arg_174_1.leftNameTxt_.text = var_177_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_18 = arg_174_1:GetWordFromCfg(938021042)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_20 = 64
				local var_177_21 = utf8.len(var_177_19)
				local var_177_22 = var_177_20 <= 0 and var_177_16 or var_177_16 * (var_177_21 / var_177_20)

				if var_177_22 > 0 and var_177_16 < var_177_22 then
					arg_174_1.talkMaxDuration = var_177_22

					if var_177_22 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_23 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_23 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_23

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_23 and arg_174_1.time_ < var_177_15 + var_177_23 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938021043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938021044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10144"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = var_181_0.localPosition
				var_181_0.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 3)

				local var_181_2 = var_181_0.childCount

				for iter_181_0 = 0, var_181_2 - 1 do
					local var_181_3 = var_181_0:GetChild(iter_181_0)

					if var_181_3.name == "" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_4 then
				local var_181_5 = (arg_178_1.time_ - var_181_1) / var_181_4
				local var_181_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, var_181_6, var_181_5)
			end

			if arg_178_1.time_ >= var_181_1 + var_181_4 and arg_178_1.time_ < var_181_1 + var_181_4 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_181_7 = 0
			local var_181_8 = 1.075

			if var_181_7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_9 = arg_178_1:FormatText(StoryNameCfg[1297].name)

				arg_178_1.leftNameTxt_.text = var_181_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(938021043)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_12 = 43
				local var_181_13 = utf8.len(var_181_11)
				local var_181_14 = var_181_12 <= 0 and var_181_8 or var_181_8 * (var_181_13 / var_181_12)

				if var_181_14 > 0 and var_181_8 < var_181_14 then
					arg_178_1.talkMaxDuration = var_181_14

					if var_181_14 + var_181_7 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_7
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_15 = math.max(var_181_8, arg_178_1.talkMaxDuration)

			if var_181_7 <= arg_178_1.time_ and arg_178_1.time_ < var_181_7 + var_181_15 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_7) / var_181_15

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_7 + var_181_15 and arg_178_1.time_ < var_181_7 + var_181_15 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 938021044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play938021045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10144"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10144 == nil then
				arg_182_1.var_.actorSpriteComps10144 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps10144 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 0.5, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10144 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10144 = nil
			end

			local var_185_8 = arg_182_1.actors_["10144"].transform
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 then
				arg_182_1.var_.moveOldPos10144 = var_185_8.localPosition
				var_185_8.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10144", 7)

				local var_185_10 = var_185_8.childCount

				for iter_185_4 = 0, var_185_10 - 1 do
					local var_185_11 = var_185_8:GetChild(iter_185_4)

					if var_185_11.name == "" or not string.find(var_185_11.name, "split") then
						var_185_11.gameObject:SetActive(true)
					else
						var_185_11.gameObject:SetActive(false)
					end
				end
			end

			local var_185_12 = 0.001

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_12 then
				local var_185_13 = (arg_182_1.time_ - var_185_9) / var_185_12
				local var_185_14 = Vector3.New(0, -2000, 0)

				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10144, var_185_14, var_185_13)
			end

			if arg_182_1.time_ >= var_185_9 + var_185_12 and arg_182_1.time_ < var_185_9 + var_185_12 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_185_15 = 0
			local var_185_16 = 1.55

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_17 = arg_182_1:GetWordFromCfg(938021044)
				local var_185_18 = arg_182_1:FormatText(var_185_17.content)

				arg_182_1.text_.text = var_185_18

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_19 = 62
				local var_185_20 = utf8.len(var_185_18)
				local var_185_21 = var_185_19 <= 0 and var_185_16 or var_185_16 * (var_185_20 / var_185_19)

				if var_185_21 > 0 and var_185_16 < var_185_21 then
					arg_182_1.talkMaxDuration = var_185_21

					if var_185_21 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_21 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_18
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_22 and arg_182_1.time_ < var_185_15 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 938021045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play938021046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.55

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[7].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(938021045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 22
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play938021046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 938021046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play938021047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10144"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10144 == nil then
				arg_190_1.var_.actorSpriteComps10144 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps10144 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 1, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10144 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10144 = nil
			end

			local var_193_8 = arg_190_1.actors_["10144"].transform
			local var_193_9 = 0

			if var_193_9 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.var_.moveOldPos10144 = var_193_8.localPosition
				var_193_8.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10144", 3)

				local var_193_10 = var_193_8.childCount

				for iter_193_4 = 0, var_193_10 - 1 do
					local var_193_11 = var_193_8:GetChild(iter_193_4)

					if var_193_11.name == "split_7" or not string.find(var_193_11.name, "split") then
						var_193_11.gameObject:SetActive(true)
					else
						var_193_11.gameObject:SetActive(false)
					end
				end
			end

			local var_193_12 = 0.001

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_12 then
				local var_193_13 = (arg_190_1.time_ - var_193_9) / var_193_12
				local var_193_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10144, var_193_14, var_193_13)
			end

			if arg_190_1.time_ >= var_193_9 + var_193_12 and arg_190_1.time_ < var_193_9 + var_193_12 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_193_15 = 0
			local var_193_16 = 1

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[1297].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(938021046)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 40
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_23 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_23 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_23

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_23 and arg_190_1.time_ < var_193_15 + var_193_23 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play938021047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 938021047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play938021048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["10144"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps10144 == nil then
				arg_194_1.var_.actorSpriteComps10144 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps10144 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor2.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor2.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor2.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 0.5, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps10144 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_197_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps10144 = nil
			end

			local var_197_8 = 0
			local var_197_9 = 0.875

			if var_197_8 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_10 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_11 = arg_194_1:GetWordFromCfg(938021047)
				local var_197_12 = arg_194_1:FormatText(var_197_11.content)

				arg_194_1.text_.text = var_197_12

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 35
				local var_197_14 = utf8.len(var_197_12)
				local var_197_15 = var_197_13 <= 0 and var_197_9 or var_197_9 * (var_197_14 / var_197_13)

				if var_197_15 > 0 and var_197_9 < var_197_15 then
					arg_194_1.talkMaxDuration = var_197_15

					if var_197_15 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_12
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_16 and arg_194_1.time_ < var_197_8 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play938021048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 938021048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play938021049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10144"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10144 == nil then
				arg_198_1.var_.actorSpriteComps10144 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps10144 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 1, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10144 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10144 = nil
			end

			local var_201_8 = arg_198_1.actors_["10144"].transform
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.var_.moveOldPos10144 = var_201_8.localPosition
				var_201_8.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10144", 3)

				local var_201_10 = var_201_8.childCount

				for iter_201_4 = 0, var_201_10 - 1 do
					local var_201_11 = var_201_8:GetChild(iter_201_4)

					if var_201_11.name == "split_1" then
						var_201_11:SetAsLastSibling()
						var_201_11.gameObject:SetActive(true)

						arg_198_1.var_.actorSpriteSplit10144 = var_201_11.gameObject:GetComponent(typeof(Image))

						arg_198_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_201_12 = 0.5

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_12 then
				local var_201_13 = (arg_198_1.time_ - var_201_9) / var_201_12
				local var_201_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_201_8.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10144, var_201_14, var_201_13)

				if arg_198_1.var_.actorSpriteSplit10144 ~= nil then
					arg_198_1.var_.actorSpriteSplit10144:SetAlpha(var_201_13)
				end
			end

			if arg_198_1.time_ >= var_201_9 + var_201_12 and arg_198_1.time_ < var_201_9 + var_201_12 + arg_201_0 then
				var_201_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_198_1.var_.actorSpriteSplit10144 ~= nil then
					arg_198_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_201_15 = 0
			local var_201_16 = 1.575

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_17 = arg_198_1:FormatText(StoryNameCfg[1297].name)

				arg_198_1.leftNameTxt_.text = var_201_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_18 = arg_198_1:GetWordFromCfg(938021048)
				local var_201_19 = arg_198_1:FormatText(var_201_18.content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 63
				local var_201_21 = utf8.len(var_201_19)
				local var_201_22 = var_201_20 <= 0 and var_201_16 or var_201_16 * (var_201_21 / var_201_20)

				if var_201_22 > 0 and var_201_16 < var_201_22 then
					arg_198_1.talkMaxDuration = var_201_22

					if var_201_22 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_22 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_23 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_23 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_23

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_23 and arg_198_1.time_ < var_201_15 + var_201_23 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play938021049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 938021049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play938021050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10144"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos10144 = var_205_0.localPosition
				var_205_0.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10144", 3)

				local var_205_2 = var_205_0.childCount

				for iter_205_0 = 0, var_205_2 - 1 do
					local var_205_3 = var_205_0:GetChild(iter_205_0)

					if var_205_3.name == "" or not string.find(var_205_3.name, "split") then
						var_205_3.gameObject:SetActive(true)
					else
						var_205_3.gameObject:SetActive(false)
					end
				end
			end

			local var_205_4 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_4 then
				local var_205_5 = (arg_202_1.time_ - var_205_1) / var_205_4
				local var_205_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10144, var_205_6, var_205_5)
			end

			if arg_202_1.time_ >= var_205_1 + var_205_4 and arg_202_1.time_ < var_205_1 + var_205_4 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_205_7 = 0
			local var_205_8 = 1.1

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_9 = arg_202_1:FormatText(StoryNameCfg[1297].name)

				arg_202_1.leftNameTxt_.text = var_205_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_10 = arg_202_1:GetWordFromCfg(938021049)
				local var_205_11 = arg_202_1:FormatText(var_205_10.content)

				arg_202_1.text_.text = var_205_11

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_12 = 44
				local var_205_13 = utf8.len(var_205_11)
				local var_205_14 = var_205_12 <= 0 and var_205_8 or var_205_8 * (var_205_13 / var_205_12)

				if var_205_14 > 0 and var_205_8 < var_205_14 then
					arg_202_1.talkMaxDuration = var_205_14

					if var_205_14 + var_205_7 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_7
					end
				end

				arg_202_1.text_.text = var_205_11
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_15 = math.max(var_205_8, arg_202_1.talkMaxDuration)

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_15 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_7) / var_205_15

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_7 + var_205_15 and arg_202_1.time_ < var_205_7 + var_205_15 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938021050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938021051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10144"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10144 == nil then
				arg_206_1.var_.actorSpriteComps10144 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps10144 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor2.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor2.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor2.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 0.5, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10144 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10144 = nil
			end

			local var_209_8 = 0
			local var_209_9 = 0.65

			if var_209_8 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_10 = arg_206_1:FormatText(StoryNameCfg[7].name)

				arg_206_1.leftNameTxt_.text = var_209_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_11 = arg_206_1:GetWordFromCfg(938021050)
				local var_209_12 = arg_206_1:FormatText(var_209_11.content)

				arg_206_1.text_.text = var_209_12

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 26
				local var_209_14 = utf8.len(var_209_12)
				local var_209_15 = var_209_13 <= 0 and var_209_9 or var_209_9 * (var_209_14 / var_209_13)

				if var_209_15 > 0 and var_209_9 < var_209_15 then
					arg_206_1.talkMaxDuration = var_209_15

					if var_209_15 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_15 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_12
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play938021051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938021051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938021052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10144"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10144 == nil then
				arg_210_1.var_.actorSpriteComps10144 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10144 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 1, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10144 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10144 = nil
			end

			local var_213_8 = arg_210_1.actors_["10144"].transform
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1.var_.moveOldPos10144 = var_213_8.localPosition
				var_213_8.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10144", 3)

				local var_213_10 = var_213_8.childCount

				for iter_213_4 = 0, var_213_10 - 1 do
					local var_213_11 = var_213_8:GetChild(iter_213_4)

					if var_213_11.name == "split_2" then
						var_213_11:SetAsLastSibling()
						var_213_11.gameObject:SetActive(true)

						arg_210_1.var_.actorSpriteSplit10144 = var_213_11.gameObject:GetComponent(typeof(Image))

						arg_210_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_213_12 = 0.5

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_12 then
				local var_213_13 = (arg_210_1.time_ - var_213_9) / var_213_12
				local var_213_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_213_8.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10144, var_213_14, var_213_13)

				if arg_210_1.var_.actorSpriteSplit10144 ~= nil then
					arg_210_1.var_.actorSpriteSplit10144:SetAlpha(var_213_13)
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_12 and arg_210_1.time_ < var_213_9 + var_213_12 + arg_213_0 then
				var_213_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_210_1.var_.actorSpriteSplit10144 ~= nil then
					arg_210_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_213_15 = 0
			local var_213_16 = 0.675

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[1297].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(938021051)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 27
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_23 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_23 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_23

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_23 and arg_210_1.time_ < var_213_15 + var_213_23 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play938021052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938021052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938021053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 1.375

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1297].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(938021052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 55
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
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play938021053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938021053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938021054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10144"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10144 = var_221_0.localPosition
				var_221_0.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10144", 3)

				local var_221_2 = var_221_0.childCount

				for iter_221_0 = 0, var_221_2 - 1 do
					local var_221_3 = var_221_0:GetChild(iter_221_0)

					if var_221_3.name == "" then
						var_221_3:SetAsLastSibling()
						var_221_3.gameObject:SetActive(true)

						arg_218_1.var_.actorSpriteSplit10144 = var_221_3.gameObject:GetComponent(typeof(Image))

						arg_218_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_221_4 = 0.5

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_4 then
				local var_221_5 = (arg_218_1.time_ - var_221_1) / var_221_4
				local var_221_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10144, var_221_6, var_221_5)

				if arg_218_1.var_.actorSpriteSplit10144 ~= nil then
					arg_218_1.var_.actorSpriteSplit10144:SetAlpha(var_221_5)
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_4 and arg_218_1.time_ < var_221_1 + var_221_4 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_218_1.var_.actorSpriteSplit10144 ~= nil then
					arg_218_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_221_7 = 0
			local var_221_8 = 0.75

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_9 = arg_218_1:FormatText(StoryNameCfg[1297].name)

				arg_218_1.leftNameTxt_.text = var_221_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(938021053)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_12 = 30
				local var_221_13 = utf8.len(var_221_11)
				local var_221_14 = var_221_12 <= 0 and var_221_8 or var_221_8 * (var_221_13 / var_221_12)

				if var_221_14 > 0 and var_221_8 < var_221_14 then
					arg_218_1.talkMaxDuration = var_221_14

					if var_221_14 + var_221_7 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_7
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_15 = math.max(var_221_8, arg_218_1.talkMaxDuration)

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_15 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_7) / var_221_15

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_7 + var_221_15 and arg_218_1.time_ < var_221_7 + var_221_15 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938021054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938021054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938021055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10144"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10144 == nil then
				arg_222_1.var_.actorSpriteComps10144 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps10144 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10144 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10144 = nil
			end

			local var_225_8 = 0
			local var_225_9 = 0.55

			if var_225_8 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_10 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_11 = arg_222_1:GetWordFromCfg(938021054)
				local var_225_12 = arg_222_1:FormatText(var_225_11.content)

				arg_222_1.text_.text = var_225_12

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 22
				local var_225_14 = utf8.len(var_225_12)
				local var_225_15 = var_225_13 <= 0 and var_225_9 or var_225_9 * (var_225_14 / var_225_13)

				if var_225_15 > 0 and var_225_9 < var_225_15 then
					arg_222_1.talkMaxDuration = var_225_15

					if var_225_15 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_12
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_16 and arg_222_1.time_ < var_225_8 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play938021055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938021055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play938021056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10144"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10144 == nil then
				arg_226_1.var_.actorSpriteComps10144 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps10144 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 1, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10144 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10144 = nil
			end

			local var_229_8 = arg_226_1.actors_["10144"].transform
			local var_229_9 = 0

			if var_229_9 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 then
				arg_226_1.var_.moveOldPos10144 = var_229_8.localPosition
				var_229_8.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10144", 3)

				local var_229_10 = var_229_8.childCount

				for iter_229_4 = 0, var_229_10 - 1 do
					local var_229_11 = var_229_8:GetChild(iter_229_4)

					if var_229_11.name == "split_2" or not string.find(var_229_11.name, "split") then
						var_229_11.gameObject:SetActive(true)
					else
						var_229_11.gameObject:SetActive(false)
					end
				end
			end

			local var_229_12 = 0.001

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_12 then
				local var_229_13 = (arg_226_1.time_ - var_229_9) / var_229_12
				local var_229_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_229_8.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10144, var_229_14, var_229_13)
			end

			if arg_226_1.time_ >= var_229_9 + var_229_12 and arg_226_1.time_ < var_229_9 + var_229_12 + arg_229_0 then
				var_229_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_229_15 = 0
			local var_229_16 = 1.25

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_17 = arg_226_1:FormatText(StoryNameCfg[1297].name)

				arg_226_1.leftNameTxt_.text = var_229_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_18 = arg_226_1:GetWordFromCfg(938021055)
				local var_229_19 = arg_226_1:FormatText(var_229_18.content)

				arg_226_1.text_.text = var_229_19

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_20 = 50
				local var_229_21 = utf8.len(var_229_19)
				local var_229_22 = var_229_20 <= 0 and var_229_16 or var_229_16 * (var_229_21 / var_229_20)

				if var_229_22 > 0 and var_229_16 < var_229_22 then
					arg_226_1.talkMaxDuration = var_229_22

					if var_229_22 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_22 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_19
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_23 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_23 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_23

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_23 and arg_226_1.time_ < var_229_15 + var_229_23 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play938021056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 938021056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play938021057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10144"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10144 == nil then
				arg_230_1.var_.actorSpriteComps10144 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps10144 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 0.5, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10144 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10144 = nil
			end

			local var_233_8 = 0
			local var_233_9 = 0.7

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_10 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_11 = arg_230_1:GetWordFromCfg(938021056)
				local var_233_12 = arg_230_1:FormatText(var_233_11.content)

				arg_230_1.text_.text = var_233_12

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 28
				local var_233_14 = utf8.len(var_233_12)
				local var_233_15 = var_233_13 <= 0 and var_233_9 or var_233_9 * (var_233_14 / var_233_13)

				if var_233_15 > 0 and var_233_9 < var_233_15 then
					arg_230_1.talkMaxDuration = var_233_15

					if var_233_15 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_15 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_12
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play938021057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 938021057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play938021058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10144"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10144 == nil then
				arg_234_1.var_.actorSpriteComps10144 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps10144 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 1, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10144 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_237_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10144 = nil
			end

			local var_237_8 = arg_234_1.actors_["10144"].transform
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 then
				arg_234_1.var_.moveOldPos10144 = var_237_8.localPosition
				var_237_8.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10144", 3)

				local var_237_10 = var_237_8.childCount

				for iter_237_4 = 0, var_237_10 - 1 do
					local var_237_11 = var_237_8:GetChild(iter_237_4)

					if var_237_11.name == "split_1" then
						var_237_11:SetAsLastSibling()
						var_237_11.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit10144 = var_237_11.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_237_12 = 0.5

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_12 then
				local var_237_13 = (arg_234_1.time_ - var_237_9) / var_237_12
				local var_237_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_237_8.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10144, var_237_14, var_237_13)

				if arg_234_1.var_.actorSpriteSplit10144 ~= nil then
					arg_234_1.var_.actorSpriteSplit10144:SetAlpha(var_237_13)
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_12 and arg_234_1.time_ < var_237_9 + var_237_12 + arg_237_0 then
				var_237_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_234_1.var_.actorSpriteSplit10144 ~= nil then
					arg_234_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_237_15 = 0
			local var_237_16 = 1.5

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_17 = arg_234_1:FormatText(StoryNameCfg[1297].name)

				arg_234_1.leftNameTxt_.text = var_237_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(938021057)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_20 = 60
				local var_237_21 = utf8.len(var_237_19)
				local var_237_22 = var_237_20 <= 0 and var_237_16 or var_237_16 * (var_237_21 / var_237_20)

				if var_237_22 > 0 and var_237_16 < var_237_22 then
					arg_234_1.talkMaxDuration = var_237_22

					if var_237_22 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_15
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_23 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_23 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_23

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_23 and arg_234_1.time_ < var_237_15 + var_237_23 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play938021058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 938021058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play938021059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10144"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10144 == nil then
				arg_238_1.var_.actorSpriteComps10144 = var_241_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.actorSpriteComps10144 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								local var_241_4 = Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor2.r, var_241_3)
								local var_241_5 = Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor2.g, var_241_3)
								local var_241_6 = Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor2.b, var_241_3)

								iter_241_1.color = Color.New(var_241_4, var_241_5, var_241_6)
							else
								local var_241_7 = Mathf.Lerp(iter_241_1.color.r, 0.5, var_241_3)

								iter_241_1.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10144 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_241_3 then
						if arg_238_1.isInRecall_ then
							iter_241_3.color = arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_241_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps10144 = nil
			end

			local var_241_8 = 0
			local var_241_9 = 0.275

			if var_241_8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_10 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_11 = arg_238_1:GetWordFromCfg(938021058)
				local var_241_12 = arg_238_1:FormatText(var_241_11.content)

				arg_238_1.text_.text = var_241_12

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 11
				local var_241_14 = utf8.len(var_241_12)
				local var_241_15 = var_241_13 <= 0 and var_241_9 or var_241_9 * (var_241_14 / var_241_13)

				if var_241_15 > 0 and var_241_9 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_12
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_9, arg_238_1.talkMaxDuration)

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_8) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_8 + var_241_16 and arg_238_1.time_ < var_241_8 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play938021059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 938021059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play938021060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10144"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps10144 == nil then
				arg_242_1.var_.actorSpriteComps10144 = var_245_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.actorSpriteComps10144 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 1, var_245_3)

								iter_245_1.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps10144 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_245_3 then
						if arg_242_1.isInRecall_ then
							iter_245_3.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps10144 = nil
			end

			local var_245_8 = arg_242_1.actors_["10144"].transform
			local var_245_9 = 0

			if var_245_9 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.var_.moveOldPos10144 = var_245_8.localPosition
				var_245_8.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10144", 3)

				local var_245_10 = var_245_8.childCount

				for iter_245_4 = 0, var_245_10 - 1 do
					local var_245_11 = var_245_8:GetChild(iter_245_4)

					if var_245_11.name == "" or not string.find(var_245_11.name, "split") then
						var_245_11.gameObject:SetActive(true)
					else
						var_245_11.gameObject:SetActive(false)
					end
				end
			end

			local var_245_12 = 0.001

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_12 then
				local var_245_13 = (arg_242_1.time_ - var_245_9) / var_245_12
				local var_245_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_245_8.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10144, var_245_14, var_245_13)
			end

			if arg_242_1.time_ >= var_245_9 + var_245_12 and arg_242_1.time_ < var_245_9 + var_245_12 + arg_245_0 then
				var_245_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_245_15 = 0
			local var_245_16 = 0.175

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[1297].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(938021059)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 7
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_23 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_23 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_23

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_23 and arg_242_1.time_ < var_245_15 + var_245_23 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play938021060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 938021060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play938021061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10144"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps10144 == nil then
				arg_246_1.var_.actorSpriteComps10144 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps10144 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								local var_249_4 = Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, var_249_3)
								local var_249_5 = Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, var_249_3)
								local var_249_6 = Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, var_249_3)

								iter_249_1.color = Color.New(var_249_4, var_249_5, var_249_6)
							else
								local var_249_7 = Mathf.Lerp(iter_249_1.color.r, 0.5, var_249_3)

								iter_249_1.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps10144 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps10144 = nil
			end

			local var_249_8 = 0
			local var_249_9 = 0.4

			if var_249_8 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_10 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_11 = arg_246_1:GetWordFromCfg(938021060)
				local var_249_12 = arg_246_1:FormatText(var_249_11.content)

				arg_246_1.text_.text = var_249_12

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 16
				local var_249_14 = utf8.len(var_249_12)
				local var_249_15 = var_249_13 <= 0 and var_249_9 or var_249_9 * (var_249_14 / var_249_13)

				if var_249_15 > 0 and var_249_9 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_12
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play938021061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938021061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938021062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10144"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10144 = var_253_0.localPosition
				var_253_0.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10144", 7)

				local var_253_2 = var_253_0.childCount

				for iter_253_0 = 0, var_253_2 - 1 do
					local var_253_3 = var_253_0:GetChild(iter_253_0)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_4 then
				local var_253_5 = (arg_250_1.time_ - var_253_1) / var_253_4
				local var_253_6 = Vector3.New(0, -2000, 0)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10144, var_253_6, var_253_5)
			end

			if arg_250_1.time_ >= var_253_1 + var_253_4 and arg_250_1.time_ < var_253_1 + var_253_4 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_7 = 0
			local var_253_8 = 1.5

			if var_253_7 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(938021061)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 60
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_8 or var_253_8 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_8 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_7 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_7
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_8, arg_250_1.talkMaxDuration)

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_7) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_7 + var_253_14 and arg_250_1.time_ < var_253_7 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play938021062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938021062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938021063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = "104701"

			if arg_254_1.actors_[var_257_0] == nil then
				local var_257_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_257_1) then
					local var_257_2 = Object.Instantiate(var_257_1, arg_254_1.canvasGo_.transform)

					var_257_2.transform:SetSiblingIndex(1)

					var_257_2.name = var_257_0
					var_257_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_254_1.actors_[var_257_0] = var_257_2

					local var_257_3 = var_257_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_254_1.isInRecall_ then
						for iter_257_0, iter_257_1 in ipairs(var_257_3) do
							iter_257_1.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_257_4 = arg_254_1.actors_["104701"]
			local var_257_5 = 0

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 and not isNil(var_257_4) and arg_254_1.var_.actorSpriteComps104701 == nil then
				arg_254_1.var_.actorSpriteComps104701 = var_257_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_6 = 0.2

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_6 and not isNil(var_257_4) then
				local var_257_7 = (arg_254_1.time_ - var_257_5) / var_257_6

				if arg_254_1.var_.actorSpriteComps104701 then
					for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_257_3 then
							if arg_254_1.isInRecall_ then
								local var_257_8 = Mathf.Lerp(iter_257_3.color.r, arg_254_1.hightColor1.r, var_257_7)
								local var_257_9 = Mathf.Lerp(iter_257_3.color.g, arg_254_1.hightColor1.g, var_257_7)
								local var_257_10 = Mathf.Lerp(iter_257_3.color.b, arg_254_1.hightColor1.b, var_257_7)

								iter_257_3.color = Color.New(var_257_8, var_257_9, var_257_10)
							else
								local var_257_11 = Mathf.Lerp(iter_257_3.color.r, 1, var_257_7)

								iter_257_3.color = Color.New(var_257_11, var_257_11, var_257_11)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_5 + var_257_6 and arg_254_1.time_ < var_257_5 + var_257_6 + arg_257_0 and not isNil(var_257_4) and arg_254_1.var_.actorSpriteComps104701 then
				for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_257_5 then
						if arg_254_1.isInRecall_ then
							iter_257_5.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps104701 = nil
			end

			local var_257_12 = arg_254_1.actors_["104701"].transform
			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1.var_.moveOldPos104701 = var_257_12.localPosition
				var_257_12.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("104701", 2)

				local var_257_14 = var_257_12.childCount

				for iter_257_6 = 0, var_257_14 - 1 do
					local var_257_15 = var_257_12:GetChild(iter_257_6)

					if var_257_15.name == "split_1" or not string.find(var_257_15.name, "split") then
						var_257_15.gameObject:SetActive(true)
					else
						var_257_15.gameObject:SetActive(false)
					end
				end
			end

			local var_257_16 = 0.001

			if var_257_13 <= arg_254_1.time_ and arg_254_1.time_ < var_257_13 + var_257_16 then
				local var_257_17 = (arg_254_1.time_ - var_257_13) / var_257_16
				local var_257_18 = Vector3.New(-528.7, -386.8, -295)

				var_257_12.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos104701, var_257_18, var_257_17)
			end

			if arg_254_1.time_ >= var_257_13 + var_257_16 and arg_254_1.time_ < var_257_13 + var_257_16 + arg_257_0 then
				var_257_12.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_257_19 = arg_254_1.actors_["104701"]
			local var_257_20 = 0

			if var_257_20 < arg_254_1.time_ and arg_254_1.time_ <= var_257_20 + arg_257_0 then
				local var_257_21 = var_257_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_257_21 then
					arg_254_1.var_.alphaOldValue104701 = var_257_21.alpha
					arg_254_1.var_.characterEffect104701 = var_257_21
				end

				arg_254_1.var_.alphaOldValue104701 = 0
			end

			local var_257_22 = 0.5

			if var_257_20 <= arg_254_1.time_ and arg_254_1.time_ < var_257_20 + var_257_22 then
				local var_257_23 = (arg_254_1.time_ - var_257_20) / var_257_22
				local var_257_24 = Mathf.Lerp(arg_254_1.var_.alphaOldValue104701, 1, var_257_23)

				if arg_254_1.var_.characterEffect104701 then
					arg_254_1.var_.characterEffect104701.alpha = var_257_24
				end
			end

			if arg_254_1.time_ >= var_257_20 + var_257_22 and arg_254_1.time_ < var_257_20 + var_257_22 + arg_257_0 and arg_254_1.var_.characterEffect104701 then
				arg_254_1.var_.characterEffect104701.alpha = 1
			end

			local var_257_25 = 0
			local var_257_26 = 1.025

			if var_257_25 < arg_254_1.time_ and arg_254_1.time_ <= var_257_25 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_27 = arg_254_1:FormatText(StoryNameCfg[1296].name)

				arg_254_1.leftNameTxt_.text = var_257_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_28 = arg_254_1:GetWordFromCfg(938021062)
				local var_257_29 = arg_254_1:FormatText(var_257_28.content)

				arg_254_1.text_.text = var_257_29

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_30 = 41
				local var_257_31 = utf8.len(var_257_29)
				local var_257_32 = var_257_30 <= 0 and var_257_26 or var_257_26 * (var_257_31 / var_257_30)

				if var_257_32 > 0 and var_257_26 < var_257_32 then
					arg_254_1.talkMaxDuration = var_257_32

					if var_257_32 + var_257_25 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_32 + var_257_25
					end
				end

				arg_254_1.text_.text = var_257_29
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_33 = math.max(var_257_26, arg_254_1.talkMaxDuration)

			if var_257_25 <= arg_254_1.time_ and arg_254_1.time_ < var_257_25 + var_257_33 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_25) / var_257_33

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_25 + var_257_33 and arg_254_1.time_ < var_257_25 + var_257_33 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play938021063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938021063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938021064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["128404"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps128404 == nil then
				arg_258_1.var_.actorSpriteComps128404 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps128404 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								local var_261_4 = Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, var_261_3)
								local var_261_5 = Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, var_261_3)
								local var_261_6 = Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, var_261_3)

								iter_261_1.color = Color.New(var_261_4, var_261_5, var_261_6)
							else
								local var_261_7 = Mathf.Lerp(iter_261_1.color.r, 1, var_261_3)

								iter_261_1.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps128404 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps128404 = nil
			end

			local var_261_8 = arg_258_1.actors_["104701"]
			local var_261_9 = 0

			if var_261_9 < arg_258_1.time_ and arg_258_1.time_ <= var_261_9 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps104701 == nil then
				arg_258_1.var_.actorSpriteComps104701 = var_261_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_10 = 0.2

			if var_261_9 <= arg_258_1.time_ and arg_258_1.time_ < var_261_9 + var_261_10 and not isNil(var_261_8) then
				local var_261_11 = (arg_258_1.time_ - var_261_9) / var_261_10

				if arg_258_1.var_.actorSpriteComps104701 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								local var_261_12 = Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, var_261_11)
								local var_261_13 = Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, var_261_11)
								local var_261_14 = Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, var_261_11)

								iter_261_5.color = Color.New(var_261_12, var_261_13, var_261_14)
							else
								local var_261_15 = Mathf.Lerp(iter_261_5.color.r, 0.5, var_261_11)

								iter_261_5.color = Color.New(var_261_15, var_261_15, var_261_15)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_9 + var_261_10 and arg_258_1.time_ < var_261_9 + var_261_10 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps104701 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_261_7 then
						if arg_258_1.isInRecall_ then
							iter_261_7.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps104701 = nil
			end

			local var_261_16 = arg_258_1.actors_["128404"].transform
			local var_261_17 = 0

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.var_.moveOldPos128404 = var_261_16.localPosition
				var_261_16.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("128404", 4)

				local var_261_18 = var_261_16.childCount

				for iter_261_8 = 0, var_261_18 - 1 do
					local var_261_19 = var_261_16:GetChild(iter_261_8)

					if var_261_19.name == "split_3" or not string.find(var_261_19.name, "split") then
						var_261_19.gameObject:SetActive(true)
					else
						var_261_19.gameObject:SetActive(false)
					end
				end
			end

			local var_261_20 = 0.001

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_20 then
				local var_261_21 = (arg_258_1.time_ - var_261_17) / var_261_20
				local var_261_22 = Vector3.New(390.2, -356, -362.3)

				var_261_16.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos128404, var_261_22, var_261_21)
			end

			if arg_258_1.time_ >= var_261_17 + var_261_20 and arg_258_1.time_ < var_261_17 + var_261_20 + arg_261_0 then
				var_261_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_261_23 = arg_258_1.actors_["128404"]
			local var_261_24 = 0

			if var_261_24 < arg_258_1.time_ and arg_258_1.time_ <= var_261_24 + arg_261_0 then
				local var_261_25 = var_261_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_261_25 then
					arg_258_1.var_.alphaOldValue128404 = var_261_25.alpha
					arg_258_1.var_.characterEffect128404 = var_261_25
				end

				arg_258_1.var_.alphaOldValue128404 = 0
			end

			local var_261_26 = 0.5

			if var_261_24 <= arg_258_1.time_ and arg_258_1.time_ < var_261_24 + var_261_26 then
				local var_261_27 = (arg_258_1.time_ - var_261_24) / var_261_26
				local var_261_28 = Mathf.Lerp(arg_258_1.var_.alphaOldValue128404, 1, var_261_27)

				if arg_258_1.var_.characterEffect128404 then
					arg_258_1.var_.characterEffect128404.alpha = var_261_28
				end
			end

			if arg_258_1.time_ >= var_261_24 + var_261_26 and arg_258_1.time_ < var_261_24 + var_261_26 + arg_261_0 and arg_258_1.var_.characterEffect128404 then
				arg_258_1.var_.characterEffect128404.alpha = 1
			end

			local var_261_29 = 0
			local var_261_30 = 1.35

			if var_261_29 < arg_258_1.time_ and arg_258_1.time_ <= var_261_29 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_31 = arg_258_1:FormatText(StoryNameCfg[6].name)

				arg_258_1.leftNameTxt_.text = var_261_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_32 = arg_258_1:GetWordFromCfg(938021063)
				local var_261_33 = arg_258_1:FormatText(var_261_32.content)

				arg_258_1.text_.text = var_261_33

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_34 = 54
				local var_261_35 = utf8.len(var_261_33)
				local var_261_36 = var_261_34 <= 0 and var_261_30 or var_261_30 * (var_261_35 / var_261_34)

				if var_261_36 > 0 and var_261_30 < var_261_36 then
					arg_258_1.talkMaxDuration = var_261_36

					if var_261_36 + var_261_29 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_36 + var_261_29
					end
				end

				arg_258_1.text_.text = var_261_33
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_37 = math.max(var_261_30, arg_258_1.talkMaxDuration)

			if var_261_29 <= arg_258_1.time_ and arg_258_1.time_ < var_261_29 + var_261_37 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_29) / var_261_37

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_29 + var_261_37 and arg_258_1.time_ < var_261_29 + var_261_37 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play938021064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938021064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938021065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["104902"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps104902 == nil then
				arg_262_1.var_.actorSpriteComps104902 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps104902 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								local var_265_4 = Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, var_265_3)
								local var_265_5 = Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, var_265_3)
								local var_265_6 = Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, var_265_3)

								iter_265_1.color = Color.New(var_265_4, var_265_5, var_265_6)
							else
								local var_265_7 = Mathf.Lerp(iter_265_1.color.r, 1, var_265_3)

								iter_265_1.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps104902 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps104902 = nil
			end

			local var_265_8 = arg_262_1.actors_["128404"]
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = var_265_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_10 = 0.2

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_10 and not isNil(var_265_8) then
				local var_265_11 = (arg_262_1.time_ - var_265_9) / var_265_10

				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								local var_265_12 = Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, var_265_11)
								local var_265_13 = Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, var_265_11)
								local var_265_14 = Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, var_265_11)

								iter_265_5.color = Color.New(var_265_12, var_265_13, var_265_14)
							else
								local var_265_15 = Mathf.Lerp(iter_265_5.color.r, 0.5, var_265_11)

								iter_265_5.color = Color.New(var_265_15, var_265_15, var_265_15)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_9 + var_265_10 and arg_262_1.time_ < var_265_9 + var_265_10 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_7 then
						if arg_262_1.isInRecall_ then
							iter_265_7.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_16 = arg_262_1.actors_["104902"].transform
			local var_265_17 = 0

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.var_.moveOldPos104902 = var_265_16.localPosition
				var_265_16.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("104902", 3)

				local var_265_18 = var_265_16.childCount

				for iter_265_8 = 0, var_265_18 - 1 do
					local var_265_19 = var_265_16:GetChild(iter_265_8)

					if var_265_19.name == "split_2" or not string.find(var_265_19.name, "split") then
						var_265_19.gameObject:SetActive(true)
					else
						var_265_19.gameObject:SetActive(false)
					end
				end
			end

			local var_265_20 = 0.001

			if var_265_17 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_20 then
				local var_265_21 = (arg_262_1.time_ - var_265_17) / var_265_20
				local var_265_22 = Vector3.New(0, -335, -360)

				var_265_16.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos104902, var_265_22, var_265_21)
			end

			if arg_262_1.time_ >= var_265_17 + var_265_20 and arg_262_1.time_ < var_265_17 + var_265_20 + arg_265_0 then
				var_265_16.localPosition = Vector3.New(0, -335, -360)
			end

			local var_265_23 = arg_262_1.actors_["104701"].transform
			local var_265_24 = 0

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 then
				arg_262_1.var_.moveOldPos104701 = var_265_23.localPosition
				var_265_23.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("104701", 2)

				local var_265_25 = var_265_23.childCount

				for iter_265_9 = 0, var_265_25 - 1 do
					local var_265_26 = var_265_23:GetChild(iter_265_9)

					if var_265_26.name == "" or not string.find(var_265_26.name, "split") then
						var_265_26.gameObject:SetActive(true)
					else
						var_265_26.gameObject:SetActive(false)
					end
				end
			end

			local var_265_27 = 0.001

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_27 then
				local var_265_28 = (arg_262_1.time_ - var_265_24) / var_265_27
				local var_265_29 = Vector3.New(-528.7, -386.8, -295)

				var_265_23.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos104701, var_265_29, var_265_28)
			end

			if arg_262_1.time_ >= var_265_24 + var_265_27 and arg_262_1.time_ < var_265_24 + var_265_27 + arg_265_0 then
				var_265_23.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_265_30 = arg_262_1.actors_["104902"]
			local var_265_31 = 0

			if var_265_31 < arg_262_1.time_ and arg_262_1.time_ <= var_265_31 + arg_265_0 then
				local var_265_32 = var_265_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_265_32 then
					arg_262_1.var_.alphaOldValue104902 = var_265_32.alpha
					arg_262_1.var_.characterEffect104902 = var_265_32
				end

				arg_262_1.var_.alphaOldValue104902 = 0
			end

			local var_265_33 = 0.5

			if var_265_31 <= arg_262_1.time_ and arg_262_1.time_ < var_265_31 + var_265_33 then
				local var_265_34 = (arg_262_1.time_ - var_265_31) / var_265_33
				local var_265_35 = Mathf.Lerp(arg_262_1.var_.alphaOldValue104902, 1, var_265_34)

				if arg_262_1.var_.characterEffect104902 then
					arg_262_1.var_.characterEffect104902.alpha = var_265_35
				end
			end

			if arg_262_1.time_ >= var_265_31 + var_265_33 and arg_262_1.time_ < var_265_31 + var_265_33 + arg_265_0 and arg_262_1.var_.characterEffect104902 then
				arg_262_1.var_.characterEffect104902.alpha = 1
			end

			local var_265_36 = 0
			local var_265_37 = 0.975

			if var_265_36 < arg_262_1.time_ and arg_262_1.time_ <= var_265_36 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_38 = arg_262_1:FormatText(StoryNameCfg[562].name)

				arg_262_1.leftNameTxt_.text = var_265_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_39 = arg_262_1:GetWordFromCfg(938021064)
				local var_265_40 = arg_262_1:FormatText(var_265_39.content)

				arg_262_1.text_.text = var_265_40

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_41 = 39
				local var_265_42 = utf8.len(var_265_40)
				local var_265_43 = var_265_41 <= 0 and var_265_37 or var_265_37 * (var_265_42 / var_265_41)

				if var_265_43 > 0 and var_265_37 < var_265_43 then
					arg_262_1.talkMaxDuration = var_265_43

					if var_265_43 + var_265_36 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_43 + var_265_36
					end
				end

				arg_262_1.text_.text = var_265_40
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_44 = math.max(var_265_37, arg_262_1.talkMaxDuration)

			if var_265_36 <= arg_262_1.time_ and arg_262_1.time_ < var_265_36 + var_265_44 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_36) / var_265_44

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_36 + var_265_44 and arg_262_1.time_ < var_265_36 + var_265_44 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938021065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938021065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938021066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["104902"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps104902 == nil then
				arg_266_1.var_.actorSpriteComps104902 = var_269_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.actorSpriteComps104902 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								local var_269_4 = Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor2.r, var_269_3)
								local var_269_5 = Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor2.g, var_269_3)
								local var_269_6 = Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor2.b, var_269_3)

								iter_269_1.color = Color.New(var_269_4, var_269_5, var_269_6)
							else
								local var_269_7 = Mathf.Lerp(iter_269_1.color.r, 0.5, var_269_3)

								iter_269_1.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps104902 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_269_3 then
						if arg_266_1.isInRecall_ then
							iter_269_3.color = arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_269_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps104902 = nil
			end

			local var_269_8 = 0
			local var_269_9 = 0.25

			if var_269_8 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_10 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_11 = arg_266_1:GetWordFromCfg(938021065)
				local var_269_12 = arg_266_1:FormatText(var_269_11.content)

				arg_266_1.text_.text = var_269_12

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 10
				local var_269_14 = utf8.len(var_269_12)
				local var_269_15 = var_269_13 <= 0 and var_269_9 or var_269_9 * (var_269_14 / var_269_13)

				if var_269_15 > 0 and var_269_9 < var_269_15 then
					arg_266_1.talkMaxDuration = var_269_15

					if var_269_15 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_15 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_12
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_16 and arg_266_1.time_ < var_269_8 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play938021066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938021066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938021067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1.225

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(938021066)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 49
				local var_273_5 = utf8.len(var_273_3)
				local var_273_6 = var_273_4 <= 0 and var_273_1 or var_273_1 * (var_273_5 / var_273_4)

				if var_273_6 > 0 and var_273_1 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_7 and arg_270_1.time_ < var_273_0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play938021067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938021067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938021068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.325

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[1332].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_108301_split_5")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(938021067)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 13
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938021068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938021068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938021069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.475

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[32].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_4")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(938021068)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 19
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play938021069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 938021069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play938021070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["108301"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps108301 == nil then
				arg_282_1.var_.actorSpriteComps108301 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps108301 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 1, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps108301 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps108301 = nil
			end

			local var_285_8 = arg_282_1.actors_["106603"]
			local var_285_9 = 0

			if var_285_9 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps106603 == nil then
				arg_282_1.var_.actorSpriteComps106603 = var_285_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_10 = 0.2

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_10 and not isNil(var_285_8) then
				local var_285_11 = (arg_282_1.time_ - var_285_9) / var_285_10

				if arg_282_1.var_.actorSpriteComps106603 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								local var_285_12 = Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor2.r, var_285_11)
								local var_285_13 = Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor2.g, var_285_11)
								local var_285_14 = Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor2.b, var_285_11)

								iter_285_5.color = Color.New(var_285_12, var_285_13, var_285_14)
							else
								local var_285_15 = Mathf.Lerp(iter_285_5.color.r, 0.5, var_285_11)

								iter_285_5.color = Color.New(var_285_15, var_285_15, var_285_15)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_9 + var_285_10 and arg_282_1.time_ < var_285_9 + var_285_10 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps106603 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_285_7 then
						if arg_282_1.isInRecall_ then
							iter_285_7.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps106603 = nil
			end

			local var_285_16 = arg_282_1.actors_["108301"].transform
			local var_285_17 = 0

			if var_285_17 < arg_282_1.time_ and arg_282_1.time_ <= var_285_17 + arg_285_0 then
				arg_282_1.var_.moveOldPos108301 = var_285_16.localPosition
				var_285_16.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("108301", 2)

				local var_285_18 = var_285_16.childCount

				for iter_285_8 = 0, var_285_18 - 1 do
					local var_285_19 = var_285_16:GetChild(iter_285_8)

					if var_285_19.name == "split_2" or not string.find(var_285_19.name, "split") then
						var_285_19.gameObject:SetActive(true)
					else
						var_285_19.gameObject:SetActive(false)
					end
				end
			end

			local var_285_20 = 0.001

			if var_285_17 <= arg_282_1.time_ and arg_282_1.time_ < var_285_17 + var_285_20 then
				local var_285_21 = (arg_282_1.time_ - var_285_17) / var_285_20
				local var_285_22 = Vector3.New(-420, -360, -195)

				var_285_16.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos108301, var_285_22, var_285_21)
			end

			if arg_282_1.time_ >= var_285_17 + var_285_20 and arg_282_1.time_ < var_285_17 + var_285_20 + arg_285_0 then
				var_285_16.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_285_23 = arg_282_1.actors_["104701"].transform
			local var_285_24 = 0

			if var_285_24 < arg_282_1.time_ and arg_282_1.time_ <= var_285_24 + arg_285_0 then
				arg_282_1.var_.moveOldPos104701 = var_285_23.localPosition
				var_285_23.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("104701", 7)

				local var_285_25 = var_285_23.childCount

				for iter_285_9 = 0, var_285_25 - 1 do
					local var_285_26 = var_285_23:GetChild(iter_285_9)

					if var_285_26.name == "split_1" or not string.find(var_285_26.name, "split") then
						var_285_26.gameObject:SetActive(true)
					else
						var_285_26.gameObject:SetActive(false)
					end
				end
			end

			local var_285_27 = 0.001

			if var_285_24 <= arg_282_1.time_ and arg_282_1.time_ < var_285_24 + var_285_27 then
				local var_285_28 = (arg_282_1.time_ - var_285_24) / var_285_27
				local var_285_29 = Vector3.New(0, -2000, 0)

				var_285_23.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos104701, var_285_29, var_285_28)
			end

			if arg_282_1.time_ >= var_285_24 + var_285_27 and arg_282_1.time_ < var_285_24 + var_285_27 + arg_285_0 then
				var_285_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_30 = arg_282_1.actors_["104902"].transform
			local var_285_31 = 0

			if var_285_31 < arg_282_1.time_ and arg_282_1.time_ <= var_285_31 + arg_285_0 then
				arg_282_1.var_.moveOldPos104902 = var_285_30.localPosition
				var_285_30.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("104902", 7)

				local var_285_32 = var_285_30.childCount

				for iter_285_10 = 0, var_285_32 - 1 do
					local var_285_33 = var_285_30:GetChild(iter_285_10)

					if var_285_33.name == "split_1" or not string.find(var_285_33.name, "split") then
						var_285_33.gameObject:SetActive(true)
					else
						var_285_33.gameObject:SetActive(false)
					end
				end
			end

			local var_285_34 = 0.001

			if var_285_31 <= arg_282_1.time_ and arg_282_1.time_ < var_285_31 + var_285_34 then
				local var_285_35 = (arg_282_1.time_ - var_285_31) / var_285_34
				local var_285_36 = Vector3.New(0, -2000, 0)

				var_285_30.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos104902, var_285_36, var_285_35)
			end

			if arg_282_1.time_ >= var_285_31 + var_285_34 and arg_282_1.time_ < var_285_31 + var_285_34 + arg_285_0 then
				var_285_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_37 = arg_282_1.actors_["128404"].transform
			local var_285_38 = 0

			if var_285_38 < arg_282_1.time_ and arg_282_1.time_ <= var_285_38 + arg_285_0 then
				arg_282_1.var_.moveOldPos128404 = var_285_37.localPosition
				var_285_37.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("128404", 7)

				local var_285_39 = var_285_37.childCount

				for iter_285_11 = 0, var_285_39 - 1 do
					local var_285_40 = var_285_37:GetChild(iter_285_11)

					if var_285_40.name == "split_1" or not string.find(var_285_40.name, "split") then
						var_285_40.gameObject:SetActive(true)
					else
						var_285_40.gameObject:SetActive(false)
					end
				end
			end

			local var_285_41 = 0.001

			if var_285_38 <= arg_282_1.time_ and arg_282_1.time_ < var_285_38 + var_285_41 then
				local var_285_42 = (arg_282_1.time_ - var_285_38) / var_285_41
				local var_285_43 = Vector3.New(0, -2000, 0)

				var_285_37.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos128404, var_285_43, var_285_42)
			end

			if arg_282_1.time_ >= var_285_38 + var_285_41 and arg_282_1.time_ < var_285_38 + var_285_41 + arg_285_0 then
				var_285_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_44 = 0
			local var_285_45 = 0.7

			if var_285_44 < arg_282_1.time_ and arg_282_1.time_ <= var_285_44 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_46 = arg_282_1:FormatText(StoryNameCfg[1332].name)

				arg_282_1.leftNameTxt_.text = var_285_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_47 = arg_282_1:GetWordFromCfg(938021069)
				local var_285_48 = arg_282_1:FormatText(var_285_47.content)

				arg_282_1.text_.text = var_285_48

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_49 = 28
				local var_285_50 = utf8.len(var_285_48)
				local var_285_51 = var_285_49 <= 0 and var_285_45 or var_285_45 * (var_285_50 / var_285_49)

				if var_285_51 > 0 and var_285_45 < var_285_51 then
					arg_282_1.talkMaxDuration = var_285_51

					if var_285_51 + var_285_44 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_51 + var_285_44
					end
				end

				arg_282_1.text_.text = var_285_48
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_52 = math.max(var_285_45, arg_282_1.talkMaxDuration)

			if var_285_44 <= arg_282_1.time_ and arg_282_1.time_ < var_285_44 + var_285_52 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_44) / var_285_52

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_44 + var_285_52 and arg_282_1.time_ < var_285_44 + var_285_52 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play938021070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 938021070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play938021071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["106603"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps106603 == nil then
				arg_286_1.var_.actorSpriteComps106603 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps106603 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 1, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps106603 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps106603 = nil
			end

			local var_289_8 = arg_286_1.actors_["108301"]
			local var_289_9 = 0

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps108301 == nil then
				arg_286_1.var_.actorSpriteComps108301 = var_289_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_10 = 0.2

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_10 and not isNil(var_289_8) then
				local var_289_11 = (arg_286_1.time_ - var_289_9) / var_289_10

				if arg_286_1.var_.actorSpriteComps108301 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								local var_289_12 = Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, var_289_11)
								local var_289_13 = Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, var_289_11)
								local var_289_14 = Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, var_289_11)

								iter_289_5.color = Color.New(var_289_12, var_289_13, var_289_14)
							else
								local var_289_15 = Mathf.Lerp(iter_289_5.color.r, 0.5, var_289_11)

								iter_289_5.color = Color.New(var_289_15, var_289_15, var_289_15)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_9 + var_289_10 and arg_286_1.time_ < var_289_9 + var_289_10 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps108301 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_289_7 then
						if arg_286_1.isInRecall_ then
							iter_289_7.color = arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_289_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps108301 = nil
			end

			local var_289_16 = arg_286_1.actors_["106603"].transform
			local var_289_17 = 0

			if var_289_17 < arg_286_1.time_ and arg_286_1.time_ <= var_289_17 + arg_289_0 then
				arg_286_1.var_.moveOldPos106603 = var_289_16.localPosition
				var_289_16.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("106603", 4)

				local var_289_18 = var_289_16.childCount

				for iter_289_8 = 0, var_289_18 - 1 do
					local var_289_19 = var_289_16:GetChild(iter_289_8)

					if var_289_19.name == "" or not string.find(var_289_19.name, "split") then
						var_289_19.gameObject:SetActive(true)
					else
						var_289_19.gameObject:SetActive(false)
					end
				end
			end

			local var_289_20 = 0.001

			if var_289_17 <= arg_286_1.time_ and arg_286_1.time_ < var_289_17 + var_289_20 then
				local var_289_21 = (arg_286_1.time_ - var_289_17) / var_289_20
				local var_289_22 = Vector3.New(453.9, -399.1, -303.3)

				var_289_16.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos106603, var_289_22, var_289_21)
			end

			if arg_286_1.time_ >= var_289_17 + var_289_20 and arg_286_1.time_ < var_289_17 + var_289_20 + arg_289_0 then
				var_289_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_289_23 = 0
			local var_289_24 = 0.85

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_25 = arg_286_1:FormatText(StoryNameCfg[32].name)

				arg_286_1.leftNameTxt_.text = var_289_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_26 = arg_286_1:GetWordFromCfg(938021070)
				local var_289_27 = arg_286_1:FormatText(var_289_26.content)

				arg_286_1.text_.text = var_289_27

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_28 = 34
				local var_289_29 = utf8.len(var_289_27)
				local var_289_30 = var_289_28 <= 0 and var_289_24 or var_289_24 * (var_289_29 / var_289_28)

				if var_289_30 > 0 and var_289_24 < var_289_30 then
					arg_286_1.talkMaxDuration = var_289_30

					if var_289_30 + var_289_23 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_30 + var_289_23
					end
				end

				arg_286_1.text_.text = var_289_27
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_31 = math.max(var_289_24, arg_286_1.talkMaxDuration)

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_31 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_23) / var_289_31

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_23 + var_289_31 and arg_286_1.time_ < var_289_23 + var_289_31 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play938021071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938021071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938021072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["106603"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps106603 == nil then
				arg_290_1.var_.actorSpriteComps106603 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps106603 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 0.5, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps106603 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps106603 = nil
			end

			local var_293_8 = arg_290_1.actors_["106603"].transform
			local var_293_9 = 0

			if var_293_9 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.var_.moveOldPos106603 = var_293_8.localPosition
				var_293_8.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("106603", 7)

				local var_293_10 = var_293_8.childCount

				for iter_293_4 = 0, var_293_10 - 1 do
					local var_293_11 = var_293_8:GetChild(iter_293_4)

					if var_293_11.name == "" or not string.find(var_293_11.name, "split") then
						var_293_11.gameObject:SetActive(true)
					else
						var_293_11.gameObject:SetActive(false)
					end
				end
			end

			local var_293_12 = 0.001

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_12 then
				local var_293_13 = (arg_290_1.time_ - var_293_9) / var_293_12
				local var_293_14 = Vector3.New(0, -2000, 0)

				var_293_8.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos106603, var_293_14, var_293_13)
			end

			if arg_290_1.time_ >= var_293_9 + var_293_12 and arg_290_1.time_ < var_293_9 + var_293_12 + arg_293_0 then
				var_293_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_15 = arg_290_1.actors_["108301"].transform
			local var_293_16 = 0

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.var_.moveOldPos108301 = var_293_15.localPosition
				var_293_15.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("108301", 7)

				local var_293_17 = var_293_15.childCount

				for iter_293_5 = 0, var_293_17 - 1 do
					local var_293_18 = var_293_15:GetChild(iter_293_5)

					if var_293_18.name == "" or not string.find(var_293_18.name, "split") then
						var_293_18.gameObject:SetActive(true)
					else
						var_293_18.gameObject:SetActive(false)
					end
				end
			end

			local var_293_19 = 0.001

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_19 then
				local var_293_20 = (arg_290_1.time_ - var_293_16) / var_293_19
				local var_293_21 = Vector3.New(0, -2000, 0)

				var_293_15.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos108301, var_293_21, var_293_20)
			end

			if arg_290_1.time_ >= var_293_16 + var_293_19 and arg_290_1.time_ < var_293_16 + var_293_19 + arg_293_0 then
				var_293_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_22 = 0
			local var_293_23 = 1.425

			if var_293_22 < arg_290_1.time_ and arg_290_1.time_ <= var_293_22 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_24 = arg_290_1:GetWordFromCfg(938021071)
				local var_293_25 = arg_290_1:FormatText(var_293_24.content)

				arg_290_1.text_.text = var_293_25

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_26 = 57
				local var_293_27 = utf8.len(var_293_25)
				local var_293_28 = var_293_26 <= 0 and var_293_23 or var_293_23 * (var_293_27 / var_293_26)

				if var_293_28 > 0 and var_293_23 < var_293_28 then
					arg_290_1.talkMaxDuration = var_293_28

					if var_293_28 + var_293_22 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_28 + var_293_22
					end
				end

				arg_290_1.text_.text = var_293_25
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_29 = math.max(var_293_23, arg_290_1.talkMaxDuration)

			if var_293_22 <= arg_290_1.time_ and arg_290_1.time_ < var_293_22 + var_293_29 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_22) / var_293_29

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_22 + var_293_29 and arg_290_1.time_ < var_293_22 + var_293_29 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play938021072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938021072
		arg_294_1.duration_ = 5.6

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938021073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = manager.ui.mainCamera.transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.shakeOldPos = var_297_0.localPosition
			end

			local var_297_2 = 0.6

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / 0.066
				local var_297_4, var_297_5 = math.modf(var_297_3)

				var_297_0.localPosition = Vector3.New(var_297_5 * 0.13, var_297_5 * 0.13, var_297_5 * 0.13) + arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = arg_294_1.var_.shakeOldPos
			end

			local var_297_6 = 0

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			local var_297_7 = 0.6

			if arg_294_1.time_ >= var_297_6 + var_297_7 and arg_294_1.time_ < var_297_6 + var_297_7 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_8 = 0.6
			local var_297_9 = 0.525

			if var_297_8 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_10 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_10:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_11 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_12 = arg_294_1:GetWordFromCfg(938021072)
				local var_297_13 = arg_294_1:FormatText(var_297_12.content)

				arg_294_1.text_.text = var_297_13

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_14 = 21
				local var_297_15 = utf8.len(var_297_13)
				local var_297_16 = var_297_14 <= 0 and var_297_9 or var_297_9 * (var_297_15 / var_297_14)

				if var_297_16 > 0 and var_297_9 < var_297_16 then
					arg_294_1.talkMaxDuration = var_297_16
					var_297_8 = var_297_8 + 0.3

					if var_297_16 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_16 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_13
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_17 = var_297_8 + 0.3
			local var_297_18 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_17 <= arg_294_1.time_ and arg_294_1.time_ < var_297_17 + var_297_18 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_17) / var_297_18

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_17 + var_297_18 and arg_294_1.time_ < var_297_17 + var_297_18 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play938021073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 938021073
		arg_300_1.duration_ = 9

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play938021074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 2

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				local var_303_1 = manager.ui.mainCamera.transform.localPosition
				local var_303_2 = Vector3.New(0, 0, 10) + Vector3.New(var_303_1.x, var_303_1.y, 0)
				local var_303_3 = arg_300_1.bgs_.ST0119

				var_303_3.transform.localPosition = var_303_2
				var_303_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_4 = var_303_3:GetComponent("SpriteRenderer")

				if var_303_4 and var_303_4.sprite then
					local var_303_5 = (var_303_3.transform.localPosition - var_303_1).z
					local var_303_6 = manager.ui.mainCameraCom_
					local var_303_7 = 2 * var_303_5 * Mathf.Tan(var_303_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_303_8 = var_303_7 * var_303_6.aspect
					local var_303_9 = var_303_4.sprite.bounds.size.x
					local var_303_10 = var_303_4.sprite.bounds.size.y
					local var_303_11 = var_303_8 / var_303_9
					local var_303_12 = var_303_7 / var_303_10
					local var_303_13 = var_303_12 < var_303_11 and var_303_11 or var_303_12

					var_303_3.transform.localScale = Vector3.New(var_303_13, var_303_13, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "ST0119" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_14 = 4

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			local var_303_15 = 0.3

			if arg_300_1.time_ >= var_303_14 + var_303_15 and arg_300_1.time_ < var_303_14 + var_303_15 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_17 = 2

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_17 then
				local var_303_18 = (arg_300_1.time_ - var_303_16) / var_303_17
				local var_303_19 = Color.New(0, 0, 0)

				var_303_19.a = Mathf.Lerp(0, 1, var_303_18)
				arg_300_1.mask_.color = var_303_19
			end

			if arg_300_1.time_ >= var_303_16 + var_303_17 and arg_300_1.time_ < var_303_16 + var_303_17 + arg_303_0 then
				local var_303_20 = Color.New(0, 0, 0)

				var_303_20.a = 1
				arg_300_1.mask_.color = var_303_20
			end

			local var_303_21 = 2

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_22 = 2

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_22 then
				local var_303_23 = (arg_300_1.time_ - var_303_21) / var_303_22
				local var_303_24 = Color.New(0, 0, 0)

				var_303_24.a = Mathf.Lerp(1, 0, var_303_23)
				arg_300_1.mask_.color = var_303_24
			end

			if arg_300_1.time_ >= var_303_21 + var_303_22 and arg_300_1.time_ < var_303_21 + var_303_22 + arg_303_0 then
				local var_303_25 = Color.New(0, 0, 0)
				local var_303_26 = 0

				arg_300_1.mask_.enabled = false
				var_303_25.a = var_303_26
				arg_300_1.mask_.color = var_303_25
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_27 = 4
			local var_303_28 = 0.25

			if var_303_27 < arg_300_1.time_ and arg_300_1.time_ <= var_303_27 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_29 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_29:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_30 = arg_300_1:GetWordFromCfg(938021073)
				local var_303_31 = arg_300_1:FormatText(var_303_30.content)

				arg_300_1.text_.text = var_303_31

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_32 = 10
				local var_303_33 = utf8.len(var_303_31)
				local var_303_34 = var_303_32 <= 0 and var_303_28 or var_303_28 * (var_303_33 / var_303_32)

				if var_303_34 > 0 and var_303_28 < var_303_34 then
					arg_300_1.talkMaxDuration = var_303_34
					var_303_27 = var_303_27 + 0.3

					if var_303_34 + var_303_27 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_34 + var_303_27
					end
				end

				arg_300_1.text_.text = var_303_31
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_35 = var_303_27 + 0.3
			local var_303_36 = math.max(var_303_28, arg_300_1.talkMaxDuration)

			if var_303_35 <= arg_300_1.time_ and arg_300_1.time_ < var_303_35 + var_303_36 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_35) / var_303_36

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_35 + var_303_36 and arg_300_1.time_ < var_303_35 + var_303_36 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play938021074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938021074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938021075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["108301"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps108301 == nil then
				arg_306_1.var_.actorSpriteComps108301 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps108301 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 1, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps108301 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps108301 = nil
			end

			local var_309_8 = arg_306_1.actors_["108301"].transform
			local var_309_9 = 0

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 then
				arg_306_1.var_.moveOldPos108301 = var_309_8.localPosition
				var_309_8.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("108301", 3)

				local var_309_10 = var_309_8.childCount

				for iter_309_4 = 0, var_309_10 - 1 do
					local var_309_11 = var_309_8:GetChild(iter_309_4)

					if var_309_11.name == "" or not string.find(var_309_11.name, "split") then
						var_309_11.gameObject:SetActive(true)
					else
						var_309_11.gameObject:SetActive(false)
					end
				end
			end

			local var_309_12 = 0.001

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_12 then
				local var_309_13 = (arg_306_1.time_ - var_309_9) / var_309_12
				local var_309_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_309_8.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos108301, var_309_14, var_309_13)
			end

			if arg_306_1.time_ >= var_309_9 + var_309_12 and arg_306_1.time_ < var_309_9 + var_309_12 + arg_309_0 then
				var_309_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_309_15 = 0
			local var_309_16 = 0.45

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_17 = arg_306_1:FormatText(StoryNameCfg[1332].name)

				arg_306_1.leftNameTxt_.text = var_309_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_18 = arg_306_1:GetWordFromCfg(938021074)
				local var_309_19 = arg_306_1:FormatText(var_309_18.content)

				arg_306_1.text_.text = var_309_19

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_20 = 18
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
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_23 = math.max(var_309_16, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_23 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_15) / var_309_23

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_23 and arg_306_1.time_ < var_309_15 + var_309_23 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938021075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938021076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["108301"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps108301 == nil then
				arg_310_1.var_.actorSpriteComps108301 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps108301 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 0.5, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps108301 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps108301 = nil
			end

			local var_313_8 = 0
			local var_313_9 = 0.625

			if var_313_8 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_10 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_11 = arg_310_1:GetWordFromCfg(938021075)
				local var_313_12 = arg_310_1:FormatText(var_313_11.content)

				arg_310_1.text_.text = var_313_12

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 25
				local var_313_14 = utf8.len(var_313_12)
				local var_313_15 = var_313_13 <= 0 and var_313_9 or var_313_9 * (var_313_14 / var_313_13)

				if var_313_15 > 0 and var_313_9 < var_313_15 then
					arg_310_1.talkMaxDuration = var_313_15

					if var_313_15 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_15 + var_313_8
					end
				end

				arg_310_1.text_.text = var_313_12
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_9, arg_310_1.talkMaxDuration)

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_8) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_8 + var_313_16 and arg_310_1.time_ < var_313_8 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938021076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938021076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938021077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["108301"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps108301 == nil then
				arg_314_1.var_.actorSpriteComps108301 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps108301 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps108301 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps108301 = nil
			end

			local var_317_8 = 0
			local var_317_9 = 1.275

			if var_317_8 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_10 = arg_314_1:FormatText(StoryNameCfg[1332].name)

				arg_314_1.leftNameTxt_.text = var_317_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_11 = arg_314_1:GetWordFromCfg(938021076)
				local var_317_12 = arg_314_1:FormatText(var_317_11.content)

				arg_314_1.text_.text = var_317_12

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 51
				local var_317_14 = utf8.len(var_317_12)
				local var_317_15 = var_317_13 <= 0 and var_317_9 or var_317_9 * (var_317_14 / var_317_13)

				if var_317_15 > 0 and var_317_9 < var_317_15 then
					arg_314_1.talkMaxDuration = var_317_15

					if var_317_15 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_15 + var_317_8
					end
				end

				arg_314_1.text_.text = var_317_12
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_9, arg_314_1.talkMaxDuration)

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_8) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_8 + var_317_16 and arg_314_1.time_ < var_317_8 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play938021077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938021077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play938021078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["108301"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps108301 == nil then
				arg_318_1.var_.actorSpriteComps108301 = var_321_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.actorSpriteComps108301 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								local var_321_4 = Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, var_321_3)
								local var_321_5 = Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, var_321_3)
								local var_321_6 = Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, var_321_3)

								iter_321_1.color = Color.New(var_321_4, var_321_5, var_321_6)
							else
								local var_321_7 = Mathf.Lerp(iter_321_1.color.r, 0.5, var_321_3)

								iter_321_1.color = Color.New(var_321_7, var_321_7, var_321_7)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps108301 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_321_3 then
						if arg_318_1.isInRecall_ then
							iter_321_3.color = arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_321_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps108301 = nil
			end

			local var_321_8 = 0
			local var_321_9 = 0.45

			if var_321_8 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_10 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_11 = arg_318_1:GetWordFromCfg(938021077)
				local var_321_12 = arg_318_1:FormatText(var_321_11.content)

				arg_318_1.text_.text = var_321_12

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 18
				local var_321_14 = utf8.len(var_321_12)
				local var_321_15 = var_321_13 <= 0 and var_321_9 or var_321_9 * (var_321_14 / var_321_13)

				if var_321_15 > 0 and var_321_9 < var_321_15 then
					arg_318_1.talkMaxDuration = var_321_15

					if var_321_15 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_8
					end
				end

				arg_318_1.text_.text = var_321_12
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_9, arg_318_1.talkMaxDuration)

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_8) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_8 + var_321_16 and arg_318_1.time_ < var_321_8 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play938021078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 938021078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play938021079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["108301"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps108301 == nil then
				arg_322_1.var_.actorSpriteComps108301 = var_325_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.actorSpriteComps108301 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps108301 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_325_3 then
						if arg_322_1.isInRecall_ then
							iter_325_3.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_325_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps108301 = nil
			end

			local var_325_8 = 0
			local var_325_9 = 0.775

			if var_325_8 < arg_322_1.time_ and arg_322_1.time_ <= var_325_8 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_10 = arg_322_1:FormatText(StoryNameCfg[1332].name)

				arg_322_1.leftNameTxt_.text = var_325_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_11 = arg_322_1:GetWordFromCfg(938021078)
				local var_325_12 = arg_322_1:FormatText(var_325_11.content)

				arg_322_1.text_.text = var_325_12

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_13 = 31
				local var_325_14 = utf8.len(var_325_12)
				local var_325_15 = var_325_13 <= 0 and var_325_9 or var_325_9 * (var_325_14 / var_325_13)

				if var_325_15 > 0 and var_325_9 < var_325_15 then
					arg_322_1.talkMaxDuration = var_325_15

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

			local var_325_16 = math.max(var_325_9, arg_322_1.talkMaxDuration)

			if var_325_8 <= arg_322_1.time_ and arg_322_1.time_ < var_325_8 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_8) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_8 + var_325_16 and arg_322_1.time_ < var_325_8 + var_325_16 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play938021079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 938021079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play938021080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["108301"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps108301 == nil then
				arg_326_1.var_.actorSpriteComps108301 = var_329_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.actorSpriteComps108301 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								local var_329_4 = Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, var_329_3)
								local var_329_5 = Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, var_329_3)
								local var_329_6 = Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, var_329_3)

								iter_329_1.color = Color.New(var_329_4, var_329_5, var_329_6)
							else
								local var_329_7 = Mathf.Lerp(iter_329_1.color.r, 0.5, var_329_3)

								iter_329_1.color = Color.New(var_329_7, var_329_7, var_329_7)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps108301 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_329_3 then
						if arg_326_1.isInRecall_ then
							iter_329_3.color = arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_329_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps108301 = nil
			end

			local var_329_8 = 0
			local var_329_9 = 0.25

			if var_329_8 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_10 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_11 = arg_326_1:GetWordFromCfg(938021079)
				local var_329_12 = arg_326_1:FormatText(var_329_11.content)

				arg_326_1.text_.text = var_329_12

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 10
				local var_329_14 = utf8.len(var_329_12)
				local var_329_15 = var_329_13 <= 0 and var_329_9 or var_329_9 * (var_329_14 / var_329_13)

				if var_329_15 > 0 and var_329_9 < var_329_15 then
					arg_326_1.talkMaxDuration = var_329_15

					if var_329_15 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_15 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_12
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play938021080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 938021080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play938021081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["108301"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps108301 == nil then
				arg_330_1.var_.actorSpriteComps108301 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps108301 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 1, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps108301 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps108301 = nil
			end

			local var_333_8 = arg_330_1.actors_["108301"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos108301 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("108301", 3)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "split_2" then
						var_333_11:SetAsLastSibling()
						var_333_11.gameObject:SetActive(true)

						arg_330_1.var_.actorSpriteSplit108301 = var_333_11.gameObject:GetComponent(typeof(Image))

						arg_330_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_333_12 = 0.5

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos108301, var_333_14, var_333_13)

				if arg_330_1.var_.actorSpriteSplit108301 ~= nil then
					arg_330_1.var_.actorSpriteSplit108301:SetAlpha(var_333_13)
				end
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_330_1.var_.actorSpriteSplit108301 ~= nil then
					arg_330_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_333_15 = 0
			local var_333_16 = 0.1

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[1332].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(938021080)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 4
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_23 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_23 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_23

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_23 and arg_330_1.time_ < var_333_15 + var_333_23 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play938021081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 938021081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play938021082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["108301"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps108301 == nil then
				arg_334_1.var_.actorSpriteComps108301 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps108301 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 0.5, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps108301 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps108301 = nil
			end

			local var_337_8 = 0
			local var_337_9 = 0.1

			if var_337_8 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_10 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_11 = arg_334_1:GetWordFromCfg(938021081)
				local var_337_12 = arg_334_1:FormatText(var_337_11.content)

				arg_334_1.text_.text = var_337_12

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_13 = 4
				local var_337_14 = utf8.len(var_337_12)
				local var_337_15 = var_337_13 <= 0 and var_337_9 or var_337_9 * (var_337_14 / var_337_13)

				if var_337_15 > 0 and var_337_9 < var_337_15 then
					arg_334_1.talkMaxDuration = var_337_15

					if var_337_15 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_15 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_12
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_16 and arg_334_1.time_ < var_337_8 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play938021082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938021082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938021083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["108301"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps108301 == nil then
				arg_338_1.var_.actorSpriteComps108301 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps108301 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps108301 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps108301 = nil
			end

			local var_341_8 = arg_338_1.actors_["108301"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos108301 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("108301", 3)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "split_5" then
						var_341_11:SetAsLastSibling()
						var_341_11.gameObject:SetActive(true)

						arg_338_1.var_.actorSpriteSplit108301 = var_341_11.gameObject:GetComponent(typeof(Image))

						arg_338_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_341_12 = 0.5

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos108301, var_341_14, var_341_13)

				if arg_338_1.var_.actorSpriteSplit108301 ~= nil then
					arg_338_1.var_.actorSpriteSplit108301:SetAlpha(var_341_13)
				end
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_338_1.var_.actorSpriteSplit108301 ~= nil then
					arg_338_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_341_15 = 0
			local var_341_16 = 0.075

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[1332].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_18 = arg_338_1:GetWordFromCfg(938021082)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 3
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_23 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_23 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_23

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_23 and arg_338_1.time_ < var_341_15 + var_341_23 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play938021083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938021083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["108301"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps108301 == nil then
				arg_342_1.var_.actorSpriteComps108301 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps108301 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 0.5, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps108301 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps108301 = nil
			end

			local var_345_8 = 0
			local var_345_9 = 0.425

			if var_345_8 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_10 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_11 = arg_342_1:GetWordFromCfg(938021083)
				local var_345_12 = arg_342_1:FormatText(var_345_11.content)

				arg_342_1.text_.text = var_345_12

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 17
				local var_345_14 = utf8.len(var_345_12)
				local var_345_15 = var_345_13 <= 0 and var_345_9 or var_345_9 * (var_345_14 / var_345_13)

				if var_345_15 > 0 and var_345_9 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_12
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/ST0108"
	},
	voices = {}
}
