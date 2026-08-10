return {
	Play425122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play425122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "M01g"

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
				local var_4_5 = arg_1_1.bgs_.M01g

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
					if iter_4_0 ~= "M01g" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

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

			local var_4_36 = 0.133333333333333
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 1.999999999999
			local var_4_41 = 0.575

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

				local var_4_43 = arg_1_1:GetWordFromCfg(425122001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 23
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
	Play425122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play425122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.1

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

				local var_12_2 = arg_9_1:GetWordFromCfg(425122002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 44
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
	Play425122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425122003
		arg_13_1.duration_ = 4.7

		local var_13_0 = {
			zh = 3.533,
			ja = 4.7
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
				arg_13_0:Play425122004(arg_13_1)
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

				arg_13_1:CheckSpriteTmpPos("1137", 2)

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
				local var_16_18 = Vector3.New(-390, -425, -200)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1137, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_16_19 = 0
			local var_16_20 = 0.4

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

				local var_16_22 = arg_13_1:GetWordFromCfg(425122003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122003", "story_v_out_425122.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_425122", "425122003", "story_v_out_425122.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_425122", "425122003", "story_v_out_425122.awb")

						arg_13_1:RecordAudio("425122003", var_16_28)
						arg_13_1:RecordAudio("425122003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425122", "425122003", "story_v_out_425122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425122", "425122003", "story_v_out_425122.awb")
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
	Play425122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425122004
		arg_17_1.duration_ = 9.23

		local var_17_0 = {
			zh = 5.966,
			ja = 9.233
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
				arg_17_0:Play425122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1036"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1036")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["1036"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1036 == nil then
				arg_17_1.var_.actorSpriteComps1036 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps1036 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1036 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1036 = nil
			end

			local var_20_12 = arg_17_1.actors_["1137"]
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps1137 == nil then
				arg_17_1.var_.actorSpriteComps1137 = var_20_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_14 = 0.2

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_14 and not isNil(var_20_12) then
				local var_20_15 = (arg_17_1.time_ - var_20_13) / var_20_14

				if arg_17_1.var_.actorSpriteComps1137 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_16 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_15)
								local var_20_17 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_15)
								local var_20_18 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_15)

								iter_20_7.color = Color.New(var_20_16, var_20_17, var_20_18)
							else
								local var_20_19 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_15)

								iter_20_7.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_13 + var_20_14 and arg_17_1.time_ < var_20_13 + var_20_14 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps1137 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1137 = nil
			end

			local var_20_20 = arg_17_1.actors_["1036"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos1036 = var_20_20.localPosition
				var_20_20.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1036", 4)

				local var_20_22 = var_20_20.childCount

				for iter_20_10 = 0, var_20_22 - 1 do
					local var_20_23 = var_20_20:GetChild(iter_20_10)

					if var_20_23.name == "" or not string.find(var_20_23.name, "split") then
						var_20_23.gameObject:SetActive(true)
					else
						var_20_23.gameObject:SetActive(false)
					end
				end
			end

			local var_20_24 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_21) / var_20_24
				local var_20_26 = Vector3.New(390, -388, -250)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1036, var_20_26, var_20_25)
			end

			if arg_17_1.time_ >= var_20_21 + var_20_24 and arg_17_1.time_ < var_20_21 + var_20_24 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(390, -388, -250)
			end

			local var_20_27 = 0
			local var_20_28 = 0.825

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_29 = arg_17_1:FormatText(StoryNameCfg[5].name)

				arg_17_1.leftNameTxt_.text = var_20_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_30 = arg_17_1:GetWordFromCfg(425122004)
				local var_20_31 = arg_17_1:FormatText(var_20_30.content)

				arg_17_1.text_.text = var_20_31

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_32 = 33
				local var_20_33 = utf8.len(var_20_31)
				local var_20_34 = var_20_32 <= 0 and var_20_28 or var_20_28 * (var_20_33 / var_20_32)

				if var_20_34 > 0 and var_20_28 < var_20_34 then
					arg_17_1.talkMaxDuration = var_20_34

					if var_20_34 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_27
					end
				end

				arg_17_1.text_.text = var_20_31
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122004", "story_v_out_425122.awb") ~= 0 then
					local var_20_35 = manager.audio:GetVoiceLength("story_v_out_425122", "425122004", "story_v_out_425122.awb") / 1000

					if var_20_35 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_35 + var_20_27
					end

					if var_20_30.prefab_name ~= "" and arg_17_1.actors_[var_20_30.prefab_name] ~= nil then
						local var_20_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_30.prefab_name].transform, "story_v_out_425122", "425122004", "story_v_out_425122.awb")

						arg_17_1:RecordAudio("425122004", var_20_36)
						arg_17_1:RecordAudio("425122004", var_20_36)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425122", "425122004", "story_v_out_425122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425122", "425122004", "story_v_out_425122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_37 = math.max(var_20_28, arg_17_1.talkMaxDuration)

			if var_20_27 <= arg_17_1.time_ and arg_17_1.time_ < var_20_27 + var_20_37 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_27) / var_20_37

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_27 + var_20_37 and arg_17_1.time_ < var_20_27 + var_20_37 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play425122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425122005
		arg_21_1.duration_ = 4.73

		local var_21_0 = {
			zh = 3.4,
			ja = 4.733
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
				arg_21_0:Play425122006(arg_21_1)
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
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

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
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1137 = nil
			end

			local var_24_8 = arg_21_1.actors_["1036"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1036 == nil then
				arg_21_1.var_.actorSpriteComps1036 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1036 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1036 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1036 = nil
			end

			local var_24_16 = arg_21_1.actors_["1137"].transform
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.var_.moveOldPos1137 = var_24_16.localPosition
				var_24_16.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1137", 2)

				local var_24_18 = var_24_16.childCount

				for iter_24_8 = 0, var_24_18 - 1 do
					local var_24_19 = var_24_16:GetChild(iter_24_8)

					if var_24_19.name == "split_4" then
						var_24_19:SetAsLastSibling()
						var_24_19.gameObject:SetActive(true)

						arg_21_1.var_.actorSpriteSplit1137 = var_24_19.gameObject:GetComponent(typeof(Image))

						arg_21_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_24_20 = 0.5

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_20 then
				local var_24_21 = (arg_21_1.time_ - var_24_17) / var_24_20
				local var_24_22 = Vector3.New(-390, -425, -200)

				var_24_16.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1137, var_24_22, var_24_21)

				if arg_21_1.var_.actorSpriteSplit1137 ~= nil then
					arg_21_1.var_.actorSpriteSplit1137:SetAlpha(var_24_21)
				end
			end

			if arg_21_1.time_ >= var_24_17 + var_24_20 and arg_21_1.time_ < var_24_17 + var_24_20 + arg_24_0 then
				var_24_16.localPosition = Vector3.New(-390, -425, -200)

				if arg_21_1.var_.actorSpriteSplit1137 ~= nil then
					arg_21_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_24_23 = 0
			local var_24_24 = 0.475

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[15].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(425122005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 19
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122005", "story_v_out_425122.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122005", "story_v_out_425122.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_425122", "425122005", "story_v_out_425122.awb")

						arg_21_1:RecordAudio("425122005", var_24_32)
						arg_21_1:RecordAudio("425122005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425122", "425122005", "story_v_out_425122.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425122", "425122005", "story_v_out_425122.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_33 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_33 and arg_21_1.time_ < var_24_23 + var_24_33 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play425122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425122006
		arg_25_1.duration_ = 5.7

		local var_25_0 = {
			zh = 4.2,
			ja = 5.7
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
				arg_25_0:Play425122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1036"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1036 == nil then
				arg_25_1.var_.actorSpriteComps1036 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1036 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1036 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1036 = nil
			end

			local var_28_8 = arg_25_1.actors_["1137"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1137 == nil then
				arg_25_1.var_.actorSpriteComps1137 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps1137 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 0.5, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1137 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1137 = nil
			end

			local var_28_16 = arg_25_1.actors_["1036"].transform
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.var_.moveOldPos1036 = var_28_16.localPosition
				var_28_16.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1036", 4)

				local var_28_18 = var_28_16.childCount

				for iter_28_8 = 0, var_28_18 - 1 do
					local var_28_19 = var_28_16:GetChild(iter_28_8)

					if var_28_19.name == "" or not string.find(var_28_19.name, "split") then
						var_28_19.gameObject:SetActive(true)
					else
						var_28_19.gameObject:SetActive(false)
					end
				end
			end

			local var_28_20 = 0.001

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_17) / var_28_20
				local var_28_22 = Vector3.New(390, -388, -250)

				var_28_16.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1036, var_28_22, var_28_21)
			end

			if arg_25_1.time_ >= var_28_17 + var_28_20 and arg_25_1.time_ < var_28_17 + var_28_20 + arg_28_0 then
				var_28_16.localPosition = Vector3.New(390, -388, -250)
			end

			local var_28_23 = 0
			local var_28_24 = 0.475

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[5].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(425122006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 19
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122006", "story_v_out_425122.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122006", "story_v_out_425122.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_425122", "425122006", "story_v_out_425122.awb")

						arg_25_1:RecordAudio("425122006", var_28_32)
						arg_25_1:RecordAudio("425122006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425122", "425122006", "story_v_out_425122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425122", "425122006", "story_v_out_425122.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425122007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play425122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1036"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1036 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1036", 7)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -2000, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1036, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_7 = arg_29_1.actors_["1137"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos1137 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1137", 7)

				local var_32_9 = var_32_7.childCount

				for iter_32_1 = 0, var_32_9 - 1 do
					local var_32_10 = var_32_7:GetChild(iter_32_1)

					if var_32_10.name == "" or not string.find(var_32_10.name, "split") then
						var_32_10.gameObject:SetActive(true)
					else
						var_32_10.gameObject:SetActive(false)
					end
				end
			end

			local var_32_11 = 0.001

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_8) / var_32_11
				local var_32_13 = Vector3.New(0, -2000, 0)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1137, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_14 = 0
			local var_32_15 = 1.2

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:GetWordFromCfg(425122007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 48
				local var_32_19 = utf8.len(var_32_17)
				local var_32_20 = var_32_18 <= 0 and var_32_15 or var_32_15 * (var_32_19 / var_32_18)

				if var_32_20 > 0 and var_32_15 < var_32_20 then
					arg_29_1.talkMaxDuration = var_32_20

					if var_32_20 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_14
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_15, arg_29_1.talkMaxDuration)

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_14) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_14 + var_32_21 and arg_29_1.time_ < var_32_14 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_29_1:InitPlayNodeList()
	end,
	Play425122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425122008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play425122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.75

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(425122008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 30
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play425122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425122009
		arg_37_1.duration_ = 3.23

		local var_37_0 = {
			zh = 2.866,
			ja = 3.233
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
				arg_37_0:Play425122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1036"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1036 == nil then
				arg_37_1.var_.actorSpriteComps1036 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1036 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 1, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1036 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1036 = nil
			end

			local var_40_8 = arg_37_1.actors_["1036"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos1036 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1036", 3)

				local var_40_10 = var_40_8.childCount

				for iter_40_4 = 0, var_40_10 - 1 do
					local var_40_11 = var_40_8:GetChild(iter_40_4)

					if var_40_11.name == "" or not string.find(var_40_11.name, "split") then
						var_40_11.gameObject:SetActive(true)
					else
						var_40_11.gameObject:SetActive(false)
					end
				end
			end

			local var_40_12 = 0.001

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_9) / var_40_12
				local var_40_14 = Vector3.New(0, -388, -250)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1036, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_40_15 = 0
			local var_40_16 = 0.425

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[5].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(425122009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 17
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122009", "story_v_out_425122.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122009", "story_v_out_425122.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_425122", "425122009", "story_v_out_425122.awb")

						arg_37_1:RecordAudio("425122009", var_40_24)
						arg_37_1:RecordAudio("425122009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425122", "425122009", "story_v_out_425122.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425122", "425122009", "story_v_out_425122.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play425122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425122010
		arg_41_1.duration_ = 8.97

		local var_41_0 = {
			zh = 5.133,
			ja = 8.966
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play425122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1036"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1036 == nil then
				arg_41_1.var_.actorSpriteComps1036 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1036 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1036 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1036 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.675

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[236].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_41_1.callingController_:SetSelectedState("calling")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(425122010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 27
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122010", "story_v_out_425122.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122010", "story_v_out_425122.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_425122", "425122010", "story_v_out_425122.awb")

						arg_41_1:RecordAudio("425122010", var_44_17)
						arg_41_1:RecordAudio("425122010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425122", "425122010", "story_v_out_425122.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425122", "425122010", "story_v_out_425122.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play425122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425122011
		arg_45_1.duration_ = 4.77

		local var_45_0 = {
			zh = 3.9,
			ja = 4.766
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play425122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1137"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1137 == nil then
				arg_45_1.var_.actorSpriteComps1137 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1137 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1137 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1137 = nil
			end

			local var_48_8 = arg_45_1.actors_["1137"].transform
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.var_.moveOldPos1137 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1137", 2)

				local var_48_10 = var_48_8.childCount

				for iter_48_4 = 0, var_48_10 - 1 do
					local var_48_11 = var_48_8:GetChild(iter_48_4)

					if var_48_11.name == "split_4" or not string.find(var_48_11.name, "split") then
						var_48_11.gameObject:SetActive(true)
					else
						var_48_11.gameObject:SetActive(false)
					end
				end
			end

			local var_48_12 = 0.001

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_9) / var_48_12
				local var_48_14 = Vector3.New(-390, -425, -200)

				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1137, var_48_14, var_48_13)
			end

			if arg_45_1.time_ >= var_48_9 + var_48_12 and arg_45_1.time_ < var_48_9 + var_48_12 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_48_15 = arg_45_1.actors_["1036"].transform
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.var_.moveOldPos1036 = var_48_15.localPosition
				var_48_15.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1036", 4)

				local var_48_17 = var_48_15.childCount

				for iter_48_5 = 0, var_48_17 - 1 do
					local var_48_18 = var_48_15:GetChild(iter_48_5)

					if var_48_18.name == "" or not string.find(var_48_18.name, "split") then
						var_48_18.gameObject:SetActive(true)
					else
						var_48_18.gameObject:SetActive(false)
					end
				end
			end

			local var_48_19 = 0.001

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_16) / var_48_19
				local var_48_21 = Vector3.New(390, -388, -250)

				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1036, var_48_21, var_48_20)
			end

			if arg_45_1.time_ >= var_48_16 + var_48_19 and arg_45_1.time_ < var_48_16 + var_48_19 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(390, -388, -250)
			end

			local var_48_22 = 0
			local var_48_23 = 0.5

			if var_48_22 < arg_45_1.time_ and arg_45_1.time_ <= var_48_22 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_24 = arg_45_1:FormatText(StoryNameCfg[15].name)

				arg_45_1.leftNameTxt_.text = var_48_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_25 = arg_45_1:GetWordFromCfg(425122011)
				local var_48_26 = arg_45_1:FormatText(var_48_25.content)

				arg_45_1.text_.text = var_48_26

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_27 = 20
				local var_48_28 = utf8.len(var_48_26)
				local var_48_29 = var_48_27 <= 0 and var_48_23 or var_48_23 * (var_48_28 / var_48_27)

				if var_48_29 > 0 and var_48_23 < var_48_29 then
					arg_45_1.talkMaxDuration = var_48_29

					if var_48_29 + var_48_22 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_29 + var_48_22
					end
				end

				arg_45_1.text_.text = var_48_26
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122011", "story_v_out_425122.awb") ~= 0 then
					local var_48_30 = manager.audio:GetVoiceLength("story_v_out_425122", "425122011", "story_v_out_425122.awb") / 1000

					if var_48_30 + var_48_22 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_22
					end

					if var_48_25.prefab_name ~= "" and arg_45_1.actors_[var_48_25.prefab_name] ~= nil then
						local var_48_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_25.prefab_name].transform, "story_v_out_425122", "425122011", "story_v_out_425122.awb")

						arg_45_1:RecordAudio("425122011", var_48_31)
						arg_45_1:RecordAudio("425122011", var_48_31)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425122", "425122011", "story_v_out_425122.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425122", "425122011", "story_v_out_425122.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_32 = math.max(var_48_23, arg_45_1.talkMaxDuration)

			if var_48_22 <= arg_45_1.time_ and arg_45_1.time_ < var_48_22 + var_48_32 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_22) / var_48_32

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_22 + var_48_32 and arg_45_1.time_ < var_48_22 + var_48_32 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play425122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425122012
		arg_49_1.duration_ = 1.8

		local var_49_0 = {
			zh = 1.266,
			ja = 1.8
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
				arg_49_0:Play425122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1137"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1137 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1137", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_6" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1137, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = arg_49_1.actors_["1036"].transform
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.var_.moveOldPos1036 = var_52_7.localPosition
				var_52_7.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1036", 7)

				local var_52_9 = var_52_7.childCount

				for iter_52_1 = 0, var_52_9 - 1 do
					local var_52_10 = var_52_7:GetChild(iter_52_1)

					if var_52_10.name == "" or not string.find(var_52_10.name, "split") then
						var_52_10.gameObject:SetActive(true)
					else
						var_52_10.gameObject:SetActive(false)
					end
				end
			end

			local var_52_11 = 0.001

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_8) / var_52_11
				local var_52_13 = Vector3.New(0, -2000, 0)

				var_52_7.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1036, var_52_13, var_52_12)
			end

			if arg_49_1.time_ >= var_52_8 + var_52_11 and arg_49_1.time_ < var_52_8 + var_52_11 + arg_52_0 then
				var_52_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_14 = 0
			local var_52_15 = 0.125

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_16 = arg_49_1:FormatText(StoryNameCfg[236].name)

				arg_49_1.leftNameTxt_.text = var_52_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_49_1.callingController_:SetSelectedState("calling")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_17 = arg_49_1:GetWordFromCfg(425122012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 5
				local var_52_20 = utf8.len(var_52_18)
				local var_52_21 = var_52_19 <= 0 and var_52_15 or var_52_15 * (var_52_20 / var_52_19)

				if var_52_21 > 0 and var_52_15 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21

					if var_52_21 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_14
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122012", "story_v_out_425122.awb") ~= 0 then
					local var_52_22 = manager.audio:GetVoiceLength("story_v_out_425122", "425122012", "story_v_out_425122.awb") / 1000

					if var_52_22 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_14
					end

					if var_52_17.prefab_name ~= "" and arg_49_1.actors_[var_52_17.prefab_name] ~= nil then
						local var_52_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_17.prefab_name].transform, "story_v_out_425122", "425122012", "story_v_out_425122.awb")

						arg_49_1:RecordAudio("425122012", var_52_23)
						arg_49_1:RecordAudio("425122012", var_52_23)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_425122", "425122012", "story_v_out_425122.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_425122", "425122012", "story_v_out_425122.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_24 = math.max(var_52_15, arg_49_1.talkMaxDuration)

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_24 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_14) / var_52_24

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_14 + var_52_24 and arg_49_1.time_ < var_52_14 + var_52_24 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play425122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425122013
		arg_53_1.duration_ = 9.37

		local var_53_0 = {
			zh = 5.733,
			ja = 9.366
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
				arg_53_0:Play425122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1036"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1036 == nil then
				arg_53_1.var_.actorSpriteComps1036 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1036 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1036 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1036 = nil
			end

			local var_56_8 = arg_53_1.actors_["1036"].transform
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.var_.moveOldPos1036 = var_56_8.localPosition
				var_56_8.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1036", 3)

				local var_56_10 = var_56_8.childCount

				for iter_56_4 = 0, var_56_10 - 1 do
					local var_56_11 = var_56_8:GetChild(iter_56_4)

					if var_56_11.name == "" or not string.find(var_56_11.name, "split") then
						var_56_11.gameObject:SetActive(true)
					else
						var_56_11.gameObject:SetActive(false)
					end
				end
			end

			local var_56_12 = 0.001

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_9) / var_56_12
				local var_56_14 = Vector3.New(0, -388, -250)

				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1036, var_56_14, var_56_13)
			end

			if arg_53_1.time_ >= var_56_9 + var_56_12 and arg_53_1.time_ < var_56_9 + var_56_12 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_56_15 = 0
			local var_56_16 = 0.725

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[5].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(425122013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 29
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122013", "story_v_out_425122.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122013", "story_v_out_425122.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_425122", "425122013", "story_v_out_425122.awb")

						arg_53_1:RecordAudio("425122013", var_56_24)
						arg_53_1:RecordAudio("425122013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425122", "425122013", "story_v_out_425122.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425122", "425122013", "story_v_out_425122.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play425122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425122014
		arg_57_1.duration_ = 11.93

		local var_57_0 = {
			zh = 6.633,
			ja = 11.933
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
				arg_57_0:Play425122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "10127"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(var_60_1, arg_57_1.canvasGo_.transform)

					var_60_2.transform:SetSiblingIndex(1)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs(var_60_3) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_4 = arg_57_1.actors_["10127"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.actorSpriteComps10127 == nil then
				arg_57_1.var_.actorSpriteComps10127 = var_60_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 0.2

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.actorSpriteComps10127 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								local var_60_8 = Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, var_60_7)
								local var_60_9 = Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, var_60_7)
								local var_60_10 = Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, var_60_7)

								iter_60_3.color = Color.New(var_60_8, var_60_9, var_60_10)
							else
								local var_60_11 = Mathf.Lerp(iter_60_3.color.r, 1, var_60_7)

								iter_60_3.color = Color.New(var_60_11, var_60_11, var_60_11)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.actorSpriteComps10127 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_60_5 then
						if arg_57_1.isInRecall_ then
							iter_60_5.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10127 = nil
			end

			local var_60_12 = arg_57_1.actors_["1036"]
			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 and not isNil(var_60_12) and arg_57_1.var_.actorSpriteComps1036 == nil then
				arg_57_1.var_.actorSpriteComps1036 = var_60_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_14 = 0.2

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_14 and not isNil(var_60_12) then
				local var_60_15 = (arg_57_1.time_ - var_60_13) / var_60_14

				if arg_57_1.var_.actorSpriteComps1036 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								local var_60_16 = Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, var_60_15)
								local var_60_17 = Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, var_60_15)
								local var_60_18 = Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, var_60_15)

								iter_60_7.color = Color.New(var_60_16, var_60_17, var_60_18)
							else
								local var_60_19 = Mathf.Lerp(iter_60_7.color.r, 0.5, var_60_15)

								iter_60_7.color = Color.New(var_60_19, var_60_19, var_60_19)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_13 + var_60_14 and arg_57_1.time_ < var_60_13 + var_60_14 + arg_60_0 and not isNil(var_60_12) and arg_57_1.var_.actorSpriteComps1036 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1036 = nil
			end

			local var_60_20 = 0
			local var_60_21 = 0.925

			if var_60_20 < arg_57_1.time_ and arg_57_1.time_ <= var_60_20 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_22 = arg_57_1:FormatText(StoryNameCfg[236].name)

				arg_57_1.leftNameTxt_.text = var_60_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_57_1.callingController_:SetSelectedState("calling")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_23 = arg_57_1:GetWordFromCfg(425122014)
				local var_60_24 = arg_57_1:FormatText(var_60_23.content)

				arg_57_1.text_.text = var_60_24

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_25 = 37
				local var_60_26 = utf8.len(var_60_24)
				local var_60_27 = var_60_25 <= 0 and var_60_21 or var_60_21 * (var_60_26 / var_60_25)

				if var_60_27 > 0 and var_60_21 < var_60_27 then
					arg_57_1.talkMaxDuration = var_60_27

					if var_60_27 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_27 + var_60_20
					end
				end

				arg_57_1.text_.text = var_60_24
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122014", "story_v_out_425122.awb") ~= 0 then
					local var_60_28 = manager.audio:GetVoiceLength("story_v_out_425122", "425122014", "story_v_out_425122.awb") / 1000

					if var_60_28 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_20
					end

					if var_60_23.prefab_name ~= "" and arg_57_1.actors_[var_60_23.prefab_name] ~= nil then
						local var_60_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_23.prefab_name].transform, "story_v_out_425122", "425122014", "story_v_out_425122.awb")

						arg_57_1:RecordAudio("425122014", var_60_29)
						arg_57_1:RecordAudio("425122014", var_60_29)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425122", "425122014", "story_v_out_425122.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425122", "425122014", "story_v_out_425122.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_30 = math.max(var_60_21, arg_57_1.talkMaxDuration)

			if var_60_20 <= arg_57_1.time_ and arg_57_1.time_ < var_60_20 + var_60_30 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_20) / var_60_30

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_20 + var_60_30 and arg_57_1.time_ < var_60_20 + var_60_30 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play425122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 425122015
		arg_61_1.duration_ = 4.8

		local var_61_0 = {
			zh = 4.4,
			ja = 4.8
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
				arg_61_0:Play425122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1036"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1036 == nil then
				arg_61_1.var_.actorSpriteComps1036 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1036 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1036 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1036 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.625

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[5].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(425122015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 25
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122015", "story_v_out_425122.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122015", "story_v_out_425122.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_425122", "425122015", "story_v_out_425122.awb")

						arg_61_1:RecordAudio("425122015", var_64_17)
						arg_61_1:RecordAudio("425122015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_425122", "425122015", "story_v_out_425122.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_425122", "425122015", "story_v_out_425122.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play425122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 425122016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play425122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1036"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1036 == nil then
				arg_65_1.var_.actorSpriteComps1036 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1036 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1036 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1036 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.425

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(425122016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_12 = 17
				local var_68_13 = utf8.len(var_68_11)
				local var_68_14 = var_68_12 <= 0 and var_68_9 or var_68_9 * (var_68_13 / var_68_12)

				if var_68_14 > 0 and var_68_9 < var_68_14 then
					arg_65_1.talkMaxDuration = var_68_14

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_15 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_15 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_15

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_15 and arg_65_1.time_ < var_68_8 + var_68_15 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play425122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 425122017
		arg_69_1.duration_ = 10.23

		local var_69_0 = {
			zh = 7.166,
			ja = 10.233
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
				arg_69_0:Play425122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.975

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[236].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_69_1.callingController_:SetSelectedState("calling")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(425122017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122017", "story_v_out_425122.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122017", "story_v_out_425122.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_425122", "425122017", "story_v_out_425122.awb")

						arg_69_1:RecordAudio("425122017", var_72_9)
						arg_69_1:RecordAudio("425122017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_425122", "425122017", "story_v_out_425122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_425122", "425122017", "story_v_out_425122.awb")
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
	Play425122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 425122018
		arg_73_1.duration_ = 4.43

		local var_73_0 = {
			zh = 2.4,
			ja = 4.433
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
				arg_73_0:Play425122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1036"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1036 == nil then
				arg_73_1.var_.actorSpriteComps1036 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1036 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1036 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1036 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.325

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[5].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_11 = arg_73_1:GetWordFromCfg(425122018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 13
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_9 or var_76_9 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_9 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122018", "story_v_out_425122.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122018", "story_v_out_425122.awb") / 1000

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end

					if var_76_11.prefab_name ~= "" and arg_73_1.actors_[var_76_11.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_11.prefab_name].transform, "story_v_out_425122", "425122018", "story_v_out_425122.awb")

						arg_73_1:RecordAudio("425122018", var_76_17)
						arg_73_1:RecordAudio("425122018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_425122", "425122018", "story_v_out_425122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_425122", "425122018", "story_v_out_425122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_18 and arg_73_1.time_ < var_76_8 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play425122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 425122019
		arg_77_1.duration_ = 7

		local var_77_0 = {
			zh = 5.866,
			ja = 7
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play425122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1036"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1036 == nil then
				arg_77_1.var_.actorSpriteComps1036 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1036 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1036 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1036 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.725

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[236].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_77_1.callingController_:SetSelectedState("calling")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(425122019)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122019", "story_v_out_425122.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122019", "story_v_out_425122.awb") / 1000

					if var_80_16 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_8
					end

					if var_80_11.prefab_name ~= "" and arg_77_1.actors_[var_80_11.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_11.prefab_name].transform, "story_v_out_425122", "425122019", "story_v_out_425122.awb")

						arg_77_1:RecordAudio("425122019", var_80_17)
						arg_77_1:RecordAudio("425122019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_425122", "425122019", "story_v_out_425122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_425122", "425122019", "story_v_out_425122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_18 and arg_77_1.time_ < var_80_8 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play425122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 425122020
		arg_81_1.duration_ = 4.2

		local var_81_0 = {
			zh = 2.466,
			ja = 4.2
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play425122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1036"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1036 == nil then
				arg_81_1.var_.actorSpriteComps1036 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1036 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1036 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1036 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.35

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_10 = arg_81_1:FormatText(StoryNameCfg[5].name)

				arg_81_1.leftNameTxt_.text = var_84_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_11 = arg_81_1:GetWordFromCfg(425122020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 14
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_9 or var_84_9 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_9 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122020", "story_v_out_425122.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122020", "story_v_out_425122.awb") / 1000

					if var_84_16 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_8
					end

					if var_84_11.prefab_name ~= "" and arg_81_1.actors_[var_84_11.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_11.prefab_name].transform, "story_v_out_425122", "425122020", "story_v_out_425122.awb")

						arg_81_1:RecordAudio("425122020", var_84_17)
						arg_81_1:RecordAudio("425122020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_425122", "425122020", "story_v_out_425122.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_425122", "425122020", "story_v_out_425122.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_18 and arg_81_1.time_ < var_84_8 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play425122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425122021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play425122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1036"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1036 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1036", 7)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -2000, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1036, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_7 = 0
			local var_88_8 = 0.775

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(425122021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 31
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_8 or var_88_8 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_8 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_7 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_7
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_8, arg_85_1.talkMaxDuration)

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_7) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_7 + var_88_14 and arg_85_1.time_ < var_88_7 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play425122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425122022
		arg_89_1.duration_ = 1.5

		local var_89_0 = {
			zh = 1.266,
			ja = 1.5
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play425122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.075

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[15].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_5")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(425122022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 3
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122022", "story_v_out_425122.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122022", "story_v_out_425122.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_425122", "425122022", "story_v_out_425122.awb")

						arg_89_1:RecordAudio("425122022", var_92_9)
						arg_89_1:RecordAudio("425122022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_425122", "425122022", "story_v_out_425122.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_425122", "425122022", "story_v_out_425122.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play425122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425122023
		arg_93_1.duration_ = 6.3

		local var_93_0 = {
			zh = 4.5,
			ja = 6.3
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play425122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1036"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1036 == nil then
				arg_93_1.var_.actorSpriteComps1036 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1036 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1036 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1036 = nil
			end

			local var_96_8 = arg_93_1.actors_["1036"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos1036 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1036", 3)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "" or not string.find(var_96_11.name, "split") then
						var_96_11.gameObject:SetActive(true)
					else
						var_96_11.gameObject:SetActive(false)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(0, -388, -250)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1036, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_96_15 = 0
			local var_96_16 = 0.65

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[5].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(425122023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 26
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122023", "story_v_out_425122.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122023", "story_v_out_425122.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_425122", "425122023", "story_v_out_425122.awb")

						arg_93_1:RecordAudio("425122023", var_96_24)
						arg_93_1:RecordAudio("425122023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425122", "425122023", "story_v_out_425122.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425122", "425122023", "story_v_out_425122.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play425122024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425122024
		arg_97_1.duration_ = 5.13

		local var_97_0 = {
			zh = 5.033,
			ja = 5.133
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play425122025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.7

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[5].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(425122024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 27
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122024", "story_v_out_425122.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122024", "story_v_out_425122.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_425122", "425122024", "story_v_out_425122.awb")

						arg_97_1:RecordAudio("425122024", var_100_9)
						arg_97_1:RecordAudio("425122024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425122", "425122024", "story_v_out_425122.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425122", "425122024", "story_v_out_425122.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play425122025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425122025
		arg_101_1.duration_ = 5

		local var_101_0 = {
			zh = 4.566,
			ja = 5
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play425122026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1137"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1137 == nil then
				arg_101_1.var_.actorSpriteComps1137 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps1137 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1137 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1137 = nil
			end

			local var_104_8 = arg_101_1.actors_["1036"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1036 == nil then
				arg_101_1.var_.actorSpriteComps1036 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps1036 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								local var_104_12 = Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, var_104_11)
								local var_104_13 = Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, var_104_11)
								local var_104_14 = Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, var_104_11)

								iter_104_5.color = Color.New(var_104_12, var_104_13, var_104_14)
							else
								local var_104_15 = Mathf.Lerp(iter_104_5.color.r, 0.5, var_104_11)

								iter_104_5.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1036 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1036 = nil
			end

			local var_104_16 = arg_101_1.actors_["1137"].transform
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos1137 = var_104_16.localPosition
				var_104_16.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1137", 2)

				local var_104_18 = var_104_16.childCount

				for iter_104_8 = 0, var_104_18 - 1 do
					local var_104_19 = var_104_16:GetChild(iter_104_8)

					if var_104_19.name == "split_4" or not string.find(var_104_19.name, "split") then
						var_104_19.gameObject:SetActive(true)
					else
						var_104_19.gameObject:SetActive(false)
					end
				end
			end

			local var_104_20 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_20 then
				local var_104_21 = (arg_101_1.time_ - var_104_17) / var_104_20
				local var_104_22 = Vector3.New(-390, -425, -200)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1137, var_104_22, var_104_21)
			end

			if arg_101_1.time_ >= var_104_17 + var_104_20 and arg_101_1.time_ < var_104_17 + var_104_20 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_104_23 = arg_101_1.actors_["1036"].transform
			local var_104_24 = 0

			if var_104_24 < arg_101_1.time_ and arg_101_1.time_ <= var_104_24 + arg_104_0 then
				arg_101_1.var_.moveOldPos1036 = var_104_23.localPosition
				var_104_23.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1036", 4)

				local var_104_25 = var_104_23.childCount

				for iter_104_9 = 0, var_104_25 - 1 do
					local var_104_26 = var_104_23:GetChild(iter_104_9)

					if var_104_26.name == "" or not string.find(var_104_26.name, "split") then
						var_104_26.gameObject:SetActive(true)
					else
						var_104_26.gameObject:SetActive(false)
					end
				end
			end

			local var_104_27 = 0.001

			if var_104_24 <= arg_101_1.time_ and arg_101_1.time_ < var_104_24 + var_104_27 then
				local var_104_28 = (arg_101_1.time_ - var_104_24) / var_104_27
				local var_104_29 = Vector3.New(390, -388, -250)

				var_104_23.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1036, var_104_29, var_104_28)
			end

			if arg_101_1.time_ >= var_104_24 + var_104_27 and arg_101_1.time_ < var_104_24 + var_104_27 + arg_104_0 then
				var_104_23.localPosition = Vector3.New(390, -388, -250)
			end

			local var_104_30 = 0
			local var_104_31 = 0.4

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[15].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(425122025)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 16
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122025", "story_v_out_425122.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_425122", "425122025", "story_v_out_425122.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_425122", "425122025", "story_v_out_425122.awb")

						arg_101_1:RecordAudio("425122025", var_104_39)
						arg_101_1:RecordAudio("425122025", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_425122", "425122025", "story_v_out_425122.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_425122", "425122025", "story_v_out_425122.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play425122026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425122026
		arg_105_1.duration_ = 5.63

		local var_105_0 = {
			zh = 5.366,
			ja = 5.633
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play425122027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1036"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1036 == nil then
				arg_105_1.var_.actorSpriteComps1036 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1036 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1036 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1036 = nil
			end

			local var_108_8 = arg_105_1.actors_["1137"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps1137 == nil then
				arg_105_1.var_.actorSpriteComps1137 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps1137 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps1137 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1137 = nil
			end

			local var_108_16 = 0
			local var_108_17 = 0.6

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[5].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(425122026)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 24
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122026", "story_v_out_425122.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_425122", "425122026", "story_v_out_425122.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_425122", "425122026", "story_v_out_425122.awb")

						arg_105_1:RecordAudio("425122026", var_108_25)
						arg_105_1:RecordAudio("425122026", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425122", "425122026", "story_v_out_425122.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425122", "425122026", "story_v_out_425122.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play425122027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 425122027
		arg_109_1.duration_ = 8.63

		local var_109_0 = {
			zh = 6.233,
			ja = 8.633
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play425122028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.875

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[5].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(425122027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 35
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122027", "story_v_out_425122.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122027", "story_v_out_425122.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_425122", "425122027", "story_v_out_425122.awb")

						arg_109_1:RecordAudio("425122027", var_112_9)
						arg_109_1:RecordAudio("425122027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_425122", "425122027", "story_v_out_425122.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_425122", "425122027", "story_v_out_425122.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play425122028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 425122028
		arg_113_1.duration_ = 9.67

		local var_113_0 = {
			zh = 7.966,
			ja = 9.666
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play425122029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.125

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[5].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(425122028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 45
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122028", "story_v_out_425122.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122028", "story_v_out_425122.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_425122", "425122028", "story_v_out_425122.awb")

						arg_113_1:RecordAudio("425122028", var_116_9)
						arg_113_1:RecordAudio("425122028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_425122", "425122028", "story_v_out_425122.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_425122", "425122028", "story_v_out_425122.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play425122029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 425122029
		arg_117_1.duration_ = 1.6

		local var_117_0 = {
			zh = 0.999999999999,
			ja = 1.6
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play425122030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1137"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1137 == nil then
				arg_117_1.var_.actorSpriteComps1137 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps1137 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1137 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1137 = nil
			end

			local var_120_8 = arg_117_1.actors_["1036"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1036 == nil then
				arg_117_1.var_.actorSpriteComps1036 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 0.2

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps1036 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								local var_120_12 = Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor2.r, var_120_11)
								local var_120_13 = Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor2.g, var_120_11)
								local var_120_14 = Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor2.b, var_120_11)

								iter_120_5.color = Color.New(var_120_12, var_120_13, var_120_14)
							else
								local var_120_15 = Mathf.Lerp(iter_120_5.color.r, 0.5, var_120_11)

								iter_120_5.color = Color.New(var_120_15, var_120_15, var_120_15)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1036 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1036 = nil
			end

			local var_120_16 = 0
			local var_120_17 = 0.05

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_18 = arg_117_1:FormatText(StoryNameCfg[15].name)

				arg_117_1.leftNameTxt_.text = var_120_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_19 = arg_117_1:GetWordFromCfg(425122029)
				local var_120_20 = arg_117_1:FormatText(var_120_19.content)

				arg_117_1.text_.text = var_120_20

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_21 = 2
				local var_120_22 = utf8.len(var_120_20)
				local var_120_23 = var_120_21 <= 0 and var_120_17 or var_120_17 * (var_120_22 / var_120_21)

				if var_120_23 > 0 and var_120_17 < var_120_23 then
					arg_117_1.talkMaxDuration = var_120_23

					if var_120_23 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_16
					end
				end

				arg_117_1.text_.text = var_120_20
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122029", "story_v_out_425122.awb") ~= 0 then
					local var_120_24 = manager.audio:GetVoiceLength("story_v_out_425122", "425122029", "story_v_out_425122.awb") / 1000

					if var_120_24 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_24 + var_120_16
					end

					if var_120_19.prefab_name ~= "" and arg_117_1.actors_[var_120_19.prefab_name] ~= nil then
						local var_120_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_19.prefab_name].transform, "story_v_out_425122", "425122029", "story_v_out_425122.awb")

						arg_117_1:RecordAudio("425122029", var_120_25)
						arg_117_1:RecordAudio("425122029", var_120_25)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_425122", "425122029", "story_v_out_425122.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_425122", "425122029", "story_v_out_425122.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_26 = math.max(var_120_17, arg_117_1.talkMaxDuration)

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_26 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_16) / var_120_26

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_16 + var_120_26 and arg_117_1.time_ < var_120_16 + var_120_26 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play425122030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 425122030
		arg_121_1.duration_ = 13.4

		local var_121_0 = {
			zh = 10.833,
			ja = 13.4
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play425122031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = "ST2403a"

			if arg_121_1.bgs_[var_124_0] == nil then
				local var_124_1 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_124_0)
				var_124_1.name = var_124_0
				var_124_1.transform.parent = arg_121_1.stage_.transform
				var_124_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_[var_124_0] = var_124_1
			end

			local var_124_2 = 2

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				local var_124_3 = manager.ui.mainCamera.transform.localPosition
				local var_124_4 = Vector3.New(0, 0, 10) + Vector3.New(var_124_3.x, var_124_3.y, 0)
				local var_124_5 = arg_121_1.bgs_.ST2403a

				var_124_5.transform.localPosition = var_124_4
				var_124_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_6 = var_124_5:GetComponent("SpriteRenderer")

				if var_124_6 and var_124_6.sprite then
					local var_124_7 = (var_124_5.transform.localPosition - var_124_3).z
					local var_124_8 = manager.ui.mainCameraCom_
					local var_124_9 = 2 * var_124_7 * Mathf.Tan(var_124_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_10 = var_124_9 * var_124_8.aspect
					local var_124_11 = var_124_6.sprite.bounds.size.x
					local var_124_12 = var_124_6.sprite.bounds.size.y
					local var_124_13 = var_124_10 / var_124_11
					local var_124_14 = var_124_9 / var_124_12
					local var_124_15 = var_124_14 < var_124_13 and var_124_13 or var_124_14

					var_124_5.transform.localScale = Vector3.New(var_124_15, var_124_15, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST2403a" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_16 = 4

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_17 = 0.3

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_18 = 0

			if var_124_18 < arg_121_1.time_ and arg_121_1.time_ <= var_124_18 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_19 = 2

			if var_124_18 <= arg_121_1.time_ and arg_121_1.time_ < var_124_18 + var_124_19 then
				local var_124_20 = (arg_121_1.time_ - var_124_18) / var_124_19
				local var_124_21 = Color.New(0, 0, 0)

				var_124_21.a = Mathf.Lerp(0, 1, var_124_20)
				arg_121_1.mask_.color = var_124_21
			end

			if arg_121_1.time_ >= var_124_18 + var_124_19 and arg_121_1.time_ < var_124_18 + var_124_19 + arg_124_0 then
				local var_124_22 = Color.New(0, 0, 0)

				var_124_22.a = 1
				arg_121_1.mask_.color = var_124_22
			end

			local var_124_23 = 2

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_24 = 2

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24
				local var_124_26 = Color.New(0, 0, 0)

				var_124_26.a = Mathf.Lerp(1, 0, var_124_25)
				arg_121_1.mask_.color = var_124_26
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 then
				local var_124_27 = Color.New(0, 0, 0)
				local var_124_28 = 0

				arg_121_1.mask_.enabled = false
				var_124_27.a = var_124_28
				arg_121_1.mask_.color = var_124_27
			end

			local var_124_29 = arg_121_1.actors_["1137"].transform
			local var_124_30 = 2

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.var_.moveOldPos1137 = var_124_29.localPosition
				var_124_29.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1137", 7)

				local var_124_31 = var_124_29.childCount

				for iter_124_2 = 0, var_124_31 - 1 do
					local var_124_32 = var_124_29:GetChild(iter_124_2)

					if var_124_32.name == "" or not string.find(var_124_32.name, "split") then
						var_124_32.gameObject:SetActive(true)
					else
						var_124_32.gameObject:SetActive(false)
					end
				end
			end

			local var_124_33 = 0.001

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_33 then
				local var_124_34 = (arg_121_1.time_ - var_124_30) / var_124_33
				local var_124_35 = Vector3.New(0, -2000, 0)

				var_124_29.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1137, var_124_35, var_124_34)
			end

			if arg_121_1.time_ >= var_124_30 + var_124_33 and arg_121_1.time_ < var_124_30 + var_124_33 + arg_124_0 then
				var_124_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_36 = arg_121_1.actors_["1036"].transform
			local var_124_37 = 2

			if var_124_37 < arg_121_1.time_ and arg_121_1.time_ <= var_124_37 + arg_124_0 then
				arg_121_1.var_.moveOldPos1036 = var_124_36.localPosition
				var_124_36.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1036", 7)

				local var_124_38 = var_124_36.childCount

				for iter_124_3 = 0, var_124_38 - 1 do
					local var_124_39 = var_124_36:GetChild(iter_124_3)

					if var_124_39.name == "" or not string.find(var_124_39.name, "split") then
						var_124_39.gameObject:SetActive(true)
					else
						var_124_39.gameObject:SetActive(false)
					end
				end
			end

			local var_124_40 = 0.001

			if var_124_37 <= arg_121_1.time_ and arg_121_1.time_ < var_124_37 + var_124_40 then
				local var_124_41 = (arg_121_1.time_ - var_124_37) / var_124_40
				local var_124_42 = Vector3.New(0, -2000, 0)

				var_124_36.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1036, var_124_42, var_124_41)
			end

			if arg_121_1.time_ >= var_124_37 + var_124_40 and arg_121_1.time_ < var_124_37 + var_124_40 + arg_124_0 then
				var_124_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_43 = 0.133333333333333
			local var_124_44 = 1

			if var_124_43 < arg_121_1.time_ and arg_121_1.time_ <= var_124_43 + arg_124_0 then
				local var_124_45 = "stop"
				local var_124_46 = "effect"

				arg_121_1:AudioAction(var_124_45, var_124_46, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_124_47 = 1.73333333333333
			local var_124_48 = 1

			if var_124_47 < arg_121_1.time_ and arg_121_1.time_ <= var_124_47 + arg_124_0 then
				local var_124_49 = "play"
				local var_124_50 = "effect"

				arg_121_1:AudioAction(var_124_49, var_124_50, "se_story_141", "se_story_141_amb_bass", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_51 = 4
			local var_124_52 = 0.65

			if var_124_51 < arg_121_1.time_ and arg_121_1.time_ <= var_124_51 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_53 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_53:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_54 = arg_121_1:FormatText(StoryNameCfg[36].name)

				arg_121_1.leftNameTxt_.text = var_124_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_55 = arg_121_1:GetWordFromCfg(425122030)
				local var_124_56 = arg_121_1:FormatText(var_124_55.content)

				arg_121_1.text_.text = var_124_56

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_57 = 26
				local var_124_58 = utf8.len(var_124_56)
				local var_124_59 = var_124_57 <= 0 and var_124_52 or var_124_52 * (var_124_58 / var_124_57)

				if var_124_59 > 0 and var_124_52 < var_124_59 then
					arg_121_1.talkMaxDuration = var_124_59
					var_124_51 = var_124_51 + 0.3

					if var_124_59 + var_124_51 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_59 + var_124_51
					end
				end

				arg_121_1.text_.text = var_124_56
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122030", "story_v_out_425122.awb") ~= 0 then
					local var_124_60 = manager.audio:GetVoiceLength("story_v_out_425122", "425122030", "story_v_out_425122.awb") / 1000

					if var_124_60 + var_124_51 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_60 + var_124_51
					end

					if var_124_55.prefab_name ~= "" and arg_121_1.actors_[var_124_55.prefab_name] ~= nil then
						local var_124_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_55.prefab_name].transform, "story_v_out_425122", "425122030", "story_v_out_425122.awb")

						arg_121_1:RecordAudio("425122030", var_124_61)
						arg_121_1:RecordAudio("425122030", var_124_61)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_425122", "425122030", "story_v_out_425122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_425122", "425122030", "story_v_out_425122.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_62 = var_124_51 + 0.3
			local var_124_63 = math.max(var_124_52, arg_121_1.talkMaxDuration)

			if var_124_62 <= arg_121_1.time_ and arg_121_1.time_ < var_124_62 + var_124_63 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_62) / var_124_63

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_62 + var_124_63 and arg_121_1.time_ < var_124_62 + var_124_63 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play425122031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425122031
		arg_127_1.duration_ = 1.63

		local var_127_0 = {
			zh = 1.5,
			ja = 1.633
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
				arg_127_0:Play425122032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.1

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[15].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(425122031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122031", "story_v_out_425122.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122031", "story_v_out_425122.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_425122", "425122031", "story_v_out_425122.awb")

						arg_127_1:RecordAudio("425122031", var_130_9)
						arg_127_1:RecordAudio("425122031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_425122", "425122031", "story_v_out_425122.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_425122", "425122031", "story_v_out_425122.awb")
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
	Play425122032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425122032
		arg_131_1.duration_ = 4.2

		local var_131_0 = {
			zh = 3.366,
			ja = 4.2
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play425122033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.225

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[36].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(425122032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 9
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122032", "story_v_out_425122.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122032", "story_v_out_425122.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_425122", "425122032", "story_v_out_425122.awb")

						arg_131_1:RecordAudio("425122032", var_134_9)
						arg_131_1:RecordAudio("425122032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425122", "425122032", "story_v_out_425122.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425122", "425122032", "story_v_out_425122.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play425122033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425122033
		arg_135_1.duration_ = 4.37

		local var_135_0 = {
			zh = 2.666,
			ja = 4.366
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play425122034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.175

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[15].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(425122033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122033", "story_v_out_425122.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122033", "story_v_out_425122.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_425122", "425122033", "story_v_out_425122.awb")

						arg_135_1:RecordAudio("425122033", var_138_9)
						arg_135_1:RecordAudio("425122033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_425122", "425122033", "story_v_out_425122.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_425122", "425122033", "story_v_out_425122.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 5, 0)
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play425122034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425122034
		arg_139_1.duration_ = 13.53

		local var_139_0 = {
			zh = 8.066,
			ja = 13.533
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
				arg_139_0:Play425122035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.825

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[36].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(425122034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 33
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122034", "story_v_out_425122.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122034", "story_v_out_425122.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_425122", "425122034", "story_v_out_425122.awb")

						arg_139_1:RecordAudio("425122034", var_142_9)
						arg_139_1:RecordAudio("425122034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425122", "425122034", "story_v_out_425122.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425122", "425122034", "story_v_out_425122.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play425122035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425122035
		arg_143_1.duration_ = 1.8

		local var_143_0 = {
			zh = 1.8,
			ja = 1.433
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play425122036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.05

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[15].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(425122035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 2
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122035", "story_v_out_425122.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122035", "story_v_out_425122.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_425122", "425122035", "story_v_out_425122.awb")

						arg_143_1:RecordAudio("425122035", var_146_9)
						arg_143_1:RecordAudio("425122035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425122", "425122035", "story_v_out_425122.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425122", "425122035", "story_v_out_425122.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play425122036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425122036
		arg_147_1.duration_ = 1.93

		local var_147_0 = {
			zh = 1.6,
			ja = 1.933
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
				arg_147_0:Play425122037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.125

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

				local var_150_3 = arg_147_1:GetWordFromCfg(425122036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122036", "story_v_out_425122.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122036", "story_v_out_425122.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_425122", "425122036", "story_v_out_425122.awb")

						arg_147_1:RecordAudio("425122036", var_150_9)
						arg_147_1:RecordAudio("425122036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425122", "425122036", "story_v_out_425122.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425122", "425122036", "story_v_out_425122.awb")
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
	Play425122037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425122037
		arg_151_1.duration_ = 10.8

		local var_151_0 = {
			zh = 10.433,
			ja = 10.8
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
				arg_151_0:Play425122038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 2

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				local var_154_1 = manager.ui.mainCamera.transform.localPosition
				local var_154_2 = Vector3.New(0, 0, 10) + Vector3.New(var_154_1.x, var_154_1.y, 0)
				local var_154_3 = arg_151_1.bgs_.M01g

				var_154_3.transform.localPosition = var_154_2
				var_154_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_4 = var_154_3:GetComponent("SpriteRenderer")

				if var_154_4 and var_154_4.sprite then
					local var_154_5 = (var_154_3.transform.localPosition - var_154_1).z
					local var_154_6 = manager.ui.mainCameraCom_
					local var_154_7 = 2 * var_154_5 * Mathf.Tan(var_154_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_154_8 = var_154_7 * var_154_6.aspect
					local var_154_9 = var_154_4.sprite.bounds.size.x
					local var_154_10 = var_154_4.sprite.bounds.size.y
					local var_154_11 = var_154_8 / var_154_9
					local var_154_12 = var_154_7 / var_154_10
					local var_154_13 = var_154_12 < var_154_11 and var_154_11 or var_154_12

					var_154_3.transform.localScale = Vector3.New(var_154_13, var_154_13, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "M01g" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_14 = 4

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_15 = 0.533333333333333

			if arg_151_1.time_ >= var_154_14 + var_154_15 and arg_151_1.time_ < var_154_14 + var_154_15 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_17 = 2

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Color.New(0, 0, 0)

				var_154_19.a = Mathf.Lerp(0, 1, var_154_18)
				arg_151_1.mask_.color = var_154_19
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				local var_154_20 = Color.New(0, 0, 0)

				var_154_20.a = 1
				arg_151_1.mask_.color = var_154_20
			end

			local var_154_21 = 2

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_22 = 2

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_22 then
				local var_154_23 = (arg_151_1.time_ - var_154_21) / var_154_22
				local var_154_24 = Color.New(0, 0, 0)

				var_154_24.a = Mathf.Lerp(1, 0, var_154_23)
				arg_151_1.mask_.color = var_154_24
			end

			if arg_151_1.time_ >= var_154_21 + var_154_22 and arg_151_1.time_ < var_154_21 + var_154_22 + arg_154_0 then
				local var_154_25 = Color.New(0, 0, 0)
				local var_154_26 = 0

				arg_151_1.mask_.enabled = false
				var_154_25.a = var_154_26
				arg_151_1.mask_.color = var_154_25
			end

			local var_154_27 = arg_151_1.actors_["1137"]
			local var_154_28 = 3.8

			if var_154_28 < arg_151_1.time_ and arg_151_1.time_ <= var_154_28 + arg_154_0 and not isNil(var_154_27) and arg_151_1.var_.actorSpriteComps1137 == nil then
				arg_151_1.var_.actorSpriteComps1137 = var_154_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_29 = 0.2

			if var_154_28 <= arg_151_1.time_ and arg_151_1.time_ < var_154_28 + var_154_29 and not isNil(var_154_27) then
				local var_154_30 = (arg_151_1.time_ - var_154_28) / var_154_29

				if arg_151_1.var_.actorSpriteComps1137 then
					for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_154_3 then
							if arg_151_1.isInRecall_ then
								local var_154_31 = Mathf.Lerp(iter_154_3.color.r, arg_151_1.hightColor1.r, var_154_30)
								local var_154_32 = Mathf.Lerp(iter_154_3.color.g, arg_151_1.hightColor1.g, var_154_30)
								local var_154_33 = Mathf.Lerp(iter_154_3.color.b, arg_151_1.hightColor1.b, var_154_30)

								iter_154_3.color = Color.New(var_154_31, var_154_32, var_154_33)
							else
								local var_154_34 = Mathf.Lerp(iter_154_3.color.r, 1, var_154_30)

								iter_154_3.color = Color.New(var_154_34, var_154_34, var_154_34)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_28 + var_154_29 and arg_151_1.time_ < var_154_28 + var_154_29 + arg_154_0 and not isNil(var_154_27) and arg_151_1.var_.actorSpriteComps1137 then
				for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_154_5 then
						if arg_151_1.isInRecall_ then
							iter_154_5.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1137 = nil
			end

			local var_154_35 = arg_151_1.actors_["1137"].transform
			local var_154_36 = 3.8

			if var_154_36 < arg_151_1.time_ and arg_151_1.time_ <= var_154_36 + arg_154_0 then
				arg_151_1.var_.moveOldPos1137 = var_154_35.localPosition
				var_154_35.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1137", 3)

				local var_154_37 = var_154_35.childCount

				for iter_154_6 = 0, var_154_37 - 1 do
					local var_154_38 = var_154_35:GetChild(iter_154_6)

					if var_154_38.name == "split_6" or not string.find(var_154_38.name, "split") then
						var_154_38.gameObject:SetActive(true)
					else
						var_154_38.gameObject:SetActive(false)
					end
				end
			end

			local var_154_39 = 0.001

			if var_154_36 <= arg_151_1.time_ and arg_151_1.time_ < var_154_36 + var_154_39 then
				local var_154_40 = (arg_151_1.time_ - var_154_36) / var_154_39
				local var_154_41 = Vector3.New(0, -425, -200)

				var_154_35.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1137, var_154_41, var_154_40)
			end

			if arg_151_1.time_ >= var_154_36 + var_154_39 and arg_151_1.time_ < var_154_36 + var_154_39 + arg_154_0 then
				var_154_35.localPosition = Vector3.New(0, -425, -200)
			end

			local var_154_42 = 0.133333333333333
			local var_154_43 = 1

			if var_154_42 < arg_151_1.time_ and arg_151_1.time_ <= var_154_42 + arg_154_0 then
				local var_154_44 = "stop"
				local var_154_45 = "effect"

				arg_151_1:AudioAction(var_154_44, var_154_45, "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_154_46 = 1.66666666666667
			local var_154_47 = 1

			if var_154_46 < arg_151_1.time_ and arg_151_1.time_ <= var_154_46 + arg_154_0 then
				local var_154_48 = "play"
				local var_154_49 = "effect"

				arg_151_1:AudioAction(var_154_48, var_154_49, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_50 = 4
			local var_154_51 = 0.8

			if var_154_50 < arg_151_1.time_ and arg_151_1.time_ <= var_154_50 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_52 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_52:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_53 = arg_151_1:FormatText(StoryNameCfg[15].name)

				arg_151_1.leftNameTxt_.text = var_154_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_54 = arg_151_1:GetWordFromCfg(425122037)
				local var_154_55 = arg_151_1:FormatText(var_154_54.content)

				arg_151_1.text_.text = var_154_55

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_56 = 32
				local var_154_57 = utf8.len(var_154_55)
				local var_154_58 = var_154_56 <= 0 and var_154_51 or var_154_51 * (var_154_57 / var_154_56)

				if var_154_58 > 0 and var_154_51 < var_154_58 then
					arg_151_1.talkMaxDuration = var_154_58
					var_154_50 = var_154_50 + 0.3

					if var_154_58 + var_154_50 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_58 + var_154_50
					end
				end

				arg_151_1.text_.text = var_154_55
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122037", "story_v_out_425122.awb") ~= 0 then
					local var_154_59 = manager.audio:GetVoiceLength("story_v_out_425122", "425122037", "story_v_out_425122.awb") / 1000

					if var_154_59 + var_154_50 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_59 + var_154_50
					end

					if var_154_54.prefab_name ~= "" and arg_151_1.actors_[var_154_54.prefab_name] ~= nil then
						local var_154_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_54.prefab_name].transform, "story_v_out_425122", "425122037", "story_v_out_425122.awb")

						arg_151_1:RecordAudio("425122037", var_154_60)
						arg_151_1:RecordAudio("425122037", var_154_60)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425122", "425122037", "story_v_out_425122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425122", "425122037", "story_v_out_425122.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_61 = var_154_50 + 0.3
			local var_154_62 = math.max(var_154_51, arg_151_1.talkMaxDuration)

			if var_154_61 <= arg_151_1.time_ and arg_151_1.time_ < var_154_61 + var_154_62 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_61) / var_154_62

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_61 + var_154_62 and arg_151_1.time_ < var_154_61 + var_154_62 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play425122038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 425122038
		arg_157_1.duration_ = 5.87

		local var_157_0 = {
			zh = 4.066,
			ja = 5.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play425122039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1036"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1036 == nil then
				arg_157_1.var_.actorSpriteComps1036 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1036 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1036 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1036 = nil
			end

			local var_160_8 = arg_157_1.actors_["1137"]
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1137 == nil then
				arg_157_1.var_.actorSpriteComps1137 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_10 = 0.2

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 and not isNil(var_160_8) then
				local var_160_11 = (arg_157_1.time_ - var_160_9) / var_160_10

				if arg_157_1.var_.actorSpriteComps1137 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								local var_160_12 = Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor2.r, var_160_11)
								local var_160_13 = Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor2.g, var_160_11)
								local var_160_14 = Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor2.b, var_160_11)

								iter_160_5.color = Color.New(var_160_12, var_160_13, var_160_14)
							else
								local var_160_15 = Mathf.Lerp(iter_160_5.color.r, 0.5, var_160_11)

								iter_160_5.color = Color.New(var_160_15, var_160_15, var_160_15)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1137 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_160_7 then
						if arg_157_1.isInRecall_ then
							iter_160_7.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1137 = nil
			end

			local var_160_16 = arg_157_1.actors_["1036"].transform
			local var_160_17 = 0

			if var_160_17 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.var_.moveOldPos1036 = var_160_16.localPosition
				var_160_16.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1036", 4)

				local var_160_18 = var_160_16.childCount

				for iter_160_8 = 0, var_160_18 - 1 do
					local var_160_19 = var_160_16:GetChild(iter_160_8)

					if var_160_19.name == "" or not string.find(var_160_19.name, "split") then
						var_160_19.gameObject:SetActive(true)
					else
						var_160_19.gameObject:SetActive(false)
					end
				end
			end

			local var_160_20 = 0.001

			if var_160_17 <= arg_157_1.time_ and arg_157_1.time_ < var_160_17 + var_160_20 then
				local var_160_21 = (arg_157_1.time_ - var_160_17) / var_160_20
				local var_160_22 = Vector3.New(390, -388, -250)

				var_160_16.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1036, var_160_22, var_160_21)
			end

			if arg_157_1.time_ >= var_160_17 + var_160_20 and arg_157_1.time_ < var_160_17 + var_160_20 + arg_160_0 then
				var_160_16.localPosition = Vector3.New(390, -388, -250)
			end

			local var_160_23 = arg_157_1.actors_["1137"].transform
			local var_160_24 = 0

			if var_160_24 < arg_157_1.time_ and arg_157_1.time_ <= var_160_24 + arg_160_0 then
				arg_157_1.var_.moveOldPos1137 = var_160_23.localPosition
				var_160_23.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1137", 2)

				local var_160_25 = var_160_23.childCount

				for iter_160_9 = 0, var_160_25 - 1 do
					local var_160_26 = var_160_23:GetChild(iter_160_9)

					if var_160_26.name == "split_6" or not string.find(var_160_26.name, "split") then
						var_160_26.gameObject:SetActive(true)
					else
						var_160_26.gameObject:SetActive(false)
					end
				end
			end

			local var_160_27 = 0.001

			if var_160_24 <= arg_157_1.time_ and arg_157_1.time_ < var_160_24 + var_160_27 then
				local var_160_28 = (arg_157_1.time_ - var_160_24) / var_160_27
				local var_160_29 = Vector3.New(-390, -425, -200)

				var_160_23.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1137, var_160_29, var_160_28)
			end

			if arg_157_1.time_ >= var_160_24 + var_160_27 and arg_157_1.time_ < var_160_24 + var_160_27 + arg_160_0 then
				var_160_23.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_160_30 = 0
			local var_160_31 = 0.55

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_32 = arg_157_1:FormatText(StoryNameCfg[5].name)

				arg_157_1.leftNameTxt_.text = var_160_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(425122038)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_35 = 22
				local var_160_36 = utf8.len(var_160_34)
				local var_160_37 = var_160_35 <= 0 and var_160_31 or var_160_31 * (var_160_36 / var_160_35)

				if var_160_37 > 0 and var_160_31 < var_160_37 then
					arg_157_1.talkMaxDuration = var_160_37

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122038", "story_v_out_425122.awb") ~= 0 then
					local var_160_38 = manager.audio:GetVoiceLength("story_v_out_425122", "425122038", "story_v_out_425122.awb") / 1000

					if var_160_38 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_425122", "425122038", "story_v_out_425122.awb")

						arg_157_1:RecordAudio("425122038", var_160_39)
						arg_157_1:RecordAudio("425122038", var_160_39)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_425122", "425122038", "story_v_out_425122.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_425122", "425122038", "story_v_out_425122.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_40 and arg_157_1.time_ < var_160_30 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_157_1:InitPlayNodeList()
	end,
	Play425122039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 425122039
		arg_161_1.duration_ = 1.43

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play425122040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1137"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1137 == nil then
				arg_161_1.var_.actorSpriteComps1137 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1137 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1137 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1137 = nil
			end

			local var_164_8 = arg_161_1.actors_["1036"]
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1036 == nil then
				arg_161_1.var_.actorSpriteComps1036 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_10 = 0.2

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 and not isNil(var_164_8) then
				local var_164_11 = (arg_161_1.time_ - var_164_9) / var_164_10

				if arg_161_1.var_.actorSpriteComps1036 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								local var_164_12 = Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor2.r, var_164_11)
								local var_164_13 = Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor2.g, var_164_11)
								local var_164_14 = Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor2.b, var_164_11)

								iter_164_5.color = Color.New(var_164_12, var_164_13, var_164_14)
							else
								local var_164_15 = Mathf.Lerp(iter_164_5.color.r, 0.5, var_164_11)

								iter_164_5.color = Color.New(var_164_15, var_164_15, var_164_15)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1036 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_164_7 then
						if arg_161_1.isInRecall_ then
							iter_164_7.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1036 = nil
			end

			local var_164_16 = arg_161_1.actors_["1137"].transform
			local var_164_17 = 0

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.var_.moveOldPos1137 = var_164_16.localPosition
				var_164_16.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1137", 2)

				local var_164_18 = var_164_16.childCount

				for iter_164_8 = 0, var_164_18 - 1 do
					local var_164_19 = var_164_16:GetChild(iter_164_8)

					if var_164_19.name == "split_4" then
						var_164_19:SetAsLastSibling()
						var_164_19.gameObject:SetActive(true)

						arg_161_1.var_.actorSpriteSplit1137 = var_164_19.gameObject:GetComponent(typeof(Image))

						arg_161_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_164_20 = 0.2

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_20 then
				local var_164_21 = (arg_161_1.time_ - var_164_17) / var_164_20
				local var_164_22 = Vector3.New(-390, -425, -200)

				var_164_16.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1137, var_164_22, var_164_21)

				if arg_161_1.var_.actorSpriteSplit1137 ~= nil then
					arg_161_1.var_.actorSpriteSplit1137:SetAlpha(var_164_21)
				end
			end

			if arg_161_1.time_ >= var_164_17 + var_164_20 and arg_161_1.time_ < var_164_17 + var_164_20 + arg_164_0 then
				var_164_16.localPosition = Vector3.New(-390, -425, -200)

				if arg_161_1.var_.actorSpriteSplit1137 ~= nil then
					arg_161_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_24 = 0.2

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_25 = 0
			local var_164_26 = 0.1

			if var_164_25 < arg_161_1.time_ and arg_161_1.time_ <= var_164_25 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_27 = arg_161_1:FormatText(StoryNameCfg[15].name)

				arg_161_1.leftNameTxt_.text = var_164_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_28 = arg_161_1:GetWordFromCfg(425122039)
				local var_164_29 = arg_161_1:FormatText(var_164_28.content)

				arg_161_1.text_.text = var_164_29

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_30 = 4
				local var_164_31 = utf8.len(var_164_29)
				local var_164_32 = var_164_30 <= 0 and var_164_26 or var_164_26 * (var_164_31 / var_164_30)

				if var_164_32 > 0 and var_164_26 < var_164_32 then
					arg_161_1.talkMaxDuration = var_164_32

					if var_164_32 + var_164_25 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_32 + var_164_25
					end
				end

				arg_161_1.text_.text = var_164_29
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122039", "story_v_out_425122.awb") ~= 0 then
					local var_164_33 = manager.audio:GetVoiceLength("story_v_out_425122", "425122039", "story_v_out_425122.awb") / 1000

					if var_164_33 + var_164_25 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_33 + var_164_25
					end

					if var_164_28.prefab_name ~= "" and arg_161_1.actors_[var_164_28.prefab_name] ~= nil then
						local var_164_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_28.prefab_name].transform, "story_v_out_425122", "425122039", "story_v_out_425122.awb")

						arg_161_1:RecordAudio("425122039", var_164_34)
						arg_161_1:RecordAudio("425122039", var_164_34)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_425122", "425122039", "story_v_out_425122.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_425122", "425122039", "story_v_out_425122.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_35 = math.max(var_164_26, arg_161_1.talkMaxDuration)

			if var_164_25 <= arg_161_1.time_ and arg_161_1.time_ < var_164_25 + var_164_35 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_25) / var_164_35

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_25 + var_164_35 and arg_161_1.time_ < var_164_25 + var_164_35 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play425122040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 425122040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play425122041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1137"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1137 == nil then
				arg_165_1.var_.actorSpriteComps1137 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps1137 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1137 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1137 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.925

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(425122040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 37
				local var_168_13 = utf8.len(var_168_11)
				local var_168_14 = var_168_12 <= 0 and var_168_9 or var_168_9 * (var_168_13 / var_168_12)

				if var_168_14 > 0 and var_168_9 < var_168_14 then
					arg_165_1.talkMaxDuration = var_168_14

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_15 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_15 and arg_165_1.time_ < var_168_8 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play425122041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 425122041
		arg_169_1.duration_ = 3.67

		local var_169_0 = {
			zh = 2.066,
			ja = 3.666
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play425122042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1036"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1036 == nil then
				arg_169_1.var_.actorSpriteComps1036 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps1036 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1036 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1036 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.275

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[5].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(425122041)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 11
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_9 or var_172_9 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_9 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122041", "story_v_out_425122.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122041", "story_v_out_425122.awb") / 1000

					if var_172_16 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_8
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_425122", "425122041", "story_v_out_425122.awb")

						arg_169_1:RecordAudio("425122041", var_172_17)
						arg_169_1:RecordAudio("425122041", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_425122", "425122041", "story_v_out_425122.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_425122", "425122041", "story_v_out_425122.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_18 and arg_169_1.time_ < var_172_8 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play425122042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 425122042
		arg_173_1.duration_ = 4.6

		local var_173_0 = {
			zh = 4.366,
			ja = 4.6
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play425122043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.5

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[5].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(425122042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 20
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122042", "story_v_out_425122.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122042", "story_v_out_425122.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_425122", "425122042", "story_v_out_425122.awb")

						arg_173_1:RecordAudio("425122042", var_176_9)
						arg_173_1:RecordAudio("425122042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_425122", "425122042", "story_v_out_425122.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_425122", "425122042", "story_v_out_425122.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play425122043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 425122043
		arg_177_1.duration_ = 3.33

		local var_177_0 = {
			zh = 1.366,
			ja = 3.333
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play425122044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1137"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1137 == nil then
				arg_177_1.var_.actorSpriteComps1137 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1137 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1137 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1137 = nil
			end

			local var_180_8 = arg_177_1.actors_["1036"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1036 == nil then
				arg_177_1.var_.actorSpriteComps1036 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps1036 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1036 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1036 = nil
			end

			local var_180_16 = 0
			local var_180_17 = 0.15

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_18 = arg_177_1:FormatText(StoryNameCfg[15].name)

				arg_177_1.leftNameTxt_.text = var_180_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:GetWordFromCfg(425122043)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 6
				local var_180_22 = utf8.len(var_180_20)
				local var_180_23 = var_180_21 <= 0 and var_180_17 or var_180_17 * (var_180_22 / var_180_21)

				if var_180_23 > 0 and var_180_17 < var_180_23 then
					arg_177_1.talkMaxDuration = var_180_23

					if var_180_23 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122043", "story_v_out_425122.awb") ~= 0 then
					local var_180_24 = manager.audio:GetVoiceLength("story_v_out_425122", "425122043", "story_v_out_425122.awb") / 1000

					if var_180_24 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_24 + var_180_16
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_425122", "425122043", "story_v_out_425122.awb")

						arg_177_1:RecordAudio("425122043", var_180_25)
						arg_177_1:RecordAudio("425122043", var_180_25)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_425122", "425122043", "story_v_out_425122.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_425122", "425122043", "story_v_out_425122.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_26 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_26 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_16) / var_180_26

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_16 + var_180_26 and arg_177_1.time_ < var_180_16 + var_180_26 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play425122044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 425122044
		arg_181_1.duration_ = 6.23

		local var_181_0 = {
			zh = 4.6,
			ja = 6.233
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play425122045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1036"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1036 == nil then
				arg_181_1.var_.actorSpriteComps1036 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps1036 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1036 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1036 = nil
			end

			local var_184_8 = arg_181_1.actors_["1137"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1137 == nil then
				arg_181_1.var_.actorSpriteComps1137 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps1137 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1137 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1137 = nil
			end

			local var_184_16 = 0
			local var_184_17 = 0.6

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_18 = arg_181_1:FormatText(StoryNameCfg[5].name)

				arg_181_1.leftNameTxt_.text = var_184_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:GetWordFromCfg(425122044)
				local var_184_20 = arg_181_1:FormatText(var_184_19.content)

				arg_181_1.text_.text = var_184_20

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 24
				local var_184_22 = utf8.len(var_184_20)
				local var_184_23 = var_184_21 <= 0 and var_184_17 or var_184_17 * (var_184_22 / var_184_21)

				if var_184_23 > 0 and var_184_17 < var_184_23 then
					arg_181_1.talkMaxDuration = var_184_23

					if var_184_23 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_20
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122044", "story_v_out_425122.awb") ~= 0 then
					local var_184_24 = manager.audio:GetVoiceLength("story_v_out_425122", "425122044", "story_v_out_425122.awb") / 1000

					if var_184_24 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_16
					end

					if var_184_19.prefab_name ~= "" and arg_181_1.actors_[var_184_19.prefab_name] ~= nil then
						local var_184_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_19.prefab_name].transform, "story_v_out_425122", "425122044", "story_v_out_425122.awb")

						arg_181_1:RecordAudio("425122044", var_184_25)
						arg_181_1:RecordAudio("425122044", var_184_25)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_425122", "425122044", "story_v_out_425122.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_425122", "425122044", "story_v_out_425122.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_16) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_16 + var_184_26 and arg_181_1.time_ < var_184_16 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play425122045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 425122045
		arg_185_1.duration_ = 4.5

		local var_185_0 = {
			zh = 3.3,
			ja = 4.5
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play425122046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.425

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[5].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(425122045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 17
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122045", "story_v_out_425122.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122045", "story_v_out_425122.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_425122", "425122045", "story_v_out_425122.awb")

						arg_185_1:RecordAudio("425122045", var_188_9)
						arg_185_1:RecordAudio("425122045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_425122", "425122045", "story_v_out_425122.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_425122", "425122045", "story_v_out_425122.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play425122046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 425122046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play425122047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1036"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1036 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1036", 7)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -2000, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1036, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_7 = arg_189_1.actors_["1137"].transform
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.var_.moveOldPos1137 = var_192_7.localPosition
				var_192_7.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1137", 7)

				local var_192_9 = var_192_7.childCount

				for iter_192_1 = 0, var_192_9 - 1 do
					local var_192_10 = var_192_7:GetChild(iter_192_1)

					if var_192_10.name == "" or not string.find(var_192_10.name, "split") then
						var_192_10.gameObject:SetActive(true)
					else
						var_192_10.gameObject:SetActive(false)
					end
				end
			end

			local var_192_11 = 0.001

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_11 then
				local var_192_12 = (arg_189_1.time_ - var_192_8) / var_192_11
				local var_192_13 = Vector3.New(0, -2000, 0)

				var_192_7.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1137, var_192_13, var_192_12)
			end

			if arg_189_1.time_ >= var_192_8 + var_192_11 and arg_189_1.time_ < var_192_8 + var_192_11 + arg_192_0 then
				var_192_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_14 = 0
			local var_192_15 = 0.825

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_16 = arg_189_1:GetWordFromCfg(425122046)
				local var_192_17 = arg_189_1:FormatText(var_192_16.content)

				arg_189_1.text_.text = var_192_17

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_18 = 33
				local var_192_19 = utf8.len(var_192_17)
				local var_192_20 = var_192_18 <= 0 and var_192_15 or var_192_15 * (var_192_19 / var_192_18)

				if var_192_20 > 0 and var_192_15 < var_192_20 then
					arg_189_1.talkMaxDuration = var_192_20

					if var_192_20 + var_192_14 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_14
					end
				end

				arg_189_1.text_.text = var_192_17
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_21 = math.max(var_192_15, arg_189_1.talkMaxDuration)

			if var_192_14 <= arg_189_1.time_ and arg_189_1.time_ < var_192_14 + var_192_21 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_14) / var_192_21

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_14 + var_192_21 and arg_189_1.time_ < var_192_14 + var_192_21 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_189_1:InitPlayNodeList()
	end,
	Play425122047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 425122047
		arg_193_1.duration_ = 7.1

		local var_193_0 = {
			zh = 6.733,
			ja = 7.1
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
				arg_193_0:Play425122048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1036"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1036 == nil then
				arg_193_1.var_.actorSpriteComps1036 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1036 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1036 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1036 = nil
			end

			local var_196_8 = arg_193_1.actors_["1036"].transform
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.var_.moveOldPos1036 = var_196_8.localPosition
				var_196_8.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1036", 3)

				local var_196_10 = var_196_8.childCount

				for iter_196_4 = 0, var_196_10 - 1 do
					local var_196_11 = var_196_8:GetChild(iter_196_4)

					if var_196_11.name == "" or not string.find(var_196_11.name, "split") then
						var_196_11.gameObject:SetActive(true)
					else
						var_196_11.gameObject:SetActive(false)
					end
				end
			end

			local var_196_12 = 0.001

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_12 then
				local var_196_13 = (arg_193_1.time_ - var_196_9) / var_196_12
				local var_196_14 = Vector3.New(0, -388, -250)

				var_196_8.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1036, var_196_14, var_196_13)
			end

			if arg_193_1.time_ >= var_196_9 + var_196_12 and arg_193_1.time_ < var_196_9 + var_196_12 + arg_196_0 then
				var_196_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_196_15 = 0
			local var_196_16 = 0.75

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[5].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(425122047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 30
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122047", "story_v_out_425122.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122047", "story_v_out_425122.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_425122", "425122047", "story_v_out_425122.awb")

						arg_193_1:RecordAudio("425122047", var_196_24)
						arg_193_1:RecordAudio("425122047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_425122", "425122047", "story_v_out_425122.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_425122", "425122047", "story_v_out_425122.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425122048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 425122048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play425122049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1036"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1036 == nil then
				arg_197_1.var_.actorSpriteComps1036 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps1036 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 0.5, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1036 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1036 = nil
			end

			local var_200_8 = arg_197_1.actors_["1036"].transform
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.var_.moveOldPos1036 = var_200_8.localPosition
				var_200_8.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1036", 7)

				local var_200_10 = var_200_8.childCount

				for iter_200_4 = 0, var_200_10 - 1 do
					local var_200_11 = var_200_8:GetChild(iter_200_4)

					if var_200_11.name == "" or not string.find(var_200_11.name, "split") then
						var_200_11.gameObject:SetActive(true)
					else
						var_200_11.gameObject:SetActive(false)
					end
				end
			end

			local var_200_12 = 0.001

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_12 then
				local var_200_13 = (arg_197_1.time_ - var_200_9) / var_200_12
				local var_200_14 = Vector3.New(0, -2000, 0)

				var_200_8.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1036, var_200_14, var_200_13)
			end

			if arg_197_1.time_ >= var_200_9 + var_200_12 and arg_197_1.time_ < var_200_9 + var_200_12 + arg_200_0 then
				var_200_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_200_15 = 0
			local var_200_16 = 0.55

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_17 = arg_197_1:GetWordFromCfg(425122048)
				local var_200_18 = arg_197_1:FormatText(var_200_17.content)

				arg_197_1.text_.text = var_200_18

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_19 = 22
				local var_200_20 = utf8.len(var_200_18)
				local var_200_21 = var_200_19 <= 0 and var_200_16 or var_200_16 * (var_200_20 / var_200_19)

				if var_200_21 > 0 and var_200_16 < var_200_21 then
					arg_197_1.talkMaxDuration = var_200_21

					if var_200_21 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_21 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_18
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_22 and arg_197_1.time_ < var_200_15 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play425122049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 425122049
		arg_201_1.duration_ = 9

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play425122050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 2

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.M01g

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "M01g" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = 4

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_15 = 0.7

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_17 = 2

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Color.New(0, 0, 0)

				var_204_19.a = Mathf.Lerp(0, 1, var_204_18)
				arg_201_1.mask_.color = var_204_19
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				local var_204_20 = Color.New(0, 0, 0)

				var_204_20.a = 1
				arg_201_1.mask_.color = var_204_20
			end

			local var_204_21 = 2

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_22 = 2

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_22 then
				local var_204_23 = (arg_201_1.time_ - var_204_21) / var_204_22
				local var_204_24 = Color.New(0, 0, 0)

				var_204_24.a = Mathf.Lerp(1, 0, var_204_23)
				arg_201_1.mask_.color = var_204_24
			end

			if arg_201_1.time_ >= var_204_21 + var_204_22 and arg_201_1.time_ < var_204_21 + var_204_22 + arg_204_0 then
				local var_204_25 = Color.New(0, 0, 0)
				local var_204_26 = 0

				arg_201_1.mask_.enabled = false
				var_204_25.a = var_204_26
				arg_201_1.mask_.color = var_204_25
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_27 = 4
			local var_204_28 = 1.325

			if var_204_27 < arg_201_1.time_ and arg_201_1.time_ <= var_204_27 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_29 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_29:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_30 = arg_201_1:GetWordFromCfg(425122049)
				local var_204_31 = arg_201_1:FormatText(var_204_30.content)

				arg_201_1.text_.text = var_204_31

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_32 = 53
				local var_204_33 = utf8.len(var_204_31)
				local var_204_34 = var_204_32 <= 0 and var_204_28 or var_204_28 * (var_204_33 / var_204_32)

				if var_204_34 > 0 and var_204_28 < var_204_34 then
					arg_201_1.talkMaxDuration = var_204_34
					var_204_27 = var_204_27 + 0.3

					if var_204_34 + var_204_27 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_34 + var_204_27
					end
				end

				arg_201_1.text_.text = var_204_31
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_35 = var_204_27 + 0.3
			local var_204_36 = math.max(var_204_28, arg_201_1.talkMaxDuration)

			if var_204_35 <= arg_201_1.time_ and arg_201_1.time_ < var_204_35 + var_204_36 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_35) / var_204_36

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_35 + var_204_36 and arg_201_1.time_ < var_204_35 + var_204_36 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play425122050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 425122050
		arg_207_1.duration_ = 1.7

		local var_207_0 = {
			zh = 1.633,
			ja = 1.7
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play425122051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1036"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1036 == nil then
				arg_207_1.var_.actorSpriteComps1036 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps1036 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 1, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1036 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1036 = nil
			end

			local var_210_8 = arg_207_1.actors_["1036"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos1036 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1036", 3)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(0, -388, -250)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1036, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_210_15 = 0
			local var_210_16 = 0.15

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[5].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(425122050)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 6
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122050", "story_v_out_425122.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122050", "story_v_out_425122.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_425122", "425122050", "story_v_out_425122.awb")

						arg_207_1:RecordAudio("425122050", var_210_24)
						arg_207_1:RecordAudio("425122050", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_425122", "425122050", "story_v_out_425122.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_425122", "425122050", "story_v_out_425122.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play425122051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 425122051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play425122052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1036"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1036 == nil then
				arg_211_1.var_.actorSpriteComps1036 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps1036 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 0.5, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1036 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1036 = nil
			end

			local var_214_8 = arg_211_1.actors_["1036"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos1036 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1036", 7)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(0, -2000, 0)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1036, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_15 = 0.4
			local var_214_16 = 1

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				local var_214_17 = "play"
				local var_214_18 = "effect"

				arg_211_1:AudioAction(var_214_17, var_214_18, "se_story_121_00", "se_story_121_00_monster_death", "")
			end

			local var_214_19 = manager.ui.mainCamera.transform
			local var_214_20 = 0.4

			if var_214_20 < arg_211_1.time_ and arg_211_1.time_ <= var_214_20 + arg_214_0 then
				local var_214_21 = arg_211_1.var_.effect10092051
				local var_214_22
				local var_214_23 = var_214_19

				if not var_214_21 then
					var_214_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_214_23)
					var_214_21.name = "2051"
					arg_211_1.var_.effect10092051 = var_214_21
				else
					var_214_21.transform:SetParent(var_214_23)
				end

				var_214_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_214_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_214_24 = manager.ui.mainCamera.transform
			local var_214_25 = 1.93333333333333

			if var_214_25 < arg_211_1.time_ and arg_211_1.time_ <= var_214_25 + arg_214_0 then
				local var_214_26 = arg_211_1.var_.effect10092051

				if var_214_26 then
					Object.Destroy(var_214_26)

					arg_211_1.var_.effect10092051 = nil
				end
			end

			local var_214_27 = manager.ui.mainCamera.transform
			local var_214_28 = 0.4

			if var_214_28 < arg_211_1.time_ and arg_211_1.time_ <= var_214_28 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_27.localPosition
			end

			local var_214_29 = 0.3

			if var_214_28 <= arg_211_1.time_ and arg_211_1.time_ < var_214_28 + var_214_29 then
				local var_214_30 = (arg_211_1.time_ - var_214_28) / 0.066
				local var_214_31, var_214_32 = math.modf(var_214_30)

				var_214_27.localPosition = Vector3.New(var_214_32 * 0.13, var_214_32 * 0.13, var_214_32 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= var_214_28 + var_214_29 and arg_211_1.time_ < var_214_28 + var_214_29 + arg_214_0 then
				var_214_27.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_33 = 0
			local var_214_34 = 0.85

			if var_214_33 < arg_211_1.time_ and arg_211_1.time_ <= var_214_33 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_35 = arg_211_1:GetWordFromCfg(425122051)
				local var_214_36 = arg_211_1:FormatText(var_214_35.content)

				arg_211_1.text_.text = var_214_36

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_37 = 34
				local var_214_38 = utf8.len(var_214_36)
				local var_214_39 = var_214_37 <= 0 and var_214_34 or var_214_34 * (var_214_38 / var_214_37)

				if var_214_39 > 0 and var_214_34 < var_214_39 then
					arg_211_1.talkMaxDuration = var_214_39

					if var_214_39 + var_214_33 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_39 + var_214_33
					end
				end

				arg_211_1.text_.text = var_214_36
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_40 = math.max(var_214_34, arg_211_1.talkMaxDuration)

			if var_214_33 <= arg_211_1.time_ and arg_211_1.time_ < var_214_33 + var_214_40 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_33) / var_214_40

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_33 + var_214_40 and arg_211_1.time_ < var_214_33 + var_214_40 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play425122052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 425122052
		arg_215_1.duration_ = 3.87

		local var_215_0 = {
			zh = 2.8,
			ja = 3.866
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play425122053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1036"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1036 == nil then
				arg_215_1.var_.actorSpriteComps1036 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps1036 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1036 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1036 = nil
			end

			local var_218_8 = arg_215_1.actors_["1036"].transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPos1036 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1036", 3)

				local var_218_10 = var_218_8.childCount

				for iter_218_4 = 0, var_218_10 - 1 do
					local var_218_11 = var_218_8:GetChild(iter_218_4)

					if var_218_11.name == "" or not string.find(var_218_11.name, "split") then
						var_218_11.gameObject:SetActive(true)
					else
						var_218_11.gameObject:SetActive(false)
					end
				end
			end

			local var_218_12 = 0.001

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_9) / var_218_12
				local var_218_14 = Vector3.New(0, -388, -250)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1036, var_218_14, var_218_13)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_12 and arg_215_1.time_ < var_218_9 + var_218_12 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_218_15 = 0
			local var_218_16 = 0.35

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[5].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(425122052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 14
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122052", "story_v_out_425122.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122052", "story_v_out_425122.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_425122", "425122052", "story_v_out_425122.awb")

						arg_215_1:RecordAudio("425122052", var_218_24)
						arg_215_1:RecordAudio("425122052", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_425122", "425122052", "story_v_out_425122.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_425122", "425122052", "story_v_out_425122.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play425122053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 425122053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play425122054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1036"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1036 = var_222_0.localPosition
				var_222_0.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1036", 7)

				local var_222_2 = var_222_0.childCount

				for iter_222_0 = 0, var_222_2 - 1 do
					local var_222_3 = var_222_0:GetChild(iter_222_0)

					if var_222_3.name == "" or not string.find(var_222_3.name, "split") then
						var_222_3.gameObject:SetActive(true)
					else
						var_222_3.gameObject:SetActive(false)
					end
				end
			end

			local var_222_4 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_4 then
				local var_222_5 = (arg_219_1.time_ - var_222_1) / var_222_4
				local var_222_6 = Vector3.New(0, -2000, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1036, var_222_6, var_222_5)
			end

			if arg_219_1.time_ >= var_222_1 + var_222_4 and arg_219_1.time_ < var_222_1 + var_222_4 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_7 = 0
			local var_222_8 = 1.1

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(425122053)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 44
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_8 or var_222_8 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_8 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_7) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_7 + var_222_14 and arg_219_1.time_ < var_222_7 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play425122054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 425122054
		arg_223_1.duration_ = 2.77

		local var_223_0 = {
			zh = 1.6,
			ja = 2.766
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play425122055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.175

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[236].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_223_1.callingController_:SetSelectedState("calling")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(425122054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 7
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122054", "story_v_out_425122.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122054", "story_v_out_425122.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_425122", "425122054", "story_v_out_425122.awb")

						arg_223_1:RecordAudio("425122054", var_226_9)
						arg_223_1:RecordAudio("425122054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_425122", "425122054", "story_v_out_425122.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_425122", "425122054", "story_v_out_425122.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play425122055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 425122055
		arg_227_1.duration_ = 7.27

		local var_227_0 = {
			zh = 5.433,
			ja = 7.266
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play425122056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1036"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1036 == nil then
				arg_227_1.var_.actorSpriteComps1036 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1036 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 1, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1036 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1036 = nil
			end

			local var_230_8 = arg_227_1.actors_["1036"].transform
			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.var_.moveOldPos1036 = var_230_8.localPosition
				var_230_8.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1036", 3)

				local var_230_10 = var_230_8.childCount

				for iter_230_4 = 0, var_230_10 - 1 do
					local var_230_11 = var_230_8:GetChild(iter_230_4)

					if var_230_11.name == "" or not string.find(var_230_11.name, "split") then
						var_230_11.gameObject:SetActive(true)
					else
						var_230_11.gameObject:SetActive(false)
					end
				end
			end

			local var_230_12 = 0.001

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_12 then
				local var_230_13 = (arg_227_1.time_ - var_230_9) / var_230_12
				local var_230_14 = Vector3.New(0, -388, -250)

				var_230_8.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1036, var_230_14, var_230_13)
			end

			if arg_227_1.time_ >= var_230_9 + var_230_12 and arg_227_1.time_ < var_230_9 + var_230_12 + arg_230_0 then
				var_230_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_230_15 = 0
			local var_230_16 = 0.725

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[5].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(425122055)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 29
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122055", "story_v_out_425122.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122055", "story_v_out_425122.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_425122", "425122055", "story_v_out_425122.awb")

						arg_227_1:RecordAudio("425122055", var_230_24)
						arg_227_1:RecordAudio("425122055", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_425122", "425122055", "story_v_out_425122.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_425122", "425122055", "story_v_out_425122.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play425122056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 425122056
		arg_231_1.duration_ = 5.73

		local var_231_0 = {
			zh = 3.4,
			ja = 5.733
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play425122057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1036"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1036 == nil then
				arg_231_1.var_.actorSpriteComps1036 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1036 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 0.5, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1036 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1036 = nil
			end

			local var_234_8 = 0
			local var_234_9 = 0.475

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_10 = arg_231_1:FormatText(StoryNameCfg[236].name)

				arg_231_1.leftNameTxt_.text = var_234_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_231_1.callingController_:SetSelectedState("calling")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_11 = arg_231_1:GetWordFromCfg(425122056)
				local var_234_12 = arg_231_1:FormatText(var_234_11.content)

				arg_231_1.text_.text = var_234_12

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 19
				local var_234_14 = utf8.len(var_234_12)
				local var_234_15 = var_234_13 <= 0 and var_234_9 or var_234_9 * (var_234_14 / var_234_13)

				if var_234_15 > 0 and var_234_9 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_12
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122056", "story_v_out_425122.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122056", "story_v_out_425122.awb") / 1000

					if var_234_16 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_8
					end

					if var_234_11.prefab_name ~= "" and arg_231_1.actors_[var_234_11.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_11.prefab_name].transform, "story_v_out_425122", "425122056", "story_v_out_425122.awb")

						arg_231_1:RecordAudio("425122056", var_234_17)
						arg_231_1:RecordAudio("425122056", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_425122", "425122056", "story_v_out_425122.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_425122", "425122056", "story_v_out_425122.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_18 and arg_231_1.time_ < var_234_8 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play425122057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 425122057
		arg_235_1.duration_ = 3.13

		local var_235_0 = {
			zh = 3.066,
			ja = 3.133
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play425122058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1036"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1036 == nil then
				arg_235_1.var_.actorSpriteComps1036 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1036 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1036 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1036 = nil
			end

			local var_238_8 = arg_235_1.actors_["1036"].transform
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.var_.moveOldPos1036 = var_238_8.localPosition
				var_238_8.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1036", 3)

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
				local var_238_14 = Vector3.New(0, -388, -250)

				var_238_8.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1036, var_238_14, var_238_13)
			end

			if arg_235_1.time_ >= var_238_9 + var_238_12 and arg_235_1.time_ < var_238_9 + var_238_12 + arg_238_0 then
				var_238_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_238_15 = 0
			local var_238_16 = 0.35

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_17 = arg_235_1:FormatText(StoryNameCfg[5].name)

				arg_235_1.leftNameTxt_.text = var_238_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_18 = arg_235_1:GetWordFromCfg(425122057)
				local var_238_19 = arg_235_1:FormatText(var_238_18.content)

				arg_235_1.text_.text = var_238_19

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122057", "story_v_out_425122.awb") ~= 0 then
					local var_238_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122057", "story_v_out_425122.awb") / 1000

					if var_238_23 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_15
					end

					if var_238_18.prefab_name ~= "" and arg_235_1.actors_[var_238_18.prefab_name] ~= nil then
						local var_238_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_18.prefab_name].transform, "story_v_out_425122", "425122057", "story_v_out_425122.awb")

						arg_235_1:RecordAudio("425122057", var_238_24)
						arg_235_1:RecordAudio("425122057", var_238_24)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_425122", "425122057", "story_v_out_425122.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_425122", "425122057", "story_v_out_425122.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_25 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_25 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_25

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_25 and arg_235_1.time_ < var_238_15 + var_238_25 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425122058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 425122058
		arg_239_1.duration_ = 3.47

		local var_239_0 = {
			zh = 1.3,
			ja = 3.466
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play425122059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1036"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1036 == nil then
				arg_239_1.var_.actorSpriteComps1036 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps1036 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1036 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1036 = nil
			end

			local var_242_8 = 0
			local var_242_9 = 0.2

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_10 = arg_239_1:FormatText(StoryNameCfg[236].name)

				arg_239_1.leftNameTxt_.text = var_242_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_239_1.callingController_:SetSelectedState("calling")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_11 = arg_239_1:GetWordFromCfg(425122058)
				local var_242_12 = arg_239_1:FormatText(var_242_11.content)

				arg_239_1.text_.text = var_242_12

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122058", "story_v_out_425122.awb") ~= 0 then
					local var_242_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122058", "story_v_out_425122.awb") / 1000

					if var_242_16 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_16 + var_242_8
					end

					if var_242_11.prefab_name ~= "" and arg_239_1.actors_[var_242_11.prefab_name] ~= nil then
						local var_242_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_11.prefab_name].transform, "story_v_out_425122", "425122058", "story_v_out_425122.awb")

						arg_239_1:RecordAudio("425122058", var_242_17)
						arg_239_1:RecordAudio("425122058", var_242_17)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_425122", "425122058", "story_v_out_425122.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_425122", "425122058", "story_v_out_425122.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_18 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_18 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_18

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_18 and arg_239_1.time_ < var_242_8 + var_242_18 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play425122059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 425122059
		arg_243_1.duration_ = 5.37

		local var_243_0 = {
			zh = 3.933,
			ja = 5.366
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play425122060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1036"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1036 == nil then
				arg_243_1.var_.actorSpriteComps1036 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1036 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1036 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1036 = nil
			end

			local var_246_8 = arg_243_1.actors_["1036"].transform
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.var_.moveOldPos1036 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1036", 3)

				local var_246_10 = var_246_8.childCount

				for iter_246_4 = 0, var_246_10 - 1 do
					local var_246_11 = var_246_8:GetChild(iter_246_4)

					if var_246_11.name == "" or not string.find(var_246_11.name, "split") then
						var_246_11.gameObject:SetActive(true)
					else
						var_246_11.gameObject:SetActive(false)
					end
				end
			end

			local var_246_12 = 0.001

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_9) / var_246_12
				local var_246_14 = Vector3.New(0, -388, -250)

				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1036, var_246_14, var_246_13)
			end

			if arg_243_1.time_ >= var_246_9 + var_246_12 and arg_243_1.time_ < var_246_9 + var_246_12 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_246_15 = 0
			local var_246_16 = 0.475

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[5].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(425122059)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122059", "story_v_out_425122.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122059", "story_v_out_425122.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_425122", "425122059", "story_v_out_425122.awb")

						arg_243_1:RecordAudio("425122059", var_246_24)
						arg_243_1:RecordAudio("425122059", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_425122", "425122059", "story_v_out_425122.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_425122", "425122059", "story_v_out_425122.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425122060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 425122060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play425122061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1036"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1036 == nil then
				arg_247_1.var_.actorSpriteComps1036 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps1036 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1036 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1036 = nil
			end

			local var_250_8 = arg_247_1.actors_["1036"].transform
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.var_.moveOldPos1036 = var_250_8.localPosition
				var_250_8.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1036", 7)

				local var_250_10 = var_250_8.childCount

				for iter_250_4 = 0, var_250_10 - 1 do
					local var_250_11 = var_250_8:GetChild(iter_250_4)

					if var_250_11.name == "" or not string.find(var_250_11.name, "split") then
						var_250_11.gameObject:SetActive(true)
					else
						var_250_11.gameObject:SetActive(false)
					end
				end
			end

			local var_250_12 = 0.001

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_12 then
				local var_250_13 = (arg_247_1.time_ - var_250_9) / var_250_12
				local var_250_14 = Vector3.New(0, -2000, 0)

				var_250_8.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1036, var_250_14, var_250_13)
			end

			if arg_247_1.time_ >= var_250_9 + var_250_12 and arg_247_1.time_ < var_250_9 + var_250_12 + arg_250_0 then
				var_250_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_15 = 0
			local var_250_16 = 0.6

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_17 = arg_247_1:GetWordFromCfg(425122060)
				local var_250_18 = arg_247_1:FormatText(var_250_17.content)

				arg_247_1.text_.text = var_250_18

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_19 = 24
				local var_250_20 = utf8.len(var_250_18)
				local var_250_21 = var_250_19 <= 0 and var_250_16 or var_250_16 * (var_250_20 / var_250_19)

				if var_250_21 > 0 and var_250_16 < var_250_21 then
					arg_247_1.talkMaxDuration = var_250_21

					if var_250_21 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_21 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_18
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_22 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_22

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_22 and arg_247_1.time_ < var_250_15 + var_250_22 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play425122061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 425122061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play425122062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.133333333333333
			local var_254_1 = 1

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				local var_254_2 = "play"
				local var_254_3 = "effect"

				arg_251_1:AudioAction(var_254_2, var_254_3, "se_story_141", "se_story_141_rush", "")
			end

			local var_254_4 = 0
			local var_254_5 = 1.25

			if var_254_4 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(425122061)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_8 = 50
				local var_254_9 = utf8.len(var_254_7)
				local var_254_10 = var_254_8 <= 0 and var_254_5 or var_254_5 * (var_254_9 / var_254_8)

				if var_254_10 > 0 and var_254_5 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_11 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_11 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_11

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_11 and arg_251_1.time_ < var_254_4 + var_254_11 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play425122062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 425122062
		arg_255_1.duration_ = 3.47

		local var_255_0 = {
			zh = 1.566,
			ja = 3.466
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play425122063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.2

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[236].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_255_1.callingController_:SetSelectedState("calling")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(425122062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 8
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122062", "story_v_out_425122.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122062", "story_v_out_425122.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_425122", "425122062", "story_v_out_425122.awb")

						arg_255_1:RecordAudio("425122062", var_258_9)
						arg_255_1:RecordAudio("425122062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_425122", "425122062", "story_v_out_425122.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_425122", "425122062", "story_v_out_425122.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play425122063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 425122063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play425122064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 1

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				local var_262_2 = "play"
				local var_262_3 = "effect"

				arg_259_1:AudioAction(var_262_2, var_262_3, "se_story_147", "se_story_147_phone_busy", "")
			end

			local var_262_4 = 0
			local var_262_5 = 0.225

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(425122063)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_8 = 9
				local var_262_9 = utf8.len(var_262_7)
				local var_262_10 = var_262_8 <= 0 and var_262_5 or var_262_5 * (var_262_9 / var_262_8)

				if var_262_10 > 0 and var_262_5 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_11 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_11 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_11

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_11 and arg_259_1.time_ < var_262_4 + var_262_11 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play425122064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 425122064
		arg_263_1.duration_ = 2.45

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play425122065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_1 = 1

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_1 then
				local var_266_2 = (arg_263_1.time_ - var_266_0) / var_266_1
				local var_266_3 = Color.New(0, 0, 0)

				var_266_3.a = Mathf.Lerp(0, 1, var_266_2)
				arg_263_1.mask_.color = var_266_3
			end

			if arg_263_1.time_ >= var_266_0 + var_266_1 and arg_263_1.time_ < var_266_0 + var_266_1 + arg_266_0 then
				local var_266_4 = Color.New(0, 0, 0)

				var_266_4.a = 1
				arg_263_1.mask_.color = var_266_4
			end

			local var_266_5 = 1

			if var_266_5 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_6 = 1

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_6 then
				local var_266_7 = (arg_263_1.time_ - var_266_5) / var_266_6
				local var_266_8 = Color.New(0, 0, 0)

				var_266_8.a = Mathf.Lerp(1, 0, var_266_7)
				arg_263_1.mask_.color = var_266_8
			end

			if arg_263_1.time_ >= var_266_5 + var_266_6 and arg_263_1.time_ < var_266_5 + var_266_6 + arg_266_0 then
				local var_266_9 = Color.New(0, 0, 0)
				local var_266_10 = 0

				arg_263_1.mask_.enabled = false
				var_266_9.a = var_266_10
				arg_263_1.mask_.color = var_266_9
			end

			local var_266_11 = "STblack"

			if arg_263_1.bgs_[var_266_11] == nil then
				local var_266_12 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_266_11)
				var_266_12.name = var_266_11
				var_266_12.transform.parent = arg_263_1.stage_.transform
				var_266_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_[var_266_11] = var_266_12
			end

			local var_266_13 = 1

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				local var_266_14 = manager.ui.mainCamera.transform.localPosition
				local var_266_15 = Vector3.New(0, 0, 10) + Vector3.New(var_266_14.x, var_266_14.y, 0)
				local var_266_16 = arg_263_1.bgs_.STblack

				var_266_16.transform.localPosition = var_266_15
				var_266_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_17 = var_266_16:GetComponent("SpriteRenderer")

				if var_266_17 and var_266_17.sprite then
					local var_266_18 = (var_266_16.transform.localPosition - var_266_14).z
					local var_266_19 = manager.ui.mainCameraCom_
					local var_266_20 = 2 * var_266_18 * Mathf.Tan(var_266_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_266_21 = var_266_20 * var_266_19.aspect
					local var_266_22 = var_266_17.sprite.bounds.size.x
					local var_266_23 = var_266_17.sprite.bounds.size.y
					local var_266_24 = var_266_21 / var_266_22
					local var_266_25 = var_266_20 / var_266_23
					local var_266_26 = var_266_25 < var_266_24 and var_266_24 or var_266_25

					var_266_16.transform.localScale = Vector3.New(var_266_26, var_266_26, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "STblack" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_27 = 0.133333333333333
			local var_266_28 = 1

			if var_266_27 < arg_263_1.time_ and arg_263_1.time_ <= var_266_27 + arg_266_0 then
				local var_266_29 = "play"
				local var_266_30 = "effect"

				arg_263_1:AudioAction(var_266_29, var_266_30, "se_story_122_03", "se_story_122_03_impale", "")
			end

			local var_266_31 = 0.266666666666667
			local var_266_32 = 1

			if var_266_31 < arg_263_1.time_ and arg_263_1.time_ <= var_266_31 + arg_266_0 then
				local var_266_33 = "play"
				local var_266_34 = "effect"

				arg_263_1:AudioAction(var_266_33, var_266_34, "se_story_1311", "se_story_1311_blood", "")
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419174,
				charCount = 4,
				enableLayoutChange = true,
				duration = 0.266666666666667,
				groupID = "2064",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425122064,
				charCount = 18,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "20641",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play425122065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 425122065
		arg_267_1.duration_ = 2.67

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play425122066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			return
		end

		arg_267_1.nodeConfigList_ = {
			{
				groupID = "20641",
				duration = 1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425122065,
				charCount = 40,
				enableLayoutChange = true,
				duration = 2.66666666666667,
				groupID = "2065",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play425122066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425122066
		arg_271_1.duration_ = 2.67

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play425122067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1.566
			local var_274_2 = manager.audio:GetVoiceLength("story_v_out_425122", "425122066", "story_v_out_425121.awb") / 1000

			if var_274_2 > 0 and var_274_1 < var_274_2 and var_274_2 + var_274_0 > arg_271_1.duration_ then
				local var_274_3 = var_274_2

				arg_271_1.duration_ = var_274_2 + var_274_0
			end

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				local var_274_4 = "play"
				local var_274_5 = "voice"

				arg_271_1:AudioAction(var_274_4, var_274_5, "story_v_out_425122", "425122066", "story_v_out_425121.awb")
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				groupID = "2065",
				duration = 2.66666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425122066,
				charCount = 4,
				enableLayoutChange = true,
				duration = 0.266666666666667,
				groupID = "2066",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play425122067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425122067
		arg_275_1.duration_ = 7

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play425122068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_1 = 1

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_1 then
				local var_278_2 = (arg_275_1.time_ - var_278_0) / var_278_1
				local var_278_3 = Color.New(0, 0, 0)

				var_278_3.a = Mathf.Lerp(0, 1, var_278_2)
				arg_275_1.mask_.color = var_278_3
			end

			if arg_275_1.time_ >= var_278_0 + var_278_1 and arg_275_1.time_ < var_278_0 + var_278_1 + arg_278_0 then
				local var_278_4 = Color.New(0, 0, 0)

				var_278_4.a = 1
				arg_275_1.mask_.color = var_278_4
			end

			local var_278_5 = 1

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_6 = 1

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_6 then
				local var_278_7 = (arg_275_1.time_ - var_278_5) / var_278_6
				local var_278_8 = Color.New(0, 0, 0)

				var_278_8.a = Mathf.Lerp(1, 0, var_278_7)
				arg_275_1.mask_.color = var_278_8
			end

			if arg_275_1.time_ >= var_278_5 + var_278_6 and arg_275_1.time_ < var_278_5 + var_278_6 + arg_278_0 then
				local var_278_9 = Color.New(0, 0, 0)
				local var_278_10 = 0

				arg_275_1.mask_.enabled = false
				var_278_9.a = var_278_10
				arg_275_1.mask_.color = var_278_9
			end

			local var_278_11 = 1

			if var_278_11 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				local var_278_12 = manager.ui.mainCamera.transform.localPosition
				local var_278_13 = Vector3.New(0, 0, 10) + Vector3.New(var_278_12.x, var_278_12.y, 0)
				local var_278_14 = arg_275_1.bgs_.M01g

				var_278_14.transform.localPosition = var_278_13
				var_278_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_15 = var_278_14:GetComponent("SpriteRenderer")

				if var_278_15 and var_278_15.sprite then
					local var_278_16 = (var_278_14.transform.localPosition - var_278_12).z
					local var_278_17 = manager.ui.mainCameraCom_
					local var_278_18 = 2 * var_278_16 * Mathf.Tan(var_278_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_278_19 = var_278_18 * var_278_17.aspect
					local var_278_20 = var_278_15.sprite.bounds.size.x
					local var_278_21 = var_278_15.sprite.bounds.size.y
					local var_278_22 = var_278_19 / var_278_20
					local var_278_23 = var_278_18 / var_278_21
					local var_278_24 = var_278_23 < var_278_22 and var_278_22 or var_278_23

					var_278_14.transform.localScale = Vector3.New(var_278_24, var_278_24, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "M01g" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_25 = 2
			local var_278_26 = 1.45

			if var_278_25 < arg_275_1.time_ and arg_275_1.time_ <= var_278_25 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_27 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_27:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_28 = arg_275_1:GetWordFromCfg(425122067)
				local var_278_29 = arg_275_1:FormatText(var_278_28.content)

				arg_275_1.text_.text = var_278_29

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_30 = 32
				local var_278_31 = utf8.len(var_278_29)
				local var_278_32 = var_278_30 <= 0 and var_278_26 or var_278_26 * (var_278_31 / var_278_30)

				if var_278_32 > 0 and var_278_26 < var_278_32 then
					arg_275_1.talkMaxDuration = var_278_32
					var_278_25 = var_278_25 + 0.3

					if var_278_32 + var_278_25 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_32 + var_278_25
					end
				end

				arg_275_1.text_.text = var_278_29
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_33 = var_278_25 + 0.3
			local var_278_34 = math.max(var_278_26, arg_275_1.talkMaxDuration)

			if var_278_33 <= arg_275_1.time_ and arg_275_1.time_ < var_278_33 + var_278_34 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_33) / var_278_34

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_33 + var_278_34 and arg_275_1.time_ < var_278_33 + var_278_34 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				groupID = "2066",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "2064",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play425122068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 425122068
		arg_281_1.duration_ = 5.63

		local var_281_0 = {
			zh = 4.5,
			ja = 5.633
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play425122069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.45

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[5].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_281_1.callingController_:SetSelectedState("calling")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(425122068)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 11
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122068", "story_v_out_425122.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122068", "story_v_out_425122.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_425122", "425122068", "story_v_out_425122.awb")

						arg_281_1:RecordAudio("425122068", var_284_9)
						arg_281_1:RecordAudio("425122068", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_425122", "425122068", "story_v_out_425122.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_425122", "425122068", "story_v_out_425122.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play425122069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 425122069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play425122070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.233333333333333
			local var_288_1 = 1

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				local var_288_2 = "play"
				local var_288_3 = "effect"

				arg_285_1:AudioAction(var_288_2, var_288_3, "se_story_side_1093", "se_story_side_1093_ropetight", "")
			end

			local var_288_4 = 0
			local var_288_5 = 1.025

			if var_288_4 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(425122069)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 41
				local var_288_9 = utf8.len(var_288_7)
				local var_288_10 = var_288_8 <= 0 and var_288_5 or var_288_5 * (var_288_9 / var_288_8)

				if var_288_10 > 0 and var_288_5 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_11 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_11 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_11

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_11 and arg_285_1.time_ < var_288_4 + var_288_11 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play425122070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 425122070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play425122071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.133333333333333
			local var_292_1 = 1

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				local var_292_2 = "play"
				local var_292_3 = "effect"

				arg_289_1:AudioAction(var_292_2, var_292_3, "se_story_147", "se_story_147_blood", "")
			end

			local var_292_4 = 0
			local var_292_5 = 1.45

			if var_292_4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(425122070)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_8 = 58
				local var_292_9 = utf8.len(var_292_7)
				local var_292_10 = var_292_8 <= 0 and var_292_5 or var_292_5 * (var_292_9 / var_292_8)

				if var_292_10 > 0 and var_292_5 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_11 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_11 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_11

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_11 and arg_289_1.time_ < var_292_4 + var_292_11 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play425122071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 425122071
		arg_293_1.duration_ = 7.77

		local var_293_0 = {
			zh = 4.233,
			ja = 7.766
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play425122072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1036"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1036 == nil then
				arg_293_1.var_.actorSpriteComps1036 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps1036 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1036 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1036 = nil
			end

			local var_296_8 = arg_293_1.actors_["1036"].transform
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.var_.moveOldPos1036 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1036", 2)

				local var_296_10 = var_296_8.childCount

				for iter_296_4 = 0, var_296_10 - 1 do
					local var_296_11 = var_296_8:GetChild(iter_296_4)

					if var_296_11.name == "" or not string.find(var_296_11.name, "split") then
						var_296_11.gameObject:SetActive(true)
					else
						var_296_11.gameObject:SetActive(false)
					end
				end
			end

			local var_296_12 = 0.001

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_12 then
				local var_296_13 = (arg_293_1.time_ - var_296_9) / var_296_12
				local var_296_14 = Vector3.New(-390, -388, -250)

				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1036, var_296_14, var_296_13)
			end

			if arg_293_1.time_ >= var_296_9 + var_296_12 and arg_293_1.time_ < var_296_9 + var_296_12 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_296_15 = 0
			local var_296_16 = 0.525

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[5].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(425122071)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 21
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122071", "story_v_out_425122.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122071", "story_v_out_425122.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_425122", "425122071", "story_v_out_425122.awb")

						arg_293_1:RecordAudio("425122071", var_296_24)
						arg_293_1:RecordAudio("425122071", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_425122", "425122071", "story_v_out_425122.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_425122", "425122071", "story_v_out_425122.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play425122072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 425122072
		arg_297_1.duration_ = 4.73

		local var_297_0 = {
			zh = 3.866,
			ja = 4.733
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play425122073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1137"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1137 == nil then
				arg_297_1.var_.actorSpriteComps1137 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1137 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 1, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1137 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1137 = nil
			end

			local var_300_8 = arg_297_1.actors_["1036"]
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps1036 == nil then
				arg_297_1.var_.actorSpriteComps1036 = var_300_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_10 = 0.2

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 and not isNil(var_300_8) then
				local var_300_11 = (arg_297_1.time_ - var_300_9) / var_300_10

				if arg_297_1.var_.actorSpriteComps1036 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								local var_300_12 = Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor2.r, var_300_11)
								local var_300_13 = Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor2.g, var_300_11)
								local var_300_14 = Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor2.b, var_300_11)

								iter_300_5.color = Color.New(var_300_12, var_300_13, var_300_14)
							else
								local var_300_15 = Mathf.Lerp(iter_300_5.color.r, 0.5, var_300_11)

								iter_300_5.color = Color.New(var_300_15, var_300_15, var_300_15)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps1036 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_300_7 then
						if arg_297_1.isInRecall_ then
							iter_300_7.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1036 = nil
			end

			local var_300_16 = arg_297_1.actors_["1137"].transform
			local var_300_17 = 0

			if var_300_17 < arg_297_1.time_ and arg_297_1.time_ <= var_300_17 + arg_300_0 then
				arg_297_1.var_.moveOldPos1137 = var_300_16.localPosition
				var_300_16.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1137", 4)

				local var_300_18 = var_300_16.childCount

				for iter_300_8 = 0, var_300_18 - 1 do
					local var_300_19 = var_300_16:GetChild(iter_300_8)

					if var_300_19.name == "split_4" or not string.find(var_300_19.name, "split") then
						var_300_19.gameObject:SetActive(true)
					else
						var_300_19.gameObject:SetActive(false)
					end
				end
			end

			local var_300_20 = 0.001

			if var_300_17 <= arg_297_1.time_ and arg_297_1.time_ < var_300_17 + var_300_20 then
				local var_300_21 = (arg_297_1.time_ - var_300_17) / var_300_20
				local var_300_22 = Vector3.New(390, -425, -200)

				var_300_16.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1137, var_300_22, var_300_21)
			end

			if arg_297_1.time_ >= var_300_17 + var_300_20 and arg_297_1.time_ < var_300_17 + var_300_20 + arg_300_0 then
				var_300_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_300_23 = 0
			local var_300_24 = 0.525

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[15].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_26 = arg_297_1:GetWordFromCfg(425122072)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 21
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_24 or var_300_24 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_24 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30

					if var_300_30 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122072", "story_v_out_425122.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122072", "story_v_out_425122.awb") / 1000

					if var_300_31 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_23
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_425122", "425122072", "story_v_out_425122.awb")

						arg_297_1:RecordAudio("425122072", var_300_32)
						arg_297_1:RecordAudio("425122072", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_425122", "425122072", "story_v_out_425122.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_425122", "425122072", "story_v_out_425122.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_33 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_33

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_33 and arg_297_1.time_ < var_300_23 + var_300_33 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play425122073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 425122073
		arg_301_1.duration_ = 4.97

		local var_301_0 = {
			zh = 2.666,
			ja = 4.966
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play425122074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1036"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1036 == nil then
				arg_301_1.var_.actorSpriteComps1036 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1036 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor1.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor1.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor1.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 1, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1036 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1036 = nil
			end

			local var_304_8 = arg_301_1.actors_["1137"]
			local var_304_9 = 0

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps1137 == nil then
				arg_301_1.var_.actorSpriteComps1137 = var_304_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_10 = 0.2

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_10 and not isNil(var_304_8) then
				local var_304_11 = (arg_301_1.time_ - var_304_9) / var_304_10

				if arg_301_1.var_.actorSpriteComps1137 then
					for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_304_5 then
							if arg_301_1.isInRecall_ then
								local var_304_12 = Mathf.Lerp(iter_304_5.color.r, arg_301_1.hightColor2.r, var_304_11)
								local var_304_13 = Mathf.Lerp(iter_304_5.color.g, arg_301_1.hightColor2.g, var_304_11)
								local var_304_14 = Mathf.Lerp(iter_304_5.color.b, arg_301_1.hightColor2.b, var_304_11)

								iter_304_5.color = Color.New(var_304_12, var_304_13, var_304_14)
							else
								local var_304_15 = Mathf.Lerp(iter_304_5.color.r, 0.5, var_304_11)

								iter_304_5.color = Color.New(var_304_15, var_304_15, var_304_15)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_9 + var_304_10 and arg_301_1.time_ < var_304_9 + var_304_10 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps1137 then
				for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_304_7 then
						if arg_301_1.isInRecall_ then
							iter_304_7.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1137 = nil
			end

			local var_304_16 = arg_301_1.actors_["1036"].transform
			local var_304_17 = 0

			if var_304_17 < arg_301_1.time_ and arg_301_1.time_ <= var_304_17 + arg_304_0 then
				arg_301_1.var_.moveOldPos1036 = var_304_16.localPosition
				var_304_16.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1036", 2)

				local var_304_18 = var_304_16.childCount

				for iter_304_8 = 0, var_304_18 - 1 do
					local var_304_19 = var_304_16:GetChild(iter_304_8)

					if var_304_19.name == "" or not string.find(var_304_19.name, "split") then
						var_304_19.gameObject:SetActive(true)
					else
						var_304_19.gameObject:SetActive(false)
					end
				end
			end

			local var_304_20 = 0.001

			if var_304_17 <= arg_301_1.time_ and arg_301_1.time_ < var_304_17 + var_304_20 then
				local var_304_21 = (arg_301_1.time_ - var_304_17) / var_304_20
				local var_304_22 = Vector3.New(-390, -388, -250)

				var_304_16.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1036, var_304_22, var_304_21)
			end

			if arg_301_1.time_ >= var_304_17 + var_304_20 and arg_301_1.time_ < var_304_17 + var_304_20 + arg_304_0 then
				var_304_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_304_23 = 0
			local var_304_24 = 0.375

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[5].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(425122073)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 15
				local var_304_29 = utf8.len(var_304_27)
				local var_304_30 = var_304_28 <= 0 and var_304_24 or var_304_24 * (var_304_29 / var_304_28)

				if var_304_30 > 0 and var_304_24 < var_304_30 then
					arg_301_1.talkMaxDuration = var_304_30

					if var_304_30 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_30 + var_304_23
					end
				end

				arg_301_1.text_.text = var_304_27
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122073", "story_v_out_425122.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122073", "story_v_out_425122.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_425122", "425122073", "story_v_out_425122.awb")

						arg_301_1:RecordAudio("425122073", var_304_32)
						arg_301_1:RecordAudio("425122073", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_425122", "425122073", "story_v_out_425122.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_425122", "425122073", "story_v_out_425122.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_33 = math.max(var_304_24, arg_301_1.talkMaxDuration)

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_33 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_23) / var_304_33

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_23 + var_304_33 and arg_301_1.time_ < var_304_23 + var_304_33 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play425122074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 425122074
		arg_305_1.duration_ = 3

		local var_305_0 = {
			zh = 2.266,
			ja = 3
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play425122075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1036"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1036 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1036", 2)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(-390, -388, -250)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1036, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_308_7 = 0.133333333333333
			local var_308_8 = 1

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				local var_308_9 = "play"
				local var_308_10 = "effect"

				arg_305_1:AudioAction(var_308_9, var_308_10, "se_story_145", "se_story_145_gold", "")
			end

			local var_308_11 = 0
			local var_308_12 = 0.3

			if var_308_11 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_13 = arg_305_1:FormatText(StoryNameCfg[5].name)

				arg_305_1.leftNameTxt_.text = var_308_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_14 = arg_305_1:GetWordFromCfg(425122074)
				local var_308_15 = arg_305_1:FormatText(var_308_14.content)

				arg_305_1.text_.text = var_308_15

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_16 = 12
				local var_308_17 = utf8.len(var_308_15)
				local var_308_18 = var_308_16 <= 0 and var_308_12 or var_308_12 * (var_308_17 / var_308_16)

				if var_308_18 > 0 and var_308_12 < var_308_18 then
					arg_305_1.talkMaxDuration = var_308_18

					if var_308_18 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_18 + var_308_11
					end
				end

				arg_305_1.text_.text = var_308_15
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122074", "story_v_out_425122.awb") ~= 0 then
					local var_308_19 = manager.audio:GetVoiceLength("story_v_out_425122", "425122074", "story_v_out_425122.awb") / 1000

					if var_308_19 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_11
					end

					if var_308_14.prefab_name ~= "" and arg_305_1.actors_[var_308_14.prefab_name] ~= nil then
						local var_308_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_14.prefab_name].transform, "story_v_out_425122", "425122074", "story_v_out_425122.awb")

						arg_305_1:RecordAudio("425122074", var_308_20)
						arg_305_1:RecordAudio("425122074", var_308_20)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_425122", "425122074", "story_v_out_425122.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_425122", "425122074", "story_v_out_425122.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_21 = math.max(var_308_12, arg_305_1.talkMaxDuration)

			if var_308_11 <= arg_305_1.time_ and arg_305_1.time_ < var_308_11 + var_308_21 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_11) / var_308_21

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_11 + var_308_21 and arg_305_1.time_ < var_308_11 + var_308_21 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play425122075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 425122075
		arg_309_1.duration_ = 6.6

		local var_309_0 = {
			zh = 4.533,
			ja = 6.6
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play425122076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1137"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1137 == nil then
				arg_309_1.var_.actorSpriteComps1137 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps1137 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								local var_312_4 = Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, var_312_3)
								local var_312_5 = Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, var_312_3)
								local var_312_6 = Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, var_312_3)

								iter_312_1.color = Color.New(var_312_4, var_312_5, var_312_6)
							else
								local var_312_7 = Mathf.Lerp(iter_312_1.color.r, 1, var_312_3)

								iter_312_1.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1137 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_312_3 then
						if arg_309_1.isInRecall_ then
							iter_312_3.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1137 = nil
			end

			local var_312_8 = arg_309_1.actors_["1036"]
			local var_312_9 = 0

			if var_312_9 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps1036 == nil then
				arg_309_1.var_.actorSpriteComps1036 = var_312_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_10 = 0.2

			if var_312_9 <= arg_309_1.time_ and arg_309_1.time_ < var_312_9 + var_312_10 and not isNil(var_312_8) then
				local var_312_11 = (arg_309_1.time_ - var_312_9) / var_312_10

				if arg_309_1.var_.actorSpriteComps1036 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								local var_312_12 = Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, var_312_11)
								local var_312_13 = Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, var_312_11)
								local var_312_14 = Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, var_312_11)

								iter_312_5.color = Color.New(var_312_12, var_312_13, var_312_14)
							else
								local var_312_15 = Mathf.Lerp(iter_312_5.color.r, 0.5, var_312_11)

								iter_312_5.color = Color.New(var_312_15, var_312_15, var_312_15)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_9 + var_312_10 and arg_309_1.time_ < var_312_9 + var_312_10 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps1036 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_312_7 then
						if arg_309_1.isInRecall_ then
							iter_312_7.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1036 = nil
			end

			local var_312_16 = arg_309_1.actors_["1137"].transform
			local var_312_17 = 0

			if var_312_17 < arg_309_1.time_ and arg_309_1.time_ <= var_312_17 + arg_312_0 then
				arg_309_1.var_.moveOldPos1137 = var_312_16.localPosition
				var_312_16.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1137", 4)

				local var_312_18 = var_312_16.childCount

				for iter_312_8 = 0, var_312_18 - 1 do
					local var_312_19 = var_312_16:GetChild(iter_312_8)

					if var_312_19.name == "split_4" or not string.find(var_312_19.name, "split") then
						var_312_19.gameObject:SetActive(true)
					else
						var_312_19.gameObject:SetActive(false)
					end
				end
			end

			local var_312_20 = 0.001

			if var_312_17 <= arg_309_1.time_ and arg_309_1.time_ < var_312_17 + var_312_20 then
				local var_312_21 = (arg_309_1.time_ - var_312_17) / var_312_20
				local var_312_22 = Vector3.New(390, -425, -200)

				var_312_16.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1137, var_312_22, var_312_21)
			end

			if arg_309_1.time_ >= var_312_17 + var_312_20 and arg_309_1.time_ < var_312_17 + var_312_20 + arg_312_0 then
				var_312_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_312_23 = 0
			local var_312_24 = 0.35

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_25 = arg_309_1:FormatText(StoryNameCfg[15].name)

				arg_309_1.leftNameTxt_.text = var_312_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_26 = arg_309_1:GetWordFromCfg(425122075)
				local var_312_27 = arg_309_1:FormatText(var_312_26.content)

				arg_309_1.text_.text = var_312_27

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_28 = 14
				local var_312_29 = utf8.len(var_312_27)
				local var_312_30 = var_312_28 <= 0 and var_312_24 or var_312_24 * (var_312_29 / var_312_28)

				if var_312_30 > 0 and var_312_24 < var_312_30 then
					arg_309_1.talkMaxDuration = var_312_30

					if var_312_30 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_30 + var_312_23
					end
				end

				arg_309_1.text_.text = var_312_27
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122075", "story_v_out_425122.awb") ~= 0 then
					local var_312_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122075", "story_v_out_425122.awb") / 1000

					if var_312_31 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_31 + var_312_23
					end

					if var_312_26.prefab_name ~= "" and arg_309_1.actors_[var_312_26.prefab_name] ~= nil then
						local var_312_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_26.prefab_name].transform, "story_v_out_425122", "425122075", "story_v_out_425122.awb")

						arg_309_1:RecordAudio("425122075", var_312_32)
						arg_309_1:RecordAudio("425122075", var_312_32)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_425122", "425122075", "story_v_out_425122.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_425122", "425122075", "story_v_out_425122.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_33 = math.max(var_312_24, arg_309_1.talkMaxDuration)

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_33 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_23) / var_312_33

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_23 + var_312_33 and arg_309_1.time_ < var_312_23 + var_312_33 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play425122076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 425122076
		arg_313_1.duration_ = 9.43

		local var_313_0 = {
			zh = 6.533,
			ja = 9.433
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play425122077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1036"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1036 == nil then
				arg_313_1.var_.actorSpriteComps1036 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps1036 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								local var_316_4 = Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, var_316_3)
								local var_316_5 = Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, var_316_3)
								local var_316_6 = Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, var_316_3)

								iter_316_1.color = Color.New(var_316_4, var_316_5, var_316_6)
							else
								local var_316_7 = Mathf.Lerp(iter_316_1.color.r, 1, var_316_3)

								iter_316_1.color = Color.New(var_316_7, var_316_7, var_316_7)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1036 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1036 = nil
			end

			local var_316_8 = arg_313_1.actors_["1137"]
			local var_316_9 = 0

			if var_316_9 < arg_313_1.time_ and arg_313_1.time_ <= var_316_9 + arg_316_0 and not isNil(var_316_8) and arg_313_1.var_.actorSpriteComps1137 == nil then
				arg_313_1.var_.actorSpriteComps1137 = var_316_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_10 = 0.2

			if var_316_9 <= arg_313_1.time_ and arg_313_1.time_ < var_316_9 + var_316_10 and not isNil(var_316_8) then
				local var_316_11 = (arg_313_1.time_ - var_316_9) / var_316_10

				if arg_313_1.var_.actorSpriteComps1137 then
					for iter_316_4, iter_316_5 in pairs(arg_313_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_316_5 then
							if arg_313_1.isInRecall_ then
								local var_316_12 = Mathf.Lerp(iter_316_5.color.r, arg_313_1.hightColor2.r, var_316_11)
								local var_316_13 = Mathf.Lerp(iter_316_5.color.g, arg_313_1.hightColor2.g, var_316_11)
								local var_316_14 = Mathf.Lerp(iter_316_5.color.b, arg_313_1.hightColor2.b, var_316_11)

								iter_316_5.color = Color.New(var_316_12, var_316_13, var_316_14)
							else
								local var_316_15 = Mathf.Lerp(iter_316_5.color.r, 0.5, var_316_11)

								iter_316_5.color = Color.New(var_316_15, var_316_15, var_316_15)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_9 + var_316_10 and arg_313_1.time_ < var_316_9 + var_316_10 + arg_316_0 and not isNil(var_316_8) and arg_313_1.var_.actorSpriteComps1137 then
				for iter_316_6, iter_316_7 in pairs(arg_313_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_316_7 then
						if arg_313_1.isInRecall_ then
							iter_316_7.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1137 = nil
			end

			local var_316_16 = arg_313_1.actors_["1036"].transform
			local var_316_17 = 0

			if var_316_17 < arg_313_1.time_ and arg_313_1.time_ <= var_316_17 + arg_316_0 then
				arg_313_1.var_.moveOldPos1036 = var_316_16.localPosition
				var_316_16.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1036", 2)

				local var_316_18 = var_316_16.childCount

				for iter_316_8 = 0, var_316_18 - 1 do
					local var_316_19 = var_316_16:GetChild(iter_316_8)

					if var_316_19.name == "" or not string.find(var_316_19.name, "split") then
						var_316_19.gameObject:SetActive(true)
					else
						var_316_19.gameObject:SetActive(false)
					end
				end
			end

			local var_316_20 = 0.001

			if var_316_17 <= arg_313_1.time_ and arg_313_1.time_ < var_316_17 + var_316_20 then
				local var_316_21 = (arg_313_1.time_ - var_316_17) / var_316_20
				local var_316_22 = Vector3.New(-390, -388, -250)

				var_316_16.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1036, var_316_22, var_316_21)
			end

			if arg_313_1.time_ >= var_316_17 + var_316_20 and arg_313_1.time_ < var_316_17 + var_316_20 + arg_316_0 then
				var_316_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_316_23 = 0
			local var_316_24 = 0.7

			if var_316_23 < arg_313_1.time_ and arg_313_1.time_ <= var_316_23 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_25 = arg_313_1:FormatText(StoryNameCfg[5].name)

				arg_313_1.leftNameTxt_.text = var_316_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_26 = arg_313_1:GetWordFromCfg(425122076)
				local var_316_27 = arg_313_1:FormatText(var_316_26.content)

				arg_313_1.text_.text = var_316_27

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_28 = 28
				local var_316_29 = utf8.len(var_316_27)
				local var_316_30 = var_316_28 <= 0 and var_316_24 or var_316_24 * (var_316_29 / var_316_28)

				if var_316_30 > 0 and var_316_24 < var_316_30 then
					arg_313_1.talkMaxDuration = var_316_30

					if var_316_30 + var_316_23 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_30 + var_316_23
					end
				end

				arg_313_1.text_.text = var_316_27
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122076", "story_v_out_425122.awb") ~= 0 then
					local var_316_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122076", "story_v_out_425122.awb") / 1000

					if var_316_31 + var_316_23 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_31 + var_316_23
					end

					if var_316_26.prefab_name ~= "" and arg_313_1.actors_[var_316_26.prefab_name] ~= nil then
						local var_316_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_26.prefab_name].transform, "story_v_out_425122", "425122076", "story_v_out_425122.awb")

						arg_313_1:RecordAudio("425122076", var_316_32)
						arg_313_1:RecordAudio("425122076", var_316_32)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_425122", "425122076", "story_v_out_425122.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_425122", "425122076", "story_v_out_425122.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_33 = math.max(var_316_24, arg_313_1.talkMaxDuration)

			if var_316_23 <= arg_313_1.time_ and arg_313_1.time_ < var_316_23 + var_316_33 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_23) / var_316_33

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_23 + var_316_33 and arg_313_1.time_ < var_316_23 + var_316_33 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play425122077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 425122077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play425122078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1036"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1036 == nil then
				arg_317_1.var_.actorSpriteComps1036 = var_320_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.actorSpriteComps1036 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								local var_320_4 = Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor2.r, var_320_3)
								local var_320_5 = Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor2.g, var_320_3)
								local var_320_6 = Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor2.b, var_320_3)

								iter_320_1.color = Color.New(var_320_4, var_320_5, var_320_6)
							else
								local var_320_7 = Mathf.Lerp(iter_320_1.color.r, 0.5, var_320_3)

								iter_320_1.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1036 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_320_3 then
						if arg_317_1.isInRecall_ then
							iter_320_3.color = arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_320_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1036 = nil
			end

			local var_320_8 = arg_317_1.actors_["1036"].transform
			local var_320_9 = 0

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.var_.moveOldPos1036 = var_320_8.localPosition
				var_320_8.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1036", 7)

				local var_320_10 = var_320_8.childCount

				for iter_320_4 = 0, var_320_10 - 1 do
					local var_320_11 = var_320_8:GetChild(iter_320_4)

					if var_320_11.name == "" or not string.find(var_320_11.name, "split") then
						var_320_11.gameObject:SetActive(true)
					else
						var_320_11.gameObject:SetActive(false)
					end
				end
			end

			local var_320_12 = 0.001

			if var_320_9 <= arg_317_1.time_ and arg_317_1.time_ < var_320_9 + var_320_12 then
				local var_320_13 = (arg_317_1.time_ - var_320_9) / var_320_12
				local var_320_14 = Vector3.New(0, -2000, 0)

				var_320_8.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1036, var_320_14, var_320_13)
			end

			if arg_317_1.time_ >= var_320_9 + var_320_12 and arg_317_1.time_ < var_320_9 + var_320_12 + arg_320_0 then
				var_320_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_15 = arg_317_1.actors_["1137"].transform
			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1.var_.moveOldPos1137 = var_320_15.localPosition
				var_320_15.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1137", 7)

				local var_320_17 = var_320_15.childCount

				for iter_320_5 = 0, var_320_17 - 1 do
					local var_320_18 = var_320_15:GetChild(iter_320_5)

					if var_320_18.name == "" or not string.find(var_320_18.name, "split") then
						var_320_18.gameObject:SetActive(true)
					else
						var_320_18.gameObject:SetActive(false)
					end
				end
			end

			local var_320_19 = 0.001

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_19 then
				local var_320_20 = (arg_317_1.time_ - var_320_16) / var_320_19
				local var_320_21 = Vector3.New(0, -2000, 0)

				var_320_15.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1137, var_320_21, var_320_20)
			end

			if arg_317_1.time_ >= var_320_16 + var_320_19 and arg_317_1.time_ < var_320_16 + var_320_19 + arg_320_0 then
				var_320_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_22 = 0
			local var_320_23 = 1.275

			if var_320_22 < arg_317_1.time_ and arg_317_1.time_ <= var_320_22 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(425122077)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 51
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_23 or var_320_23 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_23 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_22 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_22
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_29 = math.max(var_320_23, arg_317_1.talkMaxDuration)

			if var_320_22 <= arg_317_1.time_ and arg_317_1.time_ < var_320_22 + var_320_29 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_22) / var_320_29

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_22 + var_320_29 and arg_317_1.time_ < var_320_22 + var_320_29 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_317_1:InitPlayNodeList()
	end,
	Play425122078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 425122078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play425122079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.533333333333333
			local var_324_1 = 1

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				local var_324_2 = "play"
				local var_324_3 = "effect"

				arg_321_1:AudioAction(var_324_2, var_324_3, "se_story_side_1093", "se_story_side_1093_ropetight", "")
			end

			local var_324_4 = 0
			local var_324_5 = 1.075

			if var_324_4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(425122078)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_8 = 43
				local var_324_9 = utf8.len(var_324_7)
				local var_324_10 = var_324_8 <= 0 and var_324_5 or var_324_5 * (var_324_9 / var_324_8)

				if var_324_10 > 0 and var_324_5 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_11 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_11 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_11

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_11 and arg_321_1.time_ < var_324_4 + var_324_11 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play425122079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 425122079
		arg_325_1.duration_ = 1.3

		local var_325_0 = {
			zh = 1.3,
			ja = 1.166
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play425122080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1036"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1036 == nil then
				arg_325_1.var_.actorSpriteComps1036 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps1036 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								local var_328_4 = Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, var_328_3)
								local var_328_5 = Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, var_328_3)
								local var_328_6 = Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, var_328_3)

								iter_328_1.color = Color.New(var_328_4, var_328_5, var_328_6)
							else
								local var_328_7 = Mathf.Lerp(iter_328_1.color.r, 1, var_328_3)

								iter_328_1.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1036 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps1036 = nil
			end

			local var_328_8 = arg_325_1.actors_["1036"].transform
			local var_328_9 = 0

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.var_.moveOldPos1036 = var_328_8.localPosition
				var_328_8.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1036", 2)

				local var_328_10 = var_328_8.childCount

				for iter_328_4 = 0, var_328_10 - 1 do
					local var_328_11 = var_328_8:GetChild(iter_328_4)

					if var_328_11.name == "" or not string.find(var_328_11.name, "split") then
						var_328_11.gameObject:SetActive(true)
					else
						var_328_11.gameObject:SetActive(false)
					end
				end
			end

			local var_328_12 = 0.001

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_12 then
				local var_328_13 = (arg_325_1.time_ - var_328_9) / var_328_12
				local var_328_14 = Vector3.New(-390, -388, -250)

				var_328_8.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1036, var_328_14, var_328_13)
			end

			if arg_325_1.time_ >= var_328_9 + var_328_12 and arg_325_1.time_ < var_328_9 + var_328_12 + arg_328_0 then
				var_328_8.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_328_15 = 0
			local var_328_16 = 0.1

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_17 = arg_325_1:FormatText(StoryNameCfg[5].name)

				arg_325_1.leftNameTxt_.text = var_328_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_18 = arg_325_1:GetWordFromCfg(425122079)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 4
				local var_328_21 = utf8.len(var_328_19)
				local var_328_22 = var_328_20 <= 0 and var_328_16 or var_328_16 * (var_328_21 / var_328_20)

				if var_328_22 > 0 and var_328_16 < var_328_22 then
					arg_325_1.talkMaxDuration = var_328_22

					if var_328_22 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_15
					end
				end

				arg_325_1.text_.text = var_328_19
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122079", "story_v_out_425122.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122079", "story_v_out_425122.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_out_425122", "425122079", "story_v_out_425122.awb")

						arg_325_1:RecordAudio("425122079", var_328_24)
						arg_325_1:RecordAudio("425122079", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_425122", "425122079", "story_v_out_425122.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_425122", "425122079", "story_v_out_425122.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = math.max(var_328_16, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_25 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_25

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_25 and arg_325_1.time_ < var_328_15 + var_328_25 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play425122080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 425122080
		arg_329_1.duration_ = 1.47

		local var_329_0 = {
			zh = 0.999999999999,
			ja = 1.466
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play425122081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1137"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1137 == nil then
				arg_329_1.var_.actorSpriteComps1137 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1137 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								local var_332_4 = Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, var_332_3)
								local var_332_5 = Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, var_332_3)
								local var_332_6 = Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, var_332_3)

								iter_332_1.color = Color.New(var_332_4, var_332_5, var_332_6)
							else
								local var_332_7 = Mathf.Lerp(iter_332_1.color.r, 1, var_332_3)

								iter_332_1.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1137 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1137 = nil
			end

			local var_332_8 = arg_329_1.actors_["1036"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps1036 == nil then
				arg_329_1.var_.actorSpriteComps1036 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps1036 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_332_5 then
							if arg_329_1.isInRecall_ then
								local var_332_12 = Mathf.Lerp(iter_332_5.color.r, arg_329_1.hightColor2.r, var_332_11)
								local var_332_13 = Mathf.Lerp(iter_332_5.color.g, arg_329_1.hightColor2.g, var_332_11)
								local var_332_14 = Mathf.Lerp(iter_332_5.color.b, arg_329_1.hightColor2.b, var_332_11)

								iter_332_5.color = Color.New(var_332_12, var_332_13, var_332_14)
							else
								local var_332_15 = Mathf.Lerp(iter_332_5.color.r, 0.5, var_332_11)

								iter_332_5.color = Color.New(var_332_15, var_332_15, var_332_15)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps1036 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1036 = nil
			end

			local var_332_16 = arg_329_1.actors_["1137"].transform
			local var_332_17 = 0

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.var_.moveOldPos1137 = var_332_16.localPosition
				var_332_16.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1137", 4)

				local var_332_18 = var_332_16.childCount

				for iter_332_8 = 0, var_332_18 - 1 do
					local var_332_19 = var_332_16:GetChild(iter_332_8)

					if var_332_19.name == "split_5" or not string.find(var_332_19.name, "split") then
						var_332_19.gameObject:SetActive(true)
					else
						var_332_19.gameObject:SetActive(false)
					end
				end
			end

			local var_332_20 = 0.001

			if var_332_17 <= arg_329_1.time_ and arg_329_1.time_ < var_332_17 + var_332_20 then
				local var_332_21 = (arg_329_1.time_ - var_332_17) / var_332_20
				local var_332_22 = Vector3.New(390, -425, -200)

				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1137, var_332_22, var_332_21)
			end

			if arg_329_1.time_ >= var_332_17 + var_332_20 and arg_329_1.time_ < var_332_17 + var_332_20 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_332_23 = 0
			local var_332_24 = 0.075

			if var_332_23 < arg_329_1.time_ and arg_329_1.time_ <= var_332_23 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_25 = arg_329_1:FormatText(StoryNameCfg[15].name)

				arg_329_1.leftNameTxt_.text = var_332_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_26 = arg_329_1:GetWordFromCfg(425122080)
				local var_332_27 = arg_329_1:FormatText(var_332_26.content)

				arg_329_1.text_.text = var_332_27

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_28 = 3
				local var_332_29 = utf8.len(var_332_27)
				local var_332_30 = var_332_28 <= 0 and var_332_24 or var_332_24 * (var_332_29 / var_332_28)

				if var_332_30 > 0 and var_332_24 < var_332_30 then
					arg_329_1.talkMaxDuration = var_332_30

					if var_332_30 + var_332_23 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_30 + var_332_23
					end
				end

				arg_329_1.text_.text = var_332_27
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122080", "story_v_out_425122.awb") ~= 0 then
					local var_332_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122080", "story_v_out_425122.awb") / 1000

					if var_332_31 + var_332_23 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_31 + var_332_23
					end

					if var_332_26.prefab_name ~= "" and arg_329_1.actors_[var_332_26.prefab_name] ~= nil then
						local var_332_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_26.prefab_name].transform, "story_v_out_425122", "425122080", "story_v_out_425122.awb")

						arg_329_1:RecordAudio("425122080", var_332_32)
						arg_329_1:RecordAudio("425122080", var_332_32)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_425122", "425122080", "story_v_out_425122.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_425122", "425122080", "story_v_out_425122.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_33 = math.max(var_332_24, arg_329_1.talkMaxDuration)

			if var_332_23 <= arg_329_1.time_ and arg_329_1.time_ < var_332_23 + var_332_33 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_23) / var_332_33

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_23 + var_332_33 and arg_329_1.time_ < var_332_23 + var_332_33 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play425122081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 425122081
		arg_333_1.duration_ = 2.77

		local var_333_0 = {
			zh = 2.033,
			ja = 2.766
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play425122082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1036"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1036 == nil then
				arg_333_1.var_.actorSpriteComps1036 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1036 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 1, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1036 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1036 = nil
			end

			local var_336_8 = arg_333_1.actors_["1137"]
			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps1137 == nil then
				arg_333_1.var_.actorSpriteComps1137 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_10 = 0.2

			if var_336_9 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 and not isNil(var_336_8) then
				local var_336_11 = (arg_333_1.time_ - var_336_9) / var_336_10

				if arg_333_1.var_.actorSpriteComps1137 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								local var_336_12 = Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor2.r, var_336_11)
								local var_336_13 = Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor2.g, var_336_11)
								local var_336_14 = Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor2.b, var_336_11)

								iter_336_5.color = Color.New(var_336_12, var_336_13, var_336_14)
							else
								local var_336_15 = Mathf.Lerp(iter_336_5.color.r, 0.5, var_336_11)

								iter_336_5.color = Color.New(var_336_15, var_336_15, var_336_15)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps1137 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_336_7 then
						if arg_333_1.isInRecall_ then
							iter_336_7.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1137 = nil
			end

			local var_336_16 = arg_333_1.actors_["1036"].transform
			local var_336_17 = 0

			if var_336_17 < arg_333_1.time_ and arg_333_1.time_ <= var_336_17 + arg_336_0 then
				arg_333_1.var_.moveOldPos1036 = var_336_16.localPosition
				var_336_16.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1036", 2)

				local var_336_18 = var_336_16.childCount

				for iter_336_8 = 0, var_336_18 - 1 do
					local var_336_19 = var_336_16:GetChild(iter_336_8)

					if var_336_19.name == "" or not string.find(var_336_19.name, "split") then
						var_336_19.gameObject:SetActive(true)
					else
						var_336_19.gameObject:SetActive(false)
					end
				end
			end

			local var_336_20 = 0.001

			if var_336_17 <= arg_333_1.time_ and arg_333_1.time_ < var_336_17 + var_336_20 then
				local var_336_21 = (arg_333_1.time_ - var_336_17) / var_336_20
				local var_336_22 = Vector3.New(-390, -388, -250)

				var_336_16.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1036, var_336_22, var_336_21)
			end

			if arg_333_1.time_ >= var_336_17 + var_336_20 and arg_333_1.time_ < var_336_17 + var_336_20 + arg_336_0 then
				var_336_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_336_23 = 0
			local var_336_24 = 0.2

			if var_336_23 < arg_333_1.time_ and arg_333_1.time_ <= var_336_23 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_25 = arg_333_1:FormatText(StoryNameCfg[5].name)

				arg_333_1.leftNameTxt_.text = var_336_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_26 = arg_333_1:GetWordFromCfg(425122081)
				local var_336_27 = arg_333_1:FormatText(var_336_26.content)

				arg_333_1.text_.text = var_336_27

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_28 = 8
				local var_336_29 = utf8.len(var_336_27)
				local var_336_30 = var_336_28 <= 0 and var_336_24 or var_336_24 * (var_336_29 / var_336_28)

				if var_336_30 > 0 and var_336_24 < var_336_30 then
					arg_333_1.talkMaxDuration = var_336_30

					if var_336_30 + var_336_23 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_30 + var_336_23
					end
				end

				arg_333_1.text_.text = var_336_27
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122081", "story_v_out_425122.awb") ~= 0 then
					local var_336_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122081", "story_v_out_425122.awb") / 1000

					if var_336_31 + var_336_23 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_31 + var_336_23
					end

					if var_336_26.prefab_name ~= "" and arg_333_1.actors_[var_336_26.prefab_name] ~= nil then
						local var_336_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_26.prefab_name].transform, "story_v_out_425122", "425122081", "story_v_out_425122.awb")

						arg_333_1:RecordAudio("425122081", var_336_32)
						arg_333_1:RecordAudio("425122081", var_336_32)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_425122", "425122081", "story_v_out_425122.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_425122", "425122081", "story_v_out_425122.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_33 = math.max(var_336_24, arg_333_1.talkMaxDuration)

			if var_336_23 <= arg_333_1.time_ and arg_333_1.time_ < var_336_23 + var_336_33 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_23) / var_336_33

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_23 + var_336_33 and arg_333_1.time_ < var_336_23 + var_336_33 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play425122082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 425122082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play425122083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1036"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1036 == nil then
				arg_337_1.var_.actorSpriteComps1036 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps1036 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_4 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, var_340_3)
								local var_340_5 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, var_340_3)
								local var_340_6 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, var_340_3)

								iter_340_1.color = Color.New(var_340_4, var_340_5, var_340_6)
							else
								local var_340_7 = Mathf.Lerp(iter_340_1.color.r, 0.5, var_340_3)

								iter_340_1.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1036 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1036 = nil
			end

			local var_340_8 = arg_337_1.actors_["1036"].transform
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1.var_.moveOldPos1036 = var_340_8.localPosition
				var_340_8.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1036", 7)

				local var_340_10 = var_340_8.childCount

				for iter_340_4 = 0, var_340_10 - 1 do
					local var_340_11 = var_340_8:GetChild(iter_340_4)

					if var_340_11.name == "" or not string.find(var_340_11.name, "split") then
						var_340_11.gameObject:SetActive(true)
					else
						var_340_11.gameObject:SetActive(false)
					end
				end
			end

			local var_340_12 = 0.001

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_12 then
				local var_340_13 = (arg_337_1.time_ - var_340_9) / var_340_12
				local var_340_14 = Vector3.New(0, -2000, 0)

				var_340_8.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1036, var_340_14, var_340_13)
			end

			if arg_337_1.time_ >= var_340_9 + var_340_12 and arg_337_1.time_ < var_340_9 + var_340_12 + arg_340_0 then
				var_340_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_340_15 = arg_337_1.actors_["1137"].transform
			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1.var_.moveOldPos1137 = var_340_15.localPosition
				var_340_15.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1137", 7)

				local var_340_17 = var_340_15.childCount

				for iter_340_5 = 0, var_340_17 - 1 do
					local var_340_18 = var_340_15:GetChild(iter_340_5)

					if var_340_18.name == "" or not string.find(var_340_18.name, "split") then
						var_340_18.gameObject:SetActive(true)
					else
						var_340_18.gameObject:SetActive(false)
					end
				end
			end

			local var_340_19 = 0.001

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_19 then
				local var_340_20 = (arg_337_1.time_ - var_340_16) / var_340_19
				local var_340_21 = Vector3.New(0, -2000, 0)

				var_340_15.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1137, var_340_21, var_340_20)
			end

			if arg_337_1.time_ >= var_340_16 + var_340_19 and arg_337_1.time_ < var_340_16 + var_340_19 + arg_340_0 then
				var_340_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_340_22 = 0.333333333333333
			local var_340_23 = 1

			if var_340_22 < arg_337_1.time_ and arg_337_1.time_ <= var_340_22 + arg_340_0 then
				local var_340_24 = "play"
				local var_340_25 = "effect"

				arg_337_1:AudioAction(var_340_24, var_340_25, "se_story_9", "se_story_9_monster03", "")
			end

			local var_340_26 = 0
			local var_340_27 = 1.225

			if var_340_26 < arg_337_1.time_ and arg_337_1.time_ <= var_340_26 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_28 = arg_337_1:GetWordFromCfg(425122082)
				local var_340_29 = arg_337_1:FormatText(var_340_28.content)

				arg_337_1.text_.text = var_340_29

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_30 = 49
				local var_340_31 = utf8.len(var_340_29)
				local var_340_32 = var_340_30 <= 0 and var_340_27 or var_340_27 * (var_340_31 / var_340_30)

				if var_340_32 > 0 and var_340_27 < var_340_32 then
					arg_337_1.talkMaxDuration = var_340_32

					if var_340_32 + var_340_26 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_32 + var_340_26
					end
				end

				arg_337_1.text_.text = var_340_29
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_33 = math.max(var_340_27, arg_337_1.talkMaxDuration)

			if var_340_26 <= arg_337_1.time_ and arg_337_1.time_ < var_340_26 + var_340_33 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_26) / var_340_33

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_26 + var_340_33 and arg_337_1.time_ < var_340_26 + var_340_33 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_337_1:InitPlayNodeList()
	end,
	Play425122083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 425122083
		arg_341_1.duration_ = 5.9

		local var_341_0 = {
			zh = 4.033,
			ja = 5.9
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play425122084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1137"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps1137 == nil then
				arg_341_1.var_.actorSpriteComps1137 = var_344_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_2 = 0.2

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.actorSpriteComps1137 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								local var_344_4 = Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor1.r, var_344_3)
								local var_344_5 = Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor1.g, var_344_3)
								local var_344_6 = Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor1.b, var_344_3)

								iter_344_1.color = Color.New(var_344_4, var_344_5, var_344_6)
							else
								local var_344_7 = Mathf.Lerp(iter_344_1.color.r, 1, var_344_3)

								iter_344_1.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps1137 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_344_3 then
						if arg_341_1.isInRecall_ then
							iter_344_3.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1137 = nil
			end

			local var_344_8 = arg_341_1.actors_["1137"].transform
			local var_344_9 = 0

			if var_344_9 < arg_341_1.time_ and arg_341_1.time_ <= var_344_9 + arg_344_0 then
				arg_341_1.var_.moveOldPos1137 = var_344_8.localPosition
				var_344_8.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1137", 3)

				local var_344_10 = var_344_8.childCount

				for iter_344_4 = 0, var_344_10 - 1 do
					local var_344_11 = var_344_8:GetChild(iter_344_4)

					if var_344_11.name == "split_6" or not string.find(var_344_11.name, "split") then
						var_344_11.gameObject:SetActive(true)
					else
						var_344_11.gameObject:SetActive(false)
					end
				end
			end

			local var_344_12 = 0.001

			if var_344_9 <= arg_341_1.time_ and arg_341_1.time_ < var_344_9 + var_344_12 then
				local var_344_13 = (arg_341_1.time_ - var_344_9) / var_344_12
				local var_344_14 = Vector3.New(0, -425, -200)

				var_344_8.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1137, var_344_14, var_344_13)
			end

			if arg_341_1.time_ >= var_344_9 + var_344_12 and arg_341_1.time_ < var_344_9 + var_344_12 + arg_344_0 then
				var_344_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_344_15 = 0
			local var_344_16 = 0.575

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_17 = arg_341_1:FormatText(StoryNameCfg[15].name)

				arg_341_1.leftNameTxt_.text = var_344_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_18 = arg_341_1:GetWordFromCfg(425122083)
				local var_344_19 = arg_341_1:FormatText(var_344_18.content)

				arg_341_1.text_.text = var_344_19

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_20 = 23
				local var_344_21 = utf8.len(var_344_19)
				local var_344_22 = var_344_20 <= 0 and var_344_16 or var_344_16 * (var_344_21 / var_344_20)

				if var_344_22 > 0 and var_344_16 < var_344_22 then
					arg_341_1.talkMaxDuration = var_344_22

					if var_344_22 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_15
					end
				end

				arg_341_1.text_.text = var_344_19
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122083", "story_v_out_425122.awb") ~= 0 then
					local var_344_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122083", "story_v_out_425122.awb") / 1000

					if var_344_23 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_15
					end

					if var_344_18.prefab_name ~= "" and arg_341_1.actors_[var_344_18.prefab_name] ~= nil then
						local var_344_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_18.prefab_name].transform, "story_v_out_425122", "425122083", "story_v_out_425122.awb")

						arg_341_1:RecordAudio("425122083", var_344_24)
						arg_341_1:RecordAudio("425122083", var_344_24)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_425122", "425122083", "story_v_out_425122.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_425122", "425122083", "story_v_out_425122.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_25 = math.max(var_344_16, arg_341_1.talkMaxDuration)

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_15) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_15 + var_344_25 and arg_341_1.time_ < var_344_15 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play425122084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 425122084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play425122085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1137"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps1137 == nil then
				arg_345_1.var_.actorSpriteComps1137 = var_348_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.actorSpriteComps1137 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								local var_348_4 = Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor2.r, var_348_3)
								local var_348_5 = Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor2.g, var_348_3)
								local var_348_6 = Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor2.b, var_348_3)

								iter_348_1.color = Color.New(var_348_4, var_348_5, var_348_6)
							else
								local var_348_7 = Mathf.Lerp(iter_348_1.color.r, 0.5, var_348_3)

								iter_348_1.color = Color.New(var_348_7, var_348_7, var_348_7)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps1137 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_348_3 then
						if arg_345_1.isInRecall_ then
							iter_348_3.color = arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_348_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps1137 = nil
			end

			local var_348_8 = arg_345_1.actors_["1137"].transform
			local var_348_9 = 0

			if var_348_9 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 then
				arg_345_1.var_.moveOldPos1137 = var_348_8.localPosition
				var_348_8.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1137", 7)

				local var_348_10 = var_348_8.childCount

				for iter_348_4 = 0, var_348_10 - 1 do
					local var_348_11 = var_348_8:GetChild(iter_348_4)

					if var_348_11.name == "" or not string.find(var_348_11.name, "split") then
						var_348_11.gameObject:SetActive(true)
					else
						var_348_11.gameObject:SetActive(false)
					end
				end
			end

			local var_348_12 = 0.001

			if var_348_9 <= arg_345_1.time_ and arg_345_1.time_ < var_348_9 + var_348_12 then
				local var_348_13 = (arg_345_1.time_ - var_348_9) / var_348_12
				local var_348_14 = Vector3.New(0, -2000, 0)

				var_348_8.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1137, var_348_14, var_348_13)
			end

			if arg_345_1.time_ >= var_348_9 + var_348_12 and arg_345_1.time_ < var_348_9 + var_348_12 + arg_348_0 then
				var_348_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_348_15 = 0.133333333333333
			local var_348_16 = 1

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				local var_348_17 = "play"
				local var_348_18 = "effect"

				arg_345_1:AudioAction(var_348_17, var_348_18, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_348_19 = 0
			local var_348_20 = 0.8

			if var_348_19 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_21 = arg_345_1:GetWordFromCfg(425122084)
				local var_348_22 = arg_345_1:FormatText(var_348_21.content)

				arg_345_1.text_.text = var_348_22

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_23 = 32
				local var_348_24 = utf8.len(var_348_22)
				local var_348_25 = var_348_23 <= 0 and var_348_20 or var_348_20 * (var_348_24 / var_348_23)

				if var_348_25 > 0 and var_348_20 < var_348_25 then
					arg_345_1.talkMaxDuration = var_348_25

					if var_348_25 + var_348_19 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_25 + var_348_19
					end
				end

				arg_345_1.text_.text = var_348_22
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_26 = math.max(var_348_20, arg_345_1.talkMaxDuration)

			if var_348_19 <= arg_345_1.time_ and arg_345_1.time_ < var_348_19 + var_348_26 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_19) / var_348_26

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_19 + var_348_26 and arg_345_1.time_ < var_348_19 + var_348_26 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play425122085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 425122085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play425122086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 1.075

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:GetWordFromCfg(425122085)
				local var_352_3 = arg_349_1:FormatText(var_352_2.content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 43
				local var_352_5 = utf8.len(var_352_3)
				local var_352_6 = var_352_4 <= 0 and var_352_1 or var_352_1 * (var_352_5 / var_352_4)

				if var_352_6 > 0 and var_352_1 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_7 and arg_349_1.time_ < var_352_0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play425122086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 425122086
		arg_353_1.duration_ = 2.67

		local var_353_0 = {
			zh = 1.966,
			ja = 2.666
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play425122087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1137"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1137 == nil then
				arg_353_1.var_.actorSpriteComps1137 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps1137 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 1, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1137 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1137 = nil
			end

			local var_356_8 = arg_353_1.actors_["1137"].transform
			local var_356_9 = 0

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				arg_353_1.var_.moveOldPos1137 = var_356_8.localPosition
				var_356_8.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1137", 2)

				local var_356_10 = var_356_8.childCount

				for iter_356_4 = 0, var_356_10 - 1 do
					local var_356_11 = var_356_8:GetChild(iter_356_4)

					if var_356_11.name == "split_6" or not string.find(var_356_11.name, "split") then
						var_356_11.gameObject:SetActive(true)
					else
						var_356_11.gameObject:SetActive(false)
					end
				end
			end

			local var_356_12 = 0.001

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_12 then
				local var_356_13 = (arg_353_1.time_ - var_356_9) / var_356_12
				local var_356_14 = Vector3.New(-390, -425, -200)

				var_356_8.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1137, var_356_14, var_356_13)
			end

			if arg_353_1.time_ >= var_356_9 + var_356_12 and arg_353_1.time_ < var_356_9 + var_356_12 + arg_356_0 then
				var_356_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_356_15 = 0
			local var_356_16 = 0.175

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_17 = arg_353_1:FormatText(StoryNameCfg[15].name)

				arg_353_1.leftNameTxt_.text = var_356_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:GetWordFromCfg(425122086)
				local var_356_19 = arg_353_1:FormatText(var_356_18.content)

				arg_353_1.text_.text = var_356_19

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 7
				local var_356_21 = utf8.len(var_356_19)
				local var_356_22 = var_356_20 <= 0 and var_356_16 or var_356_16 * (var_356_21 / var_356_20)

				if var_356_22 > 0 and var_356_16 < var_356_22 then
					arg_353_1.talkMaxDuration = var_356_22

					if var_356_22 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_22 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_19
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122086", "story_v_out_425122.awb") ~= 0 then
					local var_356_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122086", "story_v_out_425122.awb") / 1000

					if var_356_23 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_15
					end

					if var_356_18.prefab_name ~= "" and arg_353_1.actors_[var_356_18.prefab_name] ~= nil then
						local var_356_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_18.prefab_name].transform, "story_v_out_425122", "425122086", "story_v_out_425122.awb")

						arg_353_1:RecordAudio("425122086", var_356_24)
						arg_353_1:RecordAudio("425122086", var_356_24)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_425122", "425122086", "story_v_out_425122.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_425122", "425122086", "story_v_out_425122.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_25 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_25 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_25

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_25 and arg_353_1.time_ < var_356_15 + var_356_25 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play425122087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 425122087
		arg_357_1.duration_ = 3.33

		local var_357_0 = {
			zh = 2.333,
			ja = 3.333
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play425122088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1036"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1036 == nil then
				arg_357_1.var_.actorSpriteComps1036 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps1036 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1036 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1036 = nil
			end

			local var_360_8 = arg_357_1.actors_["1137"]
			local var_360_9 = 0

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1137 == nil then
				arg_357_1.var_.actorSpriteComps1137 = var_360_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_10 = 0.2

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_10 and not isNil(var_360_8) then
				local var_360_11 = (arg_357_1.time_ - var_360_9) / var_360_10

				if arg_357_1.var_.actorSpriteComps1137 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								local var_360_12 = Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, var_360_11)
								local var_360_13 = Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, var_360_11)
								local var_360_14 = Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, var_360_11)

								iter_360_5.color = Color.New(var_360_12, var_360_13, var_360_14)
							else
								local var_360_15 = Mathf.Lerp(iter_360_5.color.r, 0.5, var_360_11)

								iter_360_5.color = Color.New(var_360_15, var_360_15, var_360_15)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_9 + var_360_10 and arg_357_1.time_ < var_360_9 + var_360_10 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1137 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_360_7 then
						if arg_357_1.isInRecall_ then
							iter_360_7.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1137 = nil
			end

			local var_360_16 = arg_357_1.actors_["1036"].transform
			local var_360_17 = 0

			if var_360_17 < arg_357_1.time_ and arg_357_1.time_ <= var_360_17 + arg_360_0 then
				arg_357_1.var_.moveOldPos1036 = var_360_16.localPosition
				var_360_16.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1036", 4)

				local var_360_18 = var_360_16.childCount

				for iter_360_8 = 0, var_360_18 - 1 do
					local var_360_19 = var_360_16:GetChild(iter_360_8)

					if var_360_19.name == "" or not string.find(var_360_19.name, "split") then
						var_360_19.gameObject:SetActive(true)
					else
						var_360_19.gameObject:SetActive(false)
					end
				end
			end

			local var_360_20 = 0.001

			if var_360_17 <= arg_357_1.time_ and arg_357_1.time_ < var_360_17 + var_360_20 then
				local var_360_21 = (arg_357_1.time_ - var_360_17) / var_360_20
				local var_360_22 = Vector3.New(390, -388, -250)

				var_360_16.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1036, var_360_22, var_360_21)
			end

			if arg_357_1.time_ >= var_360_17 + var_360_20 and arg_357_1.time_ < var_360_17 + var_360_20 + arg_360_0 then
				var_360_16.localPosition = Vector3.New(390, -388, -250)
			end

			local var_360_23 = 0
			local var_360_24 = 0.175

			if var_360_23 < arg_357_1.time_ and arg_357_1.time_ <= var_360_23 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_25 = arg_357_1:FormatText(StoryNameCfg[5].name)

				arg_357_1.leftNameTxt_.text = var_360_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_26 = arg_357_1:GetWordFromCfg(425122087)
				local var_360_27 = arg_357_1:FormatText(var_360_26.content)

				arg_357_1.text_.text = var_360_27

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_28 = 7
				local var_360_29 = utf8.len(var_360_27)
				local var_360_30 = var_360_28 <= 0 and var_360_24 or var_360_24 * (var_360_29 / var_360_28)

				if var_360_30 > 0 and var_360_24 < var_360_30 then
					arg_357_1.talkMaxDuration = var_360_30

					if var_360_30 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_30 + var_360_23
					end
				end

				arg_357_1.text_.text = var_360_27
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122087", "story_v_out_425122.awb") ~= 0 then
					local var_360_31 = manager.audio:GetVoiceLength("story_v_out_425122", "425122087", "story_v_out_425122.awb") / 1000

					if var_360_31 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_31 + var_360_23
					end

					if var_360_26.prefab_name ~= "" and arg_357_1.actors_[var_360_26.prefab_name] ~= nil then
						local var_360_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_26.prefab_name].transform, "story_v_out_425122", "425122087", "story_v_out_425122.awb")

						arg_357_1:RecordAudio("425122087", var_360_32)
						arg_357_1:RecordAudio("425122087", var_360_32)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_425122", "425122087", "story_v_out_425122.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_425122", "425122087", "story_v_out_425122.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_33 = math.max(var_360_24, arg_357_1.talkMaxDuration)

			if var_360_23 <= arg_357_1.time_ and arg_357_1.time_ < var_360_23 + var_360_33 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_23) / var_360_33

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_23 + var_360_33 and arg_357_1.time_ < var_360_23 + var_360_33 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play425122088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 425122088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play425122089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1036"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps1036 == nil then
				arg_361_1.var_.actorSpriteComps1036 = var_364_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_2 = 0.2

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.actorSpriteComps1036 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								local var_364_4 = Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor2.r, var_364_3)
								local var_364_5 = Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor2.g, var_364_3)
								local var_364_6 = Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor2.b, var_364_3)

								iter_364_1.color = Color.New(var_364_4, var_364_5, var_364_6)
							else
								local var_364_7 = Mathf.Lerp(iter_364_1.color.r, 0.5, var_364_3)

								iter_364_1.color = Color.New(var_364_7, var_364_7, var_364_7)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps1036 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_364_3 then
						if arg_361_1.isInRecall_ then
							iter_364_3.color = arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_364_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps1036 = nil
			end

			local var_364_8 = arg_361_1.actors_["1036"].transform
			local var_364_9 = 0

			if var_364_9 < arg_361_1.time_ and arg_361_1.time_ <= var_364_9 + arg_364_0 then
				arg_361_1.var_.moveOldPos1036 = var_364_8.localPosition
				var_364_8.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1036", 7)

				local var_364_10 = var_364_8.childCount

				for iter_364_4 = 0, var_364_10 - 1 do
					local var_364_11 = var_364_8:GetChild(iter_364_4)

					if var_364_11.name == "" or not string.find(var_364_11.name, "split") then
						var_364_11.gameObject:SetActive(true)
					else
						var_364_11.gameObject:SetActive(false)
					end
				end
			end

			local var_364_12 = 0.001

			if var_364_9 <= arg_361_1.time_ and arg_361_1.time_ < var_364_9 + var_364_12 then
				local var_364_13 = (arg_361_1.time_ - var_364_9) / var_364_12
				local var_364_14 = Vector3.New(0, -2000, 0)

				var_364_8.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1036, var_364_14, var_364_13)
			end

			if arg_361_1.time_ >= var_364_9 + var_364_12 and arg_361_1.time_ < var_364_9 + var_364_12 + arg_364_0 then
				var_364_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_15 = arg_361_1.actors_["1137"].transform
			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.var_.moveOldPos1137 = var_364_15.localPosition
				var_364_15.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1137", 7)

				local var_364_17 = var_364_15.childCount

				for iter_364_5 = 0, var_364_17 - 1 do
					local var_364_18 = var_364_15:GetChild(iter_364_5)

					if var_364_18.name == "" or not string.find(var_364_18.name, "split") then
						var_364_18.gameObject:SetActive(true)
					else
						var_364_18.gameObject:SetActive(false)
					end
				end
			end

			local var_364_19 = 0.001

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_19 then
				local var_364_20 = (arg_361_1.time_ - var_364_16) / var_364_19
				local var_364_21 = Vector3.New(0, -2000, 0)

				var_364_15.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1137, var_364_21, var_364_20)
			end

			if arg_361_1.time_ >= var_364_16 + var_364_19 and arg_361_1.time_ < var_364_16 + var_364_19 + arg_364_0 then
				var_364_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_22 = 0
			local var_364_23 = 0.55

			if var_364_22 < arg_361_1.time_ and arg_361_1.time_ <= var_364_22 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_24 = arg_361_1:GetWordFromCfg(425122088)
				local var_364_25 = arg_361_1:FormatText(var_364_24.content)

				arg_361_1.text_.text = var_364_25

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_26 = 22
				local var_364_27 = utf8.len(var_364_25)
				local var_364_28 = var_364_26 <= 0 and var_364_23 or var_364_23 * (var_364_27 / var_364_26)

				if var_364_28 > 0 and var_364_23 < var_364_28 then
					arg_361_1.talkMaxDuration = var_364_28

					if var_364_28 + var_364_22 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_28 + var_364_22
					end
				end

				arg_361_1.text_.text = var_364_25
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_29 = math.max(var_364_23, arg_361_1.talkMaxDuration)

			if var_364_22 <= arg_361_1.time_ and arg_361_1.time_ < var_364_22 + var_364_29 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_22) / var_364_29

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_22 + var_364_29 and arg_361_1.time_ < var_364_22 + var_364_29 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_361_1:InitPlayNodeList()
	end,
	Play425122089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 425122089
		arg_365_1.duration_ = 2.63

		local var_365_0 = {
			zh = 2.333,
			ja = 2.633
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play425122090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.35

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[1440].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3070")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(425122089)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 14
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122089", "story_v_out_425122.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122089", "story_v_out_425122.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_425122", "425122089", "story_v_out_425122.awb")

						arg_365_1:RecordAudio("425122089", var_368_9)
						arg_365_1:RecordAudio("425122089", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_425122", "425122089", "story_v_out_425122.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_425122", "425122089", "story_v_out_425122.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play425122090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 425122090
		arg_369_1.duration_ = 4.03

		local var_369_0 = {
			zh = 2.7,
			ja = 4.033
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play425122091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1137"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1137 == nil then
				arg_369_1.var_.actorSpriteComps1137 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps1137 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 1, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1137 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1137 = nil
			end

			local var_372_8 = arg_369_1.actors_["1137"].transform
			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.var_.moveOldPos1137 = var_372_8.localPosition
				var_372_8.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1137", 3)

				local var_372_10 = var_372_8.childCount

				for iter_372_4 = 0, var_372_10 - 1 do
					local var_372_11 = var_372_8:GetChild(iter_372_4)

					if var_372_11.name == "split_5" or not string.find(var_372_11.name, "split") then
						var_372_11.gameObject:SetActive(true)
					else
						var_372_11.gameObject:SetActive(false)
					end
				end
			end

			local var_372_12 = 0.001

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_12 then
				local var_372_13 = (arg_369_1.time_ - var_372_9) / var_372_12
				local var_372_14 = Vector3.New(0, -425, -200)

				var_372_8.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1137, var_372_14, var_372_13)
			end

			if arg_369_1.time_ >= var_372_9 + var_372_12 and arg_369_1.time_ < var_372_9 + var_372_12 + arg_372_0 then
				var_372_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_372_15 = 0
			local var_372_16 = 0.275

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[15].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(425122090)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 11
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_16 or var_372_16 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_16 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122090", "story_v_out_425122.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_425122", "425122090", "story_v_out_425122.awb") / 1000

					if var_372_23 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_15
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_425122", "425122090", "story_v_out_425122.awb")

						arg_369_1:RecordAudio("425122090", var_372_24)
						arg_369_1:RecordAudio("425122090", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_425122", "425122090", "story_v_out_425122.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_425122", "425122090", "story_v_out_425122.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_25 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_25

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_25 and arg_369_1.time_ < var_372_15 + var_372_25 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play425122091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 425122091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play425122092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1137"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1137 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1137", 7)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(0, -2000, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1137, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_376_7 = 0.133333333333333
			local var_376_8 = 1

			if var_376_7 < arg_373_1.time_ and arg_373_1.time_ <= var_376_7 + arg_376_0 then
				local var_376_9 = "play"
				local var_376_10 = "effect"

				arg_373_1:AudioAction(var_376_9, var_376_10, "se_story_141", "se_story_141_snake04", "")
			end

			local var_376_11 = 0
			local var_376_12 = 0.8

			if var_376_11 < arg_373_1.time_ and arg_373_1.time_ <= var_376_11 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_13 = arg_373_1:GetWordFromCfg(425122091)
				local var_376_14 = arg_373_1:FormatText(var_376_13.content)

				arg_373_1.text_.text = var_376_14

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_15 = 32
				local var_376_16 = utf8.len(var_376_14)
				local var_376_17 = var_376_15 <= 0 and var_376_12 or var_376_12 * (var_376_16 / var_376_15)

				if var_376_17 > 0 and var_376_12 < var_376_17 then
					arg_373_1.talkMaxDuration = var_376_17

					if var_376_17 + var_376_11 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_17 + var_376_11
					end
				end

				arg_373_1.text_.text = var_376_14
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_18 = math.max(var_376_12, arg_373_1.talkMaxDuration)

			if var_376_11 <= arg_373_1.time_ and arg_373_1.time_ < var_376_11 + var_376_18 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_11) / var_376_18

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_11 + var_376_18 and arg_373_1.time_ < var_376_11 + var_376_18 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play425122092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 425122092
		arg_377_1.duration_ = 5.53

		local var_377_0 = {
			zh = 5.5,
			ja = 5.533
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play425122093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 2

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				local var_380_1 = manager.ui.mainCamera.transform.localPosition
				local var_380_2 = Vector3.New(0, 0, 10) + Vector3.New(var_380_1.x, var_380_1.y, 0)
				local var_380_3 = arg_377_1.bgs_.STblack

				var_380_3.transform.localPosition = var_380_2
				var_380_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_4 = var_380_3:GetComponent("SpriteRenderer")

				if var_380_4 and var_380_4.sprite then
					local var_380_5 = (var_380_3.transform.localPosition - var_380_1).z
					local var_380_6 = manager.ui.mainCameraCom_
					local var_380_7 = 2 * var_380_5 * Mathf.Tan(var_380_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_8 = var_380_7 * var_380_6.aspect
					local var_380_9 = var_380_4.sprite.bounds.size.x
					local var_380_10 = var_380_4.sprite.bounds.size.y
					local var_380_11 = var_380_8 / var_380_9
					local var_380_12 = var_380_7 / var_380_10
					local var_380_13 = var_380_12 < var_380_11 and var_380_11 or var_380_12

					var_380_3.transform.localScale = Vector3.New(var_380_13, var_380_13, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "STblack" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_14 = 4

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1.allBtn_.enabled = false
			end

			local var_380_15 = 0.3

			if arg_377_1.time_ >= var_380_14 + var_380_15 and arg_377_1.time_ < var_380_14 + var_380_15 + arg_380_0 then
				arg_377_1.allBtn_.enabled = true
			end

			local var_380_16 = 0

			if var_380_16 < arg_377_1.time_ and arg_377_1.time_ <= var_380_16 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_17 = 2

			if var_380_16 <= arg_377_1.time_ and arg_377_1.time_ < var_380_16 + var_380_17 then
				local var_380_18 = (arg_377_1.time_ - var_380_16) / var_380_17
				local var_380_19 = Color.New(0, 0, 0)

				var_380_19.a = Mathf.Lerp(0, 1, var_380_18)
				arg_377_1.mask_.color = var_380_19
			end

			if arg_377_1.time_ >= var_380_16 + var_380_17 and arg_377_1.time_ < var_380_16 + var_380_17 + arg_380_0 then
				local var_380_20 = Color.New(0, 0, 0)

				var_380_20.a = 1
				arg_377_1.mask_.color = var_380_20
			end

			local var_380_21 = 2

			if var_380_21 < arg_377_1.time_ and arg_377_1.time_ <= var_380_21 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_22 = 2

			if var_380_21 <= arg_377_1.time_ and arg_377_1.time_ < var_380_21 + var_380_22 then
				local var_380_23 = (arg_377_1.time_ - var_380_21) / var_380_22
				local var_380_24 = Color.New(0, 0, 0)

				var_380_24.a = Mathf.Lerp(1, 0, var_380_23)
				arg_377_1.mask_.color = var_380_24
			end

			if arg_377_1.time_ >= var_380_21 + var_380_22 and arg_377_1.time_ < var_380_21 + var_380_22 + arg_380_0 then
				local var_380_25 = Color.New(0, 0, 0)
				local var_380_26 = 0

				arg_377_1.mask_.enabled = false
				var_380_25.a = var_380_26
				arg_377_1.mask_.color = var_380_25
			end

			local var_380_27 = 3.53333333333333
			local var_380_28 = 1

			if var_380_27 < arg_377_1.time_ and arg_377_1.time_ <= var_380_27 + arg_380_0 then
				local var_380_29 = "play"
				local var_380_30 = "effect"

				arg_377_1:AudioAction(var_380_29, var_380_30, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_31 = 4
			local var_380_32 = 0.075

			if var_380_31 < arg_377_1.time_ and arg_377_1.time_ <= var_380_31 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_33 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_33:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_34 = arg_377_1:FormatText(StoryNameCfg[15].name)

				arg_377_1.leftNameTxt_.text = var_380_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_35 = arg_377_1:GetWordFromCfg(425122092)
				local var_380_36 = arg_377_1:FormatText(var_380_35.content)

				arg_377_1.text_.text = var_380_36

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_37 = 3
				local var_380_38 = utf8.len(var_380_36)
				local var_380_39 = var_380_37 <= 0 and var_380_32 or var_380_32 * (var_380_38 / var_380_37)

				if var_380_39 > 0 and var_380_32 < var_380_39 then
					arg_377_1.talkMaxDuration = var_380_39
					var_380_31 = var_380_31 + 0.3

					if var_380_39 + var_380_31 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_39 + var_380_31
					end
				end

				arg_377_1.text_.text = var_380_36
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122092", "story_v_out_425122.awb") ~= 0 then
					local var_380_40 = manager.audio:GetVoiceLength("story_v_out_425122", "425122092", "story_v_out_425122.awb") / 1000

					if var_380_40 + var_380_31 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_40 + var_380_31
					end

					if var_380_35.prefab_name ~= "" and arg_377_1.actors_[var_380_35.prefab_name] ~= nil then
						local var_380_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_35.prefab_name].transform, "story_v_out_425122", "425122092", "story_v_out_425122.awb")

						arg_377_1:RecordAudio("425122092", var_380_41)
						arg_377_1:RecordAudio("425122092", var_380_41)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_425122", "425122092", "story_v_out_425122.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_425122", "425122092", "story_v_out_425122.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_42 = var_380_31 + 0.3
			local var_380_43 = math.max(var_380_32, arg_377_1.talkMaxDuration)

			if var_380_42 <= arg_377_1.time_ and arg_377_1.time_ < var_380_42 + var_380_43 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_42) / var_380_43

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_42 + var_380_43 and arg_377_1.time_ < var_380_42 + var_380_43 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 20,
				className = "StoryShakeNode",
				duration = 0.133333333333334,
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 10, 10)
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play425122093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 425122093
		arg_383_1.duration_ = 1.07

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play425122094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			return
		end

		arg_383_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425122093,
				charCount = 16,
				enableLayoutChange = true,
				duration = 1.06666666666667,
				groupID = "2093",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play425122094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 425122094
		arg_387_1.duration_ = 6.87

		local var_387_0 = {
			zh = 5.866,
			ja = 6.866
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play425122095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = "ST2403b"

			if arg_387_1.bgs_[var_390_0] == nil then
				local var_390_1 = Object.Instantiate(arg_387_1.paintGo_)

				var_390_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_390_0)
				var_390_1.name = var_390_0
				var_390_1.transform.parent = arg_387_1.stage_.transform
				var_390_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.bgs_[var_390_0] = var_390_1
			end

			local var_390_2 = 2

			if var_390_2 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				local var_390_3 = manager.ui.mainCamera.transform.localPosition
				local var_390_4 = Vector3.New(0, 0, 10) + Vector3.New(var_390_3.x, var_390_3.y, 0)
				local var_390_5 = arg_387_1.bgs_.ST2403b

				var_390_5.transform.localPosition = var_390_4
				var_390_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_390_6 = var_390_5:GetComponent("SpriteRenderer")

				if var_390_6 and var_390_6.sprite then
					local var_390_7 = (var_390_5.transform.localPosition - var_390_3).z
					local var_390_8 = manager.ui.mainCameraCom_
					local var_390_9 = 2 * var_390_7 * Mathf.Tan(var_390_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_390_10 = var_390_9 * var_390_8.aspect
					local var_390_11 = var_390_6.sprite.bounds.size.x
					local var_390_12 = var_390_6.sprite.bounds.size.y
					local var_390_13 = var_390_10 / var_390_11
					local var_390_14 = var_390_9 / var_390_12
					local var_390_15 = var_390_14 < var_390_13 and var_390_13 or var_390_14

					var_390_5.transform.localScale = Vector3.New(var_390_15, var_390_15, 0)
				end

				for iter_390_0, iter_390_1 in pairs(arg_387_1.bgs_) do
					if iter_390_0 ~= "ST2403b" then
						iter_390_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_390_16 = 4

			if var_390_16 < arg_387_1.time_ and arg_387_1.time_ <= var_390_16 + arg_390_0 then
				arg_387_1.allBtn_.enabled = false
			end

			local var_390_17 = 0.15

			if arg_387_1.time_ >= var_390_16 + var_390_17 and arg_387_1.time_ < var_390_16 + var_390_17 + arg_390_0 then
				arg_387_1.allBtn_.enabled = true
			end

			local var_390_18 = 0

			if var_390_18 < arg_387_1.time_ and arg_387_1.time_ <= var_390_18 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_19 = 2

			if var_390_18 <= arg_387_1.time_ and arg_387_1.time_ < var_390_18 + var_390_19 then
				local var_390_20 = (arg_387_1.time_ - var_390_18) / var_390_19
				local var_390_21 = Color.New(0, 0, 0)

				var_390_21.a = Mathf.Lerp(0, 1, var_390_20)
				arg_387_1.mask_.color = var_390_21
			end

			if arg_387_1.time_ >= var_390_18 + var_390_19 and arg_387_1.time_ < var_390_18 + var_390_19 + arg_390_0 then
				local var_390_22 = Color.New(0, 0, 0)

				var_390_22.a = 1
				arg_387_1.mask_.color = var_390_22
			end

			local var_390_23 = 2

			if var_390_23 < arg_387_1.time_ and arg_387_1.time_ <= var_390_23 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_24 = 2

			if var_390_23 <= arg_387_1.time_ and arg_387_1.time_ < var_390_23 + var_390_24 then
				local var_390_25 = (arg_387_1.time_ - var_390_23) / var_390_24
				local var_390_26 = Color.New(0, 0, 0)

				var_390_26.a = Mathf.Lerp(1, 0, var_390_25)
				arg_387_1.mask_.color = var_390_26
			end

			if arg_387_1.time_ >= var_390_23 + var_390_24 and arg_387_1.time_ < var_390_23 + var_390_24 + arg_390_0 then
				local var_390_27 = Color.New(0, 0, 0)
				local var_390_28 = 0

				arg_387_1.mask_.enabled = false
				var_390_27.a = var_390_28
				arg_387_1.mask_.color = var_390_27
			end

			local var_390_29 = 1.73333333333333
			local var_390_30 = 1

			if var_390_29 < arg_387_1.time_ and arg_387_1.time_ <= var_390_29 + arg_390_0 then
				local var_390_31 = "play"
				local var_390_32 = "effect"

				arg_387_1:AudioAction(var_390_31, var_390_32, "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_390_33 = 0.2
			local var_390_34 = 1

			if var_390_33 < arg_387_1.time_ and arg_387_1.time_ <= var_390_33 + arg_390_0 then
				local var_390_35 = "stop"
				local var_390_36 = "effect"

				arg_387_1:AudioAction(var_390_35, var_390_36, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_390_37 = 0.2
			local var_390_38 = 0.3

			if var_390_37 < arg_387_1.time_ and arg_387_1.time_ <= var_390_37 + arg_390_0 then
				local var_390_39 = "play"
				local var_390_40 = "music"

				arg_387_1:AudioAction(var_390_39, var_390_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_390_41 = ""
				local var_390_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_390_42 ~= "" then
					if arg_387_1.bgmTxt_.text ~= var_390_42 and arg_387_1.bgmTxt_.text ~= "" then
						if arg_387_1.bgmTxt2_.text ~= "" then
							arg_387_1.bgmTxt_.text = arg_387_1.bgmTxt2_.text
						end

						arg_387_1.bgmTxt2_.text = var_390_42

						arg_387_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_387_1.bgmTxt_.text = var_390_42
						arg_387_1.bgmTxt2_.text = var_390_42
					end

					if arg_387_1.bgmTimer then
						arg_387_1.bgmTimer:Stop()

						arg_387_1.bgmTimer = nil
					end

					if arg_387_1.settingData.show_music_name == 1 then
						arg_387_1.musicController:SetSelectedState("show")
						arg_387_1.musicAnimator_:Play("open", 0, 0)

						if arg_387_1.settingData.music_time ~= 0 then
							arg_387_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_387_1.settingData.music_time), function()
								if arg_387_1 == nil or isNil(arg_387_1.bgmTxt_) then
									return
								end

								arg_387_1.musicController:SetSelectedState("hide")
								arg_387_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_390_43 = 1.73333333333333
			local var_390_44 = 1

			if var_390_43 < arg_387_1.time_ and arg_387_1.time_ <= var_390_43 + arg_390_0 then
				local var_390_45 = "play"
				local var_390_46 = "music"

				arg_387_1:AudioAction(var_390_45, var_390_46, "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3.awb")

				local var_390_47 = ""
				local var_390_48 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3")

				if var_390_48 ~= "" then
					if arg_387_1.bgmTxt_.text ~= var_390_48 and arg_387_1.bgmTxt_.text ~= "" then
						if arg_387_1.bgmTxt2_.text ~= "" then
							arg_387_1.bgmTxt_.text = arg_387_1.bgmTxt2_.text
						end

						arg_387_1.bgmTxt2_.text = var_390_48

						arg_387_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_387_1.bgmTxt_.text = var_390_48
						arg_387_1.bgmTxt2_.text = var_390_48
					end

					if arg_387_1.bgmTimer then
						arg_387_1.bgmTimer:Stop()

						arg_387_1.bgmTimer = nil
					end

					if arg_387_1.settingData.show_music_name == 1 then
						arg_387_1.musicController:SetSelectedState("show")
						arg_387_1.musicAnimator_:Play("open", 0, 0)

						if arg_387_1.settingData.music_time ~= 0 then
							arg_387_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_387_1.settingData.music_time), function()
								if arg_387_1 == nil or isNil(arg_387_1.bgmTxt_) then
									return
								end

								arg_387_1.musicController:SetSelectedState("hide")
								arg_387_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_387_1.frameCnt_ <= 1 then
				arg_387_1.dialog_:SetActive(false)
			end

			local var_390_49 = 4
			local var_390_50 = 0.15

			if var_390_49 < arg_387_1.time_ and arg_387_1.time_ <= var_390_49 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_51 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_51:setOnUpdate(LuaHelper.FloatAction(function(arg_393_0)
					arg_387_1.dialogCg_.alpha = arg_393_0
				end))
				var_390_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_52 = arg_387_1:FormatText(StoryNameCfg[15].name)

				arg_387_1.leftNameTxt_.text = var_390_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_4")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_53 = arg_387_1:GetWordFromCfg(425122094)
				local var_390_54 = arg_387_1:FormatText(var_390_53.content)

				arg_387_1.text_.text = var_390_54

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_55 = 6
				local var_390_56 = utf8.len(var_390_54)
				local var_390_57 = var_390_55 <= 0 and var_390_50 or var_390_50 * (var_390_56 / var_390_55)

				if var_390_57 > 0 and var_390_50 < var_390_57 then
					arg_387_1.talkMaxDuration = var_390_57
					var_390_49 = var_390_49 + 0.3

					if var_390_57 + var_390_49 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_57 + var_390_49
					end
				end

				arg_387_1.text_.text = var_390_54
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122094", "story_v_out_425122.awb") ~= 0 then
					local var_390_58 = manager.audio:GetVoiceLength("story_v_out_425122", "425122094", "story_v_out_425122.awb") / 1000

					if var_390_58 + var_390_49 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_58 + var_390_49
					end

					if var_390_53.prefab_name ~= "" and arg_387_1.actors_[var_390_53.prefab_name] ~= nil then
						local var_390_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_53.prefab_name].transform, "story_v_out_425122", "425122094", "story_v_out_425122.awb")

						arg_387_1:RecordAudio("425122094", var_390_59)
						arg_387_1:RecordAudio("425122094", var_390_59)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_425122", "425122094", "story_v_out_425122.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_425122", "425122094", "story_v_out_425122.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_60 = var_390_49 + 0.3
			local var_390_61 = math.max(var_390_50, arg_387_1.talkMaxDuration)

			if var_390_60 <= arg_387_1.time_ and arg_387_1.time_ < var_390_60 + var_390_61 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_60) / var_390_61

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_60 + var_390_61 and arg_387_1.time_ < var_390_60 + var_390_61 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				groupID = "2093",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play425122095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 425122095
		arg_395_1.duration_ = 5.33

		local var_395_0 = {
			zh = 5.333,
			ja = 5.133
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play425122096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1137"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps1137 == nil then
				arg_395_1.var_.actorSpriteComps1137 = var_398_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.actorSpriteComps1137 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								local var_398_4 = Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, var_398_3)
								local var_398_5 = Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, var_398_3)
								local var_398_6 = Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, var_398_3)

								iter_398_1.color = Color.New(var_398_4, var_398_5, var_398_6)
							else
								local var_398_7 = Mathf.Lerp(iter_398_1.color.r, 0.5, var_398_3)

								iter_398_1.color = Color.New(var_398_7, var_398_7, var_398_7)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps1137 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_398_3 then
						if arg_395_1.isInRecall_ then
							iter_398_3.color = arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_398_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_395_1.var_.actorSpriteComps1137 = nil
			end

			local var_398_8 = 0
			local var_398_9 = 0.475

			if var_398_8 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_10 = arg_395_1:FormatText(StoryNameCfg[1440].name)

				arg_395_1.leftNameTxt_.text = var_398_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_11 = arg_395_1:GetWordFromCfg(425122095)
				local var_398_12 = arg_395_1:FormatText(var_398_11.content)

				arg_395_1.text_.text = var_398_12

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_13 = 19
				local var_398_14 = utf8.len(var_398_12)
				local var_398_15 = var_398_13 <= 0 and var_398_9 or var_398_9 * (var_398_14 / var_398_13)

				if var_398_15 > 0 and var_398_9 < var_398_15 then
					arg_395_1.talkMaxDuration = var_398_15

					if var_398_15 + var_398_8 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_15 + var_398_8
					end
				end

				arg_395_1.text_.text = var_398_12
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122095", "story_v_out_425122.awb") ~= 0 then
					local var_398_16 = manager.audio:GetVoiceLength("story_v_out_425122", "425122095", "story_v_out_425122.awb") / 1000

					if var_398_16 + var_398_8 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_16 + var_398_8
					end

					if var_398_11.prefab_name ~= "" and arg_395_1.actors_[var_398_11.prefab_name] ~= nil then
						local var_398_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_11.prefab_name].transform, "story_v_out_425122", "425122095", "story_v_out_425122.awb")

						arg_395_1:RecordAudio("425122095", var_398_17)
						arg_395_1:RecordAudio("425122095", var_398_17)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_425122", "425122095", "story_v_out_425122.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_425122", "425122095", "story_v_out_425122.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_18 = math.max(var_398_9, arg_395_1.talkMaxDuration)

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_18 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_8) / var_398_18

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_8 + var_398_18 and arg_395_1.time_ < var_398_8 + var_398_18 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play425122096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 425122096
		arg_399_1.duration_ = 4.83

		local var_399_0 = {
			zh = 2.866,
			ja = 4.833
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
				arg_399_0:Play425122097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.25

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[1440].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:GetWordFromCfg(425122096)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 10
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122096", "story_v_out_425122.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122096", "story_v_out_425122.awb") / 1000

					if var_402_8 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_0
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_425122", "425122096", "story_v_out_425122.awb")

						arg_399_1:RecordAudio("425122096", var_402_9)
						arg_399_1:RecordAudio("425122096", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_425122", "425122096", "story_v_out_425122.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_425122", "425122096", "story_v_out_425122.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_10 and arg_399_1.time_ < var_402_0 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play425122097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 425122097
		arg_403_1.duration_ = 10.3

		local var_403_0 = {
			zh = 9.9,
			ja = 10.3
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
				arg_403_0:Play425122098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[1440].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_3 = arg_403_1:GetWordFromCfg(425122097)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 40
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122097", "story_v_out_425122.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122097", "story_v_out_425122.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_425122", "425122097", "story_v_out_425122.awb")

						arg_403_1:RecordAudio("425122097", var_406_9)
						arg_403_1:RecordAudio("425122097", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_425122", "425122097", "story_v_out_425122.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_425122", "425122097", "story_v_out_425122.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play425122098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 425122098
		arg_407_1.duration_ = 2.57

		local var_407_0 = {
			zh = 1.466,
			ja = 2.566
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
				arg_407_0:Play425122099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 0.05

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[15].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_4")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:GetWordFromCfg(425122098)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122098", "story_v_out_425122.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122098", "story_v_out_425122.awb") / 1000

					if var_410_8 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_0
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_out_425122", "425122098", "story_v_out_425122.awb")

						arg_407_1:RecordAudio("425122098", var_410_9)
						arg_407_1:RecordAudio("425122098", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_425122", "425122098", "story_v_out_425122.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_425122", "425122098", "story_v_out_425122.awb")
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
	Play425122099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 425122099
		arg_411_1.duration_ = 8.3

		local var_411_0 = {
			zh = 7.166,
			ja = 8.3
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
				arg_411_0:Play425122100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 0.55

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[1440].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_3 = arg_411_1:GetWordFromCfg(425122099)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 22
				local var_414_6 = utf8.len(var_414_4)
				local var_414_7 = var_414_5 <= 0 and var_414_1 or var_414_1 * (var_414_6 / var_414_5)

				if var_414_7 > 0 and var_414_1 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122099", "story_v_out_425122.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122099", "story_v_out_425122.awb") / 1000

					if var_414_8 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_0
					end

					if var_414_3.prefab_name ~= "" and arg_411_1.actors_[var_414_3.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_3.prefab_name].transform, "story_v_out_425122", "425122099", "story_v_out_425122.awb")

						arg_411_1:RecordAudio("425122099", var_414_9)
						arg_411_1:RecordAudio("425122099", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_425122", "425122099", "story_v_out_425122.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_425122", "425122099", "story_v_out_425122.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_10 and arg_411_1.time_ < var_414_0 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play425122100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 425122100
		arg_415_1.duration_ = 10.47

		local var_415_0 = {
			zh = 7.866,
			ja = 10.466
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
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play425122101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.625

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[1440].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_3 = arg_415_1:GetWordFromCfg(425122100)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 25
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122100", "story_v_out_425122.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122100", "story_v_out_425122.awb") / 1000

					if var_418_8 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_0
					end

					if var_418_3.prefab_name ~= "" and arg_415_1.actors_[var_418_3.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_3.prefab_name].transform, "story_v_out_425122", "425122100", "story_v_out_425122.awb")

						arg_415_1:RecordAudio("425122100", var_418_9)
						arg_415_1:RecordAudio("425122100", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_425122", "425122100", "story_v_out_425122.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_425122", "425122100", "story_v_out_425122.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_10 and arg_415_1.time_ < var_418_0 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play425122101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 425122101
		arg_419_1.duration_ = 2.23

		local var_419_0 = {
			zh = 2.233,
			ja = 1.866
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play425122102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.1

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[15].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_4")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:GetWordFromCfg(425122101)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 4
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425122", "425122101", "story_v_out_425122.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_425122", "425122101", "story_v_out_425122.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_425122", "425122101", "story_v_out_425122.awb")

						arg_419_1:RecordAudio("425122101", var_422_9)
						arg_419_1:RecordAudio("425122101", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_425122", "425122101", "story_v_out_425122.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_425122", "425122101", "story_v_out_425122.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play425122102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 425122102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
			arg_423_1.auto_ = false
		end

		function arg_423_1.playNext_(arg_425_0)
			arg_423_1.onStoryFinished_()
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.75

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_2 = arg_423_1:GetWordFromCfg(425122102)
				local var_426_3 = arg_423_1:FormatText(var_426_2.content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 30
				local var_426_5 = utf8.len(var_426_3)
				local var_426_6 = var_426_4 <= 0 and var_426_1 or var_426_1 * (var_426_5 / var_426_4)

				if var_426_6 > 0 and var_426_1 < var_426_6 then
					arg_423_1.talkMaxDuration = var_426_6

					if var_426_6 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_6 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_7 and arg_423_1.time_ < var_426_0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/M01g",
		"TextureConfig/Background/ST2403a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2403b"
	},
	voices = {
		"story_v_out_425122.awb",
		"story_v_out_425121.awb"
	}
}
