return {
	Play925131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 925131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play925131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.1

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I06f"

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
				local var_4_7 = arg_1_1.bgs_.I06f

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
					if iter_4_0 ~= "I06f" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.233333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_36 = 2
			local var_4_37 = 0.2

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(925131001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 8
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play925131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 925131002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play925131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1011"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1011")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["1011"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1011 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1011", 3)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_1" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(0, -390, 270)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1011, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -390, 270)
			end

			local var_12_11 = arg_9_1.actors_["1011"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1011 == nil then
				arg_9_1.var_.actorSpriteComps1011 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 0.2

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps1011 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_15 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, var_12_14)
								local var_12_16 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, var_12_14)
								local var_12_17 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, var_12_14)

								iter_12_4.color = Color.New(var_12_15, var_12_16, var_12_17)
							else
								local var_12_18 = Mathf.Lerp(iter_12_4.color.r, 1, var_12_14)

								iter_12_4.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1011 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1011 = nil
			end

			local var_12_19 = 0
			local var_12_20 = 0.666666666666667

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[37].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(925131002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 13
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_27 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_27 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_27

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_27 and arg_9_1.time_ < var_12_19 + var_12_27 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play925131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 925131003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play925131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1011"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1011 == nil then
				arg_13_1.var_.actorSpriteComps1011 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1011 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 0.5, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1011 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1011 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.275

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(925131003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 21
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play925131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 925131004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play925131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1011"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1011 == nil then
				arg_17_1.var_.actorSpriteComps1011 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1011 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1011 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1011 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.425

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[37].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(925131004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 17
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_9 or var_20_9 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_9 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play925131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 925131005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play925131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1011"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1011 == nil then
				arg_21_1.var_.actorSpriteComps1011 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1011 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1011 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1011 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.1

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_11 = arg_21_1:GetWordFromCfg(925131005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 4
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play925131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 925131006
		arg_25_1.duration_ = 7.87

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play925131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.36666666666667

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_1 = manager.ui.mainCamera.transform.localPosition
				local var_28_2 = Vector3.New(0, 0, 10) + Vector3.New(var_28_1.x, var_28_1.y, 0)
				local var_28_3 = arg_25_1.bgs_.I06f

				var_28_3.transform.localPosition = var_28_2
				var_28_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_4 = var_28_3:GetComponent("SpriteRenderer")

				if var_28_4 and var_28_4.sprite then
					local var_28_5 = (var_28_3.transform.localPosition - var_28_1).z
					local var_28_6 = manager.ui.mainCameraCom_
					local var_28_7 = 2 * var_28_5 * Mathf.Tan(var_28_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_8 = var_28_7 * var_28_6.aspect
					local var_28_9 = var_28_4.sprite.bounds.size.x
					local var_28_10 = var_28_4.sprite.bounds.size.y
					local var_28_11 = var_28_8 / var_28_9
					local var_28_12 = var_28_7 / var_28_10
					local var_28_13 = var_28_12 < var_28_11 and var_28_11 or var_28_12

					var_28_3.transform.localScale = Vector3.New(var_28_13, var_28_13, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "I06f" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_15 = 1.36666666666667

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_15 then
				local var_28_16 = (arg_25_1.time_ - var_28_14) / var_28_15
				local var_28_17 = Color.New(0, 0, 0)

				var_28_17.a = Mathf.Lerp(0, 1, var_28_16)
				arg_25_1.mask_.color = var_28_17
			end

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 then
				local var_28_18 = Color.New(0, 0, 0)

				var_28_18.a = 1
				arg_25_1.mask_.color = var_28_18
			end

			local var_28_19 = 1.36666666666667

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_20 = 1.5

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20
				local var_28_22 = Color.New(0, 0, 0)

				var_28_22.a = Mathf.Lerp(1, 0, var_28_21)
				arg_25_1.mask_.color = var_28_22
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 then
				local var_28_23 = Color.New(0, 0, 0)
				local var_28_24 = 0

				arg_25_1.mask_.enabled = false
				var_28_23.a = var_28_24
				arg_25_1.mask_.color = var_28_23
			end

			local var_28_25 = arg_25_1.actors_["1011"].transform
			local var_28_26 = 1.33266666666667

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				arg_25_1.var_.moveOldPos1011 = var_28_25.localPosition
				var_28_25.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1011", 7)

				local var_28_27 = var_28_25.childCount

				for iter_28_2 = 0, var_28_27 - 1 do
					local var_28_28 = var_28_25:GetChild(iter_28_2)

					if var_28_28.name == "split_1" or not string.find(var_28_28.name, "split") then
						var_28_28.gameObject:SetActive(true)
					else
						var_28_28.gameObject:SetActive(false)
					end
				end
			end

			local var_28_29 = 0.001

			if var_28_26 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_29 then
				local var_28_30 = (arg_25_1.time_ - var_28_26) / var_28_29
				local var_28_31 = Vector3.New(0, -2000, 0)

				var_28_25.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1011, var_28_31, var_28_30)
			end

			if arg_25_1.time_ >= var_28_26 + var_28_29 and arg_25_1.time_ < var_28_26 + var_28_29 + arg_28_0 then
				var_28_25.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_32 = arg_25_1.actors_["1011"].transform
			local var_28_33 = 2.66666666666667

			if var_28_33 < arg_25_1.time_ and arg_25_1.time_ <= var_28_33 + arg_28_0 then
				arg_25_1.var_.moveOldPos1011 = var_28_32.localPosition
				var_28_32.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1011", 3)

				local var_28_34 = var_28_32.childCount

				for iter_28_3 = 0, var_28_34 - 1 do
					local var_28_35 = var_28_32:GetChild(iter_28_3)

					if var_28_35.name == "split_5" or not string.find(var_28_35.name, "split") then
						var_28_35.gameObject:SetActive(true)
					else
						var_28_35.gameObject:SetActive(false)
					end
				end
			end

			local var_28_36 = 0.001

			if var_28_33 <= arg_25_1.time_ and arg_25_1.time_ < var_28_33 + var_28_36 then
				local var_28_37 = (arg_25_1.time_ - var_28_33) / var_28_36
				local var_28_38 = Vector3.New(0, -390, 270)

				var_28_32.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1011, var_28_38, var_28_37)
			end

			if arg_25_1.time_ >= var_28_33 + var_28_36 and arg_25_1.time_ < var_28_33 + var_28_36 + arg_28_0 then
				var_28_32.localPosition = Vector3.New(0, -390, 270)
			end

			local var_28_39 = arg_25_1.actors_["1011"]
			local var_28_40 = 2.66666666666667

			if var_28_40 < arg_25_1.time_ and arg_25_1.time_ <= var_28_40 + arg_28_0 and not isNil(var_28_39) and arg_25_1.var_.actorSpriteComps1011 == nil then
				arg_25_1.var_.actorSpriteComps1011 = var_28_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_41 = 0.133333330353101

			if var_28_40 <= arg_25_1.time_ and arg_25_1.time_ < var_28_40 + var_28_41 and not isNil(var_28_39) then
				local var_28_42 = (arg_25_1.time_ - var_28_40) / var_28_41

				if arg_25_1.var_.actorSpriteComps1011 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_43 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor1.r, var_28_42)
								local var_28_44 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor1.g, var_28_42)
								local var_28_45 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor1.b, var_28_42)

								iter_28_5.color = Color.New(var_28_43, var_28_44, var_28_45)
							else
								local var_28_46 = Mathf.Lerp(iter_28_5.color.r, 1, var_28_42)

								iter_28_5.color = Color.New(var_28_46, var_28_46, var_28_46)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_40 + var_28_41 and arg_25_1.time_ < var_28_40 + var_28_41 + arg_28_0 and not isNil(var_28_39) and arg_25_1.var_.actorSpriteComps1011 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1011 = nil
			end

			local var_28_47 = arg_25_1.actors_["1011"]
			local var_28_48 = 2.66666666666667

			if var_28_48 < arg_25_1.time_ and arg_25_1.time_ <= var_28_48 + arg_28_0 then
				local var_28_49 = var_28_47:GetComponentInChildren(typeof(CanvasGroup))

				if var_28_49 then
					arg_25_1.var_.alphaOldValue1011 = var_28_49.alpha
					arg_25_1.var_.characterEffect1011 = var_28_49
				end

				arg_25_1.var_.alphaOldValue1011 = 0
			end

			local var_28_50 = 0.2

			if var_28_48 <= arg_25_1.time_ and arg_25_1.time_ < var_28_48 + var_28_50 then
				local var_28_51 = (arg_25_1.time_ - var_28_48) / var_28_50
				local var_28_52 = Mathf.Lerp(arg_25_1.var_.alphaOldValue1011, 1, var_28_51)

				if arg_25_1.var_.characterEffect1011 then
					arg_25_1.var_.characterEffect1011.alpha = var_28_52
				end
			end

			if arg_25_1.time_ >= var_28_48 + var_28_50 and arg_25_1.time_ < var_28_48 + var_28_50 + arg_28_0 and arg_25_1.var_.characterEffect1011 then
				arg_25_1.var_.characterEffect1011.alpha = 1
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_53 = 2.86666666666667
			local var_28_54 = 0.433333330353101

			if var_28_53 < arg_25_1.time_ and arg_25_1.time_ <= var_28_53 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_55 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_55:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_56 = arg_25_1:FormatText(StoryNameCfg[37].name)

				arg_25_1.leftNameTxt_.text = var_28_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_57 = arg_25_1:GetWordFromCfg(925131006)
				local var_28_58 = arg_25_1:FormatText(var_28_57.content)

				arg_25_1.text_.text = var_28_58

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_59 = 8
				local var_28_60 = utf8.len(var_28_58)
				local var_28_61 = var_28_59 <= 0 and var_28_54 or var_28_54 * (var_28_60 / var_28_59)

				if var_28_61 > 0 and var_28_54 < var_28_61 then
					arg_25_1.talkMaxDuration = var_28_61
					var_28_53 = var_28_53 + 0.3

					if var_28_61 + var_28_53 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_61 + var_28_53
					end
				end

				arg_25_1.text_.text = var_28_58
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_62 = var_28_53 + 0.3
			local var_28_63 = math.max(var_28_54, arg_25_1.talkMaxDuration)

			if var_28_62 <= arg_25_1.time_ and arg_25_1.time_ < var_28_62 + var_28_63 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_62) / var_28_63

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_62 + var_28_63 and arg_25_1.time_ < var_28_62 + var_28_63 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.33266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play925131007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 925131007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play925131008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1011"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1011 == nil then
				arg_31_1.var_.actorSpriteComps1011 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps1011 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1011:ToTable()) do
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

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1011 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_34_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps1011 = nil
			end

			local var_34_8 = 0
			local var_34_9 = 0.625

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_10 = arg_31_1:FormatText(StoryNameCfg[7].name)

				arg_31_1.leftNameTxt_.text = var_34_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_11 = arg_31_1:GetWordFromCfg(925131007)
				local var_34_12 = arg_31_1:FormatText(var_34_11.content)

				arg_31_1.text_.text = var_34_12

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 25
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
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play925131008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 925131008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play925131009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.525

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(925131008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 21
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
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play925131009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 925131009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play925131010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1011"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1011 == nil then
				arg_39_1.var_.actorSpriteComps1011 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1011 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 1, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1011 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1011 = nil
			end

			local var_42_8 = arg_39_1.actors_["1011"].transform
			local var_42_9 = 0

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.var_.moveOldPos1011 = var_42_8.localPosition
				var_42_8.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1011", 3)

				local var_42_10 = var_42_8.childCount

				for iter_42_4 = 0, var_42_10 - 1 do
					local var_42_11 = var_42_8:GetChild(iter_42_4)

					if var_42_11.name == "split_1" or not string.find(var_42_11.name, "split") then
						var_42_11.gameObject:SetActive(true)
					else
						var_42_11.gameObject:SetActive(false)
					end
				end
			end

			local var_42_12 = 0.001

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_12 then
				local var_42_13 = (arg_39_1.time_ - var_42_9) / var_42_12
				local var_42_14 = Vector3.New(0, -390, 270)

				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1011, var_42_14, var_42_13)
			end

			if arg_39_1.time_ >= var_42_9 + var_42_12 and arg_39_1.time_ < var_42_9 + var_42_12 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(0, -390, 270)
			end

			local var_42_15 = 0
			local var_42_16 = 0.25

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[37].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(925131009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 10
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_23 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_23 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_23

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_23 and arg_39_1.time_ < var_42_15 + var_42_23 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
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
	Play925131010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 925131010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play925131011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1011"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1011 == nil then
				arg_43_1.var_.actorSpriteComps1011 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1011 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 0.5, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1011 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1011 = nil
			end

			local var_46_8 = 0
			local var_46_9 = 0.25

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_10 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_11 = arg_43_1:GetWordFromCfg(925131010)
				local var_46_12 = arg_43_1:FormatText(var_46_11.content)

				arg_43_1.text_.text = var_46_12

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 10
				local var_46_14 = utf8.len(var_46_12)
				local var_46_15 = var_46_13 <= 0 and var_46_9 or var_46_9 * (var_46_14 / var_46_13)

				if var_46_15 > 0 and var_46_9 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_12
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play925131011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 925131011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play925131012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1011"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1011 == nil then
				arg_47_1.var_.actorSpriteComps1011 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps1011 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor1.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor1.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor1.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 1, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1011 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1011 = nil
			end

			local var_50_8 = arg_47_1.actors_["1011"].transform
			local var_50_9 = 0

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.var_.moveOldPos1011 = var_50_8.localPosition
				var_50_8.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1011", 3)

				local var_50_10 = var_50_8.childCount

				for iter_50_4 = 0, var_50_10 - 1 do
					local var_50_11 = var_50_8:GetChild(iter_50_4)

					if var_50_11.name == "split_1" or not string.find(var_50_11.name, "split") then
						var_50_11.gameObject:SetActive(true)
					else
						var_50_11.gameObject:SetActive(false)
					end
				end
			end

			local var_50_12 = 0.001

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_12 then
				local var_50_13 = (arg_47_1.time_ - var_50_9) / var_50_12
				local var_50_14 = Vector3.New(0, -390, 270)

				var_50_8.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1011, var_50_14, var_50_13)
			end

			if arg_47_1.time_ >= var_50_9 + var_50_12 and arg_47_1.time_ < var_50_9 + var_50_12 + arg_50_0 then
				var_50_8.localPosition = Vector3.New(0, -390, 270)
			end

			local var_50_15 = 0
			local var_50_16 = 0.575

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_17 = arg_47_1:FormatText(StoryNameCfg[37].name)

				arg_47_1.leftNameTxt_.text = var_50_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_18 = arg_47_1:GetWordFromCfg(925131011)
				local var_50_19 = arg_47_1:FormatText(var_50_18.content)

				arg_47_1.text_.text = var_50_19

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_20 = 23
				local var_50_21 = utf8.len(var_50_19)
				local var_50_22 = var_50_20 <= 0 and var_50_16 or var_50_16 * (var_50_21 / var_50_20)

				if var_50_22 > 0 and var_50_16 < var_50_22 then
					arg_47_1.talkMaxDuration = var_50_22

					if var_50_22 + var_50_15 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_22 + var_50_15
					end
				end

				arg_47_1.text_.text = var_50_19
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_23 = math.max(var_50_16, arg_47_1.talkMaxDuration)

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_23 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_15) / var_50_23

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_15 + var_50_23 and arg_47_1.time_ < var_50_15 + var_50_23 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play925131012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 925131012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play925131013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1011"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1011 == nil then
				arg_51_1.var_.actorSpriteComps1011 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1011 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 0.5, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1011 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1011 = nil
			end

			local var_54_8 = 0
			local var_54_9 = 0.5

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_10 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_11 = arg_51_1:GetWordFromCfg(925131012)
				local var_54_12 = arg_51_1:FormatText(var_54_11.content)

				arg_51_1.text_.text = var_54_12

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 20
				local var_54_14 = utf8.len(var_54_12)
				local var_54_15 = var_54_13 <= 0 and var_54_9 or var_54_9 * (var_54_14 / var_54_13)

				if var_54_15 > 0 and var_54_9 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_12
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play925131013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 925131013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play925131014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1011"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1011 == nil then
				arg_55_1.var_.actorSpriteComps1011 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps1011 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 1, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1011 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1011 = nil
			end

			local var_58_8 = arg_55_1.actors_["1011"].transform
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.var_.moveOldPos1011 = var_58_8.localPosition
				var_58_8.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1011", 3)

				local var_58_10 = var_58_8.childCount

				for iter_58_4 = 0, var_58_10 - 1 do
					local var_58_11 = var_58_8:GetChild(iter_58_4)

					if var_58_11.name == "split_2" or not string.find(var_58_11.name, "split") then
						var_58_11.gameObject:SetActive(true)
					else
						var_58_11.gameObject:SetActive(false)
					end
				end
			end

			local var_58_12 = 0.001

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_9) / var_58_12
				local var_58_14 = Vector3.New(0, -390, 270)

				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1011, var_58_14, var_58_13)
			end

			if arg_55_1.time_ >= var_58_9 + var_58_12 and arg_55_1.time_ < var_58_9 + var_58_12 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(0, -390, 270)
			end

			local var_58_15 = 0
			local var_58_16 = 0.375

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[37].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(925131013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 15
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_23 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_23 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_23

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_23 and arg_55_1.time_ < var_58_15 + var_58_23 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play925131014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 925131014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play925131015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1011"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1011 == nil then
				arg_59_1.var_.actorSpriteComps1011 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps1011 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 0.5, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1011 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1011 = nil
			end

			local var_62_8 = 0
			local var_62_9 = 0.225

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_10 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_11 = arg_59_1:GetWordFromCfg(925131014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 9
				local var_62_14 = utf8.len(var_62_12)
				local var_62_15 = var_62_13 <= 0 and var_62_9 or var_62_9 * (var_62_14 / var_62_13)

				if var_62_15 > 0 and var_62_9 < var_62_15 then
					arg_59_1.talkMaxDuration = var_62_15

					if var_62_15 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play925131015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 925131015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play925131016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1011"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1011 == nil then
				arg_63_1.var_.actorSpriteComps1011 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps1011 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1011 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1011 = nil
			end

			local var_66_8 = arg_63_1.actors_["1011"].transform
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.var_.moveOldPos1011 = var_66_8.localPosition
				var_66_8.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1011", 3)

				local var_66_10 = var_66_8.childCount

				for iter_66_4 = 0, var_66_10 - 1 do
					local var_66_11 = var_66_8:GetChild(iter_66_4)

					if var_66_11.name == "split_1" or not string.find(var_66_11.name, "split") then
						var_66_11.gameObject:SetActive(true)
					else
						var_66_11.gameObject:SetActive(false)
					end
				end
			end

			local var_66_12 = 0.001

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_12 then
				local var_66_13 = (arg_63_1.time_ - var_66_9) / var_66_12
				local var_66_14 = Vector3.New(0, -390, 270)

				var_66_8.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1011, var_66_14, var_66_13)
			end

			if arg_63_1.time_ >= var_66_9 + var_66_12 and arg_63_1.time_ < var_66_9 + var_66_12 + arg_66_0 then
				var_66_8.localPosition = Vector3.New(0, -390, 270)
			end

			local var_66_15 = 0
			local var_66_16 = 0.0329999998211861

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[37].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(925131015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 7
				local var_66_21 = utf8.len(var_66_19)
				local var_66_22 = var_66_20 <= 0 and var_66_16 or var_66_16 * (var_66_21 / var_66_20)

				if var_66_22 > 0 and var_66_16 < var_66_22 then
					arg_63_1.talkMaxDuration = var_66_22

					if var_66_22 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_22 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_23 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_23 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_23

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_23 and arg_63_1.time_ < var_66_15 + var_66_23 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play925131016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 925131016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play925131017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1011"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1011 == nil then
				arg_67_1.var_.actorSpriteComps1011 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps1011 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								local var_70_4 = Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, var_70_3)
								local var_70_5 = Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, var_70_3)
								local var_70_6 = Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, var_70_3)

								iter_70_1.color = Color.New(var_70_4, var_70_5, var_70_6)
							else
								local var_70_7 = Mathf.Lerp(iter_70_1.color.r, 0.5, var_70_3)

								iter_70_1.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1011 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1011 = nil
			end

			local var_70_8 = 0
			local var_70_9 = 0.0329999998211861

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_10 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_11 = arg_67_1:GetWordFromCfg(925131016)
				local var_70_12 = arg_67_1:FormatText(var_70_11.content)

				arg_67_1.text_.text = var_70_12

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 12
				local var_70_14 = utf8.len(var_70_12)
				local var_70_15 = var_70_13 <= 0 and var_70_9 or var_70_9 * (var_70_14 / var_70_13)

				if var_70_15 > 0 and var_70_9 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_12
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play925131017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 925131017
		arg_71_1.duration_ = 5.5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play925131018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1011"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1011 == nil then
				arg_71_1.var_.actorSpriteComps1011 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps1011 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								local var_74_4 = Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor1.r, var_74_3)
								local var_74_5 = Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor1.g, var_74_3)
								local var_74_6 = Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor1.b, var_74_3)

								iter_74_1.color = Color.New(var_74_4, var_74_5, var_74_6)
							else
								local var_74_7 = Mathf.Lerp(iter_74_1.color.r, 1, var_74_3)

								iter_74_1.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1011 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_74_3 then
						if arg_71_1.isInRecall_ then
							iter_74_3.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1011 = nil
			end

			local var_74_8 = arg_71_1.actors_["1011"].transform
			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.var_.moveOldPos1011 = var_74_8.localPosition
				var_74_8.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1011", 3)

				local var_74_10 = var_74_8.childCount

				for iter_74_4 = 0, var_74_10 - 1 do
					local var_74_11 = var_74_8:GetChild(iter_74_4)

					if var_74_11.name == "split_1" or not string.find(var_74_11.name, "split") then
						var_74_11.gameObject:SetActive(true)
					else
						var_74_11.gameObject:SetActive(false)
					end
				end
			end

			local var_74_12 = 0.001

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_12 then
				local var_74_13 = (arg_71_1.time_ - var_74_9) / var_74_12
				local var_74_14 = Vector3.New(0, -390, 270)

				var_74_8.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1011, var_74_14, var_74_13)
			end

			if arg_71_1.time_ >= var_74_9 + var_74_12 and arg_71_1.time_ < var_74_9 + var_74_12 + arg_74_0 then
				var_74_8.localPosition = Vector3.New(0, -390, 270)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_15 = 0.5
			local var_74_16 = 0.0329999998211861

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_17 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_17:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_18 = arg_71_1:FormatText(StoryNameCfg[37].name)

				arg_71_1.leftNameTxt_.text = var_74_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_19 = arg_71_1:GetWordFromCfg(925131017)
				local var_74_20 = arg_71_1:FormatText(var_74_19.content)

				arg_71_1.text_.text = var_74_20

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_21 = 16
				local var_74_22 = utf8.len(var_74_20)
				local var_74_23 = var_74_21 <= 0 and var_74_16 or var_74_16 * (var_74_22 / var_74_21)

				if var_74_23 > 0 and var_74_16 < var_74_23 then
					arg_71_1.talkMaxDuration = var_74_23
					var_74_15 = var_74_15 + 0.3

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_20
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_24 = var_74_15 + 0.3
			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_24 <= arg_71_1.time_ and arg_71_1.time_ < var_74_24 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_24) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_24 + var_74_25 and arg_71_1.time_ < var_74_24 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play925131018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 925131018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
			arg_77_1.auto_ = false
		end

		function arg_77_1.playNext_(arg_79_0)
			arg_77_1.onStoryFinished_()
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1011"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1011 == nil then
				arg_77_1.var_.actorSpriteComps1011 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1011 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1011:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1011 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1011:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1011 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.0329999998211861

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(925131018)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 6
				local var_80_14 = utf8.len(var_80_12)
				local var_80_15 = var_80_13 <= 0 and var_80_9 or var_80_9 * (var_80_14 / var_80_13)

				if var_80_15 > 0 and var_80_9 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06f"
	},
	voices = {}
}
