return {
	Play929041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 929041001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play929041002(arg_1_1)
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_140", "se_story_140_amb_room01", "")
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

			local var_4_34 = 0.3
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")
			end

			local var_4_38 = 0
			local var_4_39 = 0.1

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_41

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

				local var_4_42 = arg_1_1:GetWordFromCfg(929041001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 4
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play929041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 929041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play929041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "10148"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

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

			local var_11_4 = arg_8_1.actors_["10148"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10148 == nil then
				arg_8_1.var_.actorSpriteComps10148 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps10148 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10148 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10148 = nil
			end

			local var_11_12 = arg_8_1.actors_["10148"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos10148 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10148", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_2" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(0, -350, -270)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10148, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, -350, -270)
			end

			local var_11_19 = 0
			local var_11_20 = 1.125

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_21 = arg_8_1:FormatText(StoryNameCfg[1331].name)

				arg_8_1.leftNameTxt_.text = var_11_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(929041002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 45
				local var_11_25 = utf8.len(var_11_23)
				local var_11_26 = var_11_24 <= 0 and var_11_20 or var_11_20 * (var_11_25 / var_11_24)

				if var_11_26 > 0 and var_11_20 < var_11_26 then
					arg_8_1.talkMaxDuration = var_11_26

					if var_11_26 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_19
					end
				end

				arg_8_1.text_.text = var_11_23
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_27 = math.max(var_11_20, arg_8_1.talkMaxDuration)

			if var_11_19 <= arg_8_1.time_ and arg_8_1.time_ < var_11_19 + var_11_27 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_19) / var_11_27

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_19 + var_11_27 and arg_8_1.time_ < var_11_19 + var_11_27 + arg_11_0 then
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
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play929041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 929041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play929041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10148"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos10148 = var_15_0.localPosition
				var_15_0.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10148", 3)

				local var_15_2 = var_15_0.childCount

				for iter_15_0 = 0, var_15_2 - 1 do
					local var_15_3 = var_15_0:GetChild(iter_15_0)

					if var_15_3.name == "split_2" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_4 then
				local var_15_5 = (arg_12_1.time_ - var_15_1) / var_15_4
				local var_15_6 = Vector3.New(0, -350, -270)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10148, var_15_6, var_15_5)
			end

			if arg_12_1.time_ >= var_15_1 + var_15_4 and arg_12_1.time_ < var_15_1 + var_15_4 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_15_7 = 0
			local var_15_8 = 0.975

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_9 = arg_12_1:FormatText(StoryNameCfg[1331].name)

				arg_12_1.leftNameTxt_.text = var_15_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(929041003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_12 = 39
				local var_15_13 = utf8.len(var_15_11)
				local var_15_14 = var_15_12 <= 0 and var_15_8 or var_15_8 * (var_15_13 / var_15_12)

				if var_15_14 > 0 and var_15_8 < var_15_14 then
					arg_12_1.talkMaxDuration = var_15_14

					if var_15_14 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_7
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_15 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_15 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_7) / var_15_15

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_7 + var_15_15 and arg_12_1.time_ < var_15_7 + var_15_15 + arg_15_0 then
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
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play929041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 929041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play929041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10148"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10148 = var_19_0.localPosition
				var_19_0.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10148", 3)

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
				local var_19_6 = Vector3.New(0, -350, -270)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10148, var_19_6, var_19_5)
			end

			if arg_16_1.time_ >= var_19_1 + var_19_4 and arg_16_1.time_ < var_19_1 + var_19_4 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_19_7 = 0
			local var_19_8 = 0.825

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_9 = arg_16_1:FormatText(StoryNameCfg[1331].name)

				arg_16_1.leftNameTxt_.text = var_19_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(929041004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_12 = 33
				local var_19_13 = utf8.len(var_19_11)
				local var_19_14 = var_19_12 <= 0 and var_19_8 or var_19_8 * (var_19_13 / var_19_12)

				if var_19_14 > 0 and var_19_8 < var_19_14 then
					arg_16_1.talkMaxDuration = var_19_14

					if var_19_14 + var_19_7 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_7
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_15 = math.max(var_19_8, arg_16_1.talkMaxDuration)

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_15 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_7) / var_19_15

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_7 + var_19_15 and arg_16_1.time_ < var_19_7 + var_19_15 + arg_19_0 then
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
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play929041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 929041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play929041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10148"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10148 = var_23_0.localPosition
				var_23_0.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10148", 3)

				local var_23_2 = var_23_0.childCount

				for iter_23_0 = 0, var_23_2 - 1 do
					local var_23_3 = var_23_0:GetChild(iter_23_0)

					if var_23_3.name == "" or not string.find(var_23_3.name, "split") then
						var_23_3.gameObject:SetActive(true)
					else
						var_23_3.gameObject:SetActive(false)
					end
				end
			end

			local var_23_4 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_4 then
				local var_23_5 = (arg_20_1.time_ - var_23_1) / var_23_4
				local var_23_6 = Vector3.New(0, -350, -270)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10148, var_23_6, var_23_5)
			end

			if arg_20_1.time_ >= var_23_1 + var_23_4 and arg_20_1.time_ < var_23_1 + var_23_4 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_23_7 = 0
			local var_23_8 = 1.275

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_9 = arg_20_1:FormatText(StoryNameCfg[1331].name)

				arg_20_1.leftNameTxt_.text = var_23_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(929041005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_12 = 51
				local var_23_13 = utf8.len(var_23_11)
				local var_23_14 = var_23_12 <= 0 and var_23_8 or var_23_8 * (var_23_13 / var_23_12)

				if var_23_14 > 0 and var_23_8 < var_23_14 then
					arg_20_1.talkMaxDuration = var_23_14

					if var_23_14 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_7
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_7) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_7 + var_23_15 and arg_20_1.time_ < var_23_7 + var_23_15 + arg_23_0 then
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
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play929041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 929041006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play929041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1083"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(var_27_1, arg_24_1.canvasGo_.transform)

					var_27_2.transform:SetSiblingIndex(1)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs(var_27_3) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_4 = arg_24_1.actors_["1083"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps1083 == nil then
				arg_24_1.var_.actorSpriteComps1083 = var_27_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_6 = 0.2

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.actorSpriteComps1083 then
					for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_27_3 then
							if arg_24_1.isInRecall_ then
								local var_27_8 = Mathf.Lerp(iter_27_3.color.r, arg_24_1.hightColor1.r, var_27_7)
								local var_27_9 = Mathf.Lerp(iter_27_3.color.g, arg_24_1.hightColor1.g, var_27_7)
								local var_27_10 = Mathf.Lerp(iter_27_3.color.b, arg_24_1.hightColor1.b, var_27_7)

								iter_27_3.color = Color.New(var_27_8, var_27_9, var_27_10)
							else
								local var_27_11 = Mathf.Lerp(iter_27_3.color.r, 1, var_27_7)

								iter_27_3.color = Color.New(var_27_11, var_27_11, var_27_11)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps1083 then
				for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_27_5 then
						if arg_24_1.isInRecall_ then
							iter_27_5.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1083 = nil
			end

			local var_27_12 = arg_24_1.actors_["10148"]
			local var_27_13 = 0

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10148 == nil then
				arg_24_1.var_.actorSpriteComps10148 = var_27_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_14 = 0.2

			if var_27_13 <= arg_24_1.time_ and arg_24_1.time_ < var_27_13 + var_27_14 and not isNil(var_27_12) then
				local var_27_15 = (arg_24_1.time_ - var_27_13) / var_27_14

				if arg_24_1.var_.actorSpriteComps10148 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								local var_27_16 = Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor2.r, var_27_15)
								local var_27_17 = Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor2.g, var_27_15)
								local var_27_18 = Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor2.b, var_27_15)

								iter_27_7.color = Color.New(var_27_16, var_27_17, var_27_18)
							else
								local var_27_19 = Mathf.Lerp(iter_27_7.color.r, 0.5, var_27_15)

								iter_27_7.color = Color.New(var_27_19, var_27_19, var_27_19)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_13 + var_27_14 and arg_24_1.time_ < var_27_13 + var_27_14 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10148 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_27_9 then
						if arg_24_1.isInRecall_ then
							iter_27_9.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10148 = nil
			end

			local var_27_20 = arg_24_1.actors_["1083"].transform
			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.var_.moveOldPos1083 = var_27_20.localPosition
				var_27_20.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1083", 3)

				local var_27_22 = var_27_20.childCount

				for iter_27_10 = 0, var_27_22 - 1 do
					local var_27_23 = var_27_20:GetChild(iter_27_10)

					if var_27_23.name == "split_2" or not string.find(var_27_23.name, "split") then
						var_27_23.gameObject:SetActive(true)
					else
						var_27_23.gameObject:SetActive(false)
					end
				end
			end

			local var_27_24 = 0.001

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_24 then
				local var_27_25 = (arg_24_1.time_ - var_27_21) / var_27_24
				local var_27_26 = Vector3.New(-50, -345, -345)

				var_27_20.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1083, var_27_26, var_27_25)
			end

			if arg_24_1.time_ >= var_27_21 + var_27_24 and arg_24_1.time_ < var_27_21 + var_27_24 + arg_27_0 then
				var_27_20.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_27_27 = 0
			local var_27_28 = 0.25

			if var_27_27 < arg_24_1.time_ and arg_24_1.time_ <= var_27_27 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_29 = arg_24_1:FormatText(StoryNameCfg[1332].name)

				arg_24_1.leftNameTxt_.text = var_27_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_30 = arg_24_1:GetWordFromCfg(929041006)
				local var_27_31 = arg_24_1:FormatText(var_27_30.content)

				arg_24_1.text_.text = var_27_31

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_32 = 10
				local var_27_33 = utf8.len(var_27_31)
				local var_27_34 = var_27_32 <= 0 and var_27_28 or var_27_28 * (var_27_33 / var_27_32)

				if var_27_34 > 0 and var_27_28 < var_27_34 then
					arg_24_1.talkMaxDuration = var_27_34

					if var_27_34 + var_27_27 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_27
					end
				end

				arg_24_1.text_.text = var_27_31
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_28, arg_24_1.talkMaxDuration)

			if var_27_27 <= arg_24_1.time_ and arg_24_1.time_ < var_27_27 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_27) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_27 + var_27_35 and arg_24_1.time_ < var_27_27 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play929041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 929041007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play929041008(arg_28_1)
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

			local var_31_8 = arg_28_1.actors_["1083"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1083 == nil then
				arg_28_1.var_.actorSpriteComps1083 = var_31_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_10 = 0.2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.actorSpriteComps1083 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_31_5 then
							if arg_28_1.isInRecall_ then
								local var_31_12 = Mathf.Lerp(iter_31_5.color.r, arg_28_1.hightColor2.r, var_31_11)
								local var_31_13 = Mathf.Lerp(iter_31_5.color.g, arg_28_1.hightColor2.g, var_31_11)
								local var_31_14 = Mathf.Lerp(iter_31_5.color.b, arg_28_1.hightColor2.b, var_31_11)

								iter_31_5.color = Color.New(var_31_12, var_31_13, var_31_14)
							else
								local var_31_15 = Mathf.Lerp(iter_31_5.color.r, 0.5, var_31_11)

								iter_31_5.color = Color.New(var_31_15, var_31_15, var_31_15)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1083 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_31_7 then
						if arg_28_1.isInRecall_ then
							iter_31_7.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1083 = nil
			end

			local var_31_16 = arg_28_1.actors_["10148"].transform
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.var_.moveOldPos10148 = var_31_16.localPosition
				var_31_16.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10148", 3)

				local var_31_18 = var_31_16.childCount

				for iter_31_8 = 0, var_31_18 - 1 do
					local var_31_19 = var_31_16:GetChild(iter_31_8)

					if var_31_19.name == "split_2" or not string.find(var_31_19.name, "split") then
						var_31_19.gameObject:SetActive(true)
					else
						var_31_19.gameObject:SetActive(false)
					end
				end
			end

			local var_31_20 = 0.001

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_17) / var_31_20
				local var_31_22 = Vector3.New(0, -350, -270)

				var_31_16.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10148, var_31_22, var_31_21)
			end

			if arg_28_1.time_ >= var_31_17 + var_31_20 and arg_28_1.time_ < var_31_17 + var_31_20 + arg_31_0 then
				var_31_16.localPosition = Vector3.New(0, -350, -270)
			end

			local var_31_23 = 0
			local var_31_24 = 0.625

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_25 = arg_28_1:FormatText(StoryNameCfg[1331].name)

				arg_28_1.leftNameTxt_.text = var_31_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:GetWordFromCfg(929041007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 25
				local var_31_29 = utf8.len(var_31_27)
				local var_31_30 = var_31_28 <= 0 and var_31_24 or var_31_24 * (var_31_29 / var_31_28)

				if var_31_30 > 0 and var_31_24 < var_31_30 then
					arg_28_1.talkMaxDuration = var_31_30

					if var_31_30 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_23
					end
				end

				arg_28_1.text_.text = var_31_27
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_31 = math.max(var_31_24, arg_28_1.talkMaxDuration)

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_31 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_23) / var_31_31

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_23 + var_31_31 and arg_28_1.time_ < var_31_23 + var_31_31 + arg_31_0 then
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
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play929041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 929041008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play929041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10148"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10148 == nil then
				arg_32_1.var_.actorSpriteComps10148 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10148 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 0.5, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10148 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10148 = nil
			end

			local var_35_8 = arg_32_1.actors_["10148"].transform
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.var_.moveOldPos10148 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10148", 3)

				local var_35_10 = var_35_8.childCount

				for iter_35_4 = 0, var_35_10 - 1 do
					local var_35_11 = var_35_8:GetChild(iter_35_4)

					if var_35_11.name == "split_2" or not string.find(var_35_11.name, "split") then
						var_35_11.gameObject:SetActive(true)
					else
						var_35_11.gameObject:SetActive(false)
					end
				end
			end

			local var_35_12 = 0.001

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_9) / var_35_12
				local var_35_14 = Vector3.New(0, -350, -270)

				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10148, var_35_14, var_35_13)
			end

			if arg_32_1.time_ >= var_35_9 + var_35_12 and arg_32_1.time_ < var_35_9 + var_35_12 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_35_15 = 0
			local var_35_16 = 0.075

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_18 = arg_32_1:GetWordFromCfg(929041008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 3
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
				actorName = "10148",
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
	Play929041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 929041009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play929041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10148"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10148 = var_39_0.localPosition
				var_39_0.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10148", 3)

				local var_39_2 = var_39_0.childCount

				for iter_39_0 = 0, var_39_2 - 1 do
					local var_39_3 = var_39_0:GetChild(iter_39_0)

					if var_39_3.name == "split_1" or not string.find(var_39_3.name, "split") then
						var_39_3.gameObject:SetActive(true)
					else
						var_39_3.gameObject:SetActive(false)
					end
				end
			end

			local var_39_4 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_4 then
				local var_39_5 = (arg_36_1.time_ - var_39_1) / var_39_4
				local var_39_6 = Vector3.New(0, -350, -270)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10148, var_39_6, var_39_5)
			end

			if arg_36_1.time_ >= var_39_1 + var_39_4 and arg_36_1.time_ < var_39_1 + var_39_4 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_39_7 = 0
			local var_39_8 = 0.8

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_9 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_10 = arg_36_1:GetWordFromCfg(929041009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 32
				local var_39_13 = utf8.len(var_39_11)
				local var_39_14 = var_39_12 <= 0 and var_39_8 or var_39_8 * (var_39_13 / var_39_12)

				if var_39_14 > 0 and var_39_8 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14

					if var_39_14 + var_39_7 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_7
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_7) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_7 + var_39_15 and arg_36_1.time_ < var_39_7 + var_39_15 + arg_39_0 then
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
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play929041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 929041010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play929041011(arg_40_1)
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

			local var_43_8 = arg_40_1.actors_["10148"].transform
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.var_.moveOldPos10148 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10148", 3)

				local var_43_10 = var_43_8.childCount

				for iter_43_4 = 0, var_43_10 - 1 do
					local var_43_11 = var_43_8:GetChild(iter_43_4)

					if var_43_11.name == "split_3" or not string.find(var_43_11.name, "split") then
						var_43_11.gameObject:SetActive(true)
					else
						var_43_11.gameObject:SetActive(false)
					end
				end
			end

			local var_43_12 = 0.001

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_9) / var_43_12
				local var_43_14 = Vector3.New(0, -350, -270)

				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10148, var_43_14, var_43_13)
			end

			if arg_40_1.time_ >= var_43_9 + var_43_12 and arg_40_1.time_ < var_43_9 + var_43_12 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_43_15 = 0
			local var_43_16 = 0.325

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[1331].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(929041010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 13
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_23 and arg_40_1.time_ < var_43_15 + var_43_23 + arg_43_0 then
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
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play929041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 929041011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play929041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1083"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1083 == nil then
				arg_44_1.var_.actorSpriteComps1083 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps1083 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 1, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1083 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1083 = nil
			end

			local var_47_8 = arg_44_1.actors_["10148"]
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps10148 == nil then
				arg_44_1.var_.actorSpriteComps10148 = var_47_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_10 = 0.2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 and not isNil(var_47_8) then
				local var_47_11 = (arg_44_1.time_ - var_47_9) / var_47_10

				if arg_44_1.var_.actorSpriteComps10148 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								local var_47_12 = Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, var_47_11)
								local var_47_13 = Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, var_47_11)
								local var_47_14 = Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, var_47_11)

								iter_47_5.color = Color.New(var_47_12, var_47_13, var_47_14)
							else
								local var_47_15 = Mathf.Lerp(iter_47_5.color.r, 0.5, var_47_11)

								iter_47_5.color = Color.New(var_47_15, var_47_15, var_47_15)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps10148 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_47_7 then
						if arg_44_1.isInRecall_ then
							iter_47_7.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10148 = nil
			end

			local var_47_16 = arg_44_1.actors_["1083"].transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.moveOldPos1083 = var_47_16.localPosition
				var_47_16.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1083", 3)

				local var_47_18 = var_47_16.childCount

				for iter_47_8 = 0, var_47_18 - 1 do
					local var_47_19 = var_47_16:GetChild(iter_47_8)

					if var_47_19.name == "split_2" or not string.find(var_47_19.name, "split") then
						var_47_19.gameObject:SetActive(true)
					else
						var_47_19.gameObject:SetActive(false)
					end
				end
			end

			local var_47_20 = 0.001

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_20 then
				local var_47_21 = (arg_44_1.time_ - var_47_17) / var_47_20
				local var_47_22 = Vector3.New(-50, -345, -345)

				var_47_16.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1083, var_47_22, var_47_21)
			end

			if arg_44_1.time_ >= var_47_17 + var_47_20 and arg_44_1.time_ < var_47_17 + var_47_20 + arg_47_0 then
				var_47_16.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_47_23 = 0
			local var_47_24 = 0.55

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_25 = arg_44_1:FormatText(StoryNameCfg[1332].name)

				arg_44_1.leftNameTxt_.text = var_47_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_26 = arg_44_1:GetWordFromCfg(929041011)
				local var_47_27 = arg_44_1:FormatText(var_47_26.content)

				arg_44_1.text_.text = var_47_27

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_28 = 22
				local var_47_29 = utf8.len(var_47_27)
				local var_47_30 = var_47_28 <= 0 and var_47_24 or var_47_24 * (var_47_29 / var_47_28)

				if var_47_30 > 0 and var_47_24 < var_47_30 then
					arg_44_1.talkMaxDuration = var_47_30

					if var_47_30 + var_47_23 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_30 + var_47_23
					end
				end

				arg_44_1.text_.text = var_47_27
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_31 = math.max(var_47_24, arg_44_1.talkMaxDuration)

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_31 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_23) / var_47_31

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_23 + var_47_31 and arg_44_1.time_ < var_47_23 + var_47_31 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
	Play929041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 929041012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play929041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1083"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1083 == nil then
				arg_48_1.var_.actorSpriteComps1083 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1083 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1083 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1083 = nil
			end

			local var_51_8 = arg_48_1.actors_["1083"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos1083 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1083", 3)

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
				local var_51_14 = Vector3.New(-50, -345, -345)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1083, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_51_15 = 0
			local var_51_16 = 0.5

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_18 = arg_48_1:GetWordFromCfg(929041012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 20
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
	Play929041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 929041013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play929041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1083"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1083 = var_55_0.localPosition
				var_55_0.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("1083", 3)

				local var_55_2 = var_55_0.childCount

				for iter_55_0 = 0, var_55_2 - 1 do
					local var_55_3 = var_55_0:GetChild(iter_55_0)

					if var_55_3.name == "" or not string.find(var_55_3.name, "split") then
						var_55_3.gameObject:SetActive(true)
					else
						var_55_3.gameObject:SetActive(false)
					end
				end
			end

			local var_55_4 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_4 then
				local var_55_5 = (arg_52_1.time_ - var_55_1) / var_55_4
				local var_55_6 = Vector3.New(-50, -345, -345)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1083, var_55_6, var_55_5)
			end

			if arg_52_1.time_ >= var_55_1 + var_55_4 and arg_52_1.time_ < var_55_1 + var_55_4 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_55_7 = 0
			local var_55_8 = 1

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_9 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_10 = arg_52_1:GetWordFromCfg(929041013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 40
				local var_55_13 = utf8.len(var_55_11)
				local var_55_14 = var_55_12 <= 0 and var_55_8 or var_55_8 * (var_55_13 / var_55_12)

				if var_55_14 > 0 and var_55_8 < var_55_14 then
					arg_52_1.talkMaxDuration = var_55_14

					if var_55_14 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_7
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_15 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_7) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_7 + var_55_15 and arg_52_1.time_ < var_55_7 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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
	Play929041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 929041014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play929041015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1083"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1083 == nil then
				arg_56_1.var_.actorSpriteComps1083 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1083 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 1, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1083 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1083 = nil
			end

			local var_59_8 = arg_56_1.actors_["1083"].transform
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.var_.moveOldPos1083 = var_59_8.localPosition
				var_59_8.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1083", 3)

				local var_59_10 = var_59_8.childCount

				for iter_59_4 = 0, var_59_10 - 1 do
					local var_59_11 = var_59_8:GetChild(iter_59_4)

					if var_59_11.name == "split_6" or not string.find(var_59_11.name, "split") then
						var_59_11.gameObject:SetActive(true)
					else
						var_59_11.gameObject:SetActive(false)
					end
				end
			end

			local var_59_12 = 0.001

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_9) / var_59_12
				local var_59_14 = Vector3.New(-50, -345, -345)

				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1083, var_59_14, var_59_13)
			end

			if arg_56_1.time_ >= var_59_9 + var_59_12 and arg_56_1.time_ < var_59_9 + var_59_12 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_59_15 = 0
			local var_59_16 = 1.2

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[1332].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(929041014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 48
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_23 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_23 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_23

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_23 and arg_56_1.time_ < var_59_15 + var_59_23 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
	Play929041015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 929041015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play929041016(arg_60_1)
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
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor2.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor2.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor2.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 0.5, var_63_3)

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
							iter_63_3.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1083 = nil
			end

			local var_63_8 = arg_60_1.actors_["1083"].transform
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.var_.moveOldPos1083 = var_63_8.localPosition
				var_63_8.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1083", 3)

				local var_63_10 = var_63_8.childCount

				for iter_63_4 = 0, var_63_10 - 1 do
					local var_63_11 = var_63_8:GetChild(iter_63_4)

					if var_63_11.name == "" or not string.find(var_63_11.name, "split") then
						var_63_11.gameObject:SetActive(true)
					else
						var_63_11.gameObject:SetActive(false)
					end
				end
			end

			local var_63_12 = 0.001

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_9) / var_63_12
				local var_63_14 = Vector3.New(-50, -345, -345)

				var_63_8.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1083, var_63_14, var_63_13)
			end

			if arg_60_1.time_ >= var_63_9 + var_63_12 and arg_60_1.time_ < var_63_9 + var_63_12 + arg_63_0 then
				var_63_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_63_15 = 0
			local var_63_16 = 0.975

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_18 = arg_60_1:GetWordFromCfg(929041015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 39
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
	Play929041016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 929041016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play929041017(arg_64_1)
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

			local var_67_8 = arg_64_1.actors_["10148"].transform
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.var_.moveOldPos10148 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10148", 3)

				local var_67_10 = var_67_8.childCount

				for iter_67_4 = 0, var_67_10 - 1 do
					local var_67_11 = var_67_8:GetChild(iter_67_4)

					if var_67_11.name == "split_4" or not string.find(var_67_11.name, "split") then
						var_67_11.gameObject:SetActive(true)
					else
						var_67_11.gameObject:SetActive(false)
					end
				end
			end

			local var_67_12 = 0.001

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_9) / var_67_12
				local var_67_14 = Vector3.New(0, -350, -270)

				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10148, var_67_14, var_67_13)
			end

			if arg_64_1.time_ >= var_67_9 + var_67_12 and arg_64_1.time_ < var_67_9 + var_67_12 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_67_15 = 0
			local var_67_16 = 1

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[1331].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(929041016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 40
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
				actorName = "10148",
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
	Play929041017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 929041017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
			arg_68_1.auto_ = false
		end

		function arg_68_1.playNext_(arg_70_0)
			arg_68_1.onStoryFinished_()
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10148"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10148 == nil then
				arg_68_1.var_.actorSpriteComps10148 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10148 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10148 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10148 = nil
			end

			local var_71_8 = arg_68_1.actors_["10148"].transform
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.var_.moveOldPos10148 = var_71_8.localPosition
				var_71_8.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10148", 3)

				local var_71_10 = var_71_8.childCount

				for iter_71_4 = 0, var_71_10 - 1 do
					local var_71_11 = var_71_8:GetChild(iter_71_4)

					if var_71_11.name == "split_4" or not string.find(var_71_11.name, "split") then
						var_71_11.gameObject:SetActive(true)
					else
						var_71_11.gameObject:SetActive(false)
					end
				end
			end

			local var_71_12 = 0.001

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_9) / var_71_12
				local var_71_14 = Vector3.New(0, -350, -270)

				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10148, var_71_14, var_71_13)
			end

			if arg_68_1.time_ >= var_71_9 + var_71_12 and arg_68_1.time_ < var_71_9 + var_71_12 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_71_15 = 0
			local var_71_16 = 0.45

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_18 = arg_68_1:GetWordFromCfg(929041017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 18
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_23 and arg_68_1.time_ < var_71_15 + var_71_23 + arg_71_0 then
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
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0112"
	},
	voices = {}
}
