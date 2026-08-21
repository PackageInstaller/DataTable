return {
	Play929011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 929011001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play929011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0112"

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
				local var_4_5 = arg_1_1.bgs_.ST0112

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
					if iter_4_0 ~= "ST0112" then
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

			local var_4_24 = "10148"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

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

			local var_4_28 = arg_1_1.actors_["10148"]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 == nil then
				arg_1_1.var_.actorSpriteComps10148 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10148 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10148 = nil
			end

			local var_4_36 = arg_1_1.actors_["10148"].transform
			local var_4_37 = 0

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10148 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10148", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -350, -270)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10148, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -350, -270)
			end

			local var_4_43 = 0
			local var_4_44 = 0.2

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

			local var_4_49 = 0.3
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")
			end

			local var_4_53 = 0.2
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "effect"

				arg_1_1:AudioAction(var_4_55, var_4_56, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_4_57 = 0
			local var_4_58 = 1.1

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

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[1331].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(929011001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 44
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
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play929011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 929011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play929011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1083"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_11_4 = arg_8_1.actors_["1083"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1083 == nil then
				arg_8_1.var_.actorSpriteComps1083 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps1083 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1083 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1083 = nil
			end

			local var_11_12 = arg_8_1.actors_["10148"]
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps10148 == nil then
				arg_8_1.var_.actorSpriteComps10148 = var_11_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_14 = 0.2

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_14 and not isNil(var_11_12) then
				local var_11_15 = (arg_8_1.time_ - var_11_13) / var_11_14

				if arg_8_1.var_.actorSpriteComps10148 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_8_1.time_ >= var_11_13 + var_11_14 and arg_8_1.time_ < var_11_13 + var_11_14 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps10148 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_11_9 then
						if arg_8_1.isInRecall_ then
							iter_11_9.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10148 = nil
			end

			local var_11_20 = arg_8_1.actors_["10148"].transform
			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.var_.moveOldPos10148 = var_11_20.localPosition
				var_11_20.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10148", 2)

				local var_11_22 = var_11_20.childCount

				for iter_11_10 = 0, var_11_22 - 1 do
					local var_11_23 = var_11_20:GetChild(iter_11_10)

					if var_11_23.name == "" or not string.find(var_11_23.name, "split") then
						var_11_23.gameObject:SetActive(true)
					else
						var_11_23.gameObject:SetActive(false)
					end
				end
			end

			local var_11_24 = 0.001

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_24 then
				local var_11_25 = (arg_8_1.time_ - var_11_21) / var_11_24
				local var_11_26 = Vector3.New(-390, -350, -270)

				var_11_20.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10148, var_11_26, var_11_25)
			end

			if arg_8_1.time_ >= var_11_21 + var_11_24 and arg_8_1.time_ < var_11_21 + var_11_24 + arg_11_0 then
				var_11_20.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_11_27 = arg_8_1.actors_["1083"].transform
			local var_11_28 = 0

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1.var_.moveOldPos1083 = var_11_27.localPosition
				var_11_27.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1083", 4)

				local var_11_29 = var_11_27.childCount

				for iter_11_11 = 0, var_11_29 - 1 do
					local var_11_30 = var_11_27:GetChild(iter_11_11)

					if var_11_30.name == "" or not string.find(var_11_30.name, "split") then
						var_11_30.gameObject:SetActive(true)
					else
						var_11_30.gameObject:SetActive(false)
					end
				end
			end

			local var_11_31 = 0.001

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_31 then
				local var_11_32 = (arg_8_1.time_ - var_11_28) / var_11_31
				local var_11_33 = Vector3.New(390, -345, -345)

				var_11_27.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1083, var_11_33, var_11_32)
			end

			if arg_8_1.time_ >= var_11_28 + var_11_31 and arg_8_1.time_ < var_11_28 + var_11_31 + arg_11_0 then
				var_11_27.localPosition = Vector3.New(390, -345, -345)
			end

			local var_11_34 = 0
			local var_11_35 = 0.775

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_36 = arg_8_1:FormatText(StoryNameCfg[1332].name)

				arg_8_1.leftNameTxt_.text = var_11_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_37 = arg_8_1:GetWordFromCfg(929011002)
				local var_11_38 = arg_8_1:FormatText(var_11_37.content)

				arg_8_1.text_.text = var_11_38

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_39 = 31
				local var_11_40 = utf8.len(var_11_38)
				local var_11_41 = var_11_39 <= 0 and var_11_35 or var_11_35 * (var_11_40 / var_11_39)

				if var_11_41 > 0 and var_11_35 < var_11_41 then
					arg_8_1.talkMaxDuration = var_11_41

					if var_11_41 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_41 + var_11_34
					end
				end

				arg_8_1.text_.text = var_11_38
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_42 = math.max(var_11_35, arg_8_1.talkMaxDuration)

			if var_11_34 <= arg_8_1.time_ and arg_8_1.time_ < var_11_34 + var_11_42 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_34) / var_11_42

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_34 + var_11_42 and arg_8_1.time_ < var_11_34 + var_11_42 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 929011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play929011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10148"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10148 == nil then
				arg_12_1.var_.actorSpriteComps10148 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps10148 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 1, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10148 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10148 = nil
			end

			local var_15_8 = arg_12_1.actors_["1083"]
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps1083 == nil then
				arg_12_1.var_.actorSpriteComps1083 = var_15_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_10 = 0.2

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 and not isNil(var_15_8) then
				local var_15_11 = (arg_12_1.time_ - var_15_9) / var_15_10

				if arg_12_1.var_.actorSpriteComps1083 then
					for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_15_5 then
							if arg_12_1.isInRecall_ then
								local var_15_12 = Mathf.Lerp(iter_15_5.color.r, arg_12_1.hightColor2.r, var_15_11)
								local var_15_13 = Mathf.Lerp(iter_15_5.color.g, arg_12_1.hightColor2.g, var_15_11)
								local var_15_14 = Mathf.Lerp(iter_15_5.color.b, arg_12_1.hightColor2.b, var_15_11)

								iter_15_5.color = Color.New(var_15_12, var_15_13, var_15_14)
							else
								local var_15_15 = Mathf.Lerp(iter_15_5.color.r, 0.5, var_15_11)

								iter_15_5.color = Color.New(var_15_15, var_15_15, var_15_15)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps1083 then
				for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_15_7 then
						if arg_12_1.isInRecall_ then
							iter_15_7.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1083 = nil
			end

			local var_15_16 = arg_12_1.actors_["10148"].transform
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.var_.moveOldPos10148 = var_15_16.localPosition
				var_15_16.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10148", 2)

				local var_15_18 = var_15_16.childCount

				for iter_15_8 = 0, var_15_18 - 1 do
					local var_15_19 = var_15_16:GetChild(iter_15_8)

					if var_15_19.name == "split_4" or not string.find(var_15_19.name, "split") then
						var_15_19.gameObject:SetActive(true)
					else
						var_15_19.gameObject:SetActive(false)
					end
				end
			end

			local var_15_20 = 0.001

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_17) / var_15_20
				local var_15_22 = Vector3.New(-390, -350, -270)

				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10148, var_15_22, var_15_21)
			end

			if arg_12_1.time_ >= var_15_17 + var_15_20 and arg_12_1.time_ < var_15_17 + var_15_20 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_15_23 = arg_12_1.actors_["1083"].transform
			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1.var_.moveOldPos1083 = var_15_23.localPosition
				var_15_23.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1083", 4)

				local var_15_25 = var_15_23.childCount

				for iter_15_9 = 0, var_15_25 - 1 do
					local var_15_26 = var_15_23:GetChild(iter_15_9)

					if var_15_26.name == "" or not string.find(var_15_26.name, "split") then
						var_15_26.gameObject:SetActive(true)
					else
						var_15_26.gameObject:SetActive(false)
					end
				end
			end

			local var_15_27 = 0.001

			if var_15_24 <= arg_12_1.time_ and arg_12_1.time_ < var_15_24 + var_15_27 then
				local var_15_28 = (arg_12_1.time_ - var_15_24) / var_15_27
				local var_15_29 = Vector3.New(390, -345, -345)

				var_15_23.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1083, var_15_29, var_15_28)
			end

			if arg_12_1.time_ >= var_15_24 + var_15_27 and arg_12_1.time_ < var_15_24 + var_15_27 + arg_15_0 then
				var_15_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_15_30 = 0
			local var_15_31 = 0.85

			if var_15_30 < arg_12_1.time_ and arg_12_1.time_ <= var_15_30 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_32 = arg_12_1:FormatText(StoryNameCfg[1331].name)

				arg_12_1.leftNameTxt_.text = var_15_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_33 = arg_12_1:GetWordFromCfg(929011003)
				local var_15_34 = arg_12_1:FormatText(var_15_33.content)

				arg_12_1.text_.text = var_15_34

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_35 = 34
				local var_15_36 = utf8.len(var_15_34)
				local var_15_37 = var_15_35 <= 0 and var_15_31 or var_15_31 * (var_15_36 / var_15_35)

				if var_15_37 > 0 and var_15_31 < var_15_37 then
					arg_12_1.talkMaxDuration = var_15_37

					if var_15_37 + var_15_30 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_37 + var_15_30
					end
				end

				arg_12_1.text_.text = var_15_34
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_38 = math.max(var_15_31, arg_12_1.talkMaxDuration)

			if var_15_30 <= arg_12_1.time_ and arg_12_1.time_ < var_15_30 + var_15_38 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_30) / var_15_38

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_30 + var_15_38 and arg_12_1.time_ < var_15_30 + var_15_38 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 929011004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play929011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1083"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1083 == nil then
				arg_16_1.var_.actorSpriteComps1083 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps1083 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1083 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps1083 = nil
			end

			local var_19_8 = arg_16_1.actors_["10148"]
			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps10148 == nil then
				arg_16_1.var_.actorSpriteComps10148 = var_19_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_10 = 0.2

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 and not isNil(var_19_8) then
				local var_19_11 = (arg_16_1.time_ - var_19_9) / var_19_10

				if arg_16_1.var_.actorSpriteComps10148 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_19_5 then
							if arg_16_1.isInRecall_ then
								local var_19_12 = Mathf.Lerp(iter_19_5.color.r, arg_16_1.hightColor2.r, var_19_11)
								local var_19_13 = Mathf.Lerp(iter_19_5.color.g, arg_16_1.hightColor2.g, var_19_11)
								local var_19_14 = Mathf.Lerp(iter_19_5.color.b, arg_16_1.hightColor2.b, var_19_11)

								iter_19_5.color = Color.New(var_19_12, var_19_13, var_19_14)
							else
								local var_19_15 = Mathf.Lerp(iter_19_5.color.r, 0.5, var_19_11)

								iter_19_5.color = Color.New(var_19_15, var_19_15, var_19_15)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps10148 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_19_7 then
						if arg_16_1.isInRecall_ then
							iter_19_7.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10148 = nil
			end

			local var_19_16 = arg_16_1.actors_["10148"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos10148 = var_19_16.localPosition
				var_19_16.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10148", 2)

				local var_19_18 = var_19_16.childCount

				for iter_19_8 = 0, var_19_18 - 1 do
					local var_19_19 = var_19_16:GetChild(iter_19_8)

					if var_19_19.name == "split_4" or not string.find(var_19_19.name, "split") then
						var_19_19.gameObject:SetActive(true)
					else
						var_19_19.gameObject:SetActive(false)
					end
				end
			end

			local var_19_20 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_17) / var_19_20
				local var_19_22 = Vector3.New(-390, -350, -270)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10148, var_19_22, var_19_21)
			end

			if arg_16_1.time_ >= var_19_17 + var_19_20 and arg_16_1.time_ < var_19_17 + var_19_20 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_19_23 = arg_16_1.actors_["1083"].transform
			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.var_.moveOldPos1083 = var_19_23.localPosition
				var_19_23.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("1083", 4)

				local var_19_25 = var_19_23.childCount

				for iter_19_9 = 0, var_19_25 - 1 do
					local var_19_26 = var_19_23:GetChild(iter_19_9)

					if var_19_26.name == "split_6" or not string.find(var_19_26.name, "split") then
						var_19_26.gameObject:SetActive(true)
					else
						var_19_26.gameObject:SetActive(false)
					end
				end
			end

			local var_19_27 = 0.001

			if var_19_24 <= arg_16_1.time_ and arg_16_1.time_ < var_19_24 + var_19_27 then
				local var_19_28 = (arg_16_1.time_ - var_19_24) / var_19_27
				local var_19_29 = Vector3.New(390, -345, -345)

				var_19_23.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1083, var_19_29, var_19_28)
			end

			if arg_16_1.time_ >= var_19_24 + var_19_27 and arg_16_1.time_ < var_19_24 + var_19_27 + arg_19_0 then
				var_19_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_19_30 = 0
			local var_19_31 = 0.4

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_32 = arg_16_1:FormatText(StoryNameCfg[1332].name)

				arg_16_1.leftNameTxt_.text = var_19_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_33 = arg_16_1:GetWordFromCfg(929011004)
				local var_19_34 = arg_16_1:FormatText(var_19_33.content)

				arg_16_1.text_.text = var_19_34

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_35 = 16
				local var_19_36 = utf8.len(var_19_34)
				local var_19_37 = var_19_35 <= 0 and var_19_31 or var_19_31 * (var_19_36 / var_19_35)

				if var_19_37 > 0 and var_19_31 < var_19_37 then
					arg_16_1.talkMaxDuration = var_19_37

					if var_19_37 + var_19_30 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_37 + var_19_30
					end
				end

				arg_16_1.text_.text = var_19_34
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_38 = math.max(var_19_31, arg_16_1.talkMaxDuration)

			if var_19_30 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_38 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_30) / var_19_38

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_30 + var_19_38 and arg_16_1.time_ < var_19_30 + var_19_38 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 929011005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play929011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10148"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10148 == nil then
				arg_20_1.var_.actorSpriteComps10148 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps10148 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								local var_23_4 = Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, var_23_3)
								local var_23_5 = Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, var_23_3)
								local var_23_6 = Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, var_23_3)

								iter_23_1.color = Color.New(var_23_4, var_23_5, var_23_6)
							else
								local var_23_7 = Mathf.Lerp(iter_23_1.color.r, 1, var_23_3)

								iter_23_1.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10148 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10148 = nil
			end

			local var_23_8 = arg_20_1.actors_["1083"]
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps1083 == nil then
				arg_20_1.var_.actorSpriteComps1083 = var_23_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_10 = 0.2

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_10 and not isNil(var_23_8) then
				local var_23_11 = (arg_20_1.time_ - var_23_9) / var_23_10

				if arg_20_1.var_.actorSpriteComps1083 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_23_5 then
							if arg_20_1.isInRecall_ then
								local var_23_12 = Mathf.Lerp(iter_23_5.color.r, arg_20_1.hightColor2.r, var_23_11)
								local var_23_13 = Mathf.Lerp(iter_23_5.color.g, arg_20_1.hightColor2.g, var_23_11)
								local var_23_14 = Mathf.Lerp(iter_23_5.color.b, arg_20_1.hightColor2.b, var_23_11)

								iter_23_5.color = Color.New(var_23_12, var_23_13, var_23_14)
							else
								local var_23_15 = Mathf.Lerp(iter_23_5.color.r, 0.5, var_23_11)

								iter_23_5.color = Color.New(var_23_15, var_23_15, var_23_15)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_9 + var_23_10 and arg_20_1.time_ < var_23_9 + var_23_10 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps1083 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_23_7 then
						if arg_20_1.isInRecall_ then
							iter_23_7.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps1083 = nil
			end

			local var_23_16 = arg_20_1.actors_["10148"].transform
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.var_.moveOldPos10148 = var_23_16.localPosition
				var_23_16.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10148", 3)

				local var_23_18 = var_23_16.childCount

				for iter_23_8 = 0, var_23_18 - 1 do
					local var_23_19 = var_23_16:GetChild(iter_23_8)

					if var_23_19.name == "split_3" or not string.find(var_23_19.name, "split") then
						var_23_19.gameObject:SetActive(true)
					else
						var_23_19.gameObject:SetActive(false)
					end
				end
			end

			local var_23_20 = 0.001

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_20 then
				local var_23_21 = (arg_20_1.time_ - var_23_17) / var_23_20
				local var_23_22 = Vector3.New(0, -350, -270)

				var_23_16.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10148, var_23_22, var_23_21)
			end

			if arg_20_1.time_ >= var_23_17 + var_23_20 and arg_20_1.time_ < var_23_17 + var_23_20 + arg_23_0 then
				var_23_16.localPosition = Vector3.New(0, -350, -270)
			end

			local var_23_23 = arg_20_1.actors_["1083"].transform
			local var_23_24 = 0

			if var_23_24 < arg_20_1.time_ and arg_20_1.time_ <= var_23_24 + arg_23_0 then
				arg_20_1.var_.moveOldPos1083 = var_23_23.localPosition
				var_23_23.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1083", 7)

				local var_23_25 = var_23_23.childCount

				for iter_23_9 = 0, var_23_25 - 1 do
					local var_23_26 = var_23_23:GetChild(iter_23_9)

					if var_23_26.name == "" or not string.find(var_23_26.name, "split") then
						var_23_26.gameObject:SetActive(true)
					else
						var_23_26.gameObject:SetActive(false)
					end
				end
			end

			local var_23_27 = 0.001

			if var_23_24 <= arg_20_1.time_ and arg_20_1.time_ < var_23_24 + var_23_27 then
				local var_23_28 = (arg_20_1.time_ - var_23_24) / var_23_27
				local var_23_29 = Vector3.New(0, -2000, 0)

				var_23_23.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1083, var_23_29, var_23_28)
			end

			if arg_20_1.time_ >= var_23_24 + var_23_27 and arg_20_1.time_ < var_23_24 + var_23_27 + arg_23_0 then
				var_23_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_23_30 = 0
			local var_23_31 = 0.675

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_32 = arg_20_1:FormatText(StoryNameCfg[1331].name)

				arg_20_1.leftNameTxt_.text = var_23_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_33 = arg_20_1:GetWordFromCfg(929011005)
				local var_23_34 = arg_20_1:FormatText(var_23_33.content)

				arg_20_1.text_.text = var_23_34

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_35 = 27
				local var_23_36 = utf8.len(var_23_34)
				local var_23_37 = var_23_35 <= 0 and var_23_31 or var_23_31 * (var_23_36 / var_23_35)

				if var_23_37 > 0 and var_23_31 < var_23_37 then
					arg_20_1.talkMaxDuration = var_23_37

					if var_23_37 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_37 + var_23_30
					end
				end

				arg_20_1.text_.text = var_23_34
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_38 = math.max(var_23_31, arg_20_1.talkMaxDuration)

			if var_23_30 <= arg_20_1.time_ and arg_20_1.time_ < var_23_30 + var_23_38 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_30) / var_23_38

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_30 + var_23_38 and arg_20_1.time_ < var_23_30 + var_23_38 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play929011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 929011006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play929011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10148"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10148 == nil then
				arg_24_1.var_.actorSpriteComps10148 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps10148 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 0.5, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10148 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10148 = nil
			end

			local var_27_8 = arg_24_1.actors_["10148"].transform
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.var_.moveOldPos10148 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10148", 3)

				local var_27_10 = var_27_8.childCount

				for iter_27_4 = 0, var_27_10 - 1 do
					local var_27_11 = var_27_8:GetChild(iter_27_4)

					if var_27_11.name == "split_6" or not string.find(var_27_11.name, "split") then
						var_27_11.gameObject:SetActive(true)
					else
						var_27_11.gameObject:SetActive(false)
					end
				end
			end

			local var_27_12 = 0.001

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_9) / var_27_12
				local var_27_14 = Vector3.New(0, -350, -270)

				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10148, var_27_14, var_27_13)
			end

			if arg_24_1.time_ >= var_27_9 + var_27_12 and arg_24_1.time_ < var_27_9 + var_27_12 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_27_15 = 0
			local var_27_16 = 0.875

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_17 = arg_24_1:GetWordFromCfg(929011006)
				local var_27_18 = arg_24_1:FormatText(var_27_17.content)

				arg_24_1.text_.text = var_27_18

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 35
				local var_27_20 = utf8.len(var_27_18)
				local var_27_21 = var_27_19 <= 0 and var_27_16 or var_27_16 * (var_27_20 / var_27_19)

				if var_27_21 > 0 and var_27_16 < var_27_21 then
					arg_24_1.talkMaxDuration = var_27_21

					if var_27_21 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_21 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_18
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_22 and arg_24_1.time_ < var_27_15 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play929011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 929011007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play929011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10148"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps10148 == nil then
				arg_28_1.var_.actorSpriteComps10148 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps10148 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								local var_31_4 = Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor1.r, var_31_3)
								local var_31_5 = Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor1.g, var_31_3)
								local var_31_6 = Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor1.b, var_31_3)

								iter_31_1.color = Color.New(var_31_4, var_31_5, var_31_6)
							else
								local var_31_7 = Mathf.Lerp(iter_31_1.color.r, 1, var_31_3)

								iter_31_1.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps10148 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10148 = nil
			end

			local var_31_8 = arg_28_1.actors_["10148"].transform
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.var_.moveOldPos10148 = var_31_8.localPosition
				var_31_8.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10148", 2)

				local var_31_10 = var_31_8.childCount

				for iter_31_4 = 0, var_31_10 - 1 do
					local var_31_11 = var_31_8:GetChild(iter_31_4)

					if var_31_11.name == "split_6" or not string.find(var_31_11.name, "split") then
						var_31_11.gameObject:SetActive(true)
					else
						var_31_11.gameObject:SetActive(false)
					end
				end
			end

			local var_31_12 = 0.001

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_9) / var_31_12
				local var_31_14 = Vector3.New(-390, -350, -270)

				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10148, var_31_14, var_31_13)
			end

			if arg_28_1.time_ >= var_31_9 + var_31_12 and arg_28_1.time_ < var_31_9 + var_31_12 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_31_15 = arg_28_1.actors_["1083"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos1083 = var_31_15.localPosition
				var_31_15.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1083", 4)

				local var_31_17 = var_31_15.childCount

				for iter_31_5 = 0, var_31_17 - 1 do
					local var_31_18 = var_31_15:GetChild(iter_31_5)

					if var_31_18.name == "" or not string.find(var_31_18.name, "split") then
						var_31_18.gameObject:SetActive(true)
					else
						var_31_18.gameObject:SetActive(false)
					end
				end
			end

			local var_31_19 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_19 then
				local var_31_20 = (arg_28_1.time_ - var_31_16) / var_31_19
				local var_31_21 = Vector3.New(390, -345, -345)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1083, var_31_21, var_31_20)
			end

			if arg_28_1.time_ >= var_31_16 + var_31_19 and arg_28_1.time_ < var_31_16 + var_31_19 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(390, -345, -345)
			end

			local var_31_22 = 0
			local var_31_23 = 1.075

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[1331].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(929011007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 43
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_30 and arg_28_1.time_ < var_31_22 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 929011008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play929011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10148"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10148 = var_35_0.localPosition
				var_35_0.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10148", 2)

				local var_35_2 = var_35_0.childCount

				for iter_35_0 = 0, var_35_2 - 1 do
					local var_35_3 = var_35_0:GetChild(iter_35_0)

					if var_35_3.name == "split_6" or not string.find(var_35_3.name, "split") then
						var_35_3.gameObject:SetActive(true)
					else
						var_35_3.gameObject:SetActive(false)
					end
				end
			end

			local var_35_4 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_4 then
				local var_35_5 = (arg_32_1.time_ - var_35_1) / var_35_4
				local var_35_6 = Vector3.New(-390, -350, -270)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10148, var_35_6, var_35_5)
			end

			if arg_32_1.time_ >= var_35_1 + var_35_4 and arg_32_1.time_ < var_35_1 + var_35_4 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_35_7 = arg_32_1.actors_["1083"].transform
			local var_35_8 = 0

			if var_35_8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.var_.moveOldPos1083 = var_35_7.localPosition
				var_35_7.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("1083", 4)

				local var_35_9 = var_35_7.childCount

				for iter_35_1 = 0, var_35_9 - 1 do
					local var_35_10 = var_35_7:GetChild(iter_35_1)

					if var_35_10.name == "" or not string.find(var_35_10.name, "split") then
						var_35_10.gameObject:SetActive(true)
					else
						var_35_10.gameObject:SetActive(false)
					end
				end
			end

			local var_35_11 = 0.001

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_11 then
				local var_35_12 = (arg_32_1.time_ - var_35_8) / var_35_11
				local var_35_13 = Vector3.New(390, -345, -345)

				var_35_7.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1083, var_35_13, var_35_12)
			end

			if arg_32_1.time_ >= var_35_8 + var_35_11 and arg_32_1.time_ < var_35_8 + var_35_11 + arg_35_0 then
				var_35_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_35_14 = 0
			local var_35_15 = 0.3

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_16 = arg_32_1:FormatText(StoryNameCfg[1331].name)

				arg_32_1.leftNameTxt_.text = var_35_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_17 = arg_32_1:GetWordFromCfg(929011008)
				local var_35_18 = arg_32_1:FormatText(var_35_17.content)

				arg_32_1.text_.text = var_35_18

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 12
				local var_35_20 = utf8.len(var_35_18)
				local var_35_21 = var_35_19 <= 0 and var_35_15 or var_35_15 * (var_35_20 / var_35_19)

				if var_35_21 > 0 and var_35_15 < var_35_21 then
					arg_32_1.talkMaxDuration = var_35_21

					if var_35_21 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_21 + var_35_14
					end
				end

				arg_32_1.text_.text = var_35_18
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_15, arg_32_1.talkMaxDuration)

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_14) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_14 + var_35_22 and arg_32_1.time_ < var_35_14 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 929011009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play929011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1083"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1083 == nil then
				arg_36_1.var_.actorSpriteComps1083 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps1083 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 1, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1083 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1083 = nil
			end

			local var_39_8 = arg_36_1.actors_["10148"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10148 == nil then
				arg_36_1.var_.actorSpriteComps10148 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps10148 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_12 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, var_39_11)
								local var_39_13 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, var_39_11)
								local var_39_14 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, var_39_11)

								iter_39_5.color = Color.New(var_39_12, var_39_13, var_39_14)
							else
								local var_39_15 = Mathf.Lerp(iter_39_5.color.r, 0.5, var_39_11)

								iter_39_5.color = Color.New(var_39_15, var_39_15, var_39_15)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10148 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10148 = nil
			end

			local var_39_16 = arg_36_1.actors_["10148"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos10148 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10148", 2)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "split_6" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(-390, -350, -270)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10148, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_39_23 = arg_36_1.actors_["1083"].transform
			local var_39_24 = 0

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 then
				arg_36_1.var_.moveOldPos1083 = var_39_23.localPosition
				var_39_23.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1083", 4)

				local var_39_25 = var_39_23.childCount

				for iter_39_9 = 0, var_39_25 - 1 do
					local var_39_26 = var_39_23:GetChild(iter_39_9)

					if var_39_26.name == "split_1" or not string.find(var_39_26.name, "split") then
						var_39_26.gameObject:SetActive(true)
					else
						var_39_26.gameObject:SetActive(false)
					end
				end
			end

			local var_39_27 = 0.001

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_27 then
				local var_39_28 = (arg_36_1.time_ - var_39_24) / var_39_27
				local var_39_29 = Vector3.New(390, -345, -345)

				var_39_23.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1083, var_39_29, var_39_28)
			end

			if arg_36_1.time_ >= var_39_24 + var_39_27 and arg_36_1.time_ < var_39_24 + var_39_27 + arg_39_0 then
				var_39_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_39_30 = 0
			local var_39_31 = 0.475

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[1332].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(929011009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 19
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_31 or var_39_31 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_31 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_38 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_38 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_38

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_38 and arg_36_1.time_ < var_39_30 + var_39_38 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 929011010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play929011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10148"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10148 == nil then
				arg_40_1.var_.actorSpriteComps10148 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10148 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10148 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10148 = nil
			end

			local var_43_8 = arg_40_1.actors_["1083"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1083 == nil then
				arg_40_1.var_.actorSpriteComps1083 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps1083 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1083 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1083 = nil
			end

			local var_43_16 = arg_40_1.actors_["10148"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos10148 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10148", 2)

				local var_43_18 = var_43_16.childCount

				for iter_43_8 = 0, var_43_18 - 1 do
					local var_43_19 = var_43_16:GetChild(iter_43_8)

					if var_43_19.name == "split_2" or not string.find(var_43_19.name, "split") then
						var_43_19.gameObject:SetActive(true)
					else
						var_43_19.gameObject:SetActive(false)
					end
				end
			end

			local var_43_20 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_20 then
				local var_43_21 = (arg_40_1.time_ - var_43_17) / var_43_20
				local var_43_22 = Vector3.New(-390, -350, -270)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10148, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_43_23 = arg_40_1.actors_["1083"].transform
			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1.var_.moveOldPos1083 = var_43_23.localPosition
				var_43_23.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("1083", 4)

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
				local var_43_29 = Vector3.New(390, -345, -345)

				var_43_23.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1083, var_43_29, var_43_28)
			end

			if arg_40_1.time_ >= var_43_24 + var_43_27 and arg_40_1.time_ < var_43_24 + var_43_27 + arg_43_0 then
				var_43_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_43_30 = 0
			local var_43_31 = 1.05

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[1331].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(929011010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 42
				local var_43_36 = utf8.len(var_43_34)
				local var_43_37 = var_43_35 <= 0 and var_43_31 or var_43_31 * (var_43_36 / var_43_35)

				if var_43_37 > 0 and var_43_31 < var_43_37 then
					arg_40_1.talkMaxDuration = var_43_37

					if var_43_37 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_37 + var_43_30
					end
				end

				arg_40_1.text_.text = var_43_34
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_38 = math.max(var_43_31, arg_40_1.talkMaxDuration)

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_38 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_30) / var_43_38

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_30 + var_43_38 and arg_40_1.time_ < var_43_30 + var_43_38 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 929011011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play929011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10148"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos10148 = var_47_0.localPosition
				var_47_0.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10148", 2)

				local var_47_2 = var_47_0.childCount

				for iter_47_0 = 0, var_47_2 - 1 do
					local var_47_3 = var_47_0:GetChild(iter_47_0)

					if var_47_3.name == "" or not string.find(var_47_3.name, "split") then
						var_47_3.gameObject:SetActive(true)
					else
						var_47_3.gameObject:SetActive(false)
					end
				end
			end

			local var_47_4 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_4 then
				local var_47_5 = (arg_44_1.time_ - var_47_1) / var_47_4
				local var_47_6 = Vector3.New(-390, -350, -270)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10148, var_47_6, var_47_5)
			end

			if arg_44_1.time_ >= var_47_1 + var_47_4 and arg_44_1.time_ < var_47_1 + var_47_4 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_47_7 = arg_44_1.actors_["1083"].transform
			local var_47_8 = 0

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.var_.moveOldPos1083 = var_47_7.localPosition
				var_47_7.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1083", 4)

				local var_47_9 = var_47_7.childCount

				for iter_47_1 = 0, var_47_9 - 1 do
					local var_47_10 = var_47_7:GetChild(iter_47_1)

					if var_47_10.name == "" or not string.find(var_47_10.name, "split") then
						var_47_10.gameObject:SetActive(true)
					else
						var_47_10.gameObject:SetActive(false)
					end
				end
			end

			local var_47_11 = 0.001

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_11 then
				local var_47_12 = (arg_44_1.time_ - var_47_8) / var_47_11
				local var_47_13 = Vector3.New(390, -345, -345)

				var_47_7.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1083, var_47_13, var_47_12)
			end

			if arg_44_1.time_ >= var_47_8 + var_47_11 and arg_44_1.time_ < var_47_8 + var_47_11 + arg_47_0 then
				var_47_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_47_14 = 0
			local var_47_15 = 1.35

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_16 = arg_44_1:FormatText(StoryNameCfg[1331].name)

				arg_44_1.leftNameTxt_.text = var_47_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_17 = arg_44_1:GetWordFromCfg(929011011)
				local var_47_18 = arg_44_1:FormatText(var_47_17.content)

				arg_44_1.text_.text = var_47_18

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 54
				local var_47_20 = utf8.len(var_47_18)
				local var_47_21 = var_47_19 <= 0 and var_47_15 or var_47_15 * (var_47_20 / var_47_19)

				if var_47_21 > 0 and var_47_15 < var_47_21 then
					arg_44_1.talkMaxDuration = var_47_21

					if var_47_21 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_21 + var_47_14
					end
				end

				arg_44_1.text_.text = var_47_18
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_15, arg_44_1.talkMaxDuration)

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_14) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_14 + var_47_22 and arg_44_1.time_ < var_47_14 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 929011012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play929011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10148"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10148 = var_51_0.localPosition
				var_51_0.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10148", 2)

				local var_51_2 = var_51_0.childCount

				for iter_51_0 = 0, var_51_2 - 1 do
					local var_51_3 = var_51_0:GetChild(iter_51_0)

					if var_51_3.name == "" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_4 then
				local var_51_5 = (arg_48_1.time_ - var_51_1) / var_51_4
				local var_51_6 = Vector3.New(-390, -350, -270)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10148, var_51_6, var_51_5)
			end

			if arg_48_1.time_ >= var_51_1 + var_51_4 and arg_48_1.time_ < var_51_1 + var_51_4 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_51_7 = arg_48_1.actors_["1083"].transform
			local var_51_8 = 0

			if var_51_8 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.var_.moveOldPos1083 = var_51_7.localPosition
				var_51_7.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1083", 4)

				local var_51_9 = var_51_7.childCount

				for iter_51_1 = 0, var_51_9 - 1 do
					local var_51_10 = var_51_7:GetChild(iter_51_1)

					if var_51_10.name == "" or not string.find(var_51_10.name, "split") then
						var_51_10.gameObject:SetActive(true)
					else
						var_51_10.gameObject:SetActive(false)
					end
				end
			end

			local var_51_11 = 0.001

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_11 then
				local var_51_12 = (arg_48_1.time_ - var_51_8) / var_51_11
				local var_51_13 = Vector3.New(390, -345, -345)

				var_51_7.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1083, var_51_13, var_51_12)
			end

			if arg_48_1.time_ >= var_51_8 + var_51_11 and arg_48_1.time_ < var_51_8 + var_51_11 + arg_51_0 then
				var_51_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_51_14 = 0
			local var_51_15 = 0.875

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_16 = arg_48_1:FormatText(StoryNameCfg[1331].name)

				arg_48_1.leftNameTxt_.text = var_51_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_17 = arg_48_1:GetWordFromCfg(929011012)
				local var_51_18 = arg_48_1:FormatText(var_51_17.content)

				arg_48_1.text_.text = var_51_18

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 35
				local var_51_20 = utf8.len(var_51_18)
				local var_51_21 = var_51_19 <= 0 and var_51_15 or var_51_15 * (var_51_20 / var_51_19)

				if var_51_21 > 0 and var_51_15 < var_51_21 then
					arg_48_1.talkMaxDuration = var_51_21

					if var_51_21 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_21 + var_51_14
					end
				end

				arg_48_1.text_.text = var_51_18
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_15, arg_48_1.talkMaxDuration)

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_14) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_14 + var_51_22 and arg_48_1.time_ < var_51_14 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play929011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 929011013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play929011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10148"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos10148 = var_55_0.localPosition
				var_55_0.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10148", 2)

				local var_55_2 = var_55_0.childCount

				for iter_55_0 = 0, var_55_2 - 1 do
					local var_55_3 = var_55_0:GetChild(iter_55_0)

					if var_55_3.name == "split_2" or not string.find(var_55_3.name, "split") then
						var_55_3.gameObject:SetActive(true)
					else
						var_55_3.gameObject:SetActive(false)
					end
				end
			end

			local var_55_4 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_4 then
				local var_55_5 = (arg_52_1.time_ - var_55_1) / var_55_4
				local var_55_6 = Vector3.New(-390, -350, -270)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10148, var_55_6, var_55_5)
			end

			if arg_52_1.time_ >= var_55_1 + var_55_4 and arg_52_1.time_ < var_55_1 + var_55_4 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_55_7 = arg_52_1.actors_["1083"].transform
			local var_55_8 = 0

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.var_.moveOldPos1083 = var_55_7.localPosition
				var_55_7.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("1083", 4)

				local var_55_9 = var_55_7.childCount

				for iter_55_1 = 0, var_55_9 - 1 do
					local var_55_10 = var_55_7:GetChild(iter_55_1)

					if var_55_10.name == "" or not string.find(var_55_10.name, "split") then
						var_55_10.gameObject:SetActive(true)
					else
						var_55_10.gameObject:SetActive(false)
					end
				end
			end

			local var_55_11 = 0.001

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_11 then
				local var_55_12 = (arg_52_1.time_ - var_55_8) / var_55_11
				local var_55_13 = Vector3.New(390, -345, -345)

				var_55_7.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1083, var_55_13, var_55_12)
			end

			if arg_52_1.time_ >= var_55_8 + var_55_11 and arg_52_1.time_ < var_55_8 + var_55_11 + arg_55_0 then
				var_55_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_55_14 = 0
			local var_55_15 = 0.75

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_16 = arg_52_1:FormatText(StoryNameCfg[1331].name)

				arg_52_1.leftNameTxt_.text = var_55_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_17 = arg_52_1:GetWordFromCfg(929011013)
				local var_55_18 = arg_52_1:FormatText(var_55_17.content)

				arg_52_1.text_.text = var_55_18

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_19 = 30
				local var_55_20 = utf8.len(var_55_18)
				local var_55_21 = var_55_19 <= 0 and var_55_15 or var_55_15 * (var_55_20 / var_55_19)

				if var_55_21 > 0 and var_55_15 < var_55_21 then
					arg_52_1.talkMaxDuration = var_55_21

					if var_55_21 + var_55_14 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_21 + var_55_14
					end
				end

				arg_52_1.text_.text = var_55_18
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_15, arg_52_1.talkMaxDuration)

			if var_55_14 <= arg_52_1.time_ and arg_52_1.time_ < var_55_14 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_14) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_14 + var_55_22 and arg_52_1.time_ < var_55_14 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play929011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 929011014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play929011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10148"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10148 = var_59_0.localPosition
				var_59_0.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10148", 2)

				local var_59_2 = var_59_0.childCount

				for iter_59_0 = 0, var_59_2 - 1 do
					local var_59_3 = var_59_0:GetChild(iter_59_0)

					if var_59_3.name == "" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_4 then
				local var_59_5 = (arg_56_1.time_ - var_59_1) / var_59_4
				local var_59_6 = Vector3.New(-390, -350, -270)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10148, var_59_6, var_59_5)
			end

			if arg_56_1.time_ >= var_59_1 + var_59_4 and arg_56_1.time_ < var_59_1 + var_59_4 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_59_7 = arg_56_1.actors_["1083"].transform
			local var_59_8 = 0

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.var_.moveOldPos1083 = var_59_7.localPosition
				var_59_7.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1083", 4)

				local var_59_9 = var_59_7.childCount

				for iter_59_1 = 0, var_59_9 - 1 do
					local var_59_10 = var_59_7:GetChild(iter_59_1)

					if var_59_10.name == "" or not string.find(var_59_10.name, "split") then
						var_59_10.gameObject:SetActive(true)
					else
						var_59_10.gameObject:SetActive(false)
					end
				end
			end

			local var_59_11 = 0.001

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_11 then
				local var_59_12 = (arg_56_1.time_ - var_59_8) / var_59_11
				local var_59_13 = Vector3.New(390, -345, -345)

				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1083, var_59_13, var_59_12)
			end

			if arg_56_1.time_ >= var_59_8 + var_59_11 and arg_56_1.time_ < var_59_8 + var_59_11 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_59_14 = 0
			local var_59_15 = 0.775

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_16 = arg_56_1:FormatText(StoryNameCfg[1331].name)

				arg_56_1.leftNameTxt_.text = var_59_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_17 = arg_56_1:GetWordFromCfg(929011014)
				local var_59_18 = arg_56_1:FormatText(var_59_17.content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_19 = 31
				local var_59_20 = utf8.len(var_59_18)
				local var_59_21 = var_59_19 <= 0 and var_59_15 or var_59_15 * (var_59_20 / var_59_19)

				if var_59_21 > 0 and var_59_15 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_14 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_14
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_15, arg_56_1.talkMaxDuration)

			if var_59_14 <= arg_56_1.time_ and arg_56_1.time_ < var_59_14 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_14) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_14 + var_59_22 and arg_56_1.time_ < var_59_14 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play929011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 929011015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play929011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1083"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1083 == nil then
				arg_60_1.var_.actorSpriteComps1083 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps1083 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1083 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1083 = nil
			end

			local var_63_8 = arg_60_1.actors_["10148"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10148 == nil then
				arg_60_1.var_.actorSpriteComps10148 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps10148 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								local var_63_12 = Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, var_63_11)
								local var_63_13 = Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, var_63_11)
								local var_63_14 = Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, var_63_11)

								iter_63_5.color = Color.New(var_63_12, var_63_13, var_63_14)
							else
								local var_63_15 = Mathf.Lerp(iter_63_5.color.r, 0.5, var_63_11)

								iter_63_5.color = Color.New(var_63_15, var_63_15, var_63_15)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10148 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10148 = nil
			end

			local var_63_16 = arg_60_1.actors_["10148"].transform
			local var_63_17 = 0

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.var_.moveOldPos10148 = var_63_16.localPosition
				var_63_16.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("10148", 2)

				local var_63_18 = var_63_16.childCount

				for iter_63_8 = 0, var_63_18 - 1 do
					local var_63_19 = var_63_16:GetChild(iter_63_8)

					if var_63_19.name == "" or not string.find(var_63_19.name, "split") then
						var_63_19.gameObject:SetActive(true)
					else
						var_63_19.gameObject:SetActive(false)
					end
				end
			end

			local var_63_20 = 0.001

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_20 then
				local var_63_21 = (arg_60_1.time_ - var_63_17) / var_63_20
				local var_63_22 = Vector3.New(-390, -350, -270)

				var_63_16.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10148, var_63_22, var_63_21)
			end

			if arg_60_1.time_ >= var_63_17 + var_63_20 and arg_60_1.time_ < var_63_17 + var_63_20 + arg_63_0 then
				var_63_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_63_23 = arg_60_1.actors_["1083"].transform
			local var_63_24 = 0

			if var_63_24 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 then
				arg_60_1.var_.moveOldPos1083 = var_63_23.localPosition
				var_63_23.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1083", 4)

				local var_63_25 = var_63_23.childCount

				for iter_63_9 = 0, var_63_25 - 1 do
					local var_63_26 = var_63_23:GetChild(iter_63_9)

					if var_63_26.name == "split_8" or not string.find(var_63_26.name, "split") then
						var_63_26.gameObject:SetActive(true)
					else
						var_63_26.gameObject:SetActive(false)
					end
				end
			end

			local var_63_27 = 0.001

			if var_63_24 <= arg_60_1.time_ and arg_60_1.time_ < var_63_24 + var_63_27 then
				local var_63_28 = (arg_60_1.time_ - var_63_24) / var_63_27
				local var_63_29 = Vector3.New(390, -345, -345)

				var_63_23.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1083, var_63_29, var_63_28)
			end

			if arg_60_1.time_ >= var_63_24 + var_63_27 and arg_60_1.time_ < var_63_24 + var_63_27 + arg_63_0 then
				var_63_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_63_30 = 0
			local var_63_31 = 0.775

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_32 = arg_60_1:FormatText(StoryNameCfg[1332].name)

				arg_60_1.leftNameTxt_.text = var_63_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_33 = arg_60_1:GetWordFromCfg(929011015)
				local var_63_34 = arg_60_1:FormatText(var_63_33.content)

				arg_60_1.text_.text = var_63_34

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_35 = 31
				local var_63_36 = utf8.len(var_63_34)
				local var_63_37 = var_63_35 <= 0 and var_63_31 or var_63_31 * (var_63_36 / var_63_35)

				if var_63_37 > 0 and var_63_31 < var_63_37 then
					arg_60_1.talkMaxDuration = var_63_37

					if var_63_37 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_37 + var_63_30
					end
				end

				arg_60_1.text_.text = var_63_34
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_38 = math.max(var_63_31, arg_60_1.talkMaxDuration)

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_38 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_30) / var_63_38

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_30 + var_63_38 and arg_60_1.time_ < var_63_30 + var_63_38 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play929011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 929011016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play929011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10148"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10148 == nil then
				arg_64_1.var_.actorSpriteComps10148 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps10148 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10148 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10148 = nil
			end

			local var_67_8 = arg_64_1.actors_["1083"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1083 == nil then
				arg_64_1.var_.actorSpriteComps1083 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps1083 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1083 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1083 = nil
			end

			local var_67_16 = arg_64_1.actors_["10148"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos10148 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10148", 2)

				local var_67_18 = var_67_16.childCount

				for iter_67_8 = 0, var_67_18 - 1 do
					local var_67_19 = var_67_16:GetChild(iter_67_8)

					if var_67_19.name == "" or not string.find(var_67_19.name, "split") then
						var_67_19.gameObject:SetActive(true)
					else
						var_67_19.gameObject:SetActive(false)
					end
				end
			end

			local var_67_20 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_20 then
				local var_67_21 = (arg_64_1.time_ - var_67_17) / var_67_20
				local var_67_22 = Vector3.New(-390, -350, -270)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10148, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_67_23 = arg_64_1.actors_["1083"].transform
			local var_67_24 = 0

			if var_67_24 < arg_64_1.time_ and arg_64_1.time_ <= var_67_24 + arg_67_0 then
				arg_64_1.var_.moveOldPos1083 = var_67_23.localPosition
				var_67_23.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1083", 4)

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
				local var_67_29 = Vector3.New(390, -345, -345)

				var_67_23.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1083, var_67_29, var_67_28)
			end

			if arg_64_1.time_ >= var_67_24 + var_67_27 and arg_64_1.time_ < var_67_24 + var_67_27 + arg_67_0 then
				var_67_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_67_30 = 0
			local var_67_31 = 1.075

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[1331].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(929011016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 43
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
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_38 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_38 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_38

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_38 and arg_64_1.time_ < var_67_30 + var_67_38 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 929011017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play929011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10148"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos10148 = var_71_0.localPosition
				var_71_0.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10148", 2)

				local var_71_2 = var_71_0.childCount

				for iter_71_0 = 0, var_71_2 - 1 do
					local var_71_3 = var_71_0:GetChild(iter_71_0)

					if var_71_3.name == "" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_4 then
				local var_71_5 = (arg_68_1.time_ - var_71_1) / var_71_4
				local var_71_6 = Vector3.New(-390, -350, -270)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10148, var_71_6, var_71_5)
			end

			if arg_68_1.time_ >= var_71_1 + var_71_4 and arg_68_1.time_ < var_71_1 + var_71_4 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_71_7 = arg_68_1.actors_["1083"].transform
			local var_71_8 = 0

			if var_71_8 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.var_.moveOldPos1083 = var_71_7.localPosition
				var_71_7.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1083", 4)

				local var_71_9 = var_71_7.childCount

				for iter_71_1 = 0, var_71_9 - 1 do
					local var_71_10 = var_71_7:GetChild(iter_71_1)

					if var_71_10.name == "" or not string.find(var_71_10.name, "split") then
						var_71_10.gameObject:SetActive(true)
					else
						var_71_10.gameObject:SetActive(false)
					end
				end
			end

			local var_71_11 = 0.001

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_8) / var_71_11
				local var_71_13 = Vector3.New(390, -345, -345)

				var_71_7.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1083, var_71_13, var_71_12)
			end

			if arg_68_1.time_ >= var_71_8 + var_71_11 and arg_68_1.time_ < var_71_8 + var_71_11 + arg_71_0 then
				var_71_7.localPosition = Vector3.New(390, -345, -345)
			end

			local var_71_14 = 0
			local var_71_15 = 1.2

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_16 = arg_68_1:FormatText(StoryNameCfg[1331].name)

				arg_68_1.leftNameTxt_.text = var_71_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_17 = arg_68_1:GetWordFromCfg(929011017)
				local var_71_18 = arg_68_1:FormatText(var_71_17.content)

				arg_68_1.text_.text = var_71_18

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_19 = 48
				local var_71_20 = utf8.len(var_71_18)
				local var_71_21 = var_71_19 <= 0 and var_71_15 or var_71_15 * (var_71_20 / var_71_19)

				if var_71_21 > 0 and var_71_15 < var_71_21 then
					arg_68_1.talkMaxDuration = var_71_21

					if var_71_21 + var_71_14 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_21 + var_71_14
					end
				end

				arg_68_1.text_.text = var_71_18
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_15, arg_68_1.talkMaxDuration)

			if var_71_14 <= arg_68_1.time_ and arg_68_1.time_ < var_71_14 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_14) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_14 + var_71_22 and arg_68_1.time_ < var_71_14 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play929011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 929011018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play929011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10148"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10148 == nil then
				arg_72_1.var_.actorSpriteComps10148 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps10148 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor2.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor2.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor2.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 0.5, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10148 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10148 = nil
			end

			local var_75_8 = arg_72_1.actors_["10148"].transform
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.var_.moveOldPos10148 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10148", 2)

				local var_75_10 = var_75_8.childCount

				for iter_75_4 = 0, var_75_10 - 1 do
					local var_75_11 = var_75_8:GetChild(iter_75_4)

					if var_75_11.name == "" or not string.find(var_75_11.name, "split") then
						var_75_11.gameObject:SetActive(true)
					else
						var_75_11.gameObject:SetActive(false)
					end
				end
			end

			local var_75_12 = 0.001

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_9) / var_75_12
				local var_75_14 = Vector3.New(-390, -350, -270)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10148, var_75_14, var_75_13)
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_75_15 = arg_72_1.actors_["1083"].transform
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.var_.moveOldPos1083 = var_75_15.localPosition
				var_75_15.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1083", 4)

				local var_75_17 = var_75_15.childCount

				for iter_75_5 = 0, var_75_17 - 1 do
					local var_75_18 = var_75_15:GetChild(iter_75_5)

					if var_75_18.name == "" or not string.find(var_75_18.name, "split") then
						var_75_18.gameObject:SetActive(true)
					else
						var_75_18.gameObject:SetActive(false)
					end
				end
			end

			local var_75_19 = 0.001

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_19 then
				local var_75_20 = (arg_72_1.time_ - var_75_16) / var_75_19
				local var_75_21 = Vector3.New(390, -345, -345)

				var_75_15.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1083, var_75_21, var_75_20)
			end

			if arg_72_1.time_ >= var_75_16 + var_75_19 and arg_72_1.time_ < var_75_16 + var_75_19 + arg_75_0 then
				var_75_15.localPosition = Vector3.New(390, -345, -345)
			end

			local var_75_22 = 0
			local var_75_23 = 0.925

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_24 = arg_72_1:GetWordFromCfg(929011018)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 37
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_23 or var_75_23 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_23 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_22 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_22
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_29 = math.max(var_75_23, arg_72_1.talkMaxDuration)

			if var_75_22 <= arg_72_1.time_ and arg_72_1.time_ < var_75_22 + var_75_29 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_22) / var_75_29

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_22 + var_75_29 and arg_72_1.time_ < var_75_22 + var_75_29 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play929011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 929011019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play929011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10148"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10148 == nil then
				arg_76_1.var_.actorSpriteComps10148 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10148 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10148 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10148 = nil
			end

			local var_79_8 = arg_76_1.actors_["10148"].transform
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.var_.moveOldPos10148 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10148", 2)

				local var_79_10 = var_79_8.childCount

				for iter_79_4 = 0, var_79_10 - 1 do
					local var_79_11 = var_79_8:GetChild(iter_79_4)

					if var_79_11.name == "split_4" or not string.find(var_79_11.name, "split") then
						var_79_11.gameObject:SetActive(true)
					else
						var_79_11.gameObject:SetActive(false)
					end
				end
			end

			local var_79_12 = 0.001

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_12 then
				local var_79_13 = (arg_76_1.time_ - var_79_9) / var_79_12
				local var_79_14 = Vector3.New(-390, -350, -270)

				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10148, var_79_14, var_79_13)
			end

			if arg_76_1.time_ >= var_79_9 + var_79_12 and arg_76_1.time_ < var_79_9 + var_79_12 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_79_15 = arg_76_1.actors_["1083"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos1083 = var_79_15.localPosition
				var_79_15.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1083", 4)

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
				local var_79_21 = Vector3.New(390, -345, -345)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1083, var_79_21, var_79_20)
			end

			if arg_76_1.time_ >= var_79_16 + var_79_19 and arg_76_1.time_ < var_79_16 + var_79_19 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(390, -345, -345)
			end

			local var_79_22 = 0
			local var_79_23 = 0.55

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_24 = arg_76_1:FormatText(StoryNameCfg[1331].name)

				arg_76_1.leftNameTxt_.text = var_79_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_25 = arg_76_1:GetWordFromCfg(929011019)
				local var_79_26 = arg_76_1:FormatText(var_79_25.content)

				arg_76_1.text_.text = var_79_26

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_27 = 22
				local var_79_28 = utf8.len(var_79_26)
				local var_79_29 = var_79_27 <= 0 and var_79_23 or var_79_23 * (var_79_28 / var_79_27)

				if var_79_29 > 0 and var_79_23 < var_79_29 then
					arg_76_1.talkMaxDuration = var_79_29

					if var_79_29 + var_79_22 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_22
					end
				end

				arg_76_1.text_.text = var_79_26
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_30 = math.max(var_79_23, arg_76_1.talkMaxDuration)

			if var_79_22 <= arg_76_1.time_ and arg_76_1.time_ < var_79_22 + var_79_30 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_22) / var_79_30

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_22 + var_79_30 and arg_76_1.time_ < var_79_22 + var_79_30 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play929011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 929011020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1083"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1083 == nil then
				arg_80_1.var_.actorSpriteComps1083 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps1083 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								local var_83_4 = Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, var_83_3)
								local var_83_5 = Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, var_83_3)
								local var_83_6 = Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, var_83_3)

								iter_83_1.color = Color.New(var_83_4, var_83_5, var_83_6)
							else
								local var_83_7 = Mathf.Lerp(iter_83_1.color.r, 1, var_83_3)

								iter_83_1.color = Color.New(var_83_7, var_83_7, var_83_7)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1083 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1083 = nil
			end

			local var_83_8 = arg_80_1.actors_["10148"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10148 == nil then
				arg_80_1.var_.actorSpriteComps10148 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps10148 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								local var_83_12 = Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, var_83_11)
								local var_83_13 = Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, var_83_11)
								local var_83_14 = Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, var_83_11)

								iter_83_5.color = Color.New(var_83_12, var_83_13, var_83_14)
							else
								local var_83_15 = Mathf.Lerp(iter_83_5.color.r, 0.5, var_83_11)

								iter_83_5.color = Color.New(var_83_15, var_83_15, var_83_15)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10148 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10148 = nil
			end

			local var_83_16 = arg_80_1.actors_["1083"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos1083 = var_83_16.localPosition
				var_83_16.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1083", 3)

				local var_83_18 = var_83_16.childCount

				for iter_83_8 = 0, var_83_18 - 1 do
					local var_83_19 = var_83_16:GetChild(iter_83_8)

					if var_83_19.name == "split_2" or not string.find(var_83_19.name, "split") then
						var_83_19.gameObject:SetActive(true)
					else
						var_83_19.gameObject:SetActive(false)
					end
				end
			end

			local var_83_20 = 0.001

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_20 then
				local var_83_21 = (arg_80_1.time_ - var_83_17) / var_83_20
				local var_83_22 = Vector3.New(-50, -345, -345)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1083, var_83_22, var_83_21)
			end

			if arg_80_1.time_ >= var_83_17 + var_83_20 and arg_80_1.time_ < var_83_17 + var_83_20 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_83_23 = arg_80_1.actors_["10148"].transform
			local var_83_24 = 0

			if var_83_24 < arg_80_1.time_ and arg_80_1.time_ <= var_83_24 + arg_83_0 then
				arg_80_1.var_.moveOldPos10148 = var_83_23.localPosition
				var_83_23.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10148", 7)

				local var_83_25 = var_83_23.childCount

				for iter_83_9 = 0, var_83_25 - 1 do
					local var_83_26 = var_83_23:GetChild(iter_83_9)

					if var_83_26.name == "" or not string.find(var_83_26.name, "split") then
						var_83_26.gameObject:SetActive(true)
					else
						var_83_26.gameObject:SetActive(false)
					end
				end
			end

			local var_83_27 = 0.001

			if var_83_24 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_27 then
				local var_83_28 = (arg_80_1.time_ - var_83_24) / var_83_27
				local var_83_29 = Vector3.New(0, -2000, 0)

				var_83_23.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10148, var_83_29, var_83_28)
			end

			if arg_80_1.time_ >= var_83_24 + var_83_27 and arg_80_1.time_ < var_83_24 + var_83_27 + arg_83_0 then
				var_83_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_83_30 = 0
			local var_83_31 = 0.475

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[1332].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(929011020)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 19
				local var_83_36 = utf8.len(var_83_34)
				local var_83_37 = var_83_35 <= 0 and var_83_31 or var_83_31 * (var_83_36 / var_83_35)

				if var_83_37 > 0 and var_83_31 < var_83_37 then
					arg_80_1.talkMaxDuration = var_83_37

					if var_83_37 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_30
					end
				end

				arg_80_1.text_.text = var_83_34
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_38 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_38 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_38

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_38 and arg_80_1.time_ < var_83_30 + var_83_38 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
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
	assets = {
		"TextureConfig/Background/ST0112"
	},
	voices = {}
}
