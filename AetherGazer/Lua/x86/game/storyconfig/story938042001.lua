return {
	Play938042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938042001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938042002(arg_1_1)
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

			local var_4_24 = "10183"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

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

			local var_4_28 = arg_1_1.actors_["10183"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10183 == nil then
				arg_1_1.var_.actorSpriteComps10183 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10183 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10183 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10183 = nil
			end

			local var_4_36 = arg_1_1.actors_["10183"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10183 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10183", 3)

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
				local var_4_42 = Vector3.New(0, -475, -325)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10183, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -475, -325)
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 1.025

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[1562].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(938042001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 41
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_53 + 0.3
			local var_4_63 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938042002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10183"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10183 = var_11_0.localPosition
				var_11_0.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10183", 3)

				local var_11_2 = var_11_0.childCount

				for iter_11_0 = 0, var_11_2 - 1 do
					local var_11_3 = var_11_0:GetChild(iter_11_0)

					if var_11_3.name == "split_2" then
						var_11_3:SetAsLastSibling()
						var_11_3.gameObject:SetActive(true)

						arg_8_1.var_.actorSpriteSplit10183 = var_11_3.gameObject:GetComponent(typeof(Image))

						arg_8_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_11_4 = 0.5

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_4 then
				local var_11_5 = (arg_8_1.time_ - var_11_1) / var_11_4
				local var_11_6 = Vector3.New(0, -475, -325)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10183, var_11_6, var_11_5)

				if arg_8_1.var_.actorSpriteSplit10183 ~= nil then
					arg_8_1.var_.actorSpriteSplit10183:SetAlpha(var_11_5)
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_4 and arg_8_1.time_ < var_11_1 + var_11_4 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, -475, -325)

				if arg_8_1.var_.actorSpriteSplit10183 ~= nil then
					arg_8_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_11_7 = 0
			local var_11_8 = 0.7

			if var_11_7 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_9 = arg_8_1:FormatText(StoryNameCfg[1562].name)

				arg_8_1.leftNameTxt_.text = var_11_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(938042002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_12 = 28
				local var_11_13 = utf8.len(var_11_11)
				local var_11_14 = var_11_12 <= 0 and var_11_8 or var_11_8 * (var_11_13 / var_11_12)

				if var_11_14 > 0 and var_11_8 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_7 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_7
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_8, arg_8_1.talkMaxDuration)

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_7) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_7 + var_11_15 and arg_8_1.time_ < var_11_7 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play938042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938042003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10183"].transform
			local var_15_1 = 0.5

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos10183 = var_15_0.localPosition
				var_15_0.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10183", 7)

				local var_15_2 = var_15_0.childCount

				for iter_15_0 = 0, var_15_2 - 1 do
					local var_15_3 = var_15_0:GetChild(iter_15_0)

					if var_15_3.name == "" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_4 then
				local var_15_5 = (arg_12_1.time_ - var_15_1) / var_15_4
				local var_15_6 = Vector3.New(0, -2000, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10183, var_15_6, var_15_5)
			end

			if arg_12_1.time_ >= var_15_1 + var_15_4 and arg_12_1.time_ < var_15_1 + var_15_4 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_7 = arg_12_1.actors_["10183"].transform
			local var_15_8 = 0

			if var_15_8 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.var_.moveOldPos10183 = var_15_7.localPosition
				var_15_7.localScale = Vector3.New(1, 1, 1)

				local var_15_9 = var_15_7.childCount

				for iter_15_1 = 0, var_15_9 - 1 do
					local var_15_10 = var_15_7:GetChild(iter_15_1)

					if var_15_10.name == "split_2" or not string.find(var_15_10.name, "split") then
						var_15_10.gameObject:SetActive(true)
					else
						var_15_10.gameObject:SetActive(false)
					end
				end
			end

			local var_15_11 = 0.5

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_11 then
				local var_15_12 = (arg_12_1.time_ - var_15_8) / var_15_11
				local var_15_13 = Vector3.New(0, -8000, 0)

				var_15_7.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10183, var_15_13, var_15_12)
			end

			if arg_12_1.time_ >= var_15_8 + var_15_11 and arg_12_1.time_ < var_15_8 + var_15_11 + arg_15_0 then
				var_15_7.localPosition = Vector3.New(0, -8000, 0)
			end

			local var_15_14 = 0
			local var_15_15 = 1.125

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:GetWordFromCfg(938042003)
				local var_15_17 = arg_12_1:FormatText(var_15_16.content)

				arg_12_1.text_.text = var_15_17

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_18 = 45
				local var_15_19 = utf8.len(var_15_17)
				local var_15_20 = var_15_18 <= 0 and var_15_15 or var_15_15 * (var_15_19 / var_15_18)

				if var_15_20 > 0 and var_15_15 < var_15_20 then
					arg_12_1.talkMaxDuration = var_15_20

					if var_15_20 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_14
					end
				end

				arg_12_1.text_.text = var_15_17
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_21 = math.max(var_15_15, arg_12_1.talkMaxDuration)

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_21 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_14) / var_15_21

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_14 + var_15_21 and arg_12_1.time_ < var_15_14 + var_15_21 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(0, -475, -325),
					endPos = Vector3.New(0, -8000, 0),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play938042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938042004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "128404"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(var_19_1, arg_16_1.canvasGo_.transform)

					var_19_2.transform:SetSiblingIndex(1)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_16_1.isInRecall_ then
						for iter_19_0, iter_19_1 in ipairs(var_19_3) do
							iter_19_1.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_19_4 = arg_16_1.actors_["128404"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps128404 == nil then
				arg_16_1.var_.actorSpriteComps128404 = var_19_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_6 = 0.2

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.actorSpriteComps128404 then
					for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_19_3 then
							if arg_16_1.isInRecall_ then
								local var_19_8 = Mathf.Lerp(iter_19_3.color.r, arg_16_1.hightColor1.r, var_19_7)
								local var_19_9 = Mathf.Lerp(iter_19_3.color.g, arg_16_1.hightColor1.g, var_19_7)
								local var_19_10 = Mathf.Lerp(iter_19_3.color.b, arg_16_1.hightColor1.b, var_19_7)

								iter_19_3.color = Color.New(var_19_8, var_19_9, var_19_10)
							else
								local var_19_11 = Mathf.Lerp(iter_19_3.color.r, 1, var_19_7)

								iter_19_3.color = Color.New(var_19_11, var_19_11, var_19_11)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps128404 then
				for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_19_5 then
						if arg_16_1.isInRecall_ then
							iter_19_5.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps128404 = nil
			end

			local var_19_12 = arg_16_1.actors_["128404"].transform
			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1.var_.moveOldPos128404 = var_19_12.localPosition
				var_19_12.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("128404", 3)

				local var_19_14 = var_19_12.childCount

				for iter_19_6 = 0, var_19_14 - 1 do
					local var_19_15 = var_19_12:GetChild(iter_19_6)

					if var_19_15.name == "split_3" or not string.find(var_19_15.name, "split") then
						var_19_15.gameObject:SetActive(true)
					else
						var_19_15.gameObject:SetActive(false)
					end
				end
			end

			local var_19_16 = 0.001

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_16 then
				local var_19_17 = (arg_16_1.time_ - var_19_13) / var_19_16
				local var_19_18 = Vector3.New(-16.1, -362, -375)

				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos128404, var_19_18, var_19_17)
			end

			if arg_16_1.time_ >= var_19_13 + var_19_16 and arg_16_1.time_ < var_19_13 + var_19_16 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_19_19 = 0
			local var_19_20 = 0.175

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_21 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_22 = arg_16_1:GetWordFromCfg(938042004)
				local var_19_23 = arg_16_1:FormatText(var_19_22.content)

				arg_16_1.text_.text = var_19_23

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_24 = 7
				local var_19_25 = utf8.len(var_19_23)
				local var_19_26 = var_19_24 <= 0 and var_19_20 or var_19_20 * (var_19_25 / var_19_24)

				if var_19_26 > 0 and var_19_20 < var_19_26 then
					arg_16_1.talkMaxDuration = var_19_26

					if var_19_26 + var_19_19 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_26 + var_19_19
					end
				end

				arg_16_1.text_.text = var_19_23
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_20, arg_16_1.talkMaxDuration)

			if var_19_19 <= arg_16_1.time_ and arg_16_1.time_ < var_19_19 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_19) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_19 + var_19_27 and arg_16_1.time_ < var_19_19 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play938042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938042005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["128404"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps128404 == nil then
				arg_20_1.var_.actorSpriteComps128404 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps128404 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								local var_23_4 = Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor2.r, var_23_3)
								local var_23_5 = Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor2.g, var_23_3)
								local var_23_6 = Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor2.b, var_23_3)

								iter_23_1.color = Color.New(var_23_4, var_23_5, var_23_6)
							else
								local var_23_7 = Mathf.Lerp(iter_23_1.color.r, 0.5, var_23_3)

								iter_23_1.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps128404 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps128404 = nil
			end

			local var_23_8 = 0
			local var_23_9 = 0.5

			if var_23_8 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_10 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_11 = arg_20_1:GetWordFromCfg(938042005)
				local var_23_12 = arg_20_1:FormatText(var_23_11.content)

				arg_20_1.text_.text = var_23_12

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 20
				local var_23_14 = utf8.len(var_23_12)
				local var_23_15 = var_23_13 <= 0 and var_23_9 or var_23_9 * (var_23_14 / var_23_13)

				if var_23_15 > 0 and var_23_9 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_12
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938042006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["128404"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps128404 == nil then
				arg_24_1.var_.actorSpriteComps128404 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps128404 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 1, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps128404 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps128404 = nil
			end

			local var_27_8 = arg_24_1.actors_["128404"].transform
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.var_.moveOldPos128404 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("128404", 3)

				local var_27_10 = var_27_8.childCount

				for iter_27_4 = 0, var_27_10 - 1 do
					local var_27_11 = var_27_8:GetChild(iter_27_4)

					if var_27_11.name == "split_1" then
						var_27_11:SetAsLastSibling()
						var_27_11.gameObject:SetActive(true)

						arg_24_1.var_.actorSpriteSplit128404 = var_27_11.gameObject:GetComponent(typeof(Image))

						arg_24_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_27_12 = 0.5

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_9) / var_27_12
				local var_27_14 = Vector3.New(-16.1, -362, -375)

				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos128404, var_27_14, var_27_13)

				if arg_24_1.var_.actorSpriteSplit128404 ~= nil then
					arg_24_1.var_.actorSpriteSplit128404:SetAlpha(var_27_13)
				end
			end

			if arg_24_1.time_ >= var_27_9 + var_27_12 and arg_24_1.time_ < var_27_9 + var_27_12 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_24_1.var_.actorSpriteSplit128404 ~= nil then
					arg_24_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_27_15 = 0
			local var_27_16 = 0.15

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_17 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(938042006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_20 = 6
				local var_27_21 = utf8.len(var_27_19)
				local var_27_22 = var_27_20 <= 0 and var_27_16 or var_27_16 * (var_27_21 / var_27_20)

				if var_27_22 > 0 and var_27_16 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22

					if var_27_22 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_19
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_23 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_23 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_23

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_23 and arg_24_1.time_ < var_27_15 + var_27_23 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play938042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938042007
		arg_28_1.duration_ = 9

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 2

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_1 = manager.ui.mainCamera.transform.localPosition
				local var_31_2 = Vector3.New(0, 0, 10) + Vector3.New(var_31_1.x, var_31_1.y, 0)
				local var_31_3 = arg_28_1.bgs_.ST0119

				var_31_3.transform.localPosition = var_31_2
				var_31_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_4 = var_31_3:GetComponent("SpriteRenderer")

				if var_31_4 and var_31_4.sprite then
					local var_31_5 = (var_31_3.transform.localPosition - var_31_1).z
					local var_31_6 = manager.ui.mainCameraCom_
					local var_31_7 = 2 * var_31_5 * Mathf.Tan(var_31_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_8 = var_31_7 * var_31_6.aspect
					local var_31_9 = var_31_4.sprite.bounds.size.x
					local var_31_10 = var_31_4.sprite.bounds.size.y
					local var_31_11 = var_31_8 / var_31_9
					local var_31_12 = var_31_7 / var_31_10
					local var_31_13 = var_31_12 < var_31_11 and var_31_11 or var_31_12

					var_31_3.transform.localScale = Vector3.New(var_31_13, var_31_13, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST0119" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_14 = 3.999999999999

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_15 = 0.3

			if arg_28_1.time_ >= var_31_14 + var_31_15 and arg_28_1.time_ < var_31_14 + var_31_15 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_17 = 2

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Color.New(0, 0, 0)

				var_31_19.a = Mathf.Lerp(0, 1, var_31_18)
				arg_28_1.mask_.color = var_31_19
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				local var_31_20 = Color.New(0, 0, 0)

				var_31_20.a = 1
				arg_28_1.mask_.color = var_31_20
			end

			local var_31_21 = 2

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_22 = 2

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_22 then
				local var_31_23 = (arg_28_1.time_ - var_31_21) / var_31_22
				local var_31_24 = Color.New(0, 0, 0)

				var_31_24.a = Mathf.Lerp(1, 0, var_31_23)
				arg_28_1.mask_.color = var_31_24
			end

			if arg_28_1.time_ >= var_31_21 + var_31_22 and arg_28_1.time_ < var_31_21 + var_31_22 + arg_31_0 then
				local var_31_25 = Color.New(0, 0, 0)
				local var_31_26 = 0

				arg_28_1.mask_.enabled = false
				var_31_25.a = var_31_26
				arg_28_1.mask_.color = var_31_25
			end

			local var_31_27 = arg_28_1.actors_["128404"].transform
			local var_31_28 = 1.966

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_27.localPosition
				var_31_27.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 7)

				local var_31_29 = var_31_27.childCount

				for iter_31_2 = 0, var_31_29 - 1 do
					local var_31_30 = var_31_27:GetChild(iter_31_2)

					if var_31_30.name == "" or not string.find(var_31_30.name, "split") then
						var_31_30.gameObject:SetActive(true)
					else
						var_31_30.gameObject:SetActive(false)
					end
				end
			end

			local var_31_31 = 0.001

			if var_31_28 <= arg_28_1.time_ and arg_28_1.time_ < var_31_28 + var_31_31 then
				local var_31_32 = (arg_28_1.time_ - var_31_28) / var_31_31
				local var_31_33 = Vector3.New(0, -2000, 0)

				var_31_27.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, var_31_33, var_31_32)
			end

			if arg_28_1.time_ >= var_31_28 + var_31_31 and arg_28_1.time_ < var_31_28 + var_31_31 + arg_31_0 then
				var_31_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_34 = arg_28_1.actors_["128404"].transform
			local var_31_35 = 4

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_34.localPosition
				var_31_34.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 3)

				local var_31_36 = var_31_34.childCount

				for iter_31_3 = 0, var_31_36 - 1 do
					local var_31_37 = var_31_34:GetChild(iter_31_3)

					if var_31_37.name == "" or not string.find(var_31_37.name, "split") then
						var_31_37.gameObject:SetActive(true)
					else
						var_31_37.gameObject:SetActive(false)
					end
				end
			end

			local var_31_38 = 0.001

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_38 then
				local var_31_39 = (arg_28_1.time_ - var_31_35) / var_31_38
				local var_31_40 = Vector3.New(-16.1, -362, -375)

				var_31_34.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, var_31_40, var_31_39)
			end

			if arg_28_1.time_ >= var_31_35 + var_31_38 and arg_28_1.time_ < var_31_35 + var_31_38 + arg_31_0 then
				var_31_34.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_41 = 4
			local var_31_42 = 0.7

			if var_31_41 < arg_28_1.time_ and arg_28_1.time_ <= var_31_41 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_43 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_43:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_44 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_45 = arg_28_1:GetWordFromCfg(938042007)
				local var_31_46 = arg_28_1:FormatText(var_31_45.content)

				arg_28_1.text_.text = var_31_46

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_47 = 28
				local var_31_48 = utf8.len(var_31_46)
				local var_31_49 = var_31_47 <= 0 and var_31_42 or var_31_42 * (var_31_48 / var_31_47)

				if var_31_49 > 0 and var_31_42 < var_31_49 then
					arg_28_1.talkMaxDuration = var_31_49
					var_31_41 = var_31_41 + 0.3

					if var_31_49 + var_31_41 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_49 + var_31_41
					end
				end

				arg_28_1.text_.text = var_31_46
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_50 = var_31_41 + 0.3
			local var_31_51 = math.max(var_31_42, arg_28_1.talkMaxDuration)

			if var_31_50 <= arg_28_1.time_ and arg_28_1.time_ < var_31_50 + var_31_51 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_50) / var_31_51

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_50 + var_31_51 and arg_28_1.time_ < var_31_50 + var_31_51 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938042008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 938042008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play938042009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["128404"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps128404 == nil then
				arg_34_1.var_.actorSpriteComps128404 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps128404 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 0.5, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps128404 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps128404 = nil
			end

			local var_37_8 = 0
			local var_37_9 = 0.375

			if var_37_8 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_10 = arg_34_1:FormatText(StoryNameCfg[7].name)

				arg_34_1.leftNameTxt_.text = var_37_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_11 = arg_34_1:GetWordFromCfg(938042008)
				local var_37_12 = arg_34_1:FormatText(var_37_11.content)

				arg_34_1.text_.text = var_37_12

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 15
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
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_16 and arg_34_1.time_ < var_37_8 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play938042009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 938042009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play938042010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["128404"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps128404 == nil then
				arg_38_1.var_.actorSpriteComps128404 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps128404 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps128404 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps128404 = nil
			end

			local var_41_8 = arg_38_1.actors_["128404"].transform
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1.var_.moveOldPos128404 = var_41_8.localPosition
				var_41_8.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("128404", 3)

				local var_41_10 = var_41_8.childCount

				for iter_41_4 = 0, var_41_10 - 1 do
					local var_41_11 = var_41_8:GetChild(iter_41_4)

					if var_41_11.name == "split_4" or not string.find(var_41_11.name, "split") then
						var_41_11.gameObject:SetActive(true)
					else
						var_41_11.gameObject:SetActive(false)
					end
				end
			end

			local var_41_12 = 0.001

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_12 then
				local var_41_13 = (arg_38_1.time_ - var_41_9) / var_41_12
				local var_41_14 = Vector3.New(-16.1, -362, -375)

				var_41_8.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos128404, var_41_14, var_41_13)
			end

			if arg_38_1.time_ >= var_41_9 + var_41_12 and arg_38_1.time_ < var_41_9 + var_41_12 + arg_41_0 then
				var_41_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_41_15 = 0
			local var_41_16 = 0.125

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[6].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(938042009)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 5
				local var_41_21 = utf8.len(var_41_19)
				local var_41_22 = var_41_20 <= 0 and var_41_16 or var_41_16 * (var_41_21 / var_41_20)

				if var_41_22 > 0 and var_41_16 < var_41_22 then
					arg_38_1.talkMaxDuration = var_41_22

					if var_41_22 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_22 + var_41_15
					end
				end

				arg_38_1.text_.text = var_41_19
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_23 = math.max(var_41_16, arg_38_1.talkMaxDuration)

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_23 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_15) / var_41_23

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_15 + var_41_23 and arg_38_1.time_ < var_41_15 + var_41_23 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play938042010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 938042010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play938042011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "10144"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(var_45_1, arg_42_1.canvasGo_.transform)

					var_45_2.transform:SetSiblingIndex(1)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs(var_45_3) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_4 = arg_42_1.actors_["10144"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10144 == nil then
				arg_42_1.var_.actorSpriteComps10144 = var_45_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.actorSpriteComps10144 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								local var_45_8 = Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, var_45_7)
								local var_45_9 = Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, var_45_7)
								local var_45_10 = Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, var_45_7)

								iter_45_3.color = Color.New(var_45_8, var_45_9, var_45_10)
							else
								local var_45_11 = Mathf.Lerp(iter_45_3.color.r, 1, var_45_7)

								iter_45_3.color = Color.New(var_45_11, var_45_11, var_45_11)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10144 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_45_5 then
						if arg_42_1.isInRecall_ then
							iter_45_5.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10144 = nil
			end

			local var_45_12 = arg_42_1.actors_["128404"]
			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps128404 == nil then
				arg_42_1.var_.actorSpriteComps128404 = var_45_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_14 = 0.2

			if var_45_13 <= arg_42_1.time_ and arg_42_1.time_ < var_45_13 + var_45_14 and not isNil(var_45_12) then
				local var_45_15 = (arg_42_1.time_ - var_45_13) / var_45_14

				if arg_42_1.var_.actorSpriteComps128404 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								local var_45_16 = Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, var_45_15)
								local var_45_17 = Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, var_45_15)
								local var_45_18 = Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, var_45_15)

								iter_45_7.color = Color.New(var_45_16, var_45_17, var_45_18)
							else
								local var_45_19 = Mathf.Lerp(iter_45_7.color.r, 0.5, var_45_15)

								iter_45_7.color = Color.New(var_45_19, var_45_19, var_45_19)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_13 + var_45_14 and arg_42_1.time_ < var_45_13 + var_45_14 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps128404 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_45_9 then
						if arg_42_1.isInRecall_ then
							iter_45_9.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps128404 = nil
			end

			local var_45_20 = arg_42_1.actors_["10144"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos10144 = var_45_20.localPosition
				var_45_20.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10144", 4)

				local var_45_22 = var_45_20.childCount

				for iter_45_10 = 0, var_45_22 - 1 do
					local var_45_23 = var_45_20:GetChild(iter_45_10)

					if var_45_23.name == "split_2" or not string.find(var_45_23.name, "split") then
						var_45_23.gameObject:SetActive(true)
					else
						var_45_23.gameObject:SetActive(false)
					end
				end
			end

			local var_45_24 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_21) / var_45_24
				local var_45_26 = Vector3.New(435.8, -381.1, -285.9)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10144, var_45_26, var_45_25)
			end

			if arg_42_1.time_ >= var_45_21 + var_45_24 and arg_42_1.time_ < var_45_21 + var_45_24 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_45_27 = arg_42_1.actors_["128404"].transform
			local var_45_28 = 0

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 then
				arg_42_1.var_.moveOldPos128404 = var_45_27.localPosition
				var_45_27.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("128404", 2)

				local var_45_29 = var_45_27.childCount

				for iter_45_11 = 0, var_45_29 - 1 do
					local var_45_30 = var_45_27:GetChild(iter_45_11)

					if var_45_30.name == "" or not string.find(var_45_30.name, "split") then
						var_45_30.gameObject:SetActive(true)
					else
						var_45_30.gameObject:SetActive(false)
					end
				end
			end

			local var_45_31 = 0.001

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_31 then
				local var_45_32 = (arg_42_1.time_ - var_45_28) / var_45_31
				local var_45_33 = Vector3.New(-428.5, -356, -362.3)

				var_45_27.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos128404, var_45_33, var_45_32)
			end

			if arg_42_1.time_ >= var_45_28 + var_45_31 and arg_42_1.time_ < var_45_28 + var_45_31 + arg_45_0 then
				var_45_27.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_45_34 = 0
			local var_45_35 = 0.4

			if var_45_34 < arg_42_1.time_ and arg_42_1.time_ <= var_45_34 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_36 = arg_42_1:FormatText(StoryNameCfg[1297].name)

				arg_42_1.leftNameTxt_.text = var_45_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_37 = arg_42_1:GetWordFromCfg(938042010)
				local var_45_38 = arg_42_1:FormatText(var_45_37.content)

				arg_42_1.text_.text = var_45_38

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_39 = 16
				local var_45_40 = utf8.len(var_45_38)
				local var_45_41 = var_45_39 <= 0 and var_45_35 or var_45_35 * (var_45_40 / var_45_39)

				if var_45_41 > 0 and var_45_35 < var_45_41 then
					arg_42_1.talkMaxDuration = var_45_41

					if var_45_41 + var_45_34 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_41 + var_45_34
					end
				end

				arg_42_1.text_.text = var_45_38
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_42 = math.max(var_45_35, arg_42_1.talkMaxDuration)

			if var_45_34 <= arg_42_1.time_ and arg_42_1.time_ < var_45_34 + var_45_42 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_34) / var_45_42

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_34 + var_45_42 and arg_42_1.time_ < var_45_34 + var_45_42 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play938042011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 938042011
		arg_46_1.duration_ = 1

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"

			SetActive(arg_46_1.choicesGo_, true)

			for iter_47_0, iter_47_1 in ipairs(arg_46_1.choices_) do
				local var_47_0 = iter_47_0 <= 2

				SetActive(iter_47_1.go, var_47_0)
			end

			arg_46_1.choices_[1].txt.text = arg_46_1:FormatText(StoryChoiceCfg[1785].name)
			arg_46_1.choices_[2].txt.text = arg_46_1:FormatText(StoryChoiceCfg[1786].name)
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play938042012(arg_46_1)
			end

			if arg_48_0 == 2 then
				arg_46_0:Play938042012(arg_46_1)
			end

			arg_46_1:RecordChoiceLog(938042011, 1785, 1786)
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10144"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps10144 == nil then
				arg_46_1.var_.actorSpriteComps10144 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps10144 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								local var_49_4 = Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, var_49_3)
								local var_49_5 = Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, var_49_3)
								local var_49_6 = Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, var_49_3)

								iter_49_1.color = Color.New(var_49_4, var_49_5, var_49_6)
							else
								local var_49_7 = Mathf.Lerp(iter_49_1.color.r, 0.5, var_49_3)

								iter_49_1.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps10144 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps10144 = nil
			end

			local var_49_8 = 0

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			local var_49_9 = 0.5

			if arg_46_1.time_ >= var_49_8 + var_49_9 and arg_46_1.time_ < var_49_8 + var_49_9 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play938042012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938042012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938042013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["128404"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps128404 == nil then
				arg_50_1.var_.actorSpriteComps128404 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps128404 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps128404 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps128404 = nil
			end

			local var_53_8 = arg_50_1.actors_["128404"].transform
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.var_.moveOldPos128404 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("128404", 2)

				local var_53_10 = var_53_8.childCount

				for iter_53_4 = 0, var_53_10 - 1 do
					local var_53_11 = var_53_8:GetChild(iter_53_4)

					if var_53_11.name == "split_4" or not string.find(var_53_11.name, "split") then
						var_53_11.gameObject:SetActive(true)
					else
						var_53_11.gameObject:SetActive(false)
					end
				end
			end

			local var_53_12 = 0.001

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_9) / var_53_12
				local var_53_14 = Vector3.New(-428.5, -356, -362.3)

				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos128404, var_53_14, var_53_13)
			end

			if arg_50_1.time_ >= var_53_9 + var_53_12 and arg_50_1.time_ < var_53_9 + var_53_12 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_53_15 = 0
			local var_53_16 = 1.15

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[6].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(938042012)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 46
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
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_23 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_23 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_23

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_23 and arg_50_1.time_ < var_53_15 + var_53_23 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play938042013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938042013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938042014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["128404"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = var_57_0.localPosition
				var_57_0.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				local var_57_2 = var_57_0.childCount

				for iter_57_0 = 0, var_57_2 - 1 do
					local var_57_3 = var_57_0:GetChild(iter_57_0)

					if var_57_3.name == "split_2" then
						var_57_3:SetAsLastSibling()
						var_57_3.gameObject:SetActive(true)

						arg_54_1.var_.actorSpriteSplit128404 = var_57_3.gameObject:GetComponent(typeof(Image))

						arg_54_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_57_4 = 0.5

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_4 then
				local var_57_5 = (arg_54_1.time_ - var_57_1) / var_57_4
				local var_57_6 = Vector3.New(-428.5, -356, -362.3)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, var_57_6, var_57_5)

				if arg_54_1.var_.actorSpriteSplit128404 ~= nil then
					arg_54_1.var_.actorSpriteSplit128404:SetAlpha(var_57_5)
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_4 and arg_54_1.time_ < var_57_1 + var_57_4 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_54_1.var_.actorSpriteSplit128404 ~= nil then
					arg_54_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_57_7 = 0
			local var_57_8 = 0.875

			if var_57_7 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_9 = arg_54_1:FormatText(StoryNameCfg[6].name)

				arg_54_1.leftNameTxt_.text = var_57_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:GetWordFromCfg(938042013)
				local var_57_11 = arg_54_1:FormatText(var_57_10.content)

				arg_54_1.text_.text = var_57_11

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_12 = 35
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
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_15 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_15 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_7) / var_57_15

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_7 + var_57_15 and arg_54_1.time_ < var_57_7 + var_57_15 + arg_57_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play938042014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938042014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938042015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["128404"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 0.5, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_8 = 0
			local var_61_9 = 0.25

			if var_61_8 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_10 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_11 = arg_58_1:GetWordFromCfg(938042014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 10
				local var_61_14 = utf8.len(var_61_12)
				local var_61_15 = var_61_13 <= 0 and var_61_9 or var_61_9 * (var_61_14 / var_61_13)

				if var_61_15 > 0 and var_61_9 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15

					if var_61_15 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_12
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play938042015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938042015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938042016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10144"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10144 == nil then
				arg_62_1.var_.actorSpriteComps10144 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps10144 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								local var_65_4 = Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, var_65_3)
								local var_65_5 = Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, var_65_3)
								local var_65_6 = Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, var_65_3)

								iter_65_1.color = Color.New(var_65_4, var_65_5, var_65_6)
							else
								local var_65_7 = Mathf.Lerp(iter_65_1.color.r, 1, var_65_3)

								iter_65_1.color = Color.New(var_65_7, var_65_7, var_65_7)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10144 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10144 = nil
			end

			local var_65_8 = arg_62_1.actors_["10144"].transform
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.var_.moveOldPos10144 = var_65_8.localPosition
				var_65_8.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10144", 4)

				local var_65_10 = var_65_8.childCount

				for iter_65_4 = 0, var_65_10 - 1 do
					local var_65_11 = var_65_8:GetChild(iter_65_4)

					if var_65_11.name == "" then
						var_65_11:SetAsLastSibling()
						var_65_11.gameObject:SetActive(true)

						arg_62_1.var_.actorSpriteSplit10144 = var_65_11.gameObject:GetComponent(typeof(Image))

						arg_62_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_65_12 = 0.5

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_9) / var_65_12
				local var_65_14 = Vector3.New(435.8, -381.1, -285.9)

				var_65_8.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10144, var_65_14, var_65_13)

				if arg_62_1.var_.actorSpriteSplit10144 ~= nil then
					arg_62_1.var_.actorSpriteSplit10144:SetAlpha(var_65_13)
				end
			end

			if arg_62_1.time_ >= var_65_9 + var_65_12 and arg_62_1.time_ < var_65_9 + var_65_12 + arg_65_0 then
				var_65_8.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_62_1.var_.actorSpriteSplit10144 ~= nil then
					arg_62_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_65_15 = 0
			local var_65_16 = 0.4

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[1297].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(938042015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 16
				local var_65_21 = utf8.len(var_65_19)
				local var_65_22 = var_65_20 <= 0 and var_65_16 or var_65_16 * (var_65_21 / var_65_20)

				if var_65_22 > 0 and var_65_16 < var_65_22 then
					arg_62_1.talkMaxDuration = var_65_22

					if var_65_22 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_15
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_23 = math.max(var_65_16, arg_62_1.talkMaxDuration)

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_23 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_15) / var_65_23

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_15 + var_65_23 and arg_62_1.time_ < var_65_15 + var_65_23 + arg_65_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play938042016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938042016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938042017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.475

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1297].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(938042016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 19
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
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play938042017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 938042017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play938042018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10144"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos10144 = var_73_0.localPosition
				var_73_0.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("10144", 4)

				local var_73_2 = var_73_0.childCount

				for iter_73_0 = 0, var_73_2 - 1 do
					local var_73_3 = var_73_0:GetChild(iter_73_0)

					if var_73_3.name == "split_7" then
						var_73_3:SetAsLastSibling()
						var_73_3.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit10144 = var_73_3.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_73_4 = 0.5

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_4 then
				local var_73_5 = (arg_70_1.time_ - var_73_1) / var_73_4
				local var_73_6 = Vector3.New(435.8, -381.1, -285.9)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10144, var_73_6, var_73_5)

				if arg_70_1.var_.actorSpriteSplit10144 ~= nil then
					arg_70_1.var_.actorSpriteSplit10144:SetAlpha(var_73_5)
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_4 and arg_70_1.time_ < var_73_1 + var_73_4 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_70_1.var_.actorSpriteSplit10144 ~= nil then
					arg_70_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_73_7 = 0
			local var_73_8 = 0.775

			if var_73_7 < arg_70_1.time_ and arg_70_1.time_ <= var_73_7 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_9 = arg_70_1:FormatText(StoryNameCfg[1297].name)

				arg_70_1.leftNameTxt_.text = var_73_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:GetWordFromCfg(938042017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_12 = 31
				local var_73_13 = utf8.len(var_73_11)
				local var_73_14 = var_73_12 <= 0 and var_73_8 or var_73_8 * (var_73_13 / var_73_12)

				if var_73_14 > 0 and var_73_8 < var_73_14 then
					arg_70_1.talkMaxDuration = var_73_14

					if var_73_14 + var_73_7 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_7
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_15 = math.max(var_73_8, arg_70_1.talkMaxDuration)

			if var_73_7 <= arg_70_1.time_ and arg_70_1.time_ < var_73_7 + var_73_15 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_7) / var_73_15

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_7 + var_73_15 and arg_70_1.time_ < var_73_7 + var_73_15 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play938042018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 938042018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play938042019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10144"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10144 == nil then
				arg_74_1.var_.actorSpriteComps10144 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps10144 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10144 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps10144 = nil
			end

			local var_77_8 = 0
			local var_77_9 = 0.25

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_10 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_11 = arg_74_1:GetWordFromCfg(938042018)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 10
				local var_77_14 = utf8.len(var_77_12)
				local var_77_15 = var_77_13 <= 0 and var_77_9 or var_77_9 * (var_77_14 / var_77_13)

				if var_77_15 > 0 and var_77_9 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_12
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play938042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938042019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10144"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10144 == nil then
				arg_78_1.var_.actorSpriteComps10144 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10144 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10144 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10144 = nil
			end

			local var_81_8 = arg_78_1.actors_["10144"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos10144 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10144", 4)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "split_1" then
						var_81_11:SetAsLastSibling()
						var_81_11.gameObject:SetActive(true)

						arg_78_1.var_.actorSpriteSplit10144 = var_81_11.gameObject:GetComponent(typeof(Image))

						arg_78_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_81_12 = 0.5

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(435.8, -381.1, -285.9)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10144, var_81_14, var_81_13)

				if arg_78_1.var_.actorSpriteSplit10144 ~= nil then
					arg_78_1.var_.actorSpriteSplit10144:SetAlpha(var_81_13)
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_78_1.var_.actorSpriteSplit10144 ~= nil then
					arg_78_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_81_15 = 0
			local var_81_16 = 0.9

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[1297].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(938042019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 36
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
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_23 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_23 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_23

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_23 and arg_78_1.time_ < var_81_15 + var_81_23 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play938042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938042020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10144"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos10144 = var_85_0.localPosition
				var_85_0.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10144", 4)

				local var_85_2 = var_85_0.childCount

				for iter_85_0 = 0, var_85_2 - 1 do
					local var_85_3 = var_85_0:GetChild(iter_85_0)

					if var_85_3.name == "" or not string.find(var_85_3.name, "split") then
						var_85_3.gameObject:SetActive(true)
					else
						var_85_3.gameObject:SetActive(false)
					end
				end
			end

			local var_85_4 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_4 then
				local var_85_5 = (arg_82_1.time_ - var_85_1) / var_85_4
				local var_85_6 = Vector3.New(435.8, -381.1, -285.9)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10144, var_85_6, var_85_5)
			end

			if arg_82_1.time_ >= var_85_1 + var_85_4 and arg_82_1.time_ < var_85_1 + var_85_4 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_85_7 = 0
			local var_85_8 = 0.95

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_9 = arg_82_1:FormatText(StoryNameCfg[1297].name)

				arg_82_1.leftNameTxt_.text = var_85_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(938042020)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_12 = 38
				local var_85_13 = utf8.len(var_85_11)
				local var_85_14 = var_85_12 <= 0 and var_85_8 or var_85_8 * (var_85_13 / var_85_12)

				if var_85_14 > 0 and var_85_8 < var_85_14 then
					arg_82_1.talkMaxDuration = var_85_14

					if var_85_14 + var_85_7 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_7
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_15 = math.max(var_85_8, arg_82_1.talkMaxDuration)

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_15 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_7) / var_85_15

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_7 + var_85_15 and arg_82_1.time_ < var_85_7 + var_85_15 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play938042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938042022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["128404"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps128404 == nil then
				arg_86_1.var_.actorSpriteComps128404 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps128404 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 1, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps128404 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps128404 = nil
			end

			local var_89_8 = arg_86_1.actors_["10144"]
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = var_89_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_10 = 0.2

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 and not isNil(var_89_8) then
				local var_89_11 = (arg_86_1.time_ - var_89_9) / var_89_10

				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								local var_89_12 = Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor2.r, var_89_11)
								local var_89_13 = Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor2.g, var_89_11)
								local var_89_14 = Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor2.b, var_89_11)

								iter_89_5.color = Color.New(var_89_12, var_89_13, var_89_14)
							else
								local var_89_15 = Mathf.Lerp(iter_89_5.color.r, 0.5, var_89_11)

								iter_89_5.color = Color.New(var_89_15, var_89_15, var_89_15)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_7 then
						if arg_86_1.isInRecall_ then
							iter_89_7.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_16 = arg_86_1.actors_["128404"].transform
			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.var_.moveOldPos128404 = var_89_16.localPosition
				var_89_16.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("128404", 2)

				local var_89_18 = var_89_16.childCount

				for iter_89_8 = 0, var_89_18 - 1 do
					local var_89_19 = var_89_16:GetChild(iter_89_8)

					if var_89_19.name == "split_1" then
						var_89_19:SetAsLastSibling()
						var_89_19.gameObject:SetActive(true)

						arg_86_1.var_.actorSpriteSplit128404 = var_89_19.gameObject:GetComponent(typeof(Image))

						arg_86_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_89_20 = 0.5

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_20 then
				local var_89_21 = (arg_86_1.time_ - var_89_17) / var_89_20
				local var_89_22 = Vector3.New(-428.5, -356, -362.3)

				var_89_16.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos128404, var_89_22, var_89_21)

				if arg_86_1.var_.actorSpriteSplit128404 ~= nil then
					arg_86_1.var_.actorSpriteSplit128404:SetAlpha(var_89_21)
				end
			end

			if arg_86_1.time_ >= var_89_17 + var_89_20 and arg_86_1.time_ < var_89_17 + var_89_20 + arg_89_0 then
				var_89_16.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_86_1.var_.actorSpriteSplit128404 ~= nil then
					arg_86_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_89_23 = 0
			local var_89_24 = 0.425

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_25 = arg_86_1:FormatText(StoryNameCfg[6].name)

				arg_86_1.leftNameTxt_.text = var_89_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_26 = arg_86_1:GetWordFromCfg(938042021)
				local var_89_27 = arg_86_1:FormatText(var_89_26.content)

				arg_86_1.text_.text = var_89_27

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_28 = 17
				local var_89_29 = utf8.len(var_89_27)
				local var_89_30 = var_89_28 <= 0 and var_89_24 or var_89_24 * (var_89_29 / var_89_28)

				if var_89_30 > 0 and var_89_24 < var_89_30 then
					arg_86_1.talkMaxDuration = var_89_30

					if var_89_30 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_30 + var_89_23
					end
				end

				arg_86_1.text_.text = var_89_27
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_31 = math.max(var_89_24, arg_86_1.talkMaxDuration)

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_31 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_23) / var_89_31

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_23 + var_89_31 and arg_86_1.time_ < var_89_23 + var_89_31 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play938042022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938042022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938042023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["128404"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps128404 == nil then
				arg_90_1.var_.actorSpriteComps128404 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps128404 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 0.5, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps128404 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps128404 = nil
			end

			local var_93_8 = 0
			local var_93_9 = 0.4

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_11 = arg_90_1:GetWordFromCfg(938042022)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 16
				local var_93_14 = utf8.len(var_93_12)
				local var_93_15 = var_93_13 <= 0 and var_93_9 or var_93_9 * (var_93_14 / var_93_13)

				if var_93_15 > 0 and var_93_9 < var_93_15 then
					arg_90_1.talkMaxDuration = var_93_15

					if var_93_15 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_12
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play938042023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938042023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938042024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["128404"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps128404 == nil then
				arg_94_1.var_.actorSpriteComps128404 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps128404 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps128404 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps128404 = nil
			end

			local var_97_8 = arg_94_1.actors_["128404"].transform
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.var_.moveOldPos128404 = var_97_8.localPosition
				var_97_8.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("128404", 2)

				local var_97_10 = var_97_8.childCount

				for iter_97_4 = 0, var_97_10 - 1 do
					local var_97_11 = var_97_8:GetChild(iter_97_4)

					if var_97_11.name == "split_4" then
						var_97_11:SetAsLastSibling()
						var_97_11.gameObject:SetActive(true)

						arg_94_1.var_.actorSpriteSplit128404 = var_97_11.gameObject:GetComponent(typeof(Image))

						arg_94_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_97_12 = 0.5

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_9) / var_97_12
				local var_97_14 = Vector3.New(-428.5, -356, -362.3)

				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos128404, var_97_14, var_97_13)

				if arg_94_1.var_.actorSpriteSplit128404 ~= nil then
					arg_94_1.var_.actorSpriteSplit128404:SetAlpha(var_97_13)
				end
			end

			if arg_94_1.time_ >= var_97_9 + var_97_12 and arg_94_1.time_ < var_97_9 + var_97_12 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_94_1.var_.actorSpriteSplit128404 ~= nil then
					arg_94_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_97_15 = 0
			local var_97_16 = 0.925

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_17 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(938042023)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 37
				local var_97_21 = utf8.len(var_97_19)
				local var_97_22 = var_97_20 <= 0 and var_97_16 or var_97_16 * (var_97_21 / var_97_20)

				if var_97_22 > 0 and var_97_16 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22

					if var_97_22 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_15
					end
				end

				arg_94_1.text_.text = var_97_19
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_23 = math.max(var_97_16, arg_94_1.talkMaxDuration)

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_23 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_15) / var_97_23

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_15 + var_97_23 and arg_94_1.time_ < var_97_15 + var_97_23 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play938042024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938042024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938042025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["128404"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps128404 == nil then
				arg_98_1.var_.actorSpriteComps128404 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps128404 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps128404 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps128404 = nil
			end

			local var_101_8 = 0
			local var_101_9 = 0.35

			if var_101_8 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_10 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_11 = arg_98_1:GetWordFromCfg(938042024)
				local var_101_12 = arg_98_1:FormatText(var_101_11.content)

				arg_98_1.text_.text = var_101_12

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 14
				local var_101_14 = utf8.len(var_101_12)
				local var_101_15 = var_101_13 <= 0 and var_101_9 or var_101_9 * (var_101_14 / var_101_13)

				if var_101_15 > 0 and var_101_9 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_12
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play938042025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938042025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938042026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["128404"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps128404 == nil then
				arg_102_1.var_.actorSpriteComps128404 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps128404 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps128404 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps128404 = nil
			end

			local var_105_8 = arg_102_1.actors_["128404"].transform
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1.var_.moveOldPos128404 = var_105_8.localPosition
				var_105_8.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("128404", 2)

				local var_105_10 = var_105_8.childCount

				for iter_105_4 = 0, var_105_10 - 1 do
					local var_105_11 = var_105_8:GetChild(iter_105_4)

					if var_105_11.name == "split_6" then
						var_105_11:SetAsLastSibling()
						var_105_11.gameObject:SetActive(true)

						arg_102_1.var_.actorSpriteSplit128404 = var_105_11.gameObject:GetComponent(typeof(Image))

						arg_102_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_105_12 = 0.5

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_9) / var_105_12
				local var_105_14 = Vector3.New(-428.5, -356, -362.3)

				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos128404, var_105_14, var_105_13)

				if arg_102_1.var_.actorSpriteSplit128404 ~= nil then
					arg_102_1.var_.actorSpriteSplit128404:SetAlpha(var_105_13)
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_12 and arg_102_1.time_ < var_105_9 + var_105_12 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_102_1.var_.actorSpriteSplit128404 ~= nil then
					arg_102_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_105_15 = 0
			local var_105_16 = 0.125

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[6].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(938042025)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 5
				local var_105_21 = utf8.len(var_105_19)
				local var_105_22 = var_105_20 <= 0 and var_105_16 or var_105_16 * (var_105_21 / var_105_20)

				if var_105_22 > 0 and var_105_16 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22

					if var_105_22 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_19
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_23 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_23 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_23

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_23 and arg_102_1.time_ < var_105_15 + var_105_23 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938042026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938042026
		arg_106_1.duration_ = 1

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"

			SetActive(arg_106_1.choicesGo_, true)

			for iter_107_0, iter_107_1 in ipairs(arg_106_1.choices_) do
				local var_107_0 = iter_107_0 <= 1

				SetActive(iter_107_1.go, var_107_0)
			end

			arg_106_1.choices_[1].txt.text = arg_106_1:FormatText(StoryChoiceCfg[1787].name)
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938042027(arg_106_1)
			end

			arg_106_1:RecordChoiceLog(938042026, 1787)
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["128404"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps128404 == nil then
				arg_106_1.var_.actorSpriteComps128404 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps128404 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor2.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor2.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor2.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 0.5, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps128404 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps128404 = nil
			end

			local var_109_8 = 0

			if var_109_8 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.allBtn_.enabled = false
			end

			local var_109_9 = 0.5

			if arg_106_1.time_ >= var_109_8 + var_109_9 and arg_106_1.time_ < var_109_8 + var_109_9 + arg_109_0 then
				arg_106_1.allBtn_.enabled = true
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play938042027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938042027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938042028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["128404"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps128404 == nil then
				arg_110_1.var_.actorSpriteComps128404 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps128404 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps128404 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps128404 = nil
			end

			local var_113_8 = arg_110_1.actors_["128404"].transform
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.var_.moveOldPos128404 = var_113_8.localPosition
				var_113_8.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("128404", 2)

				local var_113_10 = var_113_8.childCount

				for iter_113_4 = 0, var_113_10 - 1 do
					local var_113_11 = var_113_8:GetChild(iter_113_4)

					if var_113_11.name == "split_4" then
						var_113_11:SetAsLastSibling()
						var_113_11.gameObject:SetActive(true)

						arg_110_1.var_.actorSpriteSplit128404 = var_113_11.gameObject:GetComponent(typeof(Image))

						arg_110_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_113_12 = 0.5

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_12 then
				local var_113_13 = (arg_110_1.time_ - var_113_9) / var_113_12
				local var_113_14 = Vector3.New(-428.5, -356, -362.3)

				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, var_113_14, var_113_13)

				if arg_110_1.var_.actorSpriteSplit128404 ~= nil then
					arg_110_1.var_.actorSpriteSplit128404:SetAlpha(var_113_13)
				end
			end

			if arg_110_1.time_ >= var_113_9 + var_113_12 and arg_110_1.time_ < var_113_9 + var_113_12 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_110_1.var_.actorSpriteSplit128404 ~= nil then
					arg_110_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_113_15 = 0
			local var_113_16 = 0.175

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_17 = arg_110_1:FormatText(StoryNameCfg[6].name)

				arg_110_1.leftNameTxt_.text = var_113_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(938042027)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 7
				local var_113_21 = utf8.len(var_113_19)
				local var_113_22 = var_113_20 <= 0 and var_113_16 or var_113_16 * (var_113_21 / var_113_20)

				if var_113_22 > 0 and var_113_16 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_23 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_23 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_23

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_23 and arg_110_1.time_ < var_113_15 + var_113_23 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play938042028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938042028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938042029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["128404"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps128404 == nil then
				arg_114_1.var_.actorSpriteComps128404 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps128404 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 0.5, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps128404 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps128404 = nil
			end

			local var_117_8 = 0
			local var_117_9 = 0.175

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_10 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_11 = arg_114_1:GetWordFromCfg(938042028)
				local var_117_12 = arg_114_1:FormatText(var_117_11.content)

				arg_114_1.text_.text = var_117_12

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 7
				local var_117_14 = utf8.len(var_117_12)
				local var_117_15 = var_117_13 <= 0 and var_117_9 or var_117_9 * (var_117_14 / var_117_13)

				if var_117_15 > 0 and var_117_9 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_12
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_16 and arg_114_1.time_ < var_117_8 + var_117_16 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play938042029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938042029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938042030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["128404"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps128404 == nil then
				arg_118_1.var_.actorSpriteComps128404 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps128404 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps128404 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps128404 = nil
			end

			local var_121_8 = arg_118_1.actors_["128404"].transform
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.var_.moveOldPos128404 = var_121_8.localPosition
				var_121_8.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("128404", 2)

				local var_121_10 = var_121_8.childCount

				for iter_121_4 = 0, var_121_10 - 1 do
					local var_121_11 = var_121_8:GetChild(iter_121_4)

					if var_121_11.name == "split_2" then
						var_121_11:SetAsLastSibling()
						var_121_11.gameObject:SetActive(true)

						arg_118_1.var_.actorSpriteSplit128404 = var_121_11.gameObject:GetComponent(typeof(Image))

						arg_118_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_121_12 = 0.5

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_9) / var_121_12
				local var_121_14 = Vector3.New(-428.5, -356, -362.3)

				var_121_8.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos128404, var_121_14, var_121_13)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(var_121_13)
				end
			end

			if arg_118_1.time_ >= var_121_9 + var_121_12 and arg_118_1.time_ < var_121_9 + var_121_12 + arg_121_0 then
				var_121_8.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_121_15 = 0
			local var_121_16 = 0.15

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(938042029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 6
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_23 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_23 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_23

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_23 and arg_118_1.time_ < var_121_15 + var_121_23 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play938042030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938042030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938042031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["128404"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 0.5, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_8 = 0
			local var_125_9 = 0.275

			if var_125_8 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_10 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_11 = arg_122_1:GetWordFromCfg(938042030)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 11
				local var_125_14 = utf8.len(var_125_12)
				local var_125_15 = var_125_13 <= 0 and var_125_9 or var_125_9 * (var_125_14 / var_125_13)

				if var_125_15 > 0 and var_125_9 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play938042031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938042031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938042032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["128404"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps128404 == nil then
				arg_126_1.var_.actorSpriteComps128404 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps128404 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps128404 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps128404 = nil
			end

			local var_129_8 = arg_126_1.actors_["128404"].transform
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				arg_126_1.var_.moveOldPos128404 = var_129_8.localPosition
				var_129_8.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("128404", 2)

				local var_129_10 = var_129_8.childCount

				for iter_129_4 = 0, var_129_10 - 1 do
					local var_129_11 = var_129_8:GetChild(iter_129_4)

					if var_129_11.name == "split_1" then
						var_129_11:SetAsLastSibling()
						var_129_11.gameObject:SetActive(true)

						arg_126_1.var_.actorSpriteSplit128404 = var_129_11.gameObject:GetComponent(typeof(Image))

						arg_126_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_129_12 = 0.5

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_12 then
				local var_129_13 = (arg_126_1.time_ - var_129_9) / var_129_12
				local var_129_14 = Vector3.New(-428.5, -356, -362.3)

				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos128404, var_129_14, var_129_13)

				if arg_126_1.var_.actorSpriteSplit128404 ~= nil then
					arg_126_1.var_.actorSpriteSplit128404:SetAlpha(var_129_13)
				end
			end

			if arg_126_1.time_ >= var_129_9 + var_129_12 and arg_126_1.time_ < var_129_9 + var_129_12 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_126_1.var_.actorSpriteSplit128404 ~= nil then
					arg_126_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_129_15 = 0
			local var_129_16 = 0.325

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(938042031)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 13
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_23 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_23 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_23

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_23 and arg_126_1.time_ < var_129_15 + var_129_23 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938042032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938042032
		arg_130_1.duration_ = 9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938042033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "ST84"

			if arg_130_1.bgs_[var_133_0] == nil then
				local var_133_1 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_133_0)
				var_133_1.name = var_133_0
				var_133_1.transform.parent = arg_130_1.stage_.transform
				var_133_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_[var_133_0] = var_133_1
			end

			local var_133_2 = 2

			if var_133_2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				local var_133_3 = manager.ui.mainCamera.transform.localPosition
				local var_133_4 = Vector3.New(0, 0, 10) + Vector3.New(var_133_3.x, var_133_3.y, 0)
				local var_133_5 = arg_130_1.bgs_.ST84

				var_133_5.transform.localPosition = var_133_4
				var_133_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_6 = var_133_5:GetComponent("SpriteRenderer")

				if var_133_6 and var_133_6.sprite then
					local var_133_7 = (var_133_5.transform.localPosition - var_133_3).z
					local var_133_8 = manager.ui.mainCameraCom_
					local var_133_9 = 2 * var_133_7 * Mathf.Tan(var_133_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_10 = var_133_9 * var_133_8.aspect
					local var_133_11 = var_133_6.sprite.bounds.size.x
					local var_133_12 = var_133_6.sprite.bounds.size.y
					local var_133_13 = var_133_10 / var_133_11
					local var_133_14 = var_133_9 / var_133_12
					local var_133_15 = var_133_14 < var_133_13 and var_133_13 or var_133_14

					var_133_5.transform.localScale = Vector3.New(var_133_15, var_133_15, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST84" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_16 = 3.999999999999

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_17 = 0.3

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_18 = 0

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_19 = 2

			if var_133_18 <= arg_130_1.time_ and arg_130_1.time_ < var_133_18 + var_133_19 then
				local var_133_20 = (arg_130_1.time_ - var_133_18) / var_133_19
				local var_133_21 = Color.New(0, 0, 0)

				var_133_21.a = Mathf.Lerp(0, 1, var_133_20)
				arg_130_1.mask_.color = var_133_21
			end

			if arg_130_1.time_ >= var_133_18 + var_133_19 and arg_130_1.time_ < var_133_18 + var_133_19 + arg_133_0 then
				local var_133_22 = Color.New(0, 0, 0)

				var_133_22.a = 1
				arg_130_1.mask_.color = var_133_22
			end

			local var_133_23 = 2

			if var_133_23 < arg_130_1.time_ and arg_130_1.time_ <= var_133_23 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_24 = 2

			if var_133_23 <= arg_130_1.time_ and arg_130_1.time_ < var_133_23 + var_133_24 then
				local var_133_25 = (arg_130_1.time_ - var_133_23) / var_133_24
				local var_133_26 = Color.New(0, 0, 0)

				var_133_26.a = Mathf.Lerp(1, 0, var_133_25)
				arg_130_1.mask_.color = var_133_26
			end

			if arg_130_1.time_ >= var_133_23 + var_133_24 and arg_130_1.time_ < var_133_23 + var_133_24 + arg_133_0 then
				local var_133_27 = Color.New(0, 0, 0)
				local var_133_28 = 0

				arg_130_1.mask_.enabled = false
				var_133_27.a = var_133_28
				arg_130_1.mask_.color = var_133_27
			end

			local var_133_29 = arg_130_1.actors_["128404"]
			local var_133_30 = 1.966

			if var_133_30 < arg_130_1.time_ and arg_130_1.time_ <= var_133_30 + arg_133_0 and not isNil(var_133_29) and arg_130_1.var_.actorSpriteComps128404 == nil then
				arg_130_1.var_.actorSpriteComps128404 = var_133_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_31 = 0.034

			if var_133_30 <= arg_130_1.time_ and arg_130_1.time_ < var_133_30 + var_133_31 and not isNil(var_133_29) then
				local var_133_32 = (arg_130_1.time_ - var_133_30) / var_133_31

				if arg_130_1.var_.actorSpriteComps128404 then
					for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_133_3 then
							if arg_130_1.isInRecall_ then
								local var_133_33 = Mathf.Lerp(iter_133_3.color.r, arg_130_1.hightColor2.r, var_133_32)
								local var_133_34 = Mathf.Lerp(iter_133_3.color.g, arg_130_1.hightColor2.g, var_133_32)
								local var_133_35 = Mathf.Lerp(iter_133_3.color.b, arg_130_1.hightColor2.b, var_133_32)

								iter_133_3.color = Color.New(var_133_33, var_133_34, var_133_35)
							else
								local var_133_36 = Mathf.Lerp(iter_133_3.color.r, 0.5, var_133_32)

								iter_133_3.color = Color.New(var_133_36, var_133_36, var_133_36)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_30 + var_133_31 and arg_130_1.time_ < var_133_30 + var_133_31 + arg_133_0 and not isNil(var_133_29) and arg_130_1.var_.actorSpriteComps128404 then
				for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_133_5 then
						if arg_130_1.isInRecall_ then
							iter_133_5.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps128404 = nil
			end

			local var_133_37 = arg_130_1.actors_["128404"].transform
			local var_133_38 = 1.966

			if var_133_38 < arg_130_1.time_ and arg_130_1.time_ <= var_133_38 + arg_133_0 then
				arg_130_1.var_.moveOldPos128404 = var_133_37.localPosition
				var_133_37.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("128404", 7)

				local var_133_39 = var_133_37.childCount

				for iter_133_6 = 0, var_133_39 - 1 do
					local var_133_40 = var_133_37:GetChild(iter_133_6)

					if var_133_40.name == "" or not string.find(var_133_40.name, "split") then
						var_133_40.gameObject:SetActive(true)
					else
						var_133_40.gameObject:SetActive(false)
					end
				end
			end

			local var_133_41 = 0.001

			if var_133_38 <= arg_130_1.time_ and arg_130_1.time_ < var_133_38 + var_133_41 then
				local var_133_42 = (arg_130_1.time_ - var_133_38) / var_133_41
				local var_133_43 = Vector3.New(0, -2000, 0)

				var_133_37.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos128404, var_133_43, var_133_42)
			end

			if arg_130_1.time_ >= var_133_38 + var_133_41 and arg_130_1.time_ < var_133_38 + var_133_41 + arg_133_0 then
				var_133_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_44 = arg_130_1.actors_["10144"].transform
			local var_133_45 = 1.966

			if var_133_45 < arg_130_1.time_ and arg_130_1.time_ <= var_133_45 + arg_133_0 then
				arg_130_1.var_.moveOldPos10144 = var_133_44.localPosition
				var_133_44.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10144", 7)

				local var_133_46 = var_133_44.childCount

				for iter_133_7 = 0, var_133_46 - 1 do
					local var_133_47 = var_133_44:GetChild(iter_133_7)

					if var_133_47.name == "" or not string.find(var_133_47.name, "split") then
						var_133_47.gameObject:SetActive(true)
					else
						var_133_47.gameObject:SetActive(false)
					end
				end
			end

			local var_133_48 = 0.001

			if var_133_45 <= arg_130_1.time_ and arg_130_1.time_ < var_133_45 + var_133_48 then
				local var_133_49 = (arg_130_1.time_ - var_133_45) / var_133_48
				local var_133_50 = Vector3.New(0, -2000, 0)

				var_133_44.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10144, var_133_50, var_133_49)
			end

			if arg_130_1.time_ >= var_133_45 + var_133_48 and arg_130_1.time_ < var_133_45 + var_133_48 + arg_133_0 then
				var_133_44.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_51 = 2.999999999999
			local var_133_52 = 1

			if var_133_51 < arg_130_1.time_ and arg_130_1.time_ <= var_133_51 + arg_133_0 then
				local var_133_53 = "play"
				local var_133_54 = "effect"

				arg_130_1:AudioAction(var_133_53, var_133_54, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_133_55 = 2.299999999999
			local var_133_56 = 1

			if var_133_55 < arg_130_1.time_ and arg_130_1.time_ <= var_133_55 + arg_133_0 then
				local var_133_57 = "stop"
				local var_133_58 = "effect"

				arg_130_1:AudioAction(var_133_57, var_133_58, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_133_59 = 2.999999999999
			local var_133_60 = 1

			if var_133_59 < arg_130_1.time_ and arg_130_1.time_ <= var_133_59 + arg_133_0 then
				local var_133_61 = "play"
				local var_133_62 = "music"

				arg_130_1:AudioAction(var_133_61, var_133_62, "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_133_63 = ""
				local var_133_64 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if var_133_64 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_64 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_64

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_64
						arg_130_1.bgmTxt2_.text = var_133_64
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_65 = 4
			local var_133_66 = 1.1

			if var_133_65 < arg_130_1.time_ and arg_130_1.time_ <= var_133_65 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_67 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_67:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_130_1.dialogCg_.alpha = arg_135_0
				end))
				var_133_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_68 = arg_130_1:GetWordFromCfg(938042032)
				local var_133_69 = arg_130_1:FormatText(var_133_68.content)

				arg_130_1.text_.text = var_133_69

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_70 = 44
				local var_133_71 = utf8.len(var_133_69)
				local var_133_72 = var_133_70 <= 0 and var_133_66 or var_133_66 * (var_133_71 / var_133_70)

				if var_133_72 > 0 and var_133_66 < var_133_72 then
					arg_130_1.talkMaxDuration = var_133_72
					var_133_65 = var_133_65 + 0.3

					if var_133_72 + var_133_65 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_72 + var_133_65
					end
				end

				arg_130_1.text_.text = var_133_69
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_73 = var_133_65 + 0.3
			local var_133_74 = math.max(var_133_66, arg_130_1.talkMaxDuration)

			if var_133_73 <= arg_130_1.time_ and arg_130_1.time_ < var_133_73 + var_133_74 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_73) / var_133_74

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_73 + var_133_74 and arg_130_1.time_ < var_133_73 + var_133_74 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play938042033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 938042033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play938042034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["128404"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps128404 == nil then
				arg_137_1.var_.actorSpriteComps128404 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps128404 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 1, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps128404 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps128404 = nil
			end

			local var_140_8 = arg_137_1.actors_["128404"].transform
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.var_.moveOldPos128404 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("128404", 3)

				local var_140_10 = var_140_8.childCount

				for iter_140_4 = 0, var_140_10 - 1 do
					local var_140_11 = var_140_8:GetChild(iter_140_4)

					if var_140_11.name == "split_2" or not string.find(var_140_11.name, "split") then
						var_140_11.gameObject:SetActive(true)
					else
						var_140_11.gameObject:SetActive(false)
					end
				end
			end

			local var_140_12 = 0.001

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_9) / var_140_12
				local var_140_14 = Vector3.New(-16.1, -362, -375)

				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos128404, var_140_14, var_140_13)
			end

			if arg_137_1.time_ >= var_140_9 + var_140_12 and arg_137_1.time_ < var_140_9 + var_140_12 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_140_15 = 0
			local var_140_16 = 0.6

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[6].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(938042033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 24
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_23 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_23 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_23

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_23 and arg_137_1.time_ < var_140_15 + var_140_23 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play938042034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 938042034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play938042035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["128404"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps128404 == nil then
				arg_141_1.var_.actorSpriteComps128404 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps128404 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps128404 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps128404 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.675

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_10 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_11 = arg_141_1:GetWordFromCfg(938042034)
				local var_144_12 = arg_141_1:FormatText(var_144_11.content)

				arg_141_1.text_.text = var_144_12

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 27
				local var_144_14 = utf8.len(var_144_12)
				local var_144_15 = var_144_13 <= 0 and var_144_9 or var_144_9 * (var_144_14 / var_144_13)

				if var_144_15 > 0 and var_144_9 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_12
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play938042035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 938042035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play938042036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["128404"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps128404 == nil then
				arg_145_1.var_.actorSpriteComps128404 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps128404 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps128404 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps128404 = nil
			end

			local var_148_8 = arg_145_1.actors_["128404"].transform
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos128404 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("128404", 3)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "split_1" then
						var_148_11:SetAsLastSibling()
						var_148_11.gameObject:SetActive(true)

						arg_145_1.var_.actorSpriteSplit128404 = var_148_11.gameObject:GetComponent(typeof(Image))

						arg_145_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_148_12 = 0.5

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(-16.1, -362, -375)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos128404, var_148_14, var_148_13)

				if arg_145_1.var_.actorSpriteSplit128404 ~= nil then
					arg_145_1.var_.actorSpriteSplit128404:SetAlpha(var_148_13)
				end
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_145_1.var_.actorSpriteSplit128404 ~= nil then
					arg_145_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_148_15 = 0
			local var_148_16 = 0.425

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(938042035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 17
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_23 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_23 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_23

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_23 and arg_145_1.time_ < var_148_15 + var_148_23 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play938042036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 938042036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play938042037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["128404"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.55

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_11 = arg_149_1:GetWordFromCfg(938042036)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 22
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play938042037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 938042037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play938042038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["128404"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_8 = arg_153_1.actors_["128404"].transform
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.var_.moveOldPos128404 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("128404", 3)

				local var_156_10 = var_156_8.childCount

				for iter_156_4 = 0, var_156_10 - 1 do
					local var_156_11 = var_156_8:GetChild(iter_156_4)

					if var_156_11.name == "split_4" then
						var_156_11:SetAsLastSibling()
						var_156_11.gameObject:SetActive(true)

						arg_153_1.var_.actorSpriteSplit128404 = var_156_11.gameObject:GetComponent(typeof(Image))

						arg_153_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_156_12 = 0.5

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_9) / var_156_12
				local var_156_14 = Vector3.New(-16.1, -362, -375)

				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos128404, var_156_14, var_156_13)

				if arg_153_1.var_.actorSpriteSplit128404 ~= nil then
					arg_153_1.var_.actorSpriteSplit128404:SetAlpha(var_156_13)
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_12 and arg_153_1.time_ < var_156_9 + var_156_12 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_153_1.var_.actorSpriteSplit128404 ~= nil then
					arg_153_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_156_15 = 0
			local var_156_16 = 0.075

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[6].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(938042037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 3
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_23 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_23 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_23

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_23 and arg_153_1.time_ < var_156_15 + var_156_23 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play938042038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 938042038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play938042039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["128404"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps128404 == nil then
				arg_157_1.var_.actorSpriteComps128404 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps128404 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 0.5, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps128404 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps128404 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 1.025

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_10 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_11 = arg_157_1:GetWordFromCfg(938042038)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 41
				local var_160_14 = utf8.len(var_160_12)
				local var_160_15 = var_160_13 <= 0 and var_160_9 or var_160_9 * (var_160_14 / var_160_13)

				if var_160_15 > 0 and var_160_9 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play938042039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 938042039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play938042040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["128404"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps128404 == nil then
				arg_161_1.var_.actorSpriteComps128404 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps128404 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 1, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps128404 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps128404 = nil
			end

			local var_164_8 = arg_161_1.actors_["128404"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos128404 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("128404", 3)

				local var_164_10 = var_164_8.childCount

				for iter_164_4 = 0, var_164_10 - 1 do
					local var_164_11 = var_164_8:GetChild(iter_164_4)

					if var_164_11.name == "split_5" then
						var_164_11:SetAsLastSibling()
						var_164_11.gameObject:SetActive(true)

						arg_161_1.var_.actorSpriteSplit128404 = var_164_11.gameObject:GetComponent(typeof(Image))

						arg_161_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_164_12 = 0.5

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_9) / var_164_12
				local var_164_14 = Vector3.New(-16.1, -362, -375)

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos128404, var_164_14, var_164_13)

				if arg_161_1.var_.actorSpriteSplit128404 ~= nil then
					arg_161_1.var_.actorSpriteSplit128404:SetAlpha(var_164_13)
				end
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_161_1.var_.actorSpriteSplit128404 ~= nil then
					arg_161_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_164_15 = 0
			local var_164_16 = 0.425

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(938042039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 17
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_23 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_23 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_23

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_23 and arg_161_1.time_ < var_164_15 + var_164_23 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play938042040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 938042040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play938042041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["128404"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps128404 == nil then
				arg_165_1.var_.actorSpriteComps128404 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps128404 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 0.5, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps128404 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps128404 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.325

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_10 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_11 = arg_165_1:GetWordFromCfg(938042040)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 13
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_9 or var_168_9 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_9 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play938042041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 938042041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play938042042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["128404"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps128404 == nil then
				arg_169_1.var_.actorSpriteComps128404 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps128404 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 1, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps128404 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps128404 = nil
			end

			local var_172_8 = arg_169_1.actors_["128404"].transform
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.var_.moveOldPos128404 = var_172_8.localPosition
				var_172_8.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("128404", 3)

				local var_172_10 = var_172_8.childCount

				for iter_172_4 = 0, var_172_10 - 1 do
					local var_172_11 = var_172_8:GetChild(iter_172_4)

					if var_172_11.name == "split_3" then
						var_172_11:SetAsLastSibling()
						var_172_11.gameObject:SetActive(true)

						arg_169_1.var_.actorSpriteSplit128404 = var_172_11.gameObject:GetComponent(typeof(Image))

						arg_169_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_172_12 = 0.5

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_9) / var_172_12
				local var_172_14 = Vector3.New(-16.1, -362, -375)

				var_172_8.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos128404, var_172_14, var_172_13)

				if arg_169_1.var_.actorSpriteSplit128404 ~= nil then
					arg_169_1.var_.actorSpriteSplit128404:SetAlpha(var_172_13)
				end
			end

			if arg_169_1.time_ >= var_172_9 + var_172_12 and arg_169_1.time_ < var_172_9 + var_172_12 + arg_172_0 then
				var_172_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_169_1.var_.actorSpriteSplit128404 ~= nil then
					arg_169_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_172_15 = 0
			local var_172_16 = 0.5

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[6].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(938042041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 20
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_23 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_23 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_23

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_23 and arg_169_1.time_ < var_172_15 + var_172_23 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play938042042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 938042042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play938042043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["128404"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 0.5, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.125

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_10 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_11 = arg_173_1:GetWordFromCfg(938042042)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 5
				local var_176_14 = utf8.len(var_176_12)
				local var_176_15 = var_176_13 <= 0 and var_176_9 or var_176_9 * (var_176_14 / var_176_13)

				if var_176_15 > 0 and var_176_9 < var_176_15 then
					arg_173_1.talkMaxDuration = var_176_15

					if var_176_15 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play938042043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 938042043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play938042044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["128404"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps128404 == nil then
				arg_177_1.var_.actorSpriteComps128404 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps128404 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps128404 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps128404 = nil
			end

			local var_180_8 = arg_177_1.actors_["128404"].transform
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_8.localPosition
				var_180_8.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 3)

				local var_180_10 = var_180_8.childCount

				for iter_180_4 = 0, var_180_10 - 1 do
					local var_180_11 = var_180_8:GetChild(iter_180_4)

					if var_180_11.name == "split_4" then
						var_180_11:SetAsLastSibling()
						var_180_11.gameObject:SetActive(true)

						arg_177_1.var_.actorSpriteSplit128404 = var_180_11.gameObject:GetComponent(typeof(Image))

						arg_177_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_180_12 = 0.5

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_12 then
				local var_180_13 = (arg_177_1.time_ - var_180_9) / var_180_12
				local var_180_14 = Vector3.New(-16.1, -362, -375)

				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, var_180_14, var_180_13)

				if arg_177_1.var_.actorSpriteSplit128404 ~= nil then
					arg_177_1.var_.actorSpriteSplit128404:SetAlpha(var_180_13)
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_12 and arg_177_1.time_ < var_180_9 + var_180_12 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_177_1.var_.actorSpriteSplit128404 ~= nil then
					arg_177_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_180_15 = 0
			local var_180_16 = 0.525

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(938042043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 21
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
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_23 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_23 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_23

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_23 and arg_177_1.time_ < var_180_15 + var_180_23 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play938042044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 938042044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play938042045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["128404"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps128404 == nil then
				arg_181_1.var_.actorSpriteComps128404 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps128404 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps128404 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps128404 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 0.325

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_10 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_11 = arg_181_1:GetWordFromCfg(938042044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 13
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_9 or var_184_9 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_9 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play938042045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 938042045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play938042046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["128404"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps128404 == nil then
				arg_185_1.var_.actorSpriteComps128404 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps128404 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps128404 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps128404 = nil
			end

			local var_188_8 = arg_185_1.actors_["128404"].transform
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.var_.moveOldPos128404 = var_188_8.localPosition
				var_188_8.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("128404", 3)

				local var_188_10 = var_188_8.childCount

				for iter_188_4 = 0, var_188_10 - 1 do
					local var_188_11 = var_188_8:GetChild(iter_188_4)

					if var_188_11.name == "split_6" then
						var_188_11:SetAsLastSibling()
						var_188_11.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit128404 = var_188_11.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_188_12 = 0.5

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_12 then
				local var_188_13 = (arg_185_1.time_ - var_188_9) / var_188_12
				local var_188_14 = Vector3.New(-16.1, -362, -375)

				var_188_8.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos128404, var_188_14, var_188_13)

				if arg_185_1.var_.actorSpriteSplit128404 ~= nil then
					arg_185_1.var_.actorSpriteSplit128404:SetAlpha(var_188_13)
				end
			end

			if arg_185_1.time_ >= var_188_9 + var_188_12 and arg_185_1.time_ < var_188_9 + var_188_12 + arg_188_0 then
				var_188_8.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_185_1.var_.actorSpriteSplit128404 ~= nil then
					arg_185_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_188_15 = 0
			local var_188_16 = 0.2

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(938042045)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 8
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_23 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_23 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_23

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_23 and arg_185_1.time_ < var_188_15 + var_188_23 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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

		arg_185_1:InitPlayNodeList()
	end,
	Play938042046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 938042046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play938042047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["128404"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps128404 == nil then
				arg_189_1.var_.actorSpriteComps128404 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps128404 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps128404 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps128404 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.65

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_10 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_11 = arg_189_1:GetWordFromCfg(938042046)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 26
				local var_192_14 = utf8.len(var_192_12)
				local var_192_15 = var_192_13 <= 0 and var_192_9 or var_192_9 * (var_192_14 / var_192_13)

				if var_192_15 > 0 and var_192_9 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play938042047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 938042047
		arg_193_1.duration_ = 7.53

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play938042048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "H02b"

			if arg_193_1.bgs_[var_196_0] == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			local var_196_2 = 1

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				local var_196_3 = manager.ui.mainCamera.transform.localPosition
				local var_196_4 = Vector3.New(0, 0, 10) + Vector3.New(var_196_3.x, var_196_3.y, 0)
				local var_196_5 = arg_193_1.bgs_.H02b

				var_196_5.transform.localPosition = var_196_4
				var_196_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_6 = var_196_5:GetComponent("SpriteRenderer")

				if var_196_6 and var_196_6.sprite then
					local var_196_7 = (var_196_5.transform.localPosition - var_196_3).z
					local var_196_8 = manager.ui.mainCameraCom_
					local var_196_9 = 2 * var_196_7 * Mathf.Tan(var_196_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_10 = var_196_9 * var_196_8.aspect
					local var_196_11 = var_196_6.sprite.bounds.size.x
					local var_196_12 = var_196_6.sprite.bounds.size.y
					local var_196_13 = var_196_10 / var_196_11
					local var_196_14 = var_196_9 / var_196_12
					local var_196_15 = var_196_14 < var_196_13 and var_196_13 or var_196_14

					var_196_5.transform.localScale = Vector3.New(var_196_15, var_196_15, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "H02b" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_16 = 0.7

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_17 = 0.3

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_18 = manager.ui.mainCamera.transform
			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				local var_196_20 = arg_193_1.var_.effectquwanghaitan1
				local var_196_21
				local var_196_22 = var_196_18

				if not var_196_20 then
					var_196_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), var_196_22)
					var_196_20.name = "quwanghaitan1"
					arg_193_1.var_.effectquwanghaitan1 = var_196_20
				else
					var_196_20.transform:SetParent(var_196_22)
				end

				var_196_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_196_23 = arg_193_1.actors_["128404"].transform
			local var_196_24 = 0.7

			if var_196_24 < arg_193_1.time_ and arg_193_1.time_ <= var_196_24 + arg_196_0 then
				arg_193_1.var_.moveOldPos128404 = var_196_23.localPosition
				var_196_23.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("128404", 7)

				local var_196_25 = var_196_23.childCount

				for iter_196_2 = 0, var_196_25 - 1 do
					local var_196_26 = var_196_23:GetChild(iter_196_2)

					if var_196_26.name == "" or not string.find(var_196_26.name, "split") then
						var_196_26.gameObject:SetActive(true)
					else
						var_196_26.gameObject:SetActive(false)
					end
				end
			end

			local var_196_27 = 0.001

			if var_196_24 <= arg_193_1.time_ and arg_193_1.time_ < var_196_24 + var_196_27 then
				local var_196_28 = (arg_193_1.time_ - var_196_24) / var_196_27
				local var_196_29 = Vector3.New(0, -2000, 0)

				var_196_23.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos128404, var_196_29, var_196_28)
			end

			if arg_193_1.time_ >= var_196_24 + var_196_27 and arg_193_1.time_ < var_196_24 + var_196_27 + arg_196_0 then
				var_196_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_30 = 1
			local var_196_31 = 1

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				local var_196_32 = "play"
				local var_196_33 = "effect"

				arg_193_1:AudioAction(var_196_32, var_196_33, "se_story_133", "se_story_133_sea", "")
			end

			local var_196_34 = 0.3
			local var_196_35 = 1

			if var_196_34 < arg_193_1.time_ and arg_193_1.time_ <= var_196_34 + arg_196_0 then
				local var_196_36 = "stop"
				local var_196_37 = "effect"

				arg_193_1:AudioAction(var_196_36, var_196_37, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_196_38 = 0

			if var_196_38 < arg_193_1.time_ and arg_193_1.time_ <= var_196_38 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_39 = 2.53333333333333

			if arg_193_1.time_ >= var_196_38 + var_196_39 and arg_193_1.time_ < var_196_38 + var_196_39 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_40 = 2.53333333333333
			local var_196_41 = 1.125

			if var_196_40 < arg_193_1.time_ and arg_193_1.time_ <= var_196_40 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_42 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_42:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_43 = arg_193_1:GetWordFromCfg(938042047)
				local var_196_44 = arg_193_1:FormatText(var_196_43.content)

				arg_193_1.text_.text = var_196_44

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_45 = 45
				local var_196_46 = utf8.len(var_196_44)
				local var_196_47 = var_196_45 <= 0 and var_196_41 or var_196_41 * (var_196_46 / var_196_45)

				if var_196_47 > 0 and var_196_41 < var_196_47 then
					arg_193_1.talkMaxDuration = var_196_47
					var_196_40 = var_196_40 + 0.3

					if var_196_47 + var_196_40 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_47 + var_196_40
					end
				end

				arg_193_1.text_.text = var_196_44
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_48 = var_196_40 + 0.3
			local var_196_49 = math.max(var_196_41, arg_193_1.talkMaxDuration)

			if var_196_48 <= arg_193_1.time_ and arg_193_1.time_ < var_196_48 + var_196_49 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_48) / var_196_49

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_48 + var_196_49 and arg_193_1.time_ < var_196_48 + var_196_49 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play938042048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 938042048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play938042049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.175

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(938042048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 7
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play938042049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 938042049
		arg_203_1.duration_ = 5.28

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play938042050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10183"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10183 == nil then
				arg_203_1.var_.actorSpriteComps10183 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10183 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 1, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10183 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10183 = nil
			end

			local var_206_8 = arg_203_1.actors_["10183"].transform
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.var_.moveOldPos10183 = var_206_8.localPosition
				var_206_8.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10183", 3)

				local var_206_10 = var_206_8.childCount

				for iter_206_4 = 0, var_206_10 - 1 do
					local var_206_11 = var_206_8:GetChild(iter_206_4)

					if var_206_11.name == "" or not string.find(var_206_11.name, "split") then
						var_206_11.gameObject:SetActive(true)
					else
						var_206_11.gameObject:SetActive(false)
					end
				end
			end

			local var_206_12 = 0.001

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_9) / var_206_12
				local var_206_14 = Vector3.New(0, -475, -325)

				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10183, var_206_14, var_206_13)
			end

			if arg_203_1.time_ >= var_206_9 + var_206_12 and arg_203_1.time_ < var_206_9 + var_206_12 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_206_15 = arg_203_1.actors_["10183"]
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				local var_206_17 = var_206_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_206_17 then
					arg_203_1.var_.alphaOldValue10183 = var_206_17.alpha
					arg_203_1.var_.characterEffect10183 = var_206_17
				end

				arg_203_1.var_.alphaOldValue10183 = 0
			end

			local var_206_18 = 0.5

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_18 then
				local var_206_19 = (arg_203_1.time_ - var_206_16) / var_206_18
				local var_206_20 = Mathf.Lerp(arg_203_1.var_.alphaOldValue10183, 1, var_206_19)

				if arg_203_1.var_.characterEffect10183 then
					arg_203_1.var_.characterEffect10183.alpha = var_206_20
				end
			end

			if arg_203_1.time_ >= var_206_16 + var_206_18 and arg_203_1.time_ < var_206_16 + var_206_18 + arg_206_0 and arg_203_1.var_.characterEffect10183 then
				arg_203_1.var_.characterEffect10183.alpha = 1
			end

			local var_206_21 = 0

			if var_206_21 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_22 = 0.5

			if arg_203_1.time_ >= var_206_21 + var_206_22 and arg_203_1.time_ < var_206_21 + var_206_22 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_23 = 0.275
			local var_206_24 = 0.225

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_25 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_25:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_26 = arg_203_1:FormatText(StoryNameCfg[36].name)

				arg_203_1.leftNameTxt_.text = var_206_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_27 = arg_203_1:GetWordFromCfg(938042049)
				local var_206_28 = arg_203_1:FormatText(var_206_27.content)

				arg_203_1.text_.text = var_206_28

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_29 = 9
				local var_206_30 = utf8.len(var_206_28)
				local var_206_31 = var_206_29 <= 0 and var_206_24 or var_206_24 * (var_206_30 / var_206_29)

				if var_206_31 > 0 and var_206_24 < var_206_31 then
					arg_203_1.talkMaxDuration = var_206_31
					var_206_23 = var_206_23 + 0.3

					if var_206_31 + var_206_23 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_31 + var_206_23
					end
				end

				arg_203_1.text_.text = var_206_28
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_32 = var_206_23 + 0.3
			local var_206_33 = math.max(var_206_24, arg_203_1.talkMaxDuration)

			if var_206_32 <= arg_203_1.time_ and arg_203_1.time_ < var_206_32 + var_206_33 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_32) / var_206_33

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_32 + var_206_33 and arg_203_1.time_ < var_206_32 + var_206_33 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play938042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 938042050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play938042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10183"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10183 == nil then
				arg_209_1.var_.actorSpriteComps10183 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10183 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 0.5, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10183 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10183 = nil
			end

			local var_212_8 = arg_209_1.actors_["10183"].transform
			local var_212_9 = 0.5

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.var_.moveOldPos10183 = var_212_8.localPosition
				var_212_8.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10183", 7)

				local var_212_10 = var_212_8.childCount

				for iter_212_4 = 0, var_212_10 - 1 do
					local var_212_11 = var_212_8:GetChild(iter_212_4)

					if var_212_11.name == "" or not string.find(var_212_11.name, "split") then
						var_212_11.gameObject:SetActive(true)
					else
						var_212_11.gameObject:SetActive(false)
					end
				end
			end

			local var_212_12 = 0.001

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_9) / var_212_12
				local var_212_14 = Vector3.New(0, -2000, 0)

				var_212_8.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10183, var_212_14, var_212_13)
			end

			if arg_209_1.time_ >= var_212_9 + var_212_12 and arg_209_1.time_ < var_212_9 + var_212_12 + arg_212_0 then
				var_212_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_15 = arg_209_1.actors_["10183"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				local var_212_17 = var_212_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_17 then
					arg_209_1.var_.alphaOldValue10183 = var_212_17.alpha
					arg_209_1.var_.characterEffect10183 = var_212_17
				end

				arg_209_1.var_.alphaOldValue10183 = 1
			end

			local var_212_18 = 0.5

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_18 then
				local var_212_19 = (arg_209_1.time_ - var_212_16) / var_212_18
				local var_212_20 = Mathf.Lerp(arg_209_1.var_.alphaOldValue10183, 0, var_212_19)

				if arg_209_1.var_.characterEffect10183 then
					arg_209_1.var_.characterEffect10183.alpha = var_212_20
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_18 and arg_209_1.time_ < var_212_16 + var_212_18 + arg_212_0 and arg_209_1.var_.characterEffect10183 then
				arg_209_1.var_.characterEffect10183.alpha = 0
			end

			local var_212_21 = arg_209_1.actors_["10183"]
			local var_212_22 = 0.5

			if var_212_22 < arg_209_1.time_ and arg_209_1.time_ <= var_212_22 + arg_212_0 then
				local var_212_23 = var_212_21:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_23 then
					arg_209_1.var_.alphaOldValue10183 = var_212_23.alpha
					arg_209_1.var_.characterEffect10183 = var_212_23
				end

				arg_209_1.var_.alphaOldValue10183 = 0
			end

			local var_212_24 = 0.034

			if var_212_22 <= arg_209_1.time_ and arg_209_1.time_ < var_212_22 + var_212_24 then
				local var_212_25 = (arg_209_1.time_ - var_212_22) / var_212_24
				local var_212_26 = Mathf.Lerp(arg_209_1.var_.alphaOldValue10183, 1, var_212_25)

				if arg_209_1.var_.characterEffect10183 then
					arg_209_1.var_.characterEffect10183.alpha = var_212_26
				end
			end

			if arg_209_1.time_ >= var_212_22 + var_212_24 and arg_209_1.time_ < var_212_22 + var_212_24 + arg_212_0 and arg_209_1.var_.characterEffect10183 then
				arg_209_1.var_.characterEffect10183.alpha = 1
			end

			local var_212_27 = 0
			local var_212_28 = 1.55

			if var_212_27 < arg_209_1.time_ and arg_209_1.time_ <= var_212_27 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_29 = arg_209_1:GetWordFromCfg(938042050)
				local var_212_30 = arg_209_1:FormatText(var_212_29.content)

				arg_209_1.text_.text = var_212_30

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_31 = 62
				local var_212_32 = utf8.len(var_212_30)
				local var_212_33 = var_212_31 <= 0 and var_212_28 or var_212_28 * (var_212_32 / var_212_31)

				if var_212_33 > 0 and var_212_28 < var_212_33 then
					arg_209_1.talkMaxDuration = var_212_33

					if var_212_33 + var_212_27 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_33 + var_212_27
					end
				end

				arg_209_1.text_.text = var_212_30
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_34 = math.max(var_212_28, arg_209_1.talkMaxDuration)

			if var_212_27 <= arg_209_1.time_ and arg_209_1.time_ < var_212_27 + var_212_34 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_27) / var_212_34

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_27 + var_212_34 and arg_209_1.time_ < var_212_27 + var_212_34 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play938042051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 938042051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play938042052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10183"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10183 == nil then
				arg_213_1.var_.actorSpriteComps10183 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10183 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10183 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10183 = nil
			end

			local var_216_8 = arg_213_1.actors_["10183"].transform
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.var_.moveOldPos10183 = var_216_8.localPosition
				var_216_8.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10183", 3)

				local var_216_10 = var_216_8.childCount

				for iter_216_4 = 0, var_216_10 - 1 do
					local var_216_11 = var_216_8:GetChild(iter_216_4)

					if var_216_11.name == "split_5" or not string.find(var_216_11.name, "split") then
						var_216_11.gameObject:SetActive(true)
					else
						var_216_11.gameObject:SetActive(false)
					end
				end
			end

			local var_216_12 = 0.001

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_12 then
				local var_216_13 = (arg_213_1.time_ - var_216_9) / var_216_12
				local var_216_14 = Vector3.New(0, -475, -325)

				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10183, var_216_14, var_216_13)
			end

			if arg_213_1.time_ >= var_216_9 + var_216_12 and arg_213_1.time_ < var_216_9 + var_216_12 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_216_15 = 0
			local var_216_16 = 0.625

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[1562].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(938042051)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 25
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_23 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_23 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_23

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_23 and arg_213_1.time_ < var_216_15 + var_216_23 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play938042052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 938042052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play938042053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10183"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10183 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10183", 3)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_7" then
						var_220_3:SetAsLastSibling()
						var_220_3.gameObject:SetActive(true)

						arg_217_1.var_.actorSpriteSplit10183 = var_220_3.gameObject:GetComponent(typeof(Image))

						arg_217_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_220_4 = 0.5

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(0, -475, -325)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10183, var_220_6, var_220_5)

				if arg_217_1.var_.actorSpriteSplit10183 ~= nil then
					arg_217_1.var_.actorSpriteSplit10183:SetAlpha(var_220_5)
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -475, -325)

				if arg_217_1.var_.actorSpriteSplit10183 ~= nil then
					arg_217_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_220_7 = 0
			local var_220_8 = 0.675

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_9 = arg_217_1:FormatText(StoryNameCfg[1562].name)

				arg_217_1.leftNameTxt_.text = var_220_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(938042052)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_12 = 27
				local var_220_13 = utf8.len(var_220_11)
				local var_220_14 = var_220_12 <= 0 and var_220_8 or var_220_8 * (var_220_13 / var_220_12)

				if var_220_14 > 0 and var_220_8 < var_220_14 then
					arg_217_1.talkMaxDuration = var_220_14

					if var_220_14 + var_220_7 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_7
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_15 = math.max(var_220_8, arg_217_1.talkMaxDuration)

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_15 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_7) / var_220_15

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_7 + var_220_15 and arg_217_1.time_ < var_220_7 + var_220_15 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play938042053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 938042053
		arg_221_1.duration_ = 1

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"

			SetActive(arg_221_1.choicesGo_, true)

			for iter_222_0, iter_222_1 in ipairs(arg_221_1.choices_) do
				local var_222_0 = iter_222_0 <= 2

				SetActive(iter_222_1.go, var_222_0)
			end

			arg_221_1.choices_[1].txt.text = arg_221_1:FormatText(StoryChoiceCfg[1788].name)
			arg_221_1.choices_[2].txt.text = arg_221_1:FormatText(StoryChoiceCfg[1789].name)
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play938042054(arg_221_1)
			end

			if arg_223_0 == 2 then
				arg_221_0:Play938042054(arg_221_1)
			end

			arg_221_1:RecordChoiceLog(938042053, 1788, 1789)
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10183"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10183 == nil then
				arg_221_1.var_.actorSpriteComps10183 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10183 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10183 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10183 = nil
			end

			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_9 = 1

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play938042054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 938042054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play938042055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10183"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10183 == nil then
				arg_225_1.var_.actorSpriteComps10183 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10183 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 1, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10183 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10183 = nil
			end

			local var_228_8 = arg_225_1.actors_["10183"].transform
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1.var_.moveOldPos10183 = var_228_8.localPosition
				var_228_8.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10183", 3)

				local var_228_10 = var_228_8.childCount

				for iter_228_4 = 0, var_228_10 - 1 do
					local var_228_11 = var_228_8:GetChild(iter_228_4)

					if var_228_11.name == "split_3" or not string.find(var_228_11.name, "split") then
						var_228_11.gameObject:SetActive(true)
					else
						var_228_11.gameObject:SetActive(false)
					end
				end
			end

			local var_228_12 = 0.001

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_9) / var_228_12
				local var_228_14 = Vector3.New(0, -475, -325)

				var_228_8.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10183, var_228_14, var_228_13)
			end

			if arg_225_1.time_ >= var_228_9 + var_228_12 and arg_225_1.time_ < var_228_9 + var_228_12 + arg_228_0 then
				var_228_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_228_15 = manager.ui.mainCamera.transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.shakeOldPos = var_228_15.localPosition
			end

			local var_228_17 = 0.4

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / 0.066
				local var_228_19, var_228_20 = math.modf(var_228_18)

				var_228_15.localPosition = Vector3.New(var_228_20 * 0.13, var_228_20 * 0.13, var_228_20 * 0.13) + arg_225_1.var_.shakeOldPos
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				var_228_15.localPosition = arg_225_1.var_.shakeOldPos
			end

			local var_228_21 = 0
			local var_228_22 = 0.65

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[1562].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(938042054)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 26
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_29 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_29 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_29

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_29 and arg_225_1.time_ < var_228_21 + var_228_29 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play938042055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 938042055
		arg_229_1.duration_ = 9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play938042056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 2

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				local var_232_1 = manager.ui.mainCamera.transform.localPosition
				local var_232_2 = Vector3.New(0, 0, 10) + Vector3.New(var_232_1.x, var_232_1.y, 0)
				local var_232_3 = arg_229_1.bgs_.H02b

				var_232_3.transform.localPosition = var_232_2
				var_232_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_4 = var_232_3:GetComponent("SpriteRenderer")

				if var_232_4 and var_232_4.sprite then
					local var_232_5 = (var_232_3.transform.localPosition - var_232_1).z
					local var_232_6 = manager.ui.mainCameraCom_
					local var_232_7 = 2 * var_232_5 * Mathf.Tan(var_232_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_8 = var_232_7 * var_232_6.aspect
					local var_232_9 = var_232_4.sprite.bounds.size.x
					local var_232_10 = var_232_4.sprite.bounds.size.y
					local var_232_11 = var_232_8 / var_232_9
					local var_232_12 = var_232_7 / var_232_10
					local var_232_13 = var_232_12 < var_232_11 and var_232_11 or var_232_12

					var_232_3.transform.localScale = Vector3.New(var_232_13, var_232_13, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "H02b" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_14 = 3.999999999999

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_15 = 0.3

			if arg_229_1.time_ >= var_232_14 + var_232_15 and arg_229_1.time_ < var_232_14 + var_232_15 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_17 = 2

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17
				local var_232_19 = Color.New(0, 0, 0)

				var_232_19.a = Mathf.Lerp(0, 1, var_232_18)
				arg_229_1.mask_.color = var_232_19
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				local var_232_20 = Color.New(0, 0, 0)

				var_232_20.a = 1
				arg_229_1.mask_.color = var_232_20
			end

			local var_232_21 = 2

			if var_232_21 < arg_229_1.time_ and arg_229_1.time_ <= var_232_21 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_22 = 2

			if var_232_21 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_22 then
				local var_232_23 = (arg_229_1.time_ - var_232_21) / var_232_22
				local var_232_24 = Color.New(0, 0, 0)

				var_232_24.a = Mathf.Lerp(1, 0, var_232_23)
				arg_229_1.mask_.color = var_232_24
			end

			if arg_229_1.time_ >= var_232_21 + var_232_22 and arg_229_1.time_ < var_232_21 + var_232_22 + arg_232_0 then
				local var_232_25 = Color.New(0, 0, 0)
				local var_232_26 = 0

				arg_229_1.mask_.enabled = false
				var_232_25.a = var_232_26
				arg_229_1.mask_.color = var_232_25
			end

			local var_232_27 = arg_229_1.actors_["10183"]
			local var_232_28 = 1.966

			if var_232_28 < arg_229_1.time_ and arg_229_1.time_ <= var_232_28 + arg_232_0 and not isNil(var_232_27) and arg_229_1.var_.actorSpriteComps10183 == nil then
				arg_229_1.var_.actorSpriteComps10183 = var_232_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_29 = 0.034

			if var_232_28 <= arg_229_1.time_ and arg_229_1.time_ < var_232_28 + var_232_29 and not isNil(var_232_27) then
				local var_232_30 = (arg_229_1.time_ - var_232_28) / var_232_29

				if arg_229_1.var_.actorSpriteComps10183 then
					for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_232_3 then
							if arg_229_1.isInRecall_ then
								local var_232_31 = Mathf.Lerp(iter_232_3.color.r, arg_229_1.hightColor2.r, var_232_30)
								local var_232_32 = Mathf.Lerp(iter_232_3.color.g, arg_229_1.hightColor2.g, var_232_30)
								local var_232_33 = Mathf.Lerp(iter_232_3.color.b, arg_229_1.hightColor2.b, var_232_30)

								iter_232_3.color = Color.New(var_232_31, var_232_32, var_232_33)
							else
								local var_232_34 = Mathf.Lerp(iter_232_3.color.r, 0.5, var_232_30)

								iter_232_3.color = Color.New(var_232_34, var_232_34, var_232_34)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_28 + var_232_29 and arg_229_1.time_ < var_232_28 + var_232_29 + arg_232_0 and not isNil(var_232_27) and arg_229_1.var_.actorSpriteComps10183 then
				for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_232_5 then
						if arg_229_1.isInRecall_ then
							iter_232_5.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10183 = nil
			end

			local var_232_35 = arg_229_1.actors_["10183"].transform
			local var_232_36 = 1.966

			if var_232_36 < arg_229_1.time_ and arg_229_1.time_ <= var_232_36 + arg_232_0 then
				arg_229_1.var_.moveOldPos10183 = var_232_35.localPosition
				var_232_35.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10183", 7)

				local var_232_37 = var_232_35.childCount

				for iter_232_6 = 0, var_232_37 - 1 do
					local var_232_38 = var_232_35:GetChild(iter_232_6)

					if var_232_38.name == "" or not string.find(var_232_38.name, "split") then
						var_232_38.gameObject:SetActive(true)
					else
						var_232_38.gameObject:SetActive(false)
					end
				end
			end

			local var_232_39 = 0.001

			if var_232_36 <= arg_229_1.time_ and arg_229_1.time_ < var_232_36 + var_232_39 then
				local var_232_40 = (arg_229_1.time_ - var_232_36) / var_232_39
				local var_232_41 = Vector3.New(0, -2000, 0)

				var_232_35.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10183, var_232_41, var_232_40)
			end

			if arg_229_1.time_ >= var_232_36 + var_232_39 and arg_229_1.time_ < var_232_36 + var_232_39 + arg_232_0 then
				var_232_35.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_42 = 4
			local var_232_43 = 0.35

			if var_232_42 < arg_229_1.time_ and arg_229_1.time_ <= var_232_42 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_44 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_44:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_45 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_46 = arg_229_1:GetWordFromCfg(938042055)
				local var_232_47 = arg_229_1:FormatText(var_232_46.content)

				arg_229_1.text_.text = var_232_47

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_48 = 14
				local var_232_49 = utf8.len(var_232_47)
				local var_232_50 = var_232_48 <= 0 and var_232_43 or var_232_43 * (var_232_49 / var_232_48)

				if var_232_50 > 0 and var_232_43 < var_232_50 then
					arg_229_1.talkMaxDuration = var_232_50
					var_232_42 = var_232_42 + 0.3

					if var_232_50 + var_232_42 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_50 + var_232_42
					end
				end

				arg_229_1.text_.text = var_232_47
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_51 = var_232_42 + 0.3
			local var_232_52 = math.max(var_232_43, arg_229_1.talkMaxDuration)

			if var_232_51 <= arg_229_1.time_ and arg_229_1.time_ < var_232_51 + var_232_52 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_51) / var_232_52

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_51 + var_232_52 and arg_229_1.time_ < var_232_51 + var_232_52 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play938042056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 938042056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play938042057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10183"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10183 == nil then
				arg_235_1.var_.actorSpriteComps10183 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10183 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 1, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10183 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10183 = nil
			end

			local var_238_8 = arg_235_1.actors_["10183"].transform
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.var_.moveOldPos10183 = var_238_8.localPosition
				var_238_8.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10183", 3)

				local var_238_10 = var_238_8.childCount

				for iter_238_4 = 0, var_238_10 - 1 do
					local var_238_11 = var_238_8:GetChild(iter_238_4)

					if var_238_11.name == "" or not string.find(var_238_11.name, "split") then
						var_238_11.gameObject:SetActive(true)
					else
						var_238_11.gameObject:SetActive(false)
					end
				end
			end

			local var_238_12 = 0.001

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_12 then
				local var_238_13 = (arg_235_1.time_ - var_238_9) / var_238_12
				local var_238_14 = Vector3.New(0, -475, -325)

				var_238_8.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10183, var_238_14, var_238_13)
			end

			if arg_235_1.time_ >= var_238_9 + var_238_12 and arg_235_1.time_ < var_238_9 + var_238_12 + arg_238_0 then
				var_238_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_238_15 = 0
			local var_238_16 = 0.125

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_17 = arg_235_1:FormatText(StoryNameCfg[1562].name)

				arg_235_1.leftNameTxt_.text = var_238_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_18 = arg_235_1:GetWordFromCfg(938042056)
				local var_238_19 = arg_235_1:FormatText(var_238_18.content)

				arg_235_1.text_.text = var_238_19

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_20 = 5
				local var_238_21 = utf8.len(var_238_19)
				local var_238_22 = var_238_20 <= 0 and var_238_16 or var_238_16 * (var_238_21 / var_238_20)

				if var_238_22 > 0 and var_238_16 < var_238_22 then
					arg_235_1.talkMaxDuration = var_238_22

					if var_238_22 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_22 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_19
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_23 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_23 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_23

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_23 and arg_235_1.time_ < var_238_15 + var_238_23 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play938042057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 938042057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play938042058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10183"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps10183 == nil then
				arg_239_1.var_.actorSpriteComps10183 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps10183 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 0.5, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps10183 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10183 = nil
			end

			local var_242_8 = 0
			local var_242_9 = 0.725

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_10 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_11 = arg_239_1:GetWordFromCfg(938042057)
				local var_242_12 = arg_239_1:FormatText(var_242_11.content)

				arg_239_1.text_.text = var_242_12

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 29
				local var_242_14 = utf8.len(var_242_12)
				local var_242_15 = var_242_13 <= 0 and var_242_9 or var_242_9 * (var_242_14 / var_242_13)

				if var_242_15 > 0 and var_242_9 < var_242_15 then
					arg_239_1.talkMaxDuration = var_242_15

					if var_242_15 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_15 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_12
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_16 and arg_239_1.time_ < var_242_8 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play938042058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 938042058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play938042059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10183"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10183 == nil then
				arg_243_1.var_.actorSpriteComps10183 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10183 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 1, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10183 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10183 = nil
			end

			local var_246_8 = arg_243_1.actors_["10183"].transform
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.var_.moveOldPos10183 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10183", 3)

				local var_246_10 = var_246_8.childCount

				for iter_246_4 = 0, var_246_10 - 1 do
					local var_246_11 = var_246_8:GetChild(iter_246_4)

					if var_246_11.name == "split_4" or not string.find(var_246_11.name, "split") then
						var_246_11.gameObject:SetActive(true)
					else
						var_246_11.gameObject:SetActive(false)
					end
				end
			end

			local var_246_12 = 0.001

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_9) / var_246_12
				local var_246_14 = Vector3.New(0, -475, -325)

				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10183, var_246_14, var_246_13)
			end

			if arg_243_1.time_ >= var_246_9 + var_246_12 and arg_243_1.time_ < var_246_9 + var_246_12 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_246_15 = 0
			local var_246_16 = 0.2

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[1562].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(938042058)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 8
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_23 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_23 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_23

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_23 and arg_243_1.time_ < var_246_15 + var_246_23 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play938042059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 938042059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play938042060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10183"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10183 == nil then
				arg_247_1.var_.actorSpriteComps10183 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10183 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10183 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10183 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.1

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_10 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_11 = arg_247_1:GetWordFromCfg(938042059)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 4
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
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play938042060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 938042060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play938042061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10183"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10183 == nil then
				arg_251_1.var_.actorSpriteComps10183 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10183 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 1, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10183 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10183 = nil
			end

			local var_254_8 = arg_251_1.actors_["10183"].transform
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				arg_251_1.var_.moveOldPos10183 = var_254_8.localPosition
				var_254_8.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10183", 3)

				local var_254_10 = var_254_8.childCount

				for iter_254_4 = 0, var_254_10 - 1 do
					local var_254_11 = var_254_8:GetChild(iter_254_4)

					if var_254_11.name == "" then
						var_254_11:SetAsLastSibling()
						var_254_11.gameObject:SetActive(true)

						arg_251_1.var_.actorSpriteSplit10183 = var_254_11.gameObject:GetComponent(typeof(Image))

						arg_251_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_254_12 = 0.5

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_12 then
				local var_254_13 = (arg_251_1.time_ - var_254_9) / var_254_12
				local var_254_14 = Vector3.New(0, -475, -325)

				var_254_8.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10183, var_254_14, var_254_13)

				if arg_251_1.var_.actorSpriteSplit10183 ~= nil then
					arg_251_1.var_.actorSpriteSplit10183:SetAlpha(var_254_13)
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_12 and arg_251_1.time_ < var_254_9 + var_254_12 + arg_254_0 then
				var_254_8.localPosition = Vector3.New(0, -475, -325)

				if arg_251_1.var_.actorSpriteSplit10183 ~= nil then
					arg_251_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_254_15 = 0
			local var_254_16 = 0.225

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[1562].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(938042060)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 9
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_16 or var_254_16 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_16 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_23 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_23 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_23

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_23 and arg_251_1.time_ < var_254_15 + var_254_23 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play938042061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 938042061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play938042062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10183"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10183 == nil then
				arg_255_1.var_.actorSpriteComps10183 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10183 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 0.5, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10183 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10183 = nil
			end

			local var_258_8 = 0
			local var_258_9 = 0.175

			if var_258_8 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_10 = arg_255_1:FormatText(StoryNameCfg[7].name)

				arg_255_1.leftNameTxt_.text = var_258_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_11 = arg_255_1:GetWordFromCfg(938042061)
				local var_258_12 = arg_255_1:FormatText(var_258_11.content)

				arg_255_1.text_.text = var_258_12

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 7
				local var_258_14 = utf8.len(var_258_12)
				local var_258_15 = var_258_13 <= 0 and var_258_9 or var_258_9 * (var_258_14 / var_258_13)

				if var_258_15 > 0 and var_258_9 < var_258_15 then
					arg_255_1.talkMaxDuration = var_258_15

					if var_258_15 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_15 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_12
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play938042062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 938042062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play938042063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10183"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10183 == nil then
				arg_259_1.var_.actorSpriteComps10183 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10183 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 1, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10183 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10183 = nil
			end

			local var_262_8 = arg_259_1.actors_["10183"].transform
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1.var_.moveOldPos10183 = var_262_8.localPosition
				var_262_8.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10183", 3)

				local var_262_10 = var_262_8.childCount

				for iter_262_4 = 0, var_262_10 - 1 do
					local var_262_11 = var_262_8:GetChild(iter_262_4)

					if var_262_11.name == "split_3" then
						var_262_11:SetAsLastSibling()
						var_262_11.gameObject:SetActive(true)

						arg_259_1.var_.actorSpriteSplit10183 = var_262_11.gameObject:GetComponent(typeof(Image))

						arg_259_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_262_12 = 0.5

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_12 then
				local var_262_13 = (arg_259_1.time_ - var_262_9) / var_262_12
				local var_262_14 = Vector3.New(0, -475, -325)

				var_262_8.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10183, var_262_14, var_262_13)

				if arg_259_1.var_.actorSpriteSplit10183 ~= nil then
					arg_259_1.var_.actorSpriteSplit10183:SetAlpha(var_262_13)
				end
			end

			if arg_259_1.time_ >= var_262_9 + var_262_12 and arg_259_1.time_ < var_262_9 + var_262_12 + arg_262_0 then
				var_262_8.localPosition = Vector3.New(0, -475, -325)

				if arg_259_1.var_.actorSpriteSplit10183 ~= nil then
					arg_259_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_262_15 = 0
			local var_262_16 = 1

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[1562].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(938042062)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 40
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_23 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_23 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_23

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_23 and arg_259_1.time_ < var_262_15 + var_262_23 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play938042063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 938042063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play938042064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10183"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10183 == nil then
				arg_263_1.var_.actorSpriteComps10183 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10183 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 0.5, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10183 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10183 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 0.2

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_10 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_11 = arg_263_1:GetWordFromCfg(938042063)
				local var_266_12 = arg_263_1:FormatText(var_266_11.content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 8
				local var_266_14 = utf8.len(var_266_12)
				local var_266_15 = var_266_13 <= 0 and var_266_9 or var_266_9 * (var_266_14 / var_266_13)

				if var_266_15 > 0 and var_266_9 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_16 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_16 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_16

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_16 and arg_263_1.time_ < var_266_8 + var_266_16 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play938042064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 938042064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play938042065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10183"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10183 == nil then
				arg_267_1.var_.actorSpriteComps10183 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10183 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10183 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10183 = nil
			end

			local var_270_8 = arg_267_1.actors_["10183"].transform
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.var_.moveOldPos10183 = var_270_8.localPosition
				var_270_8.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10183", 3)

				local var_270_10 = var_270_8.childCount

				for iter_270_4 = 0, var_270_10 - 1 do
					local var_270_11 = var_270_8:GetChild(iter_270_4)

					if var_270_11.name == "" then
						var_270_11:SetAsLastSibling()
						var_270_11.gameObject:SetActive(true)

						arg_267_1.var_.actorSpriteSplit10183 = var_270_11.gameObject:GetComponent(typeof(Image))

						arg_267_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_270_12 = 0.5

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_9) / var_270_12
				local var_270_14 = Vector3.New(0, -475, -325)

				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10183, var_270_14, var_270_13)

				if arg_267_1.var_.actorSpriteSplit10183 ~= nil then
					arg_267_1.var_.actorSpriteSplit10183:SetAlpha(var_270_13)
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_12 and arg_267_1.time_ < var_270_9 + var_270_12 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(0, -475, -325)

				if arg_267_1.var_.actorSpriteSplit10183 ~= nil then
					arg_267_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_270_15 = 0
			local var_270_16 = 0.4

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_17 = arg_267_1:FormatText(StoryNameCfg[1562].name)

				arg_267_1.leftNameTxt_.text = var_270_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:GetWordFromCfg(938042064)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 16
				local var_270_21 = utf8.len(var_270_19)
				local var_270_22 = var_270_20 <= 0 and var_270_16 or var_270_16 * (var_270_21 / var_270_20)

				if var_270_22 > 0 and var_270_16 < var_270_22 then
					arg_267_1.talkMaxDuration = var_270_22

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_23 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_23 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_23

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_23 and arg_267_1.time_ < var_270_15 + var_270_23 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play938042065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 938042065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play938042066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10183"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10183 == nil then
				arg_271_1.var_.actorSpriteComps10183 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10183 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10183 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10183 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 0.25

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_10 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_11 = arg_271_1:GetWordFromCfg(938042065)
				local var_274_12 = arg_271_1:FormatText(var_274_11.content)

				arg_271_1.text_.text = var_274_12

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 10
				local var_274_14 = utf8.len(var_274_12)
				local var_274_15 = var_274_13 <= 0 and var_274_9 or var_274_9 * (var_274_14 / var_274_13)

				if var_274_15 > 0 and var_274_9 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_12
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play938042066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 938042066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play938042067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10183"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos10183 = var_278_0.localPosition
				var_278_0.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10183", 7)

				local var_278_2 = var_278_0.childCount

				for iter_278_0 = 0, var_278_2 - 1 do
					local var_278_3 = var_278_0:GetChild(iter_278_0)

					if var_278_3.name == "" or not string.find(var_278_3.name, "split") then
						var_278_3.gameObject:SetActive(true)
					else
						var_278_3.gameObject:SetActive(false)
					end
				end
			end

			local var_278_4 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_4 then
				local var_278_5 = (arg_275_1.time_ - var_278_1) / var_278_4
				local var_278_6 = Vector3.New(0, -2000, 0)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10183, var_278_6, var_278_5)
			end

			if arg_275_1.time_ >= var_278_1 + var_278_4 and arg_275_1.time_ < var_278_1 + var_278_4 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_278_7 = 0
			local var_278_8 = 1.025

			if var_278_7 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_9 = arg_275_1:GetWordFromCfg(938042066)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 41
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_8 or var_278_8 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_8 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_7 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_7
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_8, arg_275_1.talkMaxDuration)

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_7) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_7 + var_278_14 and arg_275_1.time_ < var_278_7 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play938042067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 938042067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play938042068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10183"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10183 == nil then
				arg_279_1.var_.actorSpriteComps10183 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10183 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10183 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10183 = nil
			end

			local var_282_8 = arg_279_1.actors_["10183"].transform
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 then
				arg_279_1.var_.moveOldPos10183 = var_282_8.localPosition
				var_282_8.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10183", 3)

				local var_282_10 = var_282_8.childCount

				for iter_282_4 = 0, var_282_10 - 1 do
					local var_282_11 = var_282_8:GetChild(iter_282_4)

					if var_282_11.name == "split_4" or not string.find(var_282_11.name, "split") then
						var_282_11.gameObject:SetActive(true)
					else
						var_282_11.gameObject:SetActive(false)
					end
				end
			end

			local var_282_12 = 0.001

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_12 then
				local var_282_13 = (arg_279_1.time_ - var_282_9) / var_282_12
				local var_282_14 = Vector3.New(0, -475, -325)

				var_282_8.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10183, var_282_14, var_282_13)
			end

			if arg_279_1.time_ >= var_282_9 + var_282_12 and arg_279_1.time_ < var_282_9 + var_282_12 + arg_282_0 then
				var_282_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_282_15 = 0
			local var_282_16 = 0.65

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[1562].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(938042067)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 26
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_23 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_23 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_23

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_23 and arg_279_1.time_ < var_282_15 + var_282_23 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play938042068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 938042068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play938042069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10183"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10183 == nil then
				arg_283_1.var_.actorSpriteComps10183 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10183 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10183 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10183 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 0.25

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_11 = arg_283_1:GetWordFromCfg(938042068)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 10
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play938042069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 938042069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play938042070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10183"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10183 == nil then
				arg_287_1.var_.actorSpriteComps10183 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10183 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10183 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10183 = nil
			end

			local var_290_8 = arg_287_1.actors_["10183"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos10183 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10183", 3)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_7" then
						var_290_11:SetAsLastSibling()
						var_290_11.gameObject:SetActive(true)

						arg_287_1.var_.actorSpriteSplit10183 = var_290_11.gameObject:GetComponent(typeof(Image))

						arg_287_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_290_12 = 0.5

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(0, -475, -325)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10183, var_290_14, var_290_13)

				if arg_287_1.var_.actorSpriteSplit10183 ~= nil then
					arg_287_1.var_.actorSpriteSplit10183:SetAlpha(var_290_13)
				end
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(0, -475, -325)

				if arg_287_1.var_.actorSpriteSplit10183 ~= nil then
					arg_287_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_290_15 = 0
			local var_290_16 = 0.625

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[1562].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(938042069)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 25
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_23 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_23 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_23

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_23 and arg_287_1.time_ < var_290_15 + var_290_23 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play938042070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 938042070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play938042071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10183"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10183 == nil then
				arg_291_1.var_.actorSpriteComps10183 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps10183 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 0.5, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10183 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10183 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.95

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_10 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_11 = arg_291_1:GetWordFromCfg(938042070)
				local var_294_12 = arg_291_1:FormatText(var_294_11.content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 38
				local var_294_14 = utf8.len(var_294_12)
				local var_294_15 = var_294_13 <= 0 and var_294_9 or var_294_9 * (var_294_14 / var_294_13)

				if var_294_15 > 0 and var_294_9 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play938042071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 938042071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play938042072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10183"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10183 == nil then
				arg_295_1.var_.actorSpriteComps10183 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10183 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 1, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10183 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10183 = nil
			end

			local var_298_8 = arg_295_1.actors_["10183"].transform
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.var_.moveOldPos10183 = var_298_8.localPosition
				var_298_8.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10183", 3)

				local var_298_10 = var_298_8.childCount

				for iter_298_4 = 0, var_298_10 - 1 do
					local var_298_11 = var_298_8:GetChild(iter_298_4)

					if var_298_11.name == "split_2" then
						var_298_11:SetAsLastSibling()
						var_298_11.gameObject:SetActive(true)

						arg_295_1.var_.actorSpriteSplit10183 = var_298_11.gameObject:GetComponent(typeof(Image))

						arg_295_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_298_12 = 0.5

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_12 then
				local var_298_13 = (arg_295_1.time_ - var_298_9) / var_298_12
				local var_298_14 = Vector3.New(0, -475, -325)

				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10183, var_298_14, var_298_13)

				if arg_295_1.var_.actorSpriteSplit10183 ~= nil then
					arg_295_1.var_.actorSpriteSplit10183:SetAlpha(var_298_13)
				end
			end

			if arg_295_1.time_ >= var_298_9 + var_298_12 and arg_295_1.time_ < var_298_9 + var_298_12 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(0, -475, -325)

				if arg_295_1.var_.actorSpriteSplit10183 ~= nil then
					arg_295_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_298_15 = 0
			local var_298_16 = 0.675

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_17 = arg_295_1:FormatText(StoryNameCfg[1562].name)

				arg_295_1.leftNameTxt_.text = var_298_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:GetWordFromCfg(938042071)
				local var_298_19 = arg_295_1:FormatText(var_298_18.content)

				arg_295_1.text_.text = var_298_19

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 27
				local var_298_21 = utf8.len(var_298_19)
				local var_298_22 = var_298_20 <= 0 and var_298_16 or var_298_16 * (var_298_21 / var_298_20)

				if var_298_22 > 0 and var_298_16 < var_298_22 then
					arg_295_1.talkMaxDuration = var_298_22

					if var_298_22 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_22 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_19
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_23 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_23 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_23

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_23 and arg_295_1.time_ < var_298_15 + var_298_23 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play938042072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 938042072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play938042073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10183"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos10183 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10183", 3)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "split_1" then
						var_302_3:SetAsLastSibling()
						var_302_3.gameObject:SetActive(true)

						arg_299_1.var_.actorSpriteSplit10183 = var_302_3.gameObject:GetComponent(typeof(Image))

						arg_299_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_302_4 = 0.5

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(0, -475, -325)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10183, var_302_6, var_302_5)

				if arg_299_1.var_.actorSpriteSplit10183 ~= nil then
					arg_299_1.var_.actorSpriteSplit10183:SetAlpha(var_302_5)
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -475, -325)

				if arg_299_1.var_.actorSpriteSplit10183 ~= nil then
					arg_299_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_302_7 = 0
			local var_302_8 = 0.75

			if var_302_7 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_9 = arg_299_1:FormatText(StoryNameCfg[1562].name)

				arg_299_1.leftNameTxt_.text = var_302_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(938042072)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_12 = 30
				local var_302_13 = utf8.len(var_302_11)
				local var_302_14 = var_302_12 <= 0 and var_302_8 or var_302_8 * (var_302_13 / var_302_12)

				if var_302_14 > 0 and var_302_8 < var_302_14 then
					arg_299_1.talkMaxDuration = var_302_14

					if var_302_14 + var_302_7 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_7
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_15 = math.max(var_302_8, arg_299_1.talkMaxDuration)

			if var_302_7 <= arg_299_1.time_ and arg_299_1.time_ < var_302_7 + var_302_15 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_7) / var_302_15

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_7 + var_302_15 and arg_299_1.time_ < var_302_7 + var_302_15 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play938042073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 938042073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play938042074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10183"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10183 == nil then
				arg_303_1.var_.actorSpriteComps10183 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps10183 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 0.5, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10183 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10183 = nil
			end

			local var_306_8 = arg_303_1.actors_["10183"].transform
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.var_.moveOldPos10183 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10183", 7)

				local var_306_10 = var_306_8.childCount

				for iter_306_4 = 0, var_306_10 - 1 do
					local var_306_11 = var_306_8:GetChild(iter_306_4)

					if var_306_11.name == "" or not string.find(var_306_11.name, "split") then
						var_306_11.gameObject:SetActive(true)
					else
						var_306_11.gameObject:SetActive(false)
					end
				end
			end

			local var_306_12 = 0.001

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_9) / var_306_12
				local var_306_14 = Vector3.New(0, -2000, 0)

				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10183, var_306_14, var_306_13)
			end

			if arg_303_1.time_ >= var_306_9 + var_306_12 and arg_303_1.time_ < var_306_9 + var_306_12 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_15 = 0
			local var_306_16 = 1.05

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_17 = arg_303_1:GetWordFromCfg(938042073)
				local var_306_18 = arg_303_1:FormatText(var_306_17.content)

				arg_303_1.text_.text = var_306_18

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_19 = 42
				local var_306_20 = utf8.len(var_306_18)
				local var_306_21 = var_306_19 <= 0 and var_306_16 or var_306_16 * (var_306_20 / var_306_19)

				if var_306_21 > 0 and var_306_16 < var_306_21 then
					arg_303_1.talkMaxDuration = var_306_21

					if var_306_21 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_21 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_18
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_22 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_22 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_22

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_22 and arg_303_1.time_ < var_306_15 + var_306_22 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play938042074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 938042074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play938042075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1.425

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(938042074)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 57
				local var_310_5 = utf8.len(var_310_3)
				local var_310_6 = var_310_4 <= 0 and var_310_1 or var_310_1 * (var_310_5 / var_310_4)

				if var_310_6 > 0 and var_310_1 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_7 and arg_307_1.time_ < var_310_0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play938042075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 938042075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play938042076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.35

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(938042075)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 14
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play938042076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 938042076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play938042077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10183"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10183 == nil then
				arg_315_1.var_.actorSpriteComps10183 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps10183 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10183 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10183 = nil
			end

			local var_318_8 = arg_315_1.actors_["10183"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos10183 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10183", 3)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "split_3" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(0, -475, -325)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10183, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_318_15 = 0
			local var_318_16 = 0.725

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_17 = arg_315_1:FormatText(StoryNameCfg[1562].name)

				arg_315_1.leftNameTxt_.text = var_318_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_18 = arg_315_1:GetWordFromCfg(938042076)
				local var_318_19 = arg_315_1:FormatText(var_318_18.content)

				arg_315_1.text_.text = var_318_19

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_20 = 29
				local var_318_21 = utf8.len(var_318_19)
				local var_318_22 = var_318_20 <= 0 and var_318_16 or var_318_16 * (var_318_21 / var_318_20)

				if var_318_22 > 0 and var_318_16 < var_318_22 then
					arg_315_1.talkMaxDuration = var_318_22

					if var_318_22 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_22 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_19
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_23 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 <= arg_315_1.time_ and arg_315_1.time_ < var_318_15 + var_318_23 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_15) / var_318_23

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_15 + var_318_23 and arg_315_1.time_ < var_318_15 + var_318_23 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play938042077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 938042077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play938042078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10183"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10183 == nil then
				arg_319_1.var_.actorSpriteComps10183 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10183 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 0.5, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10183 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10183 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 0.175

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_10 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_11 = arg_319_1:GetWordFromCfg(938042077)
				local var_322_12 = arg_319_1:FormatText(var_322_11.content)

				arg_319_1.text_.text = var_322_12

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 7
				local var_322_14 = utf8.len(var_322_12)
				local var_322_15 = var_322_13 <= 0 and var_322_9 or var_322_9 * (var_322_14 / var_322_13)

				if var_322_15 > 0 and var_322_9 < var_322_15 then
					arg_319_1.talkMaxDuration = var_322_15

					if var_322_15 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_12
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play938042078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 938042078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play938042079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10183"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10183 == nil then
				arg_323_1.var_.actorSpriteComps10183 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10183 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 1, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10183 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10183 = nil
			end

			local var_326_8 = arg_323_1.actors_["10183"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos10183 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10183", 3)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "" then
						var_326_11:SetAsLastSibling()
						var_326_11.gameObject:SetActive(true)

						arg_323_1.var_.actorSpriteSplit10183 = var_326_11.gameObject:GetComponent(typeof(Image))

						arg_323_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_326_12 = 0.5

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -475, -325)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10183, var_326_14, var_326_13)

				if arg_323_1.var_.actorSpriteSplit10183 ~= nil then
					arg_323_1.var_.actorSpriteSplit10183:SetAlpha(var_326_13)
				end
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -475, -325)

				if arg_323_1.var_.actorSpriteSplit10183 ~= nil then
					arg_323_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_326_15 = 0
			local var_326_16 = 1.275

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[1562].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(938042078)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 51
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_23 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_23 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_23

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_23 and arg_323_1.time_ < var_326_15 + var_326_23 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play938042079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 938042079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play938042080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10183"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10183 == nil then
				arg_327_1.var_.actorSpriteComps10183 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10183 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 0.5, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10183 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10183 = nil
			end

			local var_330_8 = 0
			local var_330_9 = 0.375

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_10 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_11 = arg_327_1:GetWordFromCfg(938042079)
				local var_330_12 = arg_327_1:FormatText(var_330_11.content)

				arg_327_1.text_.text = var_330_12

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 15
				local var_330_14 = utf8.len(var_330_12)
				local var_330_15 = var_330_13 <= 0 and var_330_9 or var_330_9 * (var_330_14 / var_330_13)

				if var_330_15 > 0 and var_330_9 < var_330_15 then
					arg_327_1.talkMaxDuration = var_330_15

					if var_330_15 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_15 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_12
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play938042080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 938042080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play938042081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10183"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10183 == nil then
				arg_331_1.var_.actorSpriteComps10183 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps10183 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 1, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10183 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10183 = nil
			end

			local var_334_8 = arg_331_1.actors_["10183"].transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.moveOldPos10183 = var_334_8.localPosition
				var_334_8.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10183", 3)

				local var_334_10 = var_334_8.childCount

				for iter_334_4 = 0, var_334_10 - 1 do
					local var_334_11 = var_334_8:GetChild(iter_334_4)

					if var_334_11.name == "split_6" or not string.find(var_334_11.name, "split") then
						var_334_11.gameObject:SetActive(true)
					else
						var_334_11.gameObject:SetActive(false)
					end
				end
			end

			local var_334_12 = 0.001

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_12 then
				local var_334_13 = (arg_331_1.time_ - var_334_9) / var_334_12
				local var_334_14 = Vector3.New(0, -475, -325)

				var_334_8.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10183, var_334_14, var_334_13)
			end

			if arg_331_1.time_ >= var_334_9 + var_334_12 and arg_331_1.time_ < var_334_9 + var_334_12 + arg_334_0 then
				var_334_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_334_15 = 0
			local var_334_16 = 1.15

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[1562].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(938042080)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 46
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_23 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_23 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_23

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_23 and arg_331_1.time_ < var_334_15 + var_334_23 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play938042081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 938042081
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play938042082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.95

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[1562].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(938042081)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 38
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play938042082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 938042082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play938042083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10183"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10183 == nil then
				arg_339_1.var_.actorSpriteComps10183 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps10183 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 0.5, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10183 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10183 = nil
			end

			local var_342_8 = 0
			local var_342_9 = 0.2

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_10 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_11 = arg_339_1:GetWordFromCfg(938042082)
				local var_342_12 = arg_339_1:FormatText(var_342_11.content)

				arg_339_1.text_.text = var_342_12

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_13 = 8
				local var_342_14 = utf8.len(var_342_12)
				local var_342_15 = var_342_13 <= 0 and var_342_9 or var_342_9 * (var_342_14 / var_342_13)

				if var_342_15 > 0 and var_342_9 < var_342_15 then
					arg_339_1.talkMaxDuration = var_342_15

					if var_342_15 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_15 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_12
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_16 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_16 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_16

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_16 and arg_339_1.time_ < var_342_8 + var_342_16 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play938042083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 938042083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play938042084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10183"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10183 == nil then
				arg_343_1.var_.actorSpriteComps10183 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps10183 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10183 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10183 = nil
			end

			local var_346_8 = arg_343_1.actors_["10183"].transform
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.var_.moveOldPos10183 = var_346_8.localPosition
				var_346_8.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10183", 3)

				local var_346_10 = var_346_8.childCount

				for iter_346_4 = 0, var_346_10 - 1 do
					local var_346_11 = var_346_8:GetChild(iter_346_4)

					if var_346_11.name == "split_5" or not string.find(var_346_11.name, "split") then
						var_346_11.gameObject:SetActive(true)
					else
						var_346_11.gameObject:SetActive(false)
					end
				end
			end

			local var_346_12 = 0.001

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_12 then
				local var_346_13 = (arg_343_1.time_ - var_346_9) / var_346_12
				local var_346_14 = Vector3.New(0, -475, -325)

				var_346_8.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10183, var_346_14, var_346_13)
			end

			if arg_343_1.time_ >= var_346_9 + var_346_12 and arg_343_1.time_ < var_346_9 + var_346_12 + arg_346_0 then
				var_346_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_346_15 = 0
			local var_346_16 = 0.15

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_17 = arg_343_1:FormatText(StoryNameCfg[1562].name)

				arg_343_1.leftNameTxt_.text = var_346_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(938042083)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_20 = 6
				local var_346_21 = utf8.len(var_346_19)
				local var_346_22 = var_346_20 <= 0 and var_346_16 or var_346_16 * (var_346_21 / var_346_20)

				if var_346_22 > 0 and var_346_16 < var_346_22 then
					arg_343_1.talkMaxDuration = var_346_22

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_23 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_23 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_15) / var_346_23

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_15 + var_346_23 and arg_343_1.time_ < var_346_15 + var_346_23 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938042084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 938042084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play938042085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10183"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10183 == nil then
				arg_347_1.var_.actorSpriteComps10183 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10183 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 0.5, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10183 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10183 = nil
			end

			local var_350_8 = arg_347_1.actors_["10183"].transform
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 then
				arg_347_1.var_.moveOldPos10183 = var_350_8.localPosition
				var_350_8.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10183", 7)

				local var_350_10 = var_350_8.childCount

				for iter_350_4 = 0, var_350_10 - 1 do
					local var_350_11 = var_350_8:GetChild(iter_350_4)

					if var_350_11.name == "" or not string.find(var_350_11.name, "split") then
						var_350_11.gameObject:SetActive(true)
					else
						var_350_11.gameObject:SetActive(false)
					end
				end
			end

			local var_350_12 = 0.001

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_12 then
				local var_350_13 = (arg_347_1.time_ - var_350_9) / var_350_12
				local var_350_14 = Vector3.New(0, -2000, 0)

				var_350_8.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10183, var_350_14, var_350_13)
			end

			if arg_347_1.time_ >= var_350_9 + var_350_12 and arg_347_1.time_ < var_350_9 + var_350_12 + arg_350_0 then
				var_350_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_350_15 = 0
			local var_350_16 = 1.075

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_17 = arg_347_1:GetWordFromCfg(938042084)
				local var_350_18 = arg_347_1:FormatText(var_350_17.content)

				arg_347_1.text_.text = var_350_18

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_19 = 43
				local var_350_20 = utf8.len(var_350_18)
				local var_350_21 = var_350_19 <= 0 and var_350_16 or var_350_16 * (var_350_20 / var_350_19)

				if var_350_21 > 0 and var_350_16 < var_350_21 then
					arg_347_1.talkMaxDuration = var_350_21

					if var_350_21 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_21 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_18
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_22 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_22 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_22

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_22 and arg_347_1.time_ < var_350_15 + var_350_22 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play938042085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 938042085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play938042086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10183"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10183 == nil then
				arg_351_1.var_.actorSpriteComps10183 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10183 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 1, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10183 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_354_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10183 = nil
			end

			local var_354_8 = arg_351_1.actors_["10183"].transform
			local var_354_9 = 0

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 then
				arg_351_1.var_.moveOldPos10183 = var_354_8.localPosition
				var_354_8.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10183", 3)

				local var_354_10 = var_354_8.childCount

				for iter_354_4 = 0, var_354_10 - 1 do
					local var_354_11 = var_354_8:GetChild(iter_354_4)

					if var_354_11.name == "split_2" or not string.find(var_354_11.name, "split") then
						var_354_11.gameObject:SetActive(true)
					else
						var_354_11.gameObject:SetActive(false)
					end
				end
			end

			local var_354_12 = 0.001

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_12 then
				local var_354_13 = (arg_351_1.time_ - var_354_9) / var_354_12
				local var_354_14 = Vector3.New(0, -475, -325)

				var_354_8.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10183, var_354_14, var_354_13)
			end

			if arg_351_1.time_ >= var_354_9 + var_354_12 and arg_351_1.time_ < var_354_9 + var_354_12 + arg_354_0 then
				var_354_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_354_15 = 0
			local var_354_16 = 0.925

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_17 = arg_351_1:FormatText(StoryNameCfg[1562].name)

				arg_351_1.leftNameTxt_.text = var_354_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_18 = arg_351_1:GetWordFromCfg(938042085)
				local var_354_19 = arg_351_1:FormatText(var_354_18.content)

				arg_351_1.text_.text = var_354_19

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_20 = 37
				local var_354_21 = utf8.len(var_354_19)
				local var_354_22 = var_354_20 <= 0 and var_354_16 or var_354_16 * (var_354_21 / var_354_20)

				if var_354_22 > 0 and var_354_16 < var_354_22 then
					arg_351_1.talkMaxDuration = var_354_22

					if var_354_22 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_15
					end
				end

				arg_351_1.text_.text = var_354_19
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_23 = math.max(var_354_16, arg_351_1.talkMaxDuration)

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_23 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_23

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_23 and arg_351_1.time_ < var_354_15 + var_354_23 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play938042086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 938042086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play938042087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10183"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10183 == nil then
				arg_355_1.var_.actorSpriteComps10183 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps10183 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								local var_358_4 = Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, var_358_3)
								local var_358_5 = Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, var_358_3)
								local var_358_6 = Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, var_358_3)

								iter_358_1.color = Color.New(var_358_4, var_358_5, var_358_6)
							else
								local var_358_7 = Mathf.Lerp(iter_358_1.color.r, 0.5, var_358_3)

								iter_358_1.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10183 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10183 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.3

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_10 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_11 = arg_355_1:GetWordFromCfg(938042086)
				local var_358_12 = arg_355_1:FormatText(var_358_11.content)

				arg_355_1.text_.text = var_358_12

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 12
				local var_358_14 = utf8.len(var_358_12)
				local var_358_15 = var_358_13 <= 0 and var_358_9 or var_358_9 * (var_358_14 / var_358_13)

				if var_358_15 > 0 and var_358_9 < var_358_15 then
					arg_355_1.talkMaxDuration = var_358_15

					if var_358_15 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_15 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_12
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_16 and arg_355_1.time_ < var_358_8 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play938042087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 938042087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play938042088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10183"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10183 == nil then
				arg_359_1.var_.actorSpriteComps10183 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps10183 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 1, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10183 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10183 = nil
			end

			local var_362_8 = arg_359_1.actors_["10183"].transform
			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.var_.moveOldPos10183 = var_362_8.localPosition
				var_362_8.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10183", 3)

				local var_362_10 = var_362_8.childCount

				for iter_362_4 = 0, var_362_10 - 1 do
					local var_362_11 = var_362_8:GetChild(iter_362_4)

					if var_362_11.name == "split_5" or not string.find(var_362_11.name, "split") then
						var_362_11.gameObject:SetActive(true)
					else
						var_362_11.gameObject:SetActive(false)
					end
				end
			end

			local var_362_12 = 0.001

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_12 then
				local var_362_13 = (arg_359_1.time_ - var_362_9) / var_362_12
				local var_362_14 = Vector3.New(0, -475, -325)

				var_362_8.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10183, var_362_14, var_362_13)
			end

			if arg_359_1.time_ >= var_362_9 + var_362_12 and arg_359_1.time_ < var_362_9 + var_362_12 + arg_362_0 then
				var_362_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_362_15 = 0
			local var_362_16 = 1.35

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[1562].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(938042087)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 54
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_23 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_23 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_23

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_23 and arg_359_1.time_ < var_362_15 + var_362_23 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play938042088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 938042088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play938042089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10183"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10183 == nil then
				arg_363_1.var_.actorSpriteComps10183 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps10183 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 0.5, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10183 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10183 = nil
			end

			local var_366_8 = 0
			local var_366_9 = 0.275

			if var_366_8 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_10 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_11 = arg_363_1:GetWordFromCfg(938042088)
				local var_366_12 = arg_363_1:FormatText(var_366_11.content)

				arg_363_1.text_.text = var_366_12

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 11
				local var_366_14 = utf8.len(var_366_12)
				local var_366_15 = var_366_13 <= 0 and var_366_9 or var_366_9 * (var_366_14 / var_366_13)

				if var_366_15 > 0 and var_366_9 < var_366_15 then
					arg_363_1.talkMaxDuration = var_366_15

					if var_366_15 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_15 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_12
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_16 and arg_363_1.time_ < var_366_8 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play938042089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 938042089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play938042090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10183"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10183 == nil then
				arg_367_1.var_.actorSpriteComps10183 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps10183 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 1, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10183 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10183 = nil
			end

			local var_370_8 = arg_367_1.actors_["10183"].transform
			local var_370_9 = 0

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 then
				arg_367_1.var_.moveOldPos10183 = var_370_8.localPosition
				var_370_8.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10183", 3)

				local var_370_10 = var_370_8.childCount

				for iter_370_4 = 0, var_370_10 - 1 do
					local var_370_11 = var_370_8:GetChild(iter_370_4)

					if var_370_11.name == "split_2" then
						var_370_11:SetAsLastSibling()
						var_370_11.gameObject:SetActive(true)

						arg_367_1.var_.actorSpriteSplit10183 = var_370_11.gameObject:GetComponent(typeof(Image))

						arg_367_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_370_12 = 0.5

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_12 then
				local var_370_13 = (arg_367_1.time_ - var_370_9) / var_370_12
				local var_370_14 = Vector3.New(0, -475, -325)

				var_370_8.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10183, var_370_14, var_370_13)

				if arg_367_1.var_.actorSpriteSplit10183 ~= nil then
					arg_367_1.var_.actorSpriteSplit10183:SetAlpha(var_370_13)
				end
			end

			if arg_367_1.time_ >= var_370_9 + var_370_12 and arg_367_1.time_ < var_370_9 + var_370_12 + arg_370_0 then
				var_370_8.localPosition = Vector3.New(0, -475, -325)

				if arg_367_1.var_.actorSpriteSplit10183 ~= nil then
					arg_367_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_370_15 = 0
			local var_370_16 = 0.975

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[1562].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(938042089)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 39
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_23 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_23 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_23

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_23 and arg_367_1.time_ < var_370_15 + var_370_23 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play938042090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 938042090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play938042091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10183"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps10183 == nil then
				arg_371_1.var_.actorSpriteComps10183 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps10183 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 0.5, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps10183 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10183 = nil
			end

			local var_374_8 = 0
			local var_374_9 = 0.325

			if var_374_8 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_10 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_11 = arg_371_1:GetWordFromCfg(938042090)
				local var_374_12 = arg_371_1:FormatText(var_374_11.content)

				arg_371_1.text_.text = var_374_12

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 13
				local var_374_14 = utf8.len(var_374_12)
				local var_374_15 = var_374_13 <= 0 and var_374_9 or var_374_9 * (var_374_14 / var_374_13)

				if var_374_15 > 0 and var_374_9 < var_374_15 then
					arg_371_1.talkMaxDuration = var_374_15

					if var_374_15 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_15 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_12
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play938042091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 938042091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play938042092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10183"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10183 == nil then
				arg_375_1.var_.actorSpriteComps10183 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps10183 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 1, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10183 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10183 = nil
			end

			local var_378_8 = arg_375_1.actors_["10183"].transform
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.var_.moveOldPos10183 = var_378_8.localPosition
				var_378_8.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10183", 3)

				local var_378_10 = var_378_8.childCount

				for iter_378_4 = 0, var_378_10 - 1 do
					local var_378_11 = var_378_8:GetChild(iter_378_4)

					if var_378_11.name == "split_1" then
						var_378_11:SetAsLastSibling()
						var_378_11.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit10183 = var_378_11.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_378_12 = 0.5

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_12 then
				local var_378_13 = (arg_375_1.time_ - var_378_9) / var_378_12
				local var_378_14 = Vector3.New(0, -475, -325)

				var_378_8.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10183, var_378_14, var_378_13)

				if arg_375_1.var_.actorSpriteSplit10183 ~= nil then
					arg_375_1.var_.actorSpriteSplit10183:SetAlpha(var_378_13)
				end
			end

			if arg_375_1.time_ >= var_378_9 + var_378_12 and arg_375_1.time_ < var_378_9 + var_378_12 + arg_378_0 then
				var_378_8.localPosition = Vector3.New(0, -475, -325)

				if arg_375_1.var_.actorSpriteSplit10183 ~= nil then
					arg_375_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_378_15 = 0
			local var_378_16 = 0.875

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[1562].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(938042091)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 35
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_23 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_23 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_23

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_23 and arg_375_1.time_ < var_378_15 + var_378_23 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play938042092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 938042092
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play938042093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10183"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos10183 = var_382_0.localPosition
				var_382_0.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10183", 3)

				local var_382_2 = var_382_0.childCount

				for iter_382_0 = 0, var_382_2 - 1 do
					local var_382_3 = var_382_0:GetChild(iter_382_0)

					if var_382_3.name == "" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_4 then
				local var_382_5 = (arg_379_1.time_ - var_382_1) / var_382_4
				local var_382_6 = Vector3.New(0, -475, -325)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10183, var_382_6, var_382_5)
			end

			if arg_379_1.time_ >= var_382_1 + var_382_4 and arg_379_1.time_ < var_382_1 + var_382_4 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_382_7 = 0
			local var_382_8 = 1.25

			if var_382_7 < arg_379_1.time_ and arg_379_1.time_ <= var_382_7 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_9 = arg_379_1:FormatText(StoryNameCfg[1562].name)

				arg_379_1.leftNameTxt_.text = var_382_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(938042092)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_12 = 50
				local var_382_13 = utf8.len(var_382_11)
				local var_382_14 = var_382_12 <= 0 and var_382_8 or var_382_8 * (var_382_13 / var_382_12)

				if var_382_14 > 0 and var_382_8 < var_382_14 then
					arg_379_1.talkMaxDuration = var_382_14

					if var_382_14 + var_382_7 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_7
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_15 = math.max(var_382_8, arg_379_1.talkMaxDuration)

			if var_382_7 <= arg_379_1.time_ and arg_379_1.time_ < var_382_7 + var_382_15 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_7) / var_382_15

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_7 + var_382_15 and arg_379_1.time_ < var_382_7 + var_382_15 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play938042093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 938042093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play938042094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10183"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10183 == nil then
				arg_383_1.var_.actorSpriteComps10183 = var_386_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.actorSpriteComps10183 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								local var_386_4 = Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor2.r, var_386_3)
								local var_386_5 = Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor2.g, var_386_3)
								local var_386_6 = Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor2.b, var_386_3)

								iter_386_1.color = Color.New(var_386_4, var_386_5, var_386_6)
							else
								local var_386_7 = Mathf.Lerp(iter_386_1.color.r, 0.5, var_386_3)

								iter_386_1.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10183 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_386_3 then
						if arg_383_1.isInRecall_ then
							iter_386_3.color = arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_386_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10183 = nil
			end

			local var_386_8 = manager.ui.mainCamera.transform
			local var_386_9 = 0

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 then
				arg_383_1.var_.shakeOldPos = var_386_8.localPosition
			end

			local var_386_10 = 0.666666666666667

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_10 then
				local var_386_11 = (arg_383_1.time_ - var_386_9) / 0.066
				local var_386_12, var_386_13 = math.modf(var_386_11)

				var_386_8.localPosition = Vector3.New(var_386_13 * 0.13, var_386_13 * 0.13, var_386_13 * 0.13) + arg_383_1.var_.shakeOldPos
			end

			if arg_383_1.time_ >= var_386_9 + var_386_10 and arg_383_1.time_ < var_386_9 + var_386_10 + arg_386_0 then
				var_386_8.localPosition = arg_383_1.var_.shakeOldPos
			end

			local var_386_14 = 0
			local var_386_15 = 0.325

			if var_386_14 < arg_383_1.time_ and arg_383_1.time_ <= var_386_14 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_16 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_16:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_18 = arg_383_1:GetWordFromCfg(938042093)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 13
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_15 or var_386_15 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_15 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22
					var_386_14 = var_386_14 + 0.3

					if var_386_22 + var_386_14 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_14
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_23 = var_386_14 + 0.3
			local var_386_24 = math.max(var_386_15, arg_383_1.talkMaxDuration)

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_24 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_23) / var_386_24

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_23 + var_386_24 and arg_383_1.time_ < var_386_23 + var_386_24 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play938042094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 938042094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play938042095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10183"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10183 == nil then
				arg_389_1.var_.actorSpriteComps10183 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps10183 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								local var_392_4 = Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, var_392_3)
								local var_392_5 = Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, var_392_3)
								local var_392_6 = Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, var_392_3)

								iter_392_1.color = Color.New(var_392_4, var_392_5, var_392_6)
							else
								local var_392_7 = Mathf.Lerp(iter_392_1.color.r, 1, var_392_3)

								iter_392_1.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10183 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_392_3 then
						if arg_389_1.isInRecall_ then
							iter_392_3.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10183 = nil
			end

			local var_392_8 = arg_389_1.actors_["10183"].transform
			local var_392_9 = 0

			if var_392_9 < arg_389_1.time_ and arg_389_1.time_ <= var_392_9 + arg_392_0 then
				arg_389_1.var_.moveOldPos10183 = var_392_8.localPosition
				var_392_8.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10183", 3)

				local var_392_10 = var_392_8.childCount

				for iter_392_4 = 0, var_392_10 - 1 do
					local var_392_11 = var_392_8:GetChild(iter_392_4)

					if var_392_11.name == "" or not string.find(var_392_11.name, "split") then
						var_392_11.gameObject:SetActive(true)
					else
						var_392_11.gameObject:SetActive(false)
					end
				end
			end

			local var_392_12 = 0.001

			if var_392_9 <= arg_389_1.time_ and arg_389_1.time_ < var_392_9 + var_392_12 then
				local var_392_13 = (arg_389_1.time_ - var_392_9) / var_392_12
				local var_392_14 = Vector3.New(0, -475, -325)

				var_392_8.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10183, var_392_14, var_392_13)
			end

			if arg_389_1.time_ >= var_392_9 + var_392_12 and arg_389_1.time_ < var_392_9 + var_392_12 + arg_392_0 then
				var_392_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_392_15 = 0
			local var_392_16 = 1.3

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[1562].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(938042094)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 52
				local var_392_21 = utf8.len(var_392_19)
				local var_392_22 = var_392_20 <= 0 and var_392_16 or var_392_16 * (var_392_21 / var_392_20)

				if var_392_22 > 0 and var_392_16 < var_392_22 then
					arg_389_1.talkMaxDuration = var_392_22

					if var_392_22 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_22 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_19
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_23 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_23 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_23

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_23 and arg_389_1.time_ < var_392_15 + var_392_23 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play938042095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 938042095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play938042096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 1.45

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[1562].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:GetWordFromCfg(938042095)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 58
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_8 and arg_393_1.time_ < var_396_0 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play938042096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 938042096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play938042097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10183"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos10183 = var_400_0.localPosition
				var_400_0.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10183", 3)

				local var_400_2 = var_400_0.childCount

				for iter_400_0 = 0, var_400_2 - 1 do
					local var_400_3 = var_400_0:GetChild(iter_400_0)

					if var_400_3.name == "split_2" then
						var_400_3:SetAsLastSibling()
						var_400_3.gameObject:SetActive(true)

						arg_397_1.var_.actorSpriteSplit10183 = var_400_3.gameObject:GetComponent(typeof(Image))

						arg_397_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_400_4 = 0.5

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_4 then
				local var_400_5 = (arg_397_1.time_ - var_400_1) / var_400_4
				local var_400_6 = Vector3.New(0, -475, -325)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10183, var_400_6, var_400_5)

				if arg_397_1.var_.actorSpriteSplit10183 ~= nil then
					arg_397_1.var_.actorSpriteSplit10183:SetAlpha(var_400_5)
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_4 and arg_397_1.time_ < var_400_1 + var_400_4 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -475, -325)

				if arg_397_1.var_.actorSpriteSplit10183 ~= nil then
					arg_397_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_400_7 = 0
			local var_400_8 = 1.15

			if var_400_7 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_9 = arg_397_1:FormatText(StoryNameCfg[1562].name)

				arg_397_1.leftNameTxt_.text = var_400_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:GetWordFromCfg(938042096)
				local var_400_11 = arg_397_1:FormatText(var_400_10.content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_12 = 46
				local var_400_13 = utf8.len(var_400_11)
				local var_400_14 = var_400_12 <= 0 and var_400_8 or var_400_8 * (var_400_13 / var_400_12)

				if var_400_14 > 0 and var_400_8 < var_400_14 then
					arg_397_1.talkMaxDuration = var_400_14

					if var_400_14 + var_400_7 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_7
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_15 = math.max(var_400_8, arg_397_1.talkMaxDuration)

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_15 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_7) / var_400_15

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_7 + var_400_15 and arg_397_1.time_ < var_400_7 + var_400_15 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play938042097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 938042097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play938042098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10183"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10183 == nil then
				arg_401_1.var_.actorSpriteComps10183 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps10183 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								local var_404_4 = Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, var_404_3)
								local var_404_5 = Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, var_404_3)
								local var_404_6 = Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, var_404_3)

								iter_404_1.color = Color.New(var_404_4, var_404_5, var_404_6)
							else
								local var_404_7 = Mathf.Lerp(iter_404_1.color.r, 0.5, var_404_3)

								iter_404_1.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10183 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_404_3 then
						if arg_401_1.isInRecall_ then
							iter_404_3.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10183 = nil
			end

			local var_404_8 = 0
			local var_404_9 = 0.35

			if var_404_8 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_10 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_11 = arg_401_1:GetWordFromCfg(938042097)
				local var_404_12 = arg_401_1:FormatText(var_404_11.content)

				arg_401_1.text_.text = var_404_12

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_13 = 14
				local var_404_14 = utf8.len(var_404_12)
				local var_404_15 = var_404_13 <= 0 and var_404_9 or var_404_9 * (var_404_14 / var_404_13)

				if var_404_15 > 0 and var_404_9 < var_404_15 then
					arg_401_1.talkMaxDuration = var_404_15

					if var_404_15 + var_404_8 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_15 + var_404_8
					end
				end

				arg_401_1.text_.text = var_404_12
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_16 = math.max(var_404_9, arg_401_1.talkMaxDuration)

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_16 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_8) / var_404_16

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_8 + var_404_16 and arg_401_1.time_ < var_404_8 + var_404_16 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play938042098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 938042098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play938042099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10183"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10183 == nil then
				arg_405_1.var_.actorSpriteComps10183 = var_408_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.actorSpriteComps10183 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								local var_408_4 = Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor1.r, var_408_3)
								local var_408_5 = Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor1.g, var_408_3)
								local var_408_6 = Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor1.b, var_408_3)

								iter_408_1.color = Color.New(var_408_4, var_408_5, var_408_6)
							else
								local var_408_7 = Mathf.Lerp(iter_408_1.color.r, 1, var_408_3)

								iter_408_1.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10183 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_408_3 then
						if arg_405_1.isInRecall_ then
							iter_408_3.color = arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_408_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps10183 = nil
			end

			local var_408_8 = arg_405_1.actors_["10183"].transform
			local var_408_9 = 0

			if var_408_9 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				arg_405_1.var_.moveOldPos10183 = var_408_8.localPosition
				var_408_8.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10183", 3)

				local var_408_10 = var_408_8.childCount

				for iter_408_4 = 0, var_408_10 - 1 do
					local var_408_11 = var_408_8:GetChild(iter_408_4)

					if var_408_11.name == "" then
						var_408_11:SetAsLastSibling()
						var_408_11.gameObject:SetActive(true)

						arg_405_1.var_.actorSpriteSplit10183 = var_408_11.gameObject:GetComponent(typeof(Image))

						arg_405_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_408_12 = 0.5

			if var_408_9 <= arg_405_1.time_ and arg_405_1.time_ < var_408_9 + var_408_12 then
				local var_408_13 = (arg_405_1.time_ - var_408_9) / var_408_12
				local var_408_14 = Vector3.New(0, -475, -325)

				var_408_8.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10183, var_408_14, var_408_13)

				if arg_405_1.var_.actorSpriteSplit10183 ~= nil then
					arg_405_1.var_.actorSpriteSplit10183:SetAlpha(var_408_13)
				end
			end

			if arg_405_1.time_ >= var_408_9 + var_408_12 and arg_405_1.time_ < var_408_9 + var_408_12 + arg_408_0 then
				var_408_8.localPosition = Vector3.New(0, -475, -325)

				if arg_405_1.var_.actorSpriteSplit10183 ~= nil then
					arg_405_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_408_15 = 0
			local var_408_16 = 0.675

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_17 = arg_405_1:FormatText(StoryNameCfg[1562].name)

				arg_405_1.leftNameTxt_.text = var_408_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_18 = arg_405_1:GetWordFromCfg(938042098)
				local var_408_19 = arg_405_1:FormatText(var_408_18.content)

				arg_405_1.text_.text = var_408_19

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_20 = 27
				local var_408_21 = utf8.len(var_408_19)
				local var_408_22 = var_408_20 <= 0 and var_408_16 or var_408_16 * (var_408_21 / var_408_20)

				if var_408_22 > 0 and var_408_16 < var_408_22 then
					arg_405_1.talkMaxDuration = var_408_22

					if var_408_22 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_22 + var_408_15
					end
				end

				arg_405_1.text_.text = var_408_19
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_23 = math.max(var_408_16, arg_405_1.talkMaxDuration)

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_23 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_15) / var_408_23

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_15 + var_408_23 and arg_405_1.time_ < var_408_15 + var_408_23 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play938042099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 938042099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play938042100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10183"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos10183 = var_412_0.localPosition
				var_412_0.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10183", 3)

				local var_412_2 = var_412_0.childCount

				for iter_412_0 = 0, var_412_2 - 1 do
					local var_412_3 = var_412_0:GetChild(iter_412_0)

					if var_412_3.name == "split_5" then
						var_412_3:SetAsLastSibling()
						var_412_3.gameObject:SetActive(true)

						arg_409_1.var_.actorSpriteSplit10183 = var_412_3.gameObject:GetComponent(typeof(Image))

						arg_409_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_412_4 = 0.5

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_4 then
				local var_412_5 = (arg_409_1.time_ - var_412_1) / var_412_4
				local var_412_6 = Vector3.New(0, -475, -325)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10183, var_412_6, var_412_5)

				if arg_409_1.var_.actorSpriteSplit10183 ~= nil then
					arg_409_1.var_.actorSpriteSplit10183:SetAlpha(var_412_5)
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_4 and arg_409_1.time_ < var_412_1 + var_412_4 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -475, -325)

				if arg_409_1.var_.actorSpriteSplit10183 ~= nil then
					arg_409_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_412_7 = 0
			local var_412_8 = 1.15

			if var_412_7 < arg_409_1.time_ and arg_409_1.time_ <= var_412_7 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_9 = arg_409_1:FormatText(StoryNameCfg[1562].name)

				arg_409_1.leftNameTxt_.text = var_412_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_10 = arg_409_1:GetWordFromCfg(938042099)
				local var_412_11 = arg_409_1:FormatText(var_412_10.content)

				arg_409_1.text_.text = var_412_11

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_12 = 46
				local var_412_13 = utf8.len(var_412_11)
				local var_412_14 = var_412_12 <= 0 and var_412_8 or var_412_8 * (var_412_13 / var_412_12)

				if var_412_14 > 0 and var_412_8 < var_412_14 then
					arg_409_1.talkMaxDuration = var_412_14

					if var_412_14 + var_412_7 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_7
					end
				end

				arg_409_1.text_.text = var_412_11
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_15 = math.max(var_412_8, arg_409_1.talkMaxDuration)

			if var_412_7 <= arg_409_1.time_ and arg_409_1.time_ < var_412_7 + var_412_15 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_7) / var_412_15

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_7 + var_412_15 and arg_409_1.time_ < var_412_7 + var_412_15 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play938042100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 938042100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play938042101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10183"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10183 == nil then
				arg_413_1.var_.actorSpriteComps10183 = var_416_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.actorSpriteComps10183 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								local var_416_4 = Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor2.r, var_416_3)
								local var_416_5 = Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor2.g, var_416_3)
								local var_416_6 = Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor2.b, var_416_3)

								iter_416_1.color = Color.New(var_416_4, var_416_5, var_416_6)
							else
								local var_416_7 = Mathf.Lerp(iter_416_1.color.r, 0.5, var_416_3)

								iter_416_1.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10183 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_416_3 then
						if arg_413_1.isInRecall_ then
							iter_416_3.color = arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_416_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps10183 = nil
			end

			local var_416_8 = 0
			local var_416_9 = 0.2

			if var_416_8 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_10 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_11 = arg_413_1:GetWordFromCfg(938042100)
				local var_416_12 = arg_413_1:FormatText(var_416_11.content)

				arg_413_1.text_.text = var_416_12

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_13 = 8
				local var_416_14 = utf8.len(var_416_12)
				local var_416_15 = var_416_13 <= 0 and var_416_9 or var_416_9 * (var_416_14 / var_416_13)

				if var_416_15 > 0 and var_416_9 < var_416_15 then
					arg_413_1.talkMaxDuration = var_416_15

					if var_416_15 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_15 + var_416_8
					end
				end

				arg_413_1.text_.text = var_416_12
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_16 = math.max(var_416_9, arg_413_1.talkMaxDuration)

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_16 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_8) / var_416_16

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_8 + var_416_16 and arg_413_1.time_ < var_416_8 + var_416_16 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play938042101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 938042101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play938042102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10183"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10183 == nil then
				arg_417_1.var_.actorSpriteComps10183 = var_420_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.actorSpriteComps10183 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								local var_420_4 = Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor1.r, var_420_3)
								local var_420_5 = Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor1.g, var_420_3)
								local var_420_6 = Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor1.b, var_420_3)

								iter_420_1.color = Color.New(var_420_4, var_420_5, var_420_6)
							else
								local var_420_7 = Mathf.Lerp(iter_420_1.color.r, 1, var_420_3)

								iter_420_1.color = Color.New(var_420_7, var_420_7, var_420_7)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10183 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_420_3 then
						if arg_417_1.isInRecall_ then
							iter_420_3.color = arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_420_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps10183 = nil
			end

			local var_420_8 = arg_417_1.actors_["10183"].transform
			local var_420_9 = 0

			if var_420_9 < arg_417_1.time_ and arg_417_1.time_ <= var_420_9 + arg_420_0 then
				arg_417_1.var_.moveOldPos10183 = var_420_8.localPosition
				var_420_8.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("10183", 3)

				local var_420_10 = var_420_8.childCount

				for iter_420_4 = 0, var_420_10 - 1 do
					local var_420_11 = var_420_8:GetChild(iter_420_4)

					if var_420_11.name == "" then
						var_420_11:SetAsLastSibling()
						var_420_11.gameObject:SetActive(true)

						arg_417_1.var_.actorSpriteSplit10183 = var_420_11.gameObject:GetComponent(typeof(Image))

						arg_417_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_420_12 = 0.5

			if var_420_9 <= arg_417_1.time_ and arg_417_1.time_ < var_420_9 + var_420_12 then
				local var_420_13 = (arg_417_1.time_ - var_420_9) / var_420_12
				local var_420_14 = Vector3.New(0, -475, -325)

				var_420_8.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10183, var_420_14, var_420_13)

				if arg_417_1.var_.actorSpriteSplit10183 ~= nil then
					arg_417_1.var_.actorSpriteSplit10183:SetAlpha(var_420_13)
				end
			end

			if arg_417_1.time_ >= var_420_9 + var_420_12 and arg_417_1.time_ < var_420_9 + var_420_12 + arg_420_0 then
				var_420_8.localPosition = Vector3.New(0, -475, -325)

				if arg_417_1.var_.actorSpriteSplit10183 ~= nil then
					arg_417_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_420_15 = 0
			local var_420_16 = 0.2

			if var_420_15 < arg_417_1.time_ and arg_417_1.time_ <= var_420_15 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_17 = arg_417_1:FormatText(StoryNameCfg[1562].name)

				arg_417_1.leftNameTxt_.text = var_420_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_18 = arg_417_1:GetWordFromCfg(938042101)
				local var_420_19 = arg_417_1:FormatText(var_420_18.content)

				arg_417_1.text_.text = var_420_19

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_20 = 8
				local var_420_21 = utf8.len(var_420_19)
				local var_420_22 = var_420_20 <= 0 and var_420_16 or var_420_16 * (var_420_21 / var_420_20)

				if var_420_22 > 0 and var_420_16 < var_420_22 then
					arg_417_1.talkMaxDuration = var_420_22

					if var_420_22 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_15
					end
				end

				arg_417_1.text_.text = var_420_19
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_23 = math.max(var_420_16, arg_417_1.talkMaxDuration)

			if var_420_15 <= arg_417_1.time_ and arg_417_1.time_ < var_420_15 + var_420_23 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_15) / var_420_23

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_15 + var_420_23 and arg_417_1.time_ < var_420_15 + var_420_23 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play938042102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 938042102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play938042103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10183"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10183 == nil then
				arg_421_1.var_.actorSpriteComps10183 = var_424_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.actorSpriteComps10183 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								local var_424_4 = Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor2.r, var_424_3)
								local var_424_5 = Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor2.g, var_424_3)
								local var_424_6 = Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor2.b, var_424_3)

								iter_424_1.color = Color.New(var_424_4, var_424_5, var_424_6)
							else
								local var_424_7 = Mathf.Lerp(iter_424_1.color.r, 0.5, var_424_3)

								iter_424_1.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10183 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_424_3 then
						if arg_421_1.isInRecall_ then
							iter_424_3.color = arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_424_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps10183 = nil
			end

			local var_424_8 = 0
			local var_424_9 = 0.65

			if var_424_8 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_10 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_11 = arg_421_1:GetWordFromCfg(938042102)
				local var_424_12 = arg_421_1:FormatText(var_424_11.content)

				arg_421_1.text_.text = var_424_12

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_13 = 26
				local var_424_14 = utf8.len(var_424_12)
				local var_424_15 = var_424_13 <= 0 and var_424_9 or var_424_9 * (var_424_14 / var_424_13)

				if var_424_15 > 0 and var_424_9 < var_424_15 then
					arg_421_1.talkMaxDuration = var_424_15

					if var_424_15 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_15 + var_424_8
					end
				end

				arg_421_1.text_.text = var_424_12
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_16 = math.max(var_424_9, arg_421_1.talkMaxDuration)

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_16 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_8) / var_424_16

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_8 + var_424_16 and arg_421_1.time_ < var_424_8 + var_424_16 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play938042103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 938042103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play938042104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10183"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10183 == nil then
				arg_425_1.var_.actorSpriteComps10183 = var_428_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.actorSpriteComps10183 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								local var_428_4 = Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, var_428_3)
								local var_428_5 = Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, var_428_3)
								local var_428_6 = Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, var_428_3)

								iter_428_1.color = Color.New(var_428_4, var_428_5, var_428_6)
							else
								local var_428_7 = Mathf.Lerp(iter_428_1.color.r, 1, var_428_3)

								iter_428_1.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10183 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_428_3 then
						if arg_425_1.isInRecall_ then
							iter_428_3.color = arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_428_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10183 = nil
			end

			local var_428_8 = arg_425_1.actors_["10183"].transform
			local var_428_9 = 0

			if var_428_9 < arg_425_1.time_ and arg_425_1.time_ <= var_428_9 + arg_428_0 then
				arg_425_1.var_.moveOldPos10183 = var_428_8.localPosition
				var_428_8.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10183", 3)

				local var_428_10 = var_428_8.childCount

				for iter_428_4 = 0, var_428_10 - 1 do
					local var_428_11 = var_428_8:GetChild(iter_428_4)

					if var_428_11.name == "split_5" then
						var_428_11:SetAsLastSibling()
						var_428_11.gameObject:SetActive(true)

						arg_425_1.var_.actorSpriteSplit10183 = var_428_11.gameObject:GetComponent(typeof(Image))

						arg_425_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_428_12 = 0.5

			if var_428_9 <= arg_425_1.time_ and arg_425_1.time_ < var_428_9 + var_428_12 then
				local var_428_13 = (arg_425_1.time_ - var_428_9) / var_428_12
				local var_428_14 = Vector3.New(0, -475, -325)

				var_428_8.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10183, var_428_14, var_428_13)

				if arg_425_1.var_.actorSpriteSplit10183 ~= nil then
					arg_425_1.var_.actorSpriteSplit10183:SetAlpha(var_428_13)
				end
			end

			if arg_425_1.time_ >= var_428_9 + var_428_12 and arg_425_1.time_ < var_428_9 + var_428_12 + arg_428_0 then
				var_428_8.localPosition = Vector3.New(0, -475, -325)

				if arg_425_1.var_.actorSpriteSplit10183 ~= nil then
					arg_425_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_428_15 = 0
			local var_428_16 = 0.95

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[1562].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(938042103)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 38
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_23 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_23 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_23

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_23 and arg_425_1.time_ < var_428_15 + var_428_23 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play938042104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 938042104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play938042105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10183"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10183 == nil then
				arg_429_1.var_.actorSpriteComps10183 = var_432_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_2 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.actorSpriteComps10183 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								local var_432_4 = Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor2.r, var_432_3)
								local var_432_5 = Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor2.g, var_432_3)
								local var_432_6 = Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor2.b, var_432_3)

								iter_432_1.color = Color.New(var_432_4, var_432_5, var_432_6)
							else
								local var_432_7 = Mathf.Lerp(iter_432_1.color.r, 0.5, var_432_3)

								iter_432_1.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10183 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_432_3 then
						if arg_429_1.isInRecall_ then
							iter_432_3.color = arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_432_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_429_1.var_.actorSpriteComps10183 = nil
			end

			local var_432_8 = 0
			local var_432_9 = 0.2

			if var_432_8 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_10 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_11 = arg_429_1:GetWordFromCfg(938042104)
				local var_432_12 = arg_429_1:FormatText(var_432_11.content)

				arg_429_1.text_.text = var_432_12

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_13 = 8
				local var_432_14 = utf8.len(var_432_12)
				local var_432_15 = var_432_13 <= 0 and var_432_9 or var_432_9 * (var_432_14 / var_432_13)

				if var_432_15 > 0 and var_432_9 < var_432_15 then
					arg_429_1.talkMaxDuration = var_432_15

					if var_432_15 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_15 + var_432_8
					end
				end

				arg_429_1.text_.text = var_432_12
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_9, arg_429_1.talkMaxDuration)

			if var_432_8 <= arg_429_1.time_ and arg_429_1.time_ < var_432_8 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_8) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_8 + var_432_16 and arg_429_1.time_ < var_432_8 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play938042105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 938042105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play938042106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["10183"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10183 == nil then
				arg_433_1.var_.actorSpriteComps10183 = var_436_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_2 = 0.2

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.actorSpriteComps10183 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								local var_436_4 = Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor1.r, var_436_3)
								local var_436_5 = Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor1.g, var_436_3)
								local var_436_6 = Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor1.b, var_436_3)

								iter_436_1.color = Color.New(var_436_4, var_436_5, var_436_6)
							else
								local var_436_7 = Mathf.Lerp(iter_436_1.color.r, 1, var_436_3)

								iter_436_1.color = Color.New(var_436_7, var_436_7, var_436_7)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10183 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_436_3 then
						if arg_433_1.isInRecall_ then
							iter_436_3.color = arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_436_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_433_1.var_.actorSpriteComps10183 = nil
			end

			local var_436_8 = arg_433_1.actors_["10183"].transform
			local var_436_9 = 0

			if var_436_9 < arg_433_1.time_ and arg_433_1.time_ <= var_436_9 + arg_436_0 then
				arg_433_1.var_.moveOldPos10183 = var_436_8.localPosition
				var_436_8.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10183", 3)

				local var_436_10 = var_436_8.childCount

				for iter_436_4 = 0, var_436_10 - 1 do
					local var_436_11 = var_436_8:GetChild(iter_436_4)

					if var_436_11.name == "split_3" then
						var_436_11:SetAsLastSibling()
						var_436_11.gameObject:SetActive(true)

						arg_433_1.var_.actorSpriteSplit10183 = var_436_11.gameObject:GetComponent(typeof(Image))

						arg_433_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_436_12 = 0.5

			if var_436_9 <= arg_433_1.time_ and arg_433_1.time_ < var_436_9 + var_436_12 then
				local var_436_13 = (arg_433_1.time_ - var_436_9) / var_436_12
				local var_436_14 = Vector3.New(0, -475, -325)

				var_436_8.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10183, var_436_14, var_436_13)

				if arg_433_1.var_.actorSpriteSplit10183 ~= nil then
					arg_433_1.var_.actorSpriteSplit10183:SetAlpha(var_436_13)
				end
			end

			if arg_433_1.time_ >= var_436_9 + var_436_12 and arg_433_1.time_ < var_436_9 + var_436_12 + arg_436_0 then
				var_436_8.localPosition = Vector3.New(0, -475, -325)

				if arg_433_1.var_.actorSpriteSplit10183 ~= nil then
					arg_433_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_436_15 = 0
			local var_436_16 = 0.875

			if var_436_15 < arg_433_1.time_ and arg_433_1.time_ <= var_436_15 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_17 = arg_433_1:FormatText(StoryNameCfg[1562].name)

				arg_433_1.leftNameTxt_.text = var_436_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_18 = arg_433_1:GetWordFromCfg(938042105)
				local var_436_19 = arg_433_1:FormatText(var_436_18.content)

				arg_433_1.text_.text = var_436_19

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_20 = 35
				local var_436_21 = utf8.len(var_436_19)
				local var_436_22 = var_436_20 <= 0 and var_436_16 or var_436_16 * (var_436_21 / var_436_20)

				if var_436_22 > 0 and var_436_16 < var_436_22 then
					arg_433_1.talkMaxDuration = var_436_22

					if var_436_22 + var_436_15 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_22 + var_436_15
					end
				end

				arg_433_1.text_.text = var_436_19
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_23 = math.max(var_436_16, arg_433_1.talkMaxDuration)

			if var_436_15 <= arg_433_1.time_ and arg_433_1.time_ < var_436_15 + var_436_23 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_15) / var_436_23

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_15 + var_436_23 and arg_433_1.time_ < var_436_15 + var_436_23 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play938042106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 938042106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play938042107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["10183"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10183 == nil then
				arg_437_1.var_.actorSpriteComps10183 = var_440_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_2 = 0.2

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.actorSpriteComps10183 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								local var_440_4 = Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor2.r, var_440_3)
								local var_440_5 = Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor2.g, var_440_3)
								local var_440_6 = Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor2.b, var_440_3)

								iter_440_1.color = Color.New(var_440_4, var_440_5, var_440_6)
							else
								local var_440_7 = Mathf.Lerp(iter_440_1.color.r, 0.5, var_440_3)

								iter_440_1.color = Color.New(var_440_7, var_440_7, var_440_7)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10183 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_440_3 then
						if arg_437_1.isInRecall_ then
							iter_440_3.color = arg_437_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_440_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_437_1.var_.actorSpriteComps10183 = nil
			end

			local var_440_8 = 0
			local var_440_9 = 1.075

			if var_440_8 < arg_437_1.time_ and arg_437_1.time_ <= var_440_8 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_10 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_11 = arg_437_1:GetWordFromCfg(938042106)
				local var_440_12 = arg_437_1:FormatText(var_440_11.content)

				arg_437_1.text_.text = var_440_12

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_13 = 43
				local var_440_14 = utf8.len(var_440_12)
				local var_440_15 = var_440_13 <= 0 and var_440_9 or var_440_9 * (var_440_14 / var_440_13)

				if var_440_15 > 0 and var_440_9 < var_440_15 then
					arg_437_1.talkMaxDuration = var_440_15

					if var_440_15 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_15 + var_440_8
					end
				end

				arg_437_1.text_.text = var_440_12
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_16 = math.max(var_440_9, arg_437_1.talkMaxDuration)

			if var_440_8 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_16 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_16

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_16 and arg_437_1.time_ < var_440_8 + var_440_16 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play938042107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 938042107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play938042108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.75

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(938042107)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 30
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play938042108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 938042108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play938042109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["10183"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.actorSpriteComps10183 == nil then
				arg_445_1.var_.actorSpriteComps10183 = var_448_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_2 = 0.2

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.actorSpriteComps10183 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_448_1 then
							if arg_445_1.isInRecall_ then
								local var_448_4 = Mathf.Lerp(iter_448_1.color.r, arg_445_1.hightColor1.r, var_448_3)
								local var_448_5 = Mathf.Lerp(iter_448_1.color.g, arg_445_1.hightColor1.g, var_448_3)
								local var_448_6 = Mathf.Lerp(iter_448_1.color.b, arg_445_1.hightColor1.b, var_448_3)

								iter_448_1.color = Color.New(var_448_4, var_448_5, var_448_6)
							else
								local var_448_7 = Mathf.Lerp(iter_448_1.color.r, 1, var_448_3)

								iter_448_1.color = Color.New(var_448_7, var_448_7, var_448_7)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.actorSpriteComps10183 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_448_3 then
						if arg_445_1.isInRecall_ then
							iter_448_3.color = arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_448_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_445_1.var_.actorSpriteComps10183 = nil
			end

			local var_448_8 = arg_445_1.actors_["10183"].transform
			local var_448_9 = 0

			if var_448_9 < arg_445_1.time_ and arg_445_1.time_ <= var_448_9 + arg_448_0 then
				arg_445_1.var_.moveOldPos10183 = var_448_8.localPosition
				var_448_8.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10183", 3)

				local var_448_10 = var_448_8.childCount

				for iter_448_4 = 0, var_448_10 - 1 do
					local var_448_11 = var_448_8:GetChild(iter_448_4)

					if var_448_11.name == "split_1" then
						var_448_11:SetAsLastSibling()
						var_448_11.gameObject:SetActive(true)

						arg_445_1.var_.actorSpriteSplit10183 = var_448_11.gameObject:GetComponent(typeof(Image))

						arg_445_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_448_12 = 0.5

			if var_448_9 <= arg_445_1.time_ and arg_445_1.time_ < var_448_9 + var_448_12 then
				local var_448_13 = (arg_445_1.time_ - var_448_9) / var_448_12
				local var_448_14 = Vector3.New(0, -475, -325)

				var_448_8.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10183, var_448_14, var_448_13)

				if arg_445_1.var_.actorSpriteSplit10183 ~= nil then
					arg_445_1.var_.actorSpriteSplit10183:SetAlpha(var_448_13)
				end
			end

			if arg_445_1.time_ >= var_448_9 + var_448_12 and arg_445_1.time_ < var_448_9 + var_448_12 + arg_448_0 then
				var_448_8.localPosition = Vector3.New(0, -475, -325)

				if arg_445_1.var_.actorSpriteSplit10183 ~= nil then
					arg_445_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_448_15 = 0
			local var_448_16 = 1.05

			if var_448_15 < arg_445_1.time_ and arg_445_1.time_ <= var_448_15 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_17 = arg_445_1:FormatText(StoryNameCfg[1562].name)

				arg_445_1.leftNameTxt_.text = var_448_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_18 = arg_445_1:GetWordFromCfg(938042108)
				local var_448_19 = arg_445_1:FormatText(var_448_18.content)

				arg_445_1.text_.text = var_448_19

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_20 = 42
				local var_448_21 = utf8.len(var_448_19)
				local var_448_22 = var_448_20 <= 0 and var_448_16 or var_448_16 * (var_448_21 / var_448_20)

				if var_448_22 > 0 and var_448_16 < var_448_22 then
					arg_445_1.talkMaxDuration = var_448_22

					if var_448_22 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_22 + var_448_15
					end
				end

				arg_445_1.text_.text = var_448_19
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_23 = math.max(var_448_16, arg_445_1.talkMaxDuration)

			if var_448_15 <= arg_445_1.time_ and arg_445_1.time_ < var_448_15 + var_448_23 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_15) / var_448_23

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_15 + var_448_23 and arg_445_1.time_ < var_448_15 + var_448_23 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play938042109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 938042109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play938042110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10183"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10183 == nil then
				arg_449_1.var_.actorSpriteComps10183 = var_452_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.actorSpriteComps10183 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								local var_452_4 = Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor2.r, var_452_3)
								local var_452_5 = Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor2.g, var_452_3)
								local var_452_6 = Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor2.b, var_452_3)

								iter_452_1.color = Color.New(var_452_4, var_452_5, var_452_6)
							else
								local var_452_7 = Mathf.Lerp(iter_452_1.color.r, 0.5, var_452_3)

								iter_452_1.color = Color.New(var_452_7, var_452_7, var_452_7)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10183 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_452_3 then
						if arg_449_1.isInRecall_ then
							iter_452_3.color = arg_449_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_452_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_449_1.var_.actorSpriteComps10183 = nil
			end

			local var_452_8 = 0
			local var_452_9 = 0.175

			if var_452_8 < arg_449_1.time_ and arg_449_1.time_ <= var_452_8 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_10 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_11 = arg_449_1:GetWordFromCfg(938042109)
				local var_452_12 = arg_449_1:FormatText(var_452_11.content)

				arg_449_1.text_.text = var_452_12

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_13 = 7
				local var_452_14 = utf8.len(var_452_12)
				local var_452_15 = var_452_13 <= 0 and var_452_9 or var_452_9 * (var_452_14 / var_452_13)

				if var_452_15 > 0 and var_452_9 < var_452_15 then
					arg_449_1.talkMaxDuration = var_452_15

					if var_452_15 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_15 + var_452_8
					end
				end

				arg_449_1.text_.text = var_452_12
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_16 = math.max(var_452_9, arg_449_1.talkMaxDuration)

			if var_452_8 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_16 and arg_449_1.time_ < var_452_8 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play938042110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 938042110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play938042111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["10183"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10183 == nil then
				arg_453_1.var_.actorSpriteComps10183 = var_456_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_2 = 0.2

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.actorSpriteComps10183 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								local var_456_4 = Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor1.r, var_456_3)
								local var_456_5 = Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor1.g, var_456_3)
								local var_456_6 = Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor1.b, var_456_3)

								iter_456_1.color = Color.New(var_456_4, var_456_5, var_456_6)
							else
								local var_456_7 = Mathf.Lerp(iter_456_1.color.r, 1, var_456_3)

								iter_456_1.color = Color.New(var_456_7, var_456_7, var_456_7)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10183 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_456_3 then
						if arg_453_1.isInRecall_ then
							iter_456_3.color = arg_453_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_456_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_453_1.var_.actorSpriteComps10183 = nil
			end

			local var_456_8 = arg_453_1.actors_["10183"].transform
			local var_456_9 = 0

			if var_456_9 < arg_453_1.time_ and arg_453_1.time_ <= var_456_9 + arg_456_0 then
				arg_453_1.var_.moveOldPos10183 = var_456_8.localPosition
				var_456_8.localScale = Vector3.New(1, 1, 1)

				arg_453_1:CheckSpriteTmpPos("10183", 3)

				local var_456_10 = var_456_8.childCount

				for iter_456_4 = 0, var_456_10 - 1 do
					local var_456_11 = var_456_8:GetChild(iter_456_4)

					if var_456_11.name == "" or not string.find(var_456_11.name, "split") then
						var_456_11.gameObject:SetActive(true)
					else
						var_456_11.gameObject:SetActive(false)
					end
				end
			end

			local var_456_12 = 0.001

			if var_456_9 <= arg_453_1.time_ and arg_453_1.time_ < var_456_9 + var_456_12 then
				local var_456_13 = (arg_453_1.time_ - var_456_9) / var_456_12
				local var_456_14 = Vector3.New(0, -475, -325)

				var_456_8.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10183, var_456_14, var_456_13)
			end

			if arg_453_1.time_ >= var_456_9 + var_456_12 and arg_453_1.time_ < var_456_9 + var_456_12 + arg_456_0 then
				var_456_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_456_15 = 0
			local var_456_16 = 0.525

			if var_456_15 < arg_453_1.time_ and arg_453_1.time_ <= var_456_15 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_17 = arg_453_1:FormatText(StoryNameCfg[1562].name)

				arg_453_1.leftNameTxt_.text = var_456_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_18 = arg_453_1:GetWordFromCfg(938042110)
				local var_456_19 = arg_453_1:FormatText(var_456_18.content)

				arg_453_1.text_.text = var_456_19

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_20 = 21
				local var_456_21 = utf8.len(var_456_19)
				local var_456_22 = var_456_20 <= 0 and var_456_16 or var_456_16 * (var_456_21 / var_456_20)

				if var_456_22 > 0 and var_456_16 < var_456_22 then
					arg_453_1.talkMaxDuration = var_456_22

					if var_456_22 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_22 + var_456_15
					end
				end

				arg_453_1.text_.text = var_456_19
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_23 = math.max(var_456_16, arg_453_1.talkMaxDuration)

			if var_456_15 <= arg_453_1.time_ and arg_453_1.time_ < var_456_15 + var_456_23 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_15) / var_456_23

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_15 + var_456_23 and arg_453_1.time_ < var_456_15 + var_456_23 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play938042111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 938042111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play938042112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["10183"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10183 == nil then
				arg_457_1.var_.actorSpriteComps10183 = var_460_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_2 = 0.2

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.actorSpriteComps10183 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_460_1 then
							if arg_457_1.isInRecall_ then
								local var_460_4 = Mathf.Lerp(iter_460_1.color.r, arg_457_1.hightColor2.r, var_460_3)
								local var_460_5 = Mathf.Lerp(iter_460_1.color.g, arg_457_1.hightColor2.g, var_460_3)
								local var_460_6 = Mathf.Lerp(iter_460_1.color.b, arg_457_1.hightColor2.b, var_460_3)

								iter_460_1.color = Color.New(var_460_4, var_460_5, var_460_6)
							else
								local var_460_7 = Mathf.Lerp(iter_460_1.color.r, 0.5, var_460_3)

								iter_460_1.color = Color.New(var_460_7, var_460_7, var_460_7)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10183 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_460_3 then
						if arg_457_1.isInRecall_ then
							iter_460_3.color = arg_457_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_460_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_457_1.var_.actorSpriteComps10183 = nil
			end

			local var_460_8 = 0
			local var_460_9 = 0.275

			if var_460_8 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_10 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_11 = arg_457_1:GetWordFromCfg(938042111)
				local var_460_12 = arg_457_1:FormatText(var_460_11.content)

				arg_457_1.text_.text = var_460_12

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_13 = 11
				local var_460_14 = utf8.len(var_460_12)
				local var_460_15 = var_460_13 <= 0 and var_460_9 or var_460_9 * (var_460_14 / var_460_13)

				if var_460_15 > 0 and var_460_9 < var_460_15 then
					arg_457_1.talkMaxDuration = var_460_15

					if var_460_15 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_15 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_12
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_8) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_8 + var_460_16 and arg_457_1.time_ < var_460_8 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play938042112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 938042112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play938042113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10183"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.actorSpriteComps10183 == nil then
				arg_461_1.var_.actorSpriteComps10183 = var_464_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_2 = 0.2

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.actorSpriteComps10183 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								local var_464_4 = Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, var_464_3)
								local var_464_5 = Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, var_464_3)
								local var_464_6 = Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, var_464_3)

								iter_464_1.color = Color.New(var_464_4, var_464_5, var_464_6)
							else
								local var_464_7 = Mathf.Lerp(iter_464_1.color.r, 1, var_464_3)

								iter_464_1.color = Color.New(var_464_7, var_464_7, var_464_7)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.actorSpriteComps10183 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_464_3 then
						if arg_461_1.isInRecall_ then
							iter_464_3.color = arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_464_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_461_1.var_.actorSpriteComps10183 = nil
			end

			local var_464_8 = arg_461_1.actors_["10183"].transform
			local var_464_9 = 0

			if var_464_9 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.var_.moveOldPos10183 = var_464_8.localPosition
				var_464_8.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10183", 3)

				local var_464_10 = var_464_8.childCount

				for iter_464_4 = 0, var_464_10 - 1 do
					local var_464_11 = var_464_8:GetChild(iter_464_4)

					if var_464_11.name == "split_5" or not string.find(var_464_11.name, "split") then
						var_464_11.gameObject:SetActive(true)
					else
						var_464_11.gameObject:SetActive(false)
					end
				end
			end

			local var_464_12 = 0.001

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_12 then
				local var_464_13 = (arg_461_1.time_ - var_464_9) / var_464_12
				local var_464_14 = Vector3.New(0, -475, -325)

				var_464_8.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10183, var_464_14, var_464_13)
			end

			if arg_461_1.time_ >= var_464_9 + var_464_12 and arg_461_1.time_ < var_464_9 + var_464_12 + arg_464_0 then
				var_464_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_464_15 = 0
			local var_464_16 = 1.2

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_17 = arg_461_1:FormatText(StoryNameCfg[1562].name)

				arg_461_1.leftNameTxt_.text = var_464_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_18 = arg_461_1:GetWordFromCfg(938042112)
				local var_464_19 = arg_461_1:FormatText(var_464_18.content)

				arg_461_1.text_.text = var_464_19

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_20 = 48
				local var_464_21 = utf8.len(var_464_19)
				local var_464_22 = var_464_20 <= 0 and var_464_16 or var_464_16 * (var_464_21 / var_464_20)

				if var_464_22 > 0 and var_464_16 < var_464_22 then
					arg_461_1.talkMaxDuration = var_464_22

					if var_464_22 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_22 + var_464_15
					end
				end

				arg_461_1.text_.text = var_464_19
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_23 = math.max(var_464_16, arg_461_1.talkMaxDuration)

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_23 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_15) / var_464_23

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_15 + var_464_23 and arg_461_1.time_ < var_464_15 + var_464_23 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play938042113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 938042113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play938042114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10183"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10183 == nil then
				arg_465_1.var_.actorSpriteComps10183 = var_468_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_2 = 0.2

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.actorSpriteComps10183 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								local var_468_4 = Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, var_468_3)
								local var_468_5 = Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, var_468_3)
								local var_468_6 = Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, var_468_3)

								iter_468_1.color = Color.New(var_468_4, var_468_5, var_468_6)
							else
								local var_468_7 = Mathf.Lerp(iter_468_1.color.r, 0.5, var_468_3)

								iter_468_1.color = Color.New(var_468_7, var_468_7, var_468_7)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10183 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_468_3 then
						if arg_465_1.isInRecall_ then
							iter_468_3.color = arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_468_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_465_1.var_.actorSpriteComps10183 = nil
			end

			local var_468_8 = 0
			local var_468_9 = 0.35

			if var_468_8 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_10 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_11 = arg_465_1:GetWordFromCfg(938042113)
				local var_468_12 = arg_465_1:FormatText(var_468_11.content)

				arg_465_1.text_.text = var_468_12

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_13 = 14
				local var_468_14 = utf8.len(var_468_12)
				local var_468_15 = var_468_13 <= 0 and var_468_9 or var_468_9 * (var_468_14 / var_468_13)

				if var_468_15 > 0 and var_468_9 < var_468_15 then
					arg_465_1.talkMaxDuration = var_468_15

					if var_468_15 + var_468_8 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_15 + var_468_8
					end
				end

				arg_465_1.text_.text = var_468_12
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_16 = math.max(var_468_9, arg_465_1.talkMaxDuration)

			if var_468_8 <= arg_465_1.time_ and arg_465_1.time_ < var_468_8 + var_468_16 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_8) / var_468_16

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_8 + var_468_16 and arg_465_1.time_ < var_468_8 + var_468_16 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play938042114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 938042114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play938042115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["10183"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.actorSpriteComps10183 == nil then
				arg_469_1.var_.actorSpriteComps10183 = var_472_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_2 = 0.2

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.actorSpriteComps10183 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_472_1 then
							if arg_469_1.isInRecall_ then
								local var_472_4 = Mathf.Lerp(iter_472_1.color.r, arg_469_1.hightColor1.r, var_472_3)
								local var_472_5 = Mathf.Lerp(iter_472_1.color.g, arg_469_1.hightColor1.g, var_472_3)
								local var_472_6 = Mathf.Lerp(iter_472_1.color.b, arg_469_1.hightColor1.b, var_472_3)

								iter_472_1.color = Color.New(var_472_4, var_472_5, var_472_6)
							else
								local var_472_7 = Mathf.Lerp(iter_472_1.color.r, 1, var_472_3)

								iter_472_1.color = Color.New(var_472_7, var_472_7, var_472_7)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.actorSpriteComps10183 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_472_3 then
						if arg_469_1.isInRecall_ then
							iter_472_3.color = arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_472_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_469_1.var_.actorSpriteComps10183 = nil
			end

			local var_472_8 = arg_469_1.actors_["10183"].transform
			local var_472_9 = 0

			if var_472_9 < arg_469_1.time_ and arg_469_1.time_ <= var_472_9 + arg_472_0 then
				arg_469_1.var_.moveOldPos10183 = var_472_8.localPosition
				var_472_8.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10183", 3)

				local var_472_10 = var_472_8.childCount

				for iter_472_4 = 0, var_472_10 - 1 do
					local var_472_11 = var_472_8:GetChild(iter_472_4)

					if var_472_11.name == "split_1" then
						var_472_11:SetAsLastSibling()
						var_472_11.gameObject:SetActive(true)

						arg_469_1.var_.actorSpriteSplit10183 = var_472_11.gameObject:GetComponent(typeof(Image))

						arg_469_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_472_12 = 0.5

			if var_472_9 <= arg_469_1.time_ and arg_469_1.time_ < var_472_9 + var_472_12 then
				local var_472_13 = (arg_469_1.time_ - var_472_9) / var_472_12
				local var_472_14 = Vector3.New(0, -475, -325)

				var_472_8.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10183, var_472_14, var_472_13)

				if arg_469_1.var_.actorSpriteSplit10183 ~= nil then
					arg_469_1.var_.actorSpriteSplit10183:SetAlpha(var_472_13)
				end
			end

			if arg_469_1.time_ >= var_472_9 + var_472_12 and arg_469_1.time_ < var_472_9 + var_472_12 + arg_472_0 then
				var_472_8.localPosition = Vector3.New(0, -475, -325)

				if arg_469_1.var_.actorSpriteSplit10183 ~= nil then
					arg_469_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_472_15 = 0
			local var_472_16 = 1.35

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[1562].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(938042114)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 54
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_23 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_23 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_23

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_23 and arg_469_1.time_ < var_472_15 + var_472_23 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play938042115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 938042115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play938042116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10183"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.actorSpriteComps10183 == nil then
				arg_473_1.var_.actorSpriteComps10183 = var_476_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_2 = 0.2

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.actorSpriteComps10183 then
					for iter_476_0, iter_476_1 in pairs(arg_473_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_476_1 then
							if arg_473_1.isInRecall_ then
								local var_476_4 = Mathf.Lerp(iter_476_1.color.r, arg_473_1.hightColor2.r, var_476_3)
								local var_476_5 = Mathf.Lerp(iter_476_1.color.g, arg_473_1.hightColor2.g, var_476_3)
								local var_476_6 = Mathf.Lerp(iter_476_1.color.b, arg_473_1.hightColor2.b, var_476_3)

								iter_476_1.color = Color.New(var_476_4, var_476_5, var_476_6)
							else
								local var_476_7 = Mathf.Lerp(iter_476_1.color.r, 0.5, var_476_3)

								iter_476_1.color = Color.New(var_476_7, var_476_7, var_476_7)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.actorSpriteComps10183 then
				for iter_476_2, iter_476_3 in pairs(arg_473_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_476_3 then
						if arg_473_1.isInRecall_ then
							iter_476_3.color = arg_473_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_476_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_473_1.var_.actorSpriteComps10183 = nil
			end

			local var_476_8 = 0
			local var_476_9 = 0.475

			if var_476_8 < arg_473_1.time_ and arg_473_1.time_ <= var_476_8 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_10 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_11 = arg_473_1:GetWordFromCfg(938042115)
				local var_476_12 = arg_473_1:FormatText(var_476_11.content)

				arg_473_1.text_.text = var_476_12

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_13 = 19
				local var_476_14 = utf8.len(var_476_12)
				local var_476_15 = var_476_13 <= 0 and var_476_9 or var_476_9 * (var_476_14 / var_476_13)

				if var_476_15 > 0 and var_476_9 < var_476_15 then
					arg_473_1.talkMaxDuration = var_476_15

					if var_476_15 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_15 + var_476_8
					end
				end

				arg_473_1.text_.text = var_476_12
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_16 = math.max(var_476_9, arg_473_1.talkMaxDuration)

			if var_476_8 <= arg_473_1.time_ and arg_473_1.time_ < var_476_8 + var_476_16 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_8) / var_476_16

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_8 + var_476_16 and arg_473_1.time_ < var_476_8 + var_476_16 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play938042116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 938042116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play938042117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10183"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10183 == nil then
				arg_477_1.var_.actorSpriteComps10183 = var_480_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.actorSpriteComps10183 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_480_1 then
							if arg_477_1.isInRecall_ then
								local var_480_4 = Mathf.Lerp(iter_480_1.color.r, arg_477_1.hightColor1.r, var_480_3)
								local var_480_5 = Mathf.Lerp(iter_480_1.color.g, arg_477_1.hightColor1.g, var_480_3)
								local var_480_6 = Mathf.Lerp(iter_480_1.color.b, arg_477_1.hightColor1.b, var_480_3)

								iter_480_1.color = Color.New(var_480_4, var_480_5, var_480_6)
							else
								local var_480_7 = Mathf.Lerp(iter_480_1.color.r, 1, var_480_3)

								iter_480_1.color = Color.New(var_480_7, var_480_7, var_480_7)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10183 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_480_3 then
						if arg_477_1.isInRecall_ then
							iter_480_3.color = arg_477_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_480_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_477_1.var_.actorSpriteComps10183 = nil
			end

			local var_480_8 = arg_477_1.actors_["10183"].transform
			local var_480_9 = 0

			if var_480_9 < arg_477_1.time_ and arg_477_1.time_ <= var_480_9 + arg_480_0 then
				arg_477_1.var_.moveOldPos10183 = var_480_8.localPosition
				var_480_8.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10183", 3)

				local var_480_10 = var_480_8.childCount

				for iter_480_4 = 0, var_480_10 - 1 do
					local var_480_11 = var_480_8:GetChild(iter_480_4)

					if var_480_11.name == "" or not string.find(var_480_11.name, "split") then
						var_480_11.gameObject:SetActive(true)
					else
						var_480_11.gameObject:SetActive(false)
					end
				end
			end

			local var_480_12 = 0.001

			if var_480_9 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_12 then
				local var_480_13 = (arg_477_1.time_ - var_480_9) / var_480_12
				local var_480_14 = Vector3.New(0, -475, -325)

				var_480_8.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10183, var_480_14, var_480_13)
			end

			if arg_477_1.time_ >= var_480_9 + var_480_12 and arg_477_1.time_ < var_480_9 + var_480_12 + arg_480_0 then
				var_480_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_480_15 = 0
			local var_480_16 = 0.575

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_17 = arg_477_1:FormatText(StoryNameCfg[1562].name)

				arg_477_1.leftNameTxt_.text = var_480_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_18 = arg_477_1:GetWordFromCfg(938042116)
				local var_480_19 = arg_477_1:FormatText(var_480_18.content)

				arg_477_1.text_.text = var_480_19

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_20 = 23
				local var_480_21 = utf8.len(var_480_19)
				local var_480_22 = var_480_20 <= 0 and var_480_16 or var_480_16 * (var_480_21 / var_480_20)

				if var_480_22 > 0 and var_480_16 < var_480_22 then
					arg_477_1.talkMaxDuration = var_480_22

					if var_480_22 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_22 + var_480_15
					end
				end

				arg_477_1.text_.text = var_480_19
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_23 = math.max(var_480_16, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_23 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_23

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_23 and arg_477_1.time_ < var_480_15 + var_480_23 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play938042117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 938042117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play938042118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["10183"].transform
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.var_.moveOldPos10183 = var_484_0.localPosition
				var_484_0.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10183", 3)

				local var_484_2 = var_484_0.childCount

				for iter_484_0 = 0, var_484_2 - 1 do
					local var_484_3 = var_484_0:GetChild(iter_484_0)

					if var_484_3.name == "" or not string.find(var_484_3.name, "split") then
						var_484_3.gameObject:SetActive(true)
					else
						var_484_3.gameObject:SetActive(false)
					end
				end
			end

			local var_484_4 = 0.001

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_4 then
				local var_484_5 = (arg_481_1.time_ - var_484_1) / var_484_4
				local var_484_6 = Vector3.New(0, -475, -325)

				var_484_0.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10183, var_484_6, var_484_5)
			end

			if arg_481_1.time_ >= var_484_1 + var_484_4 and arg_481_1.time_ < var_484_1 + var_484_4 + arg_484_0 then
				var_484_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_484_7 = 0
			local var_484_8 = 0.8

			if var_484_7 < arg_481_1.time_ and arg_481_1.time_ <= var_484_7 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_9 = arg_481_1:FormatText(StoryNameCfg[1562].name)

				arg_481_1.leftNameTxt_.text = var_484_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_10 = arg_481_1:GetWordFromCfg(938042117)
				local var_484_11 = arg_481_1:FormatText(var_484_10.content)

				arg_481_1.text_.text = var_484_11

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_12 = 32
				local var_484_13 = utf8.len(var_484_11)
				local var_484_14 = var_484_12 <= 0 and var_484_8 or var_484_8 * (var_484_13 / var_484_12)

				if var_484_14 > 0 and var_484_8 < var_484_14 then
					arg_481_1.talkMaxDuration = var_484_14

					if var_484_14 + var_484_7 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_14 + var_484_7
					end
				end

				arg_481_1.text_.text = var_484_11
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_15 = math.max(var_484_8, arg_481_1.talkMaxDuration)

			if var_484_7 <= arg_481_1.time_ and arg_481_1.time_ < var_484_7 + var_484_15 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_7) / var_484_15

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_7 + var_484_15 and arg_481_1.time_ < var_484_7 + var_484_15 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play938042118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 938042118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play938042119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["10183"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.actorSpriteComps10183 == nil then
				arg_485_1.var_.actorSpriteComps10183 = var_488_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_488_2 = 0.2

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.actorSpriteComps10183 then
					for iter_488_0, iter_488_1 in pairs(arg_485_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_488_1 then
							if arg_485_1.isInRecall_ then
								local var_488_4 = Mathf.Lerp(iter_488_1.color.r, arg_485_1.hightColor2.r, var_488_3)
								local var_488_5 = Mathf.Lerp(iter_488_1.color.g, arg_485_1.hightColor2.g, var_488_3)
								local var_488_6 = Mathf.Lerp(iter_488_1.color.b, arg_485_1.hightColor2.b, var_488_3)

								iter_488_1.color = Color.New(var_488_4, var_488_5, var_488_6)
							else
								local var_488_7 = Mathf.Lerp(iter_488_1.color.r, 0.5, var_488_3)

								iter_488_1.color = Color.New(var_488_7, var_488_7, var_488_7)
							end
						end
					end
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.actorSpriteComps10183 then
				for iter_488_2, iter_488_3 in pairs(arg_485_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_488_3 then
						if arg_485_1.isInRecall_ then
							iter_488_3.color = arg_485_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_488_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_485_1.var_.actorSpriteComps10183 = nil
			end

			local var_488_8 = 0
			local var_488_9 = 0.3

			if var_488_8 < arg_485_1.time_ and arg_485_1.time_ <= var_488_8 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_10 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_11 = arg_485_1:GetWordFromCfg(938042118)
				local var_488_12 = arg_485_1:FormatText(var_488_11.content)

				arg_485_1.text_.text = var_488_12

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_13 = 12
				local var_488_14 = utf8.len(var_488_12)
				local var_488_15 = var_488_13 <= 0 and var_488_9 or var_488_9 * (var_488_14 / var_488_13)

				if var_488_15 > 0 and var_488_9 < var_488_15 then
					arg_485_1.talkMaxDuration = var_488_15

					if var_488_15 + var_488_8 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_15 + var_488_8
					end
				end

				arg_485_1.text_.text = var_488_12
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_16 = math.max(var_488_9, arg_485_1.talkMaxDuration)

			if var_488_8 <= arg_485_1.time_ and arg_485_1.time_ < var_488_8 + var_488_16 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_8) / var_488_16

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_8 + var_488_16 and arg_485_1.time_ < var_488_8 + var_488_16 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play938042119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 938042119
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play938042120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["10183"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.actorSpriteComps10183 == nil then
				arg_489_1.var_.actorSpriteComps10183 = var_492_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_2 = 0.2

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.actorSpriteComps10183 then
					for iter_492_0, iter_492_1 in pairs(arg_489_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_492_1 then
							if arg_489_1.isInRecall_ then
								local var_492_4 = Mathf.Lerp(iter_492_1.color.r, arg_489_1.hightColor1.r, var_492_3)
								local var_492_5 = Mathf.Lerp(iter_492_1.color.g, arg_489_1.hightColor1.g, var_492_3)
								local var_492_6 = Mathf.Lerp(iter_492_1.color.b, arg_489_1.hightColor1.b, var_492_3)

								iter_492_1.color = Color.New(var_492_4, var_492_5, var_492_6)
							else
								local var_492_7 = Mathf.Lerp(iter_492_1.color.r, 1, var_492_3)

								iter_492_1.color = Color.New(var_492_7, var_492_7, var_492_7)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.actorSpriteComps10183 then
				for iter_492_2, iter_492_3 in pairs(arg_489_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_492_3 then
						if arg_489_1.isInRecall_ then
							iter_492_3.color = arg_489_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_492_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_489_1.var_.actorSpriteComps10183 = nil
			end

			local var_492_8 = arg_489_1.actors_["10183"].transform
			local var_492_9 = 0

			if var_492_9 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 then
				arg_489_1.var_.moveOldPos10183 = var_492_8.localPosition
				var_492_8.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10183", 3)

				local var_492_10 = var_492_8.childCount

				for iter_492_4 = 0, var_492_10 - 1 do
					local var_492_11 = var_492_8:GetChild(iter_492_4)

					if var_492_11.name == "split_3" then
						var_492_11:SetAsLastSibling()
						var_492_11.gameObject:SetActive(true)

						arg_489_1.var_.actorSpriteSplit10183 = var_492_11.gameObject:GetComponent(typeof(Image))

						arg_489_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_492_12 = 0.5

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_12 then
				local var_492_13 = (arg_489_1.time_ - var_492_9) / var_492_12
				local var_492_14 = Vector3.New(0, -475, -325)

				var_492_8.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10183, var_492_14, var_492_13)

				if arg_489_1.var_.actorSpriteSplit10183 ~= nil then
					arg_489_1.var_.actorSpriteSplit10183:SetAlpha(var_492_13)
				end
			end

			if arg_489_1.time_ >= var_492_9 + var_492_12 and arg_489_1.time_ < var_492_9 + var_492_12 + arg_492_0 then
				var_492_8.localPosition = Vector3.New(0, -475, -325)

				if arg_489_1.var_.actorSpriteSplit10183 ~= nil then
					arg_489_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_492_15 = 0
			local var_492_16 = 1.25

			if var_492_15 < arg_489_1.time_ and arg_489_1.time_ <= var_492_15 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_17 = arg_489_1:FormatText(StoryNameCfg[1562].name)

				arg_489_1.leftNameTxt_.text = var_492_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_18 = arg_489_1:GetWordFromCfg(938042119)
				local var_492_19 = arg_489_1:FormatText(var_492_18.content)

				arg_489_1.text_.text = var_492_19

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_20 = 50
				local var_492_21 = utf8.len(var_492_19)
				local var_492_22 = var_492_20 <= 0 and var_492_16 or var_492_16 * (var_492_21 / var_492_20)

				if var_492_22 > 0 and var_492_16 < var_492_22 then
					arg_489_1.talkMaxDuration = var_492_22

					if var_492_22 + var_492_15 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_22 + var_492_15
					end
				end

				arg_489_1.text_.text = var_492_19
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_23 = math.max(var_492_16, arg_489_1.talkMaxDuration)

			if var_492_15 <= arg_489_1.time_ and arg_489_1.time_ < var_492_15 + var_492_23 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_15) / var_492_23

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_15 + var_492_23 and arg_489_1.time_ < var_492_15 + var_492_23 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play938042120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 938042120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play938042121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["10183"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.actorSpriteComps10183 == nil then
				arg_493_1.var_.actorSpriteComps10183 = var_496_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.actorSpriteComps10183 then
					for iter_496_0, iter_496_1 in pairs(arg_493_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_496_1 then
							if arg_493_1.isInRecall_ then
								local var_496_4 = Mathf.Lerp(iter_496_1.color.r, arg_493_1.hightColor2.r, var_496_3)
								local var_496_5 = Mathf.Lerp(iter_496_1.color.g, arg_493_1.hightColor2.g, var_496_3)
								local var_496_6 = Mathf.Lerp(iter_496_1.color.b, arg_493_1.hightColor2.b, var_496_3)

								iter_496_1.color = Color.New(var_496_4, var_496_5, var_496_6)
							else
								local var_496_7 = Mathf.Lerp(iter_496_1.color.r, 0.5, var_496_3)

								iter_496_1.color = Color.New(var_496_7, var_496_7, var_496_7)
							end
						end
					end
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.actorSpriteComps10183 then
				for iter_496_2, iter_496_3 in pairs(arg_493_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_496_3 then
						if arg_493_1.isInRecall_ then
							iter_496_3.color = arg_493_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_496_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_493_1.var_.actorSpriteComps10183 = nil
			end

			local var_496_8 = 0
			local var_496_9 = 0.325

			if var_496_8 < arg_493_1.time_ and arg_493_1.time_ <= var_496_8 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_10 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_11 = arg_493_1:GetWordFromCfg(938042120)
				local var_496_12 = arg_493_1:FormatText(var_496_11.content)

				arg_493_1.text_.text = var_496_12

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_13 = 13
				local var_496_14 = utf8.len(var_496_12)
				local var_496_15 = var_496_13 <= 0 and var_496_9 or var_496_9 * (var_496_14 / var_496_13)

				if var_496_15 > 0 and var_496_9 < var_496_15 then
					arg_493_1.talkMaxDuration = var_496_15

					if var_496_15 + var_496_8 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_15 + var_496_8
					end
				end

				arg_493_1.text_.text = var_496_12
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_16 = math.max(var_496_9, arg_493_1.talkMaxDuration)

			if var_496_8 <= arg_493_1.time_ and arg_493_1.time_ < var_496_8 + var_496_16 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_8) / var_496_16

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_8 + var_496_16 and arg_493_1.time_ < var_496_8 + var_496_16 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play938042121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 938042121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play938042122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["10183"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.actorSpriteComps10183 == nil then
				arg_497_1.var_.actorSpriteComps10183 = var_500_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_500_2 = 0.2

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.actorSpriteComps10183 then
					for iter_500_0, iter_500_1 in pairs(arg_497_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_500_1 then
							if arg_497_1.isInRecall_ then
								local var_500_4 = Mathf.Lerp(iter_500_1.color.r, arg_497_1.hightColor1.r, var_500_3)
								local var_500_5 = Mathf.Lerp(iter_500_1.color.g, arg_497_1.hightColor1.g, var_500_3)
								local var_500_6 = Mathf.Lerp(iter_500_1.color.b, arg_497_1.hightColor1.b, var_500_3)

								iter_500_1.color = Color.New(var_500_4, var_500_5, var_500_6)
							else
								local var_500_7 = Mathf.Lerp(iter_500_1.color.r, 1, var_500_3)

								iter_500_1.color = Color.New(var_500_7, var_500_7, var_500_7)
							end
						end
					end
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.actorSpriteComps10183 then
				for iter_500_2, iter_500_3 in pairs(arg_497_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_500_3 then
						if arg_497_1.isInRecall_ then
							iter_500_3.color = arg_497_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_500_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_497_1.var_.actorSpriteComps10183 = nil
			end

			local var_500_8 = arg_497_1.actors_["10183"].transform
			local var_500_9 = 0

			if var_500_9 < arg_497_1.time_ and arg_497_1.time_ <= var_500_9 + arg_500_0 then
				arg_497_1.var_.moveOldPos10183 = var_500_8.localPosition
				var_500_8.localScale = Vector3.New(1, 1, 1)

				arg_497_1:CheckSpriteTmpPos("10183", 3)

				local var_500_10 = var_500_8.childCount

				for iter_500_4 = 0, var_500_10 - 1 do
					local var_500_11 = var_500_8:GetChild(iter_500_4)

					if var_500_11.name == "split_4" or not string.find(var_500_11.name, "split") then
						var_500_11.gameObject:SetActive(true)
					else
						var_500_11.gameObject:SetActive(false)
					end
				end
			end

			local var_500_12 = 0.001

			if var_500_9 <= arg_497_1.time_ and arg_497_1.time_ < var_500_9 + var_500_12 then
				local var_500_13 = (arg_497_1.time_ - var_500_9) / var_500_12
				local var_500_14 = Vector3.New(0, -475, -325)

				var_500_8.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10183, var_500_14, var_500_13)
			end

			if arg_497_1.time_ >= var_500_9 + var_500_12 and arg_497_1.time_ < var_500_9 + var_500_12 + arg_500_0 then
				var_500_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_500_15 = 0
			local var_500_16 = 0.175

			if var_500_15 < arg_497_1.time_ and arg_497_1.time_ <= var_500_15 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_17 = arg_497_1:FormatText(StoryNameCfg[1562].name)

				arg_497_1.leftNameTxt_.text = var_500_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_18 = arg_497_1:GetWordFromCfg(938042121)
				local var_500_19 = arg_497_1:FormatText(var_500_18.content)

				arg_497_1.text_.text = var_500_19

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_20 = 7
				local var_500_21 = utf8.len(var_500_19)
				local var_500_22 = var_500_20 <= 0 and var_500_16 or var_500_16 * (var_500_21 / var_500_20)

				if var_500_22 > 0 and var_500_16 < var_500_22 then
					arg_497_1.talkMaxDuration = var_500_22

					if var_500_22 + var_500_15 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_22 + var_500_15
					end
				end

				arg_497_1.text_.text = var_500_19
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_23 = math.max(var_500_16, arg_497_1.talkMaxDuration)

			if var_500_15 <= arg_497_1.time_ and arg_497_1.time_ < var_500_15 + var_500_23 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_15) / var_500_23

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_15 + var_500_23 and arg_497_1.time_ < var_500_15 + var_500_23 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play938042122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 938042122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play938042123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["10183"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10183 == nil then
				arg_501_1.var_.actorSpriteComps10183 = var_504_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_2 = 0.2

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.actorSpriteComps10183 then
					for iter_504_0, iter_504_1 in pairs(arg_501_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_504_1 then
							if arg_501_1.isInRecall_ then
								local var_504_4 = Mathf.Lerp(iter_504_1.color.r, arg_501_1.hightColor2.r, var_504_3)
								local var_504_5 = Mathf.Lerp(iter_504_1.color.g, arg_501_1.hightColor2.g, var_504_3)
								local var_504_6 = Mathf.Lerp(iter_504_1.color.b, arg_501_1.hightColor2.b, var_504_3)

								iter_504_1.color = Color.New(var_504_4, var_504_5, var_504_6)
							else
								local var_504_7 = Mathf.Lerp(iter_504_1.color.r, 0.5, var_504_3)

								iter_504_1.color = Color.New(var_504_7, var_504_7, var_504_7)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10183 then
				for iter_504_2, iter_504_3 in pairs(arg_501_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_504_3 then
						if arg_501_1.isInRecall_ then
							iter_504_3.color = arg_501_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_504_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_501_1.var_.actorSpriteComps10183 = nil
			end

			local var_504_8 = 0
			local var_504_9 = 0.525

			if var_504_8 < arg_501_1.time_ and arg_501_1.time_ <= var_504_8 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_10 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_11 = arg_501_1:GetWordFromCfg(938042122)
				local var_504_12 = arg_501_1:FormatText(var_504_11.content)

				arg_501_1.text_.text = var_504_12

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_13 = 21
				local var_504_14 = utf8.len(var_504_12)
				local var_504_15 = var_504_13 <= 0 and var_504_9 or var_504_9 * (var_504_14 / var_504_13)

				if var_504_15 > 0 and var_504_9 < var_504_15 then
					arg_501_1.talkMaxDuration = var_504_15

					if var_504_15 + var_504_8 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_15 + var_504_8
					end
				end

				arg_501_1.text_.text = var_504_12
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_16 = math.max(var_504_9, arg_501_1.talkMaxDuration)

			if var_504_8 <= arg_501_1.time_ and arg_501_1.time_ < var_504_8 + var_504_16 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_8) / var_504_16

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_8 + var_504_16 and arg_501_1.time_ < var_504_8 + var_504_16 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play938042123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 938042123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play938042124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["10183"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.actorSpriteComps10183 == nil then
				arg_505_1.var_.actorSpriteComps10183 = var_508_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.actorSpriteComps10183 then
					for iter_508_0, iter_508_1 in pairs(arg_505_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_508_1 then
							if arg_505_1.isInRecall_ then
								local var_508_4 = Mathf.Lerp(iter_508_1.color.r, arg_505_1.hightColor1.r, var_508_3)
								local var_508_5 = Mathf.Lerp(iter_508_1.color.g, arg_505_1.hightColor1.g, var_508_3)
								local var_508_6 = Mathf.Lerp(iter_508_1.color.b, arg_505_1.hightColor1.b, var_508_3)

								iter_508_1.color = Color.New(var_508_4, var_508_5, var_508_6)
							else
								local var_508_7 = Mathf.Lerp(iter_508_1.color.r, 1, var_508_3)

								iter_508_1.color = Color.New(var_508_7, var_508_7, var_508_7)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.actorSpriteComps10183 then
				for iter_508_2, iter_508_3 in pairs(arg_505_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_508_3 then
						if arg_505_1.isInRecall_ then
							iter_508_3.color = arg_505_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_508_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_505_1.var_.actorSpriteComps10183 = nil
			end

			local var_508_8 = arg_505_1.actors_["10183"].transform
			local var_508_9 = 0

			if var_508_9 < arg_505_1.time_ and arg_505_1.time_ <= var_508_9 + arg_508_0 then
				arg_505_1.var_.moveOldPos10183 = var_508_8.localPosition
				var_508_8.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("10183", 3)

				local var_508_10 = var_508_8.childCount

				for iter_508_4 = 0, var_508_10 - 1 do
					local var_508_11 = var_508_8:GetChild(iter_508_4)

					if var_508_11.name == "split_3" then
						var_508_11:SetAsLastSibling()
						var_508_11.gameObject:SetActive(true)

						arg_505_1.var_.actorSpriteSplit10183 = var_508_11.gameObject:GetComponent(typeof(Image))

						arg_505_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_508_12 = 0.5

			if var_508_9 <= arg_505_1.time_ and arg_505_1.time_ < var_508_9 + var_508_12 then
				local var_508_13 = (arg_505_1.time_ - var_508_9) / var_508_12
				local var_508_14 = Vector3.New(0, -475, -325)

				var_508_8.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos10183, var_508_14, var_508_13)

				if arg_505_1.var_.actorSpriteSplit10183 ~= nil then
					arg_505_1.var_.actorSpriteSplit10183:SetAlpha(var_508_13)
				end
			end

			if arg_505_1.time_ >= var_508_9 + var_508_12 and arg_505_1.time_ < var_508_9 + var_508_12 + arg_508_0 then
				var_508_8.localPosition = Vector3.New(0, -475, -325)

				if arg_505_1.var_.actorSpriteSplit10183 ~= nil then
					arg_505_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_508_15 = 0
			local var_508_16 = 0.45

			if var_508_15 < arg_505_1.time_ and arg_505_1.time_ <= var_508_15 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_17 = arg_505_1:FormatText(StoryNameCfg[1562].name)

				arg_505_1.leftNameTxt_.text = var_508_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_18 = arg_505_1:GetWordFromCfg(938042123)
				local var_508_19 = arg_505_1:FormatText(var_508_18.content)

				arg_505_1.text_.text = var_508_19

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_20 = 18
				local var_508_21 = utf8.len(var_508_19)
				local var_508_22 = var_508_20 <= 0 and var_508_16 or var_508_16 * (var_508_21 / var_508_20)

				if var_508_22 > 0 and var_508_16 < var_508_22 then
					arg_505_1.talkMaxDuration = var_508_22

					if var_508_22 + var_508_15 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_22 + var_508_15
					end
				end

				arg_505_1.text_.text = var_508_19
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_23 = math.max(var_508_16, arg_505_1.talkMaxDuration)

			if var_508_15 <= arg_505_1.time_ and arg_505_1.time_ < var_508_15 + var_508_23 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_15) / var_508_23

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_15 + var_508_23 and arg_505_1.time_ < var_508_15 + var_508_23 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play938042124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 938042124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play938042125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["10183"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps10183 == nil then
				arg_509_1.var_.actorSpriteComps10183 = var_512_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_2 = 0.2

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.actorSpriteComps10183 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_512_1 then
							if arg_509_1.isInRecall_ then
								local var_512_4 = Mathf.Lerp(iter_512_1.color.r, arg_509_1.hightColor2.r, var_512_3)
								local var_512_5 = Mathf.Lerp(iter_512_1.color.g, arg_509_1.hightColor2.g, var_512_3)
								local var_512_6 = Mathf.Lerp(iter_512_1.color.b, arg_509_1.hightColor2.b, var_512_3)

								iter_512_1.color = Color.New(var_512_4, var_512_5, var_512_6)
							else
								local var_512_7 = Mathf.Lerp(iter_512_1.color.r, 0.5, var_512_3)

								iter_512_1.color = Color.New(var_512_7, var_512_7, var_512_7)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps10183 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_512_3 then
						if arg_509_1.isInRecall_ then
							iter_512_3.color = arg_509_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_512_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_509_1.var_.actorSpriteComps10183 = nil
			end

			local var_512_8 = 0
			local var_512_9 = 0.575

			if var_512_8 < arg_509_1.time_ and arg_509_1.time_ <= var_512_8 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_10 = arg_509_1:FormatText(StoryNameCfg[7].name)

				arg_509_1.leftNameTxt_.text = var_512_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_11 = arg_509_1:GetWordFromCfg(938042124)
				local var_512_12 = arg_509_1:FormatText(var_512_11.content)

				arg_509_1.text_.text = var_512_12

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_13 = 23
				local var_512_14 = utf8.len(var_512_12)
				local var_512_15 = var_512_13 <= 0 and var_512_9 or var_512_9 * (var_512_14 / var_512_13)

				if var_512_15 > 0 and var_512_9 < var_512_15 then
					arg_509_1.talkMaxDuration = var_512_15

					if var_512_15 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_15 + var_512_8
					end
				end

				arg_509_1.text_.text = var_512_12
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_16 = math.max(var_512_9, arg_509_1.talkMaxDuration)

			if var_512_8 <= arg_509_1.time_ and arg_509_1.time_ < var_512_8 + var_512_16 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_8) / var_512_16

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_8 + var_512_16 and arg_509_1.time_ < var_512_8 + var_512_16 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play938042125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 938042125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play938042126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.425

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(938042125)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 17
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_8 and arg_513_1.time_ < var_516_0 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play938042126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 938042126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play938042127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["10183"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps10183 == nil then
				arg_517_1.var_.actorSpriteComps10183 = var_520_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_2 = 0.2

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.actorSpriteComps10183 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								local var_520_4 = Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor1.r, var_520_3)
								local var_520_5 = Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor1.g, var_520_3)
								local var_520_6 = Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor1.b, var_520_3)

								iter_520_1.color = Color.New(var_520_4, var_520_5, var_520_6)
							else
								local var_520_7 = Mathf.Lerp(iter_520_1.color.r, 1, var_520_3)

								iter_520_1.color = Color.New(var_520_7, var_520_7, var_520_7)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps10183 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_520_3 then
						if arg_517_1.isInRecall_ then
							iter_520_3.color = arg_517_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_520_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_517_1.var_.actorSpriteComps10183 = nil
			end

			local var_520_8 = arg_517_1.actors_["10183"].transform
			local var_520_9 = 0

			if var_520_9 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1.var_.moveOldPos10183 = var_520_8.localPosition
				var_520_8.localScale = Vector3.New(1, 1, 1)

				arg_517_1:CheckSpriteTmpPos("10183", 3)

				local var_520_10 = var_520_8.childCount

				for iter_520_4 = 0, var_520_10 - 1 do
					local var_520_11 = var_520_8:GetChild(iter_520_4)

					if var_520_11.name == "split_8" then
						var_520_11:SetAsLastSibling()
						var_520_11.gameObject:SetActive(true)

						arg_517_1.var_.actorSpriteSplit10183 = var_520_11.gameObject:GetComponent(typeof(Image))

						arg_517_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_520_12 = 0.5

			if var_520_9 <= arg_517_1.time_ and arg_517_1.time_ < var_520_9 + var_520_12 then
				local var_520_13 = (arg_517_1.time_ - var_520_9) / var_520_12
				local var_520_14 = Vector3.New(0, -475, -325)

				var_520_8.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos10183, var_520_14, var_520_13)

				if arg_517_1.var_.actorSpriteSplit10183 ~= nil then
					arg_517_1.var_.actorSpriteSplit10183:SetAlpha(var_520_13)
				end
			end

			if arg_517_1.time_ >= var_520_9 + var_520_12 and arg_517_1.time_ < var_520_9 + var_520_12 + arg_520_0 then
				var_520_8.localPosition = Vector3.New(0, -475, -325)

				if arg_517_1.var_.actorSpriteSplit10183 ~= nil then
					arg_517_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_520_15 = 0
			local var_520_16 = 0.775

			if var_520_15 < arg_517_1.time_ and arg_517_1.time_ <= var_520_15 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_17 = arg_517_1:FormatText(StoryNameCfg[1562].name)

				arg_517_1.leftNameTxt_.text = var_520_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_18 = arg_517_1:GetWordFromCfg(938042126)
				local var_520_19 = arg_517_1:FormatText(var_520_18.content)

				arg_517_1.text_.text = var_520_19

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_20 = 31
				local var_520_21 = utf8.len(var_520_19)
				local var_520_22 = var_520_20 <= 0 and var_520_16 or var_520_16 * (var_520_21 / var_520_20)

				if var_520_22 > 0 and var_520_16 < var_520_22 then
					arg_517_1.talkMaxDuration = var_520_22

					if var_520_22 + var_520_15 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_22 + var_520_15
					end
				end

				arg_517_1.text_.text = var_520_19
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_23 = math.max(var_520_16, arg_517_1.talkMaxDuration)

			if var_520_15 <= arg_517_1.time_ and arg_517_1.time_ < var_520_15 + var_520_23 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_15) / var_520_23

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_15 + var_520_23 and arg_517_1.time_ < var_520_15 + var_520_23 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play938042127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 938042127
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play938042128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["10183"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps10183 == nil then
				arg_521_1.var_.actorSpriteComps10183 = var_524_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.actorSpriteComps10183 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								local var_524_4 = Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor2.r, var_524_3)
								local var_524_5 = Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor2.g, var_524_3)
								local var_524_6 = Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor2.b, var_524_3)

								iter_524_1.color = Color.New(var_524_4, var_524_5, var_524_6)
							else
								local var_524_7 = Mathf.Lerp(iter_524_1.color.r, 0.5, var_524_3)

								iter_524_1.color = Color.New(var_524_7, var_524_7, var_524_7)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps10183 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_524_3 then
						if arg_521_1.isInRecall_ then
							iter_524_3.color = arg_521_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_524_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_521_1.var_.actorSpriteComps10183 = nil
			end

			local var_524_8 = 0
			local var_524_9 = 0.2

			if var_524_8 < arg_521_1.time_ and arg_521_1.time_ <= var_524_8 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_10 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_11 = arg_521_1:GetWordFromCfg(938042127)
				local var_524_12 = arg_521_1:FormatText(var_524_11.content)

				arg_521_1.text_.text = var_524_12

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_13 = 8
				local var_524_14 = utf8.len(var_524_12)
				local var_524_15 = var_524_13 <= 0 and var_524_9 or var_524_9 * (var_524_14 / var_524_13)

				if var_524_15 > 0 and var_524_9 < var_524_15 then
					arg_521_1.talkMaxDuration = var_524_15

					if var_524_15 + var_524_8 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_15 + var_524_8
					end
				end

				arg_521_1.text_.text = var_524_12
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_16 = math.max(var_524_9, arg_521_1.talkMaxDuration)

			if var_524_8 <= arg_521_1.time_ and arg_521_1.time_ < var_524_8 + var_524_16 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_8) / var_524_16

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_8 + var_524_16 and arg_521_1.time_ < var_524_8 + var_524_16 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play938042128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 938042128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play938042129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["10183"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps10183 == nil then
				arg_525_1.var_.actorSpriteComps10183 = var_528_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_2 = 0.2

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.actorSpriteComps10183 then
					for iter_528_0, iter_528_1 in pairs(arg_525_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_528_1 then
							if arg_525_1.isInRecall_ then
								local var_528_4 = Mathf.Lerp(iter_528_1.color.r, arg_525_1.hightColor1.r, var_528_3)
								local var_528_5 = Mathf.Lerp(iter_528_1.color.g, arg_525_1.hightColor1.g, var_528_3)
								local var_528_6 = Mathf.Lerp(iter_528_1.color.b, arg_525_1.hightColor1.b, var_528_3)

								iter_528_1.color = Color.New(var_528_4, var_528_5, var_528_6)
							else
								local var_528_7 = Mathf.Lerp(iter_528_1.color.r, 1, var_528_3)

								iter_528_1.color = Color.New(var_528_7, var_528_7, var_528_7)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps10183 then
				for iter_528_2, iter_528_3 in pairs(arg_525_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_528_3 then
						if arg_525_1.isInRecall_ then
							iter_528_3.color = arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_528_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps10183 = nil
			end

			local var_528_8 = arg_525_1.actors_["10183"].transform
			local var_528_9 = 0

			if var_528_9 < arg_525_1.time_ and arg_525_1.time_ <= var_528_9 + arg_528_0 then
				arg_525_1.var_.moveOldPos10183 = var_528_8.localPosition
				var_528_8.localScale = Vector3.New(1, 1, 1)

				arg_525_1:CheckSpriteTmpPos("10183", 3)

				local var_528_10 = var_528_8.childCount

				for iter_528_4 = 0, var_528_10 - 1 do
					local var_528_11 = var_528_8:GetChild(iter_528_4)

					if var_528_11.name == "split_1" then
						var_528_11:SetAsLastSibling()
						var_528_11.gameObject:SetActive(true)

						arg_525_1.var_.actorSpriteSplit10183 = var_528_11.gameObject:GetComponent(typeof(Image))

						arg_525_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_528_12 = 0.5

			if var_528_9 <= arg_525_1.time_ and arg_525_1.time_ < var_528_9 + var_528_12 then
				local var_528_13 = (arg_525_1.time_ - var_528_9) / var_528_12
				local var_528_14 = Vector3.New(0, -475, -325)

				var_528_8.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10183, var_528_14, var_528_13)

				if arg_525_1.var_.actorSpriteSplit10183 ~= nil then
					arg_525_1.var_.actorSpriteSplit10183:SetAlpha(var_528_13)
				end
			end

			if arg_525_1.time_ >= var_528_9 + var_528_12 and arg_525_1.time_ < var_528_9 + var_528_12 + arg_528_0 then
				var_528_8.localPosition = Vector3.New(0, -475, -325)

				if arg_525_1.var_.actorSpriteSplit10183 ~= nil then
					arg_525_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_528_15 = 0
			local var_528_16 = 0.7

			if var_528_15 < arg_525_1.time_ and arg_525_1.time_ <= var_528_15 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_17 = arg_525_1:FormatText(StoryNameCfg[1562].name)

				arg_525_1.leftNameTxt_.text = var_528_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_18 = arg_525_1:GetWordFromCfg(938042128)
				local var_528_19 = arg_525_1:FormatText(var_528_18.content)

				arg_525_1.text_.text = var_528_19

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_20 = 28
				local var_528_21 = utf8.len(var_528_19)
				local var_528_22 = var_528_20 <= 0 and var_528_16 or var_528_16 * (var_528_21 / var_528_20)

				if var_528_22 > 0 and var_528_16 < var_528_22 then
					arg_525_1.talkMaxDuration = var_528_22

					if var_528_22 + var_528_15 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_22 + var_528_15
					end
				end

				arg_525_1.text_.text = var_528_19
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_23 = math.max(var_528_16, arg_525_1.talkMaxDuration)

			if var_528_15 <= arg_525_1.time_ and arg_525_1.time_ < var_528_15 + var_528_23 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_15) / var_528_23

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_15 + var_528_23 and arg_525_1.time_ < var_528_15 + var_528_23 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play938042129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 938042129
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play938042130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["10183"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps10183 == nil then
				arg_529_1.var_.actorSpriteComps10183 = var_532_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.actorSpriteComps10183 then
					for iter_532_0, iter_532_1 in pairs(arg_529_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_532_1 then
							if arg_529_1.isInRecall_ then
								local var_532_4 = Mathf.Lerp(iter_532_1.color.r, arg_529_1.hightColor2.r, var_532_3)
								local var_532_5 = Mathf.Lerp(iter_532_1.color.g, arg_529_1.hightColor2.g, var_532_3)
								local var_532_6 = Mathf.Lerp(iter_532_1.color.b, arg_529_1.hightColor2.b, var_532_3)

								iter_532_1.color = Color.New(var_532_4, var_532_5, var_532_6)
							else
								local var_532_7 = Mathf.Lerp(iter_532_1.color.r, 0.5, var_532_3)

								iter_532_1.color = Color.New(var_532_7, var_532_7, var_532_7)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps10183 then
				for iter_532_2, iter_532_3 in pairs(arg_529_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_532_3 then
						if arg_529_1.isInRecall_ then
							iter_532_3.color = arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_532_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_529_1.var_.actorSpriteComps10183 = nil
			end

			local var_532_8 = 0
			local var_532_9 = 1.45

			if var_532_8 < arg_529_1.time_ and arg_529_1.time_ <= var_532_8 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_10 = arg_529_1:GetWordFromCfg(938042129)
				local var_532_11 = arg_529_1:FormatText(var_532_10.content)

				arg_529_1.text_.text = var_532_11

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_12 = 58
				local var_532_13 = utf8.len(var_532_11)
				local var_532_14 = var_532_12 <= 0 and var_532_9 or var_532_9 * (var_532_13 / var_532_12)

				if var_532_14 > 0 and var_532_9 < var_532_14 then
					arg_529_1.talkMaxDuration = var_532_14

					if var_532_14 + var_532_8 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_14 + var_532_8
					end
				end

				arg_529_1.text_.text = var_532_11
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_15 = math.max(var_532_9, arg_529_1.talkMaxDuration)

			if var_532_8 <= arg_529_1.time_ and arg_529_1.time_ < var_532_8 + var_532_15 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_8) / var_532_15

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_8 + var_532_15 and arg_529_1.time_ < var_532_8 + var_532_15 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play938042130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 938042130
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play938042131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["10183"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.actorSpriteComps10183 == nil then
				arg_533_1.var_.actorSpriteComps10183 = var_536_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_2 = 0.2

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.actorSpriteComps10183 then
					for iter_536_0, iter_536_1 in pairs(arg_533_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_536_1 then
							if arg_533_1.isInRecall_ then
								local var_536_4 = Mathf.Lerp(iter_536_1.color.r, arg_533_1.hightColor1.r, var_536_3)
								local var_536_5 = Mathf.Lerp(iter_536_1.color.g, arg_533_1.hightColor1.g, var_536_3)
								local var_536_6 = Mathf.Lerp(iter_536_1.color.b, arg_533_1.hightColor1.b, var_536_3)

								iter_536_1.color = Color.New(var_536_4, var_536_5, var_536_6)
							else
								local var_536_7 = Mathf.Lerp(iter_536_1.color.r, 1, var_536_3)

								iter_536_1.color = Color.New(var_536_7, var_536_7, var_536_7)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.actorSpriteComps10183 then
				for iter_536_2, iter_536_3 in pairs(arg_533_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_536_3 then
						if arg_533_1.isInRecall_ then
							iter_536_3.color = arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_536_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_533_1.var_.actorSpriteComps10183 = nil
			end

			local var_536_8 = arg_533_1.actors_["10183"].transform
			local var_536_9 = 0

			if var_536_9 < arg_533_1.time_ and arg_533_1.time_ <= var_536_9 + arg_536_0 then
				arg_533_1.var_.moveOldPos10183 = var_536_8.localPosition
				var_536_8.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("10183", 3)

				local var_536_10 = var_536_8.childCount

				for iter_536_4 = 0, var_536_10 - 1 do
					local var_536_11 = var_536_8:GetChild(iter_536_4)

					if var_536_11.name == "split_1" or not string.find(var_536_11.name, "split") then
						var_536_11.gameObject:SetActive(true)
					else
						var_536_11.gameObject:SetActive(false)
					end
				end
			end

			local var_536_12 = 0.001

			if var_536_9 <= arg_533_1.time_ and arg_533_1.time_ < var_536_9 + var_536_12 then
				local var_536_13 = (arg_533_1.time_ - var_536_9) / var_536_12
				local var_536_14 = Vector3.New(0, -475, -325)

				var_536_8.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10183, var_536_14, var_536_13)
			end

			if arg_533_1.time_ >= var_536_9 + var_536_12 and arg_533_1.time_ < var_536_9 + var_536_12 + arg_536_0 then
				var_536_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_536_15 = 0
			local var_536_16 = 1

			if var_536_15 < arg_533_1.time_ and arg_533_1.time_ <= var_536_15 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_17 = arg_533_1:FormatText(StoryNameCfg[1562].name)

				arg_533_1.leftNameTxt_.text = var_536_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_18 = arg_533_1:GetWordFromCfg(938042130)
				local var_536_19 = arg_533_1:FormatText(var_536_18.content)

				arg_533_1.text_.text = var_536_19

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_20 = 40
				local var_536_21 = utf8.len(var_536_19)
				local var_536_22 = var_536_20 <= 0 and var_536_16 or var_536_16 * (var_536_21 / var_536_20)

				if var_536_22 > 0 and var_536_16 < var_536_22 then
					arg_533_1.talkMaxDuration = var_536_22

					if var_536_22 + var_536_15 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_22 + var_536_15
					end
				end

				arg_533_1.text_.text = var_536_19
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_23 = math.max(var_536_16, arg_533_1.talkMaxDuration)

			if var_536_15 <= arg_533_1.time_ and arg_533_1.time_ < var_536_15 + var_536_23 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_15) / var_536_23

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_15 + var_536_23 and arg_533_1.time_ < var_536_15 + var_536_23 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play938042131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 938042131
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play938042132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["10183"].transform
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.var_.moveOldPos10183 = var_540_0.localPosition
				var_540_0.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("10183", 3)

				local var_540_2 = var_540_0.childCount

				for iter_540_0 = 0, var_540_2 - 1 do
					local var_540_3 = var_540_0:GetChild(iter_540_0)

					if var_540_3.name == "" or not string.find(var_540_3.name, "split") then
						var_540_3.gameObject:SetActive(true)
					else
						var_540_3.gameObject:SetActive(false)
					end
				end
			end

			local var_540_4 = 0.001

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_4 then
				local var_540_5 = (arg_537_1.time_ - var_540_1) / var_540_4
				local var_540_6 = Vector3.New(0, -475, -325)

				var_540_0.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10183, var_540_6, var_540_5)
			end

			if arg_537_1.time_ >= var_540_1 + var_540_4 and arg_537_1.time_ < var_540_1 + var_540_4 + arg_540_0 then
				var_540_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_540_7 = 0
			local var_540_8 = 0.95

			if var_540_7 < arg_537_1.time_ and arg_537_1.time_ <= var_540_7 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_9 = arg_537_1:FormatText(StoryNameCfg[1562].name)

				arg_537_1.leftNameTxt_.text = var_540_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_10 = arg_537_1:GetWordFromCfg(938042131)
				local var_540_11 = arg_537_1:FormatText(var_540_10.content)

				arg_537_1.text_.text = var_540_11

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_12 = 38
				local var_540_13 = utf8.len(var_540_11)
				local var_540_14 = var_540_12 <= 0 and var_540_8 or var_540_8 * (var_540_13 / var_540_12)

				if var_540_14 > 0 and var_540_8 < var_540_14 then
					arg_537_1.talkMaxDuration = var_540_14

					if var_540_14 + var_540_7 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_14 + var_540_7
					end
				end

				arg_537_1.text_.text = var_540_11
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_15 = math.max(var_540_8, arg_537_1.talkMaxDuration)

			if var_540_7 <= arg_537_1.time_ and arg_537_1.time_ < var_540_7 + var_540_15 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_7) / var_540_15

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_7 + var_540_15 and arg_537_1.time_ < var_540_7 + var_540_15 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play938042132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 938042132
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play938042133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["10183"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps10183 == nil then
				arg_541_1.var_.actorSpriteComps10183 = var_544_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.actorSpriteComps10183 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								local var_544_4 = Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, var_544_3)
								local var_544_5 = Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, var_544_3)
								local var_544_6 = Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, var_544_3)

								iter_544_1.color = Color.New(var_544_4, var_544_5, var_544_6)
							else
								local var_544_7 = Mathf.Lerp(iter_544_1.color.r, 0.5, var_544_3)

								iter_544_1.color = Color.New(var_544_7, var_544_7, var_544_7)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps10183 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_544_3 then
						if arg_541_1.isInRecall_ then
							iter_544_3.color = arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_544_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps10183 = nil
			end

			local var_544_8 = arg_541_1.actors_["10183"].transform
			local var_544_9 = 0

			if var_544_9 < arg_541_1.time_ and arg_541_1.time_ <= var_544_9 + arg_544_0 then
				arg_541_1.var_.moveOldPos10183 = var_544_8.localPosition
				var_544_8.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10183", 7)

				local var_544_10 = var_544_8.childCount

				for iter_544_4 = 0, var_544_10 - 1 do
					local var_544_11 = var_544_8:GetChild(iter_544_4)

					if var_544_11.name == "" or not string.find(var_544_11.name, "split") then
						var_544_11.gameObject:SetActive(true)
					else
						var_544_11.gameObject:SetActive(false)
					end
				end
			end

			local var_544_12 = 0.001

			if var_544_9 <= arg_541_1.time_ and arg_541_1.time_ < var_544_9 + var_544_12 then
				local var_544_13 = (arg_541_1.time_ - var_544_9) / var_544_12
				local var_544_14 = Vector3.New(0, -2000, 0)

				var_544_8.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10183, var_544_14, var_544_13)
			end

			if arg_541_1.time_ >= var_544_9 + var_544_12 and arg_541_1.time_ < var_544_9 + var_544_12 + arg_544_0 then
				var_544_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_544_15 = 0
			local var_544_16 = 0.775

			if var_544_15 < arg_541_1.time_ and arg_541_1.time_ <= var_544_15 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_17 = arg_541_1:GetWordFromCfg(938042132)
				local var_544_18 = arg_541_1:FormatText(var_544_17.content)

				arg_541_1.text_.text = var_544_18

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_19 = 31
				local var_544_20 = utf8.len(var_544_18)
				local var_544_21 = var_544_19 <= 0 and var_544_16 or var_544_16 * (var_544_20 / var_544_19)

				if var_544_21 > 0 and var_544_16 < var_544_21 then
					arg_541_1.talkMaxDuration = var_544_21

					if var_544_21 + var_544_15 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_21 + var_544_15
					end
				end

				arg_541_1.text_.text = var_544_18
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_22 = math.max(var_544_16, arg_541_1.talkMaxDuration)

			if var_544_15 <= arg_541_1.time_ and arg_541_1.time_ < var_544_15 + var_544_22 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_15) / var_544_22

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_15 + var_544_22 and arg_541_1.time_ < var_544_15 + var_544_22 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play938042133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 938042133
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play938042134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["10183"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps10183 == nil then
				arg_545_1.var_.actorSpriteComps10183 = var_548_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_2 = 0.2

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.actorSpriteComps10183 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								local var_548_4 = Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor1.r, var_548_3)
								local var_548_5 = Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor1.g, var_548_3)
								local var_548_6 = Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor1.b, var_548_3)

								iter_548_1.color = Color.New(var_548_4, var_548_5, var_548_6)
							else
								local var_548_7 = Mathf.Lerp(iter_548_1.color.r, 1, var_548_3)

								iter_548_1.color = Color.New(var_548_7, var_548_7, var_548_7)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps10183 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_548_3 then
						if arg_545_1.isInRecall_ then
							iter_548_3.color = arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_548_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_545_1.var_.actorSpriteComps10183 = nil
			end

			local var_548_8 = arg_545_1.actors_["10183"].transform
			local var_548_9 = 0

			if var_548_9 < arg_545_1.time_ and arg_545_1.time_ <= var_548_9 + arg_548_0 then
				arg_545_1.var_.moveOldPos10183 = var_548_8.localPosition
				var_548_8.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("10183", 3)

				local var_548_10 = var_548_8.childCount

				for iter_548_4 = 0, var_548_10 - 1 do
					local var_548_11 = var_548_8:GetChild(iter_548_4)

					if var_548_11.name == "split_3" or not string.find(var_548_11.name, "split") then
						var_548_11.gameObject:SetActive(true)
					else
						var_548_11.gameObject:SetActive(false)
					end
				end
			end

			local var_548_12 = 0.001

			if var_548_9 <= arg_545_1.time_ and arg_545_1.time_ < var_548_9 + var_548_12 then
				local var_548_13 = (arg_545_1.time_ - var_548_9) / var_548_12
				local var_548_14 = Vector3.New(0, -475, -325)

				var_548_8.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10183, var_548_14, var_548_13)
			end

			if arg_545_1.time_ >= var_548_9 + var_548_12 and arg_545_1.time_ < var_548_9 + var_548_12 + arg_548_0 then
				var_548_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_548_15 = 0
			local var_548_16 = 0.775

			if var_548_15 < arg_545_1.time_ and arg_545_1.time_ <= var_548_15 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_17 = arg_545_1:FormatText(StoryNameCfg[1562].name)

				arg_545_1.leftNameTxt_.text = var_548_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_18 = arg_545_1:GetWordFromCfg(938042133)
				local var_548_19 = arg_545_1:FormatText(var_548_18.content)

				arg_545_1.text_.text = var_548_19

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_20 = 31
				local var_548_21 = utf8.len(var_548_19)
				local var_548_22 = var_548_20 <= 0 and var_548_16 or var_548_16 * (var_548_21 / var_548_20)

				if var_548_22 > 0 and var_548_16 < var_548_22 then
					arg_545_1.talkMaxDuration = var_548_22

					if var_548_22 + var_548_15 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_22 + var_548_15
					end
				end

				arg_545_1.text_.text = var_548_19
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_23 = math.max(var_548_16, arg_545_1.talkMaxDuration)

			if var_548_15 <= arg_545_1.time_ and arg_545_1.time_ < var_548_15 + var_548_23 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_15) / var_548_23

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_15 + var_548_23 and arg_545_1.time_ < var_548_15 + var_548_23 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play938042134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 938042134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play938042135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["10183"]
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.actorSpriteComps10183 == nil then
				arg_549_1.var_.actorSpriteComps10183 = var_552_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_2 = 0.2

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 and not isNil(var_552_0) then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2

				if arg_549_1.var_.actorSpriteComps10183 then
					for iter_552_0, iter_552_1 in pairs(arg_549_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_552_1 then
							if arg_549_1.isInRecall_ then
								local var_552_4 = Mathf.Lerp(iter_552_1.color.r, arg_549_1.hightColor2.r, var_552_3)
								local var_552_5 = Mathf.Lerp(iter_552_1.color.g, arg_549_1.hightColor2.g, var_552_3)
								local var_552_6 = Mathf.Lerp(iter_552_1.color.b, arg_549_1.hightColor2.b, var_552_3)

								iter_552_1.color = Color.New(var_552_4, var_552_5, var_552_6)
							else
								local var_552_7 = Mathf.Lerp(iter_552_1.color.r, 0.5, var_552_3)

								iter_552_1.color = Color.New(var_552_7, var_552_7, var_552_7)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.actorSpriteComps10183 then
				for iter_552_2, iter_552_3 in pairs(arg_549_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_552_3 then
						if arg_549_1.isInRecall_ then
							iter_552_3.color = arg_549_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_552_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_549_1.var_.actorSpriteComps10183 = nil
			end

			local var_552_8 = 0
			local var_552_9 = 0.875

			if var_552_8 < arg_549_1.time_ and arg_549_1.time_ <= var_552_8 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_10 = arg_549_1:FormatText(StoryNameCfg[7].name)

				arg_549_1.leftNameTxt_.text = var_552_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_11 = arg_549_1:GetWordFromCfg(938042134)
				local var_552_12 = arg_549_1:FormatText(var_552_11.content)

				arg_549_1.text_.text = var_552_12

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_13 = 35
				local var_552_14 = utf8.len(var_552_12)
				local var_552_15 = var_552_13 <= 0 and var_552_9 or var_552_9 * (var_552_14 / var_552_13)

				if var_552_15 > 0 and var_552_9 < var_552_15 then
					arg_549_1.talkMaxDuration = var_552_15

					if var_552_15 + var_552_8 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_15 + var_552_8
					end
				end

				arg_549_1.text_.text = var_552_12
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_16 = math.max(var_552_9, arg_549_1.talkMaxDuration)

			if var_552_8 <= arg_549_1.time_ and arg_549_1.time_ < var_552_8 + var_552_16 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_8) / var_552_16

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_8 + var_552_16 and arg_549_1.time_ < var_552_8 + var_552_16 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play938042135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 938042135
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play938042136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["10183"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps10183 == nil then
				arg_553_1.var_.actorSpriteComps10183 = var_556_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.actorSpriteComps10183 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								local var_556_4 = Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, var_556_3)
								local var_556_5 = Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, var_556_3)
								local var_556_6 = Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, var_556_3)

								iter_556_1.color = Color.New(var_556_4, var_556_5, var_556_6)
							else
								local var_556_7 = Mathf.Lerp(iter_556_1.color.r, 1, var_556_3)

								iter_556_1.color = Color.New(var_556_7, var_556_7, var_556_7)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps10183 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_556_3 then
						if arg_553_1.isInRecall_ then
							iter_556_3.color = arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_556_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps10183 = nil
			end

			local var_556_8 = arg_553_1.actors_["10183"].transform
			local var_556_9 = 0

			if var_556_9 < arg_553_1.time_ and arg_553_1.time_ <= var_556_9 + arg_556_0 then
				arg_553_1.var_.moveOldPos10183 = var_556_8.localPosition
				var_556_8.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10183", 3)

				local var_556_10 = var_556_8.childCount

				for iter_556_4 = 0, var_556_10 - 1 do
					local var_556_11 = var_556_8:GetChild(iter_556_4)

					if var_556_11.name == "split_1" or not string.find(var_556_11.name, "split") then
						var_556_11.gameObject:SetActive(true)
					else
						var_556_11.gameObject:SetActive(false)
					end
				end
			end

			local var_556_12 = 0.001

			if var_556_9 <= arg_553_1.time_ and arg_553_1.time_ < var_556_9 + var_556_12 then
				local var_556_13 = (arg_553_1.time_ - var_556_9) / var_556_12
				local var_556_14 = Vector3.New(0, -475, -325)

				var_556_8.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10183, var_556_14, var_556_13)
			end

			if arg_553_1.time_ >= var_556_9 + var_556_12 and arg_553_1.time_ < var_556_9 + var_556_12 + arg_556_0 then
				var_556_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_556_15 = 0
			local var_556_16 = 0.85

			if var_556_15 < arg_553_1.time_ and arg_553_1.time_ <= var_556_15 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_17 = arg_553_1:FormatText(StoryNameCfg[1562].name)

				arg_553_1.leftNameTxt_.text = var_556_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_18 = arg_553_1:GetWordFromCfg(938042135)
				local var_556_19 = arg_553_1:FormatText(var_556_18.content)

				arg_553_1.text_.text = var_556_19

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_20 = 34
				local var_556_21 = utf8.len(var_556_19)
				local var_556_22 = var_556_20 <= 0 and var_556_16 or var_556_16 * (var_556_21 / var_556_20)

				if var_556_22 > 0 and var_556_16 < var_556_22 then
					arg_553_1.talkMaxDuration = var_556_22

					if var_556_22 + var_556_15 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_22 + var_556_15
					end
				end

				arg_553_1.text_.text = var_556_19
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_23 = math.max(var_556_16, arg_553_1.talkMaxDuration)

			if var_556_15 <= arg_553_1.time_ and arg_553_1.time_ < var_556_15 + var_556_23 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_15) / var_556_23

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_15 + var_556_23 and arg_553_1.time_ < var_556_15 + var_556_23 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play938042136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 938042136
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play938042137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10183"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10183 == nil then
				arg_557_1.var_.actorSpriteComps10183 = var_560_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.actorSpriteComps10183 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								local var_560_4 = Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, var_560_3)
								local var_560_5 = Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, var_560_3)
								local var_560_6 = Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, var_560_3)

								iter_560_1.color = Color.New(var_560_4, var_560_5, var_560_6)
							else
								local var_560_7 = Mathf.Lerp(iter_560_1.color.r, 0.5, var_560_3)

								iter_560_1.color = Color.New(var_560_7, var_560_7, var_560_7)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10183 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_560_3 then
						if arg_557_1.isInRecall_ then
							iter_560_3.color = arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_560_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_557_1.var_.actorSpriteComps10183 = nil
			end

			local var_560_8 = arg_557_1.actors_["10183"].transform
			local var_560_9 = 0

			if var_560_9 < arg_557_1.time_ and arg_557_1.time_ <= var_560_9 + arg_560_0 then
				arg_557_1.var_.moveOldPos10183 = var_560_8.localPosition
				var_560_8.localScale = Vector3.New(1, 1, 1)

				arg_557_1:CheckSpriteTmpPos("10183", 7)

				local var_560_10 = var_560_8.childCount

				for iter_560_4 = 0, var_560_10 - 1 do
					local var_560_11 = var_560_8:GetChild(iter_560_4)

					if var_560_11.name == "" or not string.find(var_560_11.name, "split") then
						var_560_11.gameObject:SetActive(true)
					else
						var_560_11.gameObject:SetActive(false)
					end
				end
			end

			local var_560_12 = 0.001

			if var_560_9 <= arg_557_1.time_ and arg_557_1.time_ < var_560_9 + var_560_12 then
				local var_560_13 = (arg_557_1.time_ - var_560_9) / var_560_12
				local var_560_14 = Vector3.New(0, -2000, 0)

				var_560_8.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10183, var_560_14, var_560_13)
			end

			if arg_557_1.time_ >= var_560_9 + var_560_12 and arg_557_1.time_ < var_560_9 + var_560_12 + arg_560_0 then
				var_560_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_560_15 = 0
			local var_560_16 = 0.875

			if var_560_15 < arg_557_1.time_ and arg_557_1.time_ <= var_560_15 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_17 = arg_557_1:GetWordFromCfg(938042136)
				local var_560_18 = arg_557_1:FormatText(var_560_17.content)

				arg_557_1.text_.text = var_560_18

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_19 = 35
				local var_560_20 = utf8.len(var_560_18)
				local var_560_21 = var_560_19 <= 0 and var_560_16 or var_560_16 * (var_560_20 / var_560_19)

				if var_560_21 > 0 and var_560_16 < var_560_21 then
					arg_557_1.talkMaxDuration = var_560_21

					if var_560_21 + var_560_15 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_21 + var_560_15
					end
				end

				arg_557_1.text_.text = var_560_18
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_22 = math.max(var_560_16, arg_557_1.talkMaxDuration)

			if var_560_15 <= arg_557_1.time_ and arg_557_1.time_ < var_560_15 + var_560_22 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_15) / var_560_22

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_15 + var_560_22 and arg_557_1.time_ < var_560_15 + var_560_22 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play938042137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 938042137
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play938042138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.2

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:GetWordFromCfg(938042137)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 8
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_8 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_8 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_8

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_8 and arg_561_1.time_ < var_564_0 + var_564_8 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play938042138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 938042138
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play938042139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["10183"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.actorSpriteComps10183 == nil then
				arg_565_1.var_.actorSpriteComps10183 = var_568_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_568_2 = 0.2

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.actorSpriteComps10183 then
					for iter_568_0, iter_568_1 in pairs(arg_565_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_568_1 then
							if arg_565_1.isInRecall_ then
								local var_568_4 = Mathf.Lerp(iter_568_1.color.r, arg_565_1.hightColor1.r, var_568_3)
								local var_568_5 = Mathf.Lerp(iter_568_1.color.g, arg_565_1.hightColor1.g, var_568_3)
								local var_568_6 = Mathf.Lerp(iter_568_1.color.b, arg_565_1.hightColor1.b, var_568_3)

								iter_568_1.color = Color.New(var_568_4, var_568_5, var_568_6)
							else
								local var_568_7 = Mathf.Lerp(iter_568_1.color.r, 1, var_568_3)

								iter_568_1.color = Color.New(var_568_7, var_568_7, var_568_7)
							end
						end
					end
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.actorSpriteComps10183 then
				for iter_568_2, iter_568_3 in pairs(arg_565_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_568_3 then
						if arg_565_1.isInRecall_ then
							iter_568_3.color = arg_565_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_568_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_565_1.var_.actorSpriteComps10183 = nil
			end

			local var_568_8 = arg_565_1.actors_["10183"].transform
			local var_568_9 = 0

			if var_568_9 < arg_565_1.time_ and arg_565_1.time_ <= var_568_9 + arg_568_0 then
				arg_565_1.var_.moveOldPos10183 = var_568_8.localPosition
				var_568_8.localScale = Vector3.New(1, 1, 1)

				arg_565_1:CheckSpriteTmpPos("10183", 3)

				local var_568_10 = var_568_8.childCount

				for iter_568_4 = 0, var_568_10 - 1 do
					local var_568_11 = var_568_8:GetChild(iter_568_4)

					if var_568_11.name == "split_7" or not string.find(var_568_11.name, "split") then
						var_568_11.gameObject:SetActive(true)
					else
						var_568_11.gameObject:SetActive(false)
					end
				end
			end

			local var_568_12 = 0.001

			if var_568_9 <= arg_565_1.time_ and arg_565_1.time_ < var_568_9 + var_568_12 then
				local var_568_13 = (arg_565_1.time_ - var_568_9) / var_568_12
				local var_568_14 = Vector3.New(0, -475, -325)

				var_568_8.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos10183, var_568_14, var_568_13)
			end

			if arg_565_1.time_ >= var_568_9 + var_568_12 and arg_565_1.time_ < var_568_9 + var_568_12 + arg_568_0 then
				var_568_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_568_15 = 0
			local var_568_16 = 1.075

			if var_568_15 < arg_565_1.time_ and arg_565_1.time_ <= var_568_15 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_17 = arg_565_1:FormatText(StoryNameCfg[1562].name)

				arg_565_1.leftNameTxt_.text = var_568_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_18 = arg_565_1:GetWordFromCfg(938042138)
				local var_568_19 = arg_565_1:FormatText(var_568_18.content)

				arg_565_1.text_.text = var_568_19

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_20 = 43
				local var_568_21 = utf8.len(var_568_19)
				local var_568_22 = var_568_20 <= 0 and var_568_16 or var_568_16 * (var_568_21 / var_568_20)

				if var_568_22 > 0 and var_568_16 < var_568_22 then
					arg_565_1.talkMaxDuration = var_568_22

					if var_568_22 + var_568_15 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_22 + var_568_15
					end
				end

				arg_565_1.text_.text = var_568_19
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_23 = math.max(var_568_16, arg_565_1.talkMaxDuration)

			if var_568_15 <= arg_565_1.time_ and arg_565_1.time_ < var_568_15 + var_568_23 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_15) / var_568_23

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_15 + var_568_23 and arg_565_1.time_ < var_568_15 + var_568_23 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play938042139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 938042139
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play938042140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["10183"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.actorSpriteComps10183 == nil then
				arg_569_1.var_.actorSpriteComps10183 = var_572_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_572_2 = 0.2

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.actorSpriteComps10183 then
					for iter_572_0, iter_572_1 in pairs(arg_569_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_572_1 then
							if arg_569_1.isInRecall_ then
								local var_572_4 = Mathf.Lerp(iter_572_1.color.r, arg_569_1.hightColor2.r, var_572_3)
								local var_572_5 = Mathf.Lerp(iter_572_1.color.g, arg_569_1.hightColor2.g, var_572_3)
								local var_572_6 = Mathf.Lerp(iter_572_1.color.b, arg_569_1.hightColor2.b, var_572_3)

								iter_572_1.color = Color.New(var_572_4, var_572_5, var_572_6)
							else
								local var_572_7 = Mathf.Lerp(iter_572_1.color.r, 0.5, var_572_3)

								iter_572_1.color = Color.New(var_572_7, var_572_7, var_572_7)
							end
						end
					end
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.actorSpriteComps10183 then
				for iter_572_2, iter_572_3 in pairs(arg_569_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_572_3 then
						if arg_569_1.isInRecall_ then
							iter_572_3.color = arg_569_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_572_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_569_1.var_.actorSpriteComps10183 = nil
			end

			local var_572_8 = 0
			local var_572_9 = 0.225

			if var_572_8 < arg_569_1.time_ and arg_569_1.time_ <= var_572_8 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_10 = arg_569_1:FormatText(StoryNameCfg[7].name)

				arg_569_1.leftNameTxt_.text = var_572_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_11 = arg_569_1:GetWordFromCfg(938042139)
				local var_572_12 = arg_569_1:FormatText(var_572_11.content)

				arg_569_1.text_.text = var_572_12

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_13 = 9
				local var_572_14 = utf8.len(var_572_12)
				local var_572_15 = var_572_13 <= 0 and var_572_9 or var_572_9 * (var_572_14 / var_572_13)

				if var_572_15 > 0 and var_572_9 < var_572_15 then
					arg_569_1.talkMaxDuration = var_572_15

					if var_572_15 + var_572_8 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_15 + var_572_8
					end
				end

				arg_569_1.text_.text = var_572_12
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_16 = math.max(var_572_9, arg_569_1.talkMaxDuration)

			if var_572_8 <= arg_569_1.time_ and arg_569_1.time_ < var_572_8 + var_572_16 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_8) / var_572_16

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_8 + var_572_16 and arg_569_1.time_ < var_572_8 + var_572_16 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play938042140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 938042140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play938042141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["10183"]
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.actorSpriteComps10183 == nil then
				arg_573_1.var_.actorSpriteComps10183 = var_576_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_576_2 = 0.2

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 and not isNil(var_576_0) then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2

				if arg_573_1.var_.actorSpriteComps10183 then
					for iter_576_0, iter_576_1 in pairs(arg_573_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_576_1 then
							if arg_573_1.isInRecall_ then
								local var_576_4 = Mathf.Lerp(iter_576_1.color.r, arg_573_1.hightColor1.r, var_576_3)
								local var_576_5 = Mathf.Lerp(iter_576_1.color.g, arg_573_1.hightColor1.g, var_576_3)
								local var_576_6 = Mathf.Lerp(iter_576_1.color.b, arg_573_1.hightColor1.b, var_576_3)

								iter_576_1.color = Color.New(var_576_4, var_576_5, var_576_6)
							else
								local var_576_7 = Mathf.Lerp(iter_576_1.color.r, 1, var_576_3)

								iter_576_1.color = Color.New(var_576_7, var_576_7, var_576_7)
							end
						end
					end
				end
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.actorSpriteComps10183 then
				for iter_576_2, iter_576_3 in pairs(arg_573_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_576_3 then
						if arg_573_1.isInRecall_ then
							iter_576_3.color = arg_573_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_576_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_573_1.var_.actorSpriteComps10183 = nil
			end

			local var_576_8 = arg_573_1.actors_["10183"].transform
			local var_576_9 = 0

			if var_576_9 < arg_573_1.time_ and arg_573_1.time_ <= var_576_9 + arg_576_0 then
				arg_573_1.var_.moveOldPos10183 = var_576_8.localPosition
				var_576_8.localScale = Vector3.New(1, 1, 1)

				arg_573_1:CheckSpriteTmpPos("10183", 3)

				local var_576_10 = var_576_8.childCount

				for iter_576_4 = 0, var_576_10 - 1 do
					local var_576_11 = var_576_8:GetChild(iter_576_4)

					if var_576_11.name == "split_4" then
						var_576_11:SetAsLastSibling()
						var_576_11.gameObject:SetActive(true)

						arg_573_1.var_.actorSpriteSplit10183 = var_576_11.gameObject:GetComponent(typeof(Image))

						arg_573_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_576_12 = 0.5

			if var_576_9 <= arg_573_1.time_ and arg_573_1.time_ < var_576_9 + var_576_12 then
				local var_576_13 = (arg_573_1.time_ - var_576_9) / var_576_12
				local var_576_14 = Vector3.New(0, -475, -325)

				var_576_8.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos10183, var_576_14, var_576_13)

				if arg_573_1.var_.actorSpriteSplit10183 ~= nil then
					arg_573_1.var_.actorSpriteSplit10183:SetAlpha(var_576_13)
				end
			end

			if arg_573_1.time_ >= var_576_9 + var_576_12 and arg_573_1.time_ < var_576_9 + var_576_12 + arg_576_0 then
				var_576_8.localPosition = Vector3.New(0, -475, -325)

				if arg_573_1.var_.actorSpriteSplit10183 ~= nil then
					arg_573_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_576_15 = 0
			local var_576_16 = 0.125

			if var_576_15 < arg_573_1.time_ and arg_573_1.time_ <= var_576_15 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_17 = arg_573_1:FormatText(StoryNameCfg[1562].name)

				arg_573_1.leftNameTxt_.text = var_576_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_18 = arg_573_1:GetWordFromCfg(938042140)
				local var_576_19 = arg_573_1:FormatText(var_576_18.content)

				arg_573_1.text_.text = var_576_19

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_20 = 5
				local var_576_21 = utf8.len(var_576_19)
				local var_576_22 = var_576_20 <= 0 and var_576_16 or var_576_16 * (var_576_21 / var_576_20)

				if var_576_22 > 0 and var_576_16 < var_576_22 then
					arg_573_1.talkMaxDuration = var_576_22

					if var_576_22 + var_576_15 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_22 + var_576_15
					end
				end

				arg_573_1.text_.text = var_576_19
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_23 = math.max(var_576_16, arg_573_1.talkMaxDuration)

			if var_576_15 <= arg_573_1.time_ and arg_573_1.time_ < var_576_15 + var_576_23 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_15) / var_576_23

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_15 + var_576_23 and arg_573_1.time_ < var_576_15 + var_576_23 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play938042141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 938042141
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play938042142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["10183"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.actorSpriteComps10183 == nil then
				arg_577_1.var_.actorSpriteComps10183 = var_580_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_2 = 0.2

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.actorSpriteComps10183 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								local var_580_4 = Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor2.r, var_580_3)
								local var_580_5 = Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor2.g, var_580_3)
								local var_580_6 = Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor2.b, var_580_3)

								iter_580_1.color = Color.New(var_580_4, var_580_5, var_580_6)
							else
								local var_580_7 = Mathf.Lerp(iter_580_1.color.r, 0.5, var_580_3)

								iter_580_1.color = Color.New(var_580_7, var_580_7, var_580_7)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.actorSpriteComps10183 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_580_3 then
						if arg_577_1.isInRecall_ then
							iter_580_3.color = arg_577_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_580_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_577_1.var_.actorSpriteComps10183 = nil
			end

			local var_580_8 = 0
			local var_580_9 = 0.225

			if var_580_8 < arg_577_1.time_ and arg_577_1.time_ <= var_580_8 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_10 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_11 = arg_577_1:GetWordFromCfg(938042141)
				local var_580_12 = arg_577_1:FormatText(var_580_11.content)

				arg_577_1.text_.text = var_580_12

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_13 = 9
				local var_580_14 = utf8.len(var_580_12)
				local var_580_15 = var_580_13 <= 0 and var_580_9 or var_580_9 * (var_580_14 / var_580_13)

				if var_580_15 > 0 and var_580_9 < var_580_15 then
					arg_577_1.talkMaxDuration = var_580_15

					if var_580_15 + var_580_8 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_15 + var_580_8
					end
				end

				arg_577_1.text_.text = var_580_12
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_16 = math.max(var_580_9, arg_577_1.talkMaxDuration)

			if var_580_8 <= arg_577_1.time_ and arg_577_1.time_ < var_580_8 + var_580_16 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_8) / var_580_16

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_8 + var_580_16 and arg_577_1.time_ < var_580_8 + var_580_16 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play938042142 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 938042142
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play938042143(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["10183"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.actorSpriteComps10183 == nil then
				arg_581_1.var_.actorSpriteComps10183 = var_584_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_584_2 = 0.2

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.actorSpriteComps10183 then
					for iter_584_0, iter_584_1 in pairs(arg_581_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_584_1 then
							if arg_581_1.isInRecall_ then
								local var_584_4 = Mathf.Lerp(iter_584_1.color.r, arg_581_1.hightColor1.r, var_584_3)
								local var_584_5 = Mathf.Lerp(iter_584_1.color.g, arg_581_1.hightColor1.g, var_584_3)
								local var_584_6 = Mathf.Lerp(iter_584_1.color.b, arg_581_1.hightColor1.b, var_584_3)

								iter_584_1.color = Color.New(var_584_4, var_584_5, var_584_6)
							else
								local var_584_7 = Mathf.Lerp(iter_584_1.color.r, 1, var_584_3)

								iter_584_1.color = Color.New(var_584_7, var_584_7, var_584_7)
							end
						end
					end
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.actorSpriteComps10183 then
				for iter_584_2, iter_584_3 in pairs(arg_581_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_584_3 then
						if arg_581_1.isInRecall_ then
							iter_584_3.color = arg_581_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_584_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_581_1.var_.actorSpriteComps10183 = nil
			end

			local var_584_8 = arg_581_1.actors_["10183"].transform
			local var_584_9 = 0

			if var_584_9 < arg_581_1.time_ and arg_581_1.time_ <= var_584_9 + arg_584_0 then
				arg_581_1.var_.moveOldPos10183 = var_584_8.localPosition
				var_584_8.localScale = Vector3.New(1, 1, 1)

				arg_581_1:CheckSpriteTmpPos("10183", 3)

				local var_584_10 = var_584_8.childCount

				for iter_584_4 = 0, var_584_10 - 1 do
					local var_584_11 = var_584_8:GetChild(iter_584_4)

					if var_584_11.name == "split_7" then
						var_584_11:SetAsLastSibling()
						var_584_11.gameObject:SetActive(true)

						arg_581_1.var_.actorSpriteSplit10183 = var_584_11.gameObject:GetComponent(typeof(Image))

						arg_581_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_584_12 = 0.5

			if var_584_9 <= arg_581_1.time_ and arg_581_1.time_ < var_584_9 + var_584_12 then
				local var_584_13 = (arg_581_1.time_ - var_584_9) / var_584_12
				local var_584_14 = Vector3.New(0, -475, -325)

				var_584_8.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos10183, var_584_14, var_584_13)

				if arg_581_1.var_.actorSpriteSplit10183 ~= nil then
					arg_581_1.var_.actorSpriteSplit10183:SetAlpha(var_584_13)
				end
			end

			if arg_581_1.time_ >= var_584_9 + var_584_12 and arg_581_1.time_ < var_584_9 + var_584_12 + arg_584_0 then
				var_584_8.localPosition = Vector3.New(0, -475, -325)

				if arg_581_1.var_.actorSpriteSplit10183 ~= nil then
					arg_581_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_584_15 = 0
			local var_584_16 = 1.1

			if var_584_15 < arg_581_1.time_ and arg_581_1.time_ <= var_584_15 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_17 = arg_581_1:FormatText(StoryNameCfg[1562].name)

				arg_581_1.leftNameTxt_.text = var_584_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_18 = arg_581_1:GetWordFromCfg(938042142)
				local var_584_19 = arg_581_1:FormatText(var_584_18.content)

				arg_581_1.text_.text = var_584_19

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_20 = 44
				local var_584_21 = utf8.len(var_584_19)
				local var_584_22 = var_584_20 <= 0 and var_584_16 or var_584_16 * (var_584_21 / var_584_20)

				if var_584_22 > 0 and var_584_16 < var_584_22 then
					arg_581_1.talkMaxDuration = var_584_22

					if var_584_22 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_22 + var_584_15
					end
				end

				arg_581_1.text_.text = var_584_19
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_23 = math.max(var_584_16, arg_581_1.talkMaxDuration)

			if var_584_15 <= arg_581_1.time_ and arg_581_1.time_ < var_584_15 + var_584_23 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_15) / var_584_23

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_15 + var_584_23 and arg_581_1.time_ < var_584_15 + var_584_23 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play938042143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 938042143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play938042144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["10183"]
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.actorSpriteComps10183 == nil then
				arg_585_1.var_.actorSpriteComps10183 = var_588_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_588_2 = 0.2

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 and not isNil(var_588_0) then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2

				if arg_585_1.var_.actorSpriteComps10183 then
					for iter_588_0, iter_588_1 in pairs(arg_585_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_588_1 then
							if arg_585_1.isInRecall_ then
								local var_588_4 = Mathf.Lerp(iter_588_1.color.r, arg_585_1.hightColor2.r, var_588_3)
								local var_588_5 = Mathf.Lerp(iter_588_1.color.g, arg_585_1.hightColor2.g, var_588_3)
								local var_588_6 = Mathf.Lerp(iter_588_1.color.b, arg_585_1.hightColor2.b, var_588_3)

								iter_588_1.color = Color.New(var_588_4, var_588_5, var_588_6)
							else
								local var_588_7 = Mathf.Lerp(iter_588_1.color.r, 0.5, var_588_3)

								iter_588_1.color = Color.New(var_588_7, var_588_7, var_588_7)
							end
						end
					end
				end
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.actorSpriteComps10183 then
				for iter_588_2, iter_588_3 in pairs(arg_585_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_588_3 then
						if arg_585_1.isInRecall_ then
							iter_588_3.color = arg_585_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_588_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_585_1.var_.actorSpriteComps10183 = nil
			end

			local var_588_8 = 0
			local var_588_9 = 0.275

			if var_588_8 < arg_585_1.time_ and arg_585_1.time_ <= var_588_8 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_10 = arg_585_1:FormatText(StoryNameCfg[7].name)

				arg_585_1.leftNameTxt_.text = var_588_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_11 = arg_585_1:GetWordFromCfg(938042143)
				local var_588_12 = arg_585_1:FormatText(var_588_11.content)

				arg_585_1.text_.text = var_588_12

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_13 = 11
				local var_588_14 = utf8.len(var_588_12)
				local var_588_15 = var_588_13 <= 0 and var_588_9 or var_588_9 * (var_588_14 / var_588_13)

				if var_588_15 > 0 and var_588_9 < var_588_15 then
					arg_585_1.talkMaxDuration = var_588_15

					if var_588_15 + var_588_8 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_15 + var_588_8
					end
				end

				arg_585_1.text_.text = var_588_12
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_16 = math.max(var_588_9, arg_585_1.talkMaxDuration)

			if var_588_8 <= arg_585_1.time_ and arg_585_1.time_ < var_588_8 + var_588_16 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_8) / var_588_16

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_8 + var_588_16 and arg_585_1.time_ < var_588_8 + var_588_16 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play938042144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 938042144
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play938042145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["10183"]
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.actorSpriteComps10183 == nil then
				arg_589_1.var_.actorSpriteComps10183 = var_592_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_592_2 = 0.2

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 and not isNil(var_592_0) then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2

				if arg_589_1.var_.actorSpriteComps10183 then
					for iter_592_0, iter_592_1 in pairs(arg_589_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_592_1 then
							if arg_589_1.isInRecall_ then
								local var_592_4 = Mathf.Lerp(iter_592_1.color.r, arg_589_1.hightColor1.r, var_592_3)
								local var_592_5 = Mathf.Lerp(iter_592_1.color.g, arg_589_1.hightColor1.g, var_592_3)
								local var_592_6 = Mathf.Lerp(iter_592_1.color.b, arg_589_1.hightColor1.b, var_592_3)

								iter_592_1.color = Color.New(var_592_4, var_592_5, var_592_6)
							else
								local var_592_7 = Mathf.Lerp(iter_592_1.color.r, 1, var_592_3)

								iter_592_1.color = Color.New(var_592_7, var_592_7, var_592_7)
							end
						end
					end
				end
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.actorSpriteComps10183 then
				for iter_592_2, iter_592_3 in pairs(arg_589_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_592_3 then
						if arg_589_1.isInRecall_ then
							iter_592_3.color = arg_589_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_592_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_589_1.var_.actorSpriteComps10183 = nil
			end

			local var_592_8 = arg_589_1.actors_["10183"].transform
			local var_592_9 = 0

			if var_592_9 < arg_589_1.time_ and arg_589_1.time_ <= var_592_9 + arg_592_0 then
				arg_589_1.var_.moveOldPos10183 = var_592_8.localPosition
				var_592_8.localScale = Vector3.New(1, 1, 1)

				arg_589_1:CheckSpriteTmpPos("10183", 3)

				local var_592_10 = var_592_8.childCount

				for iter_592_4 = 0, var_592_10 - 1 do
					local var_592_11 = var_592_8:GetChild(iter_592_4)

					if var_592_11.name == "split_1" then
						var_592_11:SetAsLastSibling()
						var_592_11.gameObject:SetActive(true)

						arg_589_1.var_.actorSpriteSplit10183 = var_592_11.gameObject:GetComponent(typeof(Image))

						arg_589_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_592_12 = 0.5

			if var_592_9 <= arg_589_1.time_ and arg_589_1.time_ < var_592_9 + var_592_12 then
				local var_592_13 = (arg_589_1.time_ - var_592_9) / var_592_12
				local var_592_14 = Vector3.New(0, -475, -325)

				var_592_8.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10183, var_592_14, var_592_13)

				if arg_589_1.var_.actorSpriteSplit10183 ~= nil then
					arg_589_1.var_.actorSpriteSplit10183:SetAlpha(var_592_13)
				end
			end

			if arg_589_1.time_ >= var_592_9 + var_592_12 and arg_589_1.time_ < var_592_9 + var_592_12 + arg_592_0 then
				var_592_8.localPosition = Vector3.New(0, -475, -325)

				if arg_589_1.var_.actorSpriteSplit10183 ~= nil then
					arg_589_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_592_15 = 0
			local var_592_16 = 0.25

			if var_592_15 < arg_589_1.time_ and arg_589_1.time_ <= var_592_15 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_17 = arg_589_1:FormatText(StoryNameCfg[1562].name)

				arg_589_1.leftNameTxt_.text = var_592_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_18 = arg_589_1:GetWordFromCfg(938042144)
				local var_592_19 = arg_589_1:FormatText(var_592_18.content)

				arg_589_1.text_.text = var_592_19

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_20 = 10
				local var_592_21 = utf8.len(var_592_19)
				local var_592_22 = var_592_20 <= 0 and var_592_16 or var_592_16 * (var_592_21 / var_592_20)

				if var_592_22 > 0 and var_592_16 < var_592_22 then
					arg_589_1.talkMaxDuration = var_592_22

					if var_592_22 + var_592_15 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_22 + var_592_15
					end
				end

				arg_589_1.text_.text = var_592_19
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_23 = math.max(var_592_16, arg_589_1.talkMaxDuration)

			if var_592_15 <= arg_589_1.time_ and arg_589_1.time_ < var_592_15 + var_592_23 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_15) / var_592_23

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_15 + var_592_23 and arg_589_1.time_ < var_592_15 + var_592_23 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play938042145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 938042145
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play938042146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["10183"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.actorSpriteComps10183 == nil then
				arg_593_1.var_.actorSpriteComps10183 = var_596_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_596_2 = 0.2

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.actorSpriteComps10183 then
					for iter_596_0, iter_596_1 in pairs(arg_593_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_596_1 then
							if arg_593_1.isInRecall_ then
								local var_596_4 = Mathf.Lerp(iter_596_1.color.r, arg_593_1.hightColor2.r, var_596_3)
								local var_596_5 = Mathf.Lerp(iter_596_1.color.g, arg_593_1.hightColor2.g, var_596_3)
								local var_596_6 = Mathf.Lerp(iter_596_1.color.b, arg_593_1.hightColor2.b, var_596_3)

								iter_596_1.color = Color.New(var_596_4, var_596_5, var_596_6)
							else
								local var_596_7 = Mathf.Lerp(iter_596_1.color.r, 0.5, var_596_3)

								iter_596_1.color = Color.New(var_596_7, var_596_7, var_596_7)
							end
						end
					end
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.actorSpriteComps10183 then
				for iter_596_2, iter_596_3 in pairs(arg_593_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_596_3 then
						if arg_593_1.isInRecall_ then
							iter_596_3.color = arg_593_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_596_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_593_1.var_.actorSpriteComps10183 = nil
			end

			local var_596_8 = 0
			local var_596_9 = 0.3

			if var_596_8 < arg_593_1.time_ and arg_593_1.time_ <= var_596_8 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_10 = arg_593_1:FormatText(StoryNameCfg[7].name)

				arg_593_1.leftNameTxt_.text = var_596_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_11 = arg_593_1:GetWordFromCfg(938042145)
				local var_596_12 = arg_593_1:FormatText(var_596_11.content)

				arg_593_1.text_.text = var_596_12

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_13 = 12
				local var_596_14 = utf8.len(var_596_12)
				local var_596_15 = var_596_13 <= 0 and var_596_9 or var_596_9 * (var_596_14 / var_596_13)

				if var_596_15 > 0 and var_596_9 < var_596_15 then
					arg_593_1.talkMaxDuration = var_596_15

					if var_596_15 + var_596_8 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_15 + var_596_8
					end
				end

				arg_593_1.text_.text = var_596_12
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_16 = math.max(var_596_9, arg_593_1.talkMaxDuration)

			if var_596_8 <= arg_593_1.time_ and arg_593_1.time_ < var_596_8 + var_596_16 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_8) / var_596_16

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_8 + var_596_16 and arg_593_1.time_ < var_596_8 + var_596_16 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play938042146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 938042146
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play938042147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["10183"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.actorSpriteComps10183 == nil then
				arg_597_1.var_.actorSpriteComps10183 = var_600_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_600_2 = 0.2

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.actorSpriteComps10183 then
					for iter_600_0, iter_600_1 in pairs(arg_597_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_600_1 then
							if arg_597_1.isInRecall_ then
								local var_600_4 = Mathf.Lerp(iter_600_1.color.r, arg_597_1.hightColor1.r, var_600_3)
								local var_600_5 = Mathf.Lerp(iter_600_1.color.g, arg_597_1.hightColor1.g, var_600_3)
								local var_600_6 = Mathf.Lerp(iter_600_1.color.b, arg_597_1.hightColor1.b, var_600_3)

								iter_600_1.color = Color.New(var_600_4, var_600_5, var_600_6)
							else
								local var_600_7 = Mathf.Lerp(iter_600_1.color.r, 1, var_600_3)

								iter_600_1.color = Color.New(var_600_7, var_600_7, var_600_7)
							end
						end
					end
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.actorSpriteComps10183 then
				for iter_600_2, iter_600_3 in pairs(arg_597_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_600_3 then
						if arg_597_1.isInRecall_ then
							iter_600_3.color = arg_597_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_600_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_597_1.var_.actorSpriteComps10183 = nil
			end

			local var_600_8 = arg_597_1.actors_["10183"].transform
			local var_600_9 = 0

			if var_600_9 < arg_597_1.time_ and arg_597_1.time_ <= var_600_9 + arg_600_0 then
				arg_597_1.var_.moveOldPos10183 = var_600_8.localPosition
				var_600_8.localScale = Vector3.New(1, 1, 1)

				arg_597_1:CheckSpriteTmpPos("10183", 3)

				local var_600_10 = var_600_8.childCount

				for iter_600_4 = 0, var_600_10 - 1 do
					local var_600_11 = var_600_8:GetChild(iter_600_4)

					if var_600_11.name == "split_2" then
						var_600_11:SetAsLastSibling()
						var_600_11.gameObject:SetActive(true)

						arg_597_1.var_.actorSpriteSplit10183 = var_600_11.gameObject:GetComponent(typeof(Image))

						arg_597_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_600_12 = 0.5

			if var_600_9 <= arg_597_1.time_ and arg_597_1.time_ < var_600_9 + var_600_12 then
				local var_600_13 = (arg_597_1.time_ - var_600_9) / var_600_12
				local var_600_14 = Vector3.New(0, -475, -325)

				var_600_8.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos10183, var_600_14, var_600_13)

				if arg_597_1.var_.actorSpriteSplit10183 ~= nil then
					arg_597_1.var_.actorSpriteSplit10183:SetAlpha(var_600_13)
				end
			end

			if arg_597_1.time_ >= var_600_9 + var_600_12 and arg_597_1.time_ < var_600_9 + var_600_12 + arg_600_0 then
				var_600_8.localPosition = Vector3.New(0, -475, -325)

				if arg_597_1.var_.actorSpriteSplit10183 ~= nil then
					arg_597_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_600_15 = 0
			local var_600_16 = 1.15

			if var_600_15 < arg_597_1.time_ and arg_597_1.time_ <= var_600_15 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_17 = arg_597_1:FormatText(StoryNameCfg[1562].name)

				arg_597_1.leftNameTxt_.text = var_600_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_18 = arg_597_1:GetWordFromCfg(938042146)
				local var_600_19 = arg_597_1:FormatText(var_600_18.content)

				arg_597_1.text_.text = var_600_19

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_20 = 46
				local var_600_21 = utf8.len(var_600_19)
				local var_600_22 = var_600_20 <= 0 and var_600_16 or var_600_16 * (var_600_21 / var_600_20)

				if var_600_22 > 0 and var_600_16 < var_600_22 then
					arg_597_1.talkMaxDuration = var_600_22

					if var_600_22 + var_600_15 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_22 + var_600_15
					end
				end

				arg_597_1.text_.text = var_600_19
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_23 = math.max(var_600_16, arg_597_1.talkMaxDuration)

			if var_600_15 <= arg_597_1.time_ and arg_597_1.time_ < var_600_15 + var_600_23 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_15) / var_600_23

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_15 + var_600_23 and arg_597_1.time_ < var_600_15 + var_600_23 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play938042147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 938042147
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play938042148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["10183"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.actorSpriteComps10183 == nil then
				arg_601_1.var_.actorSpriteComps10183 = var_604_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_604_2 = 0.2

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.actorSpriteComps10183 then
					for iter_604_0, iter_604_1 in pairs(arg_601_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_604_1 then
							if arg_601_1.isInRecall_ then
								local var_604_4 = Mathf.Lerp(iter_604_1.color.r, arg_601_1.hightColor2.r, var_604_3)
								local var_604_5 = Mathf.Lerp(iter_604_1.color.g, arg_601_1.hightColor2.g, var_604_3)
								local var_604_6 = Mathf.Lerp(iter_604_1.color.b, arg_601_1.hightColor2.b, var_604_3)

								iter_604_1.color = Color.New(var_604_4, var_604_5, var_604_6)
							else
								local var_604_7 = Mathf.Lerp(iter_604_1.color.r, 0.5, var_604_3)

								iter_604_1.color = Color.New(var_604_7, var_604_7, var_604_7)
							end
						end
					end
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.actorSpriteComps10183 then
				for iter_604_2, iter_604_3 in pairs(arg_601_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_604_3 then
						if arg_601_1.isInRecall_ then
							iter_604_3.color = arg_601_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_604_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_601_1.var_.actorSpriteComps10183 = nil
			end

			local var_604_8 = 0
			local var_604_9 = 0.4

			if var_604_8 < arg_601_1.time_ and arg_601_1.time_ <= var_604_8 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_10 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_11 = arg_601_1:GetWordFromCfg(938042147)
				local var_604_12 = arg_601_1:FormatText(var_604_11.content)

				arg_601_1.text_.text = var_604_12

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_13 = 16
				local var_604_14 = utf8.len(var_604_12)
				local var_604_15 = var_604_13 <= 0 and var_604_9 or var_604_9 * (var_604_14 / var_604_13)

				if var_604_15 > 0 and var_604_9 < var_604_15 then
					arg_601_1.talkMaxDuration = var_604_15

					if var_604_15 + var_604_8 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_15 + var_604_8
					end
				end

				arg_601_1.text_.text = var_604_12
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_16 = math.max(var_604_9, arg_601_1.talkMaxDuration)

			if var_604_8 <= arg_601_1.time_ and arg_601_1.time_ < var_604_8 + var_604_16 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_8) / var_604_16

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_8 + var_604_16 and arg_601_1.time_ < var_604_8 + var_604_16 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play938042148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 938042148
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
			arg_605_1.auto_ = false
		end

		function arg_605_1.playNext_(arg_607_0)
			arg_605_1.onStoryFinished_()
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = arg_605_1.actors_["10183"]
			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.actorSpriteComps10183 == nil then
				arg_605_1.var_.actorSpriteComps10183 = var_608_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_608_2 = 0.2

			if var_608_1 <= arg_605_1.time_ and arg_605_1.time_ < var_608_1 + var_608_2 and not isNil(var_608_0) then
				local var_608_3 = (arg_605_1.time_ - var_608_1) / var_608_2

				if arg_605_1.var_.actorSpriteComps10183 then
					for iter_608_0, iter_608_1 in pairs(arg_605_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_608_1 then
							if arg_605_1.isInRecall_ then
								local var_608_4 = Mathf.Lerp(iter_608_1.color.r, arg_605_1.hightColor1.r, var_608_3)
								local var_608_5 = Mathf.Lerp(iter_608_1.color.g, arg_605_1.hightColor1.g, var_608_3)
								local var_608_6 = Mathf.Lerp(iter_608_1.color.b, arg_605_1.hightColor1.b, var_608_3)

								iter_608_1.color = Color.New(var_608_4, var_608_5, var_608_6)
							else
								local var_608_7 = Mathf.Lerp(iter_608_1.color.r, 1, var_608_3)

								iter_608_1.color = Color.New(var_608_7, var_608_7, var_608_7)
							end
						end
					end
				end
			end

			if arg_605_1.time_ >= var_608_1 + var_608_2 and arg_605_1.time_ < var_608_1 + var_608_2 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.actorSpriteComps10183 then
				for iter_608_2, iter_608_3 in pairs(arg_605_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_608_3 then
						if arg_605_1.isInRecall_ then
							iter_608_3.color = arg_605_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_608_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_605_1.var_.actorSpriteComps10183 = nil
			end

			local var_608_8 = arg_605_1.actors_["10183"].transform
			local var_608_9 = 0

			if var_608_9 < arg_605_1.time_ and arg_605_1.time_ <= var_608_9 + arg_608_0 then
				arg_605_1.var_.moveOldPos10183 = var_608_8.localPosition
				var_608_8.localScale = Vector3.New(1, 1, 1)

				arg_605_1:CheckSpriteTmpPos("10183", 3)

				local var_608_10 = var_608_8.childCount

				for iter_608_4 = 0, var_608_10 - 1 do
					local var_608_11 = var_608_8:GetChild(iter_608_4)

					if var_608_11.name == "split_7" or not string.find(var_608_11.name, "split") then
						var_608_11.gameObject:SetActive(true)
					else
						var_608_11.gameObject:SetActive(false)
					end
				end
			end

			local var_608_12 = 0.001

			if var_608_9 <= arg_605_1.time_ and arg_605_1.time_ < var_608_9 + var_608_12 then
				local var_608_13 = (arg_605_1.time_ - var_608_9) / var_608_12
				local var_608_14 = Vector3.New(0, -475, -325)

				var_608_8.localPosition = Vector3.Lerp(arg_605_1.var_.moveOldPos10183, var_608_14, var_608_13)
			end

			if arg_605_1.time_ >= var_608_9 + var_608_12 and arg_605_1.time_ < var_608_9 + var_608_12 + arg_608_0 then
				var_608_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_608_15 = 0
			local var_608_16 = 1.2

			if var_608_15 < arg_605_1.time_ and arg_605_1.time_ <= var_608_15 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_17 = arg_605_1:FormatText(StoryNameCfg[1562].name)

				arg_605_1.leftNameTxt_.text = var_608_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_18 = arg_605_1:GetWordFromCfg(938042148)
				local var_608_19 = arg_605_1:FormatText(var_608_18.content)

				arg_605_1.text_.text = var_608_19

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_20 = 48
				local var_608_21 = utf8.len(var_608_19)
				local var_608_22 = var_608_20 <= 0 and var_608_16 or var_608_16 * (var_608_21 / var_608_20)

				if var_608_22 > 0 and var_608_16 < var_608_22 then
					arg_605_1.talkMaxDuration = var_608_22

					if var_608_22 + var_608_15 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_22 + var_608_15
					end
				end

				arg_605_1.text_.text = var_608_19
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_23 = math.max(var_608_16, arg_605_1.talkMaxDuration)

			if var_608_15 <= arg_605_1.time_ and arg_605_1.time_ < var_608_15 + var_608_23 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_15) / var_608_23

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_15 + var_608_23 and arg_605_1.time_ < var_608_15 + var_608_23 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_605_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/ST84",
		"TextureConfig/Background/H02b"
	},
	voices = {}
}
