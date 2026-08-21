return {
	Play938032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938032002(arg_1_1)
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

			local var_4_24 = 0.3
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

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
			local var_4_35 = 0.325

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(938032001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 13
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938032002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "104902"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

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

			local var_11_4 = arg_8_1.actors_["104902"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps104902 == nil then
				arg_8_1.var_.actorSpriteComps104902 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps104902 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps104902 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps104902 = nil
			end

			local var_11_12 = arg_8_1.actors_["104902"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos104902 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("104902", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_1" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(0, -335, -360)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos104902, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, -335, -360)
			end

			local var_11_19 = arg_8_1.actors_["104902"]
			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				local var_11_21 = var_11_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_11_21 then
					arg_8_1.var_.alphaOldValue104902 = var_11_21.alpha
					arg_8_1.var_.characterEffect104902 = var_11_21
				end

				arg_8_1.var_.alphaOldValue104902 = 0
			end

			local var_11_22 = 0.5

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_22 then
				local var_11_23 = (arg_8_1.time_ - var_11_20) / var_11_22
				local var_11_24 = Mathf.Lerp(arg_8_1.var_.alphaOldValue104902, 1, var_11_23)

				if arg_8_1.var_.characterEffect104902 then
					arg_8_1.var_.characterEffect104902.alpha = var_11_24
				end
			end

			if arg_8_1.time_ >= var_11_20 + var_11_22 and arg_8_1.time_ < var_11_20 + var_11_22 + arg_11_0 and arg_8_1.var_.characterEffect104902 then
				arg_8_1.var_.characterEffect104902.alpha = 1
			end

			local var_11_25 = 0
			local var_11_26 = 0.425

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_27 = arg_8_1:FormatText(StoryNameCfg[562].name)

				arg_8_1.leftNameTxt_.text = var_11_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_28 = arg_8_1:GetWordFromCfg(938032002)
				local var_11_29 = arg_8_1:FormatText(var_11_28.content)

				arg_8_1.text_.text = var_11_29

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_30 = 17
				local var_11_31 = utf8.len(var_11_29)
				local var_11_32 = var_11_30 <= 0 and var_11_26 or var_11_26 * (var_11_31 / var_11_30)

				if var_11_32 > 0 and var_11_26 < var_11_32 then
					arg_8_1.talkMaxDuration = var_11_32

					if var_11_32 + var_11_25 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_32 + var_11_25
					end
				end

				arg_8_1.text_.text = var_11_29
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_33 = math.max(var_11_26, arg_8_1.talkMaxDuration)

			if var_11_25 <= arg_8_1.time_ and arg_8_1.time_ < var_11_25 + var_11_33 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_25) / var_11_33

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_25 + var_11_33 and arg_8_1.time_ < var_11_25 + var_11_33 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play938032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938032003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["104902"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps104902 == nil then
				arg_12_1.var_.actorSpriteComps104902 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps104902 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps104902 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps104902 = nil
			end

			local var_15_8 = 0
			local var_15_9 = 0.4

			if var_15_8 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_10 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_11 = arg_12_1:GetWordFromCfg(938032003)
				local var_15_12 = arg_12_1:FormatText(var_15_11.content)

				arg_12_1.text_.text = var_15_12

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 16
				local var_15_14 = utf8.len(var_15_12)
				local var_15_15 = var_15_13 <= 0 and var_15_9 or var_15_9 * (var_15_14 / var_15_13)

				if var_15_15 > 0 and var_15_9 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_12
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["104902"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos104902 = var_19_0.localPosition
				var_19_0.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("104902", 7)

				local var_19_2 = var_19_0.childCount

				for iter_19_0 = 0, var_19_2 - 1 do
					local var_19_3 = var_19_0:GetChild(iter_19_0)

					if var_19_3.name == "" or not string.find(var_19_3.name, "split") then
						var_19_3.gameObject:SetActive(true)
					else
						var_19_3.gameObject:SetActive(false)
					end
				end
			end

			local var_19_4 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_4 then
				local var_19_5 = (arg_16_1.time_ - var_19_1) / var_19_4
				local var_19_6 = Vector3.New(0, -2000, -360)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos104902, var_19_6, var_19_5)
			end

			if arg_16_1.time_ >= var_19_1 + var_19_4 and arg_16_1.time_ < var_19_1 + var_19_4 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_19_7 = 0
			local var_19_8 = 1.275

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(938032004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 51
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_8 or var_19_8 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_8 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_7 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_7
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_8, arg_16_1.talkMaxDuration)

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_7) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_7 + var_19_14 and arg_16_1.time_ < var_19_7 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play938032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "108301"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

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

			local var_23_4 = arg_20_1.actors_["108301"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps108301 == nil then
				arg_20_1.var_.actorSpriteComps108301 = var_23_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.actorSpriteComps108301 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps108301 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_23_5 then
						if arg_20_1.isInRecall_ then
							iter_23_5.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps108301 = nil
			end

			local var_23_12 = arg_20_1.actors_["108301"].transform
			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1.var_.moveOldPos108301 = var_23_12.localPosition
				var_23_12.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("108301", 3)

				local var_23_14 = var_23_12.childCount

				for iter_23_6 = 0, var_23_14 - 1 do
					local var_23_15 = var_23_12:GetChild(iter_23_6)

					if var_23_15.name == "split_5" or not string.find(var_23_15.name, "split") then
						var_23_15.gameObject:SetActive(true)
					else
						var_23_15.gameObject:SetActive(false)
					end
				end
			end

			local var_23_16 = 0.001

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_16 then
				local var_23_17 = (arg_20_1.time_ - var_23_13) / var_23_16
				local var_23_18 = Vector3.New(0, -360, -195)

				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos108301, var_23_18, var_23_17)
			end

			if arg_20_1.time_ >= var_23_13 + var_23_16 and arg_20_1.time_ < var_23_13 + var_23_16 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, -360, -195)
			end

			local var_23_19 = arg_20_1.actors_["108301"]
			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				local var_23_21 = var_23_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_23_21 then
					arg_20_1.var_.alphaOldValue108301 = var_23_21.alpha
					arg_20_1.var_.characterEffect108301 = var_23_21
				end

				arg_20_1.var_.alphaOldValue108301 = 0
			end

			local var_23_22 = 0.5

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_20) / var_23_22
				local var_23_24 = Mathf.Lerp(arg_20_1.var_.alphaOldValue108301, 1, var_23_23)

				if arg_20_1.var_.characterEffect108301 then
					arg_20_1.var_.characterEffect108301.alpha = var_23_24
				end
			end

			if arg_20_1.time_ >= var_23_20 + var_23_22 and arg_20_1.time_ < var_23_20 + var_23_22 + arg_23_0 and arg_20_1.var_.characterEffect108301 then
				arg_20_1.var_.characterEffect108301.alpha = 1
			end

			local var_23_25 = 0
			local var_23_26 = 0.425

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_27 = arg_20_1:FormatText(StoryNameCfg[1332].name)

				arg_20_1.leftNameTxt_.text = var_23_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_28 = arg_20_1:GetWordFromCfg(938032005)
				local var_23_29 = arg_20_1:FormatText(var_23_28.content)

				arg_20_1.text_.text = var_23_29

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_30 = 17
				local var_23_31 = utf8.len(var_23_29)
				local var_23_32 = var_23_30 <= 0 and var_23_26 or var_23_26 * (var_23_31 / var_23_30)

				if var_23_32 > 0 and var_23_26 < var_23_32 then
					arg_20_1.talkMaxDuration = var_23_32

					if var_23_32 + var_23_25 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_32 + var_23_25
					end
				end

				arg_20_1.text_.text = var_23_29
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_33 = math.max(var_23_26, arg_20_1.talkMaxDuration)

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_33 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_25) / var_23_33

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_25 + var_23_33 and arg_20_1.time_ < var_23_25 + var_23_33 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play938032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938032006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["108301"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps108301 == nil then
				arg_24_1.var_.actorSpriteComps108301 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps108301 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps108301 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps108301 = nil
			end

			local var_27_8 = 0
			local var_27_9 = 0.575

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

				local var_27_11 = arg_24_1:GetWordFromCfg(938032006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 23
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
	Play938032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.975

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(938032007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 39
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play938032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938032008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["108301"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps108301 == nil then
				arg_32_1.var_.actorSpriteComps108301 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps108301 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps108301 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps108301 = nil
			end

			local var_35_8 = arg_32_1.actors_["108301"].transform
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.var_.moveOldPos108301 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("108301", 3)

				local var_35_10 = var_35_8.childCount

				for iter_35_4 = 0, var_35_10 - 1 do
					local var_35_11 = var_35_8:GetChild(iter_35_4)

					if var_35_11.name == "split_1" then
						var_35_11:SetAsLastSibling()
						var_35_11.gameObject:SetActive(true)

						arg_32_1.var_.actorSpriteSplit108301 = var_35_11.gameObject:GetComponent(typeof(Image))

						arg_32_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_35_12 = 0.5

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_9) / var_35_12
				local var_35_14 = Vector3.New(0, -360, -195)

				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos108301, var_35_14, var_35_13)

				if arg_32_1.var_.actorSpriteSplit108301 ~= nil then
					arg_32_1.var_.actorSpriteSplit108301:SetAlpha(var_35_13)
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_12 and arg_32_1.time_ < var_35_9 + var_35_12 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, -360, -195)

				if arg_32_1.var_.actorSpriteSplit108301 ~= nil then
					arg_32_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_35_15 = 0
			local var_35_16 = 0.2

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[1332].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(938032008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 8
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_23 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_23 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_23

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_23 and arg_32_1.time_ < var_35_15 + var_35_23 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play938032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938032009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938032010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["108301"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps108301 == nil then
				arg_36_1.var_.actorSpriteComps108301 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps108301 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor2.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor2.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor2.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 0.5, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps108301 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps108301 = nil
			end

			local var_39_8 = 0
			local var_39_9 = 0.25

			if var_39_8 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_10 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_11 = arg_36_1:GetWordFromCfg(938032009)
				local var_39_12 = arg_36_1:FormatText(var_39_11.content)

				arg_36_1.text_.text = var_39_12

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 10
				local var_39_14 = utf8.len(var_39_12)
				local var_39_15 = var_39_13 <= 0 and var_39_9 or var_39_9 * (var_39_14 / var_39_13)

				if var_39_15 > 0 and var_39_9 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_12
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play938032010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938032010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938032011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["104902"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps104902 == nil then
				arg_40_1.var_.actorSpriteComps104902 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps104902 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps104902 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps104902 = nil
			end

			local var_43_8 = arg_40_1.actors_["108301"].transform
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.var_.moveOldPos108301 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("108301", 7)

				local var_43_10 = var_43_8.childCount

				for iter_43_4 = 0, var_43_10 - 1 do
					local var_43_11 = var_43_8:GetChild(iter_43_4)

					if var_43_11.name == "" or not string.find(var_43_11.name, "split") then
						var_43_11.gameObject:SetActive(true)
					else
						var_43_11.gameObject:SetActive(false)
					end
				end
			end

			local var_43_12 = 0.001

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_9) / var_43_12
				local var_43_14 = Vector3.New(0, -2000, 0)

				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos108301, var_43_14, var_43_13)
			end

			if arg_40_1.time_ >= var_43_9 + var_43_12 and arg_40_1.time_ < var_43_9 + var_43_12 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_15 = arg_40_1.actors_["104902"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos104902 = var_43_15.localPosition
				var_43_15.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("104902", 2)

				local var_43_17 = var_43_15.childCount

				for iter_43_5 = 0, var_43_17 - 1 do
					local var_43_18 = var_43_15:GetChild(iter_43_5)

					if var_43_18.name == "" or not string.find(var_43_18.name, "split") then
						var_43_18.gameObject:SetActive(true)
					else
						var_43_18.gameObject:SetActive(false)
					end
				end
			end

			local var_43_19 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_19 then
				local var_43_20 = (arg_40_1.time_ - var_43_16) / var_43_19
				local var_43_21 = Vector3.New(-390, -335, -360)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos104902, var_43_21, var_43_20)
			end

			if arg_40_1.time_ >= var_43_16 + var_43_19 and arg_40_1.time_ < var_43_16 + var_43_19 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_43_22 = 0
			local var_43_23 = 0.4

			if var_43_22 < arg_40_1.time_ and arg_40_1.time_ <= var_43_22 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_24 = arg_40_1:FormatText(StoryNameCfg[562].name)

				arg_40_1.leftNameTxt_.text = var_43_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_25 = arg_40_1:GetWordFromCfg(938032010)
				local var_43_26 = arg_40_1:FormatText(var_43_25.content)

				arg_40_1.text_.text = var_43_26

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_27 = 16
				local var_43_28 = utf8.len(var_43_26)
				local var_43_29 = var_43_27 <= 0 and var_43_23 or var_43_23 * (var_43_28 / var_43_27)

				if var_43_29 > 0 and var_43_23 < var_43_29 then
					arg_40_1.talkMaxDuration = var_43_29

					if var_43_29 + var_43_22 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_22
					end
				end

				arg_40_1.text_.text = var_43_26
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_30 = math.max(var_43_23, arg_40_1.talkMaxDuration)

			if var_43_22 <= arg_40_1.time_ and arg_40_1.time_ < var_43_22 + var_43_30 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_22) / var_43_30

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_22 + var_43_30 and arg_40_1.time_ < var_43_22 + var_43_30 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
	Play938032011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938032011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938032012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "128404"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(var_47_1, arg_44_1.canvasGo_.transform)

					var_47_2.transform:SetSiblingIndex(1)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_44_1.isInRecall_ then
						for iter_47_0, iter_47_1 in ipairs(var_47_3) do
							iter_47_1.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_47_4 = arg_44_1.actors_["128404"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.actorSpriteComps128404 == nil then
				arg_44_1.var_.actorSpriteComps128404 = var_47_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_6 = 0.2

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.actorSpriteComps128404 then
					for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_47_3 then
							if arg_44_1.isInRecall_ then
								local var_47_8 = Mathf.Lerp(iter_47_3.color.r, arg_44_1.hightColor1.r, var_47_7)
								local var_47_9 = Mathf.Lerp(iter_47_3.color.g, arg_44_1.hightColor1.g, var_47_7)
								local var_47_10 = Mathf.Lerp(iter_47_3.color.b, arg_44_1.hightColor1.b, var_47_7)

								iter_47_3.color = Color.New(var_47_8, var_47_9, var_47_10)
							else
								local var_47_11 = Mathf.Lerp(iter_47_3.color.r, 1, var_47_7)

								iter_47_3.color = Color.New(var_47_11, var_47_11, var_47_11)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.actorSpriteComps128404 then
				for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_47_5 then
						if arg_44_1.isInRecall_ then
							iter_47_5.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps128404 = nil
			end

			local var_47_12 = arg_44_1.actors_["104902"]
			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.actorSpriteComps104902 == nil then
				arg_44_1.var_.actorSpriteComps104902 = var_47_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_14 = 0.2

			if var_47_13 <= arg_44_1.time_ and arg_44_1.time_ < var_47_13 + var_47_14 and not isNil(var_47_12) then
				local var_47_15 = (arg_44_1.time_ - var_47_13) / var_47_14

				if arg_44_1.var_.actorSpriteComps104902 then
					for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_47_7 then
							if arg_44_1.isInRecall_ then
								local var_47_16 = Mathf.Lerp(iter_47_7.color.r, arg_44_1.hightColor2.r, var_47_15)
								local var_47_17 = Mathf.Lerp(iter_47_7.color.g, arg_44_1.hightColor2.g, var_47_15)
								local var_47_18 = Mathf.Lerp(iter_47_7.color.b, arg_44_1.hightColor2.b, var_47_15)

								iter_47_7.color = Color.New(var_47_16, var_47_17, var_47_18)
							else
								local var_47_19 = Mathf.Lerp(iter_47_7.color.r, 0.5, var_47_15)

								iter_47_7.color = Color.New(var_47_19, var_47_19, var_47_19)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_13 + var_47_14 and arg_44_1.time_ < var_47_13 + var_47_14 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.actorSpriteComps104902 then
				for iter_47_8, iter_47_9 in pairs(arg_44_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_47_9 then
						if arg_44_1.isInRecall_ then
							iter_47_9.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps104902 = nil
			end

			local var_47_20 = arg_44_1.actors_["128404"].transform
			local var_47_21 = 0

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.var_.moveOldPos128404 = var_47_20.localPosition
				var_47_20.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("128404", 4)

				local var_47_22 = var_47_20.childCount

				for iter_47_10 = 0, var_47_22 - 1 do
					local var_47_23 = var_47_20:GetChild(iter_47_10)

					if var_47_23.name == "split_3" or not string.find(var_47_23.name, "split") then
						var_47_23.gameObject:SetActive(true)
					else
						var_47_23.gameObject:SetActive(false)
					end
				end
			end

			local var_47_24 = 0.001

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_21) / var_47_24
				local var_47_26 = Vector3.New(390.2, -356, -362.3)

				var_47_20.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos128404, var_47_26, var_47_25)
			end

			if arg_44_1.time_ >= var_47_21 + var_47_24 and arg_44_1.time_ < var_47_21 + var_47_24 + arg_47_0 then
				var_47_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_47_27 = 0
			local var_47_28 = 0.175

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_29 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(938032011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 7
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_35 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_27) / var_47_35

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_27 + var_47_35 and arg_44_1.time_ < var_47_27 + var_47_35 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play938032012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938032012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938032013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["128404"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps128404 == nil then
				arg_48_1.var_.actorSpriteComps128404 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps128404 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 0.5, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps128404 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps128404 = nil
			end

			local var_51_8 = arg_48_1.actors_["128404"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos128404 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("128404", 7)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(0, -2000, 0)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos128404, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_51_15 = arg_48_1.actors_["104902"].transform
			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.var_.moveOldPos104902 = var_51_15.localPosition
				var_51_15.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("104902", 7)

				local var_51_17 = var_51_15.childCount

				for iter_51_5 = 0, var_51_17 - 1 do
					local var_51_18 = var_51_15:GetChild(iter_51_5)

					if var_51_18.name == "" or not string.find(var_51_18.name, "split") then
						var_51_18.gameObject:SetActive(true)
					else
						var_51_18.gameObject:SetActive(false)
					end
				end
			end

			local var_51_19 = 0.001

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_19 then
				local var_51_20 = (arg_48_1.time_ - var_51_16) / var_51_19
				local var_51_21 = Vector3.New(0, -2000, -360)

				var_51_15.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos104902, var_51_21, var_51_20)
			end

			if arg_48_1.time_ >= var_51_16 + var_51_19 and arg_48_1.time_ < var_51_16 + var_51_19 + arg_51_0 then
				var_51_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_51_22 = 0
			local var_51_23 = 1.6

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(938032012)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 64
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_23 or var_51_23 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_23 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_22
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_29 = math.max(var_51_23, arg_48_1.talkMaxDuration)

			if var_51_22 <= arg_48_1.time_ and arg_48_1.time_ < var_51_22 + var_51_29 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_22) / var_51_29

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_22 + var_51_29 and arg_48_1.time_ < var_51_22 + var_51_29 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
				actorName = "104902",
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
	Play938032013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938032013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938032014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "106603"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(var_55_1, arg_52_1.canvasGo_.transform)

					var_55_2.transform:SetSiblingIndex(1)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_52_1.isInRecall_ then
						for iter_55_0, iter_55_1 in ipairs(var_55_3) do
							iter_55_1.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_55_4 = arg_52_1.actors_["106603"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.actorSpriteComps106603 == nil then
				arg_52_1.var_.actorSpriteComps106603 = var_55_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_6 = 0.2

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.actorSpriteComps106603 then
					for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_55_3 then
							if arg_52_1.isInRecall_ then
								local var_55_8 = Mathf.Lerp(iter_55_3.color.r, arg_52_1.hightColor1.r, var_55_7)
								local var_55_9 = Mathf.Lerp(iter_55_3.color.g, arg_52_1.hightColor1.g, var_55_7)
								local var_55_10 = Mathf.Lerp(iter_55_3.color.b, arg_52_1.hightColor1.b, var_55_7)

								iter_55_3.color = Color.New(var_55_8, var_55_9, var_55_10)
							else
								local var_55_11 = Mathf.Lerp(iter_55_3.color.r, 1, var_55_7)

								iter_55_3.color = Color.New(var_55_11, var_55_11, var_55_11)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.actorSpriteComps106603 then
				for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_55_5 then
						if arg_52_1.isInRecall_ then
							iter_55_5.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps106603 = nil
			end

			local var_55_12 = arg_52_1.actors_["106603"].transform
			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1.var_.moveOldPos106603 = var_55_12.localPosition
				var_55_12.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("106603", 2)

				local var_55_14 = var_55_12.childCount

				for iter_55_6 = 0, var_55_14 - 1 do
					local var_55_15 = var_55_12:GetChild(iter_55_6)

					if var_55_15.name == "split_1" or not string.find(var_55_15.name, "split") then
						var_55_15.gameObject:SetActive(true)
					else
						var_55_15.gameObject:SetActive(false)
					end
				end
			end

			local var_55_16 = 0.001

			if var_55_13 <= arg_52_1.time_ and arg_52_1.time_ < var_55_13 + var_55_16 then
				local var_55_17 = (arg_52_1.time_ - var_55_13) / var_55_16
				local var_55_18 = Vector3.New(-510.9, -399.1, -303.3)

				var_55_12.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos106603, var_55_18, var_55_17)
			end

			if arg_52_1.time_ >= var_55_13 + var_55_16 and arg_52_1.time_ < var_55_13 + var_55_16 + arg_55_0 then
				var_55_12.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_55_19 = 0
			local var_55_20 = 0.875

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_21 = arg_52_1:FormatText(StoryNameCfg[32].name)

				arg_52_1.leftNameTxt_.text = var_55_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_22 = arg_52_1:GetWordFromCfg(938032013)
				local var_55_23 = arg_52_1:FormatText(var_55_22.content)

				arg_52_1.text_.text = var_55_23

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_24 = 35
				local var_55_25 = utf8.len(var_55_23)
				local var_55_26 = var_55_24 <= 0 and var_55_20 or var_55_20 * (var_55_25 / var_55_24)

				if var_55_26 > 0 and var_55_20 < var_55_26 then
					arg_52_1.talkMaxDuration = var_55_26

					if var_55_26 + var_55_19 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_26 + var_55_19
					end
				end

				arg_52_1.text_.text = var_55_23
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_27 = math.max(var_55_20, arg_52_1.talkMaxDuration)

			if var_55_19 <= arg_52_1.time_ and arg_52_1.time_ < var_55_19 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_19) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_19 + var_55_27 and arg_52_1.time_ < var_55_19 + var_55_27 + arg_55_0 then
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
	Play938032014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938032014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938032015(arg_56_1)
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

			local var_59_8 = 0
			local var_59_9 = 0.15

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_10 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_11 = arg_56_1:GetWordFromCfg(938032014)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 6
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_9 or var_59_9 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_9 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_16 and arg_56_1.time_ < var_59_8 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play938032015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938032015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938032016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["128404"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps128404 == nil then
				arg_60_1.var_.actorSpriteComps128404 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps128404 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps128404 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps128404 = nil
			end

			local var_63_8 = arg_60_1.actors_["128404"].transform
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.var_.moveOldPos128404 = var_63_8.localPosition
				var_63_8.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("128404", 4)

				local var_63_10 = var_63_8.childCount

				for iter_63_4 = 0, var_63_10 - 1 do
					local var_63_11 = var_63_8:GetChild(iter_63_4)

					if var_63_11.name == "split_4" or not string.find(var_63_11.name, "split") then
						var_63_11.gameObject:SetActive(true)
					else
						var_63_11.gameObject:SetActive(false)
					end
				end
			end

			local var_63_12 = 0.001

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_9) / var_63_12
				local var_63_14 = Vector3.New(390.2, -356, -362.3)

				var_63_8.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos128404, var_63_14, var_63_13)
			end

			if arg_60_1.time_ >= var_63_9 + var_63_12 and arg_60_1.time_ < var_63_9 + var_63_12 + arg_63_0 then
				var_63_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_63_15 = 0
			local var_63_16 = 0.35

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(938032015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 14
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_23 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_23 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_23

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_23 and arg_60_1.time_ < var_63_15 + var_63_23 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play938032016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938032016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938032017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["104902"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps104902 == nil then
				arg_64_1.var_.actorSpriteComps104902 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps104902 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps104902 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps104902 = nil
			end

			local var_67_8 = arg_64_1.actors_["128404"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps128404 == nil then
				arg_64_1.var_.actorSpriteComps128404 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps128404 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps128404 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps128404 = nil
			end

			local var_67_16 = arg_64_1.actors_["104902"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos104902 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("104902", 4)

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
				local var_67_22 = Vector3.New(390, -335, -360)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos104902, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_67_23 = arg_64_1.actors_["128404"].transform
			local var_67_24 = 0

			if var_67_24 < arg_64_1.time_ and arg_64_1.time_ <= var_67_24 + arg_67_0 then
				arg_64_1.var_.moveOldPos128404 = var_67_23.localPosition
				var_67_23.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("128404", 7)

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
				local var_67_29 = Vector3.New(0, -2000, 0)

				var_67_23.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos128404, var_67_29, var_67_28)
			end

			if arg_64_1.time_ >= var_67_24 + var_67_27 and arg_64_1.time_ < var_67_24 + var_67_27 + arg_67_0 then
				var_67_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_30 = 0
			local var_67_31 = 0.625

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[562].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(938032016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 25
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

		arg_64_1:InitPlayNodeList()
	end,
	Play938032017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938032017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938032018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["104902"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps104902 == nil then
				arg_68_1.var_.actorSpriteComps104902 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps104902 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps104902 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps104902 = nil
			end

			local var_71_8 = 0
			local var_71_9 = 0.525

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

				local var_71_11 = arg_68_1:GetWordFromCfg(938032017)
				local var_71_12 = arg_68_1:FormatText(var_71_11.content)

				arg_68_1.text_.text = var_71_12

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 21
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
	Play938032018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938032018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938032019(arg_72_1)
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

				arg_72_1:CheckSpriteTmpPos("106603", 2)

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
				local var_75_14 = Vector3.New(-510.9, -399.1, -303.3)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos106603, var_75_14, var_75_13)
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_75_15 = 0
			local var_75_16 = 0.325

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

				local var_75_18 = arg_72_1:GetWordFromCfg(938032018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 13
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938032019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938032019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938032020(arg_76_1)
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

			local var_79_15 = arg_76_1.actors_["104902"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos104902 = var_79_15.localPosition
				var_79_15.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("104902", 7)

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
				local var_79_21 = Vector3.New(0, -2000, 0)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos104902, var_79_21, var_79_20)
			end

			if arg_76_1.time_ >= var_79_16 + var_79_19 and arg_76_1.time_ < var_79_16 + var_79_19 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_22 = 0
			local var_79_23 = 1.525

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(938032019)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 61
				local var_79_27 = utf8.len(var_79_25)
				local var_79_28 = var_79_26 <= 0 and var_79_23 or var_79_23 * (var_79_27 / var_79_26)

				if var_79_28 > 0 and var_79_23 < var_79_28 then
					arg_76_1.talkMaxDuration = var_79_28

					if var_79_28 + var_79_22 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_22
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_29 = math.max(var_79_23, arg_76_1.talkMaxDuration)

			if var_79_22 <= arg_76_1.time_ and arg_76_1.time_ < var_79_22 + var_79_29 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_22) / var_79_29

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_22 + var_79_29 and arg_76_1.time_ < var_79_22 + var_79_29 + arg_79_0 then
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

		arg_76_1:InitPlayNodeList()
	end,
	Play938032020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938032020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938032021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = manager.ui.mainCamera.transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = var_83_0.localPosition
			end

			local var_83_2 = 0.266666666666667

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / 0.066
				local var_83_4, var_83_5 = math.modf(var_83_3)

				var_83_0.localPosition = Vector3.New(var_83_5 * 0.13, var_83_5 * 0.13, var_83_5 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_6 = manager.ui.mainCamera.transform
			local var_83_7 = 0.366666666666667

			if var_83_7 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = var_83_6.localPosition
			end

			local var_83_8 = 0.3

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_8 then
				local var_83_9 = (arg_80_1.time_ - var_83_7) / 0.066
				local var_83_10, var_83_11 = math.modf(var_83_9)

				var_83_6.localPosition = Vector3.New(var_83_11 * 0.13, var_83_11 * 0.13, var_83_11 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= var_83_7 + var_83_8 and arg_80_1.time_ < var_83_7 + var_83_8 + arg_83_0 then
				var_83_6.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_13 = 0.666666666666667

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_14 = 0
			local var_83_15 = 0.1

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_16 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_16:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[1561].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_18 = arg_80_1:GetWordFromCfg(938032020)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 4
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_15 or var_83_15 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_15 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22
					var_83_14 = var_83_14 + 0.3

					if var_83_22 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_23 = var_83_14 + 0.3
			local var_83_24 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_23) / var_83_24

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938032021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938032021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938032022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["106603"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps106603 == nil then
				arg_86_1.var_.actorSpriteComps106603 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps106603 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps106603 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps106603 = nil
			end

			local var_89_8 = arg_86_1.actors_["106603"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos106603 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("106603", 2)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(-510.9, -399.1, -303.3)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos106603, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_89_15 = 0
			local var_89_16 = 0.075

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[32].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(938032021)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 3
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
				actorName = "106603",
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
	Play938032022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938032022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938032023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["104902"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps104902 == nil then
				arg_90_1.var_.actorSpriteComps104902 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps104902 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps104902 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps104902 = nil
			end

			local var_93_8 = arg_90_1.actors_["106603"]
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps106603 == nil then
				arg_90_1.var_.actorSpriteComps106603 = var_93_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_10 = 0.2

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_10 and not isNil(var_93_8) then
				local var_93_11 = (arg_90_1.time_ - var_93_9) / var_93_10

				if arg_90_1.var_.actorSpriteComps106603 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_90_1.time_ >= var_93_9 + var_93_10 and arg_90_1.time_ < var_93_9 + var_93_10 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps106603 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_93_7 then
						if arg_90_1.isInRecall_ then
							iter_93_7.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps106603 = nil
			end

			local var_93_16 = arg_90_1.actors_["104902"].transform
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.var_.moveOldPos104902 = var_93_16.localPosition
				var_93_16.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("104902", 4)

				local var_93_18 = var_93_16.childCount

				for iter_93_8 = 0, var_93_18 - 1 do
					local var_93_19 = var_93_16:GetChild(iter_93_8)

					if var_93_19.name == "" or not string.find(var_93_19.name, "split") then
						var_93_19.gameObject:SetActive(true)
					else
						var_93_19.gameObject:SetActive(false)
					end
				end
			end

			local var_93_20 = 0.001

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_20 then
				local var_93_21 = (arg_90_1.time_ - var_93_17) / var_93_20
				local var_93_22 = Vector3.New(390, -335, -360)

				var_93_16.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos104902, var_93_22, var_93_21)
			end

			if arg_90_1.time_ >= var_93_17 + var_93_20 and arg_90_1.time_ < var_93_17 + var_93_20 + arg_93_0 then
				var_93_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_93_23 = 0
			local var_93_24 = 0.2

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_25 = arg_90_1:FormatText(StoryNameCfg[562].name)

				arg_90_1.leftNameTxt_.text = var_93_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_26 = arg_90_1:GetWordFromCfg(938032022)
				local var_93_27 = arg_90_1:FormatText(var_93_26.content)

				arg_90_1.text_.text = var_93_27

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_28 = 8
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
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_31 = math.max(var_93_24, arg_90_1.talkMaxDuration)

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_31 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_23) / var_93_31

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_23 + var_93_31 and arg_90_1.time_ < var_93_23 + var_93_31 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938032023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938032023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938032024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["108301"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps108301 == nil then
				arg_94_1.var_.actorSpriteComps108301 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps108301 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps108301 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps108301 = nil
			end

			local var_97_8 = arg_94_1.actors_["104902"]
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps104902 == nil then
				arg_94_1.var_.actorSpriteComps104902 = var_97_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_10 = 0.2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 and not isNil(var_97_8) then
				local var_97_11 = (arg_94_1.time_ - var_97_9) / var_97_10

				if arg_94_1.var_.actorSpriteComps104902 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps104902 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_97_7 then
						if arg_94_1.isInRecall_ then
							iter_97_7.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps104902 = nil
			end

			local var_97_16 = arg_94_1.actors_["108301"].transform
			local var_97_17 = 0

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				arg_94_1.var_.moveOldPos108301 = var_97_16.localPosition
				var_97_16.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("108301", 2)

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
				local var_97_22 = Vector3.New(-420, -360, -195)

				var_97_16.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos108301, var_97_22, var_97_21)
			end

			if arg_94_1.time_ >= var_97_17 + var_97_20 and arg_94_1.time_ < var_97_17 + var_97_20 + arg_97_0 then
				var_97_16.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_97_23 = arg_94_1.actors_["106603"].transform
			local var_97_24 = 0

			if var_97_24 < arg_94_1.time_ and arg_94_1.time_ <= var_97_24 + arg_97_0 then
				arg_94_1.var_.moveOldPos106603 = var_97_23.localPosition
				var_97_23.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("106603", 7)

				local var_97_25 = var_97_23.childCount

				for iter_97_9 = 0, var_97_25 - 1 do
					local var_97_26 = var_97_23:GetChild(iter_97_9)

					if var_97_26.name == "" or not string.find(var_97_26.name, "split") then
						var_97_26.gameObject:SetActive(true)
					else
						var_97_26.gameObject:SetActive(false)
					end
				end
			end

			local var_97_27 = 0.001

			if var_97_24 <= arg_94_1.time_ and arg_94_1.time_ < var_97_24 + var_97_27 then
				local var_97_28 = (arg_94_1.time_ - var_97_24) / var_97_27
				local var_97_29 = Vector3.New(0, -2000, 0)

				var_97_23.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos106603, var_97_29, var_97_28)
			end

			if arg_94_1.time_ >= var_97_24 + var_97_27 and arg_94_1.time_ < var_97_24 + var_97_27 + arg_97_0 then
				var_97_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_97_30 = 0
			local var_97_31 = 0.3

			if var_97_30 < arg_94_1.time_ and arg_94_1.time_ <= var_97_30 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_32 = arg_94_1:FormatText(StoryNameCfg[1332].name)

				arg_94_1.leftNameTxt_.text = var_97_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_33 = arg_94_1:GetWordFromCfg(938032023)
				local var_97_34 = arg_94_1:FormatText(var_97_33.content)

				arg_94_1.text_.text = var_97_34

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_35 = 12
				local var_97_36 = utf8.len(var_97_34)
				local var_97_37 = var_97_35 <= 0 and var_97_31 or var_97_31 * (var_97_36 / var_97_35)

				if var_97_37 > 0 and var_97_31 < var_97_37 then
					arg_94_1.talkMaxDuration = var_97_37

					if var_97_37 + var_97_30 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_37 + var_97_30
					end
				end

				arg_94_1.text_.text = var_97_34
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_38 = math.max(var_97_31, arg_94_1.talkMaxDuration)

			if var_97_30 <= arg_94_1.time_ and arg_94_1.time_ < var_97_30 + var_97_38 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_30) / var_97_38

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_30 + var_97_38 and arg_94_1.time_ < var_97_30 + var_97_38 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
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

		arg_94_1:InitPlayNodeList()
	end,
	Play938032024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938032024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938032025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["108301"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps108301 == nil then
				arg_98_1.var_.actorSpriteComps108301 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps108301 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps108301 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps108301 = nil
			end

			local var_101_8 = arg_98_1.actors_["108301"].transform
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.var_.moveOldPos108301 = var_101_8.localPosition
				var_101_8.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("108301", 7)

				local var_101_10 = var_101_8.childCount

				for iter_101_4 = 0, var_101_10 - 1 do
					local var_101_11 = var_101_8:GetChild(iter_101_4)

					if var_101_11.name == "" or not string.find(var_101_11.name, "split") then
						var_101_11.gameObject:SetActive(true)
					else
						var_101_11.gameObject:SetActive(false)
					end
				end
			end

			local var_101_12 = 0.001

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_9) / var_101_12
				local var_101_14 = Vector3.New(0, -2000, 0)

				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos108301, var_101_14, var_101_13)
			end

			if arg_98_1.time_ >= var_101_9 + var_101_12 and arg_98_1.time_ < var_101_9 + var_101_12 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_101_15 = arg_98_1.actors_["104902"].transform
			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.var_.moveOldPos104902 = var_101_15.localPosition
				var_101_15.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("104902", 7)

				local var_101_17 = var_101_15.childCount

				for iter_101_5 = 0, var_101_17 - 1 do
					local var_101_18 = var_101_15:GetChild(iter_101_5)

					if var_101_18.name == "" or not string.find(var_101_18.name, "split") then
						var_101_18.gameObject:SetActive(true)
					else
						var_101_18.gameObject:SetActive(false)
					end
				end
			end

			local var_101_19 = 0.001

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_19 then
				local var_101_20 = (arg_98_1.time_ - var_101_16) / var_101_19
				local var_101_21 = Vector3.New(0, -2000, -360)

				var_101_15.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos104902, var_101_21, var_101_20)
			end

			if arg_98_1.time_ >= var_101_16 + var_101_19 and arg_98_1.time_ < var_101_16 + var_101_19 + arg_101_0 then
				var_101_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_101_22 = 0
			local var_101_23 = 1

			if var_101_22 < arg_98_1.time_ and arg_98_1.time_ <= var_101_22 + arg_101_0 then
				local var_101_24 = "play"
				local var_101_25 = "effect"

				arg_98_1:AudioAction(var_101_24, var_101_25, "se_story_152", "se_story_152_jump_down", "")
			end

			local var_101_26 = 0
			local var_101_27 = 1.575

			if var_101_26 < arg_98_1.time_ and arg_98_1.time_ <= var_101_26 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_28 = arg_98_1:GetWordFromCfg(938032024)
				local var_101_29 = arg_98_1:FormatText(var_101_28.content)

				arg_98_1.text_.text = var_101_29

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_30 = 63
				local var_101_31 = utf8.len(var_101_29)
				local var_101_32 = var_101_30 <= 0 and var_101_27 or var_101_27 * (var_101_31 / var_101_30)

				if var_101_32 > 0 and var_101_27 < var_101_32 then
					arg_98_1.talkMaxDuration = var_101_32

					if var_101_32 + var_101_26 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_32 + var_101_26
					end
				end

				arg_98_1.text_.text = var_101_29
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_33 = math.max(var_101_27, arg_98_1.talkMaxDuration)

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_33 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_26) / var_101_33

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_26 + var_101_33 and arg_98_1.time_ < var_101_26 + var_101_33 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "104902",
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
	Play938032025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938032025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938032026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = manager.ui.mainCamera.transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.shakeOldPos = var_105_0.localPosition
			end

			local var_105_2 = 1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / 0.066
				local var_105_4, var_105_5 = math.modf(var_105_3)

				var_105_0.localPosition = Vector3.New(var_105_5 * 0.13, var_105_5 * 0.13, var_105_5 * 0.13) + arg_102_1.var_.shakeOldPos
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = arg_102_1.var_.shakeOldPos
			end

			local var_105_6 = 0

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			local var_105_7 = 1

			if arg_102_1.time_ >= var_105_6 + var_105_7 and arg_102_1.time_ < var_105_6 + var_105_7 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			local var_105_8 = 0
			local var_105_9 = 0.225

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[1561].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_11 = arg_102_1:GetWordFromCfg(938032025)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 9
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
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_16 and arg_102_1.time_ < var_105_8 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play938032026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938032026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938032027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.25

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(938032026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 10
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
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play938032027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938032027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938032028(arg_110_1)
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

				arg_110_1:CheckSpriteTmpPos("128404", 3)

				local var_113_10 = var_113_8.childCount

				for iter_113_4 = 0, var_113_10 - 1 do
					local var_113_11 = var_113_8:GetChild(iter_113_4)

					if var_113_11.name == "split_3" or not string.find(var_113_11.name, "split") then
						var_113_11.gameObject:SetActive(true)
					else
						var_113_11.gameObject:SetActive(false)
					end
				end
			end

			local var_113_12 = 0.001

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_12 then
				local var_113_13 = (arg_110_1.time_ - var_113_9) / var_113_12
				local var_113_14 = Vector3.New(-16.1, -362, -375)

				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, var_113_14, var_113_13)
			end

			if arg_110_1.time_ >= var_113_9 + var_113_12 and arg_110_1.time_ < var_113_9 + var_113_12 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_113_15 = 0
			local var_113_16 = 0.125

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

				local var_113_18 = arg_110_1:GetWordFromCfg(938032027)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 5
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play938032028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938032028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938032029(arg_114_1)
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

			local var_117_8 = arg_114_1.actors_["128404"].transform
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.var_.moveOldPos128404 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("128404", 7)

				local var_117_10 = var_117_8.childCount

				for iter_117_4 = 0, var_117_10 - 1 do
					local var_117_11 = var_117_8:GetChild(iter_117_4)

					if var_117_11.name == "" or not string.find(var_117_11.name, "split") then
						var_117_11.gameObject:SetActive(true)
					else
						var_117_11.gameObject:SetActive(false)
					end
				end
			end

			local var_117_12 = 0.001

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_12 then
				local var_117_13 = (arg_114_1.time_ - var_117_9) / var_117_12
				local var_117_14 = Vector3.New(0, -2000, 0)

				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos128404, var_117_14, var_117_13)
			end

			if arg_114_1.time_ >= var_117_9 + var_117_12 and arg_114_1.time_ < var_117_9 + var_117_12 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_15 = 0
			local var_117_16 = 1.325

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_17 = arg_114_1:GetWordFromCfg(938032028)
				local var_117_18 = arg_114_1:FormatText(var_117_17.content)

				arg_114_1.text_.text = var_117_18

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_19 = 53
				local var_117_20 = utf8.len(var_117_18)
				local var_117_21 = var_117_19 <= 0 and var_117_16 or var_117_16 * (var_117_20 / var_117_19)

				if var_117_21 > 0 and var_117_16 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21

					if var_117_21 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_18
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_22 and arg_114_1.time_ < var_117_15 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938032029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938032029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938032030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.925

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(938032029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 37
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play938032030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938032030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938032031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = "10183"

			if arg_122_1.actors_[var_125_0] == nil then
				local var_125_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_125_1) then
					local var_125_2 = Object.Instantiate(var_125_1, arg_122_1.canvasGo_.transform)

					var_125_2.transform:SetSiblingIndex(1)

					var_125_2.name = var_125_0
					var_125_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_122_1.actors_[var_125_0] = var_125_2

					local var_125_3 = var_125_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_122_1.isInRecall_ then
						for iter_125_0, iter_125_1 in ipairs(var_125_3) do
							iter_125_1.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_125_4 = arg_122_1.actors_["10183"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.actorSpriteComps10183 == nil then
				arg_122_1.var_.actorSpriteComps10183 = var_125_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_6 = 0.2

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.actorSpriteComps10183 then
					for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_125_3 then
							if arg_122_1.isInRecall_ then
								local var_125_8 = Mathf.Lerp(iter_125_3.color.r, arg_122_1.hightColor1.r, var_125_7)
								local var_125_9 = Mathf.Lerp(iter_125_3.color.g, arg_122_1.hightColor1.g, var_125_7)
								local var_125_10 = Mathf.Lerp(iter_125_3.color.b, arg_122_1.hightColor1.b, var_125_7)

								iter_125_3.color = Color.New(var_125_8, var_125_9, var_125_10)
							else
								local var_125_11 = Mathf.Lerp(iter_125_3.color.r, 1, var_125_7)

								iter_125_3.color = Color.New(var_125_11, var_125_11, var_125_11)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.actorSpriteComps10183 then
				for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_125_5 then
						if arg_122_1.isInRecall_ then
							iter_125_5.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps10183 = nil
			end

			local var_125_12 = arg_122_1.actors_["10183"].transform
			local var_125_13 = 0

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1.var_.moveOldPos10183 = var_125_12.localPosition
				var_125_12.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("10183", 2)

				local var_125_14 = var_125_12.childCount

				for iter_125_6 = 0, var_125_14 - 1 do
					local var_125_15 = var_125_12:GetChild(iter_125_6)

					if var_125_15.name == "" or not string.find(var_125_15.name, "split") then
						var_125_15.gameObject:SetActive(true)
					else
						var_125_15.gameObject:SetActive(false)
					end
				end
			end

			local var_125_16 = 0.001

			if var_125_13 <= arg_122_1.time_ and arg_122_1.time_ < var_125_13 + var_125_16 then
				local var_125_17 = (arg_122_1.time_ - var_125_13) / var_125_16
				local var_125_18 = Vector3.New(-300, -475, -325)

				var_125_12.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10183, var_125_18, var_125_17)
			end

			if arg_122_1.time_ >= var_125_13 + var_125_16 and arg_122_1.time_ < var_125_13 + var_125_16 + arg_125_0 then
				var_125_12.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_125_19 = arg_122_1.actors_["10183"]
			local var_125_20 = 0

			if var_125_20 < arg_122_1.time_ and arg_122_1.time_ <= var_125_20 + arg_125_0 then
				local var_125_21 = var_125_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_125_21 then
					arg_122_1.var_.alphaOldValue10183 = var_125_21.alpha
					arg_122_1.var_.characterEffect10183 = var_125_21
				end

				arg_122_1.var_.alphaOldValue10183 = 0
			end

			local var_125_22 = 0.5

			if var_125_20 <= arg_122_1.time_ and arg_122_1.time_ < var_125_20 + var_125_22 then
				local var_125_23 = (arg_122_1.time_ - var_125_20) / var_125_22
				local var_125_24 = Mathf.Lerp(arg_122_1.var_.alphaOldValue10183, 1, var_125_23)

				if arg_122_1.var_.characterEffect10183 then
					arg_122_1.var_.characterEffect10183.alpha = var_125_24
				end
			end

			if arg_122_1.time_ >= var_125_20 + var_125_22 and arg_122_1.time_ < var_125_20 + var_125_22 + arg_125_0 and arg_122_1.var_.characterEffect10183 then
				arg_122_1.var_.characterEffect10183.alpha = 1
			end

			local var_125_25 = 0
			local var_125_26 = 0.975

			if var_125_25 < arg_122_1.time_ and arg_122_1.time_ <= var_125_25 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_27 = arg_122_1:FormatText(StoryNameCfg[36].name)

				arg_122_1.leftNameTxt_.text = var_125_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_28 = arg_122_1:GetWordFromCfg(938032030)
				local var_125_29 = arg_122_1:FormatText(var_125_28.content)

				arg_122_1.text_.text = var_125_29

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_30 = 39
				local var_125_31 = utf8.len(var_125_29)
				local var_125_32 = var_125_30 <= 0 and var_125_26 or var_125_26 * (var_125_31 / var_125_30)

				if var_125_32 > 0 and var_125_26 < var_125_32 then
					arg_122_1.talkMaxDuration = var_125_32

					if var_125_32 + var_125_25 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_32 + var_125_25
					end
				end

				arg_122_1.text_.text = var_125_29
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_33 = math.max(var_125_26, arg_122_1.talkMaxDuration)

			if var_125_25 <= arg_122_1.time_ and arg_122_1.time_ < var_125_25 + var_125_33 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_25) / var_125_33

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_25 + var_125_33 and arg_122_1.time_ < var_125_25 + var_125_33 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play938032031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938032031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938032032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "10144"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(var_129_1, arg_126_1.canvasGo_.transform)

					var_129_2.transform:SetSiblingIndex(1)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_126_1.isInRecall_ then
						for iter_129_0, iter_129_1 in ipairs(var_129_3) do
							iter_129_1.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_129_4 = arg_126_1.actors_["10144"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.actorSpriteComps10144 == nil then
				arg_126_1.var_.actorSpriteComps10144 = var_129_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_6 = 0.2

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.actorSpriteComps10144 then
					for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_129_3 then
							if arg_126_1.isInRecall_ then
								local var_129_8 = Mathf.Lerp(iter_129_3.color.r, arg_126_1.hightColor1.r, var_129_7)
								local var_129_9 = Mathf.Lerp(iter_129_3.color.g, arg_126_1.hightColor1.g, var_129_7)
								local var_129_10 = Mathf.Lerp(iter_129_3.color.b, arg_126_1.hightColor1.b, var_129_7)

								iter_129_3.color = Color.New(var_129_8, var_129_9, var_129_10)
							else
								local var_129_11 = Mathf.Lerp(iter_129_3.color.r, 1, var_129_7)

								iter_129_3.color = Color.New(var_129_11, var_129_11, var_129_11)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.actorSpriteComps10144 then
				for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_129_5 then
						if arg_126_1.isInRecall_ then
							iter_129_5.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps10144 = nil
			end

			local var_129_12 = arg_126_1.actors_["10183"]
			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 and not isNil(var_129_12) and arg_126_1.var_.actorSpriteComps10183 == nil then
				arg_126_1.var_.actorSpriteComps10183 = var_129_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_14 = 0.2

			if var_129_13 <= arg_126_1.time_ and arg_126_1.time_ < var_129_13 + var_129_14 and not isNil(var_129_12) then
				local var_129_15 = (arg_126_1.time_ - var_129_13) / var_129_14

				if arg_126_1.var_.actorSpriteComps10183 then
					for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_129_7 then
							if arg_126_1.isInRecall_ then
								local var_129_16 = Mathf.Lerp(iter_129_7.color.r, arg_126_1.hightColor2.r, var_129_15)
								local var_129_17 = Mathf.Lerp(iter_129_7.color.g, arg_126_1.hightColor2.g, var_129_15)
								local var_129_18 = Mathf.Lerp(iter_129_7.color.b, arg_126_1.hightColor2.b, var_129_15)

								iter_129_7.color = Color.New(var_129_16, var_129_17, var_129_18)
							else
								local var_129_19 = Mathf.Lerp(iter_129_7.color.r, 0.5, var_129_15)

								iter_129_7.color = Color.New(var_129_19, var_129_19, var_129_19)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_13 + var_129_14 and arg_126_1.time_ < var_129_13 + var_129_14 + arg_129_0 and not isNil(var_129_12) and arg_126_1.var_.actorSpriteComps10183 then
				for iter_129_8, iter_129_9 in pairs(arg_126_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_129_9 then
						if arg_126_1.isInRecall_ then
							iter_129_9.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps10183 = nil
			end

			local var_129_20 = arg_126_1.actors_["10144"].transform
			local var_129_21 = 0

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 then
				arg_126_1.var_.moveOldPos10144 = var_129_20.localPosition
				var_129_20.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("10144", 4)

				local var_129_22 = var_129_20.childCount

				for iter_129_10 = 0, var_129_22 - 1 do
					local var_129_23 = var_129_20:GetChild(iter_129_10)

					if var_129_23.name == "split_3" or not string.find(var_129_23.name, "split") then
						var_129_23.gameObject:SetActive(true)
					else
						var_129_23.gameObject:SetActive(false)
					end
				end
			end

			local var_129_24 = 0.001

			if var_129_21 <= arg_126_1.time_ and arg_126_1.time_ < var_129_21 + var_129_24 then
				local var_129_25 = (arg_126_1.time_ - var_129_21) / var_129_24
				local var_129_26 = Vector3.New(435.8, -381.1, -285.9)

				var_129_20.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10144, var_129_26, var_129_25)
			end

			if arg_126_1.time_ >= var_129_21 + var_129_24 and arg_126_1.time_ < var_129_21 + var_129_24 + arg_129_0 then
				var_129_20.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_129_27 = arg_126_1.actors_["10144"]
			local var_129_28 = 0

			if var_129_28 < arg_126_1.time_ and arg_126_1.time_ <= var_129_28 + arg_129_0 then
				local var_129_29 = var_129_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_129_29 then
					arg_126_1.var_.alphaOldValue10144 = var_129_29.alpha
					arg_126_1.var_.characterEffect10144 = var_129_29
				end

				arg_126_1.var_.alphaOldValue10144 = 0
			end

			local var_129_30 = 0.0166666666666667

			if var_129_28 <= arg_126_1.time_ and arg_126_1.time_ < var_129_28 + var_129_30 then
				local var_129_31 = (arg_126_1.time_ - var_129_28) / var_129_30
				local var_129_32 = Mathf.Lerp(arg_126_1.var_.alphaOldValue10144, 1, var_129_31)

				if arg_126_1.var_.characterEffect10144 then
					arg_126_1.var_.characterEffect10144.alpha = var_129_32
				end
			end

			if arg_126_1.time_ >= var_129_28 + var_129_30 and arg_126_1.time_ < var_129_28 + var_129_30 + arg_129_0 and arg_126_1.var_.characterEffect10144 then
				arg_126_1.var_.characterEffect10144.alpha = 1
			end

			local var_129_33 = 0
			local var_129_34 = 0.25

			if var_129_33 < arg_126_1.time_ and arg_126_1.time_ <= var_129_33 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_35 = arg_126_1:FormatText(StoryNameCfg[1297].name)

				arg_126_1.leftNameTxt_.text = var_129_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_36 = arg_126_1:GetWordFromCfg(938032031)
				local var_129_37 = arg_126_1:FormatText(var_129_36.content)

				arg_126_1.text_.text = var_129_37

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_38 = 10
				local var_129_39 = utf8.len(var_129_37)
				local var_129_40 = var_129_38 <= 0 and var_129_34 or var_129_34 * (var_129_39 / var_129_38)

				if var_129_40 > 0 and var_129_34 < var_129_40 then
					arg_126_1.talkMaxDuration = var_129_40

					if var_129_40 + var_129_33 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_40 + var_129_33
					end
				end

				arg_126_1.text_.text = var_129_37
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_41 = math.max(var_129_34, arg_126_1.talkMaxDuration)

			if var_129_33 <= arg_126_1.time_ and arg_126_1.time_ < var_129_33 + var_129_41 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_33) / var_129_41

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_33 + var_129_41 and arg_126_1.time_ < var_129_33 + var_129_41 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938032032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938032032
		arg_130_1.duration_ = 5.91

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938032033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10144"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10144 == nil then
				arg_130_1.var_.actorSpriteComps10144 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps10144 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 0.5, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10144 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps10144 = nil
			end

			local var_133_8 = arg_130_1.actors_["10144"].transform
			local var_133_9 = 0

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.var_.moveOldPos10144 = var_133_8.localPosition
				var_133_8.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10144", 7)

				local var_133_10 = var_133_8.childCount

				for iter_133_4 = 0, var_133_10 - 1 do
					local var_133_11 = var_133_8:GetChild(iter_133_4)

					if var_133_11.name == "" or not string.find(var_133_11.name, "split") then
						var_133_11.gameObject:SetActive(true)
					else
						var_133_11.gameObject:SetActive(false)
					end
				end
			end

			local var_133_12 = 0.001

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_12 then
				local var_133_13 = (arg_130_1.time_ - var_133_9) / var_133_12
				local var_133_14 = Vector3.New(0, -2000, 0)

				var_133_8.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10144, var_133_14, var_133_13)
			end

			if arg_130_1.time_ >= var_133_9 + var_133_12 and arg_130_1.time_ < var_133_9 + var_133_12 + arg_133_0 then
				var_133_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_15 = arg_130_1.actors_["10183"].transform
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.var_.moveOldPos10183 = var_133_15.localPosition
				var_133_15.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10183", 7)

				local var_133_17 = var_133_15.childCount

				for iter_133_5 = 0, var_133_17 - 1 do
					local var_133_18 = var_133_15:GetChild(iter_133_5)

					if var_133_18.name == "" or not string.find(var_133_18.name, "split") then
						var_133_18.gameObject:SetActive(true)
					else
						var_133_18.gameObject:SetActive(false)
					end
				end
			end

			local var_133_19 = 0.001

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_19 then
				local var_133_20 = (arg_130_1.time_ - var_133_16) / var_133_19
				local var_133_21 = Vector3.New(0, -2000, 0)

				var_133_15.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10183, var_133_21, var_133_20)
			end

			if arg_130_1.time_ >= var_133_16 + var_133_19 and arg_130_1.time_ < var_133_16 + var_133_19 + arg_133_0 then
				var_133_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_22 = manager.ui.mainCamera.transform
			local var_133_23 = 0

			if var_133_23 < arg_130_1.time_ and arg_130_1.time_ <= var_133_23 + arg_133_0 then
				arg_130_1.var_.shakeOldPos = var_133_22.localPosition
			end

			local var_133_24 = 0.6

			if var_133_23 <= arg_130_1.time_ and arg_130_1.time_ < var_133_23 + var_133_24 then
				local var_133_25 = (arg_130_1.time_ - var_133_23) / 0.066
				local var_133_26, var_133_27 = math.modf(var_133_25)

				var_133_22.localPosition = Vector3.New(var_133_27 * 0.13, var_133_27 * 0.13, var_133_27 * 0.13) + arg_130_1.var_.shakeOldPos
			end

			if arg_130_1.time_ >= var_133_23 + var_133_24 and arg_130_1.time_ < var_133_23 + var_133_24 + arg_133_0 then
				var_133_22.localPosition = arg_130_1.var_.shakeOldPos
			end

			local var_133_28 = manager.ui.mainCamera.transform
			local var_133_29 = 0

			if var_133_29 < arg_130_1.time_ and arg_130_1.time_ <= var_133_29 + arg_133_0 then
				local var_133_30 = arg_130_1.var_.effectfeizoule1
				local var_133_31
				local var_133_32 = var_133_28

				if not var_133_30 then
					var_133_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_133_32)
					var_133_30.name = "feizoule1"
					arg_130_1.var_.effectfeizoule1 = var_133_30
				else
					var_133_30.transform:SetParent(var_133_32)
				end

				var_133_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_133_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_133_33 = 1.7777777777777777
				local var_133_34 = Screen.width / Screen.height
				local var_133_35 = var_133_34 / var_133_33
				local var_133_36 = Mathf.Max(var_133_33 / var_133_34, 1)

				var_133_30.transform.localScale = Vector3.New(var_133_30.transform.localScale.x * var_133_35, var_133_30.transform.localScale.y * var_133_36, var_133_30.transform.localScale.z)
			end

			local var_133_37 = 0

			if var_133_37 < arg_130_1.time_ and arg_130_1.time_ <= var_133_37 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_38 = 1.93774389754981

			if arg_130_1.time_ >= var_133_37 + var_133_38 and arg_130_1.time_ < var_133_37 + var_133_38 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_39 = 0.912743897549
			local var_133_40 = 1.025

			if var_133_39 < arg_130_1.time_ and arg_130_1.time_ <= var_133_39 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_41 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_41:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_42 = arg_130_1:GetWordFromCfg(938032032)
				local var_133_43 = arg_130_1:FormatText(var_133_42.content)

				arg_130_1.text_.text = var_133_43

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_44 = 41
				local var_133_45 = utf8.len(var_133_43)
				local var_133_46 = var_133_44 <= 0 and var_133_40 or var_133_40 * (var_133_45 / var_133_44)

				if var_133_46 > 0 and var_133_40 < var_133_46 then
					arg_130_1.talkMaxDuration = var_133_46
					var_133_39 = var_133_39 + 0.3

					if var_133_46 + var_133_39 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_46 + var_133_39
					end
				end

				arg_130_1.text_.text = var_133_43
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_47 = var_133_39 + 0.3
			local var_133_48 = math.max(var_133_40, arg_130_1.talkMaxDuration)

			if var_133_47 <= arg_130_1.time_ and arg_130_1.time_ < var_133_47 + var_133_48 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_47) / var_133_48

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_47 + var_133_48 and arg_130_1.time_ < var_133_47 + var_133_48 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play938032033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938032033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938032034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.625

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(938032033)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 25
				local var_139_5 = utf8.len(var_139_3)
				local var_139_6 = var_139_4 <= 0 and var_139_1 or var_139_1 * (var_139_5 / var_139_4)

				if var_139_6 > 0 and var_139_1 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_7 and arg_136_1.time_ < var_139_0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play938032034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938032034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938032035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10183"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps10183 == nil then
				arg_140_1.var_.actorSpriteComps10183 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps10183 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 1, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps10183 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps10183 = nil
			end

			local var_143_8 = arg_140_1.actors_["10183"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos10183 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10183", 2)

				local var_143_10 = var_143_8.childCount

				for iter_143_4 = 0, var_143_10 - 1 do
					local var_143_11 = var_143_8:GetChild(iter_143_4)

					if var_143_11.name == "split_6" or not string.find(var_143_11.name, "split") then
						var_143_11.gameObject:SetActive(true)
					else
						var_143_11.gameObject:SetActive(false)
					end
				end
			end

			local var_143_12 = 0.001

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_12 then
				local var_143_13 = (arg_140_1.time_ - var_143_9) / var_143_12
				local var_143_14 = Vector3.New(-300, -475, -325)

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10183, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_143_15 = 0
			local var_143_16 = 0.7

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_17 = arg_140_1:FormatText(StoryNameCfg[36].name)

				arg_140_1.leftNameTxt_.text = var_143_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_18 = arg_140_1:GetWordFromCfg(938032034)
				local var_143_19 = arg_140_1:FormatText(var_143_18.content)

				arg_140_1.text_.text = var_143_19

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_20 = 28
				local var_143_21 = utf8.len(var_143_19)
				local var_143_22 = var_143_20 <= 0 and var_143_16 or var_143_16 * (var_143_21 / var_143_20)

				if var_143_22 > 0 and var_143_16 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22

					if var_143_22 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_15
					end
				end

				arg_140_1.text_.text = var_143_19
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_23 = math.max(var_143_16, arg_140_1.talkMaxDuration)

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_23 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_15) / var_143_23

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_15 + var_143_23 and arg_140_1.time_ < var_143_15 + var_143_23 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play938032035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938032035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938032036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10144"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10144 == nil then
				arg_144_1.var_.actorSpriteComps10144 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps10144 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 1, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10144 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10144 = nil
			end

			local var_147_8 = arg_144_1.actors_["10183"]
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps10183 == nil then
				arg_144_1.var_.actorSpriteComps10183 = var_147_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_10 = 0.2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 and not isNil(var_147_8) then
				local var_147_11 = (arg_144_1.time_ - var_147_9) / var_147_10

				if arg_144_1.var_.actorSpriteComps10183 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								local var_147_12 = Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor2.r, var_147_11)
								local var_147_13 = Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor2.g, var_147_11)
								local var_147_14 = Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor2.b, var_147_11)

								iter_147_5.color = Color.New(var_147_12, var_147_13, var_147_14)
							else
								local var_147_15 = Mathf.Lerp(iter_147_5.color.r, 0.5, var_147_11)

								iter_147_5.color = Color.New(var_147_15, var_147_15, var_147_15)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps10183 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_147_7 then
						if arg_144_1.isInRecall_ then
							iter_147_7.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10183 = nil
			end

			local var_147_16 = arg_144_1.actors_["10144"].transform
			local var_147_17 = 0

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1.var_.moveOldPos10144 = var_147_16.localPosition
				var_147_16.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10144", 4)

				local var_147_18 = var_147_16.childCount

				for iter_147_8 = 0, var_147_18 - 1 do
					local var_147_19 = var_147_16:GetChild(iter_147_8)

					if var_147_19.name == "split_6" or not string.find(var_147_19.name, "split") then
						var_147_19.gameObject:SetActive(true)
					else
						var_147_19.gameObject:SetActive(false)
					end
				end
			end

			local var_147_20 = 0.001

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_20 then
				local var_147_21 = (arg_144_1.time_ - var_147_17) / var_147_20
				local var_147_22 = Vector3.New(435.8, -381.1, -285.9)

				var_147_16.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10144, var_147_22, var_147_21)
			end

			if arg_144_1.time_ >= var_147_17 + var_147_20 and arg_144_1.time_ < var_147_17 + var_147_20 + arg_147_0 then
				var_147_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_147_23 = 0
			local var_147_24 = 0.325

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_25 = arg_144_1:FormatText(StoryNameCfg[1297].name)

				arg_144_1.leftNameTxt_.text = var_147_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_26 = arg_144_1:GetWordFromCfg(938032035)
				local var_147_27 = arg_144_1:FormatText(var_147_26.content)

				arg_144_1.text_.text = var_147_27

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_28 = 13
				local var_147_29 = utf8.len(var_147_27)
				local var_147_30 = var_147_28 <= 0 and var_147_24 or var_147_24 * (var_147_29 / var_147_28)

				if var_147_30 > 0 and var_147_24 < var_147_30 then
					arg_144_1.talkMaxDuration = var_147_30

					if var_147_30 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_30 + var_147_23
					end
				end

				arg_144_1.text_.text = var_147_27
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_31 = math.max(var_147_24, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_31 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_31

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_31 and arg_144_1.time_ < var_147_23 + var_147_31 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play938032036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 938032036
		arg_148_1.duration_ = 5.6

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play938032037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10144"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10144 == nil then
				arg_148_1.var_.actorSpriteComps10144 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10144 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 0.5, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10144 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10144 = nil
			end

			local var_151_8 = arg_148_1.actors_["10144"].transform
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.var_.moveOldPos10144 = var_151_8.localPosition
				var_151_8.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10144", 7)

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
				local var_151_14 = Vector3.New(0, -2000, 0)

				var_151_8.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10144, var_151_14, var_151_13)
			end

			if arg_148_1.time_ >= var_151_9 + var_151_12 and arg_148_1.time_ < var_151_9 + var_151_12 + arg_151_0 then
				var_151_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_151_15 = arg_148_1.actors_["10183"].transform
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.var_.moveOldPos10183 = var_151_15.localPosition
				var_151_15.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10183", 7)

				local var_151_17 = var_151_15.childCount

				for iter_151_5 = 0, var_151_17 - 1 do
					local var_151_18 = var_151_15:GetChild(iter_151_5)

					if var_151_18.name == "" or not string.find(var_151_18.name, "split") then
						var_151_18.gameObject:SetActive(true)
					else
						var_151_18.gameObject:SetActive(false)
					end
				end
			end

			local var_151_19 = 0.001

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_19 then
				local var_151_20 = (arg_148_1.time_ - var_151_16) / var_151_19
				local var_151_21 = Vector3.New(0, -2000, 0)

				var_151_15.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10183, var_151_21, var_151_20)
			end

			if arg_148_1.time_ >= var_151_16 + var_151_19 and arg_148_1.time_ < var_151_16 + var_151_19 + arg_151_0 then
				var_151_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_151_22 = manager.ui.mainCamera.transform
			local var_151_23 = 0

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				local var_151_24 = arg_148_1.var_.effectdaleyiquan1
				local var_151_25
				local var_151_26 = var_151_22

				if not var_151_24 then
					var_151_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_151_26)
					var_151_24.name = "daleyiquan1"
					arg_148_1.var_.effectdaleyiquan1 = var_151_24
				else
					var_151_24.transform:SetParent(var_151_26)
				end

				var_151_24.transform.localPosition = Vector3.New(0, -0.52, 0)
				var_151_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_151_27 = 1.7777777777777777
				local var_151_28 = Screen.width / Screen.height
				local var_151_29 = var_151_28 / var_151_27
				local var_151_30 = Mathf.Max(var_151_27 / var_151_28, 1)

				var_151_24.transform.localScale = Vector3.New(var_151_24.transform.localScale.x * var_151_29, var_151_24.transform.localScale.y * var_151_30, var_151_24.transform.localScale.z)
			end

			local var_151_31 = manager.ui.mainCamera.transform
			local var_151_32 = 1.5

			if var_151_32 < arg_148_1.time_ and arg_148_1.time_ <= var_151_32 + arg_151_0 then
				local var_151_33 = arg_148_1.var_.effectdaleyiquan1

				if var_151_33 then
					Object.Destroy(var_151_33)

					arg_148_1.var_.effectdaleyiquan1 = nil
				end
			end

			local var_151_34 = manager.ui.mainCamera.transform
			local var_151_35 = 0

			if var_151_35 < arg_148_1.time_ and arg_148_1.time_ <= var_151_35 + arg_151_0 then
				arg_148_1.var_.shakeOldPos = var_151_34.localPosition
			end

			local var_151_36 = 0.6

			if var_151_35 <= arg_148_1.time_ and arg_148_1.time_ < var_151_35 + var_151_36 then
				local var_151_37 = (arg_148_1.time_ - var_151_35) / 0.066
				local var_151_38, var_151_39 = math.modf(var_151_37)

				var_151_34.localPosition = Vector3.New(var_151_39 * 0.13, var_151_39 * 0.13, var_151_39 * 0.13) + arg_148_1.var_.shakeOldPos
			end

			if arg_148_1.time_ >= var_151_35 + var_151_36 and arg_148_1.time_ < var_151_35 + var_151_36 + arg_151_0 then
				var_151_34.localPosition = arg_148_1.var_.shakeOldPos
			end

			local var_151_40 = 0

			if var_151_40 < arg_148_1.time_ and arg_148_1.time_ <= var_151_40 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_41 = 1.5

			if arg_148_1.time_ >= var_151_40 + var_151_41 and arg_148_1.time_ < var_151_40 + var_151_41 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_42 = 0.6
			local var_151_43 = 0.9

			if var_151_42 < arg_148_1.time_ and arg_148_1.time_ <= var_151_42 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_44 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_44:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_45 = arg_148_1:GetWordFromCfg(938032036)
				local var_151_46 = arg_148_1:FormatText(var_151_45.content)

				arg_148_1.text_.text = var_151_46

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_47 = 36
				local var_151_48 = utf8.len(var_151_46)
				local var_151_49 = var_151_47 <= 0 and var_151_43 or var_151_43 * (var_151_48 / var_151_47)

				if var_151_49 > 0 and var_151_43 < var_151_49 then
					arg_148_1.talkMaxDuration = var_151_49
					var_151_42 = var_151_42 + 0.3

					if var_151_49 + var_151_42 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_49 + var_151_42
					end
				end

				arg_148_1.text_.text = var_151_46
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_50 = var_151_42 + 0.3
			local var_151_51 = math.max(var_151_43, arg_148_1.talkMaxDuration)

			if var_151_50 <= arg_148_1.time_ and arg_148_1.time_ < var_151_50 + var_151_51 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_50) / var_151_51

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_50 + var_151_51 and arg_148_1.time_ < var_151_50 + var_151_51 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "10183",
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
	Play938032037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938032037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938032038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 1.05

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(938032037)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 42
				local var_157_5 = utf8.len(var_157_3)
				local var_157_6 = var_157_4 <= 0 and var_157_1 or var_157_1 * (var_157_5 / var_157_4)

				if var_157_6 > 0 and var_157_1 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_7 and arg_154_1.time_ < var_157_0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play938032038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938032038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938032039(arg_158_1)
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
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor1.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor1.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor1.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 1, var_161_3)

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
							iter_161_3.color = arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_161_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps10144 = nil
			end

			local var_161_8 = arg_158_1.actors_["10144"].transform
			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.var_.moveOldPos10144 = var_161_8.localPosition
				var_161_8.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10144", 3)

				local var_161_10 = var_161_8.childCount

				for iter_161_4 = 0, var_161_10 - 1 do
					local var_161_11 = var_161_8:GetChild(iter_161_4)

					if var_161_11.name == "split_2" or not string.find(var_161_11.name, "split") then
						var_161_11.gameObject:SetActive(true)
					else
						var_161_11.gameObject:SetActive(false)
					end
				end
			end

			local var_161_12 = 0.001

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_12 then
				local var_161_13 = (arg_158_1.time_ - var_161_9) / var_161_12
				local var_161_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_161_8.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, var_161_14, var_161_13)
			end

			if arg_158_1.time_ >= var_161_9 + var_161_12 and arg_158_1.time_ < var_161_9 + var_161_12 + arg_161_0 then
				var_161_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_161_15 = 0
			local var_161_16 = 0.2

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_17 = arg_158_1:FormatText(StoryNameCfg[1297].name)

				arg_158_1.leftNameTxt_.text = var_161_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_18 = arg_158_1:GetWordFromCfg(938032038)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_20 = 8
				local var_161_21 = utf8.len(var_161_19)
				local var_161_22 = var_161_20 <= 0 and var_161_16 or var_161_16 * (var_161_21 / var_161_20)

				if var_161_22 > 0 and var_161_16 < var_161_22 then
					arg_158_1.talkMaxDuration = var_161_22

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_23 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_23 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_15) / var_161_23

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_15 + var_161_23 and arg_158_1.time_ < var_161_15 + var_161_23 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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

		arg_158_1:InitPlayNodeList()
	end,
	Play938032039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938032039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938032040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10144"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10144 == nil then
				arg_162_1.var_.actorSpriteComps10144 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps10144 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 0.5, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10144 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_165_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps10144 = nil
			end

			local var_165_8 = 0
			local var_165_9 = 0.225

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_10 = arg_162_1:FormatText(StoryNameCfg[7].name)

				arg_162_1.leftNameTxt_.text = var_165_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_11 = arg_162_1:GetWordFromCfg(938032039)
				local var_165_12 = arg_162_1:FormatText(var_165_11.content)

				arg_162_1.text_.text = var_165_12

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_13 = 9
				local var_165_14 = utf8.len(var_165_12)
				local var_165_15 = var_165_13 <= 0 and var_165_9 or var_165_9 * (var_165_14 / var_165_13)

				if var_165_15 > 0 and var_165_9 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15

					if var_165_15 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_12
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_16 and arg_162_1.time_ < var_165_8 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938032040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938032040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938032041(arg_166_1)
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

					if var_169_11.name == "" then
						var_169_11:SetAsLastSibling()
						var_169_11.gameObject:SetActive(true)

						arg_166_1.var_.actorSpriteSplit10144 = var_169_11.gameObject:GetComponent(typeof(Image))

						arg_166_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_169_12 = 0.5

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_9) / var_169_12
				local var_169_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, var_169_14, var_169_13)

				if arg_166_1.var_.actorSpriteSplit10144 ~= nil then
					arg_166_1.var_.actorSpriteSplit10144:SetAlpha(var_169_13)
				end
			end

			if arg_166_1.time_ >= var_169_9 + var_169_12 and arg_166_1.time_ < var_169_9 + var_169_12 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_166_1.var_.actorSpriteSplit10144 ~= nil then
					arg_166_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_169_15 = 0
			local var_169_16 = 0.675

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

				local var_169_18 = arg_166_1:GetWordFromCfg(938032040)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 27
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play938032041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938032041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938032042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10144"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos10144 = var_173_0.localPosition
				var_173_0.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10144", 3)

				local var_173_2 = var_173_0.childCount

				for iter_173_0 = 0, var_173_2 - 1 do
					local var_173_3 = var_173_0:GetChild(iter_173_0)

					if var_173_3.name == "" or not string.find(var_173_3.name, "split") then
						var_173_3.gameObject:SetActive(true)
					else
						var_173_3.gameObject:SetActive(false)
					end
				end
			end

			local var_173_4 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_4 then
				local var_173_5 = (arg_170_1.time_ - var_173_1) / var_173_4
				local var_173_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10144, var_173_6, var_173_5)
			end

			if arg_170_1.time_ >= var_173_1 + var_173_4 and arg_170_1.time_ < var_173_1 + var_173_4 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_173_7 = 0
			local var_173_8 = 0.95

			if var_173_7 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_9 = arg_170_1:FormatText(StoryNameCfg[1297].name)

				arg_170_1.leftNameTxt_.text = var_173_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(938032041)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_12 = 38
				local var_173_13 = utf8.len(var_173_11)
				local var_173_14 = var_173_12 <= 0 and var_173_8 or var_173_8 * (var_173_13 / var_173_12)

				if var_173_14 > 0 and var_173_8 < var_173_14 then
					arg_170_1.talkMaxDuration = var_173_14

					if var_173_14 + var_173_7 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_7
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_15 = math.max(var_173_8, arg_170_1.talkMaxDuration)

			if var_173_7 <= arg_170_1.time_ and arg_170_1.time_ < var_173_7 + var_173_15 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_7) / var_173_15

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_7 + var_173_15 and arg_170_1.time_ < var_173_7 + var_173_15 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play938032042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938032042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938032043(arg_174_1)
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
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 0.5, var_177_3)

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
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_8 = 0
			local var_177_9 = 0.45

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_10 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_11 = arg_174_1:GetWordFromCfg(938032042)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 18
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_9 or var_177_9 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_9 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play938032043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938032043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938032044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10144"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10144 == nil then
				arg_178_1.var_.actorSpriteComps10144 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps10144 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 1, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10144 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10144 = nil
			end

			local var_181_8 = arg_178_1.actors_["10144"].transform
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 3)

				local var_181_10 = var_181_8.childCount

				for iter_181_4 = 0, var_181_10 - 1 do
					local var_181_11 = var_181_8:GetChild(iter_181_4)

					if var_181_11.name == "split_7" then
						var_181_11:SetAsLastSibling()
						var_181_11.gameObject:SetActive(true)

						arg_178_1.var_.actorSpriteSplit10144 = var_181_11.gameObject:GetComponent(typeof(Image))

						arg_178_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_181_12 = 0.5

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_12 then
				local var_181_13 = (arg_178_1.time_ - var_181_9) / var_181_12
				local var_181_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, var_181_14, var_181_13)

				if arg_178_1.var_.actorSpriteSplit10144 ~= nil then
					arg_178_1.var_.actorSpriteSplit10144:SetAlpha(var_181_13)
				end
			end

			if arg_178_1.time_ >= var_181_9 + var_181_12 and arg_178_1.time_ < var_181_9 + var_181_12 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_178_1.var_.actorSpriteSplit10144 ~= nil then
					arg_178_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_181_15 = 0
			local var_181_16 = 0.175

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[1297].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(938032043)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 7
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_23 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_23 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_23

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_23 and arg_178_1.time_ < var_181_15 + var_181_23 + arg_181_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play938032044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 938032044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play938032045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10144"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10144 = var_185_0.localPosition
				var_185_0.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10144", 3)

				local var_185_2 = var_185_0.childCount

				for iter_185_0 = 0, var_185_2 - 1 do
					local var_185_3 = var_185_0:GetChild(iter_185_0)

					if var_185_3.name == "" then
						var_185_3:SetAsLastSibling()
						var_185_3.gameObject:SetActive(true)

						arg_182_1.var_.actorSpriteSplit10144 = var_185_3.gameObject:GetComponent(typeof(Image))

						arg_182_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_185_4 = 0.5

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_4 then
				local var_185_5 = (arg_182_1.time_ - var_185_1) / var_185_4
				local var_185_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10144, var_185_6, var_185_5)

				if arg_182_1.var_.actorSpriteSplit10144 ~= nil then
					arg_182_1.var_.actorSpriteSplit10144:SetAlpha(var_185_5)
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_4 and arg_182_1.time_ < var_185_1 + var_185_4 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_182_1.var_.actorSpriteSplit10144 ~= nil then
					arg_182_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_185_7 = 0
			local var_185_8 = 0.775

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_9 = arg_182_1:FormatText(StoryNameCfg[1297].name)

				arg_182_1.leftNameTxt_.text = var_185_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(938032044)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_12 = 31
				local var_185_13 = utf8.len(var_185_11)
				local var_185_14 = var_185_12 <= 0 and var_185_8 or var_185_8 * (var_185_13 / var_185_12)

				if var_185_14 > 0 and var_185_8 < var_185_14 then
					arg_182_1.talkMaxDuration = var_185_14

					if var_185_14 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_7
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_15 = math.max(var_185_8, arg_182_1.talkMaxDuration)

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_15 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_7) / var_185_15

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_7 + var_185_15 and arg_182_1.time_ < var_185_7 + var_185_15 + arg_185_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play938032045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 938032045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play938032046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10144"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10144 == nil then
				arg_186_1.var_.actorSpriteComps10144 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10144 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 0.5, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10144 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10144 = nil
			end

			local var_189_8 = arg_186_1.actors_["10144"].transform
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.var_.moveOldPos10144 = var_189_8.localPosition
				var_189_8.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10144", 7)

				local var_189_10 = var_189_8.childCount

				for iter_189_4 = 0, var_189_10 - 1 do
					local var_189_11 = var_189_8:GetChild(iter_189_4)

					if var_189_11.name == "" or not string.find(var_189_11.name, "split") then
						var_189_11.gameObject:SetActive(true)
					else
						var_189_11.gameObject:SetActive(false)
					end
				end
			end

			local var_189_12 = 0.001

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_12 then
				local var_189_13 = (arg_186_1.time_ - var_189_9) / var_189_12
				local var_189_14 = Vector3.New(0, -2000, 0)

				var_189_8.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10144, var_189_14, var_189_13)
			end

			if arg_186_1.time_ >= var_189_9 + var_189_12 and arg_186_1.time_ < var_189_9 + var_189_12 + arg_189_0 then
				var_189_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_189_15 = 0
			local var_189_16 = 1.275

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_17 = arg_186_1:GetWordFromCfg(938032045)
				local var_189_18 = arg_186_1:FormatText(var_189_17.content)

				arg_186_1.text_.text = var_189_18

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_19 = 51
				local var_189_20 = utf8.len(var_189_18)
				local var_189_21 = var_189_19 <= 0 and var_189_16 or var_189_16 * (var_189_20 / var_189_19)

				if var_189_21 > 0 and var_189_16 < var_189_21 then
					arg_186_1.talkMaxDuration = var_189_21

					if var_189_21 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_21 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_18
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_22 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_22 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_22

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_22 and arg_186_1.time_ < var_189_15 + var_189_22 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play938032046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 938032046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play938032047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.475

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(938032046)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 19
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
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play938032047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 938032047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play938032048(arg_194_1)
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

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps10144 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps10144 = nil
			end

			local var_197_8 = arg_194_1.actors_["10144"].transform
			local var_197_9 = 0

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.var_.moveOldPos10144 = var_197_8.localPosition
				var_197_8.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("10144", 3)

				local var_197_10 = var_197_8.childCount

				for iter_197_4 = 0, var_197_10 - 1 do
					local var_197_11 = var_197_8:GetChild(iter_197_4)

					if var_197_11.name == "split_1" or not string.find(var_197_11.name, "split") then
						var_197_11.gameObject:SetActive(true)
					else
						var_197_11.gameObject:SetActive(false)
					end
				end
			end

			local var_197_12 = 0.001

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_12 then
				local var_197_13 = (arg_194_1.time_ - var_197_9) / var_197_12
				local var_197_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_197_8.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10144, var_197_14, var_197_13)
			end

			if arg_194_1.time_ >= var_197_9 + var_197_12 and arg_194_1.time_ < var_197_9 + var_197_12 + arg_197_0 then
				var_197_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_197_15 = 0
			local var_197_16 = 0.7

			if var_197_15 < arg_194_1.time_ and arg_194_1.time_ <= var_197_15 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_17 = arg_194_1:FormatText(StoryNameCfg[1297].name)

				arg_194_1.leftNameTxt_.text = var_197_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_18 = arg_194_1:GetWordFromCfg(938032047)
				local var_197_19 = arg_194_1:FormatText(var_197_18.content)

				arg_194_1.text_.text = var_197_19

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_20 = 28
				local var_197_21 = utf8.len(var_197_19)
				local var_197_22 = var_197_20 <= 0 and var_197_16 or var_197_16 * (var_197_21 / var_197_20)

				if var_197_22 > 0 and var_197_16 < var_197_22 then
					arg_194_1.talkMaxDuration = var_197_22

					if var_197_22 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_22 + var_197_15
					end
				end

				arg_194_1.text_.text = var_197_19
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_23 = math.max(var_197_16, arg_194_1.talkMaxDuration)

			if var_197_15 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_23 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_23

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_23 and arg_194_1.time_ < var_197_15 + var_197_23 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play938032048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 938032048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play938032049(arg_198_1)
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
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 0.5, var_201_3)

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
							iter_201_3.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10144 = nil
			end

			local var_201_8 = 0
			local var_201_9 = 0.175

			if var_201_8 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_10 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_11 = arg_198_1:GetWordFromCfg(938032048)
				local var_201_12 = arg_198_1:FormatText(var_201_11.content)

				arg_198_1.text_.text = var_201_12

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 7
				local var_201_14 = utf8.len(var_201_12)
				local var_201_15 = var_201_13 <= 0 and var_201_9 or var_201_9 * (var_201_14 / var_201_13)

				if var_201_15 > 0 and var_201_9 < var_201_15 then
					arg_198_1.talkMaxDuration = var_201_15

					if var_201_15 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_12
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play938032049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 938032049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play938032050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.2

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[1561].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(938032049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 8
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_8 and arg_202_1.time_ < var_205_0 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play938032050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938032050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938032051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10144"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10144 = var_209_0.localPosition
				var_209_0.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10144", 7)

				local var_209_2 = var_209_0.childCount

				for iter_209_0 = 0, var_209_2 - 1 do
					local var_209_3 = var_209_0:GetChild(iter_209_0)

					if var_209_3.name == "" or not string.find(var_209_3.name, "split") then
						var_209_3.gameObject:SetActive(true)
					else
						var_209_3.gameObject:SetActive(false)
					end
				end
			end

			local var_209_4 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_4 then
				local var_209_5 = (arg_206_1.time_ - var_209_1) / var_209_4
				local var_209_6 = Vector3.New(0, -2000, 0)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10144, var_209_6, var_209_5)
			end

			if arg_206_1.time_ >= var_209_1 + var_209_4 and arg_206_1.time_ < var_209_1 + var_209_4 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_7 = 0
			local var_209_8 = 0.925

			if var_209_7 < arg_206_1.time_ and arg_206_1.time_ <= var_209_7 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_9 = arg_206_1:GetWordFromCfg(938032050)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 37
				local var_209_12 = utf8.len(var_209_10)
				local var_209_13 = var_209_11 <= 0 and var_209_8 or var_209_8 * (var_209_12 / var_209_11)

				if var_209_13 > 0 and var_209_8 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_7 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_7
					end
				end

				arg_206_1.text_.text = var_209_10
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_8, arg_206_1.talkMaxDuration)

			if var_209_7 <= arg_206_1.time_ and arg_206_1.time_ < var_209_7 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_7) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_7 + var_209_14 and arg_206_1.time_ < var_209_7 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play938032051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938032051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938032052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 1.175

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(938032051)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 47
				local var_213_5 = utf8.len(var_213_3)
				local var_213_6 = var_213_4 <= 0 and var_213_1 or var_213_1 * (var_213_5 / var_213_4)

				if var_213_6 > 0 and var_213_1 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_7 and arg_210_1.time_ < var_213_0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play938032052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938032052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938032053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.175

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(938032052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 7
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
	Play938032053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938032053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938032054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10144"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10144 == nil then
				arg_218_1.var_.actorSpriteComps10144 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps10144 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10144 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10144 = nil
			end

			local var_221_8 = arg_218_1.actors_["10144"].transform
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1.var_.moveOldPos10144 = var_221_8.localPosition
				var_221_8.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10144", 2)

				local var_221_10 = var_221_8.childCount

				for iter_221_4 = 0, var_221_10 - 1 do
					local var_221_11 = var_221_8:GetChild(iter_221_4)

					if var_221_11.name == "" or not string.find(var_221_11.name, "split") then
						var_221_11.gameObject:SetActive(true)
					else
						var_221_11.gameObject:SetActive(false)
					end
				end
			end

			local var_221_12 = 0.001

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_12 then
				local var_221_13 = (arg_218_1.time_ - var_221_9) / var_221_12
				local var_221_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_221_8.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10144, var_221_14, var_221_13)
			end

			if arg_218_1.time_ >= var_221_9 + var_221_12 and arg_218_1.time_ < var_221_9 + var_221_12 + arg_221_0 then
				var_221_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_221_15 = 0
			local var_221_16 = 1.275

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[1297].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(938032053)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 51
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_16 or var_221_16 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_16 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_23 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_23 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_23

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_23 and arg_218_1.time_ < var_221_15 + var_221_23 + arg_221_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938032054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938032054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938032055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["128404"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps128404 == nil then
				arg_222_1.var_.actorSpriteComps128404 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps128404 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps128404 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps128404 = nil
			end

			local var_225_8 = arg_222_1.actors_["10144"]
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10144 == nil then
				arg_222_1.var_.actorSpriteComps10144 = var_225_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_10 = 0.2

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 and not isNil(var_225_8) then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / var_225_10

				if arg_222_1.var_.actorSpriteComps10144 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								local var_225_12 = Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor2.r, var_225_11)
								local var_225_13 = Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor2.g, var_225_11)
								local var_225_14 = Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor2.b, var_225_11)

								iter_225_5.color = Color.New(var_225_12, var_225_13, var_225_14)
							else
								local var_225_15 = Mathf.Lerp(iter_225_5.color.r, 0.5, var_225_11)

								iter_225_5.color = Color.New(var_225_15, var_225_15, var_225_15)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10144 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_225_7 then
						if arg_222_1.isInRecall_ then
							iter_225_7.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10144 = nil
			end

			local var_225_16 = arg_222_1.actors_["128404"].transform
			local var_225_17 = 0

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 then
				arg_222_1.var_.moveOldPos128404 = var_225_16.localPosition
				var_225_16.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("128404", 4)

				local var_225_18 = var_225_16.childCount

				for iter_225_8 = 0, var_225_18 - 1 do
					local var_225_19 = var_225_16:GetChild(iter_225_8)

					if var_225_19.name == "split_3" or not string.find(var_225_19.name, "split") then
						var_225_19.gameObject:SetActive(true)
					else
						var_225_19.gameObject:SetActive(false)
					end
				end
			end

			local var_225_20 = 0.001

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_20 then
				local var_225_21 = (arg_222_1.time_ - var_225_17) / var_225_20
				local var_225_22 = Vector3.New(390.2, -356, -362.3)

				var_225_16.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos128404, var_225_22, var_225_21)
			end

			if arg_222_1.time_ >= var_225_17 + var_225_20 and arg_222_1.time_ < var_225_17 + var_225_20 + arg_225_0 then
				var_225_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_225_23 = arg_222_1.actors_["128404"]
			local var_225_24 = 0

			if var_225_24 < arg_222_1.time_ and arg_222_1.time_ <= var_225_24 + arg_225_0 then
				local var_225_25 = var_225_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_225_25 then
					arg_222_1.var_.alphaOldValue128404 = var_225_25.alpha
					arg_222_1.var_.characterEffect128404 = var_225_25
				end

				arg_222_1.var_.alphaOldValue128404 = 0
			end

			local var_225_26 = 0.034

			if var_225_24 <= arg_222_1.time_ and arg_222_1.time_ < var_225_24 + var_225_26 then
				local var_225_27 = (arg_222_1.time_ - var_225_24) / var_225_26
				local var_225_28 = Mathf.Lerp(arg_222_1.var_.alphaOldValue128404, 1, var_225_27)

				if arg_222_1.var_.characterEffect128404 then
					arg_222_1.var_.characterEffect128404.alpha = var_225_28
				end
			end

			if arg_222_1.time_ >= var_225_24 + var_225_26 and arg_222_1.time_ < var_225_24 + var_225_26 + arg_225_0 and arg_222_1.var_.characterEffect128404 then
				arg_222_1.var_.characterEffect128404.alpha = 1
			end

			local var_225_29 = 0
			local var_225_30 = 0.175

			if var_225_29 < arg_222_1.time_ and arg_222_1.time_ <= var_225_29 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_31 = arg_222_1:FormatText(StoryNameCfg[6].name)

				arg_222_1.leftNameTxt_.text = var_225_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_32 = arg_222_1:GetWordFromCfg(938032054)
				local var_225_33 = arg_222_1:FormatText(var_225_32.content)

				arg_222_1.text_.text = var_225_33

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_34 = 7
				local var_225_35 = utf8.len(var_225_33)
				local var_225_36 = var_225_34 <= 0 and var_225_30 or var_225_30 * (var_225_35 / var_225_34)

				if var_225_36 > 0 and var_225_30 < var_225_36 then
					arg_222_1.talkMaxDuration = var_225_36

					if var_225_36 + var_225_29 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_36 + var_225_29
					end
				end

				arg_222_1.text_.text = var_225_33
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_37 = math.max(var_225_30, arg_222_1.talkMaxDuration)

			if var_225_29 <= arg_222_1.time_ and arg_222_1.time_ < var_225_29 + var_225_37 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_29) / var_225_37

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_29 + var_225_37 and arg_222_1.time_ < var_225_29 + var_225_37 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play938032055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938032055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play938032056(arg_226_1)
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

			local var_229_8 = arg_226_1.actors_["128404"]
			local var_229_9 = 0

			if var_229_9 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps128404 == nil then
				arg_226_1.var_.actorSpriteComps128404 = var_229_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_10 = 0.2

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 and not isNil(var_229_8) then
				local var_229_11 = (arg_226_1.time_ - var_229_9) / var_229_10

				if arg_226_1.var_.actorSpriteComps128404 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								local var_229_12 = Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, var_229_11)
								local var_229_13 = Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, var_229_11)
								local var_229_14 = Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, var_229_11)

								iter_229_5.color = Color.New(var_229_12, var_229_13, var_229_14)
							else
								local var_229_15 = Mathf.Lerp(iter_229_5.color.r, 0.5, var_229_11)

								iter_229_5.color = Color.New(var_229_15, var_229_15, var_229_15)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps128404 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_229_7 then
						if arg_226_1.isInRecall_ then
							iter_229_7.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps128404 = nil
			end

			local var_229_16 = arg_226_1.actors_["10144"].transform
			local var_229_17 = 0

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.var_.moveOldPos10144 = var_229_16.localPosition
				var_229_16.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10144", 2)

				local var_229_18 = var_229_16.childCount

				for iter_229_8 = 0, var_229_18 - 1 do
					local var_229_19 = var_229_16:GetChild(iter_229_8)

					if var_229_19.name == "" or not string.find(var_229_19.name, "split") then
						var_229_19.gameObject:SetActive(true)
					else
						var_229_19.gameObject:SetActive(false)
					end
				end
			end

			local var_229_20 = 0.001

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_20 then
				local var_229_21 = (arg_226_1.time_ - var_229_17) / var_229_20
				local var_229_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_229_16.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10144, var_229_22, var_229_21)
			end

			if arg_226_1.time_ >= var_229_17 + var_229_20 and arg_226_1.time_ < var_229_17 + var_229_20 + arg_229_0 then
				var_229_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_229_23 = 0
			local var_229_24 = 0.425

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_25 = arg_226_1:FormatText(StoryNameCfg[1297].name)

				arg_226_1.leftNameTxt_.text = var_229_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_26 = arg_226_1:GetWordFromCfg(938032055)
				local var_229_27 = arg_226_1:FormatText(var_229_26.content)

				arg_226_1.text_.text = var_229_27

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_28 = 17
				local var_229_29 = utf8.len(var_229_27)
				local var_229_30 = var_229_28 <= 0 and var_229_24 or var_229_24 * (var_229_29 / var_229_28)

				if var_229_30 > 0 and var_229_24 < var_229_30 then
					arg_226_1.talkMaxDuration = var_229_30

					if var_229_30 + var_229_23 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_30 + var_229_23
					end
				end

				arg_226_1.text_.text = var_229_27
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_31 = math.max(var_229_24, arg_226_1.talkMaxDuration)

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_31 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_23) / var_229_31

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_23 + var_229_31 and arg_226_1.time_ < var_229_23 + var_229_31 + arg_229_0 then
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
	Play938032056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 938032056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play938032057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["128404"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps128404 == nil then
				arg_230_1.var_.actorSpriteComps128404 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps128404 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps128404 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps128404 = nil
			end

			local var_233_8 = arg_230_1.actors_["10144"]
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10144 == nil then
				arg_230_1.var_.actorSpriteComps10144 = var_233_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_10 = 0.2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 and not isNil(var_233_8) then
				local var_233_11 = (arg_230_1.time_ - var_233_9) / var_233_10

				if arg_230_1.var_.actorSpriteComps10144 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_12 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, var_233_11)
								local var_233_13 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, var_233_11)
								local var_233_14 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, var_233_11)

								iter_233_5.color = Color.New(var_233_12, var_233_13, var_233_14)
							else
								local var_233_15 = Mathf.Lerp(iter_233_5.color.r, 0.5, var_233_11)

								iter_233_5.color = Color.New(var_233_15, var_233_15, var_233_15)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10144 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10144 = nil
			end

			local var_233_16 = arg_230_1.actors_["128404"].transform
			local var_233_17 = 0

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.var_.moveOldPos128404 = var_233_16.localPosition
				var_233_16.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("128404", 4)

				local var_233_18 = var_233_16.childCount

				for iter_233_8 = 0, var_233_18 - 1 do
					local var_233_19 = var_233_16:GetChild(iter_233_8)

					if var_233_19.name == "split_4" then
						var_233_19:SetAsLastSibling()
						var_233_19.gameObject:SetActive(true)

						arg_230_1.var_.actorSpriteSplit128404 = var_233_19.gameObject:GetComponent(typeof(Image))

						arg_230_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_233_20 = 0.5

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_20 then
				local var_233_21 = (arg_230_1.time_ - var_233_17) / var_233_20
				local var_233_22 = Vector3.New(390.2, -356, -362.3)

				var_233_16.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos128404, var_233_22, var_233_21)

				if arg_230_1.var_.actorSpriteSplit128404 ~= nil then
					arg_230_1.var_.actorSpriteSplit128404:SetAlpha(var_233_21)
				end
			end

			if arg_230_1.time_ >= var_233_17 + var_233_20 and arg_230_1.time_ < var_233_17 + var_233_20 + arg_233_0 then
				var_233_16.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_230_1.var_.actorSpriteSplit128404 ~= nil then
					arg_230_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_233_23 = 0
			local var_233_24 = 0.775

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_25 = arg_230_1:FormatText(StoryNameCfg[6].name)

				arg_230_1.leftNameTxt_.text = var_233_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_26 = arg_230_1:GetWordFromCfg(938032056)
				local var_233_27 = arg_230_1:FormatText(var_233_26.content)

				arg_230_1.text_.text = var_233_27

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_28 = 31
				local var_233_29 = utf8.len(var_233_27)
				local var_233_30 = var_233_28 <= 0 and var_233_24 or var_233_24 * (var_233_29 / var_233_28)

				if var_233_30 > 0 and var_233_24 < var_233_30 then
					arg_230_1.talkMaxDuration = var_233_30

					if var_233_30 + var_233_23 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_30 + var_233_23
					end
				end

				arg_230_1.text_.text = var_233_27
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_31 = math.max(var_233_24, arg_230_1.talkMaxDuration)

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_31 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_23) / var_233_31

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_23 + var_233_31 and arg_230_1.time_ < var_233_23 + var_233_31 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play938032057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 938032057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play938032058(arg_234_1)
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

			local var_237_8 = arg_234_1.actors_["128404"]
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps128404 == nil then
				arg_234_1.var_.actorSpriteComps128404 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_10 = 0.2

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_10 and not isNil(var_237_8) then
				local var_237_11 = (arg_234_1.time_ - var_237_9) / var_237_10

				if arg_234_1.var_.actorSpriteComps128404 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								local var_237_12 = Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor2.r, var_237_11)
								local var_237_13 = Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor2.g, var_237_11)
								local var_237_14 = Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor2.b, var_237_11)

								iter_237_5.color = Color.New(var_237_12, var_237_13, var_237_14)
							else
								local var_237_15 = Mathf.Lerp(iter_237_5.color.r, 0.5, var_237_11)

								iter_237_5.color = Color.New(var_237_15, var_237_15, var_237_15)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_10 and arg_234_1.time_ < var_237_9 + var_237_10 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps128404 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_237_7 then
						if arg_234_1.isInRecall_ then
							iter_237_7.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps128404 = nil
			end

			local var_237_16 = arg_234_1.actors_["10144"].transform
			local var_237_17 = 0

			if var_237_17 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				arg_234_1.var_.moveOldPos10144 = var_237_16.localPosition
				var_237_16.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10144", 2)

				local var_237_18 = var_237_16.childCount

				for iter_237_8 = 0, var_237_18 - 1 do
					local var_237_19 = var_237_16:GetChild(iter_237_8)

					if var_237_19.name == "" or not string.find(var_237_19.name, "split") then
						var_237_19.gameObject:SetActive(true)
					else
						var_237_19.gameObject:SetActive(false)
					end
				end
			end

			local var_237_20 = 0.001

			if var_237_17 <= arg_234_1.time_ and arg_234_1.time_ < var_237_17 + var_237_20 then
				local var_237_21 = (arg_234_1.time_ - var_237_17) / var_237_20
				local var_237_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_237_16.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10144, var_237_22, var_237_21)
			end

			if arg_234_1.time_ >= var_237_17 + var_237_20 and arg_234_1.time_ < var_237_17 + var_237_20 + arg_237_0 then
				var_237_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_237_23 = 0
			local var_237_24 = 1.45

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_25 = arg_234_1:FormatText(StoryNameCfg[1297].name)

				arg_234_1.leftNameTxt_.text = var_237_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_26 = arg_234_1:GetWordFromCfg(938032057)
				local var_237_27 = arg_234_1:FormatText(var_237_26.content)

				arg_234_1.text_.text = var_237_27

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_28 = 58
				local var_237_29 = utf8.len(var_237_27)
				local var_237_30 = var_237_28 <= 0 and var_237_24 or var_237_24 * (var_237_29 / var_237_28)

				if var_237_30 > 0 and var_237_24 < var_237_30 then
					arg_234_1.talkMaxDuration = var_237_30

					if var_237_30 + var_237_23 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_30 + var_237_23
					end
				end

				arg_234_1.text_.text = var_237_27
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_31 = math.max(var_237_24, arg_234_1.talkMaxDuration)

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_31 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_23) / var_237_31

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_23 + var_237_31 and arg_234_1.time_ < var_237_23 + var_237_31 + arg_237_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play938032058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 938032058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play938032059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10144"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos10144 = var_241_0.localPosition
				var_241_0.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10144", 2)

				local var_241_2 = var_241_0.childCount

				for iter_241_0 = 0, var_241_2 - 1 do
					local var_241_3 = var_241_0:GetChild(iter_241_0)

					if var_241_3.name == "" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_4 then
				local var_241_5 = (arg_238_1.time_ - var_241_1) / var_241_4
				local var_241_6 = Vector3.New(-507.9, -381.1, -285.9)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10144, var_241_6, var_241_5)
			end

			if arg_238_1.time_ >= var_241_1 + var_241_4 and arg_238_1.time_ < var_241_1 + var_241_4 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_241_7 = 0
			local var_241_8 = 0.825

			if var_241_7 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_9 = arg_238_1:FormatText(StoryNameCfg[1297].name)

				arg_238_1.leftNameTxt_.text = var_241_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_10 = arg_238_1:GetWordFromCfg(938032058)
				local var_241_11 = arg_238_1:FormatText(var_241_10.content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_12 = 33
				local var_241_13 = utf8.len(var_241_11)
				local var_241_14 = var_241_12 <= 0 and var_241_8 or var_241_8 * (var_241_13 / var_241_12)

				if var_241_14 > 0 and var_241_8 < var_241_14 then
					arg_238_1.talkMaxDuration = var_241_14

					if var_241_14 + var_241_7 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_7
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_15 = math.max(var_241_8, arg_238_1.talkMaxDuration)

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_15 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_7) / var_241_15

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_7 + var_241_15 and arg_238_1.time_ < var_241_7 + var_241_15 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play938032059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 938032059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play938032060(arg_242_1)
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
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor2.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor2.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor2.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 0.5, var_245_3)

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
							iter_245_3.color = arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_245_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps10144 = nil
			end

			local var_245_8 = 0
			local var_245_9 = 0.1

			if var_245_8 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_10 = arg_242_1:FormatText(StoryNameCfg[7].name)

				arg_242_1.leftNameTxt_.text = var_245_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_11 = arg_242_1:GetWordFromCfg(938032059)
				local var_245_12 = arg_242_1:FormatText(var_245_11.content)

				arg_242_1.text_.text = var_245_12

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 4
				local var_245_14 = utf8.len(var_245_12)
				local var_245_15 = var_245_13 <= 0 and var_245_9 or var_245_9 * (var_245_14 / var_245_13)

				if var_245_15 > 0 and var_245_9 < var_245_15 then
					arg_242_1.talkMaxDuration = var_245_15

					if var_245_15 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_15 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_12
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play938032060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 938032060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play938032061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 1.05

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(938032060)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 42
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play938032061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938032061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938032062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10144"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10144 == nil then
				arg_250_1.var_.actorSpriteComps10144 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps10144 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 1, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10144 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_253_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps10144 = nil
			end

			local var_253_8 = arg_250_1.actors_["10144"].transform
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.var_.moveOldPos10144 = var_253_8.localPosition
				var_253_8.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10144", 2)

				local var_253_10 = var_253_8.childCount

				for iter_253_4 = 0, var_253_10 - 1 do
					local var_253_11 = var_253_8:GetChild(iter_253_4)

					if var_253_11.name == "split_2" or not string.find(var_253_11.name, "split") then
						var_253_11.gameObject:SetActive(true)
					else
						var_253_11.gameObject:SetActive(false)
					end
				end
			end

			local var_253_12 = 0.001

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_9) / var_253_12
				local var_253_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_253_8.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10144, var_253_14, var_253_13)
			end

			if arg_250_1.time_ >= var_253_9 + var_253_12 and arg_250_1.time_ < var_253_9 + var_253_12 + arg_253_0 then
				var_253_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_253_15 = 0
			local var_253_16 = 0.475

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[1297].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(938032061)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 19
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_23 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_23 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_23

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_23 and arg_250_1.time_ < var_253_15 + var_253_23 + arg_253_0 then
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
	Play938032062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938032062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938032063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10144"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10144 == nil then
				arg_254_1.var_.actorSpriteComps10144 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps10144 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 0.5, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10144 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps10144 = nil
			end

			local var_257_8 = arg_254_1.actors_["10144"].transform
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.var_.moveOldPos10144 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10144", 7)

				local var_257_10 = var_257_8.childCount

				for iter_257_4 = 0, var_257_10 - 1 do
					local var_257_11 = var_257_8:GetChild(iter_257_4)

					if var_257_11.name == "" or not string.find(var_257_11.name, "split") then
						var_257_11.gameObject:SetActive(true)
					else
						var_257_11.gameObject:SetActive(false)
					end
				end
			end

			local var_257_12 = 0.001

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_12 then
				local var_257_13 = (arg_254_1.time_ - var_257_9) / var_257_12
				local var_257_14 = Vector3.New(0, -2000, 0)

				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10144, var_257_14, var_257_13)
			end

			if arg_254_1.time_ >= var_257_9 + var_257_12 and arg_254_1.time_ < var_257_9 + var_257_12 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_257_15 = arg_254_1.actors_["128404"].transform
			local var_257_16 = 0

			if var_257_16 < arg_254_1.time_ and arg_254_1.time_ <= var_257_16 + arg_257_0 then
				arg_254_1.var_.moveOldPos128404 = var_257_15.localPosition
				var_257_15.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("128404", 7)

				local var_257_17 = var_257_15.childCount

				for iter_257_5 = 0, var_257_17 - 1 do
					local var_257_18 = var_257_15:GetChild(iter_257_5)

					if var_257_18.name == "" or not string.find(var_257_18.name, "split") then
						var_257_18.gameObject:SetActive(true)
					else
						var_257_18.gameObject:SetActive(false)
					end
				end
			end

			local var_257_19 = 0.001

			if var_257_16 <= arg_254_1.time_ and arg_254_1.time_ < var_257_16 + var_257_19 then
				local var_257_20 = (arg_254_1.time_ - var_257_16) / var_257_19
				local var_257_21 = Vector3.New(0, -2000, 0)

				var_257_15.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos128404, var_257_21, var_257_20)
			end

			if arg_254_1.time_ >= var_257_16 + var_257_19 and arg_254_1.time_ < var_257_16 + var_257_19 + arg_257_0 then
				var_257_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_257_22 = 0
			local var_257_23 = 0.85

			if var_257_22 < arg_254_1.time_ and arg_254_1.time_ <= var_257_22 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_24 = arg_254_1:GetWordFromCfg(938032062)
				local var_257_25 = arg_254_1:FormatText(var_257_24.content)

				arg_254_1.text_.text = var_257_25

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_26 = 34
				local var_257_27 = utf8.len(var_257_25)
				local var_257_28 = var_257_26 <= 0 and var_257_23 or var_257_23 * (var_257_27 / var_257_26)

				if var_257_28 > 0 and var_257_23 < var_257_28 then
					arg_254_1.talkMaxDuration = var_257_28

					if var_257_28 + var_257_22 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_28 + var_257_22
					end
				end

				arg_254_1.text_.text = var_257_25
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_29 = math.max(var_257_23, arg_254_1.talkMaxDuration)

			if var_257_22 <= arg_254_1.time_ and arg_254_1.time_ < var_257_22 + var_257_29 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_22) / var_257_29

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_22 + var_257_29 and arg_254_1.time_ < var_257_22 + var_257_29 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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

		arg_254_1:InitPlayNodeList()
	end,
	Play938032063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938032063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938032064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["104902"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps104902 == nil then
				arg_258_1.var_.actorSpriteComps104902 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps104902 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps104902 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps104902 = nil
			end

			local var_261_8 = arg_258_1.actors_["104902"].transform
			local var_261_9 = 0

			if var_261_9 < arg_258_1.time_ and arg_258_1.time_ <= var_261_9 + arg_261_0 then
				arg_258_1.var_.moveOldPos104902 = var_261_8.localPosition
				var_261_8.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("104902", 2)

				local var_261_10 = var_261_8.childCount

				for iter_261_4 = 0, var_261_10 - 1 do
					local var_261_11 = var_261_8:GetChild(iter_261_4)

					if var_261_11.name == "split_1" or not string.find(var_261_11.name, "split") then
						var_261_11.gameObject:SetActive(true)
					else
						var_261_11.gameObject:SetActive(false)
					end
				end
			end

			local var_261_12 = 0.001

			if var_261_9 <= arg_258_1.time_ and arg_258_1.time_ < var_261_9 + var_261_12 then
				local var_261_13 = (arg_258_1.time_ - var_261_9) / var_261_12
				local var_261_14 = Vector3.New(-390, -335, -360)

				var_261_8.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos104902, var_261_14, var_261_13)
			end

			if arg_258_1.time_ >= var_261_9 + var_261_12 and arg_258_1.time_ < var_261_9 + var_261_12 + arg_261_0 then
				var_261_8.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_261_15 = 0
			local var_261_16 = 0.85

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[562].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(938032063)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 34
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_23 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_23 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_23

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_23 and arg_258_1.time_ < var_261_15 + var_261_23 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play938032064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938032064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938032065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["128404"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_8 = arg_262_1.actors_["104902"]
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps104902 == nil then
				arg_262_1.var_.actorSpriteComps104902 = var_265_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_10 = 0.2

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_10 and not isNil(var_265_8) then
				local var_265_11 = (arg_262_1.time_ - var_265_9) / var_265_10

				if arg_262_1.var_.actorSpriteComps104902 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_262_1.time_ >= var_265_9 + var_265_10 and arg_262_1.time_ < var_265_9 + var_265_10 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps104902 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_265_7 then
						if arg_262_1.isInRecall_ then
							iter_265_7.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps104902 = nil
			end

			local var_265_16 = arg_262_1.actors_["128404"].transform
			local var_265_17 = 0

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = var_265_16.localPosition
				var_265_16.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 4)

				local var_265_18 = var_265_16.childCount

				for iter_265_8 = 0, var_265_18 - 1 do
					local var_265_19 = var_265_16:GetChild(iter_265_8)

					if var_265_19.name == "split_3" or not string.find(var_265_19.name, "split") then
						var_265_19.gameObject:SetActive(true)
					else
						var_265_19.gameObject:SetActive(false)
					end
				end
			end

			local var_265_20 = 0.001

			if var_265_17 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_20 then
				local var_265_21 = (arg_262_1.time_ - var_265_17) / var_265_20
				local var_265_22 = Vector3.New(390.2, -356, -362.3)

				var_265_16.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, var_265_22, var_265_21)
			end

			if arg_262_1.time_ >= var_265_17 + var_265_20 and arg_262_1.time_ < var_265_17 + var_265_20 + arg_265_0 then
				var_265_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_265_23 = 0
			local var_265_24 = 0.725

			if var_265_23 < arg_262_1.time_ and arg_262_1.time_ <= var_265_23 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_25 = arg_262_1:FormatText(StoryNameCfg[6].name)

				arg_262_1.leftNameTxt_.text = var_265_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_26 = arg_262_1:GetWordFromCfg(938032064)
				local var_265_27 = arg_262_1:FormatText(var_265_26.content)

				arg_262_1.text_.text = var_265_27

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_28 = 29
				local var_265_29 = utf8.len(var_265_27)
				local var_265_30 = var_265_28 <= 0 and var_265_24 or var_265_24 * (var_265_29 / var_265_28)

				if var_265_30 > 0 and var_265_24 < var_265_30 then
					arg_262_1.talkMaxDuration = var_265_30

					if var_265_30 + var_265_23 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_30 + var_265_23
					end
				end

				arg_262_1.text_.text = var_265_27
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_31 = math.max(var_265_24, arg_262_1.talkMaxDuration)

			if var_265_23 <= arg_262_1.time_ and arg_262_1.time_ < var_265_23 + var_265_31 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_23) / var_265_31

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_23 + var_265_31 and arg_262_1.time_ < var_265_23 + var_265_31 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938032065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938032065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938032066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["106603"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps106603 == nil then
				arg_266_1.var_.actorSpriteComps106603 = var_269_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.actorSpriteComps106603 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								local var_269_4 = Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, var_269_3)
								local var_269_5 = Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, var_269_3)
								local var_269_6 = Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, var_269_3)

								iter_269_1.color = Color.New(var_269_4, var_269_5, var_269_6)
							else
								local var_269_7 = Mathf.Lerp(iter_269_1.color.r, 1, var_269_3)

								iter_269_1.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps106603 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_269_3 then
						if arg_266_1.isInRecall_ then
							iter_269_3.color = arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_269_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps106603 = nil
			end

			local var_269_8 = arg_266_1.actors_["128404"]
			local var_269_9 = 0

			if var_269_9 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 and not isNil(var_269_8) and arg_266_1.var_.actorSpriteComps128404 == nil then
				arg_266_1.var_.actorSpriteComps128404 = var_269_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_10 = 0.2

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_10 and not isNil(var_269_8) then
				local var_269_11 = (arg_266_1.time_ - var_269_9) / var_269_10

				if arg_266_1.var_.actorSpriteComps128404 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_269_5 then
							if arg_266_1.isInRecall_ then
								local var_269_12 = Mathf.Lerp(iter_269_5.color.r, arg_266_1.hightColor2.r, var_269_11)
								local var_269_13 = Mathf.Lerp(iter_269_5.color.g, arg_266_1.hightColor2.g, var_269_11)
								local var_269_14 = Mathf.Lerp(iter_269_5.color.b, arg_266_1.hightColor2.b, var_269_11)

								iter_269_5.color = Color.New(var_269_12, var_269_13, var_269_14)
							else
								local var_269_15 = Mathf.Lerp(iter_269_5.color.r, 0.5, var_269_11)

								iter_269_5.color = Color.New(var_269_15, var_269_15, var_269_15)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_9 + var_269_10 and arg_266_1.time_ < var_269_9 + var_269_10 + arg_269_0 and not isNil(var_269_8) and arg_266_1.var_.actorSpriteComps128404 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_269_7 then
						if arg_266_1.isInRecall_ then
							iter_269_7.color = arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_269_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps128404 = nil
			end

			local var_269_16 = arg_266_1.actors_["106603"].transform
			local var_269_17 = 0

			if var_269_17 < arg_266_1.time_ and arg_266_1.time_ <= var_269_17 + arg_269_0 then
				arg_266_1.var_.moveOldPos106603 = var_269_16.localPosition
				var_269_16.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("106603", 2)

				local var_269_18 = var_269_16.childCount

				for iter_269_8 = 0, var_269_18 - 1 do
					local var_269_19 = var_269_16:GetChild(iter_269_8)

					if var_269_19.name == "" or not string.find(var_269_19.name, "split") then
						var_269_19.gameObject:SetActive(true)
					else
						var_269_19.gameObject:SetActive(false)
					end
				end
			end

			local var_269_20 = 0.001

			if var_269_17 <= arg_266_1.time_ and arg_266_1.time_ < var_269_17 + var_269_20 then
				local var_269_21 = (arg_266_1.time_ - var_269_17) / var_269_20
				local var_269_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_269_16.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos106603, var_269_22, var_269_21)
			end

			if arg_266_1.time_ >= var_269_17 + var_269_20 and arg_266_1.time_ < var_269_17 + var_269_20 + arg_269_0 then
				var_269_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_269_23 = arg_266_1.actors_["104902"].transform
			local var_269_24 = 0

			if var_269_24 < arg_266_1.time_ and arg_266_1.time_ <= var_269_24 + arg_269_0 then
				arg_266_1.var_.moveOldPos104902 = var_269_23.localPosition
				var_269_23.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("104902", 7)

				local var_269_25 = var_269_23.childCount

				for iter_269_9 = 0, var_269_25 - 1 do
					local var_269_26 = var_269_23:GetChild(iter_269_9)

					if var_269_26.name == "" or not string.find(var_269_26.name, "split") then
						var_269_26.gameObject:SetActive(true)
					else
						var_269_26.gameObject:SetActive(false)
					end
				end
			end

			local var_269_27 = 0.001

			if var_269_24 <= arg_266_1.time_ and arg_266_1.time_ < var_269_24 + var_269_27 then
				local var_269_28 = (arg_266_1.time_ - var_269_24) / var_269_27
				local var_269_29 = Vector3.New(0, -2000, -360)

				var_269_23.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos104902, var_269_29, var_269_28)
			end

			if arg_266_1.time_ >= var_269_24 + var_269_27 and arg_266_1.time_ < var_269_24 + var_269_27 + arg_269_0 then
				var_269_23.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_269_30 = 0
			local var_269_31 = 0.75

			if var_269_30 < arg_266_1.time_ and arg_266_1.time_ <= var_269_30 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_32 = arg_266_1:FormatText(StoryNameCfg[32].name)

				arg_266_1.leftNameTxt_.text = var_269_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_33 = arg_266_1:GetWordFromCfg(938032065)
				local var_269_34 = arg_266_1:FormatText(var_269_33.content)

				arg_266_1.text_.text = var_269_34

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_35 = 30
				local var_269_36 = utf8.len(var_269_34)
				local var_269_37 = var_269_35 <= 0 and var_269_31 or var_269_31 * (var_269_36 / var_269_35)

				if var_269_37 > 0 and var_269_31 < var_269_37 then
					arg_266_1.talkMaxDuration = var_269_37

					if var_269_37 + var_269_30 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_37 + var_269_30
					end
				end

				arg_266_1.text_.text = var_269_34
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_38 = math.max(var_269_31, arg_266_1.talkMaxDuration)

			if var_269_30 <= arg_266_1.time_ and arg_266_1.time_ < var_269_30 + var_269_38 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_30) / var_269_38

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_30 + var_269_38 and arg_266_1.time_ < var_269_30 + var_269_38 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play938032066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938032066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938032067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["108301"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps108301 == nil then
				arg_270_1.var_.actorSpriteComps108301 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps108301 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 1, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps108301 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps108301 = nil
			end

			local var_273_8 = arg_270_1.actors_["106603"]
			local var_273_9 = 0

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.actorSpriteComps106603 == nil then
				arg_270_1.var_.actorSpriteComps106603 = var_273_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_10 = 0.2

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_10 and not isNil(var_273_8) then
				local var_273_11 = (arg_270_1.time_ - var_273_9) / var_273_10

				if arg_270_1.var_.actorSpriteComps106603 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_273_5 then
							if arg_270_1.isInRecall_ then
								local var_273_12 = Mathf.Lerp(iter_273_5.color.r, arg_270_1.hightColor2.r, var_273_11)
								local var_273_13 = Mathf.Lerp(iter_273_5.color.g, arg_270_1.hightColor2.g, var_273_11)
								local var_273_14 = Mathf.Lerp(iter_273_5.color.b, arg_270_1.hightColor2.b, var_273_11)

								iter_273_5.color = Color.New(var_273_12, var_273_13, var_273_14)
							else
								local var_273_15 = Mathf.Lerp(iter_273_5.color.r, 0.5, var_273_11)

								iter_273_5.color = Color.New(var_273_15, var_273_15, var_273_15)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_9 + var_273_10 and arg_270_1.time_ < var_273_9 + var_273_10 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.actorSpriteComps106603 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_273_7 then
						if arg_270_1.isInRecall_ then
							iter_273_7.color = arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_273_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps106603 = nil
			end

			local var_273_16 = arg_270_1.actors_["108301"].transform
			local var_273_17 = 0

			if var_273_17 < arg_270_1.time_ and arg_270_1.time_ <= var_273_17 + arg_273_0 then
				arg_270_1.var_.moveOldPos108301 = var_273_16.localPosition
				var_273_16.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("108301", 4)

				local var_273_18 = var_273_16.childCount

				for iter_273_8 = 0, var_273_18 - 1 do
					local var_273_19 = var_273_16:GetChild(iter_273_8)

					if var_273_19.name == "split_1" or not string.find(var_273_19.name, "split") then
						var_273_19.gameObject:SetActive(true)
					else
						var_273_19.gameObject:SetActive(false)
					end
				end
			end

			local var_273_20 = 0.001

			if var_273_17 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_20 then
				local var_273_21 = (arg_270_1.time_ - var_273_17) / var_273_20
				local var_273_22 = Vector3.New(460, -360, -195)

				var_273_16.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos108301, var_273_22, var_273_21)
			end

			if arg_270_1.time_ >= var_273_17 + var_273_20 and arg_270_1.time_ < var_273_17 + var_273_20 + arg_273_0 then
				var_273_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_273_23 = arg_270_1.actors_["128404"].transform
			local var_273_24 = 0

			if var_273_24 < arg_270_1.time_ and arg_270_1.time_ <= var_273_24 + arg_273_0 then
				arg_270_1.var_.moveOldPos128404 = var_273_23.localPosition
				var_273_23.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("128404", 7)

				local var_273_25 = var_273_23.childCount

				for iter_273_9 = 0, var_273_25 - 1 do
					local var_273_26 = var_273_23:GetChild(iter_273_9)

					if var_273_26.name == "" or not string.find(var_273_26.name, "split") then
						var_273_26.gameObject:SetActive(true)
					else
						var_273_26.gameObject:SetActive(false)
					end
				end
			end

			local var_273_27 = 0.001

			if var_273_24 <= arg_270_1.time_ and arg_270_1.time_ < var_273_24 + var_273_27 then
				local var_273_28 = (arg_270_1.time_ - var_273_24) / var_273_27
				local var_273_29 = Vector3.New(0, -2000, 0)

				var_273_23.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos128404, var_273_29, var_273_28)
			end

			if arg_270_1.time_ >= var_273_24 + var_273_27 and arg_270_1.time_ < var_273_24 + var_273_27 + arg_273_0 then
				var_273_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_30 = 0
			local var_273_31 = 0.4

			if var_273_30 < arg_270_1.time_ and arg_270_1.time_ <= var_273_30 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_32 = arg_270_1:FormatText(StoryNameCfg[1332].name)

				arg_270_1.leftNameTxt_.text = var_273_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_33 = arg_270_1:GetWordFromCfg(938032066)
				local var_273_34 = arg_270_1:FormatText(var_273_33.content)

				arg_270_1.text_.text = var_273_34

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_35 = 16
				local var_273_36 = utf8.len(var_273_34)
				local var_273_37 = var_273_35 <= 0 and var_273_31 or var_273_31 * (var_273_36 / var_273_35)

				if var_273_37 > 0 and var_273_31 < var_273_37 then
					arg_270_1.talkMaxDuration = var_273_37

					if var_273_37 + var_273_30 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_37 + var_273_30
					end
				end

				arg_270_1.text_.text = var_273_34
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_38 = math.max(var_273_31, arg_270_1.talkMaxDuration)

			if var_273_30 <= arg_270_1.time_ and arg_270_1.time_ < var_273_30 + var_273_38 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_30) / var_273_38

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_30 + var_273_38 and arg_270_1.time_ < var_273_30 + var_273_38 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play938032067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938032067
		arg_274_1.duration_ = 1

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"

			SetActive(arg_274_1.choicesGo_, true)

			for iter_275_0, iter_275_1 in ipairs(arg_274_1.choices_) do
				local var_275_0 = iter_275_0 <= 1

				SetActive(iter_275_1.go, var_275_0)
			end

			arg_274_1.choices_[1].txt.text = arg_274_1:FormatText(StoryChoiceCfg[1782].name)
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938032068(arg_274_1)
			end

			arg_274_1:RecordChoiceLog(938032067, 1782)
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["108301"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps108301 == nil then
				arg_274_1.var_.actorSpriteComps108301 = var_277_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.actorSpriteComps108301 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								local var_277_4 = Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, var_277_3)
								local var_277_5 = Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, var_277_3)
								local var_277_6 = Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, var_277_3)

								iter_277_1.color = Color.New(var_277_4, var_277_5, var_277_6)
							else
								local var_277_7 = Mathf.Lerp(iter_277_1.color.r, 0.5, var_277_3)

								iter_277_1.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps108301 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_277_3 then
						if arg_274_1.isInRecall_ then
							iter_277_3.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps108301 = nil
			end

			local var_277_8 = 0

			if var_277_8 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			local var_277_9 = 0.999999999999

			if arg_274_1.time_ >= var_277_8 + var_277_9 and arg_274_1.time_ < var_277_8 + var_277_9 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938032068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938032068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938032069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 2

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				local var_281_1 = manager.ui.mainCamera.transform.localPosition
				local var_281_2 = Vector3.New(0, 0, 10) + Vector3.New(var_281_1.x, var_281_1.y, 0)
				local var_281_3 = arg_278_1.bgs_.ST0119

				var_281_3.transform.localPosition = var_281_2
				var_281_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_4 = var_281_3:GetComponent("SpriteRenderer")

				if var_281_4 and var_281_4.sprite then
					local var_281_5 = (var_281_3.transform.localPosition - var_281_1).z
					local var_281_6 = manager.ui.mainCameraCom_
					local var_281_7 = 2 * var_281_5 * Mathf.Tan(var_281_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_281_8 = var_281_7 * var_281_6.aspect
					local var_281_9 = var_281_4.sprite.bounds.size.x
					local var_281_10 = var_281_4.sprite.bounds.size.y
					local var_281_11 = var_281_8 / var_281_9
					local var_281_12 = var_281_7 / var_281_10
					local var_281_13 = var_281_12 < var_281_11 and var_281_11 or var_281_12

					var_281_3.transform.localScale = Vector3.New(var_281_13, var_281_13, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "ST0119" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_14 = 4

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			local var_281_15 = 0.3

			if arg_278_1.time_ >= var_281_14 + var_281_15 and arg_278_1.time_ < var_281_14 + var_281_15 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
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

			local var_281_27 = arg_278_1.actors_["108301"]
			local var_281_28 = 3.799999999999

			if var_281_28 < arg_278_1.time_ and arg_278_1.time_ <= var_281_28 + arg_281_0 and not isNil(var_281_27) and arg_278_1.var_.actorSpriteComps108301 == nil then
				arg_278_1.var_.actorSpriteComps108301 = var_281_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_29 = 0.2

			if var_281_28 <= arg_278_1.time_ and arg_278_1.time_ < var_281_28 + var_281_29 and not isNil(var_281_27) then
				local var_281_30 = (arg_278_1.time_ - var_281_28) / var_281_29

				if arg_278_1.var_.actorSpriteComps108301 then
					for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_281_3 then
							if arg_278_1.isInRecall_ then
								local var_281_31 = Mathf.Lerp(iter_281_3.color.r, arg_278_1.hightColor1.r, var_281_30)
								local var_281_32 = Mathf.Lerp(iter_281_3.color.g, arg_278_1.hightColor1.g, var_281_30)
								local var_281_33 = Mathf.Lerp(iter_281_3.color.b, arg_278_1.hightColor1.b, var_281_30)

								iter_281_3.color = Color.New(var_281_31, var_281_32, var_281_33)
							else
								local var_281_34 = Mathf.Lerp(iter_281_3.color.r, 1, var_281_30)

								iter_281_3.color = Color.New(var_281_34, var_281_34, var_281_34)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_28 + var_281_29 and arg_278_1.time_ < var_281_28 + var_281_29 + arg_281_0 and not isNil(var_281_27) and arg_278_1.var_.actorSpriteComps108301 then
				for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_281_5 then
						if arg_278_1.isInRecall_ then
							iter_281_5.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps108301 = nil
			end

			local var_281_35 = arg_278_1.actors_["108301"].transform
			local var_281_36 = 3.8

			if var_281_36 < arg_278_1.time_ and arg_278_1.time_ <= var_281_36 + arg_281_0 then
				arg_278_1.var_.moveOldPos108301 = var_281_35.localPosition
				var_281_35.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("108301", 3)

				local var_281_37 = var_281_35.childCount

				for iter_281_6 = 0, var_281_37 - 1 do
					local var_281_38 = var_281_35:GetChild(iter_281_6)

					if var_281_38.name == "" or not string.find(var_281_38.name, "split") then
						var_281_38.gameObject:SetActive(true)
					else
						var_281_38.gameObject:SetActive(false)
					end
				end
			end

			local var_281_39 = 0.001

			if var_281_36 <= arg_278_1.time_ and arg_278_1.time_ < var_281_36 + var_281_39 then
				local var_281_40 = (arg_278_1.time_ - var_281_36) / var_281_39
				local var_281_41 = Vector3.New(0, -360, -195)

				var_281_35.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos108301, var_281_41, var_281_40)
			end

			if arg_278_1.time_ >= var_281_36 + var_281_39 and arg_278_1.time_ < var_281_36 + var_281_39 + arg_281_0 then
				var_281_35.localPosition = Vector3.New(0, -360, -195)
			end

			local var_281_42 = arg_278_1.actors_["108301"].transform
			local var_281_43 = 1.966

			if var_281_43 < arg_278_1.time_ and arg_278_1.time_ <= var_281_43 + arg_281_0 then
				arg_278_1.var_.moveOldPos108301 = var_281_42.localPosition
				var_281_42.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("108301", 7)

				local var_281_44 = var_281_42.childCount

				for iter_281_7 = 0, var_281_44 - 1 do
					local var_281_45 = var_281_42:GetChild(iter_281_7)

					if var_281_45.name == "" or not string.find(var_281_45.name, "split") then
						var_281_45.gameObject:SetActive(true)
					else
						var_281_45.gameObject:SetActive(false)
					end
				end
			end

			local var_281_46 = 0.001

			if var_281_43 <= arg_278_1.time_ and arg_278_1.time_ < var_281_43 + var_281_46 then
				local var_281_47 = (arg_278_1.time_ - var_281_43) / var_281_46
				local var_281_48 = Vector3.New(0, -2000, 0)

				var_281_42.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos108301, var_281_48, var_281_47)
			end

			if arg_278_1.time_ >= var_281_43 + var_281_46 and arg_278_1.time_ < var_281_43 + var_281_46 + arg_281_0 then
				var_281_42.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_49 = arg_278_1.actors_["106603"].transform
			local var_281_50 = 1.966

			if var_281_50 < arg_278_1.time_ and arg_278_1.time_ <= var_281_50 + arg_281_0 then
				arg_278_1.var_.moveOldPos106603 = var_281_49.localPosition
				var_281_49.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("106603", 7)

				local var_281_51 = var_281_49.childCount

				for iter_281_8 = 0, var_281_51 - 1 do
					local var_281_52 = var_281_49:GetChild(iter_281_8)

					if var_281_52.name == "" or not string.find(var_281_52.name, "split") then
						var_281_52.gameObject:SetActive(true)
					else
						var_281_52.gameObject:SetActive(false)
					end
				end
			end

			local var_281_53 = 0.001

			if var_281_50 <= arg_278_1.time_ and arg_278_1.time_ < var_281_50 + var_281_53 then
				local var_281_54 = (arg_278_1.time_ - var_281_50) / var_281_53
				local var_281_55 = Vector3.New(0, -2000, 0)

				var_281_49.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos106603, var_281_55, var_281_54)
			end

			if arg_278_1.time_ >= var_281_50 + var_281_53 and arg_278_1.time_ < var_281_50 + var_281_53 + arg_281_0 then
				var_281_49.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_56 = arg_278_1.actors_["108301"]
			local var_281_57 = 3.799999999999

			if var_281_57 < arg_278_1.time_ and arg_278_1.time_ <= var_281_57 + arg_281_0 then
				local var_281_58 = var_281_56:GetComponentInChildren(typeof(CanvasGroup))

				if var_281_58 then
					arg_278_1.var_.alphaOldValue108301 = var_281_58.alpha
					arg_278_1.var_.characterEffect108301 = var_281_58
				end

				arg_278_1.var_.alphaOldValue108301 = 0
			end

			local var_281_59 = 0.5

			if var_281_57 <= arg_278_1.time_ and arg_278_1.time_ < var_281_57 + var_281_59 then
				local var_281_60 = (arg_278_1.time_ - var_281_57) / var_281_59
				local var_281_61 = Mathf.Lerp(arg_278_1.var_.alphaOldValue108301, 1, var_281_60)

				if arg_278_1.var_.characterEffect108301 then
					arg_278_1.var_.characterEffect108301.alpha = var_281_61
				end
			end

			if arg_278_1.time_ >= var_281_57 + var_281_59 and arg_278_1.time_ < var_281_57 + var_281_59 + arg_281_0 and arg_278_1.var_.characterEffect108301 then
				arg_278_1.var_.characterEffect108301.alpha = 1
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_62 = 3.999999999999
			local var_281_63 = 0.525

			if var_281_62 < arg_278_1.time_ and arg_278_1.time_ <= var_281_62 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_64 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_64:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_65 = arg_278_1:FormatText(StoryNameCfg[1332].name)

				arg_278_1.leftNameTxt_.text = var_281_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_66 = arg_278_1:GetWordFromCfg(938032068)
				local var_281_67 = arg_278_1:FormatText(var_281_66.content)

				arg_278_1.text_.text = var_281_67

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_68 = 21
				local var_281_69 = utf8.len(var_281_67)
				local var_281_70 = var_281_68 <= 0 and var_281_63 or var_281_63 * (var_281_69 / var_281_68)

				if var_281_70 > 0 and var_281_63 < var_281_70 then
					arg_278_1.talkMaxDuration = var_281_70
					var_281_62 = var_281_62 + 0.3

					if var_281_70 + var_281_62 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_70 + var_281_62
					end
				end

				arg_278_1.text_.text = var_281_67
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_71 = var_281_62 + 0.3
			local var_281_72 = math.max(var_281_63, arg_278_1.talkMaxDuration)

			if var_281_71 <= arg_278_1.time_ and arg_278_1.time_ < var_281_71 + var_281_72 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_71) / var_281_72

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_71 + var_281_72 and arg_278_1.time_ < var_281_71 + var_281_72 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play938032069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 938032069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play938032070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["108301"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps108301 == nil then
				arg_284_1.var_.actorSpriteComps108301 = var_287_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.actorSpriteComps108301 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								local var_287_4 = Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor2.r, var_287_3)
								local var_287_5 = Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor2.g, var_287_3)
								local var_287_6 = Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor2.b, var_287_3)

								iter_287_1.color = Color.New(var_287_4, var_287_5, var_287_6)
							else
								local var_287_7 = Mathf.Lerp(iter_287_1.color.r, 0.5, var_287_3)

								iter_287_1.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps108301 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_287_3 then
						if arg_284_1.isInRecall_ then
							iter_287_3.color = arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_287_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps108301 = nil
			end

			local var_287_8 = 0
			local var_287_9 = 0.5

			if var_287_8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_10 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_11 = arg_284_1:GetWordFromCfg(938032069)
				local var_287_12 = arg_284_1:FormatText(var_287_11.content)

				arg_284_1.text_.text = var_287_12

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 20
				local var_287_14 = utf8.len(var_287_12)
				local var_287_15 = var_287_13 <= 0 and var_287_9 or var_287_9 * (var_287_14 / var_287_13)

				if var_287_15 > 0 and var_287_9 < var_287_15 then
					arg_284_1.talkMaxDuration = var_287_15

					if var_287_15 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_15 + var_287_8
					end
				end

				arg_284_1.text_.text = var_287_12
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_9, arg_284_1.talkMaxDuration)

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_8) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_8 + var_287_16 and arg_284_1.time_ < var_287_8 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play938032070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 938032070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play938032071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["108301"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps108301 == nil then
				arg_288_1.var_.actorSpriteComps108301 = var_291_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_2 = 0.2

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.actorSpriteComps108301 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								local var_291_4 = Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor1.r, var_291_3)
								local var_291_5 = Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor1.g, var_291_3)
								local var_291_6 = Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor1.b, var_291_3)

								iter_291_1.color = Color.New(var_291_4, var_291_5, var_291_6)
							else
								local var_291_7 = Mathf.Lerp(iter_291_1.color.r, 1, var_291_3)

								iter_291_1.color = Color.New(var_291_7, var_291_7, var_291_7)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps108301 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_291_3 then
						if arg_288_1.isInRecall_ then
							iter_291_3.color = arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_291_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps108301 = nil
			end

			local var_291_8 = arg_288_1.actors_["108301"].transform
			local var_291_9 = 0

			if var_291_9 < arg_288_1.time_ and arg_288_1.time_ <= var_291_9 + arg_291_0 then
				arg_288_1.var_.moveOldPos108301 = var_291_8.localPosition
				var_291_8.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("108301", 3)

				local var_291_10 = var_291_8.childCount

				for iter_291_4 = 0, var_291_10 - 1 do
					local var_291_11 = var_291_8:GetChild(iter_291_4)

					if var_291_11.name == "split_2" or not string.find(var_291_11.name, "split") then
						var_291_11.gameObject:SetActive(true)
					else
						var_291_11.gameObject:SetActive(false)
					end
				end
			end

			local var_291_12 = 0.001

			if var_291_9 <= arg_288_1.time_ and arg_288_1.time_ < var_291_9 + var_291_12 then
				local var_291_13 = (arg_288_1.time_ - var_291_9) / var_291_12
				local var_291_14 = Vector3.New(0, -360, -195)

				var_291_8.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos108301, var_291_14, var_291_13)
			end

			if arg_288_1.time_ >= var_291_9 + var_291_12 and arg_288_1.time_ < var_291_9 + var_291_12 + arg_291_0 then
				var_291_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_291_15 = 0
			local var_291_16 = 0.4

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[1332].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(938032070)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 16
				local var_291_21 = utf8.len(var_291_19)
				local var_291_22 = var_291_20 <= 0 and var_291_16 or var_291_16 * (var_291_21 / var_291_20)

				if var_291_22 > 0 and var_291_16 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_15
					end
				end

				arg_288_1.text_.text = var_291_19
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_23 = math.max(var_291_16, arg_288_1.talkMaxDuration)

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_23 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_15) / var_291_23

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_15 + var_291_23 and arg_288_1.time_ < var_291_15 + var_291_23 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play938032071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 938032071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play938032072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["108301"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps108301 == nil then
				arg_292_1.var_.actorSpriteComps108301 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps108301 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								local var_295_4 = Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor2.r, var_295_3)
								local var_295_5 = Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor2.g, var_295_3)
								local var_295_6 = Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor2.b, var_295_3)

								iter_295_1.color = Color.New(var_295_4, var_295_5, var_295_6)
							else
								local var_295_7 = Mathf.Lerp(iter_295_1.color.r, 0.5, var_295_3)

								iter_295_1.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps108301 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_295_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps108301 = nil
			end

			local var_295_8 = 0
			local var_295_9 = 0.475

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_10 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_11 = arg_292_1:GetWordFromCfg(938032071)
				local var_295_12 = arg_292_1:FormatText(var_295_11.content)

				arg_292_1.text_.text = var_295_12

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_13 = 19
				local var_295_14 = utf8.len(var_295_12)
				local var_295_15 = var_295_13 <= 0 and var_295_9 or var_295_9 * (var_295_14 / var_295_13)

				if var_295_15 > 0 and var_295_9 < var_295_15 then
					arg_292_1.talkMaxDuration = var_295_15

					if var_295_15 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_15 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_12
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_16 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_16 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_8) / var_295_16

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_8 + var_295_16 and arg_292_1.time_ < var_295_8 + var_295_16 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play938032072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 938032072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play938032073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["108301"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps108301 == nil then
				arg_296_1.var_.actorSpriteComps108301 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps108301 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps108301 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps108301 = nil
			end

			local var_299_8 = arg_296_1.actors_["108301"].transform
			local var_299_9 = 0

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.var_.moveOldPos108301 = var_299_8.localPosition
				var_299_8.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("108301", 3)

				local var_299_10 = var_299_8.childCount

				for iter_299_4 = 0, var_299_10 - 1 do
					local var_299_11 = var_299_8:GetChild(iter_299_4)

					if var_299_11.name == "split_1" or not string.find(var_299_11.name, "split") then
						var_299_11.gameObject:SetActive(true)
					else
						var_299_11.gameObject:SetActive(false)
					end
				end
			end

			local var_299_12 = 0.001

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_12 then
				local var_299_13 = (arg_296_1.time_ - var_299_9) / var_299_12
				local var_299_14 = Vector3.New(0, -360, -195)

				var_299_8.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos108301, var_299_14, var_299_13)
			end

			if arg_296_1.time_ >= var_299_9 + var_299_12 and arg_296_1.time_ < var_299_9 + var_299_12 + arg_299_0 then
				var_299_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_299_15 = 0
			local var_299_16 = 0.3

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_17 = arg_296_1:FormatText(StoryNameCfg[1332].name)

				arg_296_1.leftNameTxt_.text = var_299_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:GetWordFromCfg(938032072)
				local var_299_19 = arg_296_1:FormatText(var_299_18.content)

				arg_296_1.text_.text = var_299_19

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_20 = 12
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
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_23 = math.max(var_299_16, arg_296_1.talkMaxDuration)

			if var_299_15 <= arg_296_1.time_ and arg_296_1.time_ < var_299_15 + var_299_23 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_15) / var_299_23

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_15 + var_299_23 and arg_296_1.time_ < var_299_15 + var_299_23 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play938032073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 938032073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play938032074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["108301"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps108301 == nil then
				arg_300_1.var_.actorSpriteComps108301 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps108301 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps108301 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps108301 = nil
			end

			local var_303_8 = 0
			local var_303_9 = 0.6

			if var_303_8 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_10 = arg_300_1:FormatText(StoryNameCfg[7].name)

				arg_300_1.leftNameTxt_.text = var_303_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_11 = arg_300_1:GetWordFromCfg(938032073)
				local var_303_12 = arg_300_1:FormatText(var_303_11.content)

				arg_300_1.text_.text = var_303_12

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_13 = 24
				local var_303_14 = utf8.len(var_303_12)
				local var_303_15 = var_303_13 <= 0 and var_303_9 or var_303_9 * (var_303_14 / var_303_13)

				if var_303_15 > 0 and var_303_9 < var_303_15 then
					arg_300_1.talkMaxDuration = var_303_15

					if var_303_15 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_15 + var_303_8
					end
				end

				arg_300_1.text_.text = var_303_12
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_9, arg_300_1.talkMaxDuration)

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_8) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_8 + var_303_16 and arg_300_1.time_ < var_303_8 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play938032074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 938032074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play938032075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["108301"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps108301 == nil then
				arg_304_1.var_.actorSpriteComps108301 = var_307_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_2 = 0.2

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.actorSpriteComps108301 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								local var_307_4 = Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor1.r, var_307_3)
								local var_307_5 = Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor1.g, var_307_3)
								local var_307_6 = Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor1.b, var_307_3)

								iter_307_1.color = Color.New(var_307_4, var_307_5, var_307_6)
							else
								local var_307_7 = Mathf.Lerp(iter_307_1.color.r, 1, var_307_3)

								iter_307_1.color = Color.New(var_307_7, var_307_7, var_307_7)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps108301 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_307_3 then
						if arg_304_1.isInRecall_ then
							iter_307_3.color = arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_307_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_304_1.var_.actorSpriteComps108301 = nil
			end

			local var_307_8 = arg_304_1.actors_["108301"].transform
			local var_307_9 = 0

			if var_307_9 < arg_304_1.time_ and arg_304_1.time_ <= var_307_9 + arg_307_0 then
				arg_304_1.var_.moveOldPos108301 = var_307_8.localPosition
				var_307_8.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("108301", 3)

				local var_307_10 = var_307_8.childCount

				for iter_307_4 = 0, var_307_10 - 1 do
					local var_307_11 = var_307_8:GetChild(iter_307_4)

					if var_307_11.name == "split_2" then
						var_307_11:SetAsLastSibling()
						var_307_11.gameObject:SetActive(true)

						arg_304_1.var_.actorSpriteSplit108301 = var_307_11.gameObject:GetComponent(typeof(Image))

						arg_304_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_307_12 = 0.5

			if var_307_9 <= arg_304_1.time_ and arg_304_1.time_ < var_307_9 + var_307_12 then
				local var_307_13 = (arg_304_1.time_ - var_307_9) / var_307_12
				local var_307_14 = Vector3.New(0, -360, -195)

				var_307_8.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos108301, var_307_14, var_307_13)

				if arg_304_1.var_.actorSpriteSplit108301 ~= nil then
					arg_304_1.var_.actorSpriteSplit108301:SetAlpha(var_307_13)
				end
			end

			if arg_304_1.time_ >= var_307_9 + var_307_12 and arg_304_1.time_ < var_307_9 + var_307_12 + arg_307_0 then
				var_307_8.localPosition = Vector3.New(0, -360, -195)

				if arg_304_1.var_.actorSpriteSplit108301 ~= nil then
					arg_304_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_307_15 = 0
			local var_307_16 = 0.675

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_17 = arg_304_1:FormatText(StoryNameCfg[1332].name)

				arg_304_1.leftNameTxt_.text = var_307_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(938032074)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 27
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_16 or var_307_16 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_16 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_23 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_23 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_15) / var_307_23

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_15 + var_307_23 and arg_304_1.time_ < var_307_15 + var_307_23 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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

		arg_304_1:InitPlayNodeList()
	end,
	Play938032075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 938032075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play938032076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["108301"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps108301 == nil then
				arg_308_1.var_.actorSpriteComps108301 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps108301 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor2.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor2.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor2.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 0.5, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps108301 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_311_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps108301 = nil
			end

			local var_311_8 = 0
			local var_311_9 = 0.725

			if var_311_8 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_10 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_11 = arg_308_1:GetWordFromCfg(938032075)
				local var_311_12 = arg_308_1:FormatText(var_311_11.content)

				arg_308_1.text_.text = var_311_12

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 29
				local var_311_14 = utf8.len(var_311_12)
				local var_311_15 = var_311_13 <= 0 and var_311_9 or var_311_9 * (var_311_14 / var_311_13)

				if var_311_15 > 0 and var_311_9 < var_311_15 then
					arg_308_1.talkMaxDuration = var_311_15

					if var_311_15 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_15 + var_311_8
					end
				end

				arg_308_1.text_.text = var_311_12
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_9, arg_308_1.talkMaxDuration)

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_8) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_8 + var_311_16 and arg_308_1.time_ < var_311_8 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play938032076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 938032076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play938032077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["108301"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps108301 == nil then
				arg_312_1.var_.actorSpriteComps108301 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps108301 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps108301 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps108301 = nil
			end

			local var_315_8 = arg_312_1.actors_["108301"].transform
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.var_.moveOldPos108301 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("108301", 3)

				local var_315_10 = var_315_8.childCount

				for iter_315_4 = 0, var_315_10 - 1 do
					local var_315_11 = var_315_8:GetChild(iter_315_4)

					if var_315_11.name == "split_5" then
						var_315_11:SetAsLastSibling()
						var_315_11.gameObject:SetActive(true)

						arg_312_1.var_.actorSpriteSplit108301 = var_315_11.gameObject:GetComponent(typeof(Image))

						arg_312_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_315_12 = 0.5

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_9) / var_315_12
				local var_315_14 = Vector3.New(0, -360, -195)

				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos108301, var_315_14, var_315_13)

				if arg_312_1.var_.actorSpriteSplit108301 ~= nil then
					arg_312_1.var_.actorSpriteSplit108301:SetAlpha(var_315_13)
				end
			end

			if arg_312_1.time_ >= var_315_9 + var_315_12 and arg_312_1.time_ < var_315_9 + var_315_12 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(0, -360, -195)

				if arg_312_1.var_.actorSpriteSplit108301 ~= nil then
					arg_312_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_315_15 = 0
			local var_315_16 = 0.5

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[1332].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(938032076)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 20
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_23 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_23 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_23

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_23 and arg_312_1.time_ < var_315_15 + var_315_23 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play938032077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 938032077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play938032078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["108301"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps108301 == nil then
				arg_316_1.var_.actorSpriteComps108301 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps108301 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps108301 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_319_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps108301 = nil
			end

			local var_319_8 = 0
			local var_319_9 = 0.925

			if var_319_8 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_10 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_11 = arg_316_1:GetWordFromCfg(938032077)
				local var_319_12 = arg_316_1:FormatText(var_319_11.content)

				arg_316_1.text_.text = var_319_12

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 37
				local var_319_14 = utf8.len(var_319_12)
				local var_319_15 = var_319_13 <= 0 and var_319_9 or var_319_9 * (var_319_14 / var_319_13)

				if var_319_15 > 0 and var_319_9 < var_319_15 then
					arg_316_1.talkMaxDuration = var_319_15

					if var_319_15 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_15 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_12
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play938032078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 938032078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play938032079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10144"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps10144 == nil then
				arg_320_1.var_.actorSpriteComps10144 = var_323_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.actorSpriteComps10144 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								local var_323_4 = Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor1.r, var_323_3)
								local var_323_5 = Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor1.g, var_323_3)
								local var_323_6 = Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor1.b, var_323_3)

								iter_323_1.color = Color.New(var_323_4, var_323_5, var_323_6)
							else
								local var_323_7 = Mathf.Lerp(iter_323_1.color.r, 1, var_323_3)

								iter_323_1.color = Color.New(var_323_7, var_323_7, var_323_7)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps10144 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_323_3 then
						if arg_320_1.isInRecall_ then
							iter_323_3.color = arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_323_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps10144 = nil
			end

			local var_323_8 = arg_320_1.actors_["10144"].transform
			local var_323_9 = 0

			if var_323_9 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 then
				arg_320_1.var_.moveOldPos10144 = var_323_8.localPosition
				var_323_8.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10144", 4)

				local var_323_10 = var_323_8.childCount

				for iter_323_4 = 0, var_323_10 - 1 do
					local var_323_11 = var_323_8:GetChild(iter_323_4)

					if var_323_11.name == "split_2" or not string.find(var_323_11.name, "split") then
						var_323_11.gameObject:SetActive(true)
					else
						var_323_11.gameObject:SetActive(false)
					end
				end
			end

			local var_323_12 = 0.001

			if var_323_9 <= arg_320_1.time_ and arg_320_1.time_ < var_323_9 + var_323_12 then
				local var_323_13 = (arg_320_1.time_ - var_323_9) / var_323_12
				local var_323_14 = Vector3.New(435.8, -381.1, -285.9)

				var_323_8.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10144, var_323_14, var_323_13)
			end

			if arg_320_1.time_ >= var_323_9 + var_323_12 and arg_320_1.time_ < var_323_9 + var_323_12 + arg_323_0 then
				var_323_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_323_15 = arg_320_1.actors_["108301"].transform
			local var_323_16 = 0

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.var_.moveOldPos108301 = var_323_15.localPosition
				var_323_15.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("108301", 2)

				local var_323_17 = var_323_15.childCount

				for iter_323_5 = 0, var_323_17 - 1 do
					local var_323_18 = var_323_15:GetChild(iter_323_5)

					if var_323_18.name == "" or not string.find(var_323_18.name, "split") then
						var_323_18.gameObject:SetActive(true)
					else
						var_323_18.gameObject:SetActive(false)
					end
				end
			end

			local var_323_19 = 0.001

			if var_323_16 <= arg_320_1.time_ and arg_320_1.time_ < var_323_16 + var_323_19 then
				local var_323_20 = (arg_320_1.time_ - var_323_16) / var_323_19
				local var_323_21 = Vector3.New(-420, -360, -195)

				var_323_15.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos108301, var_323_21, var_323_20)
			end

			if arg_320_1.time_ >= var_323_16 + var_323_19 and arg_320_1.time_ < var_323_16 + var_323_19 + arg_323_0 then
				var_323_15.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_323_22 = 0
			local var_323_23 = 1.05

			if var_323_22 < arg_320_1.time_ and arg_320_1.time_ <= var_323_22 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_24 = arg_320_1:FormatText(StoryNameCfg[1297].name)

				arg_320_1.leftNameTxt_.text = var_323_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_25 = arg_320_1:GetWordFromCfg(938032078)
				local var_323_26 = arg_320_1:FormatText(var_323_25.content)

				arg_320_1.text_.text = var_323_26

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_27 = 42
				local var_323_28 = utf8.len(var_323_26)
				local var_323_29 = var_323_27 <= 0 and var_323_23 or var_323_23 * (var_323_28 / var_323_27)

				if var_323_29 > 0 and var_323_23 < var_323_29 then
					arg_320_1.talkMaxDuration = var_323_29

					if var_323_29 + var_323_22 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_29 + var_323_22
					end
				end

				arg_320_1.text_.text = var_323_26
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_30 = math.max(var_323_23, arg_320_1.talkMaxDuration)

			if var_323_22 <= arg_320_1.time_ and arg_320_1.time_ < var_323_22 + var_323_30 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_22) / var_323_30

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_22 + var_323_30 and arg_320_1.time_ < var_323_22 + var_323_30 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play938032079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 938032079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play938032080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["108301"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps108301 == nil then
				arg_324_1.var_.actorSpriteComps108301 = var_327_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.actorSpriteComps108301 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								local var_327_4 = Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor1.r, var_327_3)
								local var_327_5 = Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor1.g, var_327_3)
								local var_327_6 = Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor1.b, var_327_3)

								iter_327_1.color = Color.New(var_327_4, var_327_5, var_327_6)
							else
								local var_327_7 = Mathf.Lerp(iter_327_1.color.r, 1, var_327_3)

								iter_327_1.color = Color.New(var_327_7, var_327_7, var_327_7)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps108301 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_327_3 then
						if arg_324_1.isInRecall_ then
							iter_327_3.color = arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_327_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps108301 = nil
			end

			local var_327_8 = arg_324_1.actors_["10144"]
			local var_327_9 = 0

			if var_327_9 < arg_324_1.time_ and arg_324_1.time_ <= var_327_9 + arg_327_0 and not isNil(var_327_8) and arg_324_1.var_.actorSpriteComps10144 == nil then
				arg_324_1.var_.actorSpriteComps10144 = var_327_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_10 = 0.2

			if var_327_9 <= arg_324_1.time_ and arg_324_1.time_ < var_327_9 + var_327_10 and not isNil(var_327_8) then
				local var_327_11 = (arg_324_1.time_ - var_327_9) / var_327_10

				if arg_324_1.var_.actorSpriteComps10144 then
					for iter_327_4, iter_327_5 in pairs(arg_324_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_327_5 then
							if arg_324_1.isInRecall_ then
								local var_327_12 = Mathf.Lerp(iter_327_5.color.r, arg_324_1.hightColor2.r, var_327_11)
								local var_327_13 = Mathf.Lerp(iter_327_5.color.g, arg_324_1.hightColor2.g, var_327_11)
								local var_327_14 = Mathf.Lerp(iter_327_5.color.b, arg_324_1.hightColor2.b, var_327_11)

								iter_327_5.color = Color.New(var_327_12, var_327_13, var_327_14)
							else
								local var_327_15 = Mathf.Lerp(iter_327_5.color.r, 0.5, var_327_11)

								iter_327_5.color = Color.New(var_327_15, var_327_15, var_327_15)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_9 + var_327_10 and arg_324_1.time_ < var_327_9 + var_327_10 + arg_327_0 and not isNil(var_327_8) and arg_324_1.var_.actorSpriteComps10144 then
				for iter_327_6, iter_327_7 in pairs(arg_324_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_327_7 then
						if arg_324_1.isInRecall_ then
							iter_327_7.color = arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_327_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps10144 = nil
			end

			local var_327_16 = arg_324_1.actors_["108301"].transform
			local var_327_17 = 0

			if var_327_17 < arg_324_1.time_ and arg_324_1.time_ <= var_327_17 + arg_327_0 then
				arg_324_1.var_.moveOldPos108301 = var_327_16.localPosition
				var_327_16.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("108301", 2)

				local var_327_18 = var_327_16.childCount

				for iter_327_8 = 0, var_327_18 - 1 do
					local var_327_19 = var_327_16:GetChild(iter_327_8)

					if var_327_19.name == "" or not string.find(var_327_19.name, "split") then
						var_327_19.gameObject:SetActive(true)
					else
						var_327_19.gameObject:SetActive(false)
					end
				end
			end

			local var_327_20 = 0.001

			if var_327_17 <= arg_324_1.time_ and arg_324_1.time_ < var_327_17 + var_327_20 then
				local var_327_21 = (arg_324_1.time_ - var_327_17) / var_327_20
				local var_327_22 = Vector3.New(-420, -360, -195)

				var_327_16.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos108301, var_327_22, var_327_21)
			end

			if arg_324_1.time_ >= var_327_17 + var_327_20 and arg_324_1.time_ < var_327_17 + var_327_20 + arg_327_0 then
				var_327_16.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_327_23 = 0
			local var_327_24 = 0.4

			if var_327_23 < arg_324_1.time_ and arg_324_1.time_ <= var_327_23 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_25 = arg_324_1:FormatText(StoryNameCfg[1332].name)

				arg_324_1.leftNameTxt_.text = var_327_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_26 = arg_324_1:GetWordFromCfg(938032079)
				local var_327_27 = arg_324_1:FormatText(var_327_26.content)

				arg_324_1.text_.text = var_327_27

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_28 = 16
				local var_327_29 = utf8.len(var_327_27)
				local var_327_30 = var_327_28 <= 0 and var_327_24 or var_327_24 * (var_327_29 / var_327_28)

				if var_327_30 > 0 and var_327_24 < var_327_30 then
					arg_324_1.talkMaxDuration = var_327_30

					if var_327_30 + var_327_23 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_30 + var_327_23
					end
				end

				arg_324_1.text_.text = var_327_27
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_31 = math.max(var_327_24, arg_324_1.talkMaxDuration)

			if var_327_23 <= arg_324_1.time_ and arg_324_1.time_ < var_327_23 + var_327_31 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_23) / var_327_31

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_23 + var_327_31 and arg_324_1.time_ < var_327_23 + var_327_31 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
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

		arg_324_1:InitPlayNodeList()
	end,
	Play938032080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 938032080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play938032081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["108301"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps108301 == nil then
				arg_328_1.var_.actorSpriteComps108301 = var_331_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.actorSpriteComps108301 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								local var_331_4 = Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, var_331_3)
								local var_331_5 = Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, var_331_3)
								local var_331_6 = Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, var_331_3)

								iter_331_1.color = Color.New(var_331_4, var_331_5, var_331_6)
							else
								local var_331_7 = Mathf.Lerp(iter_331_1.color.r, 0.5, var_331_3)

								iter_331_1.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps108301 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_331_3 then
						if arg_328_1.isInRecall_ then
							iter_331_3.color = arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_331_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_328_1.var_.actorSpriteComps108301 = nil
			end

			local var_331_8 = 0
			local var_331_9 = 0.175

			if var_331_8 < arg_328_1.time_ and arg_328_1.time_ <= var_331_8 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_10 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_11 = arg_328_1:GetWordFromCfg(938032080)
				local var_331_12 = arg_328_1:FormatText(var_331_11.content)

				arg_328_1.text_.text = var_331_12

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_13 = 7
				local var_331_14 = utf8.len(var_331_12)
				local var_331_15 = var_331_13 <= 0 and var_331_9 or var_331_9 * (var_331_14 / var_331_13)

				if var_331_15 > 0 and var_331_9 < var_331_15 then
					arg_328_1.talkMaxDuration = var_331_15

					if var_331_15 + var_331_8 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_15 + var_331_8
					end
				end

				arg_328_1.text_.text = var_331_12
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_9, arg_328_1.talkMaxDuration)

			if var_331_8 <= arg_328_1.time_ and arg_328_1.time_ < var_331_8 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_8) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_8 + var_331_16 and arg_328_1.time_ < var_331_8 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play938032081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 938032081
		arg_332_1.duration_ = 9

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play938032082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 2

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				local var_335_1 = manager.ui.mainCamera.transform.localPosition
				local var_335_2 = Vector3.New(0, 0, 10) + Vector3.New(var_335_1.x, var_335_1.y, 0)
				local var_335_3 = arg_332_1.bgs_.ST0119

				var_335_3.transform.localPosition = var_335_2
				var_335_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_4 = var_335_3:GetComponent("SpriteRenderer")

				if var_335_4 and var_335_4.sprite then
					local var_335_5 = (var_335_3.transform.localPosition - var_335_1).z
					local var_335_6 = manager.ui.mainCameraCom_
					local var_335_7 = 2 * var_335_5 * Mathf.Tan(var_335_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_335_8 = var_335_7 * var_335_6.aspect
					local var_335_9 = var_335_4.sprite.bounds.size.x
					local var_335_10 = var_335_4.sprite.bounds.size.y
					local var_335_11 = var_335_8 / var_335_9
					local var_335_12 = var_335_7 / var_335_10
					local var_335_13 = var_335_12 < var_335_11 and var_335_11 or var_335_12

					var_335_3.transform.localScale = Vector3.New(var_335_13, var_335_13, 0)
				end

				for iter_335_0, iter_335_1 in pairs(arg_332_1.bgs_) do
					if iter_335_0 ~= "ST0119" then
						iter_335_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_14 = 4

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			local var_335_15 = 0.3

			if arg_332_1.time_ >= var_335_14 + var_335_15 and arg_332_1.time_ < var_335_14 + var_335_15 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_16 = 0

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_17 = 2

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_17 then
				local var_335_18 = (arg_332_1.time_ - var_335_16) / var_335_17
				local var_335_19 = Color.New(0, 0, 0)

				var_335_19.a = Mathf.Lerp(0, 1, var_335_18)
				arg_332_1.mask_.color = var_335_19
			end

			if arg_332_1.time_ >= var_335_16 + var_335_17 and arg_332_1.time_ < var_335_16 + var_335_17 + arg_335_0 then
				local var_335_20 = Color.New(0, 0, 0)

				var_335_20.a = 1
				arg_332_1.mask_.color = var_335_20
			end

			local var_335_21 = 2

			if var_335_21 < arg_332_1.time_ and arg_332_1.time_ <= var_335_21 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_22 = 2

			if var_335_21 <= arg_332_1.time_ and arg_332_1.time_ < var_335_21 + var_335_22 then
				local var_335_23 = (arg_332_1.time_ - var_335_21) / var_335_22
				local var_335_24 = Color.New(0, 0, 0)

				var_335_24.a = Mathf.Lerp(1, 0, var_335_23)
				arg_332_1.mask_.color = var_335_24
			end

			if arg_332_1.time_ >= var_335_21 + var_335_22 and arg_332_1.time_ < var_335_21 + var_335_22 + arg_335_0 then
				local var_335_25 = Color.New(0, 0, 0)
				local var_335_26 = 0

				arg_332_1.mask_.enabled = false
				var_335_25.a = var_335_26
				arg_332_1.mask_.color = var_335_25
			end

			local var_335_27 = arg_332_1.actors_["10144"]
			local var_335_28 = 4

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 and not isNil(var_335_27) and arg_332_1.var_.actorSpriteComps10144 == nil then
				arg_332_1.var_.actorSpriteComps10144 = var_335_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_29 = 0.2

			if var_335_28 <= arg_332_1.time_ and arg_332_1.time_ < var_335_28 + var_335_29 and not isNil(var_335_27) then
				local var_335_30 = (arg_332_1.time_ - var_335_28) / var_335_29

				if arg_332_1.var_.actorSpriteComps10144 then
					for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_335_3 then
							if arg_332_1.isInRecall_ then
								local var_335_31 = Mathf.Lerp(iter_335_3.color.r, arg_332_1.hightColor1.r, var_335_30)
								local var_335_32 = Mathf.Lerp(iter_335_3.color.g, arg_332_1.hightColor1.g, var_335_30)
								local var_335_33 = Mathf.Lerp(iter_335_3.color.b, arg_332_1.hightColor1.b, var_335_30)

								iter_335_3.color = Color.New(var_335_31, var_335_32, var_335_33)
							else
								local var_335_34 = Mathf.Lerp(iter_335_3.color.r, 1, var_335_30)

								iter_335_3.color = Color.New(var_335_34, var_335_34, var_335_34)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_28 + var_335_29 and arg_332_1.time_ < var_335_28 + var_335_29 + arg_335_0 and not isNil(var_335_27) and arg_332_1.var_.actorSpriteComps10144 then
				for iter_335_4, iter_335_5 in pairs(arg_332_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_335_5 then
						if arg_332_1.isInRecall_ then
							iter_335_5.color = arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_335_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps10144 = nil
			end

			local var_335_35 = arg_332_1.actors_["108301"].transform
			local var_335_36 = 1.966

			if var_335_36 < arg_332_1.time_ and arg_332_1.time_ <= var_335_36 + arg_335_0 then
				arg_332_1.var_.moveOldPos108301 = var_335_35.localPosition
				var_335_35.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("108301", 7)

				local var_335_37 = var_335_35.childCount

				for iter_335_6 = 0, var_335_37 - 1 do
					local var_335_38 = var_335_35:GetChild(iter_335_6)

					if var_335_38.name == "" or not string.find(var_335_38.name, "split") then
						var_335_38.gameObject:SetActive(true)
					else
						var_335_38.gameObject:SetActive(false)
					end
				end
			end

			local var_335_39 = 0.001

			if var_335_36 <= arg_332_1.time_ and arg_332_1.time_ < var_335_36 + var_335_39 then
				local var_335_40 = (arg_332_1.time_ - var_335_36) / var_335_39
				local var_335_41 = Vector3.New(0, -2000, 0)

				var_335_35.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos108301, var_335_41, var_335_40)
			end

			if arg_332_1.time_ >= var_335_36 + var_335_39 and arg_332_1.time_ < var_335_36 + var_335_39 + arg_335_0 then
				var_335_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_335_42 = arg_332_1.actors_["10144"].transform
			local var_335_43 = 4

			if var_335_43 < arg_332_1.time_ and arg_332_1.time_ <= var_335_43 + arg_335_0 then
				arg_332_1.var_.moveOldPos10144 = var_335_42.localPosition
				var_335_42.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10144", 3)

				local var_335_44 = var_335_42.childCount

				for iter_335_7 = 0, var_335_44 - 1 do
					local var_335_45 = var_335_42:GetChild(iter_335_7)

					if var_335_45.name == "" or not string.find(var_335_45.name, "split") then
						var_335_45.gameObject:SetActive(true)
					else
						var_335_45.gameObject:SetActive(false)
					end
				end
			end

			local var_335_46 = 0.001

			if var_335_43 <= arg_332_1.time_ and arg_332_1.time_ < var_335_43 + var_335_46 then
				local var_335_47 = (arg_332_1.time_ - var_335_43) / var_335_46
				local var_335_48 = Vector3.New(-31.5, -381.1, -285.9)

				var_335_42.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10144, var_335_48, var_335_47)
			end

			if arg_332_1.time_ >= var_335_43 + var_335_46 and arg_332_1.time_ < var_335_43 + var_335_46 + arg_335_0 then
				var_335_42.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_335_49 = arg_332_1.actors_["10144"].transform
			local var_335_50 = 1.966

			if var_335_50 < arg_332_1.time_ and arg_332_1.time_ <= var_335_50 + arg_335_0 then
				arg_332_1.var_.moveOldPos10144 = var_335_49.localPosition
				var_335_49.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10144", 7)

				local var_335_51 = var_335_49.childCount

				for iter_335_8 = 0, var_335_51 - 1 do
					local var_335_52 = var_335_49:GetChild(iter_335_8)

					if var_335_52.name == "" or not string.find(var_335_52.name, "split") then
						var_335_52.gameObject:SetActive(true)
					else
						var_335_52.gameObject:SetActive(false)
					end
				end
			end

			local var_335_53 = 0.001

			if var_335_50 <= arg_332_1.time_ and arg_332_1.time_ < var_335_50 + var_335_53 then
				local var_335_54 = (arg_332_1.time_ - var_335_50) / var_335_53
				local var_335_55 = Vector3.New(0, -2000, 0)

				var_335_49.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10144, var_335_55, var_335_54)
			end

			if arg_332_1.time_ >= var_335_50 + var_335_53 and arg_332_1.time_ < var_335_50 + var_335_53 + arg_335_0 then
				var_335_49.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_56 = 4
			local var_335_57 = 0.725

			if var_335_56 < arg_332_1.time_ and arg_332_1.time_ <= var_335_56 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_58 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_58:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_59 = arg_332_1:FormatText(StoryNameCfg[1297].name)

				arg_332_1.leftNameTxt_.text = var_335_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_60 = arg_332_1:GetWordFromCfg(938032081)
				local var_335_61 = arg_332_1:FormatText(var_335_60.content)

				arg_332_1.text_.text = var_335_61

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_62 = 29
				local var_335_63 = utf8.len(var_335_61)
				local var_335_64 = var_335_62 <= 0 and var_335_57 or var_335_57 * (var_335_63 / var_335_62)

				if var_335_64 > 0 and var_335_57 < var_335_64 then
					arg_332_1.talkMaxDuration = var_335_64
					var_335_56 = var_335_56 + 0.3

					if var_335_64 + var_335_56 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_64 + var_335_56
					end
				end

				arg_332_1.text_.text = var_335_61
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_65 = var_335_56 + 0.3
			local var_335_66 = math.max(var_335_57, arg_332_1.talkMaxDuration)

			if var_335_65 <= arg_332_1.time_ and arg_332_1.time_ < var_335_65 + var_335_66 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_65) / var_335_66

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_65 + var_335_66 and arg_332_1.time_ < var_335_65 + var_335_66 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
				startTime = 4,
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

		arg_332_1:InitPlayNodeList()
	end,
	Play938032082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938032082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938032083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["10144"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10144 == nil then
				arg_338_1.var_.actorSpriteComps10144 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps10144 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor2.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor2.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor2.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 0.5, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10144 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_341_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps10144 = nil
			end

			local var_341_8 = arg_338_1.actors_["10144"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos10144 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10144", 7)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "" or not string.find(var_341_11.name, "split") then
						var_341_11.gameObject:SetActive(true)
					else
						var_341_11.gameObject:SetActive(false)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(0, -2000, 0)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10144, var_341_14, var_341_13)
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_15 = 0.3
			local var_341_16 = 1

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				local var_341_17 = "play"
				local var_341_18 = "effect"

				arg_338_1:AudioAction(var_341_17, var_341_18, "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_341_19 = 0
			local var_341_20 = 1.025

			if var_341_19 < arg_338_1.time_ and arg_338_1.time_ <= var_341_19 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_21 = arg_338_1:GetWordFromCfg(938032082)
				local var_341_22 = arg_338_1:FormatText(var_341_21.content)

				arg_338_1.text_.text = var_341_22

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_23 = 41
				local var_341_24 = utf8.len(var_341_22)
				local var_341_25 = var_341_23 <= 0 and var_341_20 or var_341_20 * (var_341_24 / var_341_23)

				if var_341_25 > 0 and var_341_20 < var_341_25 then
					arg_338_1.talkMaxDuration = var_341_25

					if var_341_25 + var_341_19 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_25 + var_341_19
					end
				end

				arg_338_1.text_.text = var_341_22
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_26 = math.max(var_341_20, arg_338_1.talkMaxDuration)

			if var_341_19 <= arg_338_1.time_ and arg_338_1.time_ < var_341_19 + var_341_26 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_19) / var_341_26

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_19 + var_341_26 and arg_338_1.time_ < var_341_19 + var_341_26 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play938032083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938032083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play938032084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10144"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10144 == nil then
				arg_342_1.var_.actorSpriteComps10144 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps10144 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 1, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10144 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_345_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10144 = nil
			end

			local var_345_8 = arg_342_1.actors_["10144"].transform
			local var_345_9 = 0

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.var_.moveOldPos10144 = var_345_8.localPosition
				var_345_8.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10144", 3)

				local var_345_10 = var_345_8.childCount

				for iter_345_4 = 0, var_345_10 - 1 do
					local var_345_11 = var_345_8:GetChild(iter_345_4)

					if var_345_11.name == "split_7" or not string.find(var_345_11.name, "split") then
						var_345_11.gameObject:SetActive(true)
					else
						var_345_11.gameObject:SetActive(false)
					end
				end
			end

			local var_345_12 = 0.001

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_12 then
				local var_345_13 = (arg_342_1.time_ - var_345_9) / var_345_12
				local var_345_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_345_8.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10144, var_345_14, var_345_13)
			end

			if arg_342_1.time_ >= var_345_9 + var_345_12 and arg_342_1.time_ < var_345_9 + var_345_12 + arg_345_0 then
				var_345_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_345_15 = 0
			local var_345_16 = 1.1

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_17 = arg_342_1:FormatText(StoryNameCfg[1297].name)

				arg_342_1.leftNameTxt_.text = var_345_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_18 = arg_342_1:GetWordFromCfg(938032083)
				local var_345_19 = arg_342_1:FormatText(var_345_18.content)

				arg_342_1.text_.text = var_345_19

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_20 = 44
				local var_345_21 = utf8.len(var_345_19)
				local var_345_22 = var_345_20 <= 0 and var_345_16 or var_345_16 * (var_345_21 / var_345_20)

				if var_345_22 > 0 and var_345_16 < var_345_22 then
					arg_342_1.talkMaxDuration = var_345_22

					if var_345_22 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_22 + var_345_15
					end
				end

				arg_342_1.text_.text = var_345_19
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_23 = math.max(var_345_16, arg_342_1.talkMaxDuration)

			if var_345_15 <= arg_342_1.time_ and arg_342_1.time_ < var_345_15 + var_345_23 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_15) / var_345_23

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_15 + var_345_23 and arg_342_1.time_ < var_345_15 + var_345_23 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play938032084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 938032084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play938032085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10144"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos10144 = var_349_0.localPosition
				var_349_0.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10144", 3)

				local var_349_2 = var_349_0.childCount

				for iter_349_0 = 0, var_349_2 - 1 do
					local var_349_3 = var_349_0:GetChild(iter_349_0)

					if var_349_3.name == "" then
						var_349_3:SetAsLastSibling()
						var_349_3.gameObject:SetActive(true)

						arg_346_1.var_.actorSpriteSplit10144 = var_349_3.gameObject:GetComponent(typeof(Image))

						arg_346_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_349_4 = 0.5

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_4 then
				local var_349_5 = (arg_346_1.time_ - var_349_1) / var_349_4
				local var_349_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10144, var_349_6, var_349_5)

				if arg_346_1.var_.actorSpriteSplit10144 ~= nil then
					arg_346_1.var_.actorSpriteSplit10144:SetAlpha(var_349_5)
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_4 and arg_346_1.time_ < var_349_1 + var_349_4 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_346_1.var_.actorSpriteSplit10144 ~= nil then
					arg_346_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_349_7 = 0
			local var_349_8 = 0.5

			if var_349_7 < arg_346_1.time_ and arg_346_1.time_ <= var_349_7 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_9 = arg_346_1:FormatText(StoryNameCfg[1297].name)

				arg_346_1.leftNameTxt_.text = var_349_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_10 = arg_346_1:GetWordFromCfg(938032084)
				local var_349_11 = arg_346_1:FormatText(var_349_10.content)

				arg_346_1.text_.text = var_349_11

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_12 = 20
				local var_349_13 = utf8.len(var_349_11)
				local var_349_14 = var_349_12 <= 0 and var_349_8 or var_349_8 * (var_349_13 / var_349_12)

				if var_349_14 > 0 and var_349_8 < var_349_14 then
					arg_346_1.talkMaxDuration = var_349_14

					if var_349_14 + var_349_7 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_7
					end
				end

				arg_346_1.text_.text = var_349_11
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_15 = math.max(var_349_8, arg_346_1.talkMaxDuration)

			if var_349_7 <= arg_346_1.time_ and arg_346_1.time_ < var_349_7 + var_349_15 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_7) / var_349_15

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_7 + var_349_15 and arg_346_1.time_ < var_349_7 + var_349_15 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
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

		arg_346_1:InitPlayNodeList()
	end,
	Play938032085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 938032085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play938032086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["104902"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps104902 == nil then
				arg_350_1.var_.actorSpriteComps104902 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps104902 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps104902 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps104902 = nil
			end

			local var_353_8 = arg_350_1.actors_["10144"]
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps10144 == nil then
				arg_350_1.var_.actorSpriteComps10144 = var_353_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_10 = 0.2

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_10 and not isNil(var_353_8) then
				local var_353_11 = (arg_350_1.time_ - var_353_9) / var_353_10

				if arg_350_1.var_.actorSpriteComps10144 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								local var_353_12 = Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor2.r, var_353_11)
								local var_353_13 = Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor2.g, var_353_11)
								local var_353_14 = Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor2.b, var_353_11)

								iter_353_5.color = Color.New(var_353_12, var_353_13, var_353_14)
							else
								local var_353_15 = Mathf.Lerp(iter_353_5.color.r, 0.5, var_353_11)

								iter_353_5.color = Color.New(var_353_15, var_353_15, var_353_15)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_9 + var_353_10 and arg_350_1.time_ < var_353_9 + var_353_10 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps10144 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_353_7 then
						if arg_350_1.isInRecall_ then
							iter_353_7.color = arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_353_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10144 = nil
			end

			local var_353_16 = arg_350_1.actors_["104902"].transform
			local var_353_17 = 0

			if var_353_17 < arg_350_1.time_ and arg_350_1.time_ <= var_353_17 + arg_353_0 then
				arg_350_1.var_.moveOldPos104902 = var_353_16.localPosition
				var_353_16.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("104902", 4)

				local var_353_18 = var_353_16.childCount

				for iter_353_8 = 0, var_353_18 - 1 do
					local var_353_19 = var_353_16:GetChild(iter_353_8)

					if var_353_19.name == "split_2" or not string.find(var_353_19.name, "split") then
						var_353_19.gameObject:SetActive(true)
					else
						var_353_19.gameObject:SetActive(false)
					end
				end
			end

			local var_353_20 = 0.001

			if var_353_17 <= arg_350_1.time_ and arg_350_1.time_ < var_353_17 + var_353_20 then
				local var_353_21 = (arg_350_1.time_ - var_353_17) / var_353_20
				local var_353_22 = Vector3.New(390, -335, -360)

				var_353_16.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos104902, var_353_22, var_353_21)
			end

			if arg_350_1.time_ >= var_353_17 + var_353_20 and arg_350_1.time_ < var_353_17 + var_353_20 + arg_353_0 then
				var_353_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_353_23 = arg_350_1.actors_["10144"].transform
			local var_353_24 = 0

			if var_353_24 < arg_350_1.time_ and arg_350_1.time_ <= var_353_24 + arg_353_0 then
				arg_350_1.var_.moveOldPos10144 = var_353_23.localPosition
				var_353_23.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10144", 2)

				local var_353_25 = var_353_23.childCount

				for iter_353_9 = 0, var_353_25 - 1 do
					local var_353_26 = var_353_23:GetChild(iter_353_9)

					if var_353_26.name == "" or not string.find(var_353_26.name, "split") then
						var_353_26.gameObject:SetActive(true)
					else
						var_353_26.gameObject:SetActive(false)
					end
				end
			end

			local var_353_27 = 0.001

			if var_353_24 <= arg_350_1.time_ and arg_350_1.time_ < var_353_24 + var_353_27 then
				local var_353_28 = (arg_350_1.time_ - var_353_24) / var_353_27
				local var_353_29 = Vector3.New(-507.9, -381.1, -285.9)

				var_353_23.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10144, var_353_29, var_353_28)
			end

			if arg_350_1.time_ >= var_353_24 + var_353_27 and arg_350_1.time_ < var_353_24 + var_353_27 + arg_353_0 then
				var_353_23.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_353_30 = 0
			local var_353_31 = 0.325

			if var_353_30 < arg_350_1.time_ and arg_350_1.time_ <= var_353_30 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_32 = arg_350_1:FormatText(StoryNameCfg[562].name)

				arg_350_1.leftNameTxt_.text = var_353_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_33 = arg_350_1:GetWordFromCfg(938032085)
				local var_353_34 = arg_350_1:FormatText(var_353_33.content)

				arg_350_1.text_.text = var_353_34

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_35 = 13
				local var_353_36 = utf8.len(var_353_34)
				local var_353_37 = var_353_35 <= 0 and var_353_31 or var_353_31 * (var_353_36 / var_353_35)

				if var_353_37 > 0 and var_353_31 < var_353_37 then
					arg_350_1.talkMaxDuration = var_353_37

					if var_353_37 + var_353_30 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_37 + var_353_30
					end
				end

				arg_350_1.text_.text = var_353_34
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_38 = math.max(var_353_31, arg_350_1.talkMaxDuration)

			if var_353_30 <= arg_350_1.time_ and arg_350_1.time_ < var_353_30 + var_353_38 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_30) / var_353_38

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_30 + var_353_38 and arg_350_1.time_ < var_353_30 + var_353_38 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play938032086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 938032086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play938032087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["104902"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps104902 == nil then
				arg_354_1.var_.actorSpriteComps104902 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps104902 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 0.5, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps104902 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_357_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps104902 = nil
			end

			local var_357_8 = arg_354_1.actors_["104902"].transform
			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.var_.moveOldPos104902 = var_357_8.localPosition
				var_357_8.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("104902", 7)

				local var_357_10 = var_357_8.childCount

				for iter_357_4 = 0, var_357_10 - 1 do
					local var_357_11 = var_357_8:GetChild(iter_357_4)

					if var_357_11.name == "" or not string.find(var_357_11.name, "split") then
						var_357_11.gameObject:SetActive(true)
					else
						var_357_11.gameObject:SetActive(false)
					end
				end
			end

			local var_357_12 = 0.001

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_12 then
				local var_357_13 = (arg_354_1.time_ - var_357_9) / var_357_12
				local var_357_14 = Vector3.New(0, -2000, -360)

				var_357_8.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos104902, var_357_14, var_357_13)
			end

			if arg_354_1.time_ >= var_357_9 + var_357_12 and arg_354_1.time_ < var_357_9 + var_357_12 + arg_357_0 then
				var_357_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_357_15 = arg_354_1.actors_["10144"].transform
			local var_357_16 = 0

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.var_.moveOldPos10144 = var_357_15.localPosition
				var_357_15.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10144", 7)

				local var_357_17 = var_357_15.childCount

				for iter_357_5 = 0, var_357_17 - 1 do
					local var_357_18 = var_357_15:GetChild(iter_357_5)

					if var_357_18.name == "" or not string.find(var_357_18.name, "split") then
						var_357_18.gameObject:SetActive(true)
					else
						var_357_18.gameObject:SetActive(false)
					end
				end
			end

			local var_357_19 = 0.001

			if var_357_16 <= arg_354_1.time_ and arg_354_1.time_ < var_357_16 + var_357_19 then
				local var_357_20 = (arg_354_1.time_ - var_357_16) / var_357_19
				local var_357_21 = Vector3.New(0, -2000, 0)

				var_357_15.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10144, var_357_21, var_357_20)
			end

			if arg_354_1.time_ >= var_357_16 + var_357_19 and arg_354_1.time_ < var_357_16 + var_357_19 + arg_357_0 then
				var_357_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_357_22 = 0
			local var_357_23 = 0.525

			if var_357_22 < arg_354_1.time_ and arg_354_1.time_ <= var_357_22 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_24 = arg_354_1:GetWordFromCfg(938032086)
				local var_357_25 = arg_354_1:FormatText(var_357_24.content)

				arg_354_1.text_.text = var_357_25

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_26 = 21
				local var_357_27 = utf8.len(var_357_25)
				local var_357_28 = var_357_26 <= 0 and var_357_23 or var_357_23 * (var_357_27 / var_357_26)

				if var_357_28 > 0 and var_357_23 < var_357_28 then
					arg_354_1.talkMaxDuration = var_357_28

					if var_357_28 + var_357_22 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_28 + var_357_22
					end
				end

				arg_354_1.text_.text = var_357_25
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_29 = math.max(var_357_23, arg_354_1.talkMaxDuration)

			if var_357_22 <= arg_354_1.time_ and arg_354_1.time_ < var_357_22 + var_357_29 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_22) / var_357_29

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_22 + var_357_29 and arg_354_1.time_ < var_357_22 + var_357_29 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play938032087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 938032087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play938032088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["108301"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps108301 == nil then
				arg_358_1.var_.actorSpriteComps108301 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps108301 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps108301 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps108301 = nil
			end

			local var_361_8 = arg_358_1.actors_["108301"].transform
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 then
				arg_358_1.var_.moveOldPos108301 = var_361_8.localPosition
				var_361_8.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("108301", 2)

				local var_361_10 = var_361_8.childCount

				for iter_361_4 = 0, var_361_10 - 1 do
					local var_361_11 = var_361_8:GetChild(iter_361_4)

					if var_361_11.name == "split_5" or not string.find(var_361_11.name, "split") then
						var_361_11.gameObject:SetActive(true)
					else
						var_361_11.gameObject:SetActive(false)
					end
				end
			end

			local var_361_12 = 0.001

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_12 then
				local var_361_13 = (arg_358_1.time_ - var_361_9) / var_361_12
				local var_361_14 = Vector3.New(-420, -360, -195)

				var_361_8.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos108301, var_361_14, var_361_13)
			end

			if arg_358_1.time_ >= var_361_9 + var_361_12 and arg_358_1.time_ < var_361_9 + var_361_12 + arg_361_0 then
				var_361_8.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_361_15 = 0
			local var_361_16 = 1.225

			if var_361_15 < arg_358_1.time_ and arg_358_1.time_ <= var_361_15 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_17 = arg_358_1:FormatText(StoryNameCfg[1332].name)

				arg_358_1.leftNameTxt_.text = var_361_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_18 = arg_358_1:GetWordFromCfg(938032087)
				local var_361_19 = arg_358_1:FormatText(var_361_18.content)

				arg_358_1.text_.text = var_361_19

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_20 = 49
				local var_361_21 = utf8.len(var_361_19)
				local var_361_22 = var_361_20 <= 0 and var_361_16 or var_361_16 * (var_361_21 / var_361_20)

				if var_361_22 > 0 and var_361_16 < var_361_22 then
					arg_358_1.talkMaxDuration = var_361_22

					if var_361_22 + var_361_15 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_22 + var_361_15
					end
				end

				arg_358_1.text_.text = var_361_19
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_23 = math.max(var_361_16, arg_358_1.talkMaxDuration)

			if var_361_15 <= arg_358_1.time_ and arg_358_1.time_ < var_361_15 + var_361_23 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_15) / var_361_23

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_15 + var_361_23 and arg_358_1.time_ < var_361_15 + var_361_23 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play938032088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 938032088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play938032089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["128404"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps128404 == nil then
				arg_362_1.var_.actorSpriteComps128404 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.2

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps128404 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps128404 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps128404 = nil
			end

			local var_365_8 = arg_362_1.actors_["108301"]
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps108301 == nil then
				arg_362_1.var_.actorSpriteComps108301 = var_365_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_10 = 0.2

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_10 and not isNil(var_365_8) then
				local var_365_11 = (arg_362_1.time_ - var_365_9) / var_365_10

				if arg_362_1.var_.actorSpriteComps108301 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_362_1.time_ >= var_365_9 + var_365_10 and arg_362_1.time_ < var_365_9 + var_365_10 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps108301 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_365_7 then
						if arg_362_1.isInRecall_ then
							iter_365_7.color = arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_365_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps108301 = nil
			end

			local var_365_16 = arg_362_1.actors_["128404"].transform
			local var_365_17 = 0

			if var_365_17 < arg_362_1.time_ and arg_362_1.time_ <= var_365_17 + arg_365_0 then
				arg_362_1.var_.moveOldPos128404 = var_365_16.localPosition
				var_365_16.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("128404", 4)

				local var_365_18 = var_365_16.childCount

				for iter_365_8 = 0, var_365_18 - 1 do
					local var_365_19 = var_365_16:GetChild(iter_365_8)

					if var_365_19.name == "split_5" or not string.find(var_365_19.name, "split") then
						var_365_19.gameObject:SetActive(true)
					else
						var_365_19.gameObject:SetActive(false)
					end
				end
			end

			local var_365_20 = 0.001

			if var_365_17 <= arg_362_1.time_ and arg_362_1.time_ < var_365_17 + var_365_20 then
				local var_365_21 = (arg_362_1.time_ - var_365_17) / var_365_20
				local var_365_22 = Vector3.New(390.2, -356, -362.3)

				var_365_16.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos128404, var_365_22, var_365_21)
			end

			if arg_362_1.time_ >= var_365_17 + var_365_20 and arg_362_1.time_ < var_365_17 + var_365_20 + arg_365_0 then
				var_365_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_365_23 = 0
			local var_365_24 = 1.15

			if var_365_23 < arg_362_1.time_ and arg_362_1.time_ <= var_365_23 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_25 = arg_362_1:FormatText(StoryNameCfg[6].name)

				arg_362_1.leftNameTxt_.text = var_365_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_26 = arg_362_1:GetWordFromCfg(938032088)
				local var_365_27 = arg_362_1:FormatText(var_365_26.content)

				arg_362_1.text_.text = var_365_27

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_28 = 46
				local var_365_29 = utf8.len(var_365_27)
				local var_365_30 = var_365_28 <= 0 and var_365_24 or var_365_24 * (var_365_29 / var_365_28)

				if var_365_30 > 0 and var_365_24 < var_365_30 then
					arg_362_1.talkMaxDuration = var_365_30

					if var_365_30 + var_365_23 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_30 + var_365_23
					end
				end

				arg_362_1.text_.text = var_365_27
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_31 = math.max(var_365_24, arg_362_1.talkMaxDuration)

			if var_365_23 <= arg_362_1.time_ and arg_362_1.time_ < var_365_23 + var_365_31 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_23) / var_365_31

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_23 + var_365_31 and arg_362_1.time_ < var_365_23 + var_365_31 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play938032089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 938032089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play938032090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["106603"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps106603 == nil then
				arg_366_1.var_.actorSpriteComps106603 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.2

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps106603 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								local var_369_4 = Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor1.r, var_369_3)
								local var_369_5 = Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor1.g, var_369_3)
								local var_369_6 = Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor1.b, var_369_3)

								iter_369_1.color = Color.New(var_369_4, var_369_5, var_369_6)
							else
								local var_369_7 = Mathf.Lerp(iter_369_1.color.r, 1, var_369_3)

								iter_369_1.color = Color.New(var_369_7, var_369_7, var_369_7)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps106603 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_369_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps106603 = nil
			end

			local var_369_8 = arg_366_1.actors_["128404"]
			local var_369_9 = 0

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps128404 == nil then
				arg_366_1.var_.actorSpriteComps128404 = var_369_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_10 = 0.2

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_10 and not isNil(var_369_8) then
				local var_369_11 = (arg_366_1.time_ - var_369_9) / var_369_10

				if arg_366_1.var_.actorSpriteComps128404 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								local var_369_12 = Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, var_369_11)
								local var_369_13 = Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, var_369_11)
								local var_369_14 = Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, var_369_11)

								iter_369_5.color = Color.New(var_369_12, var_369_13, var_369_14)
							else
								local var_369_15 = Mathf.Lerp(iter_369_5.color.r, 0.5, var_369_11)

								iter_369_5.color = Color.New(var_369_15, var_369_15, var_369_15)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_9 + var_369_10 and arg_366_1.time_ < var_369_9 + var_369_10 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps128404 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_369_7 then
						if arg_366_1.isInRecall_ then
							iter_369_7.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps128404 = nil
			end

			local var_369_16 = arg_366_1.actors_["106603"].transform
			local var_369_17 = 0

			if var_369_17 < arg_366_1.time_ and arg_366_1.time_ <= var_369_17 + arg_369_0 then
				arg_366_1.var_.moveOldPos106603 = var_369_16.localPosition
				var_369_16.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("106603", 2)

				local var_369_18 = var_369_16.childCount

				for iter_369_8 = 0, var_369_18 - 1 do
					local var_369_19 = var_369_16:GetChild(iter_369_8)

					if var_369_19.name == "" or not string.find(var_369_19.name, "split") then
						var_369_19.gameObject:SetActive(true)
					else
						var_369_19.gameObject:SetActive(false)
					end
				end
			end

			local var_369_20 = 0.001

			if var_369_17 <= arg_366_1.time_ and arg_366_1.time_ < var_369_17 + var_369_20 then
				local var_369_21 = (arg_366_1.time_ - var_369_17) / var_369_20
				local var_369_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_369_16.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos106603, var_369_22, var_369_21)
			end

			if arg_366_1.time_ >= var_369_17 + var_369_20 and arg_366_1.time_ < var_369_17 + var_369_20 + arg_369_0 then
				var_369_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_369_23 = arg_366_1.actors_["108301"].transform
			local var_369_24 = 0

			if var_369_24 < arg_366_1.time_ and arg_366_1.time_ <= var_369_24 + arg_369_0 then
				arg_366_1.var_.moveOldPos108301 = var_369_23.localPosition
				var_369_23.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("108301", 7)

				local var_369_25 = var_369_23.childCount

				for iter_369_9 = 0, var_369_25 - 1 do
					local var_369_26 = var_369_23:GetChild(iter_369_9)

					if var_369_26.name == "" or not string.find(var_369_26.name, "split") then
						var_369_26.gameObject:SetActive(true)
					else
						var_369_26.gameObject:SetActive(false)
					end
				end
			end

			local var_369_27 = 0.001

			if var_369_24 <= arg_366_1.time_ and arg_366_1.time_ < var_369_24 + var_369_27 then
				local var_369_28 = (arg_366_1.time_ - var_369_24) / var_369_27
				local var_369_29 = Vector3.New(0, -2000, 0)

				var_369_23.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos108301, var_369_29, var_369_28)
			end

			if arg_366_1.time_ >= var_369_24 + var_369_27 and arg_366_1.time_ < var_369_24 + var_369_27 + arg_369_0 then
				var_369_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_30 = 0
			local var_369_31 = 0.15

			if var_369_30 < arg_366_1.time_ and arg_366_1.time_ <= var_369_30 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_32 = arg_366_1:FormatText(StoryNameCfg[32].name)

				arg_366_1.leftNameTxt_.text = var_369_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_33 = arg_366_1:GetWordFromCfg(938032089)
				local var_369_34 = arg_366_1:FormatText(var_369_33.content)

				arg_366_1.text_.text = var_369_34

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_35 = 6
				local var_369_36 = utf8.len(var_369_34)
				local var_369_37 = var_369_35 <= 0 and var_369_31 or var_369_31 * (var_369_36 / var_369_35)

				if var_369_37 > 0 and var_369_31 < var_369_37 then
					arg_366_1.talkMaxDuration = var_369_37

					if var_369_37 + var_369_30 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_37 + var_369_30
					end
				end

				arg_366_1.text_.text = var_369_34
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_38 = math.max(var_369_31, arg_366_1.talkMaxDuration)

			if var_369_30 <= arg_366_1.time_ and arg_366_1.time_ < var_369_30 + var_369_38 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_30) / var_369_38

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_30 + var_369_38 and arg_366_1.time_ < var_369_30 + var_369_38 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
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

		arg_366_1:InitPlayNodeList()
	end,
	Play938032090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 938032090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play938032091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["128404"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps128404 == nil then
				arg_370_1.var_.actorSpriteComps128404 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps128404 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps128404 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps128404 = nil
			end

			local var_373_8 = arg_370_1.actors_["106603"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps106603 == nil then
				arg_370_1.var_.actorSpriteComps106603 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps106603 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps106603 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps106603 = nil
			end

			local var_373_16 = arg_370_1.actors_["128404"].transform
			local var_373_17 = 0

			if var_373_17 < arg_370_1.time_ and arg_370_1.time_ <= var_373_17 + arg_373_0 then
				arg_370_1.var_.moveOldPos128404 = var_373_16.localPosition
				var_373_16.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("128404", 4)

				local var_373_18 = var_373_16.childCount

				for iter_373_8 = 0, var_373_18 - 1 do
					local var_373_19 = var_373_16:GetChild(iter_373_8)

					if var_373_19.name == "split_1" then
						var_373_19:SetAsLastSibling()
						var_373_19.gameObject:SetActive(true)

						arg_370_1.var_.actorSpriteSplit128404 = var_373_19.gameObject:GetComponent(typeof(Image))

						arg_370_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_373_20 = 0.5

			if var_373_17 <= arg_370_1.time_ and arg_370_1.time_ < var_373_17 + var_373_20 then
				local var_373_21 = (arg_370_1.time_ - var_373_17) / var_373_20
				local var_373_22 = Vector3.New(390.2, -356, -362.3)

				var_373_16.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos128404, var_373_22, var_373_21)

				if arg_370_1.var_.actorSpriteSplit128404 ~= nil then
					arg_370_1.var_.actorSpriteSplit128404:SetAlpha(var_373_21)
				end
			end

			if arg_370_1.time_ >= var_373_17 + var_373_20 and arg_370_1.time_ < var_373_17 + var_373_20 + arg_373_0 then
				var_373_16.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_370_1.var_.actorSpriteSplit128404 ~= nil then
					arg_370_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_373_23 = 0
			local var_373_24 = 0.6

			if var_373_23 < arg_370_1.time_ and arg_370_1.time_ <= var_373_23 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_25 = arg_370_1:FormatText(StoryNameCfg[6].name)

				arg_370_1.leftNameTxt_.text = var_373_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_26 = arg_370_1:GetWordFromCfg(938032090)
				local var_373_27 = arg_370_1:FormatText(var_373_26.content)

				arg_370_1.text_.text = var_373_27

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_28 = 24
				local var_373_29 = utf8.len(var_373_27)
				local var_373_30 = var_373_28 <= 0 and var_373_24 or var_373_24 * (var_373_29 / var_373_28)

				if var_373_30 > 0 and var_373_24 < var_373_30 then
					arg_370_1.talkMaxDuration = var_373_30

					if var_373_30 + var_373_23 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_30 + var_373_23
					end
				end

				arg_370_1.text_.text = var_373_27
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_31 = math.max(var_373_24, arg_370_1.talkMaxDuration)

			if var_373_23 <= arg_370_1.time_ and arg_370_1.time_ < var_373_23 + var_373_31 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_23) / var_373_31

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_23 + var_373_31 and arg_370_1.time_ < var_373_23 + var_373_31 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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

		arg_370_1:InitPlayNodeList()
	end,
	Play938032091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 938032091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play938032092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["104902"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps104902 == nil then
				arg_374_1.var_.actorSpriteComps104902 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps104902 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								local var_377_4 = Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor1.r, var_377_3)
								local var_377_5 = Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor1.g, var_377_3)
								local var_377_6 = Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor1.b, var_377_3)

								iter_377_1.color = Color.New(var_377_4, var_377_5, var_377_6)
							else
								local var_377_7 = Mathf.Lerp(iter_377_1.color.r, 1, var_377_3)

								iter_377_1.color = Color.New(var_377_7, var_377_7, var_377_7)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps104902 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_377_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps104902 = nil
			end

			local var_377_8 = arg_374_1.actors_["128404"]
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps128404 == nil then
				arg_374_1.var_.actorSpriteComps128404 = var_377_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_10 = 0.2

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 and not isNil(var_377_8) then
				local var_377_11 = (arg_374_1.time_ - var_377_9) / var_377_10

				if arg_374_1.var_.actorSpriteComps128404 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								local var_377_12 = Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor2.r, var_377_11)
								local var_377_13 = Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor2.g, var_377_11)
								local var_377_14 = Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor2.b, var_377_11)

								iter_377_5.color = Color.New(var_377_12, var_377_13, var_377_14)
							else
								local var_377_15 = Mathf.Lerp(iter_377_5.color.r, 0.5, var_377_11)

								iter_377_5.color = Color.New(var_377_15, var_377_15, var_377_15)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps128404 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_377_7 then
						if arg_374_1.isInRecall_ then
							iter_377_7.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps128404 = nil
			end

			local var_377_16 = arg_374_1.actors_["104902"].transform
			local var_377_17 = 0

			if var_377_17 < arg_374_1.time_ and arg_374_1.time_ <= var_377_17 + arg_377_0 then
				arg_374_1.var_.moveOldPos104902 = var_377_16.localPosition
				var_377_16.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("104902", 2)

				local var_377_18 = var_377_16.childCount

				for iter_377_8 = 0, var_377_18 - 1 do
					local var_377_19 = var_377_16:GetChild(iter_377_8)

					if var_377_19.name == "split_2" or not string.find(var_377_19.name, "split") then
						var_377_19.gameObject:SetActive(true)
					else
						var_377_19.gameObject:SetActive(false)
					end
				end
			end

			local var_377_20 = 0.001

			if var_377_17 <= arg_374_1.time_ and arg_374_1.time_ < var_377_17 + var_377_20 then
				local var_377_21 = (arg_374_1.time_ - var_377_17) / var_377_20
				local var_377_22 = Vector3.New(-390, -335, -360)

				var_377_16.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos104902, var_377_22, var_377_21)
			end

			if arg_374_1.time_ >= var_377_17 + var_377_20 and arg_374_1.time_ < var_377_17 + var_377_20 + arg_377_0 then
				var_377_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_377_23 = arg_374_1.actors_["106603"].transform
			local var_377_24 = 0

			if var_377_24 < arg_374_1.time_ and arg_374_1.time_ <= var_377_24 + arg_377_0 then
				arg_374_1.var_.moveOldPos106603 = var_377_23.localPosition
				var_377_23.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("106603", 7)

				local var_377_25 = var_377_23.childCount

				for iter_377_9 = 0, var_377_25 - 1 do
					local var_377_26 = var_377_23:GetChild(iter_377_9)

					if var_377_26.name == "split_1" or not string.find(var_377_26.name, "split") then
						var_377_26.gameObject:SetActive(true)
					else
						var_377_26.gameObject:SetActive(false)
					end
				end
			end

			local var_377_27 = 0.001

			if var_377_24 <= arg_374_1.time_ and arg_374_1.time_ < var_377_24 + var_377_27 then
				local var_377_28 = (arg_374_1.time_ - var_377_24) / var_377_27
				local var_377_29 = Vector3.New(0, -2000, 0)

				var_377_23.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos106603, var_377_29, var_377_28)
			end

			if arg_374_1.time_ >= var_377_24 + var_377_27 and arg_374_1.time_ < var_377_24 + var_377_27 + arg_377_0 then
				var_377_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_30 = 0
			local var_377_31 = 0.5

			if var_377_30 < arg_374_1.time_ and arg_374_1.time_ <= var_377_30 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_32 = arg_374_1:FormatText(StoryNameCfg[562].name)

				arg_374_1.leftNameTxt_.text = var_377_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_33 = arg_374_1:GetWordFromCfg(938032091)
				local var_377_34 = arg_374_1:FormatText(var_377_33.content)

				arg_374_1.text_.text = var_377_34

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_35 = 20
				local var_377_36 = utf8.len(var_377_34)
				local var_377_37 = var_377_35 <= 0 and var_377_31 or var_377_31 * (var_377_36 / var_377_35)

				if var_377_37 > 0 and var_377_31 < var_377_37 then
					arg_374_1.talkMaxDuration = var_377_37

					if var_377_37 + var_377_30 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_37 + var_377_30
					end
				end

				arg_374_1.text_.text = var_377_34
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_38 = math.max(var_377_31, arg_374_1.talkMaxDuration)

			if var_377_30 <= arg_374_1.time_ and arg_374_1.time_ < var_377_30 + var_377_38 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_30) / var_377_38

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_30 + var_377_38 and arg_374_1.time_ < var_377_30 + var_377_38 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play938032092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 938032092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play938032093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["104902"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps104902 == nil then
				arg_378_1.var_.actorSpriteComps104902 = var_381_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_2 = 0.2

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.actorSpriteComps104902 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								local var_381_4 = Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor2.r, var_381_3)
								local var_381_5 = Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor2.g, var_381_3)
								local var_381_6 = Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor2.b, var_381_3)

								iter_381_1.color = Color.New(var_381_4, var_381_5, var_381_6)
							else
								local var_381_7 = Mathf.Lerp(iter_381_1.color.r, 0.5, var_381_3)

								iter_381_1.color = Color.New(var_381_7, var_381_7, var_381_7)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps104902 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_381_3 then
						if arg_378_1.isInRecall_ then
							iter_381_3.color = arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_381_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps104902 = nil
			end

			local var_381_8 = 0
			local var_381_9 = 0.375

			if var_381_8 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_10 = arg_378_1:FormatText(StoryNameCfg[7].name)

				arg_378_1.leftNameTxt_.text = var_381_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_11 = arg_378_1:GetWordFromCfg(938032092)
				local var_381_12 = arg_378_1:FormatText(var_381_11.content)

				arg_378_1.text_.text = var_381_12

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_13 = 15
				local var_381_14 = utf8.len(var_381_12)
				local var_381_15 = var_381_13 <= 0 and var_381_9 or var_381_9 * (var_381_14 / var_381_13)

				if var_381_15 > 0 and var_381_9 < var_381_15 then
					arg_378_1.talkMaxDuration = var_381_15

					if var_381_15 + var_381_8 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_15 + var_381_8
					end
				end

				arg_378_1.text_.text = var_381_12
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_16 = math.max(var_381_9, arg_378_1.talkMaxDuration)

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_16 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_8) / var_381_16

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_8 + var_381_16 and arg_378_1.time_ < var_381_8 + var_381_16 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play938032093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 938032093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play938032094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["108301"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps108301 == nil then
				arg_382_1.var_.actorSpriteComps108301 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps108301 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 1, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps108301 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps108301 = nil
			end

			local var_385_8 = arg_382_1.actors_["108301"].transform
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 then
				arg_382_1.var_.moveOldPos108301 = var_385_8.localPosition
				var_385_8.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("108301", 4)

				local var_385_10 = var_385_8.childCount

				for iter_385_4 = 0, var_385_10 - 1 do
					local var_385_11 = var_385_8:GetChild(iter_385_4)

					if var_385_11.name == "split_3" or not string.find(var_385_11.name, "split") then
						var_385_11.gameObject:SetActive(true)
					else
						var_385_11.gameObject:SetActive(false)
					end
				end
			end

			local var_385_12 = 0.001

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_12 then
				local var_385_13 = (arg_382_1.time_ - var_385_9) / var_385_12
				local var_385_14 = Vector3.New(460, -360, -195)

				var_385_8.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos108301, var_385_14, var_385_13)
			end

			if arg_382_1.time_ >= var_385_9 + var_385_12 and arg_382_1.time_ < var_385_9 + var_385_12 + arg_385_0 then
				var_385_8.localPosition = Vector3.New(460, -360, -195)
			end

			local var_385_15 = arg_382_1.actors_["128404"].transform
			local var_385_16 = 0

			if var_385_16 < arg_382_1.time_ and arg_382_1.time_ <= var_385_16 + arg_385_0 then
				arg_382_1.var_.moveOldPos128404 = var_385_15.localPosition
				var_385_15.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("128404", 7)

				local var_385_17 = var_385_15.childCount

				for iter_385_5 = 0, var_385_17 - 1 do
					local var_385_18 = var_385_15:GetChild(iter_385_5)

					if var_385_18.name == "" or not string.find(var_385_18.name, "split") then
						var_385_18.gameObject:SetActive(true)
					else
						var_385_18.gameObject:SetActive(false)
					end
				end
			end

			local var_385_19 = 0.001

			if var_385_16 <= arg_382_1.time_ and arg_382_1.time_ < var_385_16 + var_385_19 then
				local var_385_20 = (arg_382_1.time_ - var_385_16) / var_385_19
				local var_385_21 = Vector3.New(0, -2000, 0)

				var_385_15.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos128404, var_385_21, var_385_20)
			end

			if arg_382_1.time_ >= var_385_16 + var_385_19 and arg_382_1.time_ < var_385_16 + var_385_19 + arg_385_0 then
				var_385_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_385_22 = 0
			local var_385_23 = 0.35

			if var_385_22 < arg_382_1.time_ and arg_382_1.time_ <= var_385_22 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_24 = arg_382_1:FormatText(StoryNameCfg[1332].name)

				arg_382_1.leftNameTxt_.text = var_385_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_25 = arg_382_1:GetWordFromCfg(938032093)
				local var_385_26 = arg_382_1:FormatText(var_385_25.content)

				arg_382_1.text_.text = var_385_26

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_27 = 14
				local var_385_28 = utf8.len(var_385_26)
				local var_385_29 = var_385_27 <= 0 and var_385_23 or var_385_23 * (var_385_28 / var_385_27)

				if var_385_29 > 0 and var_385_23 < var_385_29 then
					arg_382_1.talkMaxDuration = var_385_29

					if var_385_29 + var_385_22 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_29 + var_385_22
					end
				end

				arg_382_1.text_.text = var_385_26
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_30 = math.max(var_385_23, arg_382_1.talkMaxDuration)

			if var_385_22 <= arg_382_1.time_ and arg_382_1.time_ < var_385_22 + var_385_30 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_22) / var_385_30

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_22 + var_385_30 and arg_382_1.time_ < var_385_22 + var_385_30 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play938032094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 938032094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play938032095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10144"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps10144 == nil then
				arg_386_1.var_.actorSpriteComps10144 = var_389_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_2 = 0.2

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.actorSpriteComps10144 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								local var_389_4 = Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor1.r, var_389_3)
								local var_389_5 = Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor1.g, var_389_3)
								local var_389_6 = Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor1.b, var_389_3)

								iter_389_1.color = Color.New(var_389_4, var_389_5, var_389_6)
							else
								local var_389_7 = Mathf.Lerp(iter_389_1.color.r, 1, var_389_3)

								iter_389_1.color = Color.New(var_389_7, var_389_7, var_389_7)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps10144 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_389_3 then
						if arg_386_1.isInRecall_ then
							iter_389_3.color = arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_389_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps10144 = nil
			end

			local var_389_8 = arg_386_1.actors_["108301"]
			local var_389_9 = 0

			if var_389_9 < arg_386_1.time_ and arg_386_1.time_ <= var_389_9 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps108301 == nil then
				arg_386_1.var_.actorSpriteComps108301 = var_389_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_10 = 0.2

			if var_389_9 <= arg_386_1.time_ and arg_386_1.time_ < var_389_9 + var_389_10 and not isNil(var_389_8) then
				local var_389_11 = (arg_386_1.time_ - var_389_9) / var_389_10

				if arg_386_1.var_.actorSpriteComps108301 then
					for iter_389_4, iter_389_5 in pairs(arg_386_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_389_5 then
							if arg_386_1.isInRecall_ then
								local var_389_12 = Mathf.Lerp(iter_389_5.color.r, arg_386_1.hightColor2.r, var_389_11)
								local var_389_13 = Mathf.Lerp(iter_389_5.color.g, arg_386_1.hightColor2.g, var_389_11)
								local var_389_14 = Mathf.Lerp(iter_389_5.color.b, arg_386_1.hightColor2.b, var_389_11)

								iter_389_5.color = Color.New(var_389_12, var_389_13, var_389_14)
							else
								local var_389_15 = Mathf.Lerp(iter_389_5.color.r, 0.5, var_389_11)

								iter_389_5.color = Color.New(var_389_15, var_389_15, var_389_15)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_9 + var_389_10 and arg_386_1.time_ < var_389_9 + var_389_10 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps108301 then
				for iter_389_6, iter_389_7 in pairs(arg_386_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_389_7 then
						if arg_386_1.isInRecall_ then
							iter_389_7.color = arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_389_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps108301 = nil
			end

			local var_389_16 = arg_386_1.actors_["10144"].transform
			local var_389_17 = 0

			if var_389_17 < arg_386_1.time_ and arg_386_1.time_ <= var_389_17 + arg_389_0 then
				arg_386_1.var_.moveOldPos10144 = var_389_16.localPosition
				var_389_16.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("10144", 4)

				local var_389_18 = var_389_16.childCount

				for iter_389_8 = 0, var_389_18 - 1 do
					local var_389_19 = var_389_16:GetChild(iter_389_8)

					if var_389_19.name == "split_6" or not string.find(var_389_19.name, "split") then
						var_389_19.gameObject:SetActive(true)
					else
						var_389_19.gameObject:SetActive(false)
					end
				end
			end

			local var_389_20 = 0.001

			if var_389_17 <= arg_386_1.time_ and arg_386_1.time_ < var_389_17 + var_389_20 then
				local var_389_21 = (arg_386_1.time_ - var_389_17) / var_389_20
				local var_389_22 = Vector3.New(435.8, -381.1, -285.9)

				var_389_16.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos10144, var_389_22, var_389_21)
			end

			if arg_386_1.time_ >= var_389_17 + var_389_20 and arg_386_1.time_ < var_389_17 + var_389_20 + arg_389_0 then
				var_389_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_389_23 = arg_386_1.actors_["108301"].transform
			local var_389_24 = 0

			if var_389_24 < arg_386_1.time_ and arg_386_1.time_ <= var_389_24 + arg_389_0 then
				arg_386_1.var_.moveOldPos108301 = var_389_23.localPosition
				var_389_23.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("108301", 7)

				local var_389_25 = var_389_23.childCount

				for iter_389_9 = 0, var_389_25 - 1 do
					local var_389_26 = var_389_23:GetChild(iter_389_9)

					if var_389_26.name == "" or not string.find(var_389_26.name, "split") then
						var_389_26.gameObject:SetActive(true)
					else
						var_389_26.gameObject:SetActive(false)
					end
				end
			end

			local var_389_27 = 0.001

			if var_389_24 <= arg_386_1.time_ and arg_386_1.time_ < var_389_24 + var_389_27 then
				local var_389_28 = (arg_386_1.time_ - var_389_24) / var_389_27
				local var_389_29 = Vector3.New(0, -2000, 0)

				var_389_23.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos108301, var_389_29, var_389_28)
			end

			if arg_386_1.time_ >= var_389_24 + var_389_27 and arg_386_1.time_ < var_389_24 + var_389_27 + arg_389_0 then
				var_389_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_389_30 = 0
			local var_389_31 = 0.6

			if var_389_30 < arg_386_1.time_ and arg_386_1.time_ <= var_389_30 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_32 = arg_386_1:FormatText(StoryNameCfg[1297].name)

				arg_386_1.leftNameTxt_.text = var_389_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_33 = arg_386_1:GetWordFromCfg(938032094)
				local var_389_34 = arg_386_1:FormatText(var_389_33.content)

				arg_386_1.text_.text = var_389_34

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_35 = 24
				local var_389_36 = utf8.len(var_389_34)
				local var_389_37 = var_389_35 <= 0 and var_389_31 or var_389_31 * (var_389_36 / var_389_35)

				if var_389_37 > 0 and var_389_31 < var_389_37 then
					arg_386_1.talkMaxDuration = var_389_37

					if var_389_37 + var_389_30 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_37 + var_389_30
					end
				end

				arg_386_1.text_.text = var_389_34
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_38 = math.max(var_389_31, arg_386_1.talkMaxDuration)

			if var_389_30 <= arg_386_1.time_ and arg_386_1.time_ < var_389_30 + var_389_38 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_30) / var_389_38

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_30 + var_389_38 and arg_386_1.time_ < var_389_30 + var_389_38 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play938032095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 938032095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play938032096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["104902"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps104902 == nil then
				arg_390_1.var_.actorSpriteComps104902 = var_393_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_2 = 0.2

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.actorSpriteComps104902 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								local var_393_4 = Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, var_393_3)
								local var_393_5 = Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, var_393_3)
								local var_393_6 = Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, var_393_3)

								iter_393_1.color = Color.New(var_393_4, var_393_5, var_393_6)
							else
								local var_393_7 = Mathf.Lerp(iter_393_1.color.r, 1, var_393_3)

								iter_393_1.color = Color.New(var_393_7, var_393_7, var_393_7)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps104902 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_393_3 then
						if arg_390_1.isInRecall_ then
							iter_393_3.color = arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_393_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps104902 = nil
			end

			local var_393_8 = arg_390_1.actors_["10144"]
			local var_393_9 = 0

			if var_393_9 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 and not isNil(var_393_8) and arg_390_1.var_.actorSpriteComps10144 == nil then
				arg_390_1.var_.actorSpriteComps10144 = var_393_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_10 = 0.2

			if var_393_9 <= arg_390_1.time_ and arg_390_1.time_ < var_393_9 + var_393_10 and not isNil(var_393_8) then
				local var_393_11 = (arg_390_1.time_ - var_393_9) / var_393_10

				if arg_390_1.var_.actorSpriteComps10144 then
					for iter_393_4, iter_393_5 in pairs(arg_390_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_393_5 then
							if arg_390_1.isInRecall_ then
								local var_393_12 = Mathf.Lerp(iter_393_5.color.r, arg_390_1.hightColor2.r, var_393_11)
								local var_393_13 = Mathf.Lerp(iter_393_5.color.g, arg_390_1.hightColor2.g, var_393_11)
								local var_393_14 = Mathf.Lerp(iter_393_5.color.b, arg_390_1.hightColor2.b, var_393_11)

								iter_393_5.color = Color.New(var_393_12, var_393_13, var_393_14)
							else
								local var_393_15 = Mathf.Lerp(iter_393_5.color.r, 0.5, var_393_11)

								iter_393_5.color = Color.New(var_393_15, var_393_15, var_393_15)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_9 + var_393_10 and arg_390_1.time_ < var_393_9 + var_393_10 + arg_393_0 and not isNil(var_393_8) and arg_390_1.var_.actorSpriteComps10144 then
				for iter_393_6, iter_393_7 in pairs(arg_390_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_393_7 then
						if arg_390_1.isInRecall_ then
							iter_393_7.color = arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_393_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps10144 = nil
			end

			local var_393_16 = arg_390_1.actors_["104902"].transform
			local var_393_17 = 0

			if var_393_17 < arg_390_1.time_ and arg_390_1.time_ <= var_393_17 + arg_393_0 then
				arg_390_1.var_.moveOldPos104902 = var_393_16.localPosition
				var_393_16.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("104902", 2)

				local var_393_18 = var_393_16.childCount

				for iter_393_8 = 0, var_393_18 - 1 do
					local var_393_19 = var_393_16:GetChild(iter_393_8)

					if var_393_19.name == "split_2" or not string.find(var_393_19.name, "split") then
						var_393_19.gameObject:SetActive(true)
					else
						var_393_19.gameObject:SetActive(false)
					end
				end
			end

			local var_393_20 = 0.001

			if var_393_17 <= arg_390_1.time_ and arg_390_1.time_ < var_393_17 + var_393_20 then
				local var_393_21 = (arg_390_1.time_ - var_393_17) / var_393_20
				local var_393_22 = Vector3.New(-390, -335, -360)

				var_393_16.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos104902, var_393_22, var_393_21)
			end

			if arg_390_1.time_ >= var_393_17 + var_393_20 and arg_390_1.time_ < var_393_17 + var_393_20 + arg_393_0 then
				var_393_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_393_23 = 0
			local var_393_24 = 0.8

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_25 = arg_390_1:FormatText(StoryNameCfg[562].name)

				arg_390_1.leftNameTxt_.text = var_393_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_26 = arg_390_1:GetWordFromCfg(938032095)
				local var_393_27 = arg_390_1:FormatText(var_393_26.content)

				arg_390_1.text_.text = var_393_27

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_28 = 32
				local var_393_29 = utf8.len(var_393_27)
				local var_393_30 = var_393_28 <= 0 and var_393_24 or var_393_24 * (var_393_29 / var_393_28)

				if var_393_30 > 0 and var_393_24 < var_393_30 then
					arg_390_1.talkMaxDuration = var_393_30

					if var_393_30 + var_393_23 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_30 + var_393_23
					end
				end

				arg_390_1.text_.text = var_393_27
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_31 = math.max(var_393_24, arg_390_1.talkMaxDuration)

			if var_393_23 <= arg_390_1.time_ and arg_390_1.time_ < var_393_23 + var_393_31 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_23) / var_393_31

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_23 + var_393_31 and arg_390_1.time_ < var_393_23 + var_393_31 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
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

		arg_390_1:InitPlayNodeList()
	end,
	Play938032096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 938032096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play938032097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["10144"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps10144 == nil then
				arg_394_1.var_.actorSpriteComps10144 = var_397_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_2 = 0.2

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.actorSpriteComps10144 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								local var_397_4 = Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, var_397_3)
								local var_397_5 = Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, var_397_3)
								local var_397_6 = Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, var_397_3)

								iter_397_1.color = Color.New(var_397_4, var_397_5, var_397_6)
							else
								local var_397_7 = Mathf.Lerp(iter_397_1.color.r, 1, var_397_3)

								iter_397_1.color = Color.New(var_397_7, var_397_7, var_397_7)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps10144 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_397_3 then
						if arg_394_1.isInRecall_ then
							iter_397_3.color = arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_397_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps10144 = nil
			end

			local var_397_8 = arg_394_1.actors_["104902"]
			local var_397_9 = 0

			if var_397_9 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps104902 == nil then
				arg_394_1.var_.actorSpriteComps104902 = var_397_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_10 = 0.2

			if var_397_9 <= arg_394_1.time_ and arg_394_1.time_ < var_397_9 + var_397_10 and not isNil(var_397_8) then
				local var_397_11 = (arg_394_1.time_ - var_397_9) / var_397_10

				if arg_394_1.var_.actorSpriteComps104902 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								local var_397_12 = Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, var_397_11)
								local var_397_13 = Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, var_397_11)
								local var_397_14 = Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, var_397_11)

								iter_397_5.color = Color.New(var_397_12, var_397_13, var_397_14)
							else
								local var_397_15 = Mathf.Lerp(iter_397_5.color.r, 0.5, var_397_11)

								iter_397_5.color = Color.New(var_397_15, var_397_15, var_397_15)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_9 + var_397_10 and arg_394_1.time_ < var_397_9 + var_397_10 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps104902 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_397_7 then
						if arg_394_1.isInRecall_ then
							iter_397_7.color = arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_397_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps104902 = nil
			end

			local var_397_16 = arg_394_1.actors_["10144"].transform
			local var_397_17 = 0

			if var_397_17 < arg_394_1.time_ and arg_394_1.time_ <= var_397_17 + arg_397_0 then
				arg_394_1.var_.moveOldPos10144 = var_397_16.localPosition
				var_397_16.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10144", 4)

				local var_397_18 = var_397_16.childCount

				for iter_397_8 = 0, var_397_18 - 1 do
					local var_397_19 = var_397_16:GetChild(iter_397_8)

					if var_397_19.name == "split_2" then
						var_397_19:SetAsLastSibling()
						var_397_19.gameObject:SetActive(true)

						arg_394_1.var_.actorSpriteSplit10144 = var_397_19.gameObject:GetComponent(typeof(Image))

						arg_394_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_397_20 = 0.5

			if var_397_17 <= arg_394_1.time_ and arg_394_1.time_ < var_397_17 + var_397_20 then
				local var_397_21 = (arg_394_1.time_ - var_397_17) / var_397_20
				local var_397_22 = Vector3.New(435.8, -381.1, -285.9)

				var_397_16.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10144, var_397_22, var_397_21)

				if arg_394_1.var_.actorSpriteSplit10144 ~= nil then
					arg_394_1.var_.actorSpriteSplit10144:SetAlpha(var_397_21)
				end
			end

			if arg_394_1.time_ >= var_397_17 + var_397_20 and arg_394_1.time_ < var_397_17 + var_397_20 + arg_397_0 then
				var_397_16.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_394_1.var_.actorSpriteSplit10144 ~= nil then
					arg_394_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_397_23 = 0
			local var_397_24 = 0.625

			if var_397_23 < arg_394_1.time_ and arg_394_1.time_ <= var_397_23 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_25 = arg_394_1:FormatText(StoryNameCfg[1297].name)

				arg_394_1.leftNameTxt_.text = var_397_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_26 = arg_394_1:GetWordFromCfg(938032096)
				local var_397_27 = arg_394_1:FormatText(var_397_26.content)

				arg_394_1.text_.text = var_397_27

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_28 = 25
				local var_397_29 = utf8.len(var_397_27)
				local var_397_30 = var_397_28 <= 0 and var_397_24 or var_397_24 * (var_397_29 / var_397_28)

				if var_397_30 > 0 and var_397_24 < var_397_30 then
					arg_394_1.talkMaxDuration = var_397_30

					if var_397_30 + var_397_23 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_30 + var_397_23
					end
				end

				arg_394_1.text_.text = var_397_27
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_31 = math.max(var_397_24, arg_394_1.talkMaxDuration)

			if var_397_23 <= arg_394_1.time_ and arg_394_1.time_ < var_397_23 + var_397_31 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_23) / var_397_31

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_23 + var_397_31 and arg_394_1.time_ < var_397_23 + var_397_31 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
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

		arg_394_1:InitPlayNodeList()
	end,
	Play938032097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 938032097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play938032098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.475

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[1297].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(938032097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 19
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play938032098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 938032098
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play938032099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10144"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos10144 = var_405_0.localPosition
				var_405_0.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10144", 4)

				local var_405_2 = var_405_0.childCount

				for iter_405_0 = 0, var_405_2 - 1 do
					local var_405_3 = var_405_0:GetChild(iter_405_0)

					if var_405_3.name == "split_1" then
						var_405_3:SetAsLastSibling()
						var_405_3.gameObject:SetActive(true)

						arg_402_1.var_.actorSpriteSplit10144 = var_405_3.gameObject:GetComponent(typeof(Image))

						arg_402_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_405_4 = 0.5

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_4 then
				local var_405_5 = (arg_402_1.time_ - var_405_1) / var_405_4
				local var_405_6 = Vector3.New(435.8, -381.1, -285.9)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10144, var_405_6, var_405_5)

				if arg_402_1.var_.actorSpriteSplit10144 ~= nil then
					arg_402_1.var_.actorSpriteSplit10144:SetAlpha(var_405_5)
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_4 and arg_402_1.time_ < var_405_1 + var_405_4 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_402_1.var_.actorSpriteSplit10144 ~= nil then
					arg_402_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_405_7 = 0
			local var_405_8 = 0.5

			if var_405_7 < arg_402_1.time_ and arg_402_1.time_ <= var_405_7 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_9 = arg_402_1:FormatText(StoryNameCfg[1297].name)

				arg_402_1.leftNameTxt_.text = var_405_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_10 = arg_402_1:GetWordFromCfg(938032098)
				local var_405_11 = arg_402_1:FormatText(var_405_10.content)

				arg_402_1.text_.text = var_405_11

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_12 = 20
				local var_405_13 = utf8.len(var_405_11)
				local var_405_14 = var_405_12 <= 0 and var_405_8 or var_405_8 * (var_405_13 / var_405_12)

				if var_405_14 > 0 and var_405_8 < var_405_14 then
					arg_402_1.talkMaxDuration = var_405_14

					if var_405_14 + var_405_7 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_14 + var_405_7
					end
				end

				arg_402_1.text_.text = var_405_11
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_15 = math.max(var_405_8, arg_402_1.talkMaxDuration)

			if var_405_7 <= arg_402_1.time_ and arg_402_1.time_ < var_405_7 + var_405_15 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_7) / var_405_15

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_7 + var_405_15 and arg_402_1.time_ < var_405_7 + var_405_15 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
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

		arg_402_1:InitPlayNodeList()
	end,
	Play938032099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 938032099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play938032100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["10144"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps10144 == nil then
				arg_406_1.var_.actorSpriteComps10144 = var_409_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_2 = 0.2

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.actorSpriteComps10144 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								local var_409_4 = Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor2.r, var_409_3)
								local var_409_5 = Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor2.g, var_409_3)
								local var_409_6 = Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor2.b, var_409_3)

								iter_409_1.color = Color.New(var_409_4, var_409_5, var_409_6)
							else
								local var_409_7 = Mathf.Lerp(iter_409_1.color.r, 0.5, var_409_3)

								iter_409_1.color = Color.New(var_409_7, var_409_7, var_409_7)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps10144 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_409_3 then
						if arg_406_1.isInRecall_ then
							iter_409_3.color = arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_409_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps10144 = nil
			end

			local var_409_8 = arg_406_1.actors_["10144"].transform
			local var_409_9 = 0

			if var_409_9 < arg_406_1.time_ and arg_406_1.time_ <= var_409_9 + arg_409_0 then
				arg_406_1.var_.moveOldPos10144 = var_409_8.localPosition
				var_409_8.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10144", 7)

				local var_409_10 = var_409_8.childCount

				for iter_409_4 = 0, var_409_10 - 1 do
					local var_409_11 = var_409_8:GetChild(iter_409_4)

					if var_409_11.name == "" or not string.find(var_409_11.name, "split") then
						var_409_11.gameObject:SetActive(true)
					else
						var_409_11.gameObject:SetActive(false)
					end
				end
			end

			local var_409_12 = 0.001

			if var_409_9 <= arg_406_1.time_ and arg_406_1.time_ < var_409_9 + var_409_12 then
				local var_409_13 = (arg_406_1.time_ - var_409_9) / var_409_12
				local var_409_14 = Vector3.New(0, -2000, 0)

				var_409_8.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10144, var_409_14, var_409_13)
			end

			if arg_406_1.time_ >= var_409_9 + var_409_12 and arg_406_1.time_ < var_409_9 + var_409_12 + arg_409_0 then
				var_409_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_409_15 = arg_406_1.actors_["104902"].transform
			local var_409_16 = 0

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.var_.moveOldPos104902 = var_409_15.localPosition
				var_409_15.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("104902", 7)

				local var_409_17 = var_409_15.childCount

				for iter_409_5 = 0, var_409_17 - 1 do
					local var_409_18 = var_409_15:GetChild(iter_409_5)

					if var_409_18.name == "" or not string.find(var_409_18.name, "split") then
						var_409_18.gameObject:SetActive(true)
					else
						var_409_18.gameObject:SetActive(false)
					end
				end
			end

			local var_409_19 = 0.001

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_19 then
				local var_409_20 = (arg_406_1.time_ - var_409_16) / var_409_19
				local var_409_21 = Vector3.New(0, -2000, -360)

				var_409_15.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos104902, var_409_21, var_409_20)
			end

			if arg_406_1.time_ >= var_409_16 + var_409_19 and arg_406_1.time_ < var_409_16 + var_409_19 + arg_409_0 then
				var_409_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_409_22 = 0
			local var_409_23 = 1.275

			if var_409_22 < arg_406_1.time_ and arg_406_1.time_ <= var_409_22 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_24 = arg_406_1:GetWordFromCfg(938032099)
				local var_409_25 = arg_406_1:FormatText(var_409_24.content)

				arg_406_1.text_.text = var_409_25

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_26 = 51
				local var_409_27 = utf8.len(var_409_25)
				local var_409_28 = var_409_26 <= 0 and var_409_23 or var_409_23 * (var_409_27 / var_409_26)

				if var_409_28 > 0 and var_409_23 < var_409_28 then
					arg_406_1.talkMaxDuration = var_409_28

					if var_409_28 + var_409_22 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_28 + var_409_22
					end
				end

				arg_406_1.text_.text = var_409_25
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_29 = math.max(var_409_23, arg_406_1.talkMaxDuration)

			if var_409_22 <= arg_406_1.time_ and arg_406_1.time_ < var_409_22 + var_409_29 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_22) / var_409_29

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_22 + var_409_29 and arg_406_1.time_ < var_409_22 + var_409_29 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
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

		arg_406_1:InitPlayNodeList()
	end,
	Play938032100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 938032100
		arg_410_1.duration_ = 5.52

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play938032101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = manager.ui.mainCamera.transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.shakeOldPos = var_413_0.localPosition
			end

			local var_413_2 = 0.366666666666667

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / 0.066
				local var_413_4, var_413_5 = math.modf(var_413_3)

				var_413_0.localPosition = Vector3.New(var_413_5 * 0.13, var_413_5 * 0.13, var_413_5 * 0.13) + arg_410_1.var_.shakeOldPos
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 then
				var_413_0.localPosition = arg_410_1.var_.shakeOldPos
			end

			local var_413_6 = 0

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.allBtn_.enabled = false
			end

			local var_413_7 = 1

			if arg_410_1.time_ >= var_413_6 + var_413_7 and arg_410_1.time_ < var_413_6 + var_413_7 + arg_413_0 then
				arg_410_1.allBtn_.enabled = true
			end

			if arg_410_1.frameCnt_ <= 1 then
				arg_410_1.dialog_:SetActive(false)
			end

			local var_413_8 = 0.525
			local var_413_9 = 0.475

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0

				arg_410_1.dialog_:SetActive(true)

				arg_410_1.dialogCg_.alpha = 0

				local var_413_10 = LeanTween.value(arg_410_1.dialog_, 0, 1, 0.3)

				var_413_10:setOnUpdate(LuaHelper.FloatAction(function(arg_414_0)
					arg_410_1.dialogCg_.alpha = arg_414_0
				end))
				var_413_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_410_1.dialog_)
					var_413_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_410_1.duration_ = arg_410_1.duration_ + 0.3

				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_11 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_12 = arg_410_1:GetWordFromCfg(938032100)
				local var_413_13 = arg_410_1:FormatText(var_413_12.content)

				arg_410_1.text_.text = var_413_13

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_14 = 19
				local var_413_15 = utf8.len(var_413_13)
				local var_413_16 = var_413_14 <= 0 and var_413_9 or var_413_9 * (var_413_15 / var_413_14)

				if var_413_16 > 0 and var_413_9 < var_413_16 then
					arg_410_1.talkMaxDuration = var_413_16
					var_413_8 = var_413_8 + 0.3

					if var_413_16 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_16 + var_413_8
					end
				end

				arg_410_1.text_.text = var_413_13
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_17 = var_413_8 + 0.3
			local var_413_18 = math.max(var_413_9, arg_410_1.talkMaxDuration)

			if var_413_17 <= arg_410_1.time_ and arg_410_1.time_ < var_413_17 + var_413_18 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_17) / var_413_18

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_17 + var_413_18 and arg_410_1.time_ < var_413_17 + var_413_18 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play938032101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 938032101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play938032102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10144"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10144 == nil then
				arg_416_1.var_.actorSpriteComps10144 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps10144 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor1.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor1.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor1.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 1, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10144 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_419_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10144 = nil
			end

			local var_419_8 = arg_416_1.actors_["10144"].transform
			local var_419_9 = 0

			if var_419_9 < arg_416_1.time_ and arg_416_1.time_ <= var_419_9 + arg_419_0 then
				arg_416_1.var_.moveOldPos10144 = var_419_8.localPosition
				var_419_8.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10144", 3)

				local var_419_10 = var_419_8.childCount

				for iter_419_4 = 0, var_419_10 - 1 do
					local var_419_11 = var_419_8:GetChild(iter_419_4)

					if var_419_11.name == "split_2" or not string.find(var_419_11.name, "split") then
						var_419_11.gameObject:SetActive(true)
					else
						var_419_11.gameObject:SetActive(false)
					end
				end
			end

			local var_419_12 = 0.001

			if var_419_9 <= arg_416_1.time_ and arg_416_1.time_ < var_419_9 + var_419_12 then
				local var_419_13 = (arg_416_1.time_ - var_419_9) / var_419_12
				local var_419_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_419_8.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10144, var_419_14, var_419_13)
			end

			if arg_416_1.time_ >= var_419_9 + var_419_12 and arg_416_1.time_ < var_419_9 + var_419_12 + arg_419_0 then
				var_419_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_419_15 = 0
			local var_419_16 = 0.425

			if var_419_15 < arg_416_1.time_ and arg_416_1.time_ <= var_419_15 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_17 = arg_416_1:FormatText(StoryNameCfg[1297].name)

				arg_416_1.leftNameTxt_.text = var_419_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_18 = arg_416_1:GetWordFromCfg(938032101)
				local var_419_19 = arg_416_1:FormatText(var_419_18.content)

				arg_416_1.text_.text = var_419_19

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_20 = 17
				local var_419_21 = utf8.len(var_419_19)
				local var_419_22 = var_419_20 <= 0 and var_419_16 or var_419_16 * (var_419_21 / var_419_20)

				if var_419_22 > 0 and var_419_16 < var_419_22 then
					arg_416_1.talkMaxDuration = var_419_22

					if var_419_22 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_22 + var_419_15
					end
				end

				arg_416_1.text_.text = var_419_19
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_23 = math.max(var_419_16, arg_416_1.talkMaxDuration)

			if var_419_15 <= arg_416_1.time_ and arg_416_1.time_ < var_419_15 + var_419_23 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_15) / var_419_23

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_15 + var_419_23 and arg_416_1.time_ < var_419_15 + var_419_23 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play938032102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 938032102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play938032103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10144"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10144 == nil then
				arg_420_1.var_.actorSpriteComps10144 = var_423_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.actorSpriteComps10144 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								local var_423_4 = Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor2.r, var_423_3)
								local var_423_5 = Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor2.g, var_423_3)
								local var_423_6 = Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor2.b, var_423_3)

								iter_423_1.color = Color.New(var_423_4, var_423_5, var_423_6)
							else
								local var_423_7 = Mathf.Lerp(iter_423_1.color.r, 0.5, var_423_3)

								iter_423_1.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10144 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_423_3 then
						if arg_420_1.isInRecall_ then
							iter_423_3.color = arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_423_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10144 = nil
			end

			local var_423_8 = 0
			local var_423_9 = 0.525

			if var_423_8 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_10 = arg_420_1:GetWordFromCfg(938032102)
				local var_423_11 = arg_420_1:FormatText(var_423_10.content)

				arg_420_1.text_.text = var_423_11

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_12 = 21
				local var_423_13 = utf8.len(var_423_11)
				local var_423_14 = var_423_12 <= 0 and var_423_9 or var_423_9 * (var_423_13 / var_423_12)

				if var_423_14 > 0 and var_423_9 < var_423_14 then
					arg_420_1.talkMaxDuration = var_423_14

					if var_423_14 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_11
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_15 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_15 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_15

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_15 and arg_420_1.time_ < var_423_8 + var_423_15 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play938032103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 938032103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play938032104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["106603"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.actorSpriteComps106603 == nil then
				arg_424_1.var_.actorSpriteComps106603 = var_427_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_2 = 0.2

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.actorSpriteComps106603 then
					for iter_427_0, iter_427_1 in pairs(arg_424_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_427_1 then
							if arg_424_1.isInRecall_ then
								local var_427_4 = Mathf.Lerp(iter_427_1.color.r, arg_424_1.hightColor1.r, var_427_3)
								local var_427_5 = Mathf.Lerp(iter_427_1.color.g, arg_424_1.hightColor1.g, var_427_3)
								local var_427_6 = Mathf.Lerp(iter_427_1.color.b, arg_424_1.hightColor1.b, var_427_3)

								iter_427_1.color = Color.New(var_427_4, var_427_5, var_427_6)
							else
								local var_427_7 = Mathf.Lerp(iter_427_1.color.r, 1, var_427_3)

								iter_427_1.color = Color.New(var_427_7, var_427_7, var_427_7)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.actorSpriteComps106603 then
				for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_427_3 then
						if arg_424_1.isInRecall_ then
							iter_427_3.color = arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_427_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_424_1.var_.actorSpriteComps106603 = nil
			end

			local var_427_8 = arg_424_1.actors_["106603"].transform
			local var_427_9 = 0

			if var_427_9 < arg_424_1.time_ and arg_424_1.time_ <= var_427_9 + arg_427_0 then
				arg_424_1.var_.moveOldPos106603 = var_427_8.localPosition
				var_427_8.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("106603", 2)

				local var_427_10 = var_427_8.childCount

				for iter_427_4 = 0, var_427_10 - 1 do
					local var_427_11 = var_427_8:GetChild(iter_427_4)

					if var_427_11.name == "" or not string.find(var_427_11.name, "split") then
						var_427_11.gameObject:SetActive(true)
					else
						var_427_11.gameObject:SetActive(false)
					end
				end
			end

			local var_427_12 = 0.001

			if var_427_9 <= arg_424_1.time_ and arg_424_1.time_ < var_427_9 + var_427_12 then
				local var_427_13 = (arg_424_1.time_ - var_427_9) / var_427_12
				local var_427_14 = Vector3.New(-510.9, -399.1, -303.3)

				var_427_8.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos106603, var_427_14, var_427_13)
			end

			if arg_424_1.time_ >= var_427_9 + var_427_12 and arg_424_1.time_ < var_427_9 + var_427_12 + arg_427_0 then
				var_427_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_427_15 = arg_424_1.actors_["10144"].transform
			local var_427_16 = 0

			if var_427_16 < arg_424_1.time_ and arg_424_1.time_ <= var_427_16 + arg_427_0 then
				arg_424_1.var_.moveOldPos10144 = var_427_15.localPosition
				var_427_15.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10144", 7)

				local var_427_17 = var_427_15.childCount

				for iter_427_5 = 0, var_427_17 - 1 do
					local var_427_18 = var_427_15:GetChild(iter_427_5)

					if var_427_18.name == "" or not string.find(var_427_18.name, "split") then
						var_427_18.gameObject:SetActive(true)
					else
						var_427_18.gameObject:SetActive(false)
					end
				end
			end

			local var_427_19 = 0.001

			if var_427_16 <= arg_424_1.time_ and arg_424_1.time_ < var_427_16 + var_427_19 then
				local var_427_20 = (arg_424_1.time_ - var_427_16) / var_427_19
				local var_427_21 = Vector3.New(0, -2000, 0)

				var_427_15.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10144, var_427_21, var_427_20)
			end

			if arg_424_1.time_ >= var_427_16 + var_427_19 and arg_424_1.time_ < var_427_16 + var_427_19 + arg_427_0 then
				var_427_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_427_22 = 0
			local var_427_23 = 0.5

			if var_427_22 < arg_424_1.time_ and arg_424_1.time_ <= var_427_22 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_24 = arg_424_1:FormatText(StoryNameCfg[32].name)

				arg_424_1.leftNameTxt_.text = var_427_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_25 = arg_424_1:GetWordFromCfg(938032103)
				local var_427_26 = arg_424_1:FormatText(var_427_25.content)

				arg_424_1.text_.text = var_427_26

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_27 = 20
				local var_427_28 = utf8.len(var_427_26)
				local var_427_29 = var_427_27 <= 0 and var_427_23 or var_427_23 * (var_427_28 / var_427_27)

				if var_427_29 > 0 and var_427_23 < var_427_29 then
					arg_424_1.talkMaxDuration = var_427_29

					if var_427_29 + var_427_22 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_29 + var_427_22
					end
				end

				arg_424_1.text_.text = var_427_26
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_30 = math.max(var_427_23, arg_424_1.talkMaxDuration)

			if var_427_22 <= arg_424_1.time_ and arg_424_1.time_ < var_427_22 + var_427_30 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_22) / var_427_30

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_22 + var_427_30 and arg_424_1.time_ < var_427_22 + var_427_30 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play938032104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 938032104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play938032105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["108301"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps108301 == nil then
				arg_428_1.var_.actorSpriteComps108301 = var_431_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.actorSpriteComps108301 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								local var_431_4 = Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor1.r, var_431_3)
								local var_431_5 = Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor1.g, var_431_3)
								local var_431_6 = Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor1.b, var_431_3)

								iter_431_1.color = Color.New(var_431_4, var_431_5, var_431_6)
							else
								local var_431_7 = Mathf.Lerp(iter_431_1.color.r, 1, var_431_3)

								iter_431_1.color = Color.New(var_431_7, var_431_7, var_431_7)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps108301 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_431_3 then
						if arg_428_1.isInRecall_ then
							iter_431_3.color = arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_431_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps108301 = nil
			end

			local var_431_8 = arg_428_1.actors_["106603"]
			local var_431_9 = 0

			if var_431_9 < arg_428_1.time_ and arg_428_1.time_ <= var_431_9 + arg_431_0 and not isNil(var_431_8) and arg_428_1.var_.actorSpriteComps106603 == nil then
				arg_428_1.var_.actorSpriteComps106603 = var_431_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_10 = 0.2

			if var_431_9 <= arg_428_1.time_ and arg_428_1.time_ < var_431_9 + var_431_10 and not isNil(var_431_8) then
				local var_431_11 = (arg_428_1.time_ - var_431_9) / var_431_10

				if arg_428_1.var_.actorSpriteComps106603 then
					for iter_431_4, iter_431_5 in pairs(arg_428_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_431_5 then
							if arg_428_1.isInRecall_ then
								local var_431_12 = Mathf.Lerp(iter_431_5.color.r, arg_428_1.hightColor2.r, var_431_11)
								local var_431_13 = Mathf.Lerp(iter_431_5.color.g, arg_428_1.hightColor2.g, var_431_11)
								local var_431_14 = Mathf.Lerp(iter_431_5.color.b, arg_428_1.hightColor2.b, var_431_11)

								iter_431_5.color = Color.New(var_431_12, var_431_13, var_431_14)
							else
								local var_431_15 = Mathf.Lerp(iter_431_5.color.r, 0.5, var_431_11)

								iter_431_5.color = Color.New(var_431_15, var_431_15, var_431_15)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_9 + var_431_10 and arg_428_1.time_ < var_431_9 + var_431_10 + arg_431_0 and not isNil(var_431_8) and arg_428_1.var_.actorSpriteComps106603 then
				for iter_431_6, iter_431_7 in pairs(arg_428_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_431_7 then
						if arg_428_1.isInRecall_ then
							iter_431_7.color = arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_431_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps106603 = nil
			end

			local var_431_16 = arg_428_1.actors_["108301"].transform
			local var_431_17 = 0

			if var_431_17 < arg_428_1.time_ and arg_428_1.time_ <= var_431_17 + arg_431_0 then
				arg_428_1.var_.moveOldPos108301 = var_431_16.localPosition
				var_431_16.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("108301", 4)

				local var_431_18 = var_431_16.childCount

				for iter_431_8 = 0, var_431_18 - 1 do
					local var_431_19 = var_431_16:GetChild(iter_431_8)

					if var_431_19.name == "split_5" or not string.find(var_431_19.name, "split") then
						var_431_19.gameObject:SetActive(true)
					else
						var_431_19.gameObject:SetActive(false)
					end
				end
			end

			local var_431_20 = 0.001

			if var_431_17 <= arg_428_1.time_ and arg_428_1.time_ < var_431_17 + var_431_20 then
				local var_431_21 = (arg_428_1.time_ - var_431_17) / var_431_20
				local var_431_22 = Vector3.New(460, -360, -195)

				var_431_16.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos108301, var_431_22, var_431_21)
			end

			if arg_428_1.time_ >= var_431_17 + var_431_20 and arg_428_1.time_ < var_431_17 + var_431_20 + arg_431_0 then
				var_431_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_431_23 = 0
			local var_431_24 = 0.375

			if var_431_23 < arg_428_1.time_ and arg_428_1.time_ <= var_431_23 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_25 = arg_428_1:FormatText(StoryNameCfg[1332].name)

				arg_428_1.leftNameTxt_.text = var_431_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_26 = arg_428_1:GetWordFromCfg(938032104)
				local var_431_27 = arg_428_1:FormatText(var_431_26.content)

				arg_428_1.text_.text = var_431_27

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_28 = 15
				local var_431_29 = utf8.len(var_431_27)
				local var_431_30 = var_431_28 <= 0 and var_431_24 or var_431_24 * (var_431_29 / var_431_28)

				if var_431_30 > 0 and var_431_24 < var_431_30 then
					arg_428_1.talkMaxDuration = var_431_30

					if var_431_30 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_30 + var_431_23
					end
				end

				arg_428_1.text_.text = var_431_27
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_31 = math.max(var_431_24, arg_428_1.talkMaxDuration)

			if var_431_23 <= arg_428_1.time_ and arg_428_1.time_ < var_431_23 + var_431_31 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_23) / var_431_31

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_23 + var_431_31 and arg_428_1.time_ < var_431_23 + var_431_31 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play938032105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 938032105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play938032106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["128404"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps128404 == nil then
				arg_432_1.var_.actorSpriteComps128404 = var_435_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_2 = 0.2

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.actorSpriteComps128404 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								local var_435_4 = Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor1.r, var_435_3)
								local var_435_5 = Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor1.g, var_435_3)
								local var_435_6 = Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor1.b, var_435_3)

								iter_435_1.color = Color.New(var_435_4, var_435_5, var_435_6)
							else
								local var_435_7 = Mathf.Lerp(iter_435_1.color.r, 1, var_435_3)

								iter_435_1.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps128404 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_435_3 then
						if arg_432_1.isInRecall_ then
							iter_435_3.color = arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_435_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps128404 = nil
			end

			local var_435_8 = arg_432_1.actors_["108301"]
			local var_435_9 = 0

			if var_435_9 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps108301 == nil then
				arg_432_1.var_.actorSpriteComps108301 = var_435_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_10 = 0.2

			if var_435_9 <= arg_432_1.time_ and arg_432_1.time_ < var_435_9 + var_435_10 and not isNil(var_435_8) then
				local var_435_11 = (arg_432_1.time_ - var_435_9) / var_435_10

				if arg_432_1.var_.actorSpriteComps108301 then
					for iter_435_4, iter_435_5 in pairs(arg_432_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_435_5 then
							if arg_432_1.isInRecall_ then
								local var_435_12 = Mathf.Lerp(iter_435_5.color.r, arg_432_1.hightColor2.r, var_435_11)
								local var_435_13 = Mathf.Lerp(iter_435_5.color.g, arg_432_1.hightColor2.g, var_435_11)
								local var_435_14 = Mathf.Lerp(iter_435_5.color.b, arg_432_1.hightColor2.b, var_435_11)

								iter_435_5.color = Color.New(var_435_12, var_435_13, var_435_14)
							else
								local var_435_15 = Mathf.Lerp(iter_435_5.color.r, 0.5, var_435_11)

								iter_435_5.color = Color.New(var_435_15, var_435_15, var_435_15)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_9 + var_435_10 and arg_432_1.time_ < var_435_9 + var_435_10 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps108301 then
				for iter_435_6, iter_435_7 in pairs(arg_432_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_435_7 then
						if arg_432_1.isInRecall_ then
							iter_435_7.color = arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_435_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps108301 = nil
			end

			local var_435_16 = arg_432_1.actors_["128404"].transform
			local var_435_17 = 0

			if var_435_17 < arg_432_1.time_ and arg_432_1.time_ <= var_435_17 + arg_435_0 then
				arg_432_1.var_.moveOldPos128404 = var_435_16.localPosition
				var_435_16.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("128404", 2)

				local var_435_18 = var_435_16.childCount

				for iter_435_8 = 0, var_435_18 - 1 do
					local var_435_19 = var_435_16:GetChild(iter_435_8)

					if var_435_19.name == "" or not string.find(var_435_19.name, "split") then
						var_435_19.gameObject:SetActive(true)
					else
						var_435_19.gameObject:SetActive(false)
					end
				end
			end

			local var_435_20 = 0.001

			if var_435_17 <= arg_432_1.time_ and arg_432_1.time_ < var_435_17 + var_435_20 then
				local var_435_21 = (arg_432_1.time_ - var_435_17) / var_435_20
				local var_435_22 = Vector3.New(-428.5, -356, -362.3)

				var_435_16.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos128404, var_435_22, var_435_21)
			end

			if arg_432_1.time_ >= var_435_17 + var_435_20 and arg_432_1.time_ < var_435_17 + var_435_20 + arg_435_0 then
				var_435_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_435_23 = arg_432_1.actors_["106603"].transform
			local var_435_24 = 0

			if var_435_24 < arg_432_1.time_ and arg_432_1.time_ <= var_435_24 + arg_435_0 then
				arg_432_1.var_.moveOldPos106603 = var_435_23.localPosition
				var_435_23.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("106603", 7)

				local var_435_25 = var_435_23.childCount

				for iter_435_9 = 0, var_435_25 - 1 do
					local var_435_26 = var_435_23:GetChild(iter_435_9)

					if var_435_26.name == "" or not string.find(var_435_26.name, "split") then
						var_435_26.gameObject:SetActive(true)
					else
						var_435_26.gameObject:SetActive(false)
					end
				end
			end

			local var_435_27 = 0.001

			if var_435_24 <= arg_432_1.time_ and arg_432_1.time_ < var_435_24 + var_435_27 then
				local var_435_28 = (arg_432_1.time_ - var_435_24) / var_435_27
				local var_435_29 = Vector3.New(0, -2000, 0)

				var_435_23.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos106603, var_435_29, var_435_28)
			end

			if arg_432_1.time_ >= var_435_24 + var_435_27 and arg_432_1.time_ < var_435_24 + var_435_27 + arg_435_0 then
				var_435_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_435_30 = 0
			local var_435_31 = 0.125

			if var_435_30 < arg_432_1.time_ and arg_432_1.time_ <= var_435_30 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_32 = arg_432_1:FormatText(StoryNameCfg[6].name)

				arg_432_1.leftNameTxt_.text = var_435_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_33 = arg_432_1:GetWordFromCfg(938032105)
				local var_435_34 = arg_432_1:FormatText(var_435_33.content)

				arg_432_1.text_.text = var_435_34

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_35 = 5
				local var_435_36 = utf8.len(var_435_34)
				local var_435_37 = var_435_35 <= 0 and var_435_31 or var_435_31 * (var_435_36 / var_435_35)

				if var_435_37 > 0 and var_435_31 < var_435_37 then
					arg_432_1.talkMaxDuration = var_435_37

					if var_435_37 + var_435_30 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_37 + var_435_30
					end
				end

				arg_432_1.text_.text = var_435_34
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_38 = math.max(var_435_31, arg_432_1.talkMaxDuration)

			if var_435_30 <= arg_432_1.time_ and arg_432_1.time_ < var_435_30 + var_435_38 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_30) / var_435_38

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_30 + var_435_38 and arg_432_1.time_ < var_435_30 + var_435_38 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play938032106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 938032106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play938032107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["108301"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps108301 == nil then
				arg_436_1.var_.actorSpriteComps108301 = var_439_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.actorSpriteComps108301 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								local var_439_4 = Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, var_439_3)
								local var_439_5 = Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, var_439_3)
								local var_439_6 = Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, var_439_3)

								iter_439_1.color = Color.New(var_439_4, var_439_5, var_439_6)
							else
								local var_439_7 = Mathf.Lerp(iter_439_1.color.r, 1, var_439_3)

								iter_439_1.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps108301 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_439_3 then
						if arg_436_1.isInRecall_ then
							iter_439_3.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_439_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps108301 = nil
			end

			local var_439_8 = arg_436_1.actors_["128404"]
			local var_439_9 = 0

			if var_439_9 < arg_436_1.time_ and arg_436_1.time_ <= var_439_9 + arg_439_0 and not isNil(var_439_8) and arg_436_1.var_.actorSpriteComps128404 == nil then
				arg_436_1.var_.actorSpriteComps128404 = var_439_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_10 = 0.2

			if var_439_9 <= arg_436_1.time_ and arg_436_1.time_ < var_439_9 + var_439_10 and not isNil(var_439_8) then
				local var_439_11 = (arg_436_1.time_ - var_439_9) / var_439_10

				if arg_436_1.var_.actorSpriteComps128404 then
					for iter_439_4, iter_439_5 in pairs(arg_436_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_439_5 then
							if arg_436_1.isInRecall_ then
								local var_439_12 = Mathf.Lerp(iter_439_5.color.r, arg_436_1.hightColor2.r, var_439_11)
								local var_439_13 = Mathf.Lerp(iter_439_5.color.g, arg_436_1.hightColor2.g, var_439_11)
								local var_439_14 = Mathf.Lerp(iter_439_5.color.b, arg_436_1.hightColor2.b, var_439_11)

								iter_439_5.color = Color.New(var_439_12, var_439_13, var_439_14)
							else
								local var_439_15 = Mathf.Lerp(iter_439_5.color.r, 0.5, var_439_11)

								iter_439_5.color = Color.New(var_439_15, var_439_15, var_439_15)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_9 + var_439_10 and arg_436_1.time_ < var_439_9 + var_439_10 + arg_439_0 and not isNil(var_439_8) and arg_436_1.var_.actorSpriteComps128404 then
				for iter_439_6, iter_439_7 in pairs(arg_436_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_439_7 then
						if arg_436_1.isInRecall_ then
							iter_439_7.color = arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_439_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps128404 = nil
			end

			local var_439_16 = arg_436_1.actors_["108301"].transform
			local var_439_17 = 0

			if var_439_17 < arg_436_1.time_ and arg_436_1.time_ <= var_439_17 + arg_439_0 then
				arg_436_1.var_.moveOldPos108301 = var_439_16.localPosition
				var_439_16.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("108301", 4)

				local var_439_18 = var_439_16.childCount

				for iter_439_8 = 0, var_439_18 - 1 do
					local var_439_19 = var_439_16:GetChild(iter_439_8)

					if var_439_19.name == "split_3" or not string.find(var_439_19.name, "split") then
						var_439_19.gameObject:SetActive(true)
					else
						var_439_19.gameObject:SetActive(false)
					end
				end
			end

			local var_439_20 = 0.001

			if var_439_17 <= arg_436_1.time_ and arg_436_1.time_ < var_439_17 + var_439_20 then
				local var_439_21 = (arg_436_1.time_ - var_439_17) / var_439_20
				local var_439_22 = Vector3.New(460, -360, -195)

				var_439_16.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos108301, var_439_22, var_439_21)
			end

			if arg_436_1.time_ >= var_439_17 + var_439_20 and arg_436_1.time_ < var_439_17 + var_439_20 + arg_439_0 then
				var_439_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_439_23 = 0
			local var_439_24 = 0.2

			if var_439_23 < arg_436_1.time_ and arg_436_1.time_ <= var_439_23 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_25 = arg_436_1:FormatText(StoryNameCfg[1332].name)

				arg_436_1.leftNameTxt_.text = var_439_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_26 = arg_436_1:GetWordFromCfg(938032106)
				local var_439_27 = arg_436_1:FormatText(var_439_26.content)

				arg_436_1.text_.text = var_439_27

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_28 = 8
				local var_439_29 = utf8.len(var_439_27)
				local var_439_30 = var_439_28 <= 0 and var_439_24 or var_439_24 * (var_439_29 / var_439_28)

				if var_439_30 > 0 and var_439_24 < var_439_30 then
					arg_436_1.talkMaxDuration = var_439_30

					if var_439_30 + var_439_23 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_30 + var_439_23
					end
				end

				arg_436_1.text_.text = var_439_27
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_31 = math.max(var_439_24, arg_436_1.talkMaxDuration)

			if var_439_23 <= arg_436_1.time_ and arg_436_1.time_ < var_439_23 + var_439_31 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_23) / var_439_31

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_23 + var_439_31 and arg_436_1.time_ < var_439_23 + var_439_31 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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

		arg_436_1:InitPlayNodeList()
	end,
	Play938032107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 938032107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play938032108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["128404"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps128404 == nil then
				arg_440_1.var_.actorSpriteComps128404 = var_443_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_2 = 0.2

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.actorSpriteComps128404 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								local var_443_4 = Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor1.r, var_443_3)
								local var_443_5 = Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor1.g, var_443_3)
								local var_443_6 = Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor1.b, var_443_3)

								iter_443_1.color = Color.New(var_443_4, var_443_5, var_443_6)
							else
								local var_443_7 = Mathf.Lerp(iter_443_1.color.r, 1, var_443_3)

								iter_443_1.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps128404 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_443_3 then
						if arg_440_1.isInRecall_ then
							iter_443_3.color = arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_443_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps128404 = nil
			end

			local var_443_8 = arg_440_1.actors_["108301"]
			local var_443_9 = 0

			if var_443_9 < arg_440_1.time_ and arg_440_1.time_ <= var_443_9 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps108301 == nil then
				arg_440_1.var_.actorSpriteComps108301 = var_443_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_10 = 0.2

			if var_443_9 <= arg_440_1.time_ and arg_440_1.time_ < var_443_9 + var_443_10 and not isNil(var_443_8) then
				local var_443_11 = (arg_440_1.time_ - var_443_9) / var_443_10

				if arg_440_1.var_.actorSpriteComps108301 then
					for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_443_5 then
							if arg_440_1.isInRecall_ then
								local var_443_12 = Mathf.Lerp(iter_443_5.color.r, arg_440_1.hightColor2.r, var_443_11)
								local var_443_13 = Mathf.Lerp(iter_443_5.color.g, arg_440_1.hightColor2.g, var_443_11)
								local var_443_14 = Mathf.Lerp(iter_443_5.color.b, arg_440_1.hightColor2.b, var_443_11)

								iter_443_5.color = Color.New(var_443_12, var_443_13, var_443_14)
							else
								local var_443_15 = Mathf.Lerp(iter_443_5.color.r, 0.5, var_443_11)

								iter_443_5.color = Color.New(var_443_15, var_443_15, var_443_15)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_9 + var_443_10 and arg_440_1.time_ < var_443_9 + var_443_10 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps108301 then
				for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_443_7 then
						if arg_440_1.isInRecall_ then
							iter_443_7.color = arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_443_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps108301 = nil
			end

			local var_443_16 = arg_440_1.actors_["128404"].transform
			local var_443_17 = 0

			if var_443_17 < arg_440_1.time_ and arg_440_1.time_ <= var_443_17 + arg_443_0 then
				arg_440_1.var_.moveOldPos128404 = var_443_16.localPosition
				var_443_16.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("128404", 2)

				local var_443_18 = var_443_16.childCount

				for iter_443_8 = 0, var_443_18 - 1 do
					local var_443_19 = var_443_16:GetChild(iter_443_8)

					if var_443_19.name == "split_4" or not string.find(var_443_19.name, "split") then
						var_443_19.gameObject:SetActive(true)
					else
						var_443_19.gameObject:SetActive(false)
					end
				end
			end

			local var_443_20 = 0.001

			if var_443_17 <= arg_440_1.time_ and arg_440_1.time_ < var_443_17 + var_443_20 then
				local var_443_21 = (arg_440_1.time_ - var_443_17) / var_443_20
				local var_443_22 = Vector3.New(-428.5, -356, -362.3)

				var_443_16.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos128404, var_443_22, var_443_21)
			end

			if arg_440_1.time_ >= var_443_17 + var_443_20 and arg_440_1.time_ < var_443_17 + var_443_20 + arg_443_0 then
				var_443_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_443_23 = 0
			local var_443_24 = 0.875

			if var_443_23 < arg_440_1.time_ and arg_440_1.time_ <= var_443_23 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_25 = arg_440_1:FormatText(StoryNameCfg[6].name)

				arg_440_1.leftNameTxt_.text = var_443_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_26 = arg_440_1:GetWordFromCfg(938032107)
				local var_443_27 = arg_440_1:FormatText(var_443_26.content)

				arg_440_1.text_.text = var_443_27

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_28 = 35
				local var_443_29 = utf8.len(var_443_27)
				local var_443_30 = var_443_28 <= 0 and var_443_24 or var_443_24 * (var_443_29 / var_443_28)

				if var_443_30 > 0 and var_443_24 < var_443_30 then
					arg_440_1.talkMaxDuration = var_443_30

					if var_443_30 + var_443_23 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_30 + var_443_23
					end
				end

				arg_440_1.text_.text = var_443_27
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_31 = math.max(var_443_24, arg_440_1.talkMaxDuration)

			if var_443_23 <= arg_440_1.time_ and arg_440_1.time_ < var_443_23 + var_443_31 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_23) / var_443_31

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_23 + var_443_31 and arg_440_1.time_ < var_443_23 + var_443_31 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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

		arg_440_1:InitPlayNodeList()
	end,
	Play938032108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 938032108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play938032109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["128404"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps128404 == nil then
				arg_444_1.var_.actorSpriteComps128404 = var_447_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.actorSpriteComps128404 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								local var_447_4 = Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor2.r, var_447_3)
								local var_447_5 = Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor2.g, var_447_3)
								local var_447_6 = Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor2.b, var_447_3)

								iter_447_1.color = Color.New(var_447_4, var_447_5, var_447_6)
							else
								local var_447_7 = Mathf.Lerp(iter_447_1.color.r, 0.5, var_447_3)

								iter_447_1.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps128404 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_447_3 then
						if arg_444_1.isInRecall_ then
							iter_447_3.color = arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_447_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps128404 = nil
			end

			local var_447_8 = 0
			local var_447_9 = 0.125

			if var_447_8 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_10 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_11 = arg_444_1:GetWordFromCfg(938032108)
				local var_447_12 = arg_444_1:FormatText(var_447_11.content)

				arg_444_1.text_.text = var_447_12

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_13 = 5
				local var_447_14 = utf8.len(var_447_12)
				local var_447_15 = var_447_13 <= 0 and var_447_9 or var_447_9 * (var_447_14 / var_447_13)

				if var_447_15 > 0 and var_447_9 < var_447_15 then
					arg_444_1.talkMaxDuration = var_447_15

					if var_447_15 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_15 + var_447_8
					end
				end

				arg_444_1.text_.text = var_447_12
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_16 = math.max(var_447_9, arg_444_1.talkMaxDuration)

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_16 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_8) / var_447_16

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_8 + var_447_16 and arg_444_1.time_ < var_447_8 + var_447_16 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play938032109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 938032109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play938032110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["106603"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps106603 == nil then
				arg_448_1.var_.actorSpriteComps106603 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps106603 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								local var_451_4 = Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, var_451_3)
								local var_451_5 = Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, var_451_3)
								local var_451_6 = Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, var_451_3)

								iter_451_1.color = Color.New(var_451_4, var_451_5, var_451_6)
							else
								local var_451_7 = Mathf.Lerp(iter_451_1.color.r, 1, var_451_3)

								iter_451_1.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps106603 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_451_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps106603 = nil
			end

			local var_451_8 = arg_448_1.actors_["106603"].transform
			local var_451_9 = 0

			if var_451_9 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 then
				arg_448_1.var_.moveOldPos106603 = var_451_8.localPosition
				var_451_8.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("106603", 4)

				local var_451_10 = var_451_8.childCount

				for iter_451_4 = 0, var_451_10 - 1 do
					local var_451_11 = var_451_8:GetChild(iter_451_4)

					if var_451_11.name == "" or not string.find(var_451_11.name, "split") then
						var_451_11.gameObject:SetActive(true)
					else
						var_451_11.gameObject:SetActive(false)
					end
				end
			end

			local var_451_12 = 0.001

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_12 then
				local var_451_13 = (arg_448_1.time_ - var_451_9) / var_451_12
				local var_451_14 = Vector3.New(453.9, -399.1, -303.3)

				var_451_8.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos106603, var_451_14, var_451_13)
			end

			if arg_448_1.time_ >= var_451_9 + var_451_12 and arg_448_1.time_ < var_451_9 + var_451_12 + arg_451_0 then
				var_451_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_451_15 = arg_448_1.actors_["108301"].transform
			local var_451_16 = 0

			if var_451_16 < arg_448_1.time_ and arg_448_1.time_ <= var_451_16 + arg_451_0 then
				arg_448_1.var_.moveOldPos108301 = var_451_15.localPosition
				var_451_15.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("108301", 7)

				local var_451_17 = var_451_15.childCount

				for iter_451_5 = 0, var_451_17 - 1 do
					local var_451_18 = var_451_15:GetChild(iter_451_5)

					if var_451_18.name == "" or not string.find(var_451_18.name, "split") then
						var_451_18.gameObject:SetActive(true)
					else
						var_451_18.gameObject:SetActive(false)
					end
				end
			end

			local var_451_19 = 0.001

			if var_451_16 <= arg_448_1.time_ and arg_448_1.time_ < var_451_16 + var_451_19 then
				local var_451_20 = (arg_448_1.time_ - var_451_16) / var_451_19
				local var_451_21 = Vector3.New(0, -2000, 0)

				var_451_15.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos108301, var_451_21, var_451_20)
			end

			if arg_448_1.time_ >= var_451_16 + var_451_19 and arg_448_1.time_ < var_451_16 + var_451_19 + arg_451_0 then
				var_451_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_22 = 0
			local var_451_23 = 0.675

			if var_451_22 < arg_448_1.time_ and arg_448_1.time_ <= var_451_22 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_24 = arg_448_1:FormatText(StoryNameCfg[32].name)

				arg_448_1.leftNameTxt_.text = var_451_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_25 = arg_448_1:GetWordFromCfg(938032109)
				local var_451_26 = arg_448_1:FormatText(var_451_25.content)

				arg_448_1.text_.text = var_451_26

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_27 = 27
				local var_451_28 = utf8.len(var_451_26)
				local var_451_29 = var_451_27 <= 0 and var_451_23 or var_451_23 * (var_451_28 / var_451_27)

				if var_451_29 > 0 and var_451_23 < var_451_29 then
					arg_448_1.talkMaxDuration = var_451_29

					if var_451_29 + var_451_22 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_29 + var_451_22
					end
				end

				arg_448_1.text_.text = var_451_26
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_30 = math.max(var_451_23, arg_448_1.talkMaxDuration)

			if var_451_22 <= arg_448_1.time_ and arg_448_1.time_ < var_451_22 + var_451_30 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_22) / var_451_30

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_22 + var_451_30 and arg_448_1.time_ < var_451_22 + var_451_30 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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

		arg_448_1:InitPlayNodeList()
	end,
	Play938032110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 938032110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play938032111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["128404"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps128404 == nil then
				arg_452_1.var_.actorSpriteComps128404 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps128404 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								local var_455_4 = Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor1.r, var_455_3)
								local var_455_5 = Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor1.g, var_455_3)
								local var_455_6 = Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor1.b, var_455_3)

								iter_455_1.color = Color.New(var_455_4, var_455_5, var_455_6)
							else
								local var_455_7 = Mathf.Lerp(iter_455_1.color.r, 1, var_455_3)

								iter_455_1.color = Color.New(var_455_7, var_455_7, var_455_7)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps128404 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_455_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps128404 = nil
			end

			local var_455_8 = arg_452_1.actors_["106603"]
			local var_455_9 = 0

			if var_455_9 < arg_452_1.time_ and arg_452_1.time_ <= var_455_9 + arg_455_0 and not isNil(var_455_8) and arg_452_1.var_.actorSpriteComps106603 == nil then
				arg_452_1.var_.actorSpriteComps106603 = var_455_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_10 = 0.2

			if var_455_9 <= arg_452_1.time_ and arg_452_1.time_ < var_455_9 + var_455_10 and not isNil(var_455_8) then
				local var_455_11 = (arg_452_1.time_ - var_455_9) / var_455_10

				if arg_452_1.var_.actorSpriteComps106603 then
					for iter_455_4, iter_455_5 in pairs(arg_452_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_455_5 then
							if arg_452_1.isInRecall_ then
								local var_455_12 = Mathf.Lerp(iter_455_5.color.r, arg_452_1.hightColor2.r, var_455_11)
								local var_455_13 = Mathf.Lerp(iter_455_5.color.g, arg_452_1.hightColor2.g, var_455_11)
								local var_455_14 = Mathf.Lerp(iter_455_5.color.b, arg_452_1.hightColor2.b, var_455_11)

								iter_455_5.color = Color.New(var_455_12, var_455_13, var_455_14)
							else
								local var_455_15 = Mathf.Lerp(iter_455_5.color.r, 0.5, var_455_11)

								iter_455_5.color = Color.New(var_455_15, var_455_15, var_455_15)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_9 + var_455_10 and arg_452_1.time_ < var_455_9 + var_455_10 + arg_455_0 and not isNil(var_455_8) and arg_452_1.var_.actorSpriteComps106603 then
				for iter_455_6, iter_455_7 in pairs(arg_452_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_455_7 then
						if arg_452_1.isInRecall_ then
							iter_455_7.color = arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_455_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps106603 = nil
			end

			local var_455_16 = arg_452_1.actors_["128404"].transform
			local var_455_17 = 0

			if var_455_17 < arg_452_1.time_ and arg_452_1.time_ <= var_455_17 + arg_455_0 then
				arg_452_1.var_.moveOldPos128404 = var_455_16.localPosition
				var_455_16.localScale = Vector3.New(1, 1, 1)

				arg_452_1:CheckSpriteTmpPos("128404", 2)

				local var_455_18 = var_455_16.childCount

				for iter_455_8 = 0, var_455_18 - 1 do
					local var_455_19 = var_455_16:GetChild(iter_455_8)

					if var_455_19.name == "" or not string.find(var_455_19.name, "split") then
						var_455_19.gameObject:SetActive(true)
					else
						var_455_19.gameObject:SetActive(false)
					end
				end
			end

			local var_455_20 = 0.001

			if var_455_17 <= arg_452_1.time_ and arg_452_1.time_ < var_455_17 + var_455_20 then
				local var_455_21 = (arg_452_1.time_ - var_455_17) / var_455_20
				local var_455_22 = Vector3.New(-428.5, -356, -362.3)

				var_455_16.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos128404, var_455_22, var_455_21)
			end

			if arg_452_1.time_ >= var_455_17 + var_455_20 and arg_452_1.time_ < var_455_17 + var_455_20 + arg_455_0 then
				var_455_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_455_23 = 0
			local var_455_24 = 1.25

			if var_455_23 < arg_452_1.time_ and arg_452_1.time_ <= var_455_23 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_25 = arg_452_1:FormatText(StoryNameCfg[6].name)

				arg_452_1.leftNameTxt_.text = var_455_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_26 = arg_452_1:GetWordFromCfg(938032110)
				local var_455_27 = arg_452_1:FormatText(var_455_26.content)

				arg_452_1.text_.text = var_455_27

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_28 = 50
				local var_455_29 = utf8.len(var_455_27)
				local var_455_30 = var_455_28 <= 0 and var_455_24 or var_455_24 * (var_455_29 / var_455_28)

				if var_455_30 > 0 and var_455_24 < var_455_30 then
					arg_452_1.talkMaxDuration = var_455_30

					if var_455_30 + var_455_23 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_30 + var_455_23
					end
				end

				arg_452_1.text_.text = var_455_27
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_31 = math.max(var_455_24, arg_452_1.talkMaxDuration)

			if var_455_23 <= arg_452_1.time_ and arg_452_1.time_ < var_455_23 + var_455_31 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_23) / var_455_31

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_23 + var_455_31 and arg_452_1.time_ < var_455_23 + var_455_31 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
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

		arg_452_1:InitPlayNodeList()
	end,
	Play938032111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 938032111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play938032112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["104902"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps104902 == nil then
				arg_456_1.var_.actorSpriteComps104902 = var_459_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.actorSpriteComps104902 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								local var_459_4 = Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, var_459_3)
								local var_459_5 = Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, var_459_3)
								local var_459_6 = Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, var_459_3)

								iter_459_1.color = Color.New(var_459_4, var_459_5, var_459_6)
							else
								local var_459_7 = Mathf.Lerp(iter_459_1.color.r, 1, var_459_3)

								iter_459_1.color = Color.New(var_459_7, var_459_7, var_459_7)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps104902 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_459_3 then
						if arg_456_1.isInRecall_ then
							iter_459_3.color = arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_459_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps104902 = nil
			end

			local var_459_8 = arg_456_1.actors_["128404"]
			local var_459_9 = 0

			if var_459_9 < arg_456_1.time_ and arg_456_1.time_ <= var_459_9 + arg_459_0 and not isNil(var_459_8) and arg_456_1.var_.actorSpriteComps128404 == nil then
				arg_456_1.var_.actorSpriteComps128404 = var_459_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_10 = 0.2

			if var_459_9 <= arg_456_1.time_ and arg_456_1.time_ < var_459_9 + var_459_10 and not isNil(var_459_8) then
				local var_459_11 = (arg_456_1.time_ - var_459_9) / var_459_10

				if arg_456_1.var_.actorSpriteComps128404 then
					for iter_459_4, iter_459_5 in pairs(arg_456_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_459_5 then
							if arg_456_1.isInRecall_ then
								local var_459_12 = Mathf.Lerp(iter_459_5.color.r, arg_456_1.hightColor2.r, var_459_11)
								local var_459_13 = Mathf.Lerp(iter_459_5.color.g, arg_456_1.hightColor2.g, var_459_11)
								local var_459_14 = Mathf.Lerp(iter_459_5.color.b, arg_456_1.hightColor2.b, var_459_11)

								iter_459_5.color = Color.New(var_459_12, var_459_13, var_459_14)
							else
								local var_459_15 = Mathf.Lerp(iter_459_5.color.r, 0.5, var_459_11)

								iter_459_5.color = Color.New(var_459_15, var_459_15, var_459_15)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= var_459_9 + var_459_10 and arg_456_1.time_ < var_459_9 + var_459_10 + arg_459_0 and not isNil(var_459_8) and arg_456_1.var_.actorSpriteComps128404 then
				for iter_459_6, iter_459_7 in pairs(arg_456_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_459_7 then
						if arg_456_1.isInRecall_ then
							iter_459_7.color = arg_456_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_459_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps128404 = nil
			end

			local var_459_16 = arg_456_1.actors_["104902"].transform
			local var_459_17 = 0

			if var_459_17 < arg_456_1.time_ and arg_456_1.time_ <= var_459_17 + arg_459_0 then
				arg_456_1.var_.moveOldPos104902 = var_459_16.localPosition
				var_459_16.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("104902", 2)

				local var_459_18 = var_459_16.childCount

				for iter_459_8 = 0, var_459_18 - 1 do
					local var_459_19 = var_459_16:GetChild(iter_459_8)

					if var_459_19.name == "split_2" or not string.find(var_459_19.name, "split") then
						var_459_19.gameObject:SetActive(true)
					else
						var_459_19.gameObject:SetActive(false)
					end
				end
			end

			local var_459_20 = 0.001

			if var_459_17 <= arg_456_1.time_ and arg_456_1.time_ < var_459_17 + var_459_20 then
				local var_459_21 = (arg_456_1.time_ - var_459_17) / var_459_20
				local var_459_22 = Vector3.New(-390, -335, -360)

				var_459_16.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos104902, var_459_22, var_459_21)
			end

			if arg_456_1.time_ >= var_459_17 + var_459_20 and arg_456_1.time_ < var_459_17 + var_459_20 + arg_459_0 then
				var_459_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_459_23 = arg_456_1.actors_["128404"].transform
			local var_459_24 = 0

			if var_459_24 < arg_456_1.time_ and arg_456_1.time_ <= var_459_24 + arg_459_0 then
				arg_456_1.var_.moveOldPos128404 = var_459_23.localPosition
				var_459_23.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("128404", 7)

				local var_459_25 = var_459_23.childCount

				for iter_459_9 = 0, var_459_25 - 1 do
					local var_459_26 = var_459_23:GetChild(iter_459_9)

					if var_459_26.name == "" or not string.find(var_459_26.name, "split") then
						var_459_26.gameObject:SetActive(true)
					else
						var_459_26.gameObject:SetActive(false)
					end
				end
			end

			local var_459_27 = 0.001

			if var_459_24 <= arg_456_1.time_ and arg_456_1.time_ < var_459_24 + var_459_27 then
				local var_459_28 = (arg_456_1.time_ - var_459_24) / var_459_27
				local var_459_29 = Vector3.New(0, -2000, 0)

				var_459_23.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos128404, var_459_29, var_459_28)
			end

			if arg_456_1.time_ >= var_459_24 + var_459_27 and arg_456_1.time_ < var_459_24 + var_459_27 + arg_459_0 then
				var_459_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_459_30 = 0
			local var_459_31 = 0.325

			if var_459_30 < arg_456_1.time_ and arg_456_1.time_ <= var_459_30 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_32 = arg_456_1:FormatText(StoryNameCfg[562].name)

				arg_456_1.leftNameTxt_.text = var_459_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_33 = arg_456_1:GetWordFromCfg(938032111)
				local var_459_34 = arg_456_1:FormatText(var_459_33.content)

				arg_456_1.text_.text = var_459_34

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_35 = 13
				local var_459_36 = utf8.len(var_459_34)
				local var_459_37 = var_459_35 <= 0 and var_459_31 or var_459_31 * (var_459_36 / var_459_35)

				if var_459_37 > 0 and var_459_31 < var_459_37 then
					arg_456_1.talkMaxDuration = var_459_37

					if var_459_37 + var_459_30 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_37 + var_459_30
					end
				end

				arg_456_1.text_.text = var_459_34
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_38 = math.max(var_459_31, arg_456_1.talkMaxDuration)

			if var_459_30 <= arg_456_1.time_ and arg_456_1.time_ < var_459_30 + var_459_38 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_30) / var_459_38

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_30 + var_459_38 and arg_456_1.time_ < var_459_30 + var_459_38 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
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

		arg_456_1:InitPlayNodeList()
	end,
	Play938032112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 938032112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play938032113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["106603"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps106603 == nil then
				arg_460_1.var_.actorSpriteComps106603 = var_463_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_2 = 0.2

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.actorSpriteComps106603 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								local var_463_4 = Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, var_463_3)
								local var_463_5 = Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, var_463_3)
								local var_463_6 = Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, var_463_3)

								iter_463_1.color = Color.New(var_463_4, var_463_5, var_463_6)
							else
								local var_463_7 = Mathf.Lerp(iter_463_1.color.r, 1, var_463_3)

								iter_463_1.color = Color.New(var_463_7, var_463_7, var_463_7)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps106603 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_463_3 then
						if arg_460_1.isInRecall_ then
							iter_463_3.color = arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_463_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps106603 = nil
			end

			local var_463_8 = arg_460_1.actors_["104902"]
			local var_463_9 = 0

			if var_463_9 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps104902 == nil then
				arg_460_1.var_.actorSpriteComps104902 = var_463_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_10 = 0.2

			if var_463_9 <= arg_460_1.time_ and arg_460_1.time_ < var_463_9 + var_463_10 and not isNil(var_463_8) then
				local var_463_11 = (arg_460_1.time_ - var_463_9) / var_463_10

				if arg_460_1.var_.actorSpriteComps104902 then
					for iter_463_4, iter_463_5 in pairs(arg_460_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_463_5 then
							if arg_460_1.isInRecall_ then
								local var_463_12 = Mathf.Lerp(iter_463_5.color.r, arg_460_1.hightColor2.r, var_463_11)
								local var_463_13 = Mathf.Lerp(iter_463_5.color.g, arg_460_1.hightColor2.g, var_463_11)
								local var_463_14 = Mathf.Lerp(iter_463_5.color.b, arg_460_1.hightColor2.b, var_463_11)

								iter_463_5.color = Color.New(var_463_12, var_463_13, var_463_14)
							else
								local var_463_15 = Mathf.Lerp(iter_463_5.color.r, 0.5, var_463_11)

								iter_463_5.color = Color.New(var_463_15, var_463_15, var_463_15)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_9 + var_463_10 and arg_460_1.time_ < var_463_9 + var_463_10 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps104902 then
				for iter_463_6, iter_463_7 in pairs(arg_460_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_463_7 then
						if arg_460_1.isInRecall_ then
							iter_463_7.color = arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_463_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps104902 = nil
			end

			local var_463_16 = arg_460_1.actors_["106603"].transform
			local var_463_17 = 0

			if var_463_17 < arg_460_1.time_ and arg_460_1.time_ <= var_463_17 + arg_463_0 then
				arg_460_1.var_.moveOldPos106603 = var_463_16.localPosition
				var_463_16.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("106603", 4)

				local var_463_18 = var_463_16.childCount

				for iter_463_8 = 0, var_463_18 - 1 do
					local var_463_19 = var_463_16:GetChild(iter_463_8)

					if var_463_19.name == "split_4" or not string.find(var_463_19.name, "split") then
						var_463_19.gameObject:SetActive(true)
					else
						var_463_19.gameObject:SetActive(false)
					end
				end
			end

			local var_463_20 = 0.001

			if var_463_17 <= arg_460_1.time_ and arg_460_1.time_ < var_463_17 + var_463_20 then
				local var_463_21 = (arg_460_1.time_ - var_463_17) / var_463_20
				local var_463_22 = Vector3.New(453.9, -399.1, -303.3)

				var_463_16.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106603, var_463_22, var_463_21)
			end

			if arg_460_1.time_ >= var_463_17 + var_463_20 and arg_460_1.time_ < var_463_17 + var_463_20 + arg_463_0 then
				var_463_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_463_23 = 0
			local var_463_24 = 0.5

			if var_463_23 < arg_460_1.time_ and arg_460_1.time_ <= var_463_23 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_25 = arg_460_1:FormatText(StoryNameCfg[32].name)

				arg_460_1.leftNameTxt_.text = var_463_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_26 = arg_460_1:GetWordFromCfg(938032112)
				local var_463_27 = arg_460_1:FormatText(var_463_26.content)

				arg_460_1.text_.text = var_463_27

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_28 = 20
				local var_463_29 = utf8.len(var_463_27)
				local var_463_30 = var_463_28 <= 0 and var_463_24 or var_463_24 * (var_463_29 / var_463_28)

				if var_463_30 > 0 and var_463_24 < var_463_30 then
					arg_460_1.talkMaxDuration = var_463_30

					if var_463_30 + var_463_23 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_30 + var_463_23
					end
				end

				arg_460_1.text_.text = var_463_27
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_31 = math.max(var_463_24, arg_460_1.talkMaxDuration)

			if var_463_23 <= arg_460_1.time_ and arg_460_1.time_ < var_463_23 + var_463_31 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_23) / var_463_31

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_23 + var_463_31 and arg_460_1.time_ < var_463_23 + var_463_31 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play938032113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 938032113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play938032114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["108301"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps108301 == nil then
				arg_464_1.var_.actorSpriteComps108301 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps108301 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								local var_467_4 = Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor1.r, var_467_3)
								local var_467_5 = Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor1.g, var_467_3)
								local var_467_6 = Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor1.b, var_467_3)

								iter_467_1.color = Color.New(var_467_4, var_467_5, var_467_6)
							else
								local var_467_7 = Mathf.Lerp(iter_467_1.color.r, 1, var_467_3)

								iter_467_1.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps108301 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_467_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps108301 = nil
			end

			local var_467_8 = arg_464_1.actors_["106603"]
			local var_467_9 = 0

			if var_467_9 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps106603 == nil then
				arg_464_1.var_.actorSpriteComps106603 = var_467_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_10 = 0.2

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_10 and not isNil(var_467_8) then
				local var_467_11 = (arg_464_1.time_ - var_467_9) / var_467_10

				if arg_464_1.var_.actorSpriteComps106603 then
					for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_467_5 then
							if arg_464_1.isInRecall_ then
								local var_467_12 = Mathf.Lerp(iter_467_5.color.r, arg_464_1.hightColor2.r, var_467_11)
								local var_467_13 = Mathf.Lerp(iter_467_5.color.g, arg_464_1.hightColor2.g, var_467_11)
								local var_467_14 = Mathf.Lerp(iter_467_5.color.b, arg_464_1.hightColor2.b, var_467_11)

								iter_467_5.color = Color.New(var_467_12, var_467_13, var_467_14)
							else
								local var_467_15 = Mathf.Lerp(iter_467_5.color.r, 0.5, var_467_11)

								iter_467_5.color = Color.New(var_467_15, var_467_15, var_467_15)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_9 + var_467_10 and arg_464_1.time_ < var_467_9 + var_467_10 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps106603 then
				for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_467_7 then
						if arg_464_1.isInRecall_ then
							iter_467_7.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps106603 = nil
			end

			local var_467_16 = arg_464_1.actors_["108301"].transform
			local var_467_17 = 0

			if var_467_17 < arg_464_1.time_ and arg_464_1.time_ <= var_467_17 + arg_467_0 then
				arg_464_1.var_.moveOldPos108301 = var_467_16.localPosition
				var_467_16.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("108301", 4)

				local var_467_18 = var_467_16.childCount

				for iter_467_8 = 0, var_467_18 - 1 do
					local var_467_19 = var_467_16:GetChild(iter_467_8)

					if var_467_19.name == "split_2" or not string.find(var_467_19.name, "split") then
						var_467_19.gameObject:SetActive(true)
					else
						var_467_19.gameObject:SetActive(false)
					end
				end
			end

			local var_467_20 = 0.001

			if var_467_17 <= arg_464_1.time_ and arg_464_1.time_ < var_467_17 + var_467_20 then
				local var_467_21 = (arg_464_1.time_ - var_467_17) / var_467_20
				local var_467_22 = Vector3.New(460, -360, -195)

				var_467_16.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos108301, var_467_22, var_467_21)
			end

			if arg_464_1.time_ >= var_467_17 + var_467_20 and arg_464_1.time_ < var_467_17 + var_467_20 + arg_467_0 then
				var_467_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_467_23 = arg_464_1.actors_["106603"].transform
			local var_467_24 = 0

			if var_467_24 < arg_464_1.time_ and arg_464_1.time_ <= var_467_24 + arg_467_0 then
				arg_464_1.var_.moveOldPos106603 = var_467_23.localPosition
				var_467_23.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("106603", 7)

				local var_467_25 = var_467_23.childCount

				for iter_467_9 = 0, var_467_25 - 1 do
					local var_467_26 = var_467_23:GetChild(iter_467_9)

					if var_467_26.name == "" or not string.find(var_467_26.name, "split") then
						var_467_26.gameObject:SetActive(true)
					else
						var_467_26.gameObject:SetActive(false)
					end
				end
			end

			local var_467_27 = 0.001

			if var_467_24 <= arg_464_1.time_ and arg_464_1.time_ < var_467_24 + var_467_27 then
				local var_467_28 = (arg_464_1.time_ - var_467_24) / var_467_27
				local var_467_29 = Vector3.New(0, -2000, 0)

				var_467_23.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos106603, var_467_29, var_467_28)
			end

			if arg_464_1.time_ >= var_467_24 + var_467_27 and arg_464_1.time_ < var_467_24 + var_467_27 + arg_467_0 then
				var_467_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_467_30 = 0
			local var_467_31 = 0.6

			if var_467_30 < arg_464_1.time_ and arg_464_1.time_ <= var_467_30 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_32 = arg_464_1:FormatText(StoryNameCfg[1332].name)

				arg_464_1.leftNameTxt_.text = var_467_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_33 = arg_464_1:GetWordFromCfg(938032113)
				local var_467_34 = arg_464_1:FormatText(var_467_33.content)

				arg_464_1.text_.text = var_467_34

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_35 = 24
				local var_467_36 = utf8.len(var_467_34)
				local var_467_37 = var_467_35 <= 0 and var_467_31 or var_467_31 * (var_467_36 / var_467_35)

				if var_467_37 > 0 and var_467_31 < var_467_37 then
					arg_464_1.talkMaxDuration = var_467_37

					if var_467_37 + var_467_30 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_37 + var_467_30
					end
				end

				arg_464_1.text_.text = var_467_34
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_38 = math.max(var_467_31, arg_464_1.talkMaxDuration)

			if var_467_30 <= arg_464_1.time_ and arg_464_1.time_ < var_467_30 + var_467_38 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_30) / var_467_38

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_30 + var_467_38 and arg_464_1.time_ < var_467_30 + var_467_38 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play938032114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 938032114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play938032115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["108301"].transform
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 then
				arg_468_1.var_.moveOldPos108301 = var_471_0.localPosition
				var_471_0.localScale = Vector3.New(1, 1, 1)

				arg_468_1:CheckSpriteTmpPos("108301", 4)

				local var_471_2 = var_471_0.childCount

				for iter_471_0 = 0, var_471_2 - 1 do
					local var_471_3 = var_471_0:GetChild(iter_471_0)

					if var_471_3.name == "" then
						var_471_3:SetAsLastSibling()
						var_471_3.gameObject:SetActive(true)

						arg_468_1.var_.actorSpriteSplit108301 = var_471_3.gameObject:GetComponent(typeof(Image))

						arg_468_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_471_4 = 0.5

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_4 then
				local var_471_5 = (arg_468_1.time_ - var_471_1) / var_471_4
				local var_471_6 = Vector3.New(460, -360, -195)

				var_471_0.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos108301, var_471_6, var_471_5)

				if arg_468_1.var_.actorSpriteSplit108301 ~= nil then
					arg_468_1.var_.actorSpriteSplit108301:SetAlpha(var_471_5)
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_4 and arg_468_1.time_ < var_471_1 + var_471_4 + arg_471_0 then
				var_471_0.localPosition = Vector3.New(460, -360, -195)

				if arg_468_1.var_.actorSpriteSplit108301 ~= nil then
					arg_468_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_471_7 = 0
			local var_471_8 = 0.85

			if var_471_7 < arg_468_1.time_ and arg_468_1.time_ <= var_471_7 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_9 = arg_468_1:FormatText(StoryNameCfg[1332].name)

				arg_468_1.leftNameTxt_.text = var_471_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_10 = arg_468_1:GetWordFromCfg(938032114)
				local var_471_11 = arg_468_1:FormatText(var_471_10.content)

				arg_468_1.text_.text = var_471_11

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_12 = 34
				local var_471_13 = utf8.len(var_471_11)
				local var_471_14 = var_471_12 <= 0 and var_471_8 or var_471_8 * (var_471_13 / var_471_12)

				if var_471_14 > 0 and var_471_8 < var_471_14 then
					arg_468_1.talkMaxDuration = var_471_14

					if var_471_14 + var_471_7 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_14 + var_471_7
					end
				end

				arg_468_1.text_.text = var_471_11
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_15 = math.max(var_471_8, arg_468_1.talkMaxDuration)

			if var_471_7 <= arg_468_1.time_ and arg_468_1.time_ < var_471_7 + var_471_15 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_7) / var_471_15

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_7 + var_471_15 and arg_468_1.time_ < var_471_7 + var_471_15 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
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

		arg_468_1:InitPlayNodeList()
	end,
	Play938032115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 938032115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play938032116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["10183"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps10183 == nil then
				arg_472_1.var_.actorSpriteComps10183 = var_475_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_2 = 0.2

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.actorSpriteComps10183 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								local var_475_4 = Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, var_475_3)
								local var_475_5 = Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, var_475_3)
								local var_475_6 = Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, var_475_3)

								iter_475_1.color = Color.New(var_475_4, var_475_5, var_475_6)
							else
								local var_475_7 = Mathf.Lerp(iter_475_1.color.r, 1, var_475_3)

								iter_475_1.color = Color.New(var_475_7, var_475_7, var_475_7)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps10183 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_475_3 then
						if arg_472_1.isInRecall_ then
							iter_475_3.color = arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_475_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_472_1.var_.actorSpriteComps10183 = nil
			end

			local var_475_8 = arg_472_1.actors_["108301"]
			local var_475_9 = 0

			if var_475_9 < arg_472_1.time_ and arg_472_1.time_ <= var_475_9 + arg_475_0 and not isNil(var_475_8) and arg_472_1.var_.actorSpriteComps108301 == nil then
				arg_472_1.var_.actorSpriteComps108301 = var_475_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_10 = 0.2

			if var_475_9 <= arg_472_1.time_ and arg_472_1.time_ < var_475_9 + var_475_10 and not isNil(var_475_8) then
				local var_475_11 = (arg_472_1.time_ - var_475_9) / var_475_10

				if arg_472_1.var_.actorSpriteComps108301 then
					for iter_475_4, iter_475_5 in pairs(arg_472_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_475_5 then
							if arg_472_1.isInRecall_ then
								local var_475_12 = Mathf.Lerp(iter_475_5.color.r, arg_472_1.hightColor2.r, var_475_11)
								local var_475_13 = Mathf.Lerp(iter_475_5.color.g, arg_472_1.hightColor2.g, var_475_11)
								local var_475_14 = Mathf.Lerp(iter_475_5.color.b, arg_472_1.hightColor2.b, var_475_11)

								iter_475_5.color = Color.New(var_475_12, var_475_13, var_475_14)
							else
								local var_475_15 = Mathf.Lerp(iter_475_5.color.r, 0.5, var_475_11)

								iter_475_5.color = Color.New(var_475_15, var_475_15, var_475_15)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= var_475_9 + var_475_10 and arg_472_1.time_ < var_475_9 + var_475_10 + arg_475_0 and not isNil(var_475_8) and arg_472_1.var_.actorSpriteComps108301 then
				for iter_475_6, iter_475_7 in pairs(arg_472_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_475_7 then
						if arg_472_1.isInRecall_ then
							iter_475_7.color = arg_472_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_475_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_472_1.var_.actorSpriteComps108301 = nil
			end

			local var_475_16 = arg_472_1.actors_["10183"].transform
			local var_475_17 = 0

			if var_475_17 < arg_472_1.time_ and arg_472_1.time_ <= var_475_17 + arg_475_0 then
				arg_472_1.var_.moveOldPos10183 = var_475_16.localPosition
				var_475_16.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("10183", 2)

				local var_475_18 = var_475_16.childCount

				for iter_475_8 = 0, var_475_18 - 1 do
					local var_475_19 = var_475_16:GetChild(iter_475_8)

					if var_475_19.name == "split_3" or not string.find(var_475_19.name, "split") then
						var_475_19.gameObject:SetActive(true)
					else
						var_475_19.gameObject:SetActive(false)
					end
				end
			end

			local var_475_20 = 0.001

			if var_475_17 <= arg_472_1.time_ and arg_472_1.time_ < var_475_17 + var_475_20 then
				local var_475_21 = (arg_472_1.time_ - var_475_17) / var_475_20
				local var_475_22 = Vector3.New(-300, -475, -325)

				var_475_16.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos10183, var_475_22, var_475_21)
			end

			if arg_472_1.time_ >= var_475_17 + var_475_20 and arg_472_1.time_ < var_475_17 + var_475_20 + arg_475_0 then
				var_475_16.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_475_23 = arg_472_1.actors_["104902"].transform
			local var_475_24 = 0

			if var_475_24 < arg_472_1.time_ and arg_472_1.time_ <= var_475_24 + arg_475_0 then
				arg_472_1.var_.moveOldPos104902 = var_475_23.localPosition
				var_475_23.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("104902", 7)

				local var_475_25 = var_475_23.childCount

				for iter_475_9 = 0, var_475_25 - 1 do
					local var_475_26 = var_475_23:GetChild(iter_475_9)

					if var_475_26.name == "" or not string.find(var_475_26.name, "split") then
						var_475_26.gameObject:SetActive(true)
					else
						var_475_26.gameObject:SetActive(false)
					end
				end
			end

			local var_475_27 = 0.001

			if var_475_24 <= arg_472_1.time_ and arg_472_1.time_ < var_475_24 + var_475_27 then
				local var_475_28 = (arg_472_1.time_ - var_475_24) / var_475_27
				local var_475_29 = Vector3.New(0, -2000, -360)

				var_475_23.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos104902, var_475_29, var_475_28)
			end

			if arg_472_1.time_ >= var_475_24 + var_475_27 and arg_472_1.time_ < var_475_24 + var_475_27 + arg_475_0 then
				var_475_23.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_475_30 = 0
			local var_475_31 = 0.65

			if var_475_30 < arg_472_1.time_ and arg_472_1.time_ <= var_475_30 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_32 = arg_472_1:FormatText(StoryNameCfg[36].name)

				arg_472_1.leftNameTxt_.text = var_475_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_33 = arg_472_1:GetWordFromCfg(938032115)
				local var_475_34 = arg_472_1:FormatText(var_475_33.content)

				arg_472_1.text_.text = var_475_34

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_35 = 26
				local var_475_36 = utf8.len(var_475_34)
				local var_475_37 = var_475_35 <= 0 and var_475_31 or var_475_31 * (var_475_36 / var_475_35)

				if var_475_37 > 0 and var_475_31 < var_475_37 then
					arg_472_1.talkMaxDuration = var_475_37

					if var_475_37 + var_475_30 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_37 + var_475_30
					end
				end

				arg_472_1.text_.text = var_475_34
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_38 = math.max(var_475_31, arg_472_1.talkMaxDuration)

			if var_475_30 <= arg_472_1.time_ and arg_472_1.time_ < var_475_30 + var_475_38 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_30) / var_475_38

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_30 + var_475_38 and arg_472_1.time_ < var_475_30 + var_475_38 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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

		arg_472_1:InitPlayNodeList()
	end,
	Play938032116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 938032116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play938032117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["10183"].transform
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.var_.moveOldPos10183 = var_479_0.localPosition
				var_479_0.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10183", 2)

				local var_479_2 = var_479_0.childCount

				for iter_479_0 = 0, var_479_2 - 1 do
					local var_479_3 = var_479_0:GetChild(iter_479_0)

					if var_479_3.name == "split_1" then
						var_479_3:SetAsLastSibling()
						var_479_3.gameObject:SetActive(true)

						arg_476_1.var_.actorSpriteSplit10183 = var_479_3.gameObject:GetComponent(typeof(Image))

						arg_476_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_479_4 = 0.5

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_4 then
				local var_479_5 = (arg_476_1.time_ - var_479_1) / var_479_4
				local var_479_6 = Vector3.New(-300, -475, -325)

				var_479_0.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10183, var_479_6, var_479_5)

				if arg_476_1.var_.actorSpriteSplit10183 ~= nil then
					arg_476_1.var_.actorSpriteSplit10183:SetAlpha(var_479_5)
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_4 and arg_476_1.time_ < var_479_1 + var_479_4 + arg_479_0 then
				var_479_0.localPosition = Vector3.New(-300, -475, -325)

				if arg_476_1.var_.actorSpriteSplit10183 ~= nil then
					arg_476_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_479_7 = 0
			local var_479_8 = 0.6

			if var_479_7 < arg_476_1.time_ and arg_476_1.time_ <= var_479_7 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_9 = arg_476_1:FormatText(StoryNameCfg[36].name)

				arg_476_1.leftNameTxt_.text = var_479_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_10 = arg_476_1:GetWordFromCfg(938032116)
				local var_479_11 = arg_476_1:FormatText(var_479_10.content)

				arg_476_1.text_.text = var_479_11

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_12 = 24
				local var_479_13 = utf8.len(var_479_11)
				local var_479_14 = var_479_12 <= 0 and var_479_8 or var_479_8 * (var_479_13 / var_479_12)

				if var_479_14 > 0 and var_479_8 < var_479_14 then
					arg_476_1.talkMaxDuration = var_479_14

					if var_479_14 + var_479_7 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_14 + var_479_7
					end
				end

				arg_476_1.text_.text = var_479_11
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_15 = math.max(var_479_8, arg_476_1.talkMaxDuration)

			if var_479_7 <= arg_476_1.time_ and arg_476_1.time_ < var_479_7 + var_479_15 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_7) / var_479_15

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_7 + var_479_15 and arg_476_1.time_ < var_479_7 + var_479_15 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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

		arg_476_1:InitPlayNodeList()
	end,
	Play938032117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 938032117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play938032118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10183"]
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10183 == nil then
				arg_480_1.var_.actorSpriteComps10183 = var_483_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_2 = 0.2

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 and not isNil(var_483_0) then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2

				if arg_480_1.var_.actorSpriteComps10183 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								local var_483_4 = Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor2.r, var_483_3)
								local var_483_5 = Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor2.g, var_483_3)
								local var_483_6 = Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor2.b, var_483_3)

								iter_483_1.color = Color.New(var_483_4, var_483_5, var_483_6)
							else
								local var_483_7 = Mathf.Lerp(iter_483_1.color.r, 0.5, var_483_3)

								iter_483_1.color = Color.New(var_483_7, var_483_7, var_483_7)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10183 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_483_3 then
						if arg_480_1.isInRecall_ then
							iter_483_3.color = arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_483_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps10183 = nil
			end

			local var_483_8 = arg_480_1.actors_["10183"].transform
			local var_483_9 = 0

			if var_483_9 < arg_480_1.time_ and arg_480_1.time_ <= var_483_9 + arg_483_0 then
				arg_480_1.var_.moveOldPos10183 = var_483_8.localPosition
				var_483_8.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10183", 7)

				local var_483_10 = var_483_8.childCount

				for iter_483_4 = 0, var_483_10 - 1 do
					local var_483_11 = var_483_8:GetChild(iter_483_4)

					if var_483_11.name == "" or not string.find(var_483_11.name, "split") then
						var_483_11.gameObject:SetActive(true)
					else
						var_483_11.gameObject:SetActive(false)
					end
				end
			end

			local var_483_12 = 0.001

			if var_483_9 <= arg_480_1.time_ and arg_480_1.time_ < var_483_9 + var_483_12 then
				local var_483_13 = (arg_480_1.time_ - var_483_9) / var_483_12
				local var_483_14 = Vector3.New(0, -2000, 0)

				var_483_8.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10183, var_483_14, var_483_13)
			end

			if arg_480_1.time_ >= var_483_9 + var_483_12 and arg_480_1.time_ < var_483_9 + var_483_12 + arg_483_0 then
				var_483_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_483_15 = arg_480_1.actors_["108301"].transform
			local var_483_16 = 0

			if var_483_16 < arg_480_1.time_ and arg_480_1.time_ <= var_483_16 + arg_483_0 then
				arg_480_1.var_.moveOldPos108301 = var_483_15.localPosition
				var_483_15.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("108301", 7)

				local var_483_17 = var_483_15.childCount

				for iter_483_5 = 0, var_483_17 - 1 do
					local var_483_18 = var_483_15:GetChild(iter_483_5)

					if var_483_18.name == "" or not string.find(var_483_18.name, "split") then
						var_483_18.gameObject:SetActive(true)
					else
						var_483_18.gameObject:SetActive(false)
					end
				end
			end

			local var_483_19 = 0.001

			if var_483_16 <= arg_480_1.time_ and arg_480_1.time_ < var_483_16 + var_483_19 then
				local var_483_20 = (arg_480_1.time_ - var_483_16) / var_483_19
				local var_483_21 = Vector3.New(0, -2000, 0)

				var_483_15.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos108301, var_483_21, var_483_20)
			end

			if arg_480_1.time_ >= var_483_16 + var_483_19 and arg_480_1.time_ < var_483_16 + var_483_19 + arg_483_0 then
				var_483_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_483_22 = 0
			local var_483_23 = 1.425

			if var_483_22 < arg_480_1.time_ and arg_480_1.time_ <= var_483_22 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_24 = arg_480_1:GetWordFromCfg(938032117)
				local var_483_25 = arg_480_1:FormatText(var_483_24.content)

				arg_480_1.text_.text = var_483_25

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_26 = 57
				local var_483_27 = utf8.len(var_483_25)
				local var_483_28 = var_483_26 <= 0 and var_483_23 or var_483_23 * (var_483_27 / var_483_26)

				if var_483_28 > 0 and var_483_23 < var_483_28 then
					arg_480_1.talkMaxDuration = var_483_28

					if var_483_28 + var_483_22 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_28 + var_483_22
					end
				end

				arg_480_1.text_.text = var_483_25
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_29 = math.max(var_483_23, arg_480_1.talkMaxDuration)

			if var_483_22 <= arg_480_1.time_ and arg_480_1.time_ < var_483_22 + var_483_29 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_22) / var_483_29

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_22 + var_483_29 and arg_480_1.time_ < var_483_22 + var_483_29 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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

		arg_480_1:InitPlayNodeList()
	end,
	Play938032118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 938032118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play938032119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 1.175

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_2 = arg_484_1:GetWordFromCfg(938032118)
				local var_487_3 = arg_484_1:FormatText(var_487_2.content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 47
				local var_487_5 = utf8.len(var_487_3)
				local var_487_6 = var_487_4 <= 0 and var_487_1 or var_487_1 * (var_487_5 / var_487_4)

				if var_487_6 > 0 and var_487_1 < var_487_6 then
					arg_484_1.talkMaxDuration = var_487_6

					if var_487_6 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_6 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_7 and arg_484_1.time_ < var_487_0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play938032119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 938032119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play938032120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["10183"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.actorSpriteComps10183 == nil then
				arg_488_1.var_.actorSpriteComps10183 = var_491_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_2 = 0.2

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.actorSpriteComps10183 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								local var_491_4 = Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor1.r, var_491_3)
								local var_491_5 = Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor1.g, var_491_3)
								local var_491_6 = Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor1.b, var_491_3)

								iter_491_1.color = Color.New(var_491_4, var_491_5, var_491_6)
							else
								local var_491_7 = Mathf.Lerp(iter_491_1.color.r, 1, var_491_3)

								iter_491_1.color = Color.New(var_491_7, var_491_7, var_491_7)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.actorSpriteComps10183 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_491_3 then
						if arg_488_1.isInRecall_ then
							iter_491_3.color = arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_491_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_488_1.var_.actorSpriteComps10183 = nil
			end

			local var_491_8 = arg_488_1.actors_["10183"].transform
			local var_491_9 = 0

			if var_491_9 < arg_488_1.time_ and arg_488_1.time_ <= var_491_9 + arg_491_0 then
				arg_488_1.var_.moveOldPos10183 = var_491_8.localPosition
				var_491_8.localScale = Vector3.New(1, 1, 1)

				arg_488_1:CheckSpriteTmpPos("10183", 3)

				local var_491_10 = var_491_8.childCount

				for iter_491_4 = 0, var_491_10 - 1 do
					local var_491_11 = var_491_8:GetChild(iter_491_4)

					if var_491_11.name == "split_5" or not string.find(var_491_11.name, "split") then
						var_491_11.gameObject:SetActive(true)
					else
						var_491_11.gameObject:SetActive(false)
					end
				end
			end

			local var_491_12 = 0.001

			if var_491_9 <= arg_488_1.time_ and arg_488_1.time_ < var_491_9 + var_491_12 then
				local var_491_13 = (arg_488_1.time_ - var_491_9) / var_491_12
				local var_491_14 = Vector3.New(0, -475, -325)

				var_491_8.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos10183, var_491_14, var_491_13)
			end

			if arg_488_1.time_ >= var_491_9 + var_491_12 and arg_488_1.time_ < var_491_9 + var_491_12 + arg_491_0 then
				var_491_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_491_15 = 0
			local var_491_16 = 1.05

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_17 = arg_488_1:FormatText(StoryNameCfg[1562].name)

				arg_488_1.leftNameTxt_.text = var_491_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_18 = arg_488_1:GetWordFromCfg(938032119)
				local var_491_19 = arg_488_1:FormatText(var_491_18.content)

				arg_488_1.text_.text = var_491_19

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_20 = 42
				local var_491_21 = utf8.len(var_491_19)
				local var_491_22 = var_491_20 <= 0 and var_491_16 or var_491_16 * (var_491_21 / var_491_20)

				if var_491_22 > 0 and var_491_16 < var_491_22 then
					arg_488_1.talkMaxDuration = var_491_22

					if var_491_22 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_22 + var_491_15
					end
				end

				arg_488_1.text_.text = var_491_19
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_23 = math.max(var_491_16, arg_488_1.talkMaxDuration)

			if var_491_15 <= arg_488_1.time_ and arg_488_1.time_ < var_491_15 + var_491_23 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_15) / var_491_23

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_15 + var_491_23 and arg_488_1.time_ < var_491_15 + var_491_23 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
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

		arg_488_1:InitPlayNodeList()
	end,
	Play938032120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 938032120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play938032121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["10183"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps10183 == nil then
				arg_492_1.var_.actorSpriteComps10183 = var_495_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_2 = 0.2

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.actorSpriteComps10183 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								local var_495_4 = Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor2.r, var_495_3)
								local var_495_5 = Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor2.g, var_495_3)
								local var_495_6 = Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor2.b, var_495_3)

								iter_495_1.color = Color.New(var_495_4, var_495_5, var_495_6)
							else
								local var_495_7 = Mathf.Lerp(iter_495_1.color.r, 0.5, var_495_3)

								iter_495_1.color = Color.New(var_495_7, var_495_7, var_495_7)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps10183 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_495_3 then
						if arg_492_1.isInRecall_ then
							iter_495_3.color = arg_492_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_495_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_492_1.var_.actorSpriteComps10183 = nil
			end

			local var_495_8 = 0
			local var_495_9 = 0.3

			if var_495_8 < arg_492_1.time_ and arg_492_1.time_ <= var_495_8 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_10 = arg_492_1:FormatText(StoryNameCfg[7].name)

				arg_492_1.leftNameTxt_.text = var_495_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_11 = arg_492_1:GetWordFromCfg(938032120)
				local var_495_12 = arg_492_1:FormatText(var_495_11.content)

				arg_492_1.text_.text = var_495_12

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_13 = 12
				local var_495_14 = utf8.len(var_495_12)
				local var_495_15 = var_495_13 <= 0 and var_495_9 or var_495_9 * (var_495_14 / var_495_13)

				if var_495_15 > 0 and var_495_9 < var_495_15 then
					arg_492_1.talkMaxDuration = var_495_15

					if var_495_15 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_15 + var_495_8
					end
				end

				arg_492_1.text_.text = var_495_12
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_16 = math.max(var_495_9, arg_492_1.talkMaxDuration)

			if var_495_8 <= arg_492_1.time_ and arg_492_1.time_ < var_495_8 + var_495_16 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_8) / var_495_16

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_8 + var_495_16 and arg_492_1.time_ < var_495_8 + var_495_16 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play938032121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 938032121
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play938032122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["10183"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos10183 = var_499_0.localPosition
				var_499_0.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10183", 7)

				local var_499_2 = var_499_0.childCount

				for iter_499_0 = 0, var_499_2 - 1 do
					local var_499_3 = var_499_0:GetChild(iter_499_0)

					if var_499_3.name == "" or not string.find(var_499_3.name, "split") then
						var_499_3.gameObject:SetActive(true)
					else
						var_499_3.gameObject:SetActive(false)
					end
				end
			end

			local var_499_4 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_4 then
				local var_499_5 = (arg_496_1.time_ - var_499_1) / var_499_4
				local var_499_6 = Vector3.New(0, -2000, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10183, var_499_6, var_499_5)
			end

			if arg_496_1.time_ >= var_499_1 + var_499_4 and arg_496_1.time_ < var_499_1 + var_499_4 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_499_7 = 0
			local var_499_8 = 1.3

			if var_499_7 < arg_496_1.time_ and arg_496_1.time_ <= var_499_7 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_9 = arg_496_1:GetWordFromCfg(938032121)
				local var_499_10 = arg_496_1:FormatText(var_499_9.content)

				arg_496_1.text_.text = var_499_10

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_11 = 52
				local var_499_12 = utf8.len(var_499_10)
				local var_499_13 = var_499_11 <= 0 and var_499_8 or var_499_8 * (var_499_12 / var_499_11)

				if var_499_13 > 0 and var_499_8 < var_499_13 then
					arg_496_1.talkMaxDuration = var_499_13

					if var_499_13 + var_499_7 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_13 + var_499_7
					end
				end

				arg_496_1.text_.text = var_499_10
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_14 = math.max(var_499_8, arg_496_1.talkMaxDuration)

			if var_499_7 <= arg_496_1.time_ and arg_496_1.time_ < var_499_7 + var_499_14 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_7) / var_499_14

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_7 + var_499_14 and arg_496_1.time_ < var_499_7 + var_499_14 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
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

		arg_496_1:InitPlayNodeList()
	end,
	Play938032122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 938032122
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play938032123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["10183"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps10183 == nil then
				arg_500_1.var_.actorSpriteComps10183 = var_503_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.actorSpriteComps10183 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								local var_503_4 = Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, var_503_3)
								local var_503_5 = Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, var_503_3)
								local var_503_6 = Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, var_503_3)

								iter_503_1.color = Color.New(var_503_4, var_503_5, var_503_6)
							else
								local var_503_7 = Mathf.Lerp(iter_503_1.color.r, 1, var_503_3)

								iter_503_1.color = Color.New(var_503_7, var_503_7, var_503_7)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps10183 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_503_3 then
						if arg_500_1.isInRecall_ then
							iter_503_3.color = arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_503_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_500_1.var_.actorSpriteComps10183 = nil
			end

			local var_503_8 = arg_500_1.actors_["10183"].transform
			local var_503_9 = 0

			if var_503_9 < arg_500_1.time_ and arg_500_1.time_ <= var_503_9 + arg_503_0 then
				arg_500_1.var_.moveOldPos10183 = var_503_8.localPosition
				var_503_8.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10183", 3)

				local var_503_10 = var_503_8.childCount

				for iter_503_4 = 0, var_503_10 - 1 do
					local var_503_11 = var_503_8:GetChild(iter_503_4)

					if var_503_11.name == "" or not string.find(var_503_11.name, "split") then
						var_503_11.gameObject:SetActive(true)
					else
						var_503_11.gameObject:SetActive(false)
					end
				end
			end

			local var_503_12 = 0.001

			if var_503_9 <= arg_500_1.time_ and arg_500_1.time_ < var_503_9 + var_503_12 then
				local var_503_13 = (arg_500_1.time_ - var_503_9) / var_503_12
				local var_503_14 = Vector3.New(0, -475, -325)

				var_503_8.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10183, var_503_14, var_503_13)
			end

			if arg_500_1.time_ >= var_503_9 + var_503_12 and arg_500_1.time_ < var_503_9 + var_503_12 + arg_503_0 then
				var_503_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_503_15 = arg_500_1.actors_["10183"].transform
			local var_503_16 = 0.2

			if var_503_16 < arg_500_1.time_ and arg_500_1.time_ <= var_503_16 + arg_503_0 then
				arg_500_1.var_.moveOldPos10183 = var_503_15.localPosition
				var_503_15.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10183", 3)

				local var_503_17 = var_503_15.childCount

				for iter_503_5 = 0, var_503_17 - 1 do
					local var_503_18 = var_503_15:GetChild(iter_503_5)

					if var_503_18.name == "split_3" then
						var_503_18:SetAsLastSibling()
						var_503_18.gameObject:SetActive(true)

						arg_500_1.var_.actorSpriteSplit10183 = var_503_18.gameObject:GetComponent(typeof(Image))

						arg_500_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_503_19 = 0.5

			if var_503_16 <= arg_500_1.time_ and arg_500_1.time_ < var_503_16 + var_503_19 then
				local var_503_20 = (arg_500_1.time_ - var_503_16) / var_503_19
				local var_503_21 = Vector3.New(0, -475, -325)

				var_503_15.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10183, var_503_21, var_503_20)

				if arg_500_1.var_.actorSpriteSplit10183 ~= nil then
					arg_500_1.var_.actorSpriteSplit10183:SetAlpha(var_503_20)
				end
			end

			if arg_500_1.time_ >= var_503_16 + var_503_19 and arg_500_1.time_ < var_503_16 + var_503_19 + arg_503_0 then
				var_503_15.localPosition = Vector3.New(0, -475, -325)

				if arg_500_1.var_.actorSpriteSplit10183 ~= nil then
					arg_500_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_503_22 = 0

			if var_503_22 < arg_500_1.time_ and arg_500_1.time_ <= var_503_22 + arg_503_0 then
				arg_500_1.allBtn_.enabled = false
			end

			local var_503_23 = 0.7

			if arg_500_1.time_ >= var_503_22 + var_503_23 and arg_500_1.time_ < var_503_22 + var_503_23 + arg_503_0 then
				arg_500_1.allBtn_.enabled = true
			end

			local var_503_24 = 0
			local var_503_25 = 1.5

			if var_503_24 < arg_500_1.time_ and arg_500_1.time_ <= var_503_24 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_26 = arg_500_1:FormatText(StoryNameCfg[1562].name)

				arg_500_1.leftNameTxt_.text = var_503_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_27 = arg_500_1:GetWordFromCfg(938032122)
				local var_503_28 = arg_500_1:FormatText(var_503_27.content)

				arg_500_1.text_.text = var_503_28

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_29 = 60
				local var_503_30 = utf8.len(var_503_28)
				local var_503_31 = var_503_29 <= 0 and var_503_25 or var_503_25 * (var_503_30 / var_503_29)

				if var_503_31 > 0 and var_503_25 < var_503_31 then
					arg_500_1.talkMaxDuration = var_503_31

					if var_503_31 + var_503_24 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_31 + var_503_24
					end
				end

				arg_500_1.text_.text = var_503_28
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_32 = math.max(var_503_25, arg_500_1.talkMaxDuration)

			if var_503_24 <= arg_500_1.time_ and arg_500_1.time_ < var_503_24 + var_503_32 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_24) / var_503_32

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_24 + var_503_32 and arg_500_1.time_ < var_503_24 + var_503_32 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play938032123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 938032123
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play938032124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["10183"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.actorSpriteComps10183 == nil then
				arg_504_1.var_.actorSpriteComps10183 = var_507_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_507_2 = 0.2

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.actorSpriteComps10183 then
					for iter_507_0, iter_507_1 in pairs(arg_504_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_507_1 then
							if arg_504_1.isInRecall_ then
								local var_507_4 = Mathf.Lerp(iter_507_1.color.r, arg_504_1.hightColor2.r, var_507_3)
								local var_507_5 = Mathf.Lerp(iter_507_1.color.g, arg_504_1.hightColor2.g, var_507_3)
								local var_507_6 = Mathf.Lerp(iter_507_1.color.b, arg_504_1.hightColor2.b, var_507_3)

								iter_507_1.color = Color.New(var_507_4, var_507_5, var_507_6)
							else
								local var_507_7 = Mathf.Lerp(iter_507_1.color.r, 0.5, var_507_3)

								iter_507_1.color = Color.New(var_507_7, var_507_7, var_507_7)
							end
						end
					end
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.actorSpriteComps10183 then
				for iter_507_2, iter_507_3 in pairs(arg_504_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_507_3 then
						if arg_504_1.isInRecall_ then
							iter_507_3.color = arg_504_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_507_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_504_1.var_.actorSpriteComps10183 = nil
			end

			local var_507_8 = arg_504_1.actors_["10183"].transform
			local var_507_9 = 0

			if var_507_9 < arg_504_1.time_ and arg_504_1.time_ <= var_507_9 + arg_507_0 then
				arg_504_1.var_.moveOldPos10183 = var_507_8.localPosition
				var_507_8.localScale = Vector3.New(1, 1, 1)

				arg_504_1:CheckSpriteTmpPos("10183", 7)

				local var_507_10 = var_507_8.childCount

				for iter_507_4 = 0, var_507_10 - 1 do
					local var_507_11 = var_507_8:GetChild(iter_507_4)

					if var_507_11.name == "" or not string.find(var_507_11.name, "split") then
						var_507_11.gameObject:SetActive(true)
					else
						var_507_11.gameObject:SetActive(false)
					end
				end
			end

			local var_507_12 = 0.001

			if var_507_9 <= arg_504_1.time_ and arg_504_1.time_ < var_507_9 + var_507_12 then
				local var_507_13 = (arg_504_1.time_ - var_507_9) / var_507_12
				local var_507_14 = Vector3.New(0, -2000, 0)

				var_507_8.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos10183, var_507_14, var_507_13)
			end

			if arg_504_1.time_ >= var_507_9 + var_507_12 and arg_504_1.time_ < var_507_9 + var_507_12 + arg_507_0 then
				var_507_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_507_15 = 0
			local var_507_16 = 1.25

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_17 = arg_504_1:GetWordFromCfg(938032123)
				local var_507_18 = arg_504_1:FormatText(var_507_17.content)

				arg_504_1.text_.text = var_507_18

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_19 = 50
				local var_507_20 = utf8.len(var_507_18)
				local var_507_21 = var_507_19 <= 0 and var_507_16 or var_507_16 * (var_507_20 / var_507_19)

				if var_507_21 > 0 and var_507_16 < var_507_21 then
					arg_504_1.talkMaxDuration = var_507_21

					if var_507_21 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_21 + var_507_15
					end
				end

				arg_504_1.text_.text = var_507_18
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_22 = math.max(var_507_16, arg_504_1.talkMaxDuration)

			if var_507_15 <= arg_504_1.time_ and arg_504_1.time_ < var_507_15 + var_507_22 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_15) / var_507_22

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_15 + var_507_22 and arg_504_1.time_ < var_507_15 + var_507_22 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
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

		arg_504_1:InitPlayNodeList()
	end,
	Play938032124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 938032124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play938032125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["108301"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps108301 == nil then
				arg_508_1.var_.actorSpriteComps108301 = var_511_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.actorSpriteComps108301 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								local var_511_4 = Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, var_511_3)
								local var_511_5 = Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, var_511_3)
								local var_511_6 = Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, var_511_3)

								iter_511_1.color = Color.New(var_511_4, var_511_5, var_511_6)
							else
								local var_511_7 = Mathf.Lerp(iter_511_1.color.r, 1, var_511_3)

								iter_511_1.color = Color.New(var_511_7, var_511_7, var_511_7)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps108301 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_511_3 then
						if arg_508_1.isInRecall_ then
							iter_511_3.color = arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_511_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_508_1.var_.actorSpriteComps108301 = nil
			end

			local var_511_8 = arg_508_1.actors_["108301"].transform
			local var_511_9 = 0

			if var_511_9 < arg_508_1.time_ and arg_508_1.time_ <= var_511_9 + arg_511_0 then
				arg_508_1.var_.moveOldPos108301 = var_511_8.localPosition
				var_511_8.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("108301", 2)

				local var_511_10 = var_511_8.childCount

				for iter_511_4 = 0, var_511_10 - 1 do
					local var_511_11 = var_511_8:GetChild(iter_511_4)

					if var_511_11.name == "split_3" or not string.find(var_511_11.name, "split") then
						var_511_11.gameObject:SetActive(true)
					else
						var_511_11.gameObject:SetActive(false)
					end
				end
			end

			local var_511_12 = 0.001

			if var_511_9 <= arg_508_1.time_ and arg_508_1.time_ < var_511_9 + var_511_12 then
				local var_511_13 = (arg_508_1.time_ - var_511_9) / var_511_12
				local var_511_14 = Vector3.New(-300, -475, -325)

				var_511_8.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos108301, var_511_14, var_511_13)
			end

			if arg_508_1.time_ >= var_511_9 + var_511_12 and arg_508_1.time_ < var_511_9 + var_511_12 + arg_511_0 then
				var_511_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_511_15 = 0
			local var_511_16 = 0.125

			if var_511_15 < arg_508_1.time_ and arg_508_1.time_ <= var_511_15 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_17 = arg_508_1:FormatText(StoryNameCfg[1332].name)

				arg_508_1.leftNameTxt_.text = var_511_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_18 = arg_508_1:GetWordFromCfg(938032124)
				local var_511_19 = arg_508_1:FormatText(var_511_18.content)

				arg_508_1.text_.text = var_511_19

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_20 = 5
				local var_511_21 = utf8.len(var_511_19)
				local var_511_22 = var_511_20 <= 0 and var_511_16 or var_511_16 * (var_511_21 / var_511_20)

				if var_511_22 > 0 and var_511_16 < var_511_22 then
					arg_508_1.talkMaxDuration = var_511_22

					if var_511_22 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_22 + var_511_15
					end
				end

				arg_508_1.text_.text = var_511_19
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_23 = math.max(var_511_16, arg_508_1.talkMaxDuration)

			if var_511_15 <= arg_508_1.time_ and arg_508_1.time_ < var_511_15 + var_511_23 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_15) / var_511_23

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_15 + var_511_23 and arg_508_1.time_ < var_511_15 + var_511_23 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
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

		arg_508_1:InitPlayNodeList()
	end,
	Play938032125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 938032125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play938032126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["128404"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps128404 == nil then
				arg_512_1.var_.actorSpriteComps128404 = var_515_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_2 = 0.2

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.actorSpriteComps128404 then
					for iter_515_0, iter_515_1 in pairs(arg_512_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_515_1 then
							if arg_512_1.isInRecall_ then
								local var_515_4 = Mathf.Lerp(iter_515_1.color.r, arg_512_1.hightColor1.r, var_515_3)
								local var_515_5 = Mathf.Lerp(iter_515_1.color.g, arg_512_1.hightColor1.g, var_515_3)
								local var_515_6 = Mathf.Lerp(iter_515_1.color.b, arg_512_1.hightColor1.b, var_515_3)

								iter_515_1.color = Color.New(var_515_4, var_515_5, var_515_6)
							else
								local var_515_7 = Mathf.Lerp(iter_515_1.color.r, 1, var_515_3)

								iter_515_1.color = Color.New(var_515_7, var_515_7, var_515_7)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps128404 then
				for iter_515_2, iter_515_3 in pairs(arg_512_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_515_3 then
						if arg_512_1.isInRecall_ then
							iter_515_3.color = arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_515_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_512_1.var_.actorSpriteComps128404 = nil
			end

			local var_515_8 = arg_512_1.actors_["108301"]
			local var_515_9 = 0

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 and not isNil(var_515_8) and arg_512_1.var_.actorSpriteComps108301 == nil then
				arg_512_1.var_.actorSpriteComps108301 = var_515_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_10 = 0.2

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_10 and not isNil(var_515_8) then
				local var_515_11 = (arg_512_1.time_ - var_515_9) / var_515_10

				if arg_512_1.var_.actorSpriteComps108301 then
					for iter_515_4, iter_515_5 in pairs(arg_512_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_515_5 then
							if arg_512_1.isInRecall_ then
								local var_515_12 = Mathf.Lerp(iter_515_5.color.r, arg_512_1.hightColor2.r, var_515_11)
								local var_515_13 = Mathf.Lerp(iter_515_5.color.g, arg_512_1.hightColor2.g, var_515_11)
								local var_515_14 = Mathf.Lerp(iter_515_5.color.b, arg_512_1.hightColor2.b, var_515_11)

								iter_515_5.color = Color.New(var_515_12, var_515_13, var_515_14)
							else
								local var_515_15 = Mathf.Lerp(iter_515_5.color.r, 0.5, var_515_11)

								iter_515_5.color = Color.New(var_515_15, var_515_15, var_515_15)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= var_515_9 + var_515_10 and arg_512_1.time_ < var_515_9 + var_515_10 + arg_515_0 and not isNil(var_515_8) and arg_512_1.var_.actorSpriteComps108301 then
				for iter_515_6, iter_515_7 in pairs(arg_512_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_515_7 then
						if arg_512_1.isInRecall_ then
							iter_515_7.color = arg_512_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_515_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_512_1.var_.actorSpriteComps108301 = nil
			end

			local var_515_16 = arg_512_1.actors_["128404"].transform
			local var_515_17 = 0

			if var_515_17 < arg_512_1.time_ and arg_512_1.time_ <= var_515_17 + arg_515_0 then
				arg_512_1.var_.moveOldPos128404 = var_515_16.localPosition
				var_515_16.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("128404", 4)

				local var_515_18 = var_515_16.childCount

				for iter_515_8 = 0, var_515_18 - 1 do
					local var_515_19 = var_515_16:GetChild(iter_515_8)

					if var_515_19.name == "split_5" or not string.find(var_515_19.name, "split") then
						var_515_19.gameObject:SetActive(true)
					else
						var_515_19.gameObject:SetActive(false)
					end
				end
			end

			local var_515_20 = 0.001

			if var_515_17 <= arg_512_1.time_ and arg_512_1.time_ < var_515_17 + var_515_20 then
				local var_515_21 = (arg_512_1.time_ - var_515_17) / var_515_20
				local var_515_22 = Vector3.New(390.2, -356, -362.3)

				var_515_16.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos128404, var_515_22, var_515_21)
			end

			if arg_512_1.time_ >= var_515_17 + var_515_20 and arg_512_1.time_ < var_515_17 + var_515_20 + arg_515_0 then
				var_515_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_515_23 = 0
			local var_515_24 = 0.35

			if var_515_23 < arg_512_1.time_ and arg_512_1.time_ <= var_515_23 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_25 = arg_512_1:FormatText(StoryNameCfg[6].name)

				arg_512_1.leftNameTxt_.text = var_515_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_26 = arg_512_1:GetWordFromCfg(938032125)
				local var_515_27 = arg_512_1:FormatText(var_515_26.content)

				arg_512_1.text_.text = var_515_27

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_28 = 14
				local var_515_29 = utf8.len(var_515_27)
				local var_515_30 = var_515_28 <= 0 and var_515_24 or var_515_24 * (var_515_29 / var_515_28)

				if var_515_30 > 0 and var_515_24 < var_515_30 then
					arg_512_1.talkMaxDuration = var_515_30

					if var_515_30 + var_515_23 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_30 + var_515_23
					end
				end

				arg_512_1.text_.text = var_515_27
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_31 = math.max(var_515_24, arg_512_1.talkMaxDuration)

			if var_515_23 <= arg_512_1.time_ and arg_512_1.time_ < var_515_23 + var_515_31 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_23) / var_515_31

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_23 + var_515_31 and arg_512_1.time_ < var_515_23 + var_515_31 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
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

		arg_512_1:InitPlayNodeList()
	end,
	Play938032126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 938032126
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play938032127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["128404"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.actorSpriteComps128404 == nil then
				arg_516_1.var_.actorSpriteComps128404 = var_519_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_519_2 = 0.2

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.actorSpriteComps128404 then
					for iter_519_0, iter_519_1 in pairs(arg_516_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_519_1 then
							if arg_516_1.isInRecall_ then
								local var_519_4 = Mathf.Lerp(iter_519_1.color.r, arg_516_1.hightColor2.r, var_519_3)
								local var_519_5 = Mathf.Lerp(iter_519_1.color.g, arg_516_1.hightColor2.g, var_519_3)
								local var_519_6 = Mathf.Lerp(iter_519_1.color.b, arg_516_1.hightColor2.b, var_519_3)

								iter_519_1.color = Color.New(var_519_4, var_519_5, var_519_6)
							else
								local var_519_7 = Mathf.Lerp(iter_519_1.color.r, 0.5, var_519_3)

								iter_519_1.color = Color.New(var_519_7, var_519_7, var_519_7)
							end
						end
					end
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.actorSpriteComps128404 then
				for iter_519_2, iter_519_3 in pairs(arg_516_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_519_3 then
						if arg_516_1.isInRecall_ then
							iter_519_3.color = arg_516_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_519_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_516_1.var_.actorSpriteComps128404 = nil
			end

			local var_519_8 = arg_516_1.actors_["128404"].transform
			local var_519_9 = 0

			if var_519_9 < arg_516_1.time_ and arg_516_1.time_ <= var_519_9 + arg_519_0 then
				arg_516_1.var_.moveOldPos128404 = var_519_8.localPosition
				var_519_8.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("128404", 7)

				local var_519_10 = var_519_8.childCount

				for iter_519_4 = 0, var_519_10 - 1 do
					local var_519_11 = var_519_8:GetChild(iter_519_4)

					if var_519_11.name == "" or not string.find(var_519_11.name, "split") then
						var_519_11.gameObject:SetActive(true)
					else
						var_519_11.gameObject:SetActive(false)
					end
				end
			end

			local var_519_12 = 0.001

			if var_519_9 <= arg_516_1.time_ and arg_516_1.time_ < var_519_9 + var_519_12 then
				local var_519_13 = (arg_516_1.time_ - var_519_9) / var_519_12
				local var_519_14 = Vector3.New(0, -2000, 0)

				var_519_8.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos128404, var_519_14, var_519_13)
			end

			if arg_516_1.time_ >= var_519_9 + var_519_12 and arg_516_1.time_ < var_519_9 + var_519_12 + arg_519_0 then
				var_519_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_519_15 = arg_516_1.actors_["108301"].transform
			local var_519_16 = 0

			if var_519_16 < arg_516_1.time_ and arg_516_1.time_ <= var_519_16 + arg_519_0 then
				arg_516_1.var_.moveOldPos108301 = var_519_15.localPosition
				var_519_15.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("108301", 7)

				local var_519_17 = var_519_15.childCount

				for iter_519_5 = 0, var_519_17 - 1 do
					local var_519_18 = var_519_15:GetChild(iter_519_5)

					if var_519_18.name == "" or not string.find(var_519_18.name, "split") then
						var_519_18.gameObject:SetActive(true)
					else
						var_519_18.gameObject:SetActive(false)
					end
				end
			end

			local var_519_19 = 0.001

			if var_519_16 <= arg_516_1.time_ and arg_516_1.time_ < var_519_16 + var_519_19 then
				local var_519_20 = (arg_516_1.time_ - var_519_16) / var_519_19
				local var_519_21 = Vector3.New(0, -2000, 0)

				var_519_15.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos108301, var_519_21, var_519_20)
			end

			if arg_516_1.time_ >= var_519_16 + var_519_19 and arg_516_1.time_ < var_519_16 + var_519_19 + arg_519_0 then
				var_519_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_519_22 = 0
			local var_519_23 = 0.375

			if var_519_22 < arg_516_1.time_ and arg_516_1.time_ <= var_519_22 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_24 = arg_516_1:FormatText(StoryNameCfg[7].name)

				arg_516_1.leftNameTxt_.text = var_519_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_25 = arg_516_1:GetWordFromCfg(938032126)
				local var_519_26 = arg_516_1:FormatText(var_519_25.content)

				arg_516_1.text_.text = var_519_26

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_27 = 15
				local var_519_28 = utf8.len(var_519_26)
				local var_519_29 = var_519_27 <= 0 and var_519_23 or var_519_23 * (var_519_28 / var_519_27)

				if var_519_29 > 0 and var_519_23 < var_519_29 then
					arg_516_1.talkMaxDuration = var_519_29

					if var_519_29 + var_519_22 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_29 + var_519_22
					end
				end

				arg_516_1.text_.text = var_519_26
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_30 = math.max(var_519_23, arg_516_1.talkMaxDuration)

			if var_519_22 <= arg_516_1.time_ and arg_516_1.time_ < var_519_22 + var_519_30 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_22) / var_519_30

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_22 + var_519_30 and arg_516_1.time_ < var_519_22 + var_519_30 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play938032127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 938032127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play938032128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["106603"]
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps106603 == nil then
				arg_520_1.var_.actorSpriteComps106603 = var_523_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_2 = 0.2

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 and not isNil(var_523_0) then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2

				if arg_520_1.var_.actorSpriteComps106603 then
					for iter_523_0, iter_523_1 in pairs(arg_520_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_523_1 then
							if arg_520_1.isInRecall_ then
								local var_523_4 = Mathf.Lerp(iter_523_1.color.r, arg_520_1.hightColor1.r, var_523_3)
								local var_523_5 = Mathf.Lerp(iter_523_1.color.g, arg_520_1.hightColor1.g, var_523_3)
								local var_523_6 = Mathf.Lerp(iter_523_1.color.b, arg_520_1.hightColor1.b, var_523_3)

								iter_523_1.color = Color.New(var_523_4, var_523_5, var_523_6)
							else
								local var_523_7 = Mathf.Lerp(iter_523_1.color.r, 1, var_523_3)

								iter_523_1.color = Color.New(var_523_7, var_523_7, var_523_7)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps106603 then
				for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_523_3 then
						if arg_520_1.isInRecall_ then
							iter_523_3.color = arg_520_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_523_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_520_1.var_.actorSpriteComps106603 = nil
			end

			local var_523_8 = arg_520_1.actors_["106603"].transform
			local var_523_9 = 0

			if var_523_9 < arg_520_1.time_ and arg_520_1.time_ <= var_523_9 + arg_523_0 then
				arg_520_1.var_.moveOldPos106603 = var_523_8.localPosition
				var_523_8.localScale = Vector3.New(1, 1, 1)

				arg_520_1:CheckSpriteTmpPos("106603", 2)

				local var_523_10 = var_523_8.childCount

				for iter_523_4 = 0, var_523_10 - 1 do
					local var_523_11 = var_523_8:GetChild(iter_523_4)

					if var_523_11.name == "" or not string.find(var_523_11.name, "split") then
						var_523_11.gameObject:SetActive(true)
					else
						var_523_11.gameObject:SetActive(false)
					end
				end
			end

			local var_523_12 = 0.001

			if var_523_9 <= arg_520_1.time_ and arg_520_1.time_ < var_523_9 + var_523_12 then
				local var_523_13 = (arg_520_1.time_ - var_523_9) / var_523_12
				local var_523_14 = Vector3.New(-510.9, -399.1, -303.3)

				var_523_8.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos106603, var_523_14, var_523_13)
			end

			if arg_520_1.time_ >= var_523_9 + var_523_12 and arg_520_1.time_ < var_523_9 + var_523_12 + arg_523_0 then
				var_523_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_523_15 = 0
			local var_523_16 = 0.575

			if var_523_15 < arg_520_1.time_ and arg_520_1.time_ <= var_523_15 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_17 = arg_520_1:FormatText(StoryNameCfg[32].name)

				arg_520_1.leftNameTxt_.text = var_523_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_18 = arg_520_1:GetWordFromCfg(938032127)
				local var_523_19 = arg_520_1:FormatText(var_523_18.content)

				arg_520_1.text_.text = var_523_19

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_20 = 23
				local var_523_21 = utf8.len(var_523_19)
				local var_523_22 = var_523_20 <= 0 and var_523_16 or var_523_16 * (var_523_21 / var_523_20)

				if var_523_22 > 0 and var_523_16 < var_523_22 then
					arg_520_1.talkMaxDuration = var_523_22

					if var_523_22 + var_523_15 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_22 + var_523_15
					end
				end

				arg_520_1.text_.text = var_523_19
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_23 = math.max(var_523_16, arg_520_1.talkMaxDuration)

			if var_523_15 <= arg_520_1.time_ and arg_520_1.time_ < var_523_15 + var_523_23 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_15) / var_523_23

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_15 + var_523_23 and arg_520_1.time_ < var_523_15 + var_523_23 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
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

		arg_520_1:InitPlayNodeList()
	end,
	Play938032128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 938032128
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play938032129(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["106603"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps106603 == nil then
				arg_524_1.var_.actorSpriteComps106603 = var_527_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_527_2 = 0.2

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.actorSpriteComps106603 then
					for iter_527_0, iter_527_1 in pairs(arg_524_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_527_1 then
							if arg_524_1.isInRecall_ then
								local var_527_4 = Mathf.Lerp(iter_527_1.color.r, arg_524_1.hightColor2.r, var_527_3)
								local var_527_5 = Mathf.Lerp(iter_527_1.color.g, arg_524_1.hightColor2.g, var_527_3)
								local var_527_6 = Mathf.Lerp(iter_527_1.color.b, arg_524_1.hightColor2.b, var_527_3)

								iter_527_1.color = Color.New(var_527_4, var_527_5, var_527_6)
							else
								local var_527_7 = Mathf.Lerp(iter_527_1.color.r, 0.5, var_527_3)

								iter_527_1.color = Color.New(var_527_7, var_527_7, var_527_7)
							end
						end
					end
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps106603 then
				for iter_527_2, iter_527_3 in pairs(arg_524_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_527_3 then
						if arg_524_1.isInRecall_ then
							iter_527_3.color = arg_524_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_527_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_524_1.var_.actorSpriteComps106603 = nil
			end

			local var_527_8 = arg_524_1.actors_["104902"].transform
			local var_527_9 = 0

			if var_527_9 < arg_524_1.time_ and arg_524_1.time_ <= var_527_9 + arg_527_0 then
				arg_524_1.var_.moveOldPos104902 = var_527_8.localPosition
				var_527_8.localScale = Vector3.New(1, 1, 1)

				arg_524_1:CheckSpriteTmpPos("104902", 4)

				local var_527_10 = var_527_8.childCount

				for iter_527_4 = 0, var_527_10 - 1 do
					local var_527_11 = var_527_8:GetChild(iter_527_4)

					if var_527_11.name == "" or not string.find(var_527_11.name, "split") then
						var_527_11.gameObject:SetActive(true)
					else
						var_527_11.gameObject:SetActive(false)
					end
				end
			end

			local var_527_12 = 0.001

			if var_527_9 <= arg_524_1.time_ and arg_524_1.time_ < var_527_9 + var_527_12 then
				local var_527_13 = (arg_524_1.time_ - var_527_9) / var_527_12
				local var_527_14 = Vector3.New(390, -335, -360)

				var_527_8.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos104902, var_527_14, var_527_13)
			end

			if arg_524_1.time_ >= var_527_9 + var_527_12 and arg_524_1.time_ < var_527_9 + var_527_12 + arg_527_0 then
				var_527_8.localPosition = Vector3.New(390, -335, -360)
			end

			local var_527_15 = 0
			local var_527_16 = 0.55

			if var_527_15 < arg_524_1.time_ and arg_524_1.time_ <= var_527_15 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_17 = arg_524_1:FormatText(StoryNameCfg[7].name)

				arg_524_1.leftNameTxt_.text = var_527_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_18 = arg_524_1:GetWordFromCfg(938032128)
				local var_527_19 = arg_524_1:FormatText(var_527_18.content)

				arg_524_1.text_.text = var_527_19

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_20 = 22
				local var_527_21 = utf8.len(var_527_19)
				local var_527_22 = var_527_20 <= 0 and var_527_16 or var_527_16 * (var_527_21 / var_527_20)

				if var_527_22 > 0 and var_527_16 < var_527_22 then
					arg_524_1.talkMaxDuration = var_527_22

					if var_527_22 + var_527_15 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_22 + var_527_15
					end
				end

				arg_524_1.text_.text = var_527_19
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_23 = math.max(var_527_16, arg_524_1.talkMaxDuration)

			if var_527_15 <= arg_524_1.time_ and arg_524_1.time_ < var_527_15 + var_527_23 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_15) / var_527_23

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_15 + var_527_23 and arg_524_1.time_ < var_527_15 + var_527_23 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
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

		arg_524_1:InitPlayNodeList()
	end,
	Play938032129 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 938032129
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play938032130(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["104902"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.actorSpriteComps104902 == nil then
				arg_528_1.var_.actorSpriteComps104902 = var_531_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_531_2 = 0.2

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.actorSpriteComps104902 then
					for iter_531_0, iter_531_1 in pairs(arg_528_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_531_1 then
							if arg_528_1.isInRecall_ then
								local var_531_4 = Mathf.Lerp(iter_531_1.color.r, arg_528_1.hightColor1.r, var_531_3)
								local var_531_5 = Mathf.Lerp(iter_531_1.color.g, arg_528_1.hightColor1.g, var_531_3)
								local var_531_6 = Mathf.Lerp(iter_531_1.color.b, arg_528_1.hightColor1.b, var_531_3)

								iter_531_1.color = Color.New(var_531_4, var_531_5, var_531_6)
							else
								local var_531_7 = Mathf.Lerp(iter_531_1.color.r, 1, var_531_3)

								iter_531_1.color = Color.New(var_531_7, var_531_7, var_531_7)
							end
						end
					end
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.actorSpriteComps104902 then
				for iter_531_2, iter_531_3 in pairs(arg_528_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_531_3 then
						if arg_528_1.isInRecall_ then
							iter_531_3.color = arg_528_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_531_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_528_1.var_.actorSpriteComps104902 = nil
			end

			local var_531_8 = 0
			local var_531_9 = 0.575

			if var_531_8 < arg_528_1.time_ and arg_528_1.time_ <= var_531_8 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_10 = arg_528_1:FormatText(StoryNameCfg[562].name)

				arg_528_1.leftNameTxt_.text = var_531_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_11 = arg_528_1:GetWordFromCfg(938032129)
				local var_531_12 = arg_528_1:FormatText(var_531_11.content)

				arg_528_1.text_.text = var_531_12

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_13 = 23
				local var_531_14 = utf8.len(var_531_12)
				local var_531_15 = var_531_13 <= 0 and var_531_9 or var_531_9 * (var_531_14 / var_531_13)

				if var_531_15 > 0 and var_531_9 < var_531_15 then
					arg_528_1.talkMaxDuration = var_531_15

					if var_531_15 + var_531_8 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_15 + var_531_8
					end
				end

				arg_528_1.text_.text = var_531_12
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_16 = math.max(var_531_9, arg_528_1.talkMaxDuration)

			if var_531_8 <= arg_528_1.time_ and arg_528_1.time_ < var_531_8 + var_531_16 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_8) / var_531_16

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_8 + var_531_16 and arg_528_1.time_ < var_531_8 + var_531_16 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play938032130 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 938032130
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play938032131(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["104902"]
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps104902 == nil then
				arg_532_1.var_.actorSpriteComps104902 = var_535_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_535_2 = 0.2

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 and not isNil(var_535_0) then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2

				if arg_532_1.var_.actorSpriteComps104902 then
					for iter_535_0, iter_535_1 in pairs(arg_532_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_535_1 then
							if arg_532_1.isInRecall_ then
								local var_535_4 = Mathf.Lerp(iter_535_1.color.r, arg_532_1.hightColor2.r, var_535_3)
								local var_535_5 = Mathf.Lerp(iter_535_1.color.g, arg_532_1.hightColor2.g, var_535_3)
								local var_535_6 = Mathf.Lerp(iter_535_1.color.b, arg_532_1.hightColor2.b, var_535_3)

								iter_535_1.color = Color.New(var_535_4, var_535_5, var_535_6)
							else
								local var_535_7 = Mathf.Lerp(iter_535_1.color.r, 0.5, var_535_3)

								iter_535_1.color = Color.New(var_535_7, var_535_7, var_535_7)
							end
						end
					end
				end
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps104902 then
				for iter_535_2, iter_535_3 in pairs(arg_532_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_535_3 then
						if arg_532_1.isInRecall_ then
							iter_535_3.color = arg_532_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_535_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_532_1.var_.actorSpriteComps104902 = nil
			end

			local var_535_8 = 0
			local var_535_9 = 1.025

			if var_535_8 < arg_532_1.time_ and arg_532_1.time_ <= var_535_8 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_10 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_11 = arg_532_1:GetWordFromCfg(938032130)
				local var_535_12 = arg_532_1:FormatText(var_535_11.content)

				arg_532_1.text_.text = var_535_12

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_13 = 41
				local var_535_14 = utf8.len(var_535_12)
				local var_535_15 = var_535_13 <= 0 and var_535_9 or var_535_9 * (var_535_14 / var_535_13)

				if var_535_15 > 0 and var_535_9 < var_535_15 then
					arg_532_1.talkMaxDuration = var_535_15

					if var_535_15 + var_535_8 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_15 + var_535_8
					end
				end

				arg_532_1.text_.text = var_535_12
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_16 = math.max(var_535_9, arg_532_1.talkMaxDuration)

			if var_535_8 <= arg_532_1.time_ and arg_532_1.time_ < var_535_8 + var_535_16 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_8) / var_535_16

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_8 + var_535_16 and arg_532_1.time_ < var_535_8 + var_535_16 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play938032131 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 938032131
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play938032132(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.75

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_2 = arg_536_1:FormatText(StoryNameCfg[7].name)

				arg_536_1.leftNameTxt_.text = var_539_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_3 = arg_536_1:GetWordFromCfg(938032131)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 30
				local var_539_6 = utf8.len(var_539_4)
				local var_539_7 = var_539_5 <= 0 and var_539_1 or var_539_1 * (var_539_6 / var_539_5)

				if var_539_7 > 0 and var_539_1 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_8 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_8 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_8

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_8 and arg_536_1.time_ < var_539_0 + var_539_8 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play938032132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 938032132
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play938032133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["104902"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos104902 = var_543_0.localPosition
				var_543_0.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("104902", 7)

				local var_543_2 = var_543_0.childCount

				for iter_543_0 = 0, var_543_2 - 1 do
					local var_543_3 = var_543_0:GetChild(iter_543_0)

					if var_543_3.name == "" or not string.find(var_543_3.name, "split") then
						var_543_3.gameObject:SetActive(true)
					else
						var_543_3.gameObject:SetActive(false)
					end
				end
			end

			local var_543_4 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_4 then
				local var_543_5 = (arg_540_1.time_ - var_543_1) / var_543_4
				local var_543_6 = Vector3.New(0, -2000, -360)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos104902, var_543_6, var_543_5)
			end

			if arg_540_1.time_ >= var_543_1 + var_543_4 and arg_540_1.time_ < var_543_1 + var_543_4 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_543_7 = arg_540_1.actors_["106603"].transform
			local var_543_8 = 0

			if var_543_8 < arg_540_1.time_ and arg_540_1.time_ <= var_543_8 + arg_543_0 then
				arg_540_1.var_.moveOldPos106603 = var_543_7.localPosition
				var_543_7.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("106603", 7)

				local var_543_9 = var_543_7.childCount

				for iter_543_1 = 0, var_543_9 - 1 do
					local var_543_10 = var_543_7:GetChild(iter_543_1)

					if var_543_10.name == "" or not string.find(var_543_10.name, "split") then
						var_543_10.gameObject:SetActive(true)
					else
						var_543_10.gameObject:SetActive(false)
					end
				end
			end

			local var_543_11 = 0.001

			if var_543_8 <= arg_540_1.time_ and arg_540_1.time_ < var_543_8 + var_543_11 then
				local var_543_12 = (arg_540_1.time_ - var_543_8) / var_543_11
				local var_543_13 = Vector3.New(0, -2000, 0)

				var_543_7.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos106603, var_543_13, var_543_12)
			end

			if arg_540_1.time_ >= var_543_8 + var_543_11 and arg_540_1.time_ < var_543_8 + var_543_11 + arg_543_0 then
				var_543_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_543_14 = 0
			local var_543_15 = 0.975

			if var_543_14 < arg_540_1.time_ and arg_540_1.time_ <= var_543_14 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_16 = arg_540_1:GetWordFromCfg(938032132)
				local var_543_17 = arg_540_1:FormatText(var_543_16.content)

				arg_540_1.text_.text = var_543_17

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_18 = 39
				local var_543_19 = utf8.len(var_543_17)
				local var_543_20 = var_543_18 <= 0 and var_543_15 or var_543_15 * (var_543_19 / var_543_18)

				if var_543_20 > 0 and var_543_15 < var_543_20 then
					arg_540_1.talkMaxDuration = var_543_20

					if var_543_20 + var_543_14 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_20 + var_543_14
					end
				end

				arg_540_1.text_.text = var_543_17
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_21 = math.max(var_543_15, arg_540_1.talkMaxDuration)

			if var_543_14 <= arg_540_1.time_ and arg_540_1.time_ < var_543_14 + var_543_21 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_14) / var_543_21

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_14 + var_543_21 and arg_540_1.time_ < var_543_14 + var_543_21 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play938032133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 938032133
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play938032134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["10144"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.actorSpriteComps10144 == nil then
				arg_544_1.var_.actorSpriteComps10144 = var_547_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_547_2 = 0.2

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.actorSpriteComps10144 then
					for iter_547_0, iter_547_1 in pairs(arg_544_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_547_1 then
							if arg_544_1.isInRecall_ then
								local var_547_4 = Mathf.Lerp(iter_547_1.color.r, arg_544_1.hightColor1.r, var_547_3)
								local var_547_5 = Mathf.Lerp(iter_547_1.color.g, arg_544_1.hightColor1.g, var_547_3)
								local var_547_6 = Mathf.Lerp(iter_547_1.color.b, arg_544_1.hightColor1.b, var_547_3)

								iter_547_1.color = Color.New(var_547_4, var_547_5, var_547_6)
							else
								local var_547_7 = Mathf.Lerp(iter_547_1.color.r, 1, var_547_3)

								iter_547_1.color = Color.New(var_547_7, var_547_7, var_547_7)
							end
						end
					end
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.actorSpriteComps10144 then
				for iter_547_2, iter_547_3 in pairs(arg_544_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_547_3 then
						if arg_544_1.isInRecall_ then
							iter_547_3.color = arg_544_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_547_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_544_1.var_.actorSpriteComps10144 = nil
			end

			local var_547_8 = arg_544_1.actors_["10144"].transform
			local var_547_9 = 0

			if var_547_9 < arg_544_1.time_ and arg_544_1.time_ <= var_547_9 + arg_547_0 then
				arg_544_1.var_.moveOldPos10144 = var_547_8.localPosition
				var_547_8.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("10144", 3)

				local var_547_10 = var_547_8.childCount

				for iter_547_4 = 0, var_547_10 - 1 do
					local var_547_11 = var_547_8:GetChild(iter_547_4)

					if var_547_11.name == "split_1" or not string.find(var_547_11.name, "split") then
						var_547_11.gameObject:SetActive(true)
					else
						var_547_11.gameObject:SetActive(false)
					end
				end
			end

			local var_547_12 = 0.001

			if var_547_9 <= arg_544_1.time_ and arg_544_1.time_ < var_547_9 + var_547_12 then
				local var_547_13 = (arg_544_1.time_ - var_547_9) / var_547_12
				local var_547_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_547_8.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos10144, var_547_14, var_547_13)
			end

			if arg_544_1.time_ >= var_547_9 + var_547_12 and arg_544_1.time_ < var_547_9 + var_547_12 + arg_547_0 then
				var_547_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_547_15 = 0
			local var_547_16 = 1.1

			if var_547_15 < arg_544_1.time_ and arg_544_1.time_ <= var_547_15 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_17 = arg_544_1:FormatText(StoryNameCfg[1297].name)

				arg_544_1.leftNameTxt_.text = var_547_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_18 = arg_544_1:GetWordFromCfg(938032133)
				local var_547_19 = arg_544_1:FormatText(var_547_18.content)

				arg_544_1.text_.text = var_547_19

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_20 = 44
				local var_547_21 = utf8.len(var_547_19)
				local var_547_22 = var_547_20 <= 0 and var_547_16 or var_547_16 * (var_547_21 / var_547_20)

				if var_547_22 > 0 and var_547_16 < var_547_22 then
					arg_544_1.talkMaxDuration = var_547_22

					if var_547_22 + var_547_15 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_22 + var_547_15
					end
				end

				arg_544_1.text_.text = var_547_19
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_23 = math.max(var_547_16, arg_544_1.talkMaxDuration)

			if var_547_15 <= arg_544_1.time_ and arg_544_1.time_ < var_547_15 + var_547_23 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_15) / var_547_23

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_15 + var_547_23 and arg_544_1.time_ < var_547_15 + var_547_23 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
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

		arg_544_1:InitPlayNodeList()
	end,
	Play938032134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 938032134
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play938032135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["10144"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps10144 == nil then
				arg_548_1.var_.actorSpriteComps10144 = var_551_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_2 = 0.2

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.actorSpriteComps10144 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								local var_551_4 = Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor2.r, var_551_3)
								local var_551_5 = Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor2.g, var_551_3)
								local var_551_6 = Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor2.b, var_551_3)

								iter_551_1.color = Color.New(var_551_4, var_551_5, var_551_6)
							else
								local var_551_7 = Mathf.Lerp(iter_551_1.color.r, 0.5, var_551_3)

								iter_551_1.color = Color.New(var_551_7, var_551_7, var_551_7)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps10144 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_551_3 then
						if arg_548_1.isInRecall_ then
							iter_551_3.color = arg_548_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_551_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_548_1.var_.actorSpriteComps10144 = nil
			end

			local var_551_8 = 0
			local var_551_9 = 0.8

			if var_551_8 < arg_548_1.time_ and arg_548_1.time_ <= var_551_8 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_10 = arg_548_1:FormatText(StoryNameCfg[7].name)

				arg_548_1.leftNameTxt_.text = var_551_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_11 = arg_548_1:GetWordFromCfg(938032134)
				local var_551_12 = arg_548_1:FormatText(var_551_11.content)

				arg_548_1.text_.text = var_551_12

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_13 = 32
				local var_551_14 = utf8.len(var_551_12)
				local var_551_15 = var_551_13 <= 0 and var_551_9 or var_551_9 * (var_551_14 / var_551_13)

				if var_551_15 > 0 and var_551_9 < var_551_15 then
					arg_548_1.talkMaxDuration = var_551_15

					if var_551_15 + var_551_8 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_15 + var_551_8
					end
				end

				arg_548_1.text_.text = var_551_12
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_16 = math.max(var_551_9, arg_548_1.talkMaxDuration)

			if var_551_8 <= arg_548_1.time_ and arg_548_1.time_ < var_551_8 + var_551_16 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_8) / var_551_16

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_8 + var_551_16 and arg_548_1.time_ < var_551_8 + var_551_16 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play938032135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 938032135
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play938032136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["10144"]
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.actorSpriteComps10144 == nil then
				arg_552_1.var_.actorSpriteComps10144 = var_555_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_555_2 = 0.2

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 and not isNil(var_555_0) then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2

				if arg_552_1.var_.actorSpriteComps10144 then
					for iter_555_0, iter_555_1 in pairs(arg_552_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_555_1 then
							if arg_552_1.isInRecall_ then
								local var_555_4 = Mathf.Lerp(iter_555_1.color.r, arg_552_1.hightColor1.r, var_555_3)
								local var_555_5 = Mathf.Lerp(iter_555_1.color.g, arg_552_1.hightColor1.g, var_555_3)
								local var_555_6 = Mathf.Lerp(iter_555_1.color.b, arg_552_1.hightColor1.b, var_555_3)

								iter_555_1.color = Color.New(var_555_4, var_555_5, var_555_6)
							else
								local var_555_7 = Mathf.Lerp(iter_555_1.color.r, 1, var_555_3)

								iter_555_1.color = Color.New(var_555_7, var_555_7, var_555_7)
							end
						end
					end
				end
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.actorSpriteComps10144 then
				for iter_555_2, iter_555_3 in pairs(arg_552_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_555_3 then
						if arg_552_1.isInRecall_ then
							iter_555_3.color = arg_552_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_555_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_552_1.var_.actorSpriteComps10144 = nil
			end

			local var_555_8 = arg_552_1.actors_["10144"].transform
			local var_555_9 = 0

			if var_555_9 < arg_552_1.time_ and arg_552_1.time_ <= var_555_9 + arg_555_0 then
				arg_552_1.var_.moveOldPos10144 = var_555_8.localPosition
				var_555_8.localScale = Vector3.New(1, 1, 1)

				arg_552_1:CheckSpriteTmpPos("10144", 3)

				local var_555_10 = var_555_8.childCount

				for iter_555_4 = 0, var_555_10 - 1 do
					local var_555_11 = var_555_8:GetChild(iter_555_4)

					if var_555_11.name == "split_2" or not string.find(var_555_11.name, "split") then
						var_555_11.gameObject:SetActive(true)
					else
						var_555_11.gameObject:SetActive(false)
					end
				end
			end

			local var_555_12 = 0.001

			if var_555_9 <= arg_552_1.time_ and arg_552_1.time_ < var_555_9 + var_555_12 then
				local var_555_13 = (arg_552_1.time_ - var_555_9) / var_555_12
				local var_555_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_555_8.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos10144, var_555_14, var_555_13)
			end

			if arg_552_1.time_ >= var_555_9 + var_555_12 and arg_552_1.time_ < var_555_9 + var_555_12 + arg_555_0 then
				var_555_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_555_15 = 0
			local var_555_16 = 1.1

			if var_555_15 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_17 = arg_552_1:FormatText(StoryNameCfg[1297].name)

				arg_552_1.leftNameTxt_.text = var_555_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_18 = arg_552_1:GetWordFromCfg(938032135)
				local var_555_19 = arg_552_1:FormatText(var_555_18.content)

				arg_552_1.text_.text = var_555_19

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 44
				local var_555_21 = utf8.len(var_555_19)
				local var_555_22 = var_555_20 <= 0 and var_555_16 or var_555_16 * (var_555_21 / var_555_20)

				if var_555_22 > 0 and var_555_16 < var_555_22 then
					arg_552_1.talkMaxDuration = var_555_22

					if var_555_22 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_22 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_19
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_23 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_15 <= arg_552_1.time_ and arg_552_1.time_ < var_555_15 + var_555_23 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_15) / var_555_23

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_15 + var_555_23 and arg_552_1.time_ < var_555_15 + var_555_23 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
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

		arg_552_1:InitPlayNodeList()
	end,
	Play938032136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 938032136
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play938032137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["104902"]
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.actorSpriteComps104902 == nil then
				arg_556_1.var_.actorSpriteComps104902 = var_559_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_2 = 0.2

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 and not isNil(var_559_0) then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2

				if arg_556_1.var_.actorSpriteComps104902 then
					for iter_559_0, iter_559_1 in pairs(arg_556_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_559_1 then
							if arg_556_1.isInRecall_ then
								local var_559_4 = Mathf.Lerp(iter_559_1.color.r, arg_556_1.hightColor1.r, var_559_3)
								local var_559_5 = Mathf.Lerp(iter_559_1.color.g, arg_556_1.hightColor1.g, var_559_3)
								local var_559_6 = Mathf.Lerp(iter_559_1.color.b, arg_556_1.hightColor1.b, var_559_3)

								iter_559_1.color = Color.New(var_559_4, var_559_5, var_559_6)
							else
								local var_559_7 = Mathf.Lerp(iter_559_1.color.r, 1, var_559_3)

								iter_559_1.color = Color.New(var_559_7, var_559_7, var_559_7)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.actorSpriteComps104902 then
				for iter_559_2, iter_559_3 in pairs(arg_556_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_559_3 then
						if arg_556_1.isInRecall_ then
							iter_559_3.color = arg_556_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_559_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_556_1.var_.actorSpriteComps104902 = nil
			end

			local var_559_8 = arg_556_1.actors_["10144"]
			local var_559_9 = 0

			if var_559_9 < arg_556_1.time_ and arg_556_1.time_ <= var_559_9 + arg_559_0 and not isNil(var_559_8) and arg_556_1.var_.actorSpriteComps10144 == nil then
				arg_556_1.var_.actorSpriteComps10144 = var_559_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_10 = 0.2

			if var_559_9 <= arg_556_1.time_ and arg_556_1.time_ < var_559_9 + var_559_10 and not isNil(var_559_8) then
				local var_559_11 = (arg_556_1.time_ - var_559_9) / var_559_10

				if arg_556_1.var_.actorSpriteComps10144 then
					for iter_559_4, iter_559_5 in pairs(arg_556_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_559_5 then
							if arg_556_1.isInRecall_ then
								local var_559_12 = Mathf.Lerp(iter_559_5.color.r, arg_556_1.hightColor2.r, var_559_11)
								local var_559_13 = Mathf.Lerp(iter_559_5.color.g, arg_556_1.hightColor2.g, var_559_11)
								local var_559_14 = Mathf.Lerp(iter_559_5.color.b, arg_556_1.hightColor2.b, var_559_11)

								iter_559_5.color = Color.New(var_559_12, var_559_13, var_559_14)
							else
								local var_559_15 = Mathf.Lerp(iter_559_5.color.r, 0.5, var_559_11)

								iter_559_5.color = Color.New(var_559_15, var_559_15, var_559_15)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= var_559_9 + var_559_10 and arg_556_1.time_ < var_559_9 + var_559_10 + arg_559_0 and not isNil(var_559_8) and arg_556_1.var_.actorSpriteComps10144 then
				for iter_559_6, iter_559_7 in pairs(arg_556_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_559_7 then
						if arg_556_1.isInRecall_ then
							iter_559_7.color = arg_556_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_559_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_556_1.var_.actorSpriteComps10144 = nil
			end

			local var_559_16 = arg_556_1.actors_["104902"].transform
			local var_559_17 = 0

			if var_559_17 < arg_556_1.time_ and arg_556_1.time_ <= var_559_17 + arg_559_0 then
				arg_556_1.var_.moveOldPos104902 = var_559_16.localPosition
				var_559_16.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("104902", 2)

				local var_559_18 = var_559_16.childCount

				for iter_559_8 = 0, var_559_18 - 1 do
					local var_559_19 = var_559_16:GetChild(iter_559_8)

					if var_559_19.name == "" or not string.find(var_559_19.name, "split") then
						var_559_19.gameObject:SetActive(true)
					else
						var_559_19.gameObject:SetActive(false)
					end
				end
			end

			local var_559_20 = 0.001

			if var_559_17 <= arg_556_1.time_ and arg_556_1.time_ < var_559_17 + var_559_20 then
				local var_559_21 = (arg_556_1.time_ - var_559_17) / var_559_20
				local var_559_22 = Vector3.New(-390, -335, -360)

				var_559_16.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos104902, var_559_22, var_559_21)
			end

			if arg_556_1.time_ >= var_559_17 + var_559_20 and arg_556_1.time_ < var_559_17 + var_559_20 + arg_559_0 then
				var_559_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_559_23 = arg_556_1.actors_["10144"].transform
			local var_559_24 = 0

			if var_559_24 < arg_556_1.time_ and arg_556_1.time_ <= var_559_24 + arg_559_0 then
				arg_556_1.var_.moveOldPos10144 = var_559_23.localPosition
				var_559_23.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("10144", 7)

				local var_559_25 = var_559_23.childCount

				for iter_559_9 = 0, var_559_25 - 1 do
					local var_559_26 = var_559_23:GetChild(iter_559_9)

					if var_559_26.name == "" or not string.find(var_559_26.name, "split") then
						var_559_26.gameObject:SetActive(true)
					else
						var_559_26.gameObject:SetActive(false)
					end
				end
			end

			local var_559_27 = 0.001

			if var_559_24 <= arg_556_1.time_ and arg_556_1.time_ < var_559_24 + var_559_27 then
				local var_559_28 = (arg_556_1.time_ - var_559_24) / var_559_27
				local var_559_29 = Vector3.New(0, -2000, 0)

				var_559_23.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos10144, var_559_29, var_559_28)
			end

			if arg_556_1.time_ >= var_559_24 + var_559_27 and arg_556_1.time_ < var_559_24 + var_559_27 + arg_559_0 then
				var_559_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_559_30 = 0
			local var_559_31 = 0.4

			if var_559_30 < arg_556_1.time_ and arg_556_1.time_ <= var_559_30 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_32 = arg_556_1:FormatText(StoryNameCfg[562].name)

				arg_556_1.leftNameTxt_.text = var_559_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_33 = arg_556_1:GetWordFromCfg(938032136)
				local var_559_34 = arg_556_1:FormatText(var_559_33.content)

				arg_556_1.text_.text = var_559_34

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_35 = 16
				local var_559_36 = utf8.len(var_559_34)
				local var_559_37 = var_559_35 <= 0 and var_559_31 or var_559_31 * (var_559_36 / var_559_35)

				if var_559_37 > 0 and var_559_31 < var_559_37 then
					arg_556_1.talkMaxDuration = var_559_37

					if var_559_37 + var_559_30 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_37 + var_559_30
					end
				end

				arg_556_1.text_.text = var_559_34
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_38 = math.max(var_559_31, arg_556_1.talkMaxDuration)

			if var_559_30 <= arg_556_1.time_ and arg_556_1.time_ < var_559_30 + var_559_38 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_30) / var_559_38

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_30 + var_559_38 and arg_556_1.time_ < var_559_30 + var_559_38 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play938032137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 938032137
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play938032138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["128404"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps128404 == nil then
				arg_560_1.var_.actorSpriteComps128404 = var_563_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_2 = 0.2

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.actorSpriteComps128404 then
					for iter_563_0, iter_563_1 in pairs(arg_560_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_563_1 then
							if arg_560_1.isInRecall_ then
								local var_563_4 = Mathf.Lerp(iter_563_1.color.r, arg_560_1.hightColor1.r, var_563_3)
								local var_563_5 = Mathf.Lerp(iter_563_1.color.g, arg_560_1.hightColor1.g, var_563_3)
								local var_563_6 = Mathf.Lerp(iter_563_1.color.b, arg_560_1.hightColor1.b, var_563_3)

								iter_563_1.color = Color.New(var_563_4, var_563_5, var_563_6)
							else
								local var_563_7 = Mathf.Lerp(iter_563_1.color.r, 1, var_563_3)

								iter_563_1.color = Color.New(var_563_7, var_563_7, var_563_7)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps128404 then
				for iter_563_2, iter_563_3 in pairs(arg_560_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_563_3 then
						if arg_560_1.isInRecall_ then
							iter_563_3.color = arg_560_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_563_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_560_1.var_.actorSpriteComps128404 = nil
			end

			local var_563_8 = arg_560_1.actors_["104902"]
			local var_563_9 = 0

			if var_563_9 < arg_560_1.time_ and arg_560_1.time_ <= var_563_9 + arg_563_0 and not isNil(var_563_8) and arg_560_1.var_.actorSpriteComps104902 == nil then
				arg_560_1.var_.actorSpriteComps104902 = var_563_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_10 = 0.2

			if var_563_9 <= arg_560_1.time_ and arg_560_1.time_ < var_563_9 + var_563_10 and not isNil(var_563_8) then
				local var_563_11 = (arg_560_1.time_ - var_563_9) / var_563_10

				if arg_560_1.var_.actorSpriteComps104902 then
					for iter_563_4, iter_563_5 in pairs(arg_560_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_563_5 then
							if arg_560_1.isInRecall_ then
								local var_563_12 = Mathf.Lerp(iter_563_5.color.r, arg_560_1.hightColor2.r, var_563_11)
								local var_563_13 = Mathf.Lerp(iter_563_5.color.g, arg_560_1.hightColor2.g, var_563_11)
								local var_563_14 = Mathf.Lerp(iter_563_5.color.b, arg_560_1.hightColor2.b, var_563_11)

								iter_563_5.color = Color.New(var_563_12, var_563_13, var_563_14)
							else
								local var_563_15 = Mathf.Lerp(iter_563_5.color.r, 0.5, var_563_11)

								iter_563_5.color = Color.New(var_563_15, var_563_15, var_563_15)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= var_563_9 + var_563_10 and arg_560_1.time_ < var_563_9 + var_563_10 + arg_563_0 and not isNil(var_563_8) and arg_560_1.var_.actorSpriteComps104902 then
				for iter_563_6, iter_563_7 in pairs(arg_560_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_563_7 then
						if arg_560_1.isInRecall_ then
							iter_563_7.color = arg_560_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_563_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_560_1.var_.actorSpriteComps104902 = nil
			end

			local var_563_16 = arg_560_1.actors_["128404"].transform
			local var_563_17 = 0

			if var_563_17 < arg_560_1.time_ and arg_560_1.time_ <= var_563_17 + arg_563_0 then
				arg_560_1.var_.moveOldPos128404 = var_563_16.localPosition
				var_563_16.localScale = Vector3.New(1, 1, 1)

				arg_560_1:CheckSpriteTmpPos("128404", 4)

				local var_563_18 = var_563_16.childCount

				for iter_563_8 = 0, var_563_18 - 1 do
					local var_563_19 = var_563_16:GetChild(iter_563_8)

					if var_563_19.name == "split_6" or not string.find(var_563_19.name, "split") then
						var_563_19.gameObject:SetActive(true)
					else
						var_563_19.gameObject:SetActive(false)
					end
				end
			end

			local var_563_20 = 0.001

			if var_563_17 <= arg_560_1.time_ and arg_560_1.time_ < var_563_17 + var_563_20 then
				local var_563_21 = (arg_560_1.time_ - var_563_17) / var_563_20
				local var_563_22 = Vector3.New(390.2, -356, -362.3)

				var_563_16.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos128404, var_563_22, var_563_21)
			end

			if arg_560_1.time_ >= var_563_17 + var_563_20 and arg_560_1.time_ < var_563_17 + var_563_20 + arg_563_0 then
				var_563_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_563_23 = 0
			local var_563_24 = 0.65

			if var_563_23 < arg_560_1.time_ and arg_560_1.time_ <= var_563_23 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_25 = arg_560_1:FormatText(StoryNameCfg[6].name)

				arg_560_1.leftNameTxt_.text = var_563_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_26 = arg_560_1:GetWordFromCfg(938032137)
				local var_563_27 = arg_560_1:FormatText(var_563_26.content)

				arg_560_1.text_.text = var_563_27

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_28 = 26
				local var_563_29 = utf8.len(var_563_27)
				local var_563_30 = var_563_28 <= 0 and var_563_24 or var_563_24 * (var_563_29 / var_563_28)

				if var_563_30 > 0 and var_563_24 < var_563_30 then
					arg_560_1.talkMaxDuration = var_563_30

					if var_563_30 + var_563_23 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_30 + var_563_23
					end
				end

				arg_560_1.text_.text = var_563_27
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_31 = math.max(var_563_24, arg_560_1.talkMaxDuration)

			if var_563_23 <= arg_560_1.time_ and arg_560_1.time_ < var_563_23 + var_563_31 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_23) / var_563_31

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_23 + var_563_31 and arg_560_1.time_ < var_563_23 + var_563_31 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
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

		arg_560_1:InitPlayNodeList()
	end,
	Play938032138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 938032138
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play938032139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["10144"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps10144 == nil then
				arg_564_1.var_.actorSpriteComps10144 = var_567_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_2 = 0.2

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.actorSpriteComps10144 then
					for iter_567_0, iter_567_1 in pairs(arg_564_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_567_1 then
							if arg_564_1.isInRecall_ then
								local var_567_4 = Mathf.Lerp(iter_567_1.color.r, arg_564_1.hightColor1.r, var_567_3)
								local var_567_5 = Mathf.Lerp(iter_567_1.color.g, arg_564_1.hightColor1.g, var_567_3)
								local var_567_6 = Mathf.Lerp(iter_567_1.color.b, arg_564_1.hightColor1.b, var_567_3)

								iter_567_1.color = Color.New(var_567_4, var_567_5, var_567_6)
							else
								local var_567_7 = Mathf.Lerp(iter_567_1.color.r, 1, var_567_3)

								iter_567_1.color = Color.New(var_567_7, var_567_7, var_567_7)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps10144 then
				for iter_567_2, iter_567_3 in pairs(arg_564_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_567_3 then
						if arg_564_1.isInRecall_ then
							iter_567_3.color = arg_564_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_567_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_564_1.var_.actorSpriteComps10144 = nil
			end

			local var_567_8 = arg_564_1.actors_["128404"]
			local var_567_9 = 0

			if var_567_9 < arg_564_1.time_ and arg_564_1.time_ <= var_567_9 + arg_567_0 and not isNil(var_567_8) and arg_564_1.var_.actorSpriteComps128404 == nil then
				arg_564_1.var_.actorSpriteComps128404 = var_567_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_10 = 0.2

			if var_567_9 <= arg_564_1.time_ and arg_564_1.time_ < var_567_9 + var_567_10 and not isNil(var_567_8) then
				local var_567_11 = (arg_564_1.time_ - var_567_9) / var_567_10

				if arg_564_1.var_.actorSpriteComps128404 then
					for iter_567_4, iter_567_5 in pairs(arg_564_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_567_5 then
							if arg_564_1.isInRecall_ then
								local var_567_12 = Mathf.Lerp(iter_567_5.color.r, arg_564_1.hightColor2.r, var_567_11)
								local var_567_13 = Mathf.Lerp(iter_567_5.color.g, arg_564_1.hightColor2.g, var_567_11)
								local var_567_14 = Mathf.Lerp(iter_567_5.color.b, arg_564_1.hightColor2.b, var_567_11)

								iter_567_5.color = Color.New(var_567_12, var_567_13, var_567_14)
							else
								local var_567_15 = Mathf.Lerp(iter_567_5.color.r, 0.5, var_567_11)

								iter_567_5.color = Color.New(var_567_15, var_567_15, var_567_15)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= var_567_9 + var_567_10 and arg_564_1.time_ < var_567_9 + var_567_10 + arg_567_0 and not isNil(var_567_8) and arg_564_1.var_.actorSpriteComps128404 then
				for iter_567_6, iter_567_7 in pairs(arg_564_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_567_7 then
						if arg_564_1.isInRecall_ then
							iter_567_7.color = arg_564_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_567_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_564_1.var_.actorSpriteComps128404 = nil
			end

			local var_567_16 = arg_564_1.actors_["128404"].transform
			local var_567_17 = 0

			if var_567_17 < arg_564_1.time_ and arg_564_1.time_ <= var_567_17 + arg_567_0 then
				arg_564_1.var_.moveOldPos128404 = var_567_16.localPosition
				var_567_16.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("128404", 7)

				local var_567_18 = var_567_16.childCount

				for iter_567_8 = 0, var_567_18 - 1 do
					local var_567_19 = var_567_16:GetChild(iter_567_8)

					if var_567_19.name == "" or not string.find(var_567_19.name, "split") then
						var_567_19.gameObject:SetActive(true)
					else
						var_567_19.gameObject:SetActive(false)
					end
				end
			end

			local var_567_20 = 0.001

			if var_567_17 <= arg_564_1.time_ and arg_564_1.time_ < var_567_17 + var_567_20 then
				local var_567_21 = (arg_564_1.time_ - var_567_17) / var_567_20
				local var_567_22 = Vector3.New(0, -2000, 0)

				var_567_16.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos128404, var_567_22, var_567_21)
			end

			if arg_564_1.time_ >= var_567_17 + var_567_20 and arg_564_1.time_ < var_567_17 + var_567_20 + arg_567_0 then
				var_567_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_567_23 = arg_564_1.actors_["10144"].transform
			local var_567_24 = 0

			if var_567_24 < arg_564_1.time_ and arg_564_1.time_ <= var_567_24 + arg_567_0 then
				arg_564_1.var_.moveOldPos10144 = var_567_23.localPosition
				var_567_23.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("10144", 3)

				local var_567_25 = var_567_23.childCount

				for iter_567_9 = 0, var_567_25 - 1 do
					local var_567_26 = var_567_23:GetChild(iter_567_9)

					if var_567_26.name == "" or not string.find(var_567_26.name, "split") then
						var_567_26.gameObject:SetActive(true)
					else
						var_567_26.gameObject:SetActive(false)
					end
				end
			end

			local var_567_27 = 0.001

			if var_567_24 <= arg_564_1.time_ and arg_564_1.time_ < var_567_24 + var_567_27 then
				local var_567_28 = (arg_564_1.time_ - var_567_24) / var_567_27
				local var_567_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_567_23.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos10144, var_567_29, var_567_28)
			end

			if arg_564_1.time_ >= var_567_24 + var_567_27 and arg_564_1.time_ < var_567_24 + var_567_27 + arg_567_0 then
				var_567_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_567_30 = arg_564_1.actors_["104902"].transform
			local var_567_31 = 0

			if var_567_31 < arg_564_1.time_ and arg_564_1.time_ <= var_567_31 + arg_567_0 then
				arg_564_1.var_.moveOldPos104902 = var_567_30.localPosition
				var_567_30.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("104902", 7)

				local var_567_32 = var_567_30.childCount

				for iter_567_10 = 0, var_567_32 - 1 do
					local var_567_33 = var_567_30:GetChild(iter_567_10)

					if var_567_33.name == "" or not string.find(var_567_33.name, "split") then
						var_567_33.gameObject:SetActive(true)
					else
						var_567_33.gameObject:SetActive(false)
					end
				end
			end

			local var_567_34 = 0.001

			if var_567_31 <= arg_564_1.time_ and arg_564_1.time_ < var_567_31 + var_567_34 then
				local var_567_35 = (arg_564_1.time_ - var_567_31) / var_567_34
				local var_567_36 = Vector3.New(0, -2000, -360)

				var_567_30.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos104902, var_567_36, var_567_35)
			end

			if arg_564_1.time_ >= var_567_31 + var_567_34 and arg_564_1.time_ < var_567_31 + var_567_34 + arg_567_0 then
				var_567_30.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_567_37 = 0
			local var_567_38 = 0.5

			if var_567_37 < arg_564_1.time_ and arg_564_1.time_ <= var_567_37 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_39 = arg_564_1:FormatText(StoryNameCfg[1297].name)

				arg_564_1.leftNameTxt_.text = var_567_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_40 = arg_564_1:GetWordFromCfg(938032138)
				local var_567_41 = arg_564_1:FormatText(var_567_40.content)

				arg_564_1.text_.text = var_567_41

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_42 = 20
				local var_567_43 = utf8.len(var_567_41)
				local var_567_44 = var_567_42 <= 0 and var_567_38 or var_567_38 * (var_567_43 / var_567_42)

				if var_567_44 > 0 and var_567_38 < var_567_44 then
					arg_564_1.talkMaxDuration = var_567_44

					if var_567_44 + var_567_37 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_44 + var_567_37
					end
				end

				arg_564_1.text_.text = var_567_41
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_45 = math.max(var_567_38, arg_564_1.talkMaxDuration)

			if var_567_37 <= arg_564_1.time_ and arg_564_1.time_ < var_567_37 + var_567_45 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_37) / var_567_45

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_37 + var_567_45 and arg_564_1.time_ < var_567_37 + var_567_45 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
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

		arg_564_1:InitPlayNodeList()
	end,
	Play938032139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 938032139
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play938032140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["10144"].transform
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.var_.moveOldPos10144 = var_571_0.localPosition
				var_571_0.localScale = Vector3.New(1, 1, 1)

				arg_568_1:CheckSpriteTmpPos("10144", 3)

				local var_571_2 = var_571_0.childCount

				for iter_571_0 = 0, var_571_2 - 1 do
					local var_571_3 = var_571_0:GetChild(iter_571_0)

					if var_571_3.name == "" or not string.find(var_571_3.name, "split") then
						var_571_3.gameObject:SetActive(true)
					else
						var_571_3.gameObject:SetActive(false)
					end
				end
			end

			local var_571_4 = 0.001

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_4 then
				local var_571_5 = (arg_568_1.time_ - var_571_1) / var_571_4
				local var_571_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_571_0.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos10144, var_571_6, var_571_5)
			end

			if arg_568_1.time_ >= var_571_1 + var_571_4 and arg_568_1.time_ < var_571_1 + var_571_4 + arg_571_0 then
				var_571_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_571_7 = 0
			local var_571_8 = 1.1

			if var_571_7 < arg_568_1.time_ and arg_568_1.time_ <= var_571_7 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_9 = arg_568_1:FormatText(StoryNameCfg[1297].name)

				arg_568_1.leftNameTxt_.text = var_571_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_10 = arg_568_1:GetWordFromCfg(938032139)
				local var_571_11 = arg_568_1:FormatText(var_571_10.content)

				arg_568_1.text_.text = var_571_11

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_12 = 44
				local var_571_13 = utf8.len(var_571_11)
				local var_571_14 = var_571_12 <= 0 and var_571_8 or var_571_8 * (var_571_13 / var_571_12)

				if var_571_14 > 0 and var_571_8 < var_571_14 then
					arg_568_1.talkMaxDuration = var_571_14

					if var_571_14 + var_571_7 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_14 + var_571_7
					end
				end

				arg_568_1.text_.text = var_571_11
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_15 = math.max(var_571_8, arg_568_1.talkMaxDuration)

			if var_571_7 <= arg_568_1.time_ and arg_568_1.time_ < var_571_7 + var_571_15 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_7) / var_571_15

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_7 + var_571_15 and arg_568_1.time_ < var_571_7 + var_571_15 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
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

		arg_568_1:InitPlayNodeList()
	end,
	Play938032140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 938032140
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play938032141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["10144"]
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps10144 == nil then
				arg_572_1.var_.actorSpriteComps10144 = var_575_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_2 = 0.2

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 and not isNil(var_575_0) then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2

				if arg_572_1.var_.actorSpriteComps10144 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								local var_575_4 = Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor2.r, var_575_3)
								local var_575_5 = Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor2.g, var_575_3)
								local var_575_6 = Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor2.b, var_575_3)

								iter_575_1.color = Color.New(var_575_4, var_575_5, var_575_6)
							else
								local var_575_7 = Mathf.Lerp(iter_575_1.color.r, 0.5, var_575_3)

								iter_575_1.color = Color.New(var_575_7, var_575_7, var_575_7)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps10144 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_575_3 then
						if arg_572_1.isInRecall_ then
							iter_575_3.color = arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_575_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_572_1.var_.actorSpriteComps10144 = nil
			end

			local var_575_8 = 0
			local var_575_9 = 0.275

			if var_575_8 < arg_572_1.time_ and arg_572_1.time_ <= var_575_8 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_10 = arg_572_1:FormatText(StoryNameCfg[7].name)

				arg_572_1.leftNameTxt_.text = var_575_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_11 = arg_572_1:GetWordFromCfg(938032140)
				local var_575_12 = arg_572_1:FormatText(var_575_11.content)

				arg_572_1.text_.text = var_575_12

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_13 = 11
				local var_575_14 = utf8.len(var_575_12)
				local var_575_15 = var_575_13 <= 0 and var_575_9 or var_575_9 * (var_575_14 / var_575_13)

				if var_575_15 > 0 and var_575_9 < var_575_15 then
					arg_572_1.talkMaxDuration = var_575_15

					if var_575_15 + var_575_8 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_15 + var_575_8
					end
				end

				arg_572_1.text_.text = var_575_12
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_16 = math.max(var_575_9, arg_572_1.talkMaxDuration)

			if var_575_8 <= arg_572_1.time_ and arg_572_1.time_ < var_575_8 + var_575_16 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_8) / var_575_16

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_8 + var_575_16 and arg_572_1.time_ < var_575_8 + var_575_16 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play938032141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 938032141
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play938032142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["10144"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps10144 == nil then
				arg_576_1.var_.actorSpriteComps10144 = var_579_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_2 = 0.2

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.actorSpriteComps10144 then
					for iter_579_0, iter_579_1 in pairs(arg_576_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_579_1 then
							if arg_576_1.isInRecall_ then
								local var_579_4 = Mathf.Lerp(iter_579_1.color.r, arg_576_1.hightColor1.r, var_579_3)
								local var_579_5 = Mathf.Lerp(iter_579_1.color.g, arg_576_1.hightColor1.g, var_579_3)
								local var_579_6 = Mathf.Lerp(iter_579_1.color.b, arg_576_1.hightColor1.b, var_579_3)

								iter_579_1.color = Color.New(var_579_4, var_579_5, var_579_6)
							else
								local var_579_7 = Mathf.Lerp(iter_579_1.color.r, 1, var_579_3)

								iter_579_1.color = Color.New(var_579_7, var_579_7, var_579_7)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps10144 then
				for iter_579_2, iter_579_3 in pairs(arg_576_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_579_3 then
						if arg_576_1.isInRecall_ then
							iter_579_3.color = arg_576_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_579_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_576_1.var_.actorSpriteComps10144 = nil
			end

			local var_579_8 = arg_576_1.actors_["10144"].transform
			local var_579_9 = 0

			if var_579_9 < arg_576_1.time_ and arg_576_1.time_ <= var_579_9 + arg_579_0 then
				arg_576_1.var_.moveOldPos10144 = var_579_8.localPosition
				var_579_8.localScale = Vector3.New(1, 1, 1)

				arg_576_1:CheckSpriteTmpPos("10144", 3)

				local var_579_10 = var_579_8.childCount

				for iter_579_4 = 0, var_579_10 - 1 do
					local var_579_11 = var_579_8:GetChild(iter_579_4)

					if var_579_11.name == "split_7" or not string.find(var_579_11.name, "split") then
						var_579_11.gameObject:SetActive(true)
					else
						var_579_11.gameObject:SetActive(false)
					end
				end
			end

			local var_579_12 = 0.001

			if var_579_9 <= arg_576_1.time_ and arg_576_1.time_ < var_579_9 + var_579_12 then
				local var_579_13 = (arg_576_1.time_ - var_579_9) / var_579_12
				local var_579_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_579_8.localPosition = Vector3.Lerp(arg_576_1.var_.moveOldPos10144, var_579_14, var_579_13)
			end

			if arg_576_1.time_ >= var_579_9 + var_579_12 and arg_576_1.time_ < var_579_9 + var_579_12 + arg_579_0 then
				var_579_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_579_15 = 0
			local var_579_16 = 0.725

			if var_579_15 < arg_576_1.time_ and arg_576_1.time_ <= var_579_15 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_17 = arg_576_1:FormatText(StoryNameCfg[1297].name)

				arg_576_1.leftNameTxt_.text = var_579_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_18 = arg_576_1:GetWordFromCfg(938032141)
				local var_579_19 = arg_576_1:FormatText(var_579_18.content)

				arg_576_1.text_.text = var_579_19

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_20 = 29
				local var_579_21 = utf8.len(var_579_19)
				local var_579_22 = var_579_20 <= 0 and var_579_16 or var_579_16 * (var_579_21 / var_579_20)

				if var_579_22 > 0 and var_579_16 < var_579_22 then
					arg_576_1.talkMaxDuration = var_579_22

					if var_579_22 + var_579_15 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_22 + var_579_15
					end
				end

				arg_576_1.text_.text = var_579_19
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_23 = math.max(var_579_16, arg_576_1.talkMaxDuration)

			if var_579_15 <= arg_576_1.time_ and arg_576_1.time_ < var_579_15 + var_579_23 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_15) / var_579_23

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_15 + var_579_23 and arg_576_1.time_ < var_579_15 + var_579_23 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {
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

		arg_576_1:InitPlayNodeList()
	end,
	Play938032142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 938032142
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play938032143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["10144"].transform
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.var_.moveOldPos10144 = var_583_0.localPosition
				var_583_0.localScale = Vector3.New(1, 1, 1)

				arg_580_1:CheckSpriteTmpPos("10144", 3)

				local var_583_2 = var_583_0.childCount

				for iter_583_0 = 0, var_583_2 - 1 do
					local var_583_3 = var_583_0:GetChild(iter_583_0)

					if var_583_3.name == "" then
						var_583_3:SetAsLastSibling()
						var_583_3.gameObject:SetActive(true)

						arg_580_1.var_.actorSpriteSplit10144 = var_583_3.gameObject:GetComponent(typeof(Image))

						arg_580_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_583_4 = 0.5

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_4 then
				local var_583_5 = (arg_580_1.time_ - var_583_1) / var_583_4
				local var_583_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_583_0.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos10144, var_583_6, var_583_5)

				if arg_580_1.var_.actorSpriteSplit10144 ~= nil then
					arg_580_1.var_.actorSpriteSplit10144:SetAlpha(var_583_5)
				end
			end

			if arg_580_1.time_ >= var_583_1 + var_583_4 and arg_580_1.time_ < var_583_1 + var_583_4 + arg_583_0 then
				var_583_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_580_1.var_.actorSpriteSplit10144 ~= nil then
					arg_580_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_583_7 = 0
			local var_583_8 = 0.325

			if var_583_7 < arg_580_1.time_ and arg_580_1.time_ <= var_583_7 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_9 = arg_580_1:FormatText(StoryNameCfg[1297].name)

				arg_580_1.leftNameTxt_.text = var_583_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_10 = arg_580_1:GetWordFromCfg(938032142)
				local var_583_11 = arg_580_1:FormatText(var_583_10.content)

				arg_580_1.text_.text = var_583_11

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_12 = 13
				local var_583_13 = utf8.len(var_583_11)
				local var_583_14 = var_583_12 <= 0 and var_583_8 or var_583_8 * (var_583_13 / var_583_12)

				if var_583_14 > 0 and var_583_8 < var_583_14 then
					arg_580_1.talkMaxDuration = var_583_14

					if var_583_14 + var_583_7 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_14 + var_583_7
					end
				end

				arg_580_1.text_.text = var_583_11
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_15 = math.max(var_583_8, arg_580_1.talkMaxDuration)

			if var_583_7 <= arg_580_1.time_ and arg_580_1.time_ < var_583_7 + var_583_15 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_7) / var_583_15

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_7 + var_583_15 and arg_580_1.time_ < var_583_7 + var_583_15 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
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

		arg_580_1:InitPlayNodeList()
	end,
	Play938032143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 938032143
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play938032144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["10144"]
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.actorSpriteComps10144 == nil then
				arg_584_1.var_.actorSpriteComps10144 = var_587_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_587_2 = 0.2

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 and not isNil(var_587_0) then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2

				if arg_584_1.var_.actorSpriteComps10144 then
					for iter_587_0, iter_587_1 in pairs(arg_584_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_587_1 then
							if arg_584_1.isInRecall_ then
								local var_587_4 = Mathf.Lerp(iter_587_1.color.r, arg_584_1.hightColor2.r, var_587_3)
								local var_587_5 = Mathf.Lerp(iter_587_1.color.g, arg_584_1.hightColor2.g, var_587_3)
								local var_587_6 = Mathf.Lerp(iter_587_1.color.b, arg_584_1.hightColor2.b, var_587_3)

								iter_587_1.color = Color.New(var_587_4, var_587_5, var_587_6)
							else
								local var_587_7 = Mathf.Lerp(iter_587_1.color.r, 0.5, var_587_3)

								iter_587_1.color = Color.New(var_587_7, var_587_7, var_587_7)
							end
						end
					end
				end
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.actorSpriteComps10144 then
				for iter_587_2, iter_587_3 in pairs(arg_584_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_587_3 then
						if arg_584_1.isInRecall_ then
							iter_587_3.color = arg_584_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_587_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_584_1.var_.actorSpriteComps10144 = nil
			end

			local var_587_8 = arg_584_1.actors_["10144"].transform
			local var_587_9 = 0

			if var_587_9 < arg_584_1.time_ and arg_584_1.time_ <= var_587_9 + arg_587_0 then
				arg_584_1.var_.moveOldPos10144 = var_587_8.localPosition
				var_587_8.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("10144", 7)

				local var_587_10 = var_587_8.childCount

				for iter_587_4 = 0, var_587_10 - 1 do
					local var_587_11 = var_587_8:GetChild(iter_587_4)

					if var_587_11.name == "" or not string.find(var_587_11.name, "split") then
						var_587_11.gameObject:SetActive(true)
					else
						var_587_11.gameObject:SetActive(false)
					end
				end
			end

			local var_587_12 = 0.001

			if var_587_9 <= arg_584_1.time_ and arg_584_1.time_ < var_587_9 + var_587_12 then
				local var_587_13 = (arg_584_1.time_ - var_587_9) / var_587_12
				local var_587_14 = Vector3.New(0, -2000, 0)

				var_587_8.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10144, var_587_14, var_587_13)
			end

			if arg_584_1.time_ >= var_587_9 + var_587_12 and arg_584_1.time_ < var_587_9 + var_587_12 + arg_587_0 then
				var_587_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_587_15 = 0
			local var_587_16 = 1.25

			if var_587_15 < arg_584_1.time_ and arg_584_1.time_ <= var_587_15 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_17 = arg_584_1:GetWordFromCfg(938032143)
				local var_587_18 = arg_584_1:FormatText(var_587_17.content)

				arg_584_1.text_.text = var_587_18

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_19 = 50
				local var_587_20 = utf8.len(var_587_18)
				local var_587_21 = var_587_19 <= 0 and var_587_16 or var_587_16 * (var_587_20 / var_587_19)

				if var_587_21 > 0 and var_587_16 < var_587_21 then
					arg_584_1.talkMaxDuration = var_587_21

					if var_587_21 + var_587_15 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_21 + var_587_15
					end
				end

				arg_584_1.text_.text = var_587_18
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_22 = math.max(var_587_16, arg_584_1.talkMaxDuration)

			if var_587_15 <= arg_584_1.time_ and arg_584_1.time_ < var_587_15 + var_587_22 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_15) / var_587_22

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_15 + var_587_22 and arg_584_1.time_ < var_587_15 + var_587_22 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play938032144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 938032144
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
			arg_588_1.auto_ = false
		end

		function arg_588_1.playNext_(arg_590_0)
			arg_588_1.onStoryFinished_()
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["104902"]
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps104902 == nil then
				arg_588_1.var_.actorSpriteComps104902 = var_591_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_2 = 0.2

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 and not isNil(var_591_0) then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2

				if arg_588_1.var_.actorSpriteComps104902 then
					for iter_591_0, iter_591_1 in pairs(arg_588_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_591_1 then
							if arg_588_1.isInRecall_ then
								local var_591_4 = Mathf.Lerp(iter_591_1.color.r, arg_588_1.hightColor1.r, var_591_3)
								local var_591_5 = Mathf.Lerp(iter_591_1.color.g, arg_588_1.hightColor1.g, var_591_3)
								local var_591_6 = Mathf.Lerp(iter_591_1.color.b, arg_588_1.hightColor1.b, var_591_3)

								iter_591_1.color = Color.New(var_591_4, var_591_5, var_591_6)
							else
								local var_591_7 = Mathf.Lerp(iter_591_1.color.r, 1, var_591_3)

								iter_591_1.color = Color.New(var_591_7, var_591_7, var_591_7)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps104902 then
				for iter_591_2, iter_591_3 in pairs(arg_588_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_591_3 then
						if arg_588_1.isInRecall_ then
							iter_591_3.color = arg_588_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_591_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_588_1.var_.actorSpriteComps104902 = nil
			end

			local var_591_8 = arg_588_1.actors_["104902"].transform
			local var_591_9 = 0

			if var_591_9 < arg_588_1.time_ and arg_588_1.time_ <= var_591_9 + arg_591_0 then
				arg_588_1.var_.moveOldPos104902 = var_591_8.localPosition
				var_591_8.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("104902", 3)

				local var_591_10 = var_591_8.childCount

				for iter_591_4 = 0, var_591_10 - 1 do
					local var_591_11 = var_591_8:GetChild(iter_591_4)

					if var_591_11.name == "split_2" or not string.find(var_591_11.name, "split") then
						var_591_11.gameObject:SetActive(true)
					else
						var_591_11.gameObject:SetActive(false)
					end
				end
			end

			local var_591_12 = 0.001

			if var_591_9 <= arg_588_1.time_ and arg_588_1.time_ < var_591_9 + var_591_12 then
				local var_591_13 = (arg_588_1.time_ - var_591_9) / var_591_12
				local var_591_14 = Vector3.New(0, -335, -360)

				var_591_8.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos104902, var_591_14, var_591_13)
			end

			if arg_588_1.time_ >= var_591_9 + var_591_12 and arg_588_1.time_ < var_591_9 + var_591_12 + arg_591_0 then
				var_591_8.localPosition = Vector3.New(0, -335, -360)
			end

			local var_591_15 = 0
			local var_591_16 = 0.725

			if var_591_15 < arg_588_1.time_ and arg_588_1.time_ <= var_591_15 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_17 = arg_588_1:FormatText(StoryNameCfg[562].name)

				arg_588_1.leftNameTxt_.text = var_591_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_18 = arg_588_1:GetWordFromCfg(938032144)
				local var_591_19 = arg_588_1:FormatText(var_591_18.content)

				arg_588_1.text_.text = var_591_19

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_20 = 29
				local var_591_21 = utf8.len(var_591_19)
				local var_591_22 = var_591_20 <= 0 and var_591_16 or var_591_16 * (var_591_21 / var_591_20)

				if var_591_22 > 0 and var_591_16 < var_591_22 then
					arg_588_1.talkMaxDuration = var_591_22

					if var_591_22 + var_591_15 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_22 + var_591_15
					end
				end

				arg_588_1.text_.text = var_591_19
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_23 = math.max(var_591_16, arg_588_1.talkMaxDuration)

			if var_591_15 <= arg_588_1.time_ and arg_588_1.time_ < var_591_15 + var_591_23 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_15) / var_591_23

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_15 + var_591_23 and arg_588_1.time_ < var_591_15 + var_591_23 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
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

		arg_588_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
