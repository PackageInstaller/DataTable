return {
	Play425132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play425132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "Q02f"

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
				local var_4_5 = arg_1_1.bgs_.Q02f

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
					if iter_4_0 ~= "Q02f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = 0.133333333333333
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

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

			local var_4_34 = 0.433333333333333
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 1.999999999999
			local var_4_41 = 0.975

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(425132001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 39
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play425132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play425132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.95

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(425132002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 38
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play425132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425132003
		arg_13_1.duration_ = 2.13

		local var_13_0 = {
			zh = 1.6,
			ja = 2.133
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play425132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1137"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["1137"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1137 == nil then
				arg_13_1.var_.actorSpriteComps1137 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps1137 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1137 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1137 = nil
			end

			local var_16_12 = arg_13_1.actors_["1137"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos1137 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1137", 3)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "split_6" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(0, -425, -200)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1137, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(0, -425, -200)
			end

			local var_16_19 = 0
			local var_16_20 = 0.35

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[15].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(425132003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 14
				local var_16_25 = utf8.len(var_16_23)
				local var_16_26 = var_16_24 <= 0 and var_16_20 or var_16_20 * (var_16_25 / var_16_24)

				if var_16_26 > 0 and var_16_20 < var_16_26 then
					arg_13_1.talkMaxDuration = var_16_26

					if var_16_26 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_26 + var_16_19
					end
				end

				arg_13_1.text_.text = var_16_23
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132003", "story_v_out_425132.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_425132", "425132003", "story_v_out_425132.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_425132", "425132003", "story_v_out_425132.awb")

						arg_13_1:RecordAudio("425132003", var_16_28)
						arg_13_1:RecordAudio("425132003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425132", "425132003", "story_v_out_425132.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425132", "425132003", "story_v_out_425132.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_29 = math.max(var_16_20, arg_13_1.talkMaxDuration)

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_29 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_29

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_29 and arg_13_1.time_ < var_16_19 + var_16_29 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play425132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425132004
		arg_17_1.duration_ = 5.87

		local var_17_0 = {
			zh = 4.033,
			ja = 5.866
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play425132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.4

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[15].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(425132004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 16
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132004", "story_v_out_425132.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132004", "story_v_out_425132.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_425132", "425132004", "story_v_out_425132.awb")

						arg_17_1:RecordAudio("425132004", var_20_9)
						arg_17_1:RecordAudio("425132004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425132", "425132004", "story_v_out_425132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425132", "425132004", "story_v_out_425132.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play425132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425132005
		arg_21_1.duration_ = 3.97

		local var_21_0 = {
			zh = 3.9,
			ja = 3.966
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play425132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1137"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1137 == nil then
				arg_21_1.var_.actorSpriteComps1137 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1137 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1137 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1137 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.475

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[1440].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_11 = arg_21_1:GetWordFromCfg(425132005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132005", "story_v_out_425132.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_425132", "425132005", "story_v_out_425132.awb") / 1000

					if var_24_16 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_8
					end

					if var_24_11.prefab_name ~= "" and arg_21_1.actors_[var_24_11.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_11.prefab_name].transform, "story_v_out_425132", "425132005", "story_v_out_425132.awb")

						arg_21_1:RecordAudio("425132005", var_24_17)
						arg_21_1:RecordAudio("425132005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425132", "425132005", "story_v_out_425132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425132", "425132005", "story_v_out_425132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_18 and arg_21_1.time_ < var_24_8 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play425132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425132006
		arg_25_1.duration_ = 7.27

		local var_25_0 = {
			zh = 5.533,
			ja = 7.266
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play425132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1137"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1137 == nil then
				arg_25_1.var_.actorSpriteComps1137 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1137 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1137 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1137 = nil
			end

			local var_28_8 = arg_25_1.actors_["1137"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos1137 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1137", 3)

				local var_28_10 = var_28_8.childCount

				for iter_28_4 = 0, var_28_10 - 1 do
					local var_28_11 = var_28_8:GetChild(iter_28_4)

					if var_28_11.name == "" or not string.find(var_28_11.name, "split") then
						var_28_11.gameObject:SetActive(true)
					else
						var_28_11.gameObject:SetActive(false)
					end
				end
			end

			local var_28_12 = 0.001

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_12 then
				local var_28_13 = (arg_25_1.time_ - var_28_9) / var_28_12
				local var_28_14 = Vector3.New(0, -425, -200)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1137, var_28_14, var_28_13)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_12 and arg_25_1.time_ < var_28_9 + var_28_12 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_28_15 = 0
			local var_28_16 = 0.7

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[15].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(425132006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 28
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132006", "story_v_out_425132.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132006", "story_v_out_425132.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_425132", "425132006", "story_v_out_425132.awb")

						arg_25_1:RecordAudio("425132006", var_28_24)
						arg_25_1:RecordAudio("425132006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425132", "425132006", "story_v_out_425132.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425132", "425132006", "story_v_out_425132.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play425132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425132007
		arg_29_1.duration_ = 13.4

		local var_29_0 = {
			zh = 12.366,
			ja = 13.4
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play425132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1137"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1137 == nil then
				arg_29_1.var_.actorSpriteComps1137 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1137 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1137 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1137 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.8

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[1440].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_11 = arg_29_1:GetWordFromCfg(425132007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 32
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_9 or var_32_9 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_9 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132007", "story_v_out_425132.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_425132", "425132007", "story_v_out_425132.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_425132", "425132007", "story_v_out_425132.awb")

						arg_29_1:RecordAudio("425132007", var_32_17)
						arg_29_1:RecordAudio("425132007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425132", "425132007", "story_v_out_425132.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425132", "425132007", "story_v_out_425132.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_18 and arg_29_1.time_ < var_32_8 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play425132008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425132008
		arg_33_1.duration_ = 7.17

		local var_33_0 = {
			zh = 5.4,
			ja = 7.166
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play425132009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1137"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1137 == nil then
				arg_33_1.var_.actorSpriteComps1137 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1137 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1137 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1137 = nil
			end

			local var_36_8 = arg_33_1.actors_["1137"].transform
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.var_.moveOldPos1137 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1137", 3)

				local var_36_10 = var_36_8.childCount

				for iter_36_4 = 0, var_36_10 - 1 do
					local var_36_11 = var_36_8:GetChild(iter_36_4)

					if var_36_11.name == "split_6" or not string.find(var_36_11.name, "split") then
						var_36_11.gameObject:SetActive(true)
					else
						var_36_11.gameObject:SetActive(false)
					end
				end
			end

			local var_36_12 = 0.001

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_12 then
				local var_36_13 = (arg_33_1.time_ - var_36_9) / var_36_12
				local var_36_14 = Vector3.New(0, -425, -200)

				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1137, var_36_14, var_36_13)
			end

			if arg_33_1.time_ >= var_36_9 + var_36_12 and arg_33_1.time_ < var_36_9 + var_36_12 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_36_15 = 0
			local var_36_16 = 0.525

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[15].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(425132008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 21
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132008", "story_v_out_425132.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132008", "story_v_out_425132.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_425132", "425132008", "story_v_out_425132.awb")

						arg_33_1:RecordAudio("425132008", var_36_24)
						arg_33_1:RecordAudio("425132008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425132", "425132008", "story_v_out_425132.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425132", "425132008", "story_v_out_425132.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play425132009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425132009
		arg_37_1.duration_ = 2.2

		local var_37_0 = {
			zh = 2.2,
			ja = 1.3
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play425132010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1137"].transform
			local var_40_1 = 0.5

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1137 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1137", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_6" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -425, -200)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1137, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -425, -200)
			end

			local var_40_7 = manager.ui.mainCamera.transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_7.localPosition
			end

			local var_40_9 = 0.333333333333333

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / 0.066
				local var_40_11, var_40_12 = math.modf(var_40_10)

				var_40_7.localPosition = Vector3.New(var_40_12 * 0.13, var_40_12 * 0.13, var_40_12 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				var_40_7.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_13 = 0
			local var_40_14 = 1

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				local var_40_15 = "play"
				local var_40_16 = "effect"

				arg_37_1:AudioAction(var_40_15, var_40_16, "se_story_121_04", "se_story_121_04_blast", "")
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_17 = 0.5
			local var_40_18 = 0.075

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_19 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_19:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_20 = arg_37_1:FormatText(StoryNameCfg[15].name)

				arg_37_1.leftNameTxt_.text = var_40_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_21 = arg_37_1:GetWordFromCfg(425132009)
				local var_40_22 = arg_37_1:FormatText(var_40_21.content)

				arg_37_1.text_.text = var_40_22

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_23 = 3
				local var_40_24 = utf8.len(var_40_22)
				local var_40_25 = var_40_23 <= 0 and var_40_18 or var_40_18 * (var_40_24 / var_40_23)

				if var_40_25 > 0 and var_40_18 < var_40_25 then
					arg_37_1.talkMaxDuration = var_40_25
					var_40_17 = var_40_17 + 0.3

					if var_40_25 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_25 + var_40_17
					end
				end

				arg_37_1.text_.text = var_40_22
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132009", "story_v_out_425132.awb") ~= 0 then
					local var_40_26 = manager.audio:GetVoiceLength("story_v_out_425132", "425132009", "story_v_out_425132.awb") / 1000

					if var_40_26 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_17
					end

					if var_40_21.prefab_name ~= "" and arg_37_1.actors_[var_40_21.prefab_name] ~= nil then
						local var_40_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_21.prefab_name].transform, "story_v_out_425132", "425132009", "story_v_out_425132.awb")

						arg_37_1:RecordAudio("425132009", var_40_27)
						arg_37_1:RecordAudio("425132009", var_40_27)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425132", "425132009", "story_v_out_425132.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425132", "425132009", "story_v_out_425132.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_28 = var_40_17 + 0.3
			local var_40_29 = math.max(var_40_18, arg_37_1.talkMaxDuration)

			if var_40_28 <= arg_37_1.time_ and arg_37_1.time_ < var_40_28 + var_40_29 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_28) / var_40_29

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_28 + var_40_29 and arg_37_1.time_ < var_40_28 + var_40_29 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(10, 10, 10)
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play425132010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 425132010
		arg_43_1.duration_ = 16.3

		local var_43_0 = {
			zh = 11.6,
			ja = 16.3
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play425132011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "SS2504"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 2

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.SS2504

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "SS2504" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 4

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_17 = 0.3

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_19 = 2

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				local var_46_20 = (arg_43_1.time_ - var_46_18) / var_46_19
				local var_46_21 = Color.New(0, 0, 0)

				var_46_21.a = Mathf.Lerp(0, 1, var_46_20)
				arg_43_1.mask_.color = var_46_21
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				local var_46_22 = Color.New(0, 0, 0)

				var_46_22.a = 1
				arg_43_1.mask_.color = var_46_22
			end

			local var_46_23 = 2

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_24 = 2

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_24 then
				local var_46_25 = (arg_43_1.time_ - var_46_23) / var_46_24
				local var_46_26 = Color.New(0, 0, 0)

				var_46_26.a = Mathf.Lerp(1, 0, var_46_25)
				arg_43_1.mask_.color = var_46_26
			end

			if arg_43_1.time_ >= var_46_23 + var_46_24 and arg_43_1.time_ < var_46_23 + var_46_24 + arg_46_0 then
				local var_46_27 = Color.New(0, 0, 0)
				local var_46_28 = 0

				arg_43_1.mask_.enabled = false
				var_46_27.a = var_46_28
				arg_43_1.mask_.color = var_46_27
			end

			local var_46_29 = arg_43_1.actors_["1137"].transform
			local var_46_30 = 2

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.var_.moveOldPos1137 = var_46_29.localPosition
				var_46_29.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1137", 7)

				local var_46_31 = var_46_29.childCount

				for iter_46_2 = 0, var_46_31 - 1 do
					local var_46_32 = var_46_29:GetChild(iter_46_2)

					if var_46_32.name == "" or not string.find(var_46_32.name, "split") then
						var_46_32.gameObject:SetActive(true)
					else
						var_46_32.gameObject:SetActive(false)
					end
				end
			end

			local var_46_33 = 0.001

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_33 then
				local var_46_34 = (arg_43_1.time_ - var_46_30) / var_46_33
				local var_46_35 = Vector3.New(0, -2000, 0)

				var_46_29.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1137, var_46_35, var_46_34)
			end

			if arg_43_1.time_ >= var_46_30 + var_46_33 and arg_43_1.time_ < var_46_30 + var_46_33 + arg_46_0 then
				var_46_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_36 = arg_43_1.bgs_.SS2504.transform
			local var_46_37 = 2

			if var_46_37 < arg_43_1.time_ and arg_43_1.time_ <= var_46_37 + arg_46_0 then
				arg_43_1.var_.moveOldPosSS2504 = var_46_36.localPosition
			end

			local var_46_38 = 2

			if var_46_37 <= arg_43_1.time_ and arg_43_1.time_ < var_46_37 + var_46_38 then
				local var_46_39 = (arg_43_1.time_ - var_46_37) / var_46_38
				local var_46_40 = Vector3.New(0, 1, 8.5)

				var_46_36.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPosSS2504, var_46_40, var_46_39)
			end

			if arg_43_1.time_ >= var_46_37 + var_46_38 and arg_43_1.time_ < var_46_37 + var_46_38 + arg_46_0 then
				var_46_36.localPosition = Vector3.New(0, 1, 8.5)
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_41 = 4
			local var_46_42 = 0.85

			if var_46_41 < arg_43_1.time_ and arg_43_1.time_ <= var_46_41 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_43 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_43:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_44 = arg_43_1:FormatText(StoryNameCfg[15].name)

				arg_43_1.leftNameTxt_.text = var_46_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_45 = arg_43_1:GetWordFromCfg(425132010)
				local var_46_46 = arg_43_1:FormatText(var_46_45.content)

				arg_43_1.text_.text = var_46_46

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_47 = 34
				local var_46_48 = utf8.len(var_46_46)
				local var_46_49 = var_46_47 <= 0 and var_46_42 or var_46_42 * (var_46_48 / var_46_47)

				if var_46_49 > 0 and var_46_42 < var_46_49 then
					arg_43_1.talkMaxDuration = var_46_49
					var_46_41 = var_46_41 + 0.3

					if var_46_49 + var_46_41 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_49 + var_46_41
					end
				end

				arg_43_1.text_.text = var_46_46
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132010", "story_v_out_425132.awb") ~= 0 then
					local var_46_50 = manager.audio:GetVoiceLength("story_v_out_425132", "425132010", "story_v_out_425132.awb") / 1000

					if var_46_50 + var_46_41 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_50 + var_46_41
					end

					if var_46_45.prefab_name ~= "" and arg_43_1.actors_[var_46_45.prefab_name] ~= nil then
						local var_46_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_45.prefab_name].transform, "story_v_out_425132", "425132010", "story_v_out_425132.awb")

						arg_43_1:RecordAudio("425132010", var_46_51)
						arg_43_1:RecordAudio("425132010", var_46_51)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_425132", "425132010", "story_v_out_425132.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_425132", "425132010", "story_v_out_425132.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_52 = var_46_41 + 0.3
			local var_46_53 = math.max(var_46_42, arg_43_1.talkMaxDuration)

			if var_46_52 <= arg_43_1.time_ and arg_43_1.time_ < var_46_52 + var_46_53 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_52) / var_46_53

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_52 + var_46_53 and arg_43_1.time_ < var_46_52 + var_46_53 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.669,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 1, 8.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play425132011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425132011
		arg_49_1.duration_ = 3.7

		local var_49_0 = {
			zh = 2.666,
			ja = 3.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play425132012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.175

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[15].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(425132011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 7
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132011", "story_v_out_425132.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132011", "story_v_out_425132.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_425132", "425132011", "story_v_out_425132.awb")

						arg_49_1:RecordAudio("425132011", var_52_9)
						arg_49_1:RecordAudio("425132011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_425132", "425132011", "story_v_out_425132.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_425132", "425132011", "story_v_out_425132.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play425132012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425132012
		arg_53_1.duration_ = 9.4

		local var_53_0 = {
			zh = 5.8,
			ja = 9.4
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play425132013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.75

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[15].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(425132012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 30
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132012", "story_v_out_425132.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132012", "story_v_out_425132.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_425132", "425132012", "story_v_out_425132.awb")

						arg_53_1:RecordAudio("425132012", var_56_9)
						arg_53_1:RecordAudio("425132012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425132", "425132012", "story_v_out_425132.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425132", "425132012", "story_v_out_425132.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play425132013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425132013
		arg_57_1.duration_ = 4.87

		local var_57_0 = {
			zh = 2.6,
			ja = 4.866
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play425132014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.325

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[15].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(425132013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 13
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132013", "story_v_out_425132.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132013", "story_v_out_425132.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_425132", "425132013", "story_v_out_425132.awb")

						arg_57_1:RecordAudio("425132013", var_60_9)
						arg_57_1:RecordAudio("425132013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425132", "425132013", "story_v_out_425132.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425132", "425132013", "story_v_out_425132.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play425132014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 425132014
		arg_61_1.duration_ = 3.27

		local var_61_0 = {
			zh = 2.266,
			ja = 3.266
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play425132015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.275

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[1440].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(425132014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 11
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132014", "story_v_out_425132.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132014", "story_v_out_425132.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_425132", "425132014", "story_v_out_425132.awb")

						arg_61_1:RecordAudio("425132014", var_64_9)
						arg_61_1:RecordAudio("425132014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_425132", "425132014", "story_v_out_425132.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_425132", "425132014", "story_v_out_425132.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play425132015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 425132015
		arg_65_1.duration_ = 5.77

		local var_65_0 = {
			zh = 5.766,
			ja = 4.9
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play425132016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.475

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[15].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(425132015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 19
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132015", "story_v_out_425132.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132015", "story_v_out_425132.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_425132", "425132015", "story_v_out_425132.awb")

						arg_65_1:RecordAudio("425132015", var_68_9)
						arg_65_1:RecordAudio("425132015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_425132", "425132015", "story_v_out_425132.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_425132", "425132015", "story_v_out_425132.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play425132016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 425132016
		arg_69_1.duration_ = 8.1

		local var_69_0 = {
			zh = 6.2,
			ja = 8.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play425132017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.85

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[15].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(425132016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 34
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132016", "story_v_out_425132.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132016", "story_v_out_425132.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_425132", "425132016", "story_v_out_425132.awb")

						arg_69_1:RecordAudio("425132016", var_72_9)
						arg_69_1:RecordAudio("425132016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_425132", "425132016", "story_v_out_425132.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_425132", "425132016", "story_v_out_425132.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play425132017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 425132017
		arg_73_1.duration_ = 13.57

		local var_73_0 = {
			zh = 9.166,
			ja = 13.566
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play425132018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.025

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[15].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(425132017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 41
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132017", "story_v_out_425132.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132017", "story_v_out_425132.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_425132", "425132017", "story_v_out_425132.awb")

						arg_73_1:RecordAudio("425132017", var_76_9)
						arg_73_1:RecordAudio("425132017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_425132", "425132017", "story_v_out_425132.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_425132", "425132017", "story_v_out_425132.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play425132018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 425132018
		arg_77_1.duration_ = 5.8

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play425132019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = manager.ui.mainCamera.transform
			local var_80_1 = 0.333333333333333

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				local var_80_2 = arg_77_1.var_.effect2018
				local var_80_3
				local var_80_4 = var_80_0

				if not var_80_2 then
					var_80_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_80_4)
					var_80_2.name = "2018"
					arg_77_1.var_.effect2018 = var_80_2
				else
					var_80_2.transform:SetParent(var_80_4)
				end

				var_80_2.transform.localPosition = Vector3.New(2.39, 0, -4)
				var_80_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_6 = 0.333333333333333

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6
				local var_80_8 = Color.New(1, 1, 1)

				var_80_8.a = Mathf.Lerp(0, 1, var_80_7)
				arg_77_1.mask_.color = var_80_8
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				local var_80_9 = Color.New(1, 1, 1)

				var_80_9.a = 1
				arg_77_1.mask_.color = var_80_9
			end

			local var_80_10 = 0.333333333333333

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_11 = 0.466666666666667

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Color.New(1, 1, 1)

				var_80_13.a = Mathf.Lerp(1, 0, var_80_12)
				arg_77_1.mask_.color = var_80_13
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				local var_80_14 = Color.New(1, 1, 1)
				local var_80_15 = 0

				arg_77_1.mask_.enabled = false
				var_80_14.a = var_80_15
				arg_77_1.mask_.color = var_80_14
			end

			local var_80_16 = 0.133333333333333
			local var_80_17 = 1

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				local var_80_18 = "play"
				local var_80_19 = "effect"

				arg_77_1:AudioAction(var_80_18, var_80_19, "se_story_side_1028", "se_story_side_1028_ui", "")
			end

			local var_80_20 = 0.133333333333333
			local var_80_21 = 1

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				local var_80_22 = "play"
				local var_80_23 = "effect"

				arg_77_1:AudioAction(var_80_22, var_80_23, "se_story_9", "se_story_9_monster", "")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_24 = 0.8
			local var_80_25 = 1.25

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_26 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_26:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_27 = arg_77_1:GetWordFromCfg(425132018)
				local var_80_28 = arg_77_1:FormatText(var_80_27.content)

				arg_77_1.text_.text = var_80_28

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_29 = 50
				local var_80_30 = utf8.len(var_80_28)
				local var_80_31 = var_80_29 <= 0 and var_80_25 or var_80_25 * (var_80_30 / var_80_29)

				if var_80_31 > 0 and var_80_25 < var_80_31 then
					arg_77_1.talkMaxDuration = var_80_31
					var_80_24 = var_80_24 + 0.3

					if var_80_31 + var_80_24 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_24
					end
				end

				arg_77_1.text_.text = var_80_28
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_32 = var_80_24 + 0.3
			local var_80_33 = math.max(var_80_25, arg_77_1.talkMaxDuration)

			if var_80_32 <= arg_77_1.time_ and arg_77_1.time_ < var_80_32 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_32) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_32 + var_80_33 and arg_77_1.time_ < var_80_32 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play425132019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 425132019
		arg_83_1.duration_ = 8.63

		local var_83_0 = {
			zh = 7.933,
			ja = 8.633
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play425132020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[1440].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(425132019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 40
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132019", "story_v_out_425132.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132019", "story_v_out_425132.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_425132", "425132019", "story_v_out_425132.awb")

						arg_83_1:RecordAudio("425132019", var_86_9)
						arg_83_1:RecordAudio("425132019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_425132", "425132019", "story_v_out_425132.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_425132", "425132019", "story_v_out_425132.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play425132020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 425132020
		arg_87_1.duration_ = 8

		local var_87_0 = {
			zh = 6.1,
			ja = 8
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play425132021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.7

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[1440].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(425132020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 28
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132020", "story_v_out_425132.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132020", "story_v_out_425132.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_425132", "425132020", "story_v_out_425132.awb")

						arg_87_1:RecordAudio("425132020", var_90_9)
						arg_87_1:RecordAudio("425132020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_425132", "425132020", "story_v_out_425132.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_425132", "425132020", "story_v_out_425132.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play425132021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 425132021
		arg_91_1.duration_ = 10.93

		local var_91_0 = {
			zh = 6.3,
			ja = 10.933
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play425132022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.575

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[15].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(425132021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 23
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132021", "story_v_out_425132.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132021", "story_v_out_425132.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_425132", "425132021", "story_v_out_425132.awb")

						arg_91_1:RecordAudio("425132021", var_94_9)
						arg_91_1:RecordAudio("425132021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_425132", "425132021", "story_v_out_425132.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_425132", "425132021", "story_v_out_425132.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play425132022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 425132022
		arg_95_1.duration_ = 9.33

		local var_95_0 = {
			zh = 7.066,
			ja = 9.333
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play425132023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.975

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[15].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(425132022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 39
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132022", "story_v_out_425132.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132022", "story_v_out_425132.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_425132", "425132022", "story_v_out_425132.awb")

						arg_95_1:RecordAudio("425132022", var_98_9)
						arg_95_1:RecordAudio("425132022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_425132", "425132022", "story_v_out_425132.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_425132", "425132022", "story_v_out_425132.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play425132023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 425132023
		arg_99_1.duration_ = 14.3

		local var_99_0 = {
			zh = 10.666,
			ja = 14.3
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play425132024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[15].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(425132023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 40
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132023", "story_v_out_425132.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132023", "story_v_out_425132.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_425132", "425132023", "story_v_out_425132.awb")

						arg_99_1:RecordAudio("425132023", var_102_9)
						arg_99_1:RecordAudio("425132023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_425132", "425132023", "story_v_out_425132.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_425132", "425132023", "story_v_out_425132.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play425132024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 425132024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play425132025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.133333333333333
			local var_106_1 = 1

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_2 = "play"
				local var_106_3 = "effect"

				arg_103_1:AudioAction(var_106_2, var_106_3, "se_story_123_01", "se_story_123_01_wind", "")
			end

			local var_106_4 = 0
			local var_106_5 = 0.8

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(425132024)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_8 = 32
				local var_106_9 = utf8.len(var_106_7)
				local var_106_10 = var_106_8 <= 0 and var_106_5 or var_106_5 * (var_106_9 / var_106_8)

				if var_106_10 > 0 and var_106_5 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_11 and arg_103_1.time_ < var_106_4 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play425132025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 425132025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play425132026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.975

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(425132025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 39
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play425132026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 425132026
		arg_111_1.duration_ = 7.03

		local var_111_0 = {
			zh = 4.966,
			ja = 7.033
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play425132027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "I07a"

			if arg_111_1.bgs_[var_114_0] == nil then
				local var_114_1 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_0)
				var_114_1.name = var_114_0
				var_114_1.transform.parent = arg_111_1.stage_.transform
				var_114_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_[var_114_0] = var_114_1
			end

			local var_114_2 = 2

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				local var_114_3 = manager.ui.mainCamera.transform.localPosition
				local var_114_4 = Vector3.New(0, 0, 10) + Vector3.New(var_114_3.x, var_114_3.y, 0)
				local var_114_5 = arg_111_1.bgs_.I07a

				var_114_5.transform.localPosition = var_114_4
				var_114_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_6 = var_114_5:GetComponent("SpriteRenderer")

				if var_114_6 and var_114_6.sprite then
					local var_114_7 = (var_114_5.transform.localPosition - var_114_3).z
					local var_114_8 = manager.ui.mainCameraCom_
					local var_114_9 = 2 * var_114_7 * Mathf.Tan(var_114_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_114_10 = var_114_9 * var_114_8.aspect
					local var_114_11 = var_114_6.sprite.bounds.size.x
					local var_114_12 = var_114_6.sprite.bounds.size.y
					local var_114_13 = var_114_10 / var_114_11
					local var_114_14 = var_114_9 / var_114_12
					local var_114_15 = var_114_14 < var_114_13 and var_114_13 or var_114_14

					var_114_5.transform.localScale = Vector3.New(var_114_15, var_114_15, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "I07a" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_16 = 4

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_17 = 0.3

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_18 = 0

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_19 = 2

			if var_114_18 <= arg_111_1.time_ and arg_111_1.time_ < var_114_18 + var_114_19 then
				local var_114_20 = (arg_111_1.time_ - var_114_18) / var_114_19
				local var_114_21 = Color.New(0, 0, 0)

				var_114_21.a = Mathf.Lerp(0, 1, var_114_20)
				arg_111_1.mask_.color = var_114_21
			end

			if arg_111_1.time_ >= var_114_18 + var_114_19 and arg_111_1.time_ < var_114_18 + var_114_19 + arg_114_0 then
				local var_114_22 = Color.New(0, 0, 0)

				var_114_22.a = 1
				arg_111_1.mask_.color = var_114_22
			end

			local var_114_23 = 2

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_24 = 2

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 then
				local var_114_25 = (arg_111_1.time_ - var_114_23) / var_114_24
				local var_114_26 = Color.New(0, 0, 0)

				var_114_26.a = Mathf.Lerp(1, 0, var_114_25)
				arg_111_1.mask_.color = var_114_26
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 then
				local var_114_27 = Color.New(0, 0, 0)
				local var_114_28 = 0

				arg_111_1.mask_.enabled = false
				var_114_27.a = var_114_28
				arg_111_1.mask_.color = var_114_27
			end

			local var_114_29 = 0.233333333333333
			local var_114_30 = 1

			if var_114_29 < arg_111_1.time_ and arg_111_1.time_ <= var_114_29 + arg_114_0 then
				local var_114_31 = "stop"
				local var_114_32 = "effect"

				arg_111_1:AudioAction(var_114_31, var_114_32, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_114_33 = 1.66666666666667
			local var_114_34 = 1

			if var_114_33 < arg_111_1.time_ and arg_111_1.time_ <= var_114_33 + arg_114_0 then
				local var_114_35 = "play"
				local var_114_36 = "effect"

				arg_111_1:AudioAction(var_114_35, var_114_36, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_114_37 = 0
			local var_114_38 = 0.3

			if var_114_37 < arg_111_1.time_ and arg_111_1.time_ <= var_114_37 + arg_114_0 then
				local var_114_39 = "play"
				local var_114_40 = "music"

				arg_111_1:AudioAction(var_114_39, var_114_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_114_41 = ""
				local var_114_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_114_42 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_42 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_42

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_42
						arg_111_1.bgmTxt2_.text = var_114_42
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_43 = 1.66666666666667
			local var_114_44 = 1

			if var_114_43 < arg_111_1.time_ and arg_111_1.time_ <= var_114_43 + arg_114_0 then
				local var_114_45 = "play"
				local var_114_46 = "music"

				arg_111_1:AudioAction(var_114_45, var_114_46, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_114_47 = ""
				local var_114_48 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_114_48 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_48 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_48

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_48
						arg_111_1.bgmTxt2_.text = var_114_48
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_49 = manager.ui.mainCamera.transform
			local var_114_50 = 2

			if var_114_50 < arg_111_1.time_ and arg_111_1.time_ <= var_114_50 + arg_114_0 then
				local var_114_51 = arg_111_1.var_.effect2018

				if var_114_51 then
					Object.Destroy(var_114_51)

					arg_111_1.var_.effect2018 = nil
				end
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_52 = 4
			local var_114_53 = 0.05

			if var_114_52 < arg_111_1.time_ and arg_111_1.time_ <= var_114_52 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_54 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_54:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_111_1.dialogCg_.alpha = arg_117_0
				end))
				var_114_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_55 = arg_111_1:FormatText(StoryNameCfg[15].name)

				arg_111_1.leftNameTxt_.text = var_114_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_56 = arg_111_1:GetWordFromCfg(425132026)
				local var_114_57 = arg_111_1:FormatText(var_114_56.content)

				arg_111_1.text_.text = var_114_57

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_58 = 2
				local var_114_59 = utf8.len(var_114_57)
				local var_114_60 = var_114_58 <= 0 and var_114_53 or var_114_53 * (var_114_59 / var_114_58)

				if var_114_60 > 0 and var_114_53 < var_114_60 then
					arg_111_1.talkMaxDuration = var_114_60
					var_114_52 = var_114_52 + 0.3

					if var_114_60 + var_114_52 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_60 + var_114_52
					end
				end

				arg_111_1.text_.text = var_114_57
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132026", "story_v_out_425132.awb") ~= 0 then
					local var_114_61 = manager.audio:GetVoiceLength("story_v_out_425132", "425132026", "story_v_out_425132.awb") / 1000

					if var_114_61 + var_114_52 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_61 + var_114_52
					end

					if var_114_56.prefab_name ~= "" and arg_111_1.actors_[var_114_56.prefab_name] ~= nil then
						local var_114_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_56.prefab_name].transform, "story_v_out_425132", "425132026", "story_v_out_425132.awb")

						arg_111_1:RecordAudio("425132026", var_114_62)
						arg_111_1:RecordAudio("425132026", var_114_62)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_425132", "425132026", "story_v_out_425132.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_425132", "425132026", "story_v_out_425132.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_63 = var_114_52 + 0.3
			local var_114_64 = math.max(var_114_53, arg_111_1.talkMaxDuration)

			if var_114_63 <= arg_111_1.time_ and arg_111_1.time_ < var_114_63 + var_114_64 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_63) / var_114_64

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_63 + var_114_64 and arg_111_1.time_ < var_114_63 + var_114_64 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play425132027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 425132027
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play425132028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.125

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(425132027)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 5
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play425132028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 425132028
		arg_123_1.duration_ = 12.3

		local var_123_0 = {
			zh = 7.766,
			ja = 12.3
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play425132029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "10159"

			if arg_123_1.actors_[var_126_0] == nil then
				local var_126_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10159")

				if not isNil(var_126_1) then
					local var_126_2 = Object.Instantiate(var_126_1, arg_123_1.canvasGo_.transform)

					var_126_2.transform:SetSiblingIndex(1)

					var_126_2.name = var_126_0
					var_126_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_123_1.actors_[var_126_0] = var_126_2

					local var_126_3 = var_126_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_123_1.isInRecall_ then
						for iter_126_0, iter_126_1 in ipairs(var_126_3) do
							iter_126_1.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_126_4 = arg_123_1.actors_["10159"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.actorSpriteComps10159 == nil then
				arg_123_1.var_.actorSpriteComps10159 = var_126_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 0.2

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.actorSpriteComps10159 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								local var_126_8 = Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, var_126_7)
								local var_126_9 = Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, var_126_7)
								local var_126_10 = Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, var_126_7)

								iter_126_3.color = Color.New(var_126_8, var_126_9, var_126_10)
							else
								local var_126_11 = Mathf.Lerp(iter_126_3.color.r, 1, var_126_7)

								iter_126_3.color = Color.New(var_126_11, var_126_11, var_126_11)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.actorSpriteComps10159 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_126_5 then
						if arg_123_1.isInRecall_ then
							iter_126_5.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10159 = nil
			end

			local var_126_12 = arg_123_1.actors_["10159"].transform
			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1.var_.moveOldPos10159 = var_126_12.localPosition
				var_126_12.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10159", 3)

				local var_126_14 = var_126_12.childCount

				for iter_126_6 = 0, var_126_14 - 1 do
					local var_126_15 = var_126_12:GetChild(iter_126_6)

					if var_126_15.name == "" or not string.find(var_126_15.name, "split") then
						var_126_15.gameObject:SetActive(true)
					else
						var_126_15.gameObject:SetActive(false)
					end
				end
			end

			local var_126_16 = 0.001

			if var_126_13 <= arg_123_1.time_ and arg_123_1.time_ < var_126_13 + var_126_16 then
				local var_126_17 = (arg_123_1.time_ - var_126_13) / var_126_16
				local var_126_18 = Vector3.New(0, -415, -230)

				var_126_12.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10159, var_126_18, var_126_17)
			end

			if arg_123_1.time_ >= var_126_13 + var_126_16 and arg_123_1.time_ < var_126_13 + var_126_16 + arg_126_0 then
				var_126_12.localPosition = Vector3.New(0, -415, -230)
			end

			local var_126_19 = 0
			local var_126_20 = 0.85

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_21 = arg_123_1:FormatText(StoryNameCfg[1438].name)

				arg_123_1.leftNameTxt_.text = var_126_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_22 = arg_123_1:GetWordFromCfg(425132028)
				local var_126_23 = arg_123_1:FormatText(var_126_22.content)

				arg_123_1.text_.text = var_126_23

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_24 = 34
				local var_126_25 = utf8.len(var_126_23)
				local var_126_26 = var_126_24 <= 0 and var_126_20 or var_126_20 * (var_126_25 / var_126_24)

				if var_126_26 > 0 and var_126_20 < var_126_26 then
					arg_123_1.talkMaxDuration = var_126_26

					if var_126_26 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_26 + var_126_19
					end
				end

				arg_123_1.text_.text = var_126_23
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132028", "story_v_out_425132.awb") ~= 0 then
					local var_126_27 = manager.audio:GetVoiceLength("story_v_out_425132", "425132028", "story_v_out_425132.awb") / 1000

					if var_126_27 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_27 + var_126_19
					end

					if var_126_22.prefab_name ~= "" and arg_123_1.actors_[var_126_22.prefab_name] ~= nil then
						local var_126_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_22.prefab_name].transform, "story_v_out_425132", "425132028", "story_v_out_425132.awb")

						arg_123_1:RecordAudio("425132028", var_126_28)
						arg_123_1:RecordAudio("425132028", var_126_28)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_425132", "425132028", "story_v_out_425132.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_425132", "425132028", "story_v_out_425132.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_29 = math.max(var_126_20, arg_123_1.talkMaxDuration)

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_29 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_19) / var_126_29

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_19 + var_126_29 and arg_123_1.time_ < var_126_19 + var_126_29 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play425132029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425132029
		arg_127_1.duration_ = 11.4

		local var_127_0 = {
			zh = 8.2,
			ja = 11.4
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play425132030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.925

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[1438].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(425132029)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 37
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132029", "story_v_out_425132.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132029", "story_v_out_425132.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_425132", "425132029", "story_v_out_425132.awb")

						arg_127_1:RecordAudio("425132029", var_130_9)
						arg_127_1:RecordAudio("425132029", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_425132", "425132029", "story_v_out_425132.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_425132", "425132029", "story_v_out_425132.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play425132030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425132030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play425132031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10159"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10159 == nil then
				arg_131_1.var_.actorSpriteComps10159 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10159 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 0.5, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10159 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10159 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.2

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_10 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_11 = arg_131_1:GetWordFromCfg(425132030)
				local var_134_12 = arg_131_1:FormatText(var_134_11.content)

				arg_131_1.text_.text = var_134_12

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 8
				local var_134_14 = utf8.len(var_134_12)
				local var_134_15 = var_134_13 <= 0 and var_134_9 or var_134_9 * (var_134_14 / var_134_13)

				if var_134_15 > 0 and var_134_9 < var_134_15 then
					arg_131_1.talkMaxDuration = var_134_15

					if var_134_15 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_12
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play425132031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425132031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play425132032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.975

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(425132031)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 39
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425132032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425132032
		arg_139_1.duration_ = 6.27

		local var_139_0 = {
			zh = 5.766,
			ja = 6.266
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play425132033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10159"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10159 == nil then
				arg_139_1.var_.actorSpriteComps10159 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10159 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 1, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10159 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10159 = nil
			end

			local var_142_8 = arg_139_1.actors_["10159"].transform
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.var_.moveOldPos10159 = var_142_8.localPosition
				var_142_8.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10159", 3)

				local var_142_10 = var_142_8.childCount

				for iter_142_4 = 0, var_142_10 - 1 do
					local var_142_11 = var_142_8:GetChild(iter_142_4)

					if var_142_11.name == "split_1" or not string.find(var_142_11.name, "split") then
						var_142_11.gameObject:SetActive(true)
					else
						var_142_11.gameObject:SetActive(false)
					end
				end
			end

			local var_142_12 = 0.001

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_12 then
				local var_142_13 = (arg_139_1.time_ - var_142_9) / var_142_12
				local var_142_14 = Vector3.New(0, -415, -230)

				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10159, var_142_14, var_142_13)
			end

			if arg_139_1.time_ >= var_142_9 + var_142_12 and arg_139_1.time_ < var_142_9 + var_142_12 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(0, -415, -230)
			end

			local var_142_15 = 0
			local var_142_16 = 0.5

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[1438].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(425132032)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 20
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132032", "story_v_out_425132.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132032", "story_v_out_425132.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_425132", "425132032", "story_v_out_425132.awb")

						arg_139_1:RecordAudio("425132032", var_142_24)
						arg_139_1:RecordAudio("425132032", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425132", "425132032", "story_v_out_425132.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425132", "425132032", "story_v_out_425132.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play425132033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425132033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play425132034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10159"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10159 == nil then
				arg_143_1.var_.actorSpriteComps10159 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps10159 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_4 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, var_146_3)
								local var_146_5 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, var_146_3)
								local var_146_6 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, var_146_3)

								iter_146_1.color = Color.New(var_146_4, var_146_5, var_146_6)
							else
								local var_146_7 = Mathf.Lerp(iter_146_1.color.r, 0.5, var_146_3)

								iter_146_1.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10159 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10159 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 0.4

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_10 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_11 = arg_143_1:GetWordFromCfg(425132033)
				local var_146_12 = arg_143_1:FormatText(var_146_11.content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 16
				local var_146_14 = utf8.len(var_146_12)
				local var_146_15 = var_146_13 <= 0 and var_146_9 or var_146_9 * (var_146_14 / var_146_13)

				if var_146_15 > 0 and var_146_9 < var_146_15 then
					arg_143_1.talkMaxDuration = var_146_15

					if var_146_15 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_15 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play425132034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425132034
		arg_147_1.duration_ = 3.03

		local var_147_0 = {
			zh = 1.6,
			ja = 3.033
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play425132035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.35

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[15].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(425132034)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 14
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132034", "story_v_out_425132.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132034", "story_v_out_425132.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_425132", "425132034", "story_v_out_425132.awb")

						arg_147_1:RecordAudio("425132034", var_150_9)
						arg_147_1:RecordAudio("425132034", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425132", "425132034", "story_v_out_425132.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425132", "425132034", "story_v_out_425132.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play425132035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425132035
		arg_151_1.duration_ = 2.5

		local var_151_0 = {
			zh = 2.366,
			ja = 2.5
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play425132036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10159"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10159 == nil then
				arg_151_1.var_.actorSpriteComps10159 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10159 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10159 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10159 = nil
			end

			local var_154_8 = arg_151_1.actors_["10159"].transform
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.var_.moveOldPos10159 = var_154_8.localPosition
				var_154_8.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10159", 3)

				local var_154_10 = var_154_8.childCount

				for iter_154_4 = 0, var_154_10 - 1 do
					local var_154_11 = var_154_8:GetChild(iter_154_4)

					if var_154_11.name == "" then
						var_154_11:SetAsLastSibling()
						var_154_11.gameObject:SetActive(true)

						arg_151_1.var_.actorSpriteSplit10159 = var_154_11.gameObject:GetComponent(typeof(Image))

						arg_151_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_154_12 = 0.5

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_12 then
				local var_154_13 = (arg_151_1.time_ - var_154_9) / var_154_12
				local var_154_14 = Vector3.New(0, -415, -230)

				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10159, var_154_14, var_154_13)

				if arg_151_1.var_.actorSpriteSplit10159 ~= nil then
					arg_151_1.var_.actorSpriteSplit10159:SetAlpha(var_154_13)
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_12 and arg_151_1.time_ < var_154_9 + var_154_12 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(0, -415, -230)

				if arg_151_1.var_.actorSpriteSplit10159 ~= nil then
					arg_151_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_154_15 = 0
			local var_154_16 = 0.15

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[1438].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(425132035)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 6
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132035", "story_v_out_425132.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132035", "story_v_out_425132.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_425132", "425132035", "story_v_out_425132.awb")

						arg_151_1:RecordAudio("425132035", var_154_24)
						arg_151_1:RecordAudio("425132035", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425132", "425132035", "story_v_out_425132.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425132", "425132035", "story_v_out_425132.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play425132036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425132036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play425132037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10159"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10159 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10159", 7)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(0, -2000, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10159, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_158_7 = 0
			local var_158_8 = 1.125

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(425132036)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 45
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_8 or var_158_8 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_8 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_7
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_8, arg_155_1.talkMaxDuration)

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_7) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_7 + var_158_14 and arg_155_1.time_ < var_158_7 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play425132037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425132037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play425132038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.275

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(425132037)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 11
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play425132038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425132038
		arg_163_1.duration_ = 3.4

		local var_163_0 = {
			zh = 2.266,
			ja = 3.4
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play425132039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "1037"

			if arg_163_1.actors_[var_166_0] == nil then
				local var_166_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_166_1) then
					local var_166_2 = Object.Instantiate(var_166_1, arg_163_1.canvasGo_.transform)

					var_166_2.transform:SetSiblingIndex(1)

					var_166_2.name = var_166_0
					var_166_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_163_1.actors_[var_166_0] = var_166_2

					local var_166_3 = var_166_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_163_1.isInRecall_ then
						for iter_166_0, iter_166_1 in ipairs(var_166_3) do
							iter_166_1.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_166_4 = arg_163_1.actors_["1037"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps1037 == nil then
				arg_163_1.var_.actorSpriteComps1037 = var_166_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 0.2

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.actorSpriteComps1037 then
					for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_166_3 then
							if arg_163_1.isInRecall_ then
								local var_166_8 = Mathf.Lerp(iter_166_3.color.r, arg_163_1.hightColor1.r, var_166_7)
								local var_166_9 = Mathf.Lerp(iter_166_3.color.g, arg_163_1.hightColor1.g, var_166_7)
								local var_166_10 = Mathf.Lerp(iter_166_3.color.b, arg_163_1.hightColor1.b, var_166_7)

								iter_166_3.color = Color.New(var_166_8, var_166_9, var_166_10)
							else
								local var_166_11 = Mathf.Lerp(iter_166_3.color.r, 1, var_166_7)

								iter_166_3.color = Color.New(var_166_11, var_166_11, var_166_11)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps1037 then
				for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_166_5 then
						if arg_163_1.isInRecall_ then
							iter_166_5.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1037 = nil
			end

			local var_166_12 = arg_163_1.actors_["1037"].transform
			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1.var_.moveOldPos1037 = var_166_12.localPosition
				var_166_12.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1037", 3)

				local var_166_14 = var_166_12.childCount

				for iter_166_6 = 0, var_166_14 - 1 do
					local var_166_15 = var_166_12:GetChild(iter_166_6)

					if var_166_15.name == "split_4" or not string.find(var_166_15.name, "split") then
						var_166_15.gameObject:SetActive(true)
					else
						var_166_15.gameObject:SetActive(false)
					end
				end
			end

			local var_166_16 = 0.001

			if var_166_13 <= arg_163_1.time_ and arg_163_1.time_ < var_166_13 + var_166_16 then
				local var_166_17 = (arg_163_1.time_ - var_166_13) / var_166_16
				local var_166_18 = Vector3.New(0, -430, -55)

				var_166_12.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1037, var_166_18, var_166_17)
			end

			if arg_163_1.time_ >= var_166_13 + var_166_16 and arg_163_1.time_ < var_166_13 + var_166_16 + arg_166_0 then
				var_166_12.localPosition = Vector3.New(0, -430, -55)
			end

			local var_166_19 = 0
			local var_166_20 = 0.1

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_21 = arg_163_1:FormatText(StoryNameCfg[15].name)

				arg_163_1.leftNameTxt_.text = var_166_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_22 = arg_163_1:GetWordFromCfg(425132038)
				local var_166_23 = arg_163_1:FormatText(var_166_22.content)

				arg_163_1.text_.text = var_166_23

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_24 = 4
				local var_166_25 = utf8.len(var_166_23)
				local var_166_26 = var_166_24 <= 0 and var_166_20 or var_166_20 * (var_166_25 / var_166_24)

				if var_166_26 > 0 and var_166_20 < var_166_26 then
					arg_163_1.talkMaxDuration = var_166_26

					if var_166_26 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_26 + var_166_19
					end
				end

				arg_163_1.text_.text = var_166_23
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132038", "story_v_out_425132.awb") ~= 0 then
					local var_166_27 = manager.audio:GetVoiceLength("story_v_out_425132", "425132038", "story_v_out_425132.awb") / 1000

					if var_166_27 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_27 + var_166_19
					end

					if var_166_22.prefab_name ~= "" and arg_163_1.actors_[var_166_22.prefab_name] ~= nil then
						local var_166_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_22.prefab_name].transform, "story_v_out_425132", "425132038", "story_v_out_425132.awb")

						arg_163_1:RecordAudio("425132038", var_166_28)
						arg_163_1:RecordAudio("425132038", var_166_28)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_425132", "425132038", "story_v_out_425132.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_425132", "425132038", "story_v_out_425132.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_29 = math.max(var_166_20, arg_163_1.talkMaxDuration)

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_29 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_19) / var_166_29

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_19 + var_166_29 and arg_163_1.time_ < var_166_19 + var_166_29 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play425132039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425132039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play425132040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1037"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1037 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1037", 7)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(1500, -2000, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1037, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_170_7 = 0
			local var_170_8 = 1.225

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_9 = arg_167_1:GetWordFromCfg(425132039)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 49
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_8 or var_170_8 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_8 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_7
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_8, arg_167_1.talkMaxDuration)

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_7) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_7 + var_170_14 and arg_167_1.time_ < var_170_7 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play425132040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425132040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play425132041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.075

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(425132040)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 43
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play425132041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425132041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play425132042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.425

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(425132041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 17
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play425132042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 425132042
		arg_179_1.duration_ = 3.67

		local var_179_0 = {
			zh = 3.666,
			ja = 3.466
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play425132043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1037"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1037 == nil then
				arg_179_1.var_.actorSpriteComps1037 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps1037 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 1, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1037 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1037 = nil
			end

			local var_182_8 = arg_179_1.actors_["1037"].transform
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1.var_.moveOldPos1037 = var_182_8.localPosition
				var_182_8.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1037", 3)

				local var_182_10 = var_182_8.childCount

				for iter_182_4 = 0, var_182_10 - 1 do
					local var_182_11 = var_182_8:GetChild(iter_182_4)

					if var_182_11.name == "split_1" or not string.find(var_182_11.name, "split") then
						var_182_11.gameObject:SetActive(true)
					else
						var_182_11.gameObject:SetActive(false)
					end
				end
			end

			local var_182_12 = 0.001

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_12 then
				local var_182_13 = (arg_179_1.time_ - var_182_9) / var_182_12
				local var_182_14 = Vector3.New(0, -430, -55)

				var_182_8.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1037, var_182_14, var_182_13)
			end

			if arg_179_1.time_ >= var_182_9 + var_182_12 and arg_179_1.time_ < var_182_9 + var_182_12 + arg_182_0 then
				var_182_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_182_15 = 0
			local var_182_16 = 0.225

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[15].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(425132042)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 9
				local var_182_21 = utf8.len(var_182_19)
				local var_182_22 = var_182_20 <= 0 and var_182_16 or var_182_16 * (var_182_21 / var_182_20)

				if var_182_22 > 0 and var_182_16 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22

					if var_182_22 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132042", "story_v_out_425132.awb") ~= 0 then
					local var_182_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132042", "story_v_out_425132.awb") / 1000

					if var_182_23 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_15
					end

					if var_182_18.prefab_name ~= "" and arg_179_1.actors_[var_182_18.prefab_name] ~= nil then
						local var_182_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_18.prefab_name].transform, "story_v_out_425132", "425132042", "story_v_out_425132.awb")

						arg_179_1:RecordAudio("425132042", var_182_24)
						arg_179_1:RecordAudio("425132042", var_182_24)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_425132", "425132042", "story_v_out_425132.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_425132", "425132042", "story_v_out_425132.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_25 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_25 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_25

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_25 and arg_179_1.time_ < var_182_15 + var_182_25 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play425132043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 425132043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play425132044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1037"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1037 == nil then
				arg_183_1.var_.actorSpriteComps1037 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps1037 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 0.5, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1037 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1037 = nil
			end

			local var_186_8 = 0
			local var_186_9 = 0.175

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_10 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_11 = arg_183_1:GetWordFromCfg(425132043)
				local var_186_12 = arg_183_1:FormatText(var_186_11.content)

				arg_183_1.text_.text = var_186_12

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 7
				local var_186_14 = utf8.len(var_186_12)
				local var_186_15 = var_186_13 <= 0 and var_186_9 or var_186_9 * (var_186_14 / var_186_13)

				if var_186_15 > 0 and var_186_9 < var_186_15 then
					arg_183_1.talkMaxDuration = var_186_15

					if var_186_15 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_15 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_12
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play425132044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 425132044
		arg_187_1.duration_ = 5.87

		local var_187_0 = {
			zh = 5.5,
			ja = 5.866
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play425132045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = "ST2106"

			if arg_187_1.bgs_[var_190_0] == nil then
				local var_190_1 = Object.Instantiate(arg_187_1.paintGo_)

				var_190_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_190_0)
				var_190_1.name = var_190_0
				var_190_1.transform.parent = arg_187_1.stage_.transform
				var_190_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.bgs_[var_190_0] = var_190_1
			end

			local var_190_2 = 2

			if var_190_2 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				local var_190_3 = manager.ui.mainCamera.transform.localPosition
				local var_190_4 = Vector3.New(0, 0, 10) + Vector3.New(var_190_3.x, var_190_3.y, 0)
				local var_190_5 = arg_187_1.bgs_.ST2106

				var_190_5.transform.localPosition = var_190_4
				var_190_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_6 = var_190_5:GetComponent("SpriteRenderer")

				if var_190_6 and var_190_6.sprite then
					local var_190_7 = (var_190_5.transform.localPosition - var_190_3).z
					local var_190_8 = manager.ui.mainCameraCom_
					local var_190_9 = 2 * var_190_7 * Mathf.Tan(var_190_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_10 = var_190_9 * var_190_8.aspect
					local var_190_11 = var_190_6.sprite.bounds.size.x
					local var_190_12 = var_190_6.sprite.bounds.size.y
					local var_190_13 = var_190_10 / var_190_11
					local var_190_14 = var_190_9 / var_190_12
					local var_190_15 = var_190_14 < var_190_13 and var_190_13 or var_190_14

					var_190_5.transform.localScale = Vector3.New(var_190_15, var_190_15, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST2106" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_16 = 4

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_17 = 0.3

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_18 = 0

			if var_190_18 < arg_187_1.time_ and arg_187_1.time_ <= var_190_18 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_19 = 2

			if var_190_18 <= arg_187_1.time_ and arg_187_1.time_ < var_190_18 + var_190_19 then
				local var_190_20 = (arg_187_1.time_ - var_190_18) / var_190_19
				local var_190_21 = Color.New(0, 0, 0)

				var_190_21.a = Mathf.Lerp(0, 1, var_190_20)
				arg_187_1.mask_.color = var_190_21
			end

			if arg_187_1.time_ >= var_190_18 + var_190_19 and arg_187_1.time_ < var_190_18 + var_190_19 + arg_190_0 then
				local var_190_22 = Color.New(0, 0, 0)

				var_190_22.a = 1
				arg_187_1.mask_.color = var_190_22
			end

			local var_190_23 = 2

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_24 = 2

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_24 then
				local var_190_25 = (arg_187_1.time_ - var_190_23) / var_190_24
				local var_190_26 = Color.New(0, 0, 0)

				var_190_26.a = Mathf.Lerp(1, 0, var_190_25)
				arg_187_1.mask_.color = var_190_26
			end

			if arg_187_1.time_ >= var_190_23 + var_190_24 and arg_187_1.time_ < var_190_23 + var_190_24 + arg_190_0 then
				local var_190_27 = Color.New(0, 0, 0)
				local var_190_28 = 0

				arg_187_1.mask_.enabled = false
				var_190_27.a = var_190_28
				arg_187_1.mask_.color = var_190_27
			end

			local var_190_29 = arg_187_1.actors_["10159"]
			local var_190_30 = 3.8

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 and not isNil(var_190_29) and arg_187_1.var_.actorSpriteComps10159 == nil then
				arg_187_1.var_.actorSpriteComps10159 = var_190_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_31 = 0.2

			if var_190_30 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_31 and not isNil(var_190_29) then
				local var_190_32 = (arg_187_1.time_ - var_190_30) / var_190_31

				if arg_187_1.var_.actorSpriteComps10159 then
					for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_190_3 then
							if arg_187_1.isInRecall_ then
								local var_190_33 = Mathf.Lerp(iter_190_3.color.r, arg_187_1.hightColor1.r, var_190_32)
								local var_190_34 = Mathf.Lerp(iter_190_3.color.g, arg_187_1.hightColor1.g, var_190_32)
								local var_190_35 = Mathf.Lerp(iter_190_3.color.b, arg_187_1.hightColor1.b, var_190_32)

								iter_190_3.color = Color.New(var_190_33, var_190_34, var_190_35)
							else
								local var_190_36 = Mathf.Lerp(iter_190_3.color.r, 1, var_190_32)

								iter_190_3.color = Color.New(var_190_36, var_190_36, var_190_36)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_30 + var_190_31 and arg_187_1.time_ < var_190_30 + var_190_31 + arg_190_0 and not isNil(var_190_29) and arg_187_1.var_.actorSpriteComps10159 then
				for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_190_5 then
						if arg_187_1.isInRecall_ then
							iter_190_5.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10159 = nil
			end

			local var_190_37 = arg_187_1.actors_["1037"].transform
			local var_190_38 = 2

			if var_190_38 < arg_187_1.time_ and arg_187_1.time_ <= var_190_38 + arg_190_0 then
				arg_187_1.var_.moveOldPos1037 = var_190_37.localPosition
				var_190_37.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1037", 7)

				local var_190_39 = var_190_37.childCount

				for iter_190_6 = 0, var_190_39 - 1 do
					local var_190_40 = var_190_37:GetChild(iter_190_6)

					if var_190_40.name == "" or not string.find(var_190_40.name, "split") then
						var_190_40.gameObject:SetActive(true)
					else
						var_190_40.gameObject:SetActive(false)
					end
				end
			end

			local var_190_41 = 0.001

			if var_190_38 <= arg_187_1.time_ and arg_187_1.time_ < var_190_38 + var_190_41 then
				local var_190_42 = (arg_187_1.time_ - var_190_38) / var_190_41
				local var_190_43 = Vector3.New(1500, -2000, 0)

				var_190_37.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1037, var_190_43, var_190_42)
			end

			if arg_187_1.time_ >= var_190_38 + var_190_41 and arg_187_1.time_ < var_190_38 + var_190_41 + arg_190_0 then
				var_190_37.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_190_44 = arg_187_1.actors_["10159"].transform
			local var_190_45 = 3.8

			if var_190_45 < arg_187_1.time_ and arg_187_1.time_ <= var_190_45 + arg_190_0 then
				arg_187_1.var_.moveOldPos10159 = var_190_44.localPosition
				var_190_44.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10159", 3)

				local var_190_46 = var_190_44.childCount

				for iter_190_7 = 0, var_190_46 - 1 do
					local var_190_47 = var_190_44:GetChild(iter_190_7)

					if var_190_47.name == "" or not string.find(var_190_47.name, "split") then
						var_190_47.gameObject:SetActive(true)
					else
						var_190_47.gameObject:SetActive(false)
					end
				end
			end

			local var_190_48 = 0.001

			if var_190_45 <= arg_187_1.time_ and arg_187_1.time_ < var_190_45 + var_190_48 then
				local var_190_49 = (arg_187_1.time_ - var_190_45) / var_190_48
				local var_190_50 = Vector3.New(0, -415, -230)

				var_190_44.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10159, var_190_50, var_190_49)
			end

			if arg_187_1.time_ >= var_190_45 + var_190_48 and arg_187_1.time_ < var_190_45 + var_190_48 + arg_190_0 then
				var_190_44.localPosition = Vector3.New(0, -415, -230)
			end

			local var_190_51 = 0.133333333333333
			local var_190_52 = 1

			if var_190_51 < arg_187_1.time_ and arg_187_1.time_ <= var_190_51 + arg_190_0 then
				local var_190_53 = "stop"
				local var_190_54 = "effect"

				arg_187_1:AudioAction(var_190_53, var_190_54, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_190_55 = 1.7
			local var_190_56 = 1

			if var_190_55 < arg_187_1.time_ and arg_187_1.time_ <= var_190_55 + arg_190_0 then
				local var_190_57 = "play"
				local var_190_58 = "effect"

				arg_187_1:AudioAction(var_190_57, var_190_58, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_59 = 4
			local var_190_60 = 0.125

			if var_190_59 < arg_187_1.time_ and arg_187_1.time_ <= var_190_59 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_61 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_61:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_62 = arg_187_1:FormatText(StoryNameCfg[1438].name)

				arg_187_1.leftNameTxt_.text = var_190_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_63 = arg_187_1:GetWordFromCfg(425132044)
				local var_190_64 = arg_187_1:FormatText(var_190_63.content)

				arg_187_1.text_.text = var_190_64

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_65 = 5
				local var_190_66 = utf8.len(var_190_64)
				local var_190_67 = var_190_65 <= 0 and var_190_60 or var_190_60 * (var_190_66 / var_190_65)

				if var_190_67 > 0 and var_190_60 < var_190_67 then
					arg_187_1.talkMaxDuration = var_190_67
					var_190_59 = var_190_59 + 0.3

					if var_190_67 + var_190_59 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_67 + var_190_59
					end
				end

				arg_187_1.text_.text = var_190_64
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132044", "story_v_out_425132.awb") ~= 0 then
					local var_190_68 = manager.audio:GetVoiceLength("story_v_out_425132", "425132044", "story_v_out_425132.awb") / 1000

					if var_190_68 + var_190_59 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_68 + var_190_59
					end

					if var_190_63.prefab_name ~= "" and arg_187_1.actors_[var_190_63.prefab_name] ~= nil then
						local var_190_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_63.prefab_name].transform, "story_v_out_425132", "425132044", "story_v_out_425132.awb")

						arg_187_1:RecordAudio("425132044", var_190_69)
						arg_187_1:RecordAudio("425132044", var_190_69)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_425132", "425132044", "story_v_out_425132.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_425132", "425132044", "story_v_out_425132.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_70 = var_190_59 + 0.3
			local var_190_71 = math.max(var_190_60, arg_187_1.talkMaxDuration)

			if var_190_70 <= arg_187_1.time_ and arg_187_1.time_ < var_190_70 + var_190_71 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_70) / var_190_71

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_70 + var_190_71 and arg_187_1.time_ < var_190_70 + var_190_71 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play425132045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 425132045
		arg_193_1.duration_ = 9.3

		local var_193_0 = {
			zh = 4.633,
			ja = 9.3
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play425132046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1037"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1037 == nil then
				arg_193_1.var_.actorSpriteComps1037 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1037 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 1, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1037 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1037 = nil
			end

			local var_196_8 = arg_193_1.actors_["10159"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10159 == nil then
				arg_193_1.var_.actorSpriteComps10159 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.2

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10159 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 0.5, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10159 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10159 = nil
			end

			local var_196_16 = arg_193_1.actors_["1037"].transform
			local var_196_17 = 0

			if var_196_17 < arg_193_1.time_ and arg_193_1.time_ <= var_196_17 + arg_196_0 then
				arg_193_1.var_.moveOldPos1037 = var_196_16.localPosition
				var_196_16.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1037", 4)

				local var_196_18 = var_196_16.childCount

				for iter_196_8 = 0, var_196_18 - 1 do
					local var_196_19 = var_196_16:GetChild(iter_196_8)

					if var_196_19.name == "" or not string.find(var_196_19.name, "split") then
						var_196_19.gameObject:SetActive(true)
					else
						var_196_19.gameObject:SetActive(false)
					end
				end
			end

			local var_196_20 = 0.001

			if var_196_17 <= arg_193_1.time_ and arg_193_1.time_ < var_196_17 + var_196_20 then
				local var_196_21 = (arg_193_1.time_ - var_196_17) / var_196_20
				local var_196_22 = Vector3.New(390, -430, -55)

				var_196_16.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1037, var_196_22, var_196_21)
			end

			if arg_193_1.time_ >= var_196_17 + var_196_20 and arg_193_1.time_ < var_196_17 + var_196_20 + arg_196_0 then
				var_196_16.localPosition = Vector3.New(390, -430, -55)
			end

			local var_196_23 = arg_193_1.actors_["10159"].transform
			local var_196_24 = 0

			if var_196_24 < arg_193_1.time_ and arg_193_1.time_ <= var_196_24 + arg_196_0 then
				arg_193_1.var_.moveOldPos10159 = var_196_23.localPosition
				var_196_23.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10159", 2)

				local var_196_25 = var_196_23.childCount

				for iter_196_9 = 0, var_196_25 - 1 do
					local var_196_26 = var_196_23:GetChild(iter_196_9)

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
				local var_196_29 = Vector3.New(-390, -415, -230)

				var_196_23.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10159, var_196_29, var_196_28)
			end

			if arg_193_1.time_ >= var_196_24 + var_196_27 and arg_193_1.time_ < var_196_24 + var_196_27 + arg_196_0 then
				var_196_23.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_196_30 = 0
			local var_196_31 = 0.4

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_32 = arg_193_1:FormatText(StoryNameCfg[15].name)

				arg_193_1.leftNameTxt_.text = var_196_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_33 = arg_193_1:GetWordFromCfg(425132045)
				local var_196_34 = arg_193_1:FormatText(var_196_33.content)

				arg_193_1.text_.text = var_196_34

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_35 = 16
				local var_196_36 = utf8.len(var_196_34)
				local var_196_37 = var_196_35 <= 0 and var_196_31 or var_196_31 * (var_196_36 / var_196_35)

				if var_196_37 > 0 and var_196_31 < var_196_37 then
					arg_193_1.talkMaxDuration = var_196_37

					if var_196_37 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_37 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_34
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132045", "story_v_out_425132.awb") ~= 0 then
					local var_196_38 = manager.audio:GetVoiceLength("story_v_out_425132", "425132045", "story_v_out_425132.awb") / 1000

					if var_196_38 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_38 + var_196_30
					end

					if var_196_33.prefab_name ~= "" and arg_193_1.actors_[var_196_33.prefab_name] ~= nil then
						local var_196_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_33.prefab_name].transform, "story_v_out_425132", "425132045", "story_v_out_425132.awb")

						arg_193_1:RecordAudio("425132045", var_196_39)
						arg_193_1:RecordAudio("425132045", var_196_39)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_425132", "425132045", "story_v_out_425132.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_425132", "425132045", "story_v_out_425132.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_40 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_40 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_40

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_40 and arg_193_1.time_ < var_196_30 + var_196_40 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play425132046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 425132046
		arg_197_1.duration_ = 4.73

		local var_197_0 = {
			zh = 4,
			ja = 4.733
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play425132047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10159"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10159 == nil then
				arg_197_1.var_.actorSpriteComps10159 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps10159 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 1, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10159 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10159 = nil
			end

			local var_200_8 = arg_197_1.actors_["1037"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps1037 == nil then
				arg_197_1.var_.actorSpriteComps1037 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps1037 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 0.5, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps1037 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1037 = nil
			end

			local var_200_16 = 0
			local var_200_17 = 0.425

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_18 = arg_197_1:FormatText(StoryNameCfg[1438].name)

				arg_197_1.leftNameTxt_.text = var_200_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:GetWordFromCfg(425132046)
				local var_200_20 = arg_197_1:FormatText(var_200_19.content)

				arg_197_1.text_.text = var_200_20

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 17
				local var_200_22 = utf8.len(var_200_20)
				local var_200_23 = var_200_21 <= 0 and var_200_17 or var_200_17 * (var_200_22 / var_200_21)

				if var_200_23 > 0 and var_200_17 < var_200_23 then
					arg_197_1.talkMaxDuration = var_200_23

					if var_200_23 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_20
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132046", "story_v_out_425132.awb") ~= 0 then
					local var_200_24 = manager.audio:GetVoiceLength("story_v_out_425132", "425132046", "story_v_out_425132.awb") / 1000

					if var_200_24 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_24 + var_200_16
					end

					if var_200_19.prefab_name ~= "" and arg_197_1.actors_[var_200_19.prefab_name] ~= nil then
						local var_200_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_19.prefab_name].transform, "story_v_out_425132", "425132046", "story_v_out_425132.awb")

						arg_197_1:RecordAudio("425132046", var_200_25)
						arg_197_1:RecordAudio("425132046", var_200_25)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_425132", "425132046", "story_v_out_425132.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_425132", "425132046", "story_v_out_425132.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_26 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_16) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_16 + var_200_26 and arg_197_1.time_ < var_200_16 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play425132047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 425132047
		arg_201_1.duration_ = 8.77

		local var_201_0 = {
			zh = 6.066,
			ja = 8.766
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play425132048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.575

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[1438].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(425132047)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 23
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132047", "story_v_out_425132.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_425132", "425132047", "story_v_out_425132.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_425132", "425132047", "story_v_out_425132.awb")

						arg_201_1:RecordAudio("425132047", var_204_9)
						arg_201_1:RecordAudio("425132047", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_425132", "425132047", "story_v_out_425132.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_425132", "425132047", "story_v_out_425132.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play425132048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 425132048
		arg_205_1.duration_ = 12.1

		local var_205_0 = {
			zh = 9.1,
			ja = 12.1
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play425132049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1037"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1037 == nil then
				arg_205_1.var_.actorSpriteComps1037 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1037 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 1, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1037 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1037 = nil
			end

			local var_208_8 = arg_205_1.actors_["10159"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10159 == nil then
				arg_205_1.var_.actorSpriteComps10159 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 0.2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps10159 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_12 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, var_208_11)
								local var_208_13 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, var_208_11)
								local var_208_14 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, var_208_11)

								iter_208_5.color = Color.New(var_208_12, var_208_13, var_208_14)
							else
								local var_208_15 = Mathf.Lerp(iter_208_5.color.r, 0.5, var_208_11)

								iter_208_5.color = Color.New(var_208_15, var_208_15, var_208_15)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10159 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10159 = nil
			end

			local var_208_16 = 0
			local var_208_17 = 0.85

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_18 = arg_205_1:FormatText(StoryNameCfg[15].name)

				arg_205_1.leftNameTxt_.text = var_208_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:GetWordFromCfg(425132048)
				local var_208_20 = arg_205_1:FormatText(var_208_19.content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 34
				local var_208_22 = utf8.len(var_208_20)
				local var_208_23 = var_208_21 <= 0 and var_208_17 or var_208_17 * (var_208_22 / var_208_21)

				if var_208_23 > 0 and var_208_17 < var_208_23 then
					arg_205_1.talkMaxDuration = var_208_23

					if var_208_23 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132048", "story_v_out_425132.awb") ~= 0 then
					local var_208_24 = manager.audio:GetVoiceLength("story_v_out_425132", "425132048", "story_v_out_425132.awb") / 1000

					if var_208_24 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_16
					end

					if var_208_19.prefab_name ~= "" and arg_205_1.actors_[var_208_19.prefab_name] ~= nil then
						local var_208_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_19.prefab_name].transform, "story_v_out_425132", "425132048", "story_v_out_425132.awb")

						arg_205_1:RecordAudio("425132048", var_208_25)
						arg_205_1:RecordAudio("425132048", var_208_25)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_425132", "425132048", "story_v_out_425132.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_425132", "425132048", "story_v_out_425132.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_26 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_26 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_16) / var_208_26

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_16 + var_208_26 and arg_205_1.time_ < var_208_16 + var_208_26 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play425132049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 425132049
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play425132050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1037"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1037 == nil then
				arg_209_1.var_.actorSpriteComps1037 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1037 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1037 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1037 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.75

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_11 = arg_209_1:GetWordFromCfg(425132049)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 30
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_9 or var_212_9 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_9 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play425132050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 425132050
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play425132051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.325

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(425132050)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 13
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play425132051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 425132051
		arg_217_1.duration_ = 7.17

		local var_217_0 = {
			zh = 7.166,
			ja = 6.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play425132052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1037"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1037 == nil then
				arg_217_1.var_.actorSpriteComps1037 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps1037 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 1, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1037 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1037 = nil
			end

			local var_220_8 = arg_217_1.actors_["1037"].transform
			local var_220_9 = 0

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 then
				arg_217_1.var_.moveOldPos1037 = var_220_8.localPosition
				var_220_8.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1037", 4)

				local var_220_10 = var_220_8.childCount

				for iter_220_4 = 0, var_220_10 - 1 do
					local var_220_11 = var_220_8:GetChild(iter_220_4)

					if var_220_11.name == "split_3" then
						var_220_11:SetAsLastSibling()
						var_220_11.gameObject:SetActive(true)

						arg_217_1.var_.actorSpriteSplit1037 = var_220_11.gameObject:GetComponent(typeof(Image))

						arg_217_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_220_12 = 0.5

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_12 then
				local var_220_13 = (arg_217_1.time_ - var_220_9) / var_220_12
				local var_220_14 = Vector3.New(390, -430, -55)

				var_220_8.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1037, var_220_14, var_220_13)

				if arg_217_1.var_.actorSpriteSplit1037 ~= nil then
					arg_217_1.var_.actorSpriteSplit1037:SetAlpha(var_220_13)
				end
			end

			if arg_217_1.time_ >= var_220_9 + var_220_12 and arg_217_1.time_ < var_220_9 + var_220_12 + arg_220_0 then
				var_220_8.localPosition = Vector3.New(390, -430, -55)

				if arg_217_1.var_.actorSpriteSplit1037 ~= nil then
					arg_217_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_220_15 = 0
			local var_220_16 = 0.625

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[15].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(425132051)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 25
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132051", "story_v_out_425132.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_425132", "425132051", "story_v_out_425132.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_425132", "425132051", "story_v_out_425132.awb")

						arg_217_1:RecordAudio("425132051", var_220_24)
						arg_217_1:RecordAudio("425132051", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_425132", "425132051", "story_v_out_425132.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_425132", "425132051", "story_v_out_425132.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425132052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 425132052
		arg_221_1.duration_ = 7.07

		local var_221_0 = {
			zh = 6.666,
			ja = 7.066
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play425132053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10159"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10159 == nil then
				arg_221_1.var_.actorSpriteComps10159 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10159 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 1, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10159 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10159 = nil
			end

			local var_224_8 = arg_221_1.actors_["1037"]
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1037 == nil then
				arg_221_1.var_.actorSpriteComps1037 = var_224_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_10 = 0.2

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 and not isNil(var_224_8) then
				local var_224_11 = (arg_221_1.time_ - var_224_9) / var_224_10

				if arg_221_1.var_.actorSpriteComps1037 then
					for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_224_5 then
							if arg_221_1.isInRecall_ then
								local var_224_12 = Mathf.Lerp(iter_224_5.color.r, arg_221_1.hightColor2.r, var_224_11)
								local var_224_13 = Mathf.Lerp(iter_224_5.color.g, arg_221_1.hightColor2.g, var_224_11)
								local var_224_14 = Mathf.Lerp(iter_224_5.color.b, arg_221_1.hightColor2.b, var_224_11)

								iter_224_5.color = Color.New(var_224_12, var_224_13, var_224_14)
							else
								local var_224_15 = Mathf.Lerp(iter_224_5.color.r, 0.5, var_224_11)

								iter_224_5.color = Color.New(var_224_15, var_224_15, var_224_15)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1037 then
				for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_224_7 then
						if arg_221_1.isInRecall_ then
							iter_224_7.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1037 = nil
			end

			local var_224_16 = 0
			local var_224_17 = 0.4

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_18 = arg_221_1:FormatText(StoryNameCfg[1438].name)

				arg_221_1.leftNameTxt_.text = var_224_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_19 = arg_221_1:GetWordFromCfg(425132052)
				local var_224_20 = arg_221_1:FormatText(var_224_19.content)

				arg_221_1.text_.text = var_224_20

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_21 = 16
				local var_224_22 = utf8.len(var_224_20)
				local var_224_23 = var_224_21 <= 0 and var_224_17 or var_224_17 * (var_224_22 / var_224_21)

				if var_224_23 > 0 and var_224_17 < var_224_23 then
					arg_221_1.talkMaxDuration = var_224_23

					if var_224_23 + var_224_16 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_16
					end
				end

				arg_221_1.text_.text = var_224_20
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132052", "story_v_out_425132.awb") ~= 0 then
					local var_224_24 = manager.audio:GetVoiceLength("story_v_out_425132", "425132052", "story_v_out_425132.awb") / 1000

					if var_224_24 + var_224_16 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_24 + var_224_16
					end

					if var_224_19.prefab_name ~= "" and arg_221_1.actors_[var_224_19.prefab_name] ~= nil then
						local var_224_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_19.prefab_name].transform, "story_v_out_425132", "425132052", "story_v_out_425132.awb")

						arg_221_1:RecordAudio("425132052", var_224_25)
						arg_221_1:RecordAudio("425132052", var_224_25)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_425132", "425132052", "story_v_out_425132.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_425132", "425132052", "story_v_out_425132.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_26 = math.max(var_224_17, arg_221_1.talkMaxDuration)

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_26 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_16) / var_224_26

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_16 + var_224_26 and arg_221_1.time_ < var_224_16 + var_224_26 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play425132053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 425132053
		arg_225_1.duration_ = 1.17

		local var_225_0 = {
			zh = 0.999999999999,
			ja = 1.166
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play425132054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1037"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1037 == nil then
				arg_225_1.var_.actorSpriteComps1037 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps1037 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1037 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1037 = nil
			end

			local var_228_8 = arg_225_1.actors_["10159"]
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10159 == nil then
				arg_225_1.var_.actorSpriteComps10159 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_10 = 0.2

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_10 and not isNil(var_228_8) then
				local var_228_11 = (arg_225_1.time_ - var_228_9) / var_228_10

				if arg_225_1.var_.actorSpriteComps10159 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								local var_228_12 = Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor2.r, var_228_11)
								local var_228_13 = Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor2.g, var_228_11)
								local var_228_14 = Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor2.b, var_228_11)

								iter_228_5.color = Color.New(var_228_12, var_228_13, var_228_14)
							else
								local var_228_15 = Mathf.Lerp(iter_228_5.color.r, 0.5, var_228_11)

								iter_228_5.color = Color.New(var_228_15, var_228_15, var_228_15)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_9 + var_228_10 and arg_225_1.time_ < var_228_9 + var_228_10 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10159 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10159 = nil
			end

			local var_228_16 = arg_225_1.actors_["1037"].transform
			local var_228_17 = 0

			if var_228_17 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.var_.moveOldPos1037 = var_228_16.localPosition
				var_228_16.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1037", 4)

				local var_228_18 = var_228_16.childCount

				for iter_228_8 = 0, var_228_18 - 1 do
					local var_228_19 = var_228_16:GetChild(iter_228_8)

					if var_228_19.name == "split_5" then
						var_228_19:SetAsLastSibling()
						var_228_19.gameObject:SetActive(true)

						arg_225_1.var_.actorSpriteSplit1037 = var_228_19.gameObject:GetComponent(typeof(Image))

						arg_225_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_228_20 = 0.5

			if var_228_17 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_20 then
				local var_228_21 = (arg_225_1.time_ - var_228_17) / var_228_20
				local var_228_22 = Vector3.New(390, -430, -55)

				var_228_16.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1037, var_228_22, var_228_21)

				if arg_225_1.var_.actorSpriteSplit1037 ~= nil then
					arg_225_1.var_.actorSpriteSplit1037:SetAlpha(var_228_21)
				end
			end

			if arg_225_1.time_ >= var_228_17 + var_228_20 and arg_225_1.time_ < var_228_17 + var_228_20 + arg_228_0 then
				var_228_16.localPosition = Vector3.New(390, -430, -55)

				if arg_225_1.var_.actorSpriteSplit1037 ~= nil then
					arg_225_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_228_23 = 0
			local var_228_24 = 0.05

			if var_228_23 < arg_225_1.time_ and arg_225_1.time_ <= var_228_23 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_25 = arg_225_1:FormatText(StoryNameCfg[15].name)

				arg_225_1.leftNameTxt_.text = var_228_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_26 = arg_225_1:GetWordFromCfg(425132053)
				local var_228_27 = arg_225_1:FormatText(var_228_26.content)

				arg_225_1.text_.text = var_228_27

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_28 = 2
				local var_228_29 = utf8.len(var_228_27)
				local var_228_30 = var_228_28 <= 0 and var_228_24 or var_228_24 * (var_228_29 / var_228_28)

				if var_228_30 > 0 and var_228_24 < var_228_30 then
					arg_225_1.talkMaxDuration = var_228_30

					if var_228_30 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_23
					end
				end

				arg_225_1.text_.text = var_228_27
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132053", "story_v_out_425132.awb") ~= 0 then
					local var_228_31 = manager.audio:GetVoiceLength("story_v_out_425132", "425132053", "story_v_out_425132.awb") / 1000

					if var_228_31 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_31 + var_228_23
					end

					if var_228_26.prefab_name ~= "" and arg_225_1.actors_[var_228_26.prefab_name] ~= nil then
						local var_228_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_26.prefab_name].transform, "story_v_out_425132", "425132053", "story_v_out_425132.awb")

						arg_225_1:RecordAudio("425132053", var_228_32)
						arg_225_1:RecordAudio("425132053", var_228_32)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_425132", "425132053", "story_v_out_425132.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_425132", "425132053", "story_v_out_425132.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_33 = math.max(var_228_24, arg_225_1.talkMaxDuration)

			if var_228_23 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_33 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_23) / var_228_33

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_23 + var_228_33 and arg_225_1.time_ < var_228_23 + var_228_33 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play425132054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 425132054
		arg_229_1.duration_ = 11.53

		local var_229_0 = {
			zh = 7.866,
			ja = 11.533
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
			arg_229_1.auto_ = false
		end

		function arg_229_1.playNext_(arg_231_0)
			arg_229_1.onStoryFinished_()
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10159"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10159 == nil then
				arg_229_1.var_.actorSpriteComps10159 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps10159 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 1, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10159 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10159 = nil
			end

			local var_232_8 = arg_229_1.actors_["1037"]
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps1037 == nil then
				arg_229_1.var_.actorSpriteComps1037 = var_232_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_10 = 0.2

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 and not isNil(var_232_8) then
				local var_232_11 = (arg_229_1.time_ - var_232_9) / var_232_10

				if arg_229_1.var_.actorSpriteComps1037 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_232_5 then
							if arg_229_1.isInRecall_ then
								local var_232_12 = Mathf.Lerp(iter_232_5.color.r, arg_229_1.hightColor2.r, var_232_11)
								local var_232_13 = Mathf.Lerp(iter_232_5.color.g, arg_229_1.hightColor2.g, var_232_11)
								local var_232_14 = Mathf.Lerp(iter_232_5.color.b, arg_229_1.hightColor2.b, var_232_11)

								iter_232_5.color = Color.New(var_232_12, var_232_13, var_232_14)
							else
								local var_232_15 = Mathf.Lerp(iter_232_5.color.r, 0.5, var_232_11)

								iter_232_5.color = Color.New(var_232_15, var_232_15, var_232_15)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps1037 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_232_7 then
						if arg_229_1.isInRecall_ then
							iter_232_7.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1037 = nil
			end

			local var_232_16 = arg_229_1.actors_["10159"].transform
			local var_232_17 = 0

			if var_232_17 < arg_229_1.time_ and arg_229_1.time_ <= var_232_17 + arg_232_0 then
				arg_229_1.var_.moveOldPos10159 = var_232_16.localPosition
				var_232_16.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10159", 3)

				local var_232_18 = var_232_16.childCount

				for iter_232_8 = 0, var_232_18 - 1 do
					local var_232_19 = var_232_16:GetChild(iter_232_8)

					if var_232_19.name == "split_1" or not string.find(var_232_19.name, "split") then
						var_232_19.gameObject:SetActive(true)
					else
						var_232_19.gameObject:SetActive(false)
					end
				end
			end

			local var_232_20 = 0.001

			if var_232_17 <= arg_229_1.time_ and arg_229_1.time_ < var_232_17 + var_232_20 then
				local var_232_21 = (arg_229_1.time_ - var_232_17) / var_232_20
				local var_232_22 = Vector3.New(0, -415, -230)

				var_232_16.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10159, var_232_22, var_232_21)
			end

			if arg_229_1.time_ >= var_232_17 + var_232_20 and arg_229_1.time_ < var_232_17 + var_232_20 + arg_232_0 then
				var_232_16.localPosition = Vector3.New(0, -415, -230)
			end

			local var_232_23 = arg_229_1.actors_["1037"].transform
			local var_232_24 = 0

			if var_232_24 < arg_229_1.time_ and arg_229_1.time_ <= var_232_24 + arg_232_0 then
				arg_229_1.var_.moveOldPos1037 = var_232_23.localPosition
				var_232_23.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1037", 7)

				local var_232_25 = var_232_23.childCount

				for iter_232_9 = 0, var_232_25 - 1 do
					local var_232_26 = var_232_23:GetChild(iter_232_9)

					if var_232_26.name == "" or not string.find(var_232_26.name, "split") then
						var_232_26.gameObject:SetActive(true)
					else
						var_232_26.gameObject:SetActive(false)
					end
				end
			end

			local var_232_27 = 0.001

			if var_232_24 <= arg_229_1.time_ and arg_229_1.time_ < var_232_24 + var_232_27 then
				local var_232_28 = (arg_229_1.time_ - var_232_24) / var_232_27
				local var_232_29 = Vector3.New(1500, -2000, 0)

				var_232_23.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1037, var_232_29, var_232_28)
			end

			if arg_229_1.time_ >= var_232_24 + var_232_27 and arg_229_1.time_ < var_232_24 + var_232_27 + arg_232_0 then
				var_232_23.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_232_30 = 0
			local var_232_31 = 0.675

			if var_232_30 < arg_229_1.time_ and arg_229_1.time_ <= var_232_30 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_32 = arg_229_1:FormatText(StoryNameCfg[1438].name)

				arg_229_1.leftNameTxt_.text = var_232_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_33 = arg_229_1:GetWordFromCfg(425132054)
				local var_232_34 = arg_229_1:FormatText(var_232_33.content)

				arg_229_1.text_.text = var_232_34

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_35 = 27
				local var_232_36 = utf8.len(var_232_34)
				local var_232_37 = var_232_35 <= 0 and var_232_31 or var_232_31 * (var_232_36 / var_232_35)

				if var_232_37 > 0 and var_232_31 < var_232_37 then
					arg_229_1.talkMaxDuration = var_232_37

					if var_232_37 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_37 + var_232_30
					end
				end

				arg_229_1.text_.text = var_232_34
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425132", "425132054", "story_v_out_425132.awb") ~= 0 then
					local var_232_38 = manager.audio:GetVoiceLength("story_v_out_425132", "425132054", "story_v_out_425132.awb") / 1000

					if var_232_38 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_38 + var_232_30
					end

					if var_232_33.prefab_name ~= "" and arg_229_1.actors_[var_232_33.prefab_name] ~= nil then
						local var_232_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_33.prefab_name].transform, "story_v_out_425132", "425132054", "story_v_out_425132.awb")

						arg_229_1:RecordAudio("425132054", var_232_39)
						arg_229_1:RecordAudio("425132054", var_232_39)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_425132", "425132054", "story_v_out_425132.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_425132", "425132054", "story_v_out_425132.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_40 = math.max(var_232_31, arg_229_1.talkMaxDuration)

			if var_232_30 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_40 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_30) / var_232_40

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_30 + var_232_40 and arg_229_1.time_ < var_232_30 + var_232_40 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/Q02f",
		"TextureConfig/Background/SS2504",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST2106"
	},
	voices = {
		"story_v_out_425132.awb"
	}
}
