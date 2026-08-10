return {
	Play938052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938052002(arg_1_1)
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

			local var_4_24 = "10144"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_4_28 = arg_1_1.actors_["10144"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			local var_4_36 = arg_1_1.actors_["10144"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

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
				local var_4_42 = Vector3.New(-31.5, -381.1, -285.9)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_4_43 = 1
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

			local var_4_53 = 1.999999999999
			local var_4_54 = 1

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[1297].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(938052001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 40
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
				actorName = "10144",
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
	Play938052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938052002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10144"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10144 == nil then
				arg_8_1.var_.actorSpriteComps10144 = var_11_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.actorSpriteComps10144 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_11_1 then
							if arg_8_1.isInRecall_ then
								local var_11_4 = Mathf.Lerp(iter_11_1.color.r, arg_8_1.hightColor2.r, var_11_3)
								local var_11_5 = Mathf.Lerp(iter_11_1.color.g, arg_8_1.hightColor2.g, var_11_3)
								local var_11_6 = Mathf.Lerp(iter_11_1.color.b, arg_8_1.hightColor2.b, var_11_3)

								iter_11_1.color = Color.New(var_11_4, var_11_5, var_11_6)
							else
								local var_11_7 = Mathf.Lerp(iter_11_1.color.r, 0.5, var_11_3)

								iter_11_1.color = Color.New(var_11_7, var_11_7, var_11_7)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10144 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_11_3 then
						if arg_8_1.isInRecall_ then
							iter_11_3.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10144 = nil
			end

			local var_11_8 = 0
			local var_11_9 = 0.35

			if var_11_8 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_10 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_11 = arg_8_1:GetWordFromCfg(938052002)
				local var_11_12 = arg_8_1:FormatText(var_11_11.content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 14
				local var_11_14 = utf8.len(var_11_12)
				local var_11_15 = var_11_13 <= 0 and var_11_9 or var_11_9 * (var_11_14 / var_11_13)

				if var_11_15 > 0 and var_11_9 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938052003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938052003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938052004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10144"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10144 == nil then
				arg_12_1.var_.actorSpriteComps10144 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps10144 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10144 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10144 = nil
			end

			local var_15_8 = arg_12_1.actors_["10144"].transform
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.var_.moveOldPos10144 = var_15_8.localPosition
				var_15_8.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10144", 3)

				local var_15_10 = var_15_8.childCount

				for iter_15_4 = 0, var_15_10 - 1 do
					local var_15_11 = var_15_8:GetChild(iter_15_4)

					if var_15_11.name == "split_2" then
						var_15_11:SetAsLastSibling()
						var_15_11.gameObject:SetActive(true)

						arg_12_1.var_.actorSpriteSplit10144 = var_15_11.gameObject:GetComponent(typeof(Image))

						arg_12_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_15_12 = 0.5

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_9) / var_15_12
				local var_15_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10144, var_15_14, var_15_13)

				if arg_12_1.var_.actorSpriteSplit10144 ~= nil then
					arg_12_1.var_.actorSpriteSplit10144:SetAlpha(var_15_13)
				end
			end

			if arg_12_1.time_ >= var_15_9 + var_15_12 and arg_12_1.time_ < var_15_9 + var_15_12 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_12_1.var_.actorSpriteSplit10144 ~= nil then
					arg_12_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_15_15 = 0
			local var_15_16 = 0.6

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_17 = arg_12_1:FormatText(StoryNameCfg[1297].name)

				arg_12_1.leftNameTxt_.text = var_15_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_18 = arg_12_1:GetWordFromCfg(938052003)
				local var_15_19 = arg_12_1:FormatText(var_15_18.content)

				arg_12_1.text_.text = var_15_19

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_20 = 24
				local var_15_21 = utf8.len(var_15_19)
				local var_15_22 = var_15_20 <= 0 and var_15_16 or var_15_16 * (var_15_21 / var_15_20)

				if var_15_22 > 0 and var_15_16 < var_15_22 then
					arg_12_1.talkMaxDuration = var_15_22

					if var_15_22 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_22 + var_15_15
					end
				end

				arg_12_1.text_.text = var_15_19
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_23 = math.max(var_15_16, arg_12_1.talkMaxDuration)

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_23 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_15) / var_15_23

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_15 + var_15_23 and arg_12_1.time_ < var_15_15 + var_15_23 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play938052004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938052004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938052005(arg_16_1)
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
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 0.5, var_19_3)

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
							iter_19_3.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_3.color = Color.New(0.5, 0.5, 0.5)
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

				arg_16_1:CheckSpriteTmpPos("10144", 7)

				local var_19_10 = var_19_8.childCount

				for iter_19_4 = 0, var_19_10 - 1 do
					local var_19_11 = var_19_8:GetChild(iter_19_4)

					if var_19_11.name == "" or not string.find(var_19_11.name, "split") then
						var_19_11.gameObject:SetActive(true)
					else
						var_19_11.gameObject:SetActive(false)
					end
				end
			end

			local var_19_12 = 0.001

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_9) / var_19_12
				local var_19_14 = Vector3.New(0, -2000, 0)

				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10144, var_19_14, var_19_13)
			end

			if arg_16_1.time_ >= var_19_9 + var_19_12 and arg_16_1.time_ < var_19_9 + var_19_12 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_19_15 = 0
			local var_19_16 = 0.475

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(938052004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 19
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_16 or var_19_16 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_16 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_22 and arg_16_1.time_ < var_19_15 + var_19_22 + arg_19_0 then
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
	Play938052005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938052005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938052006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "106603"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(var_23_1, arg_20_1.canvasGo_.transform)

					var_23_2.transform:SetSiblingIndex(1)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs(var_23_3) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_4 = arg_20_1.actors_["106603"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps106603 == nil then
				arg_20_1.var_.actorSpriteComps106603 = var_23_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.actorSpriteComps106603 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_23_3 then
							if arg_20_1.isInRecall_ then
								local var_23_8 = Mathf.Lerp(iter_23_3.color.r, arg_20_1.hightColor1.r, var_23_7)
								local var_23_9 = Mathf.Lerp(iter_23_3.color.g, arg_20_1.hightColor1.g, var_23_7)
								local var_23_10 = Mathf.Lerp(iter_23_3.color.b, arg_20_1.hightColor1.b, var_23_7)

								iter_23_3.color = Color.New(var_23_8, var_23_9, var_23_10)
							else
								local var_23_11 = Mathf.Lerp(iter_23_3.color.r, 1, var_23_7)

								iter_23_3.color = Color.New(var_23_11, var_23_11, var_23_11)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps106603 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_23_5 then
						if arg_20_1.isInRecall_ then
							iter_23_5.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps106603 = nil
			end

			local var_23_12 = arg_20_1.actors_["106603"].transform
			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1.var_.moveOldPos106603 = var_23_12.localPosition
				var_23_12.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("106603", 3)

				local var_23_14 = var_23_12.childCount

				for iter_23_6 = 0, var_23_14 - 1 do
					local var_23_15 = var_23_12:GetChild(iter_23_6)

					if var_23_15.name == "split_6" or not string.find(var_23_15.name, "split") then
						var_23_15.gameObject:SetActive(true)
					else
						var_23_15.gameObject:SetActive(false)
					end
				end
			end

			local var_23_16 = 0.001

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_16 then
				local var_23_17 = (arg_20_1.time_ - var_23_13) / var_23_16
				local var_23_18 = Vector3.New(-77.5, -399.1, -303.3)

				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos106603, var_23_18, var_23_17)
			end

			if arg_20_1.time_ >= var_23_13 + var_23_16 and arg_20_1.time_ < var_23_13 + var_23_16 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_23_19 = 0
			local var_23_20 = 0.975

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_21 = arg_20_1:FormatText(StoryNameCfg[32].name)

				arg_20_1.leftNameTxt_.text = var_23_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_22 = arg_20_1:GetWordFromCfg(938052005)
				local var_23_23 = arg_20_1:FormatText(var_23_22.content)

				arg_20_1.text_.text = var_23_23

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_24 = 39
				local var_23_25 = utf8.len(var_23_23)
				local var_23_26 = var_23_24 <= 0 and var_23_20 or var_23_20 * (var_23_25 / var_23_24)

				if var_23_26 > 0 and var_23_20 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26

					if var_23_26 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_19
					end
				end

				arg_20_1.text_.text = var_23_23
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_27 = math.max(var_23_20, arg_20_1.talkMaxDuration)

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_27 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_19) / var_23_27

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_19 + var_23_27 and arg_20_1.time_ < var_23_19 + var_23_27 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play938052006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938052006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938052007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["106603"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps106603 == nil then
				arg_24_1.var_.actorSpriteComps106603 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps106603 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps106603 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps106603 = nil
			end

			local var_27_8 = 0
			local var_27_9 = 0.325

			if var_27_8 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_10 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_11 = arg_24_1:GetWordFromCfg(938052006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 13
				local var_27_14 = utf8.len(var_27_12)
				local var_27_15 = var_27_13 <= 0 and var_27_9 or var_27_9 * (var_27_14 / var_27_13)

				if var_27_15 > 0 and var_27_9 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_16 and arg_24_1.time_ < var_27_8 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play938052007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938052007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938052008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["106603"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps106603 == nil then
				arg_28_1.var_.actorSpriteComps106603 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps106603 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps106603 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps106603 = nil
			end

			local var_31_8 = arg_28_1.actors_["106603"].transform
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.var_.moveOldPos106603 = var_31_8.localPosition
				var_31_8.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("106603", 3)

				local var_31_10 = var_31_8.childCount

				for iter_31_4 = 0, var_31_10 - 1 do
					local var_31_11 = var_31_8:GetChild(iter_31_4)

					if var_31_11.name == "split_1" then
						var_31_11:SetAsLastSibling()
						var_31_11.gameObject:SetActive(true)

						arg_28_1.var_.actorSpriteSplit106603 = var_31_11.gameObject:GetComponent(typeof(Image))

						arg_28_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_31_12 = 0.5

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_9) / var_31_12
				local var_31_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos106603, var_31_14, var_31_13)

				if arg_28_1.var_.actorSpriteSplit106603 ~= nil then
					arg_28_1.var_.actorSpriteSplit106603:SetAlpha(var_31_13)
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_12 and arg_28_1.time_ < var_31_9 + var_31_12 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_28_1.var_.actorSpriteSplit106603 ~= nil then
					arg_28_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_31_15 = 0
			local var_31_16 = 0.75

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[32].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(938052007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 30
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_23 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_23 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_23

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_23 and arg_28_1.time_ < var_31_15 + var_31_23 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938052008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938052008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938052009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10144"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 1, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_8 = arg_32_1.actors_["106603"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps106603 == nil then
				arg_32_1.var_.actorSpriteComps106603 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps106603 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 0.5, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps106603 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps106603 = nil
			end

			local var_35_16 = arg_32_1.actors_["10144"].transform
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.var_.moveOldPos10144 = var_35_16.localPosition
				var_35_16.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10144", 4)

				local var_35_18 = var_35_16.childCount

				for iter_35_8 = 0, var_35_18 - 1 do
					local var_35_19 = var_35_16:GetChild(iter_35_8)

					if var_35_19.name == "" or not string.find(var_35_19.name, "split") then
						var_35_19.gameObject:SetActive(true)
					else
						var_35_19.gameObject:SetActive(false)
					end
				end
			end

			local var_35_20 = 0.001

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_20 then
				local var_35_21 = (arg_32_1.time_ - var_35_17) / var_35_20
				local var_35_22 = Vector3.New(435.8, -381.1, -285.9)

				var_35_16.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10144, var_35_22, var_35_21)
			end

			if arg_32_1.time_ >= var_35_17 + var_35_20 and arg_32_1.time_ < var_35_17 + var_35_20 + arg_35_0 then
				var_35_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_35_23 = arg_32_1.actors_["106603"].transform
			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1.var_.moveOldPos106603 = var_35_23.localPosition
				var_35_23.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("106603", 2)

				local var_35_25 = var_35_23.childCount

				for iter_35_9 = 0, var_35_25 - 1 do
					local var_35_26 = var_35_23:GetChild(iter_35_9)

					if var_35_26.name == "" or not string.find(var_35_26.name, "split") then
						var_35_26.gameObject:SetActive(true)
					else
						var_35_26.gameObject:SetActive(false)
					end
				end
			end

			local var_35_27 = 0.001

			if var_35_24 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_27 then
				local var_35_28 = (arg_32_1.time_ - var_35_24) / var_35_27
				local var_35_29 = Vector3.New(-510.9, -399.1, -303.3)

				var_35_23.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos106603, var_35_29, var_35_28)
			end

			if arg_32_1.time_ >= var_35_24 + var_35_27 and arg_32_1.time_ < var_35_24 + var_35_27 + arg_35_0 then
				var_35_23.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_35_30 = 0
			local var_35_31 = 0.5

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_32 = arg_32_1:FormatText(StoryNameCfg[1297].name)

				arg_32_1.leftNameTxt_.text = var_35_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_33 = arg_32_1:GetWordFromCfg(938052008)
				local var_35_34 = arg_32_1:FormatText(var_35_33.content)

				arg_32_1.text_.text = var_35_34

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_35 = 20
				local var_35_36 = utf8.len(var_35_34)
				local var_35_37 = var_35_35 <= 0 and var_35_31 or var_35_31 * (var_35_36 / var_35_35)

				if var_35_37 > 0 and var_35_31 < var_35_37 then
					arg_32_1.talkMaxDuration = var_35_37

					if var_35_37 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_37 + var_35_30
					end
				end

				arg_32_1.text_.text = var_35_34
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_38 = math.max(var_35_31, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_38 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_38

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_38 and arg_32_1.time_ < var_35_30 + var_35_38 + arg_35_0 then
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
				actorName = "106603",
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
	Play938052009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938052009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938052010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["106603"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_8 = arg_36_1.actors_["10144"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10144 == nil then
				arg_36_1.var_.actorSpriteComps10144 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps10144 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10144 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10144 = nil
			end

			local var_39_16 = arg_36_1.actors_["106603"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 2)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_39_23 = 0
			local var_39_24 = 1.3

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_25 = arg_36_1:FormatText(StoryNameCfg[32].name)

				arg_36_1.leftNameTxt_.text = var_39_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(938052009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 52
				local var_39_29 = utf8.len(var_39_27)
				local var_39_30 = var_39_28 <= 0 and var_39_24 or var_39_24 * (var_39_29 / var_39_28)

				if var_39_30 > 0 and var_39_24 < var_39_30 then
					arg_36_1.talkMaxDuration = var_39_30

					if var_39_30 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_23
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_31 = math.max(var_39_24, arg_36_1.talkMaxDuration)

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_31 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_23) / var_39_31

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_23 + var_39_31 and arg_36_1.time_ < var_39_23 + var_39_31 + arg_39_0 then
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
	Play938052010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938052010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938052011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["106603"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos106603 = var_43_0.localPosition
				var_43_0.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("106603", 2)

				local var_43_2 = var_43_0.childCount

				for iter_43_0 = 0, var_43_2 - 1 do
					local var_43_3 = var_43_0:GetChild(iter_43_0)

					if var_43_3.name == "split_5" then
						var_43_3:SetAsLastSibling()
						var_43_3.gameObject:SetActive(true)

						arg_40_1.var_.actorSpriteSplit106603 = var_43_3.gameObject:GetComponent(typeof(Image))

						arg_40_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_43_4 = 0.5

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_4 then
				local var_43_5 = (arg_40_1.time_ - var_43_1) / var_43_4
				local var_43_6 = Vector3.New(-510.9, -399.1, -303.3)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos106603, var_43_6, var_43_5)

				if arg_40_1.var_.actorSpriteSplit106603 ~= nil then
					arg_40_1.var_.actorSpriteSplit106603:SetAlpha(var_43_5)
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_4 and arg_40_1.time_ < var_43_1 + var_43_4 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(-510.9, -399.1, -303.3)

				if arg_40_1.var_.actorSpriteSplit106603 ~= nil then
					arg_40_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_43_7 = 0
			local var_43_8 = 0.225

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_9 = arg_40_1:FormatText(StoryNameCfg[32].name)

				arg_40_1.leftNameTxt_.text = var_43_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(938052010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_12 = 9
				local var_43_13 = utf8.len(var_43_11)
				local var_43_14 = var_43_12 <= 0 and var_43_8 or var_43_8 * (var_43_13 / var_43_12)

				if var_43_14 > 0 and var_43_8 < var_43_14 then
					arg_40_1.talkMaxDuration = var_43_14

					if var_43_14 + var_43_7 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_7
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_15 = math.max(var_43_8, arg_40_1.talkMaxDuration)

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_15 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_7) / var_43_15

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_7 + var_43_15 and arg_40_1.time_ < var_43_7 + var_43_15 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play938052011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938052011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938052012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["106603"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps106603 == nil then
				arg_44_1.var_.actorSpriteComps106603 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps106603 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor2.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor2.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor2.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 0.5, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps106603 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps106603 = nil
			end

			local var_47_8 = arg_44_1.actors_["106603"].transform
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 then
				arg_44_1.var_.moveOldPos106603 = var_47_8.localPosition
				var_47_8.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("106603", 7)

				local var_47_10 = var_47_8.childCount

				for iter_47_4 = 0, var_47_10 - 1 do
					local var_47_11 = var_47_8:GetChild(iter_47_4)

					if var_47_11.name == "" or not string.find(var_47_11.name, "split") then
						var_47_11.gameObject:SetActive(true)
					else
						var_47_11.gameObject:SetActive(false)
					end
				end
			end

			local var_47_12 = 0.001

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_9) / var_47_12
				local var_47_14 = Vector3.New(0, -2000, 0)

				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos106603, var_47_14, var_47_13)
			end

			if arg_44_1.time_ >= var_47_9 + var_47_12 and arg_44_1.time_ < var_47_9 + var_47_12 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_47_15 = arg_44_1.actors_["10144"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos10144 = var_47_15.localPosition
				var_47_15.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10144", 7)

				local var_47_17 = var_47_15.childCount

				for iter_47_5 = 0, var_47_17 - 1 do
					local var_47_18 = var_47_15:GetChild(iter_47_5)

					if var_47_18.name == "" or not string.find(var_47_18.name, "split") then
						var_47_18.gameObject:SetActive(true)
					else
						var_47_18.gameObject:SetActive(false)
					end
				end
			end

			local var_47_19 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_16) / var_47_19
				local var_47_21 = Vector3.New(0, -2000, 0)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10144, var_47_21, var_47_20)
			end

			if arg_44_1.time_ >= var_47_16 + var_47_19 and arg_44_1.time_ < var_47_16 + var_47_19 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_47_22 = 0
			local var_47_23 = 1.075

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_24 = arg_44_1:GetWordFromCfg(938052011)
				local var_47_25 = arg_44_1:FormatText(var_47_24.content)

				arg_44_1.text_.text = var_47_25

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_26 = 43
				local var_47_27 = utf8.len(var_47_25)
				local var_47_28 = var_47_26 <= 0 and var_47_23 or var_47_23 * (var_47_27 / var_47_26)

				if var_47_28 > 0 and var_47_23 < var_47_28 then
					arg_44_1.talkMaxDuration = var_47_28

					if var_47_28 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_22
					end
				end

				arg_44_1.text_.text = var_47_25
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_29 = math.max(var_47_23, arg_44_1.talkMaxDuration)

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_29 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_22) / var_47_29

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_22 + var_47_29 and arg_44_1.time_ < var_47_22 + var_47_29 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
	Play938052012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938052012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938052013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10144"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 == nil then
				arg_48_1.var_.actorSpriteComps10144 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10144 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10144 = nil
			end

			local var_51_8 = arg_48_1.actors_["10144"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos10144 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10144", 2)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "split_7" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10144, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_51_15 = 0
			local var_51_16 = 0.25

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[1297].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(938052012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 10
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_23 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_23 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_23

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_23 and arg_48_1.time_ < var_51_15 + var_51_23 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play938052013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938052013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938052014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["106603"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps106603 == nil then
				arg_52_1.var_.actorSpriteComps106603 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps106603 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 1, var_55_3)

								iter_55_1.color = Color.New(var_55_7, var_55_7, var_55_7)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps106603 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps106603 = nil
			end

			local var_55_8 = arg_52_1.actors_["10144"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10144 == nil then
				arg_52_1.var_.actorSpriteComps10144 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps10144 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								local var_55_12 = Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, var_55_11)
								local var_55_13 = Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, var_55_11)
								local var_55_14 = Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, var_55_11)

								iter_55_5.color = Color.New(var_55_12, var_55_13, var_55_14)
							else
								local var_55_15 = Mathf.Lerp(iter_55_5.color.r, 0.5, var_55_11)

								iter_55_5.color = Color.New(var_55_15, var_55_15, var_55_15)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10144 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10144 = nil
			end

			local var_55_16 = arg_52_1.actors_["106603"].transform
			local var_55_17 = 0

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.var_.moveOldPos106603 = var_55_16.localPosition
				var_55_16.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("106603", 4)

				local var_55_18 = var_55_16.childCount

				for iter_55_8 = 0, var_55_18 - 1 do
					local var_55_19 = var_55_16:GetChild(iter_55_8)

					if var_55_19.name == "split_4" or not string.find(var_55_19.name, "split") then
						var_55_19.gameObject:SetActive(true)
					else
						var_55_19.gameObject:SetActive(false)
					end
				end
			end

			local var_55_20 = 0.001

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_20 then
				local var_55_21 = (arg_52_1.time_ - var_55_17) / var_55_20
				local var_55_22 = Vector3.New(453.9, -399.1, -303.3)

				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos106603, var_55_22, var_55_21)
			end

			if arg_52_1.time_ >= var_55_17 + var_55_20 and arg_52_1.time_ < var_55_17 + var_55_20 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_55_23 = 0
			local var_55_24 = 0.25

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_25 = arg_52_1:FormatText(StoryNameCfg[32].name)

				arg_52_1.leftNameTxt_.text = var_55_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_26 = arg_52_1:GetWordFromCfg(938052013)
				local var_55_27 = arg_52_1:FormatText(var_55_26.content)

				arg_52_1.text_.text = var_55_27

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_28 = 10
				local var_55_29 = utf8.len(var_55_27)
				local var_55_30 = var_55_28 <= 0 and var_55_24 or var_55_24 * (var_55_29 / var_55_28)

				if var_55_30 > 0 and var_55_24 < var_55_30 then
					arg_52_1.talkMaxDuration = var_55_30

					if var_55_30 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_30 + var_55_23
					end
				end

				arg_52_1.text_.text = var_55_27
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_31 = math.max(var_55_24, arg_52_1.talkMaxDuration)

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_23) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_23 + var_55_31 and arg_52_1.time_ < var_55_23 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play938052014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938052014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938052015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["106603"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps106603 == nil then
				arg_56_1.var_.actorSpriteComps106603 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps106603 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 0.5, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps106603 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps106603 = nil
			end

			local var_59_8 = arg_56_1.actors_["106603"].transform
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.var_.moveOldPos106603 = var_59_8.localPosition
				var_59_8.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("106603", 7)

				local var_59_10 = var_59_8.childCount

				for iter_59_4 = 0, var_59_10 - 1 do
					local var_59_11 = var_59_8:GetChild(iter_59_4)

					if var_59_11.name == "" or not string.find(var_59_11.name, "split") then
						var_59_11.gameObject:SetActive(true)
					else
						var_59_11.gameObject:SetActive(false)
					end
				end
			end

			local var_59_12 = 0.001

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_9) / var_59_12
				local var_59_14 = Vector3.New(0, -2000, 0)

				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos106603, var_59_14, var_59_13)
			end

			if arg_56_1.time_ >= var_59_9 + var_59_12 and arg_56_1.time_ < var_59_9 + var_59_12 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_15 = arg_56_1.actors_["10144"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos10144 = var_59_15.localPosition
				var_59_15.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10144", 7)

				local var_59_17 = var_59_15.childCount

				for iter_59_5 = 0, var_59_17 - 1 do
					local var_59_18 = var_59_15:GetChild(iter_59_5)

					if var_59_18.name == "" or not string.find(var_59_18.name, "split") then
						var_59_18.gameObject:SetActive(true)
					else
						var_59_18.gameObject:SetActive(false)
					end
				end
			end

			local var_59_19 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_19 then
				local var_59_20 = (arg_56_1.time_ - var_59_16) / var_59_19
				local var_59_21 = Vector3.New(0, -2000, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10144, var_59_21, var_59_20)
			end

			if arg_56_1.time_ >= var_59_16 + var_59_19 and arg_56_1.time_ < var_59_16 + var_59_19 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_22 = 0
			local var_59_23 = 1.325

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(938052014)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 53
				local var_59_27 = utf8.len(var_59_25)
				local var_59_28 = var_59_26 <= 0 and var_59_23 or var_59_23 * (var_59_27 / var_59_26)

				if var_59_28 > 0 and var_59_23 < var_59_28 then
					arg_56_1.talkMaxDuration = var_59_28

					if var_59_28 + var_59_22 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_28 + var_59_22
					end
				end

				arg_56_1.text_.text = var_59_25
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_29 = math.max(var_59_23, arg_56_1.talkMaxDuration)

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_29 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_22) / var_59_29

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_22 + var_59_29 and arg_56_1.time_ < var_59_22 + var_59_29 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "10144",
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
	Play938052015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938052015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938052016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.2

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(938052015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 8
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play938052016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938052016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938052017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["106603"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps106603 == nil then
				arg_64_1.var_.actorSpriteComps106603 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps106603 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps106603 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps106603 = nil
			end

			local var_67_8 = arg_64_1.actors_["106603"].transform
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.var_.moveOldPos106603 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("106603", 3)

				local var_67_10 = var_67_8.childCount

				for iter_67_4 = 0, var_67_10 - 1 do
					local var_67_11 = var_67_8:GetChild(iter_67_4)

					if var_67_11.name == "split_6" or not string.find(var_67_11.name, "split") then
						var_67_11.gameObject:SetActive(true)
					else
						var_67_11.gameObject:SetActive(false)
					end
				end
			end

			local var_67_12 = 0.001

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_9) / var_67_12
				local var_67_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos106603, var_67_14, var_67_13)
			end

			if arg_64_1.time_ >= var_67_9 + var_67_12 and arg_64_1.time_ < var_67_9 + var_67_12 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_67_15 = 0
			local var_67_16 = 0.075

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[32].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(938052016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 3
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_23 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_23 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_23

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_23 and arg_64_1.time_ < var_67_15 + var_67_23 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play938052017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938052017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938052018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["106603"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps106603 == nil then
				arg_68_1.var_.actorSpriteComps106603 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps106603 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps106603 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps106603 = nil
			end

			local var_71_8 = 0
			local var_71_9 = 0.25

			if var_71_8 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_10 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_11 = arg_68_1:GetWordFromCfg(938052017)
				local var_71_12 = arg_68_1:FormatText(var_71_11.content)

				arg_68_1.text_.text = var_71_12

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 10
				local var_71_14 = utf8.len(var_71_12)
				local var_71_15 = var_71_13 <= 0 and var_71_9 or var_71_9 * (var_71_14 / var_71_13)

				if var_71_15 > 0 and var_71_9 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_12
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play938052018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938052018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938052019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["106603"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps106603 == nil then
				arg_72_1.var_.actorSpriteComps106603 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps106603 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps106603 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps106603 = nil
			end

			local var_75_8 = arg_72_1.actors_["106603"].transform
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.var_.moveOldPos106603 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("106603", 3)

				local var_75_10 = var_75_8.childCount

				for iter_75_4 = 0, var_75_10 - 1 do
					local var_75_11 = var_75_8:GetChild(iter_75_4)

					if var_75_11.name == "split_4" then
						var_75_11:SetAsLastSibling()
						var_75_11.gameObject:SetActive(true)

						arg_72_1.var_.actorSpriteSplit106603 = var_75_11.gameObject:GetComponent(typeof(Image))

						arg_72_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_75_12 = 0.5

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_9) / var_75_12
				local var_75_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos106603, var_75_14, var_75_13)

				if arg_72_1.var_.actorSpriteSplit106603 ~= nil then
					arg_72_1.var_.actorSpriteSplit106603:SetAlpha(var_75_13)
				end
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_72_1.var_.actorSpriteSplit106603 ~= nil then
					arg_72_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_75_15 = 0
			local var_75_16 = 0.175

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[32].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_18 = arg_72_1:GetWordFromCfg(938052018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 7
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_23 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_23 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_23

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_23 and arg_72_1.time_ < var_75_15 + var_75_23 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938052019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938052019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938052020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["106603"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps106603 == nil then
				arg_76_1.var_.actorSpriteComps106603 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps106603 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps106603 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps106603 = nil
			end

			local var_79_8 = arg_76_1.actors_["106603"].transform
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.var_.moveOldPos106603 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("106603", 7)

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

				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos106603, var_79_14, var_79_13)
			end

			if arg_76_1.time_ >= var_79_9 + var_79_12 and arg_76_1.time_ < var_79_9 + var_79_12 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_15 = 0
			local var_79_16 = 0.65

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_17 = arg_76_1:GetWordFromCfg(938052019)
				local var_79_18 = arg_76_1:FormatText(var_79_17.content)

				arg_76_1.text_.text = var_79_18

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_19 = 26
				local var_79_20 = utf8.len(var_79_18)
				local var_79_21 = var_79_19 <= 0 and var_79_16 or var_79_16 * (var_79_20 / var_79_19)

				if var_79_21 > 0 and var_79_16 < var_79_21 then
					arg_76_1.talkMaxDuration = var_79_21

					if var_79_21 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_21 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_18
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_22 and arg_76_1.time_ < var_79_15 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play938052020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938052020
		arg_80_1.duration_ = 5.2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938052021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = manager.ui.mainCamera.transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = var_83_0.localPosition
			end

			local var_83_2 = 0.5

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / 0.066
				local var_83_4, var_83_5 = math.modf(var_83_3)

				var_83_0.localPosition = Vector3.New(var_83_5 * 0.13, var_83_5 * 0.13, var_83_5 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_6 = 0

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_7 = 0.5

			if arg_80_1.time_ >= var_83_6 + var_83_7 and arg_80_1.time_ < var_83_6 + var_83_7 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_8 = 0.2
			local var_83_9 = 0.3

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_10 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_10:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_11 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_12 = arg_80_1:GetWordFromCfg(938052020)
				local var_83_13 = arg_80_1:FormatText(var_83_12.content)

				arg_80_1.text_.text = var_83_13

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_14 = 12
				local var_83_15 = utf8.len(var_83_13)
				local var_83_16 = var_83_14 <= 0 and var_83_9 or var_83_9 * (var_83_15 / var_83_14)

				if var_83_16 > 0 and var_83_9 < var_83_16 then
					arg_80_1.talkMaxDuration = var_83_16
					var_83_8 = var_83_8 + 0.3

					if var_83_16 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_13
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_17 = var_83_8 + 0.3
			local var_83_18 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_17) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_17 + var_83_18 and arg_80_1.time_ < var_83_17 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938052021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938052021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938052022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10144"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_8 = arg_86_1.actors_["10144"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos10144 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10144", 3)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "split_2" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10144, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_89_15 = 0
			local var_89_16 = 0.5

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[1297].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(938052021)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 20
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_23 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_23 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_23

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_23 and arg_86_1.time_ < var_89_15 + var_89_23 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play938052022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938052022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938052023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10144"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10144 == nil then
				arg_90_1.var_.actorSpriteComps10144 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps10144 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10144 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10144 = nil
			end

			local var_93_8 = arg_90_1.actors_["10144"].transform
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.var_.moveOldPos10144 = var_93_8.localPosition
				var_93_8.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10144", 7)

				local var_93_10 = var_93_8.childCount

				for iter_93_4 = 0, var_93_10 - 1 do
					local var_93_11 = var_93_8:GetChild(iter_93_4)

					if var_93_11.name == "" or not string.find(var_93_11.name, "split") then
						var_93_11.gameObject:SetActive(true)
					else
						var_93_11.gameObject:SetActive(false)
					end
				end
			end

			local var_93_12 = 0.001

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_9) / var_93_12
				local var_93_14 = Vector3.New(0, -2000, 0)

				var_93_8.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10144, var_93_14, var_93_13)
			end

			if arg_90_1.time_ >= var_93_9 + var_93_12 and arg_90_1.time_ < var_93_9 + var_93_12 + arg_93_0 then
				var_93_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_93_15 = 0
			local var_93_16 = 0.5

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_18 = arg_90_1:GetWordFromCfg(938052022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 20
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_23 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_23 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_23

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_23 and arg_90_1.time_ < var_93_15 + var_93_23 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938052023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938052023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938052024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["106603"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps106603 == nil then
				arg_94_1.var_.actorSpriteComps106603 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps106603 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps106603 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps106603 = nil
			end

			local var_97_8 = arg_94_1.actors_["106603"].transform
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.var_.moveOldPos106603 = var_97_8.localPosition
				var_97_8.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("106603", 3)

				local var_97_10 = var_97_8.childCount

				for iter_97_4 = 0, var_97_10 - 1 do
					local var_97_11 = var_97_8:GetChild(iter_97_4)

					if var_97_11.name == "" or not string.find(var_97_11.name, "split") then
						var_97_11.gameObject:SetActive(true)
					else
						var_97_11.gameObject:SetActive(false)
					end
				end
			end

			local var_97_12 = 0.001

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_9) / var_97_12
				local var_97_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos106603, var_97_14, var_97_13)
			end

			if arg_94_1.time_ >= var_97_9 + var_97_12 and arg_94_1.time_ < var_97_9 + var_97_12 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_97_15 = 0
			local var_97_16 = 0.775

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_17 = arg_94_1:FormatText(StoryNameCfg[32].name)

				arg_94_1.leftNameTxt_.text = var_97_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(938052023)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 31
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
				actorName = "106603",
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
	Play938052024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938052024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938052025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["106603"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos106603 = var_101_0.localPosition
				var_101_0.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("106603", 3)

				local var_101_2 = var_101_0.childCount

				for iter_101_0 = 0, var_101_2 - 1 do
					local var_101_3 = var_101_0:GetChild(iter_101_0)

					if var_101_3.name == "split_6" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_4 then
				local var_101_5 = (arg_98_1.time_ - var_101_1) / var_101_4
				local var_101_6 = Vector3.New(-77.5, -399.1, -303.3)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos106603, var_101_6, var_101_5)
			end

			if arg_98_1.time_ >= var_101_1 + var_101_4 and arg_98_1.time_ < var_101_1 + var_101_4 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_101_7 = 0
			local var_101_8 = 0.55

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_9 = arg_98_1:FormatText(StoryNameCfg[32].name)

				arg_98_1.leftNameTxt_.text = var_101_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(938052024)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_12 = 22
				local var_101_13 = utf8.len(var_101_11)
				local var_101_14 = var_101_12 <= 0 and var_101_8 or var_101_8 * (var_101_13 / var_101_12)

				if var_101_14 > 0 and var_101_8 < var_101_14 then
					arg_98_1.talkMaxDuration = var_101_14

					if var_101_14 + var_101_7 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_7
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_15 = math.max(var_101_8, arg_98_1.talkMaxDuration)

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_15 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_7) / var_101_15

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_7 + var_101_15 and arg_98_1.time_ < var_101_7 + var_101_15 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play938052025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938052025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938052026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["106603"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps106603 == nil then
				arg_102_1.var_.actorSpriteComps106603 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps106603 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 0.5, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps106603 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps106603 = nil
			end

			local var_105_8 = arg_102_1.actors_["106603"].transform
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1.var_.moveOldPos106603 = var_105_8.localPosition
				var_105_8.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("106603", 7)

				local var_105_10 = var_105_8.childCount

				for iter_105_4 = 0, var_105_10 - 1 do
					local var_105_11 = var_105_8:GetChild(iter_105_4)

					if var_105_11.name == "" or not string.find(var_105_11.name, "split") then
						var_105_11.gameObject:SetActive(true)
					else
						var_105_11.gameObject:SetActive(false)
					end
				end
			end

			local var_105_12 = 0.001

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_9) / var_105_12
				local var_105_14 = Vector3.New(0, -2000, 0)

				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos106603, var_105_14, var_105_13)
			end

			if arg_102_1.time_ >= var_105_9 + var_105_12 and arg_102_1.time_ < var_105_9 + var_105_12 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_105_15 = 0
			local var_105_16 = 0.9

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_17 = arg_102_1:GetWordFromCfg(938052025)
				local var_105_18 = arg_102_1:FormatText(var_105_17.content)

				arg_102_1.text_.text = var_105_18

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_19 = 36
				local var_105_20 = utf8.len(var_105_18)
				local var_105_21 = var_105_19 <= 0 and var_105_16 or var_105_16 * (var_105_20 / var_105_19)

				if var_105_21 > 0 and var_105_16 < var_105_21 then
					arg_102_1.talkMaxDuration = var_105_21

					if var_105_21 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_21 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_18
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_22 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_22 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_22

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_22 and arg_102_1.time_ < var_105_15 + var_105_22 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938052026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938052026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938052027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = "108301"

			if arg_106_1.actors_[var_109_0] == nil then
				local var_109_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_109_1) then
					local var_109_2 = Object.Instantiate(var_109_1, arg_106_1.canvasGo_.transform)

					var_109_2.transform:SetSiblingIndex(1)

					var_109_2.name = var_109_0
					var_109_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_106_1.actors_[var_109_0] = var_109_2

					local var_109_3 = var_109_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_106_1.isInRecall_ then
						for iter_109_0, iter_109_1 in ipairs(var_109_3) do
							iter_109_1.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_109_4 = arg_106_1.actors_["108301"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.actorSpriteComps108301 == nil then
				arg_106_1.var_.actorSpriteComps108301 = var_109_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_6 = 0.2

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.actorSpriteComps108301 then
					for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_109_3 then
							if arg_106_1.isInRecall_ then
								local var_109_8 = Mathf.Lerp(iter_109_3.color.r, arg_106_1.hightColor1.r, var_109_7)
								local var_109_9 = Mathf.Lerp(iter_109_3.color.g, arg_106_1.hightColor1.g, var_109_7)
								local var_109_10 = Mathf.Lerp(iter_109_3.color.b, arg_106_1.hightColor1.b, var_109_7)

								iter_109_3.color = Color.New(var_109_8, var_109_9, var_109_10)
							else
								local var_109_11 = Mathf.Lerp(iter_109_3.color.r, 1, var_109_7)

								iter_109_3.color = Color.New(var_109_11, var_109_11, var_109_11)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.actorSpriteComps108301 then
				for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_109_5 then
						if arg_106_1.isInRecall_ then
							iter_109_5.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps108301 = nil
			end

			local var_109_12 = arg_106_1.actors_["108301"].transform
			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_12.localPosition
				var_109_12.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 2)

				local var_109_14 = var_109_12.childCount

				for iter_109_6 = 0, var_109_14 - 1 do
					local var_109_15 = var_109_12:GetChild(iter_109_6)

					if var_109_15.name == "split_6" or not string.find(var_109_15.name, "split") then
						var_109_15.gameObject:SetActive(true)
					else
						var_109_15.gameObject:SetActive(false)
					end
				end
			end

			local var_109_16 = 0.001

			if var_109_13 <= arg_106_1.time_ and arg_106_1.time_ < var_109_13 + var_109_16 then
				local var_109_17 = (arg_106_1.time_ - var_109_13) / var_109_16
				local var_109_18 = Vector3.New(-420, -360, -195)

				var_109_12.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, var_109_18, var_109_17)
			end

			if arg_106_1.time_ >= var_109_13 + var_109_16 and arg_106_1.time_ < var_109_13 + var_109_16 + arg_109_0 then
				var_109_12.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_109_19 = 0
			local var_109_20 = 0.45

			if var_109_19 < arg_106_1.time_ and arg_106_1.time_ <= var_109_19 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_21 = arg_106_1:FormatText(StoryNameCfg[1332].name)

				arg_106_1.leftNameTxt_.text = var_109_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_22 = arg_106_1:GetWordFromCfg(938052026)
				local var_109_23 = arg_106_1:FormatText(var_109_22.content)

				arg_106_1.text_.text = var_109_23

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_24 = 18
				local var_109_25 = utf8.len(var_109_23)
				local var_109_26 = var_109_24 <= 0 and var_109_20 or var_109_20 * (var_109_25 / var_109_24)

				if var_109_26 > 0 and var_109_20 < var_109_26 then
					arg_106_1.talkMaxDuration = var_109_26

					if var_109_26 + var_109_19 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_26 + var_109_19
					end
				end

				arg_106_1.text_.text = var_109_23
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_27 = math.max(var_109_20, arg_106_1.talkMaxDuration)

			if var_109_19 <= arg_106_1.time_ and arg_106_1.time_ < var_109_19 + var_109_27 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_19) / var_109_27

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_19 + var_109_27 and arg_106_1.time_ < var_109_19 + var_109_27 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play938052027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938052027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938052028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "128404"

			if arg_110_1.actors_[var_113_0] == nil then
				local var_113_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_113_1) then
					local var_113_2 = Object.Instantiate(var_113_1, arg_110_1.canvasGo_.transform)

					var_113_2.transform:SetSiblingIndex(1)

					var_113_2.name = var_113_0
					var_113_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_110_1.actors_[var_113_0] = var_113_2

					local var_113_3 = var_113_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_110_1.isInRecall_ then
						for iter_113_0, iter_113_1 in ipairs(var_113_3) do
							iter_113_1.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_113_4 = arg_110_1.actors_["128404"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.actorSpriteComps128404 == nil then
				arg_110_1.var_.actorSpriteComps128404 = var_113_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_6 = 0.2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.actorSpriteComps128404 then
					for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_113_3 then
							if arg_110_1.isInRecall_ then
								local var_113_8 = Mathf.Lerp(iter_113_3.color.r, arg_110_1.hightColor1.r, var_113_7)
								local var_113_9 = Mathf.Lerp(iter_113_3.color.g, arg_110_1.hightColor1.g, var_113_7)
								local var_113_10 = Mathf.Lerp(iter_113_3.color.b, arg_110_1.hightColor1.b, var_113_7)

								iter_113_3.color = Color.New(var_113_8, var_113_9, var_113_10)
							else
								local var_113_11 = Mathf.Lerp(iter_113_3.color.r, 1, var_113_7)

								iter_113_3.color = Color.New(var_113_11, var_113_11, var_113_11)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.actorSpriteComps128404 then
				for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_113_5 then
						if arg_110_1.isInRecall_ then
							iter_113_5.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps128404 = nil
			end

			local var_113_12 = arg_110_1.actors_["108301"]
			local var_113_13 = 0

			if var_113_13 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 and not isNil(var_113_12) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = var_113_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_14 = 0.2

			if var_113_13 <= arg_110_1.time_ and arg_110_1.time_ < var_113_13 + var_113_14 and not isNil(var_113_12) then
				local var_113_15 = (arg_110_1.time_ - var_113_13) / var_113_14

				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_7 then
							if arg_110_1.isInRecall_ then
								local var_113_16 = Mathf.Lerp(iter_113_7.color.r, arg_110_1.hightColor2.r, var_113_15)
								local var_113_17 = Mathf.Lerp(iter_113_7.color.g, arg_110_1.hightColor2.g, var_113_15)
								local var_113_18 = Mathf.Lerp(iter_113_7.color.b, arg_110_1.hightColor2.b, var_113_15)

								iter_113_7.color = Color.New(var_113_16, var_113_17, var_113_18)
							else
								local var_113_19 = Mathf.Lerp(iter_113_7.color.r, 0.5, var_113_15)

								iter_113_7.color = Color.New(var_113_19, var_113_19, var_113_19)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_13 + var_113_14 and arg_110_1.time_ < var_113_13 + var_113_14 + arg_113_0 and not isNil(var_113_12) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_8, iter_113_9 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_9 then
						if arg_110_1.isInRecall_ then
							iter_113_9.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_20 = arg_110_1.actors_["128404"].transform
			local var_113_21 = 0

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.var_.moveOldPos128404 = var_113_20.localPosition
				var_113_20.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("128404", 4)

				local var_113_22 = var_113_20.childCount

				for iter_113_10 = 0, var_113_22 - 1 do
					local var_113_23 = var_113_20:GetChild(iter_113_10)

					if var_113_23.name == "split_8" or not string.find(var_113_23.name, "split") then
						var_113_23.gameObject:SetActive(true)
					else
						var_113_23.gameObject:SetActive(false)
					end
				end
			end

			local var_113_24 = 0.001

			if var_113_21 <= arg_110_1.time_ and arg_110_1.time_ < var_113_21 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_21) / var_113_24
				local var_113_26 = Vector3.New(390.2, -356, -362.3)

				var_113_20.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, var_113_26, var_113_25)
			end

			if arg_110_1.time_ >= var_113_21 + var_113_24 and arg_110_1.time_ < var_113_21 + var_113_24 + arg_113_0 then
				var_113_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_113_27 = 0
			local var_113_28 = 0.55

			if var_113_27 < arg_110_1.time_ and arg_110_1.time_ <= var_113_27 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_29 = arg_110_1:FormatText(StoryNameCfg[6].name)

				arg_110_1.leftNameTxt_.text = var_113_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_30 = arg_110_1:GetWordFromCfg(938052027)
				local var_113_31 = arg_110_1:FormatText(var_113_30.content)

				arg_110_1.text_.text = var_113_31

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_32 = 22
				local var_113_33 = utf8.len(var_113_31)
				local var_113_34 = var_113_32 <= 0 and var_113_28 or var_113_28 * (var_113_33 / var_113_32)

				if var_113_34 > 0 and var_113_28 < var_113_34 then
					arg_110_1.talkMaxDuration = var_113_34

					if var_113_34 + var_113_27 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_34 + var_113_27
					end
				end

				arg_110_1.text_.text = var_113_31
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_35 = math.max(var_113_28, arg_110_1.talkMaxDuration)

			if var_113_27 <= arg_110_1.time_ and arg_110_1.time_ < var_113_27 + var_113_35 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_27) / var_113_35

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_27 + var_113_35 and arg_110_1.time_ < var_113_27 + var_113_35 + arg_113_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play938052028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938052028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938052029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "104902"

			if arg_114_1.actors_[var_117_0] == nil then
				local var_117_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_117_1) then
					local var_117_2 = Object.Instantiate(var_117_1, arg_114_1.canvasGo_.transform)

					var_117_2.transform:SetSiblingIndex(1)

					var_117_2.name = var_117_0
					var_117_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_114_1.actors_[var_117_0] = var_117_2

					local var_117_3 = var_117_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_114_1.isInRecall_ then
						for iter_117_0, iter_117_1 in ipairs(var_117_3) do
							iter_117_1.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_117_4 = arg_114_1.actors_["104902"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.actorSpriteComps104902 == nil then
				arg_114_1.var_.actorSpriteComps104902 = var_117_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_6 = 0.2

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.actorSpriteComps104902 then
					for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_117_3 then
							if arg_114_1.isInRecall_ then
								local var_117_8 = Mathf.Lerp(iter_117_3.color.r, arg_114_1.hightColor1.r, var_117_7)
								local var_117_9 = Mathf.Lerp(iter_117_3.color.g, arg_114_1.hightColor1.g, var_117_7)
								local var_117_10 = Mathf.Lerp(iter_117_3.color.b, arg_114_1.hightColor1.b, var_117_7)

								iter_117_3.color = Color.New(var_117_8, var_117_9, var_117_10)
							else
								local var_117_11 = Mathf.Lerp(iter_117_3.color.r, 1, var_117_7)

								iter_117_3.color = Color.New(var_117_11, var_117_11, var_117_11)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.actorSpriteComps104902 then
				for iter_117_4, iter_117_5 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_117_5 then
						if arg_114_1.isInRecall_ then
							iter_117_5.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_117_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps104902 = nil
			end

			local var_117_12 = arg_114_1.actors_["128404"]
			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 and not isNil(var_117_12) and arg_114_1.var_.actorSpriteComps128404 == nil then
				arg_114_1.var_.actorSpriteComps128404 = var_117_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_14 = 0.2

			if var_117_13 <= arg_114_1.time_ and arg_114_1.time_ < var_117_13 + var_117_14 and not isNil(var_117_12) then
				local var_117_15 = (arg_114_1.time_ - var_117_13) / var_117_14

				if arg_114_1.var_.actorSpriteComps128404 then
					for iter_117_6, iter_117_7 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_117_7 then
							if arg_114_1.isInRecall_ then
								local var_117_16 = Mathf.Lerp(iter_117_7.color.r, arg_114_1.hightColor2.r, var_117_15)
								local var_117_17 = Mathf.Lerp(iter_117_7.color.g, arg_114_1.hightColor2.g, var_117_15)
								local var_117_18 = Mathf.Lerp(iter_117_7.color.b, arg_114_1.hightColor2.b, var_117_15)

								iter_117_7.color = Color.New(var_117_16, var_117_17, var_117_18)
							else
								local var_117_19 = Mathf.Lerp(iter_117_7.color.r, 0.5, var_117_15)

								iter_117_7.color = Color.New(var_117_19, var_117_19, var_117_19)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_13 + var_117_14 and arg_114_1.time_ < var_117_13 + var_117_14 + arg_117_0 and not isNil(var_117_12) and arg_114_1.var_.actorSpriteComps128404 then
				for iter_117_8, iter_117_9 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_117_9 then
						if arg_114_1.isInRecall_ then
							iter_117_9.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps128404 = nil
			end

			local var_117_20 = arg_114_1.actors_["104902"].transform
			local var_117_21 = 0

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 then
				arg_114_1.var_.moveOldPos104902 = var_117_20.localPosition
				var_117_20.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("104902", 2)

				local var_117_22 = var_117_20.childCount

				for iter_117_10 = 0, var_117_22 - 1 do
					local var_117_23 = var_117_20:GetChild(iter_117_10)

					if var_117_23.name == "split_6" or not string.find(var_117_23.name, "split") then
						var_117_23.gameObject:SetActive(true)
					else
						var_117_23.gameObject:SetActive(false)
					end
				end
			end

			local var_117_24 = 0.001

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_24 then
				local var_117_25 = (arg_114_1.time_ - var_117_21) / var_117_24
				local var_117_26 = Vector3.New(-390, -335, -360)

				var_117_20.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos104902, var_117_26, var_117_25)
			end

			if arg_114_1.time_ >= var_117_21 + var_117_24 and arg_114_1.time_ < var_117_21 + var_117_24 + arg_117_0 then
				var_117_20.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_117_27 = arg_114_1.actors_["108301"].transform
			local var_117_28 = 0

			if var_117_28 < arg_114_1.time_ and arg_114_1.time_ <= var_117_28 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_27.localPosition
				var_117_27.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 7)

				local var_117_29 = var_117_27.childCount

				for iter_117_11 = 0, var_117_29 - 1 do
					local var_117_30 = var_117_27:GetChild(iter_117_11)

					if var_117_30.name == "" or not string.find(var_117_30.name, "split") then
						var_117_30.gameObject:SetActive(true)
					else
						var_117_30.gameObject:SetActive(false)
					end
				end
			end

			local var_117_31 = 0.001

			if var_117_28 <= arg_114_1.time_ and arg_114_1.time_ < var_117_28 + var_117_31 then
				local var_117_32 = (arg_114_1.time_ - var_117_28) / var_117_31
				local var_117_33 = Vector3.New(0, -2000, 0)

				var_117_27.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, var_117_33, var_117_32)
			end

			if arg_114_1.time_ >= var_117_28 + var_117_31 and arg_114_1.time_ < var_117_28 + var_117_31 + arg_117_0 then
				var_117_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_34 = 0
			local var_117_35 = 0.05

			if var_117_34 < arg_114_1.time_ and arg_114_1.time_ <= var_117_34 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_36 = arg_114_1:FormatText(StoryNameCfg[562].name)

				arg_114_1.leftNameTxt_.text = var_117_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_37 = arg_114_1:GetWordFromCfg(938052028)
				local var_117_38 = arg_114_1:FormatText(var_117_37.content)

				arg_114_1.text_.text = var_117_38

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_39 = 2
				local var_117_40 = utf8.len(var_117_38)
				local var_117_41 = var_117_39 <= 0 and var_117_35 or var_117_35 * (var_117_40 / var_117_39)

				if var_117_41 > 0 and var_117_35 < var_117_41 then
					arg_114_1.talkMaxDuration = var_117_41

					if var_117_41 + var_117_34 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_41 + var_117_34
					end
				end

				arg_114_1.text_.text = var_117_38
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_42 = math.max(var_117_35, arg_114_1.talkMaxDuration)

			if var_117_34 <= arg_114_1.time_ and arg_114_1.time_ < var_117_34 + var_117_42 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_34) / var_117_42

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_34 + var_117_42 and arg_114_1.time_ < var_117_34 + var_117_42 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938052029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938052029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938052030(arg_118_1)
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

			local var_121_8 = arg_118_1.actors_["104902"]
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps104902 == nil then
				arg_118_1.var_.actorSpriteComps104902 = var_121_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_10 = 0.2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 and not isNil(var_121_8) then
				local var_121_11 = (arg_118_1.time_ - var_121_9) / var_121_10

				if arg_118_1.var_.actorSpriteComps104902 then
					for iter_121_4, iter_121_5 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_121_5 then
							if arg_118_1.isInRecall_ then
								local var_121_12 = Mathf.Lerp(iter_121_5.color.r, arg_118_1.hightColor2.r, var_121_11)
								local var_121_13 = Mathf.Lerp(iter_121_5.color.g, arg_118_1.hightColor2.g, var_121_11)
								local var_121_14 = Mathf.Lerp(iter_121_5.color.b, arg_118_1.hightColor2.b, var_121_11)

								iter_121_5.color = Color.New(var_121_12, var_121_13, var_121_14)
							else
								local var_121_15 = Mathf.Lerp(iter_121_5.color.r, 0.5, var_121_11)

								iter_121_5.color = Color.New(var_121_15, var_121_15, var_121_15)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps104902 then
				for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_121_7 then
						if arg_118_1.isInRecall_ then
							iter_121_7.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps104902 = nil
			end

			local var_121_16 = arg_118_1.actors_["128404"].transform
			local var_121_17 = 0

			if var_121_17 < arg_118_1.time_ and arg_118_1.time_ <= var_121_17 + arg_121_0 then
				arg_118_1.var_.moveOldPos128404 = var_121_16.localPosition
				var_121_16.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("128404", 4)

				local var_121_18 = var_121_16.childCount

				for iter_121_8 = 0, var_121_18 - 1 do
					local var_121_19 = var_121_16:GetChild(iter_121_8)

					if var_121_19.name == "split_7" then
						var_121_19:SetAsLastSibling()
						var_121_19.gameObject:SetActive(true)

						arg_118_1.var_.actorSpriteSplit128404 = var_121_19.gameObject:GetComponent(typeof(Image))

						arg_118_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_121_20 = 0.5

			if var_121_17 <= arg_118_1.time_ and arg_118_1.time_ < var_121_17 + var_121_20 then
				local var_121_21 = (arg_118_1.time_ - var_121_17) / var_121_20
				local var_121_22 = Vector3.New(390.2, -356, -362.3)

				var_121_16.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos128404, var_121_22, var_121_21)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(var_121_21)
				end
			end

			if arg_118_1.time_ >= var_121_17 + var_121_20 and arg_118_1.time_ < var_121_17 + var_121_20 + arg_121_0 then
				var_121_16.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_121_23 = 0
			local var_121_24 = 0.725

			if var_121_23 < arg_118_1.time_ and arg_118_1.time_ <= var_121_23 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_25 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_26 = arg_118_1:GetWordFromCfg(938052029)
				local var_121_27 = arg_118_1:FormatText(var_121_26.content)

				arg_118_1.text_.text = var_121_27

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_28 = 29
				local var_121_29 = utf8.len(var_121_27)
				local var_121_30 = var_121_28 <= 0 and var_121_24 or var_121_24 * (var_121_29 / var_121_28)

				if var_121_30 > 0 and var_121_24 < var_121_30 then
					arg_118_1.talkMaxDuration = var_121_30

					if var_121_30 + var_121_23 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_30 + var_121_23
					end
				end

				arg_118_1.text_.text = var_121_27
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_31 = math.max(var_121_24, arg_118_1.talkMaxDuration)

			if var_121_23 <= arg_118_1.time_ and arg_118_1.time_ < var_121_23 + var_121_31 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_23) / var_121_31

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_23 + var_121_31 and arg_118_1.time_ < var_121_23 + var_121_31 + arg_121_0 then
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
	Play938052030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938052030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938052031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["104902"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps104902 == nil then
				arg_122_1.var_.actorSpriteComps104902 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps104902 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 1, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps104902 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps104902 = nil
			end

			local var_125_8 = arg_122_1.actors_["128404"]
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = var_125_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_10 = 0.2

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 and not isNil(var_125_8) then
				local var_125_11 = (arg_122_1.time_ - var_125_9) / var_125_10

				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_5 then
							if arg_122_1.isInRecall_ then
								local var_125_12 = Mathf.Lerp(iter_125_5.color.r, arg_122_1.hightColor2.r, var_125_11)
								local var_125_13 = Mathf.Lerp(iter_125_5.color.g, arg_122_1.hightColor2.g, var_125_11)
								local var_125_14 = Mathf.Lerp(iter_125_5.color.b, arg_122_1.hightColor2.b, var_125_11)

								iter_125_5.color = Color.New(var_125_12, var_125_13, var_125_14)
							else
								local var_125_15 = Mathf.Lerp(iter_125_5.color.r, 0.5, var_125_11)

								iter_125_5.color = Color.New(var_125_15, var_125_15, var_125_15)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_6, iter_125_7 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_7 then
						if arg_122_1.isInRecall_ then
							iter_125_7.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_16 = arg_122_1.actors_["104902"].transform
			local var_125_17 = 0

			if var_125_17 < arg_122_1.time_ and arg_122_1.time_ <= var_125_17 + arg_125_0 then
				arg_122_1.var_.moveOldPos104902 = var_125_16.localPosition
				var_125_16.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("104902", 2)

				local var_125_18 = var_125_16.childCount

				for iter_125_8 = 0, var_125_18 - 1 do
					local var_125_19 = var_125_16:GetChild(iter_125_8)

					if var_125_19.name == "split_7" then
						var_125_19:SetAsLastSibling()
						var_125_19.gameObject:SetActive(true)

						arg_122_1.var_.actorSpriteSplit104902 = var_125_19.gameObject:GetComponent(typeof(Image))

						arg_122_1.var_.actorSpriteSplit104902:SetAlpha(0)
					end
				end
			end

			local var_125_20 = 0.5

			if var_125_17 <= arg_122_1.time_ and arg_122_1.time_ < var_125_17 + var_125_20 then
				local var_125_21 = (arg_122_1.time_ - var_125_17) / var_125_20
				local var_125_22 = Vector3.New(-390, -335, -360)

				var_125_16.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos104902, var_125_22, var_125_21)

				if arg_122_1.var_.actorSpriteSplit104902 ~= nil then
					arg_122_1.var_.actorSpriteSplit104902:SetAlpha(var_125_21)
				end
			end

			if arg_122_1.time_ >= var_125_17 + var_125_20 and arg_122_1.time_ < var_125_17 + var_125_20 + arg_125_0 then
				var_125_16.localPosition = Vector3.New(-390, -335, -360)

				if arg_122_1.var_.actorSpriteSplit104902 ~= nil then
					arg_122_1.var_.actorSpriteSplit104902:SetAlpha(1)
				end
			end

			local var_125_23 = 0
			local var_125_24 = 0.175

			if var_125_23 < arg_122_1.time_ and arg_122_1.time_ <= var_125_23 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_25 = arg_122_1:FormatText(StoryNameCfg[562].name)

				arg_122_1.leftNameTxt_.text = var_125_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_26 = arg_122_1:GetWordFromCfg(938052030)
				local var_125_27 = arg_122_1:FormatText(var_125_26.content)

				arg_122_1.text_.text = var_125_27

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_28 = 7
				local var_125_29 = utf8.len(var_125_27)
				local var_125_30 = var_125_28 <= 0 and var_125_24 or var_125_24 * (var_125_29 / var_125_28)

				if var_125_30 > 0 and var_125_24 < var_125_30 then
					arg_122_1.talkMaxDuration = var_125_30

					if var_125_30 + var_125_23 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_30 + var_125_23
					end
				end

				arg_122_1.text_.text = var_125_27
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_31 = math.max(var_125_24, arg_122_1.talkMaxDuration)

			if var_125_23 <= arg_122_1.time_ and arg_122_1.time_ < var_125_23 + var_125_31 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_23) / var_125_31

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_23 + var_125_31 and arg_122_1.time_ < var_125_23 + var_125_31 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play938052031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938052031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938052032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["106603"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps106603 == nil then
				arg_126_1.var_.actorSpriteComps106603 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps106603 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps106603 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps106603 = nil
			end

			local var_129_8 = arg_126_1.actors_["104902"]
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps104902 == nil then
				arg_126_1.var_.actorSpriteComps104902 = var_129_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_10 = 0.2

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_10 and not isNil(var_129_8) then
				local var_129_11 = (arg_126_1.time_ - var_129_9) / var_129_10

				if arg_126_1.var_.actorSpriteComps104902 then
					for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_126_1.time_ >= var_129_9 + var_129_10 and arg_126_1.time_ < var_129_9 + var_129_10 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps104902 then
				for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_129_7 then
						if arg_126_1.isInRecall_ then
							iter_129_7.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps104902 = nil
			end

			local var_129_16 = arg_126_1.actors_["106603"].transform
			local var_129_17 = 0

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 then
				arg_126_1.var_.moveOldPos106603 = var_129_16.localPosition
				var_129_16.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("106603", 3)

				local var_129_18 = var_129_16.childCount

				for iter_129_8 = 0, var_129_18 - 1 do
					local var_129_19 = var_129_16:GetChild(iter_129_8)

					if var_129_19.name == "split_8" or not string.find(var_129_19.name, "split") then
						var_129_19.gameObject:SetActive(true)
					else
						var_129_19.gameObject:SetActive(false)
					end
				end
			end

			local var_129_20 = 0.001

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_20 then
				local var_129_21 = (arg_126_1.time_ - var_129_17) / var_129_20
				local var_129_22 = Vector3.New(-77.5, -399.1, -303.3)

				var_129_16.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos106603, var_129_22, var_129_21)
			end

			if arg_126_1.time_ >= var_129_17 + var_129_20 and arg_126_1.time_ < var_129_17 + var_129_20 + arg_129_0 then
				var_129_16.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_129_23 = arg_126_1.actors_["104902"].transform
			local var_129_24 = 0

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1.var_.moveOldPos104902 = var_129_23.localPosition
				var_129_23.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("104902", 7)

				local var_129_25 = var_129_23.childCount

				for iter_129_9 = 0, var_129_25 - 1 do
					local var_129_26 = var_129_23:GetChild(iter_129_9)

					if var_129_26.name == "" or not string.find(var_129_26.name, "split") then
						var_129_26.gameObject:SetActive(true)
					else
						var_129_26.gameObject:SetActive(false)
					end
				end
			end

			local var_129_27 = 0.001

			if var_129_24 <= arg_126_1.time_ and arg_126_1.time_ < var_129_24 + var_129_27 then
				local var_129_28 = (arg_126_1.time_ - var_129_24) / var_129_27
				local var_129_29 = Vector3.New(0, -2000, -360)

				var_129_23.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos104902, var_129_29, var_129_28)
			end

			if arg_126_1.time_ >= var_129_24 + var_129_27 and arg_126_1.time_ < var_129_24 + var_129_27 + arg_129_0 then
				var_129_23.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_129_30 = arg_126_1.actors_["128404"].transform
			local var_129_31 = 0

			if var_129_31 < arg_126_1.time_ and arg_126_1.time_ <= var_129_31 + arg_129_0 then
				arg_126_1.var_.moveOldPos128404 = var_129_30.localPosition
				var_129_30.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("128404", 7)

				local var_129_32 = var_129_30.childCount

				for iter_129_10 = 0, var_129_32 - 1 do
					local var_129_33 = var_129_30:GetChild(iter_129_10)

					if var_129_33.name == "" or not string.find(var_129_33.name, "split") then
						var_129_33.gameObject:SetActive(true)
					else
						var_129_33.gameObject:SetActive(false)
					end
				end
			end

			local var_129_34 = 0.001

			if var_129_31 <= arg_126_1.time_ and arg_126_1.time_ < var_129_31 + var_129_34 then
				local var_129_35 = (arg_126_1.time_ - var_129_31) / var_129_34
				local var_129_36 = Vector3.New(0, -2000, 0)

				var_129_30.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos128404, var_129_36, var_129_35)
			end

			if arg_126_1.time_ >= var_129_31 + var_129_34 and arg_126_1.time_ < var_129_31 + var_129_34 + arg_129_0 then
				var_129_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_129_37 = 0
			local var_129_38 = 0.575

			if var_129_37 < arg_126_1.time_ and arg_126_1.time_ <= var_129_37 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_39 = arg_126_1:FormatText(StoryNameCfg[32].name)

				arg_126_1.leftNameTxt_.text = var_129_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_40 = arg_126_1:GetWordFromCfg(938052031)
				local var_129_41 = arg_126_1:FormatText(var_129_40.content)

				arg_126_1.text_.text = var_129_41

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_42 = 23
				local var_129_43 = utf8.len(var_129_41)
				local var_129_44 = var_129_42 <= 0 and var_129_38 or var_129_38 * (var_129_43 / var_129_42)

				if var_129_44 > 0 and var_129_38 < var_129_44 then
					arg_126_1.talkMaxDuration = var_129_44

					if var_129_44 + var_129_37 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_44 + var_129_37
					end
				end

				arg_126_1.text_.text = var_129_41
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_45 = math.max(var_129_38, arg_126_1.talkMaxDuration)

			if var_129_37 <= arg_126_1.time_ and arg_126_1.time_ < var_129_37 + var_129_45 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_37) / var_129_45

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_37 + var_129_45 and arg_126_1.time_ < var_129_37 + var_129_45 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938052032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938052032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938052033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["106603"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos106603 = var_133_0.localPosition
				var_133_0.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("106603", 3)

				local var_133_2 = var_133_0.childCount

				for iter_133_0 = 0, var_133_2 - 1 do
					local var_133_3 = var_133_0:GetChild(iter_133_0)

					if var_133_3.name == "split_7" then
						var_133_3:SetAsLastSibling()
						var_133_3.gameObject:SetActive(true)

						arg_130_1.var_.actorSpriteSplit106603 = var_133_3.gameObject:GetComponent(typeof(Image))

						arg_130_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_133_4 = 0.5

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_4 then
				local var_133_5 = (arg_130_1.time_ - var_133_1) / var_133_4
				local var_133_6 = Vector3.New(-77.5, -399.1, -303.3)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos106603, var_133_6, var_133_5)

				if arg_130_1.var_.actorSpriteSplit106603 ~= nil then
					arg_130_1.var_.actorSpriteSplit106603:SetAlpha(var_133_5)
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_4 and arg_130_1.time_ < var_133_1 + var_133_4 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_130_1.var_.actorSpriteSplit106603 ~= nil then
					arg_130_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_133_7 = 0
			local var_133_8 = 0.25

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_9 = arg_130_1:FormatText(StoryNameCfg[32].name)

				arg_130_1.leftNameTxt_.text = var_133_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_10 = arg_130_1:GetWordFromCfg(938052032)
				local var_133_11 = arg_130_1:FormatText(var_133_10.content)

				arg_130_1.text_.text = var_133_11

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_12 = 10
				local var_133_13 = utf8.len(var_133_11)
				local var_133_14 = var_133_12 <= 0 and var_133_8 or var_133_8 * (var_133_13 / var_133_12)

				if var_133_14 > 0 and var_133_8 < var_133_14 then
					arg_130_1.talkMaxDuration = var_133_14

					if var_133_14 + var_133_7 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_7
					end
				end

				arg_130_1.text_.text = var_133_11
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_15 = math.max(var_133_8, arg_130_1.talkMaxDuration)

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_15 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_7) / var_133_15

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_7 + var_133_15 and arg_130_1.time_ < var_133_7 + var_133_15 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play938052033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 938052033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play938052034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10144"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10144 == nil then
				arg_134_1.var_.actorSpriteComps10144 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps10144 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10144 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10144 = nil
			end

			local var_137_8 = arg_134_1.actors_["106603"]
			local var_137_9 = 0

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps106603 == nil then
				arg_134_1.var_.actorSpriteComps106603 = var_137_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_10 = 0.2

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_10 and not isNil(var_137_8) then
				local var_137_11 = (arg_134_1.time_ - var_137_9) / var_137_10

				if arg_134_1.var_.actorSpriteComps106603 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_134_1.time_ >= var_137_9 + var_137_10 and arg_134_1.time_ < var_137_9 + var_137_10 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps106603 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_137_7 then
						if arg_134_1.isInRecall_ then
							iter_137_7.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps106603 = nil
			end

			local var_137_16 = arg_134_1.actors_["10144"].transform
			local var_137_17 = 0

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.var_.moveOldPos10144 = var_137_16.localPosition
				var_137_16.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("10144", 4)

				local var_137_18 = var_137_16.childCount

				for iter_137_8 = 0, var_137_18 - 1 do
					local var_137_19 = var_137_16:GetChild(iter_137_8)

					if var_137_19.name == "split_12" or not string.find(var_137_19.name, "split") then
						var_137_19.gameObject:SetActive(true)
					else
						var_137_19.gameObject:SetActive(false)
					end
				end
			end

			local var_137_20 = 0.001

			if var_137_17 <= arg_134_1.time_ and arg_134_1.time_ < var_137_17 + var_137_20 then
				local var_137_21 = (arg_134_1.time_ - var_137_17) / var_137_20
				local var_137_22 = Vector3.New(435.8, -381.1, -285.9)

				var_137_16.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10144, var_137_22, var_137_21)
			end

			if arg_134_1.time_ >= var_137_17 + var_137_20 and arg_134_1.time_ < var_137_17 + var_137_20 + arg_137_0 then
				var_137_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_137_23 = arg_134_1.actors_["106603"].transform
			local var_137_24 = 0

			if var_137_24 < arg_134_1.time_ and arg_134_1.time_ <= var_137_24 + arg_137_0 then
				arg_134_1.var_.moveOldPos106603 = var_137_23.localPosition
				var_137_23.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("106603", 2)

				local var_137_25 = var_137_23.childCount

				for iter_137_9 = 0, var_137_25 - 1 do
					local var_137_26 = var_137_23:GetChild(iter_137_9)

					if var_137_26.name == "" or not string.find(var_137_26.name, "split") then
						var_137_26.gameObject:SetActive(true)
					else
						var_137_26.gameObject:SetActive(false)
					end
				end
			end

			local var_137_27 = 0.001

			if var_137_24 <= arg_134_1.time_ and arg_134_1.time_ < var_137_24 + var_137_27 then
				local var_137_28 = (arg_134_1.time_ - var_137_24) / var_137_27
				local var_137_29 = Vector3.New(-510.9, -399.1, -303.3)

				var_137_23.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos106603, var_137_29, var_137_28)
			end

			if arg_134_1.time_ >= var_137_24 + var_137_27 and arg_134_1.time_ < var_137_24 + var_137_27 + arg_137_0 then
				var_137_23.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_137_30 = 0
			local var_137_31 = 0.6

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_32 = arg_134_1:FormatText(StoryNameCfg[1297].name)

				arg_134_1.leftNameTxt_.text = var_137_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_33 = arg_134_1:GetWordFromCfg(938052033)
				local var_137_34 = arg_134_1:FormatText(var_137_33.content)

				arg_134_1.text_.text = var_137_34

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_35 = 24
				local var_137_36 = utf8.len(var_137_34)
				local var_137_37 = var_137_35 <= 0 and var_137_31 or var_137_31 * (var_137_36 / var_137_35)

				if var_137_37 > 0 and var_137_31 < var_137_37 then
					arg_134_1.talkMaxDuration = var_137_37

					if var_137_37 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_37 + var_137_30
					end
				end

				arg_134_1.text_.text = var_137_34
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_38 = math.max(var_137_31, arg_134_1.talkMaxDuration)

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_38 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_30) / var_137_38

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_30 + var_137_38 and arg_134_1.time_ < var_137_30 + var_137_38 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play938052034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 938052034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play938052035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["106603"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps106603 == nil then
				arg_138_1.var_.actorSpriteComps106603 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps106603 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps106603 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps106603 = nil
			end

			local var_141_8 = arg_138_1.actors_["10144"]
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps10144 == nil then
				arg_138_1.var_.actorSpriteComps10144 = var_141_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_10 = 0.2

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_10 and not isNil(var_141_8) then
				local var_141_11 = (arg_138_1.time_ - var_141_9) / var_141_10

				if arg_138_1.var_.actorSpriteComps10144 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_138_1.time_ >= var_141_9 + var_141_10 and arg_138_1.time_ < var_141_9 + var_141_10 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps10144 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_141_7 then
						if arg_138_1.isInRecall_ then
							iter_141_7.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10144 = nil
			end

			local var_141_16 = arg_138_1.actors_["106603"].transform
			local var_141_17 = 0

			if var_141_17 < arg_138_1.time_ and arg_138_1.time_ <= var_141_17 + arg_141_0 then
				arg_138_1.var_.moveOldPos106603 = var_141_16.localPosition
				var_141_16.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("106603", 2)

				local var_141_18 = var_141_16.childCount

				for iter_141_8 = 0, var_141_18 - 1 do
					local var_141_19 = var_141_16:GetChild(iter_141_8)

					if var_141_19.name == "split_11" then
						var_141_19:SetAsLastSibling()
						var_141_19.gameObject:SetActive(true)

						arg_138_1.var_.actorSpriteSplit106603 = var_141_19.gameObject:GetComponent(typeof(Image))

						arg_138_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_141_20 = 0.5

			if var_141_17 <= arg_138_1.time_ and arg_138_1.time_ < var_141_17 + var_141_20 then
				local var_141_21 = (arg_138_1.time_ - var_141_17) / var_141_20
				local var_141_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_141_16.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos106603, var_141_22, var_141_21)

				if arg_138_1.var_.actorSpriteSplit106603 ~= nil then
					arg_138_1.var_.actorSpriteSplit106603:SetAlpha(var_141_21)
				end
			end

			if arg_138_1.time_ >= var_141_17 + var_141_20 and arg_138_1.time_ < var_141_17 + var_141_20 + arg_141_0 then
				var_141_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)

				if arg_138_1.var_.actorSpriteSplit106603 ~= nil then
					arg_138_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_141_23 = 0
			local var_141_24 = 0.225

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_25 = arg_138_1:FormatText(StoryNameCfg[32].name)

				arg_138_1.leftNameTxt_.text = var_141_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_26 = arg_138_1:GetWordFromCfg(938052034)
				local var_141_27 = arg_138_1:FormatText(var_141_26.content)

				arg_138_1.text_.text = var_141_27

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_28 = 9
				local var_141_29 = utf8.len(var_141_27)
				local var_141_30 = var_141_28 <= 0 and var_141_24 or var_141_24 * (var_141_29 / var_141_28)

				if var_141_30 > 0 and var_141_24 < var_141_30 then
					arg_138_1.talkMaxDuration = var_141_30

					if var_141_30 + var_141_23 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_30 + var_141_23
					end
				end

				arg_138_1.text_.text = var_141_27
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_31 = math.max(var_141_24, arg_138_1.talkMaxDuration)

			if var_141_23 <= arg_138_1.time_ and arg_138_1.time_ < var_141_23 + var_141_31 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_23) / var_141_31

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_23 + var_141_31 and arg_138_1.time_ < var_141_23 + var_141_31 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play938052035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 938052035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play938052036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10144"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10144 == nil then
				arg_142_1.var_.actorSpriteComps10144 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps10144 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								local var_145_4 = Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, var_145_3)
								local var_145_5 = Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, var_145_3)
								local var_145_6 = Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, var_145_3)

								iter_145_1.color = Color.New(var_145_4, var_145_5, var_145_6)
							else
								local var_145_7 = Mathf.Lerp(iter_145_1.color.r, 1, var_145_3)

								iter_145_1.color = Color.New(var_145_7, var_145_7, var_145_7)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10144 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_145_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10144 = nil
			end

			local var_145_8 = arg_142_1.actors_["106603"]
			local var_145_9 = 0

			if var_145_9 < arg_142_1.time_ and arg_142_1.time_ <= var_145_9 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps106603 == nil then
				arg_142_1.var_.actorSpriteComps106603 = var_145_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_10 = 0.2

			if var_145_9 <= arg_142_1.time_ and arg_142_1.time_ < var_145_9 + var_145_10 and not isNil(var_145_8) then
				local var_145_11 = (arg_142_1.time_ - var_145_9) / var_145_10

				if arg_142_1.var_.actorSpriteComps106603 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								local var_145_12 = Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, var_145_11)
								local var_145_13 = Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, var_145_11)
								local var_145_14 = Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, var_145_11)

								iter_145_5.color = Color.New(var_145_12, var_145_13, var_145_14)
							else
								local var_145_15 = Mathf.Lerp(iter_145_5.color.r, 0.5, var_145_11)

								iter_145_5.color = Color.New(var_145_15, var_145_15, var_145_15)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_9 + var_145_10 and arg_142_1.time_ < var_145_9 + var_145_10 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps106603 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_145_7 then
						if arg_142_1.isInRecall_ then
							iter_145_7.color = arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_145_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps106603 = nil
			end

			local var_145_16 = arg_142_1.actors_["10144"].transform
			local var_145_17 = 0

			if var_145_17 < arg_142_1.time_ and arg_142_1.time_ <= var_145_17 + arg_145_0 then
				arg_142_1.var_.moveOldPos10144 = var_145_16.localPosition
				var_145_16.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10144", 4)

				local var_145_18 = var_145_16.childCount

				for iter_145_8 = 0, var_145_18 - 1 do
					local var_145_19 = var_145_16:GetChild(iter_145_8)

					if var_145_19.name == "split_11" then
						var_145_19:SetAsLastSibling()
						var_145_19.gameObject:SetActive(true)

						arg_142_1.var_.actorSpriteSplit10144 = var_145_19.gameObject:GetComponent(typeof(Image))

						arg_142_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_145_20 = 0.5

			if var_145_17 <= arg_142_1.time_ and arg_142_1.time_ < var_145_17 + var_145_20 then
				local var_145_21 = (arg_142_1.time_ - var_145_17) / var_145_20
				local var_145_22 = Vector3.New(435.8, -381.1, -285.9)

				var_145_16.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10144, var_145_22, var_145_21)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(var_145_21)
				end
			end

			if arg_142_1.time_ >= var_145_17 + var_145_20 and arg_142_1.time_ < var_145_17 + var_145_20 + arg_145_0 then
				var_145_16.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_145_23 = 0
			local var_145_24 = 0.75

			if var_145_23 < arg_142_1.time_ and arg_142_1.time_ <= var_145_23 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_25 = arg_142_1:FormatText(StoryNameCfg[1297].name)

				arg_142_1.leftNameTxt_.text = var_145_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_26 = arg_142_1:GetWordFromCfg(938052035)
				local var_145_27 = arg_142_1:FormatText(var_145_26.content)

				arg_142_1.text_.text = var_145_27

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_28 = 30
				local var_145_29 = utf8.len(var_145_27)
				local var_145_30 = var_145_28 <= 0 and var_145_24 or var_145_24 * (var_145_29 / var_145_28)

				if var_145_30 > 0 and var_145_24 < var_145_30 then
					arg_142_1.talkMaxDuration = var_145_30

					if var_145_30 + var_145_23 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_30 + var_145_23
					end
				end

				arg_142_1.text_.text = var_145_27
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_31 = math.max(var_145_24, arg_142_1.talkMaxDuration)

			if var_145_23 <= arg_142_1.time_ and arg_142_1.time_ < var_145_23 + var_145_31 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_23) / var_145_31

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_23 + var_145_31 and arg_142_1.time_ < var_145_23 + var_145_31 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play938052036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 938052036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
			arg_146_1.auto_ = false
		end

		function arg_146_1.playNext_(arg_148_0)
			arg_146_1.onStoryFinished_()
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10144"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10144 == nil then
				arg_146_1.var_.actorSpriteComps10144 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10144 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 0.5, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10144 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10144 = nil
			end

			local var_149_8 = 0
			local var_149_9 = 0.4

			if var_149_8 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_10 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_11 = arg_146_1:GetWordFromCfg(938052036)
				local var_149_12 = arg_146_1:FormatText(var_149_11.content)

				arg_146_1.text_.text = var_149_12

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_13 = 16
				local var_149_14 = utf8.len(var_149_12)
				local var_149_15 = var_149_13 <= 0 and var_149_9 or var_149_9 * (var_149_14 / var_149_13)

				if var_149_15 > 0 and var_149_9 < var_149_15 then
					arg_146_1.talkMaxDuration = var_149_15

					if var_149_15 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_15 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_12
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_16 and arg_146_1.time_ < var_149_8 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
