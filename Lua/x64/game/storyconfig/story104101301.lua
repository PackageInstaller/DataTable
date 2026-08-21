return {
	Play410131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L04f"

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
				local var_4_5 = arg_1_1.bgs_.L04f

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
					if iter_4_0 ~= "L04f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 2
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_1", "se_story_1_gun_load", "")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 1.56666666666666
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 0.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(410131001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 32
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410131002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.075

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

				local var_12_2 = arg_9_1:GetWordFromCfg(410131002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 43
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
	Play410131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410131003
		arg_13_1.duration_ = 7.5

		local var_13_0 = {
			zh = 7.5,
			ja = 6.733
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
				arg_13_0:Play410131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10059"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

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

			local var_16_4 = arg_13_1.actors_["10059"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10059 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10059", 3)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(0, -530, 35)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10059, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -530, 35)
			end

			local var_16_11 = arg_13_1.actors_["10059"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10059 == nil then
				arg_13_1.var_.actorSpriteComps10059 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps10059 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_15 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_14)
								local var_16_16 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_14)
								local var_16_17 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_14)

								iter_16_4.color = Color.New(var_16_15, var_16_16, var_16_17)
							else
								local var_16_18 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_14)

								iter_16_4.color = Color.New(var_16_18, var_16_18, var_16_18)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10059 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10059 = nil
			end

			local var_16_19 = 0
			local var_16_20 = 0.55

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[596].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(410131003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131003", "story_v_out_410131.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_410131", "410131003", "story_v_out_410131.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_410131", "410131003", "story_v_out_410131.awb")

						arg_13_1:RecordAudio("410131003", var_16_28)
						arg_13_1:RecordAudio("410131003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410131", "410131003", "story_v_out_410131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410131", "410131003", "story_v_out_410131.awb")
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
				actorName = "10059",
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
	Play410131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410131004
		arg_17_1.duration_ = 18

		local var_17_0 = {
			zh = 7.233,
			ja = 18
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
				arg_17_0:Play410131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1060"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_20_4 = arg_17_1.actors_["1060"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos1060 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1060", 4)

				local var_20_6 = var_20_4.childCount

				for iter_20_2 = 0, var_20_6 - 1 do
					local var_20_7 = var_20_4:GetChild(iter_20_2)

					if var_20_7.name == "" or not string.find(var_20_7.name, "split") then
						var_20_7.gameObject:SetActive(true)
					else
						var_20_7.gameObject:SetActive(false)
					end
				end
			end

			local var_20_8 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_5) / var_20_8
				local var_20_10 = Vector3.New(420.9, -430.8, 6.9)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1060, var_20_10, var_20_9)
			end

			if arg_17_1.time_ >= var_20_5 + var_20_8 and arg_17_1.time_ < var_20_5 + var_20_8 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_20_11 = arg_17_1.actors_["10059"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos10059 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10059", 2)

				local var_20_13 = var_20_11.childCount

				for iter_20_3 = 0, var_20_13 - 1 do
					local var_20_14 = var_20_11:GetChild(iter_20_3)

					if var_20_14.name == "" or not string.find(var_20_14.name, "split") then
						var_20_14.gameObject:SetActive(true)
					else
						var_20_14.gameObject:SetActive(false)
					end
				end
			end

			local var_20_15 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_15 then
				local var_20_16 = (arg_17_1.time_ - var_20_12) / var_20_15
				local var_20_17 = Vector3.New(-390, -530, 35)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10059, var_20_17, var_20_16)
			end

			if arg_17_1.time_ >= var_20_12 + var_20_15 and arg_17_1.time_ < var_20_12 + var_20_15 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_20_18 = arg_17_1.actors_["1060"]
			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.actorSpriteComps1060 == nil then
				arg_17_1.var_.actorSpriteComps1060 = var_20_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_20 = 0.034

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 and not isNil(var_20_18) then
				local var_20_21 = (arg_17_1.time_ - var_20_19) / var_20_20

				if arg_17_1.var_.actorSpriteComps1060 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_22 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor1.r, var_20_21)
								local var_20_23 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor1.g, var_20_21)
								local var_20_24 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor1.b, var_20_21)

								iter_20_5.color = Color.New(var_20_22, var_20_23, var_20_24)
							else
								local var_20_25 = Mathf.Lerp(iter_20_5.color.r, 1, var_20_21)

								iter_20_5.color = Color.New(var_20_25, var_20_25, var_20_25)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.actorSpriteComps1060 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1060 = nil
			end

			local var_20_26 = arg_17_1.actors_["10059"]
			local var_20_27 = 0

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 and not isNil(var_20_26) and arg_17_1.var_.actorSpriteComps10059 == nil then
				arg_17_1.var_.actorSpriteComps10059 = var_20_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_28 = 0.034

			if var_20_27 <= arg_17_1.time_ and arg_17_1.time_ < var_20_27 + var_20_28 and not isNil(var_20_26) then
				local var_20_29 = (arg_17_1.time_ - var_20_27) / var_20_28

				if arg_17_1.var_.actorSpriteComps10059 then
					for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_20_9 then
							if arg_17_1.isInRecall_ then
								local var_20_30 = Mathf.Lerp(iter_20_9.color.r, arg_17_1.hightColor2.r, var_20_29)
								local var_20_31 = Mathf.Lerp(iter_20_9.color.g, arg_17_1.hightColor2.g, var_20_29)
								local var_20_32 = Mathf.Lerp(iter_20_9.color.b, arg_17_1.hightColor2.b, var_20_29)

								iter_20_9.color = Color.New(var_20_30, var_20_31, var_20_32)
							else
								local var_20_33 = Mathf.Lerp(iter_20_9.color.r, 0.5, var_20_29)

								iter_20_9.color = Color.New(var_20_33, var_20_33, var_20_33)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_27 + var_20_28 and arg_17_1.time_ < var_20_27 + var_20_28 + arg_20_0 and not isNil(var_20_26) and arg_17_1.var_.actorSpriteComps10059 then
				for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_20_11 then
						if arg_17_1.isInRecall_ then
							iter_20_11.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10059 = nil
			end

			local var_20_34 = 0
			local var_20_35 = 1.05

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[584].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(410131004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 42
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131004", "story_v_out_410131.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_410131", "410131004", "story_v_out_410131.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_410131", "410131004", "story_v_out_410131.awb")

						arg_17_1:RecordAudio("410131004", var_20_43)
						arg_17_1:RecordAudio("410131004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410131", "410131004", "story_v_out_410131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410131", "410131004", "story_v_out_410131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410131005
		arg_21_1.duration_ = 10

		local var_21_0 = {
			zh = 6.766,
			ja = 10
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
				arg_21_0:Play410131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10059"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_8 = arg_21_1.actors_["1060"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.8

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[596].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(410131005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 32
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131005", "story_v_out_410131.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_410131", "410131005", "story_v_out_410131.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_410131", "410131005", "story_v_out_410131.awb")

						arg_21_1:RecordAudio("410131005", var_24_25)
						arg_21_1:RecordAudio("410131005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410131", "410131005", "story_v_out_410131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410131", "410131005", "story_v_out_410131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410131006
		arg_25_1.duration_ = 11.03

		local var_25_0 = {
			zh = 8.1,
			ja = 11.033
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
				arg_25_0:Play410131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.9

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[596].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(410131006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 36
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131006", "story_v_out_410131.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131006", "story_v_out_410131.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_410131", "410131006", "story_v_out_410131.awb")

						arg_25_1:RecordAudio("410131006", var_28_9)
						arg_25_1:RecordAudio("410131006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410131", "410131006", "story_v_out_410131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410131", "410131006", "story_v_out_410131.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play410131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410131007
		arg_29_1.duration_ = 8.37

		local var_29_0 = {
			zh = 4.7,
			ja = 8.366
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
				arg_29_0:Play410131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1060"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1060 == nil then
				arg_29_1.var_.actorSpriteComps1060 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1060 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1060 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1060 = nil
			end

			local var_32_8 = arg_29_1.actors_["10059"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10059 == nil then
				arg_29_1.var_.actorSpriteComps10059 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10059 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10059 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10059 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.625

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[584].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(410131007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 25
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131007", "story_v_out_410131.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_410131", "410131007", "story_v_out_410131.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_410131", "410131007", "story_v_out_410131.awb")

						arg_29_1:RecordAudio("410131007", var_32_25)
						arg_29_1:RecordAudio("410131007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410131", "410131007", "story_v_out_410131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410131", "410131007", "story_v_out_410131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410131008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 7)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(0, -2000, -40)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_36_7 = arg_33_1.actors_["1060"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor2.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor2.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor2.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 0.5, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_15 = arg_33_1.actors_["10059"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos10059 = var_36_15.localPosition
				var_36_15.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10059", 7)

				local var_36_17 = var_36_15.childCount

				for iter_36_5 = 0, var_36_17 - 1 do
					local var_36_18 = var_36_15:GetChild(iter_36_5)

					if var_36_18.name == "" or not string.find(var_36_18.name, "split") then
						var_36_18.gameObject:SetActive(true)
					else
						var_36_18.gameObject:SetActive(false)
					end
				end
			end

			local var_36_19 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_19 then
				local var_36_20 = (arg_33_1.time_ - var_36_16) / var_36_19
				local var_36_21 = Vector3.New(0, -2000, -40)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10059, var_36_21, var_36_20)
			end

			if arg_33_1.time_ >= var_36_16 + var_36_19 and arg_33_1.time_ < var_36_16 + var_36_19 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_36_22 = 0
			local var_36_23 = 1

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				local var_36_24 = "play"
				local var_36_25 = "effect"

				arg_33_1:AudioAction(var_36_24, var_36_25, "se_story_128", "se_story_128_bullet", "")
			end

			local var_36_26 = 0
			local var_36_27 = 1.025

			if var_36_26 < arg_33_1.time_ and arg_33_1.time_ <= var_36_26 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_28 = arg_33_1:GetWordFromCfg(410131008)
				local var_36_29 = arg_33_1:FormatText(var_36_28.content)

				arg_33_1.text_.text = var_36_29

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_30 = 41
				local var_36_31 = utf8.len(var_36_29)
				local var_36_32 = var_36_30 <= 0 and var_36_27 or var_36_27 * (var_36_31 / var_36_30)

				if var_36_32 > 0 and var_36_27 < var_36_32 then
					arg_33_1.talkMaxDuration = var_36_32

					if var_36_32 + var_36_26 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_32 + var_36_26
					end
				end

				arg_33_1.text_.text = var_36_29
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_27, arg_33_1.talkMaxDuration)

			if var_36_26 <= arg_33_1.time_ and arg_33_1.time_ < var_36_26 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_26) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_26 + var_36_33 and arg_33_1.time_ < var_36_26 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410131009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.05

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[604].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3046")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(410131009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 2
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410131010
		arg_41_1.duration_ = 6.97

		local var_41_0 = {
			zh = 1.966,
			ja = 6.966
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
				arg_41_0:Play410131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1060"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1060 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1060", 3)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(33.4, -430.8, 6.9)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1060, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_44_7 = arg_41_1.actors_["1060"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1060 == nil then
				arg_41_1.var_.actorSpriteComps1060 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps1060 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1060 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1060 = nil
			end

			local var_44_15 = 0
			local var_44_16 = 0.275

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[584].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(410131010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 11
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131010", "story_v_out_410131.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_410131", "410131010", "story_v_out_410131.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_410131", "410131010", "story_v_out_410131.awb")

						arg_41_1:RecordAudio("410131010", var_44_24)
						arg_41_1:RecordAudio("410131010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410131", "410131010", "story_v_out_410131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410131", "410131010", "story_v_out_410131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play410131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410131011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1060"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1060 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1060", 7)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(0, -2000, -40)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1060, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_48_7 = arg_45_1.actors_["1060"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 == nil then
				arg_45_1.var_.actorSpriteComps1060 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps1060 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor2.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor2.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor2.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 0.5, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1060 = nil
			end

			local var_48_15 = 0
			local var_48_16 = 1

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				local var_48_17 = "play"
				local var_48_18 = "effect"

				arg_45_1:AudioAction(var_48_17, var_48_18, "se_story_222_00", "se_story_222_00_gun", "")
			end

			local var_48_19 = 0
			local var_48_20 = 0.975

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_21 = arg_45_1:GetWordFromCfg(410131011)
				local var_48_22 = arg_45_1:FormatText(var_48_21.content)

				arg_45_1.text_.text = var_48_22

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_23 = 39
				local var_48_24 = utf8.len(var_48_22)
				local var_48_25 = var_48_23 <= 0 and var_48_20 or var_48_20 * (var_48_24 / var_48_23)

				if var_48_25 > 0 and var_48_20 < var_48_25 then
					arg_45_1.talkMaxDuration = var_48_25

					if var_48_25 + var_48_19 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_25 + var_48_19
					end
				end

				arg_45_1.text_.text = var_48_22
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_26 = math.max(var_48_20, arg_45_1.talkMaxDuration)

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_19) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_19 + var_48_26 and arg_45_1.time_ < var_48_19 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410131012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.25

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(410131012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 50
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play410131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410131013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.225

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(410131013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 49
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410131014
		arg_57_1.duration_ = 14.27

		local var_57_0 = {
			zh = 11.7,
			ja = 14.266
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
				arg_57_0:Play410131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10059"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10059 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10059", 3)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(0, -530, 35)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10059, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -530, 35)
			end

			local var_60_7 = arg_57_1.actors_["10059"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10059 == nil then
				arg_57_1.var_.actorSpriteComps10059 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps10059 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								local var_60_11 = Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, var_60_10)
								local var_60_12 = Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, var_60_10)
								local var_60_13 = Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, var_60_10)

								iter_60_2.color = Color.New(var_60_11, var_60_12, var_60_13)
							else
								local var_60_14 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_10)

								iter_60_2.color = Color.New(var_60_14, var_60_14, var_60_14)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10059 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10059 = nil
			end

			local var_60_15 = 0
			local var_60_16 = 1.325

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[596].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(410131014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 53
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131014", "story_v_out_410131.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_410131", "410131014", "story_v_out_410131.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_410131", "410131014", "story_v_out_410131.awb")

						arg_57_1:RecordAudio("410131014", var_60_24)
						arg_57_1:RecordAudio("410131014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410131", "410131014", "story_v_out_410131.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410131", "410131014", "story_v_out_410131.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play410131015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410131015
		arg_61_1.duration_ = 7.53

		local var_61_0 = {
			zh = 7.533,
			ja = 5.966
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
				arg_61_0:Play410131016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.65

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[596].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(410131015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131015", "story_v_out_410131.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131015", "story_v_out_410131.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_410131", "410131015", "story_v_out_410131.awb")

						arg_61_1:RecordAudio("410131015", var_64_9)
						arg_61_1:RecordAudio("410131015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410131", "410131015", "story_v_out_410131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410131", "410131015", "story_v_out_410131.awb")
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
	Play410131016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410131016
		arg_65_1.duration_ = 5.17

		local var_65_0 = {
			zh = 4,
			ja = 5.166
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
				arg_65_0:Play410131017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1060"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1060 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1060", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "split_3" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(420.9, -430.8, 6.9)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1060, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_68_7 = arg_65_1.actors_["10059"].transform
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = var_68_7.localPosition
				var_68_7.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 2)

				local var_68_9 = var_68_7.childCount

				for iter_68_1 = 0, var_68_9 - 1 do
					local var_68_10 = var_68_7:GetChild(iter_68_1)

					if var_68_10.name == "" or not string.find(var_68_10.name, "split") then
						var_68_10.gameObject:SetActive(true)
					else
						var_68_10.gameObject:SetActive(false)
					end
				end
			end

			local var_68_11 = 0.001

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_8) / var_68_11
				local var_68_13 = Vector3.New(-390, -530, 35)

				var_68_7.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, var_68_13, var_68_12)
			end

			if arg_65_1.time_ >= var_68_8 + var_68_11 and arg_65_1.time_ < var_68_8 + var_68_11 + arg_68_0 then
				var_68_7.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_68_14 = arg_65_1.actors_["1060"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.actorSpriteComps1060 == nil then
				arg_65_1.var_.actorSpriteComps1060 = var_68_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_16 = 0.034

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.actorSpriteComps1060 then
					for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_68_3 then
							if arg_65_1.isInRecall_ then
								local var_68_18 = Mathf.Lerp(iter_68_3.color.r, arg_65_1.hightColor1.r, var_68_17)
								local var_68_19 = Mathf.Lerp(iter_68_3.color.g, arg_65_1.hightColor1.g, var_68_17)
								local var_68_20 = Mathf.Lerp(iter_68_3.color.b, arg_65_1.hightColor1.b, var_68_17)

								iter_68_3.color = Color.New(var_68_18, var_68_19, var_68_20)
							else
								local var_68_21 = Mathf.Lerp(iter_68_3.color.r, 1, var_68_17)

								iter_68_3.color = Color.New(var_68_21, var_68_21, var_68_21)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.actorSpriteComps1060 then
				for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_68_5 then
						if arg_65_1.isInRecall_ then
							iter_68_5.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1060 = nil
			end

			local var_68_22 = arg_65_1.actors_["10059"]
			local var_68_23 = 0

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_24 = 0.034

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 and not isNil(var_68_22) then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24

				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_68_7 then
							if arg_65_1.isInRecall_ then
								local var_68_26 = Mathf.Lerp(iter_68_7.color.r, arg_65_1.hightColor2.r, var_68_25)
								local var_68_27 = Mathf.Lerp(iter_68_7.color.g, arg_65_1.hightColor2.g, var_68_25)
								local var_68_28 = Mathf.Lerp(iter_68_7.color.b, arg_65_1.hightColor2.b, var_68_25)

								iter_68_7.color = Color.New(var_68_26, var_68_27, var_68_28)
							else
								local var_68_29 = Mathf.Lerp(iter_68_7.color.r, 0.5, var_68_25)

								iter_68_7.color = Color.New(var_68_29, var_68_29, var_68_29)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_8, iter_68_9 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_9 then
						if arg_65_1.isInRecall_ then
							iter_68_9.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_30 = 0
			local var_68_31 = 0.575

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[584].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(410131016)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 23
				local var_68_36 = utf8.len(var_68_34)
				local var_68_37 = var_68_35 <= 0 and var_68_31 or var_68_31 * (var_68_36 / var_68_35)

				if var_68_37 > 0 and var_68_31 < var_68_37 then
					arg_65_1.talkMaxDuration = var_68_37

					if var_68_37 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_37 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_34
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131016", "story_v_out_410131.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_410131", "410131016", "story_v_out_410131.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_410131", "410131016", "story_v_out_410131.awb")

						arg_65_1:RecordAudio("410131016", var_68_39)
						arg_65_1:RecordAudio("410131016", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410131", "410131016", "story_v_out_410131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410131", "410131016", "story_v_out_410131.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_40 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_40 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_30) / var_68_40

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_30 + var_68_40 and arg_65_1.time_ < var_68_30 + var_68_40 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410131017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410131017
		arg_69_1.duration_ = 15.6

		local var_69_0 = {
			zh = 6.9,
			ja = 15.6
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
				arg_69_0:Play410131018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1060"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1060 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1060", 4)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(420.9, -430.8, 6.9)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1060, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_72_7 = 0
			local var_72_8 = 0.9

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_9 = arg_69_1:FormatText(StoryNameCfg[584].name)

				arg_69_1.leftNameTxt_.text = var_72_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(410131017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 36
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_8 or var_72_8 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_8 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14

					if var_72_14 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131017", "story_v_out_410131.awb") ~= 0 then
					local var_72_15 = manager.audio:GetVoiceLength("story_v_out_410131", "410131017", "story_v_out_410131.awb") / 1000

					if var_72_15 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_7
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_410131", "410131017", "story_v_out_410131.awb")

						arg_69_1:RecordAudio("410131017", var_72_16)
						arg_69_1:RecordAudio("410131017", var_72_16)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410131", "410131017", "story_v_out_410131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410131", "410131017", "story_v_out_410131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_17 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_17 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_17

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_17 and arg_69_1.time_ < var_72_7 + var_72_17 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play410131018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410131018
		arg_73_1.duration_ = 11.6

		local var_73_0 = {
			zh = 7.4,
			ja = 11.6
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
				arg_73_0:Play410131019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1060"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1060 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1060", 4)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(420.9, -430.8, 6.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1060, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_76_7 = arg_73_1.actors_["10059"].transform
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = var_76_7.localPosition
				var_76_7.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 2)

				local var_76_9 = var_76_7.childCount

				for iter_76_1 = 0, var_76_9 - 1 do
					local var_76_10 = var_76_7:GetChild(iter_76_1)

					if var_76_10.name == "split_3" or not string.find(var_76_10.name, "split") then
						var_76_10.gameObject:SetActive(true)
					else
						var_76_10.gameObject:SetActive(false)
					end
				end
			end

			local var_76_11 = 0.001

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_8) / var_76_11
				local var_76_13 = Vector3.New(-390, -530, 35)

				var_76_7.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, var_76_13, var_76_12)
			end

			if arg_73_1.time_ >= var_76_8 + var_76_11 and arg_73_1.time_ < var_76_8 + var_76_11 + arg_76_0 then
				var_76_7.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_76_14 = arg_73_1.actors_["1060"]
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps1060 == nil then
				arg_73_1.var_.actorSpriteComps1060 = var_76_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_16 = 0.034

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_16 and not isNil(var_76_14) then
				local var_76_17 = (arg_73_1.time_ - var_76_15) / var_76_16

				if arg_73_1.var_.actorSpriteComps1060 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								local var_76_18 = Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, var_76_17)
								local var_76_19 = Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, var_76_17)
								local var_76_20 = Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, var_76_17)

								iter_76_3.color = Color.New(var_76_18, var_76_19, var_76_20)
							else
								local var_76_21 = Mathf.Lerp(iter_76_3.color.r, 0.5, var_76_17)

								iter_76_3.color = Color.New(var_76_21, var_76_21, var_76_21)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_15 + var_76_16 and arg_73_1.time_ < var_76_15 + var_76_16 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps1060 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_76_5 then
						if arg_73_1.isInRecall_ then
							iter_76_5.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1060 = nil
			end

			local var_76_22 = arg_73_1.actors_["10059"]
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_24 = 0.034

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 and not isNil(var_76_22) then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24

				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								local var_76_26 = Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor1.r, var_76_25)
								local var_76_27 = Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor1.g, var_76_25)
								local var_76_28 = Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor1.b, var_76_25)

								iter_76_7.color = Color.New(var_76_26, var_76_27, var_76_28)
							else
								local var_76_29 = Mathf.Lerp(iter_76_7.color.r, 1, var_76_25)

								iter_76_7.color = Color.New(var_76_29, var_76_29, var_76_29)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_9 then
						if arg_73_1.isInRecall_ then
							iter_76_9.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_30 = 0
			local var_76_31 = 0.825

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_32 = arg_73_1:FormatText(StoryNameCfg[596].name)

				arg_73_1.leftNameTxt_.text = var_76_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_33 = arg_73_1:GetWordFromCfg(410131018)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 33
				local var_76_36 = utf8.len(var_76_34)
				local var_76_37 = var_76_35 <= 0 and var_76_31 or var_76_31 * (var_76_36 / var_76_35)

				if var_76_37 > 0 and var_76_31 < var_76_37 then
					arg_73_1.talkMaxDuration = var_76_37

					if var_76_37 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_37 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_34
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131018", "story_v_out_410131.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_410131", "410131018", "story_v_out_410131.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_410131", "410131018", "story_v_out_410131.awb")

						arg_73_1:RecordAudio("410131018", var_76_39)
						arg_73_1:RecordAudio("410131018", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410131", "410131018", "story_v_out_410131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410131", "410131018", "story_v_out_410131.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_40 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_40 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_40

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_40 and arg_73_1.time_ < var_76_30 + var_76_40 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play410131019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410131019
		arg_77_1.duration_ = 8

		local var_77_0 = {
			zh = 6.166,
			ja = 8
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
				arg_77_0:Play410131020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.575

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[596].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(410131019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 23
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131019", "story_v_out_410131.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131019", "story_v_out_410131.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_410131", "410131019", "story_v_out_410131.awb")

						arg_77_1:RecordAudio("410131019", var_80_9)
						arg_77_1:RecordAudio("410131019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410131", "410131019", "story_v_out_410131.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410131", "410131019", "story_v_out_410131.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play410131020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410131020
		arg_81_1.duration_ = 5.87

		local var_81_0 = {
			zh = 5.566,
			ja = 5.866
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
				arg_81_0:Play410131021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.675

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[596].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(410131020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 27
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131020", "story_v_out_410131.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131020", "story_v_out_410131.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_410131", "410131020", "story_v_out_410131.awb")

						arg_81_1:RecordAudio("410131020", var_84_9)
						arg_81_1:RecordAudio("410131020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410131", "410131020", "story_v_out_410131.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410131", "410131020", "story_v_out_410131.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play410131021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410131021
		arg_85_1.duration_ = 8.77

		local var_85_0 = {
			zh = 3.033,
			ja = 8.766
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play410131022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10059"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10059 == nil then
				arg_85_1.var_.actorSpriteComps10059 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.034

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10059 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10059 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10059 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.4

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[36].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_11 = arg_85_1:GetWordFromCfg(410131021)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 16
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131021", "story_v_out_410131.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_410131", "410131021", "story_v_out_410131.awb") / 1000

					if var_88_16 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_8
					end

					if var_88_11.prefab_name ~= "" and arg_85_1.actors_[var_88_11.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_11.prefab_name].transform, "story_v_out_410131", "410131021", "story_v_out_410131.awb")

						arg_85_1:RecordAudio("410131021", var_88_17)
						arg_85_1:RecordAudio("410131021", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410131", "410131021", "story_v_out_410131.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410131", "410131021", "story_v_out_410131.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_18 and arg_85_1.time_ < var_88_8 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play410131022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410131022
		arg_89_1.duration_ = 3.13

		local var_89_0 = {
			zh = 1.466,
			ja = 3.133
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
				arg_89_0:Play410131023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10059"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10059 == nil then
				arg_89_1.var_.actorSpriteComps10059 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.034

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10059 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10059 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10059 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 0.15

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_10 = arg_89_1:FormatText(StoryNameCfg[596].name)

				arg_89_1.leftNameTxt_.text = var_92_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_11 = arg_89_1:GetWordFromCfg(410131022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 6
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_9 or var_92_9 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_9 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131022", "story_v_out_410131.awb") ~= 0 then
					local var_92_16 = manager.audio:GetVoiceLength("story_v_out_410131", "410131022", "story_v_out_410131.awb") / 1000

					if var_92_16 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_8
					end

					if var_92_11.prefab_name ~= "" and arg_89_1.actors_[var_92_11.prefab_name] ~= nil then
						local var_92_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_11.prefab_name].transform, "story_v_out_410131", "410131022", "story_v_out_410131.awb")

						arg_89_1:RecordAudio("410131022", var_92_17)
						arg_89_1:RecordAudio("410131022", var_92_17)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410131", "410131022", "story_v_out_410131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410131", "410131022", "story_v_out_410131.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_18 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_18 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_18

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_18 and arg_89_1.time_ < var_92_8 + var_92_18 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play410131023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410131023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play410131024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10059"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10059 == nil then
				arg_93_1.var_.actorSpriteComps10059 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10059 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10059 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10059 = nil
			end

			local var_96_8 = arg_93_1.actors_["1060"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos1060 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1060", 7)

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
				local var_96_14 = Vector3.New(0, -2000, -40)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1060, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_96_15 = arg_93_1.actors_["10059"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos10059 = var_96_15.localPosition
				var_96_15.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10059", 7)

				local var_96_17 = var_96_15.childCount

				for iter_96_5 = 0, var_96_17 - 1 do
					local var_96_18 = var_96_15:GetChild(iter_96_5)

					if var_96_18.name == "" or not string.find(var_96_18.name, "split") then
						var_96_18.gameObject:SetActive(true)
					else
						var_96_18.gameObject:SetActive(false)
					end
				end
			end

			local var_96_19 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_19 then
				local var_96_20 = (arg_93_1.time_ - var_96_16) / var_96_19
				local var_96_21 = Vector3.New(0, -2000, 35)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10059, var_96_21, var_96_20)
			end

			if arg_93_1.time_ >= var_96_16 + var_96_19 and arg_93_1.time_ < var_96_16 + var_96_19 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_96_22 = 0
			local var_96_23 = 1.35

			if var_96_22 < arg_93_1.time_ and arg_93_1.time_ <= var_96_22 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_24 = arg_93_1:GetWordFromCfg(410131023)
				local var_96_25 = arg_93_1:FormatText(var_96_24.content)

				arg_93_1.text_.text = var_96_25

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_26 = 54
				local var_96_27 = utf8.len(var_96_25)
				local var_96_28 = var_96_26 <= 0 and var_96_23 or var_96_23 * (var_96_27 / var_96_26)

				if var_96_28 > 0 and var_96_23 < var_96_28 then
					arg_93_1.talkMaxDuration = var_96_28

					if var_96_28 + var_96_22 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_28 + var_96_22
					end
				end

				arg_93_1.text_.text = var_96_25
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_29 = math.max(var_96_23, arg_93_1.talkMaxDuration)

			if var_96_22 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_29 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_22) / var_96_29

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_22 + var_96_29 and arg_93_1.time_ < var_96_22 + var_96_29 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410131024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410131024
		arg_97_1.duration_ = 2.53

		local var_97_0 = {
			zh = 1.3,
			ja = 2.533
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
				arg_97_0:Play410131025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1060"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1060 == nil then
				arg_97_1.var_.actorSpriteComps1060 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.034

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1060 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 1, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1060 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1060 = nil
			end

			local var_100_8 = arg_97_1.actors_["1060"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos1060 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1060", 3)

				local var_100_10 = var_100_8.childCount

				for iter_100_4 = 0, var_100_10 - 1 do
					local var_100_11 = var_100_8:GetChild(iter_100_4)

					if var_100_11.name == "" or not string.find(var_100_11.name, "split") then
						var_100_11.gameObject:SetActive(true)
					else
						var_100_11.gameObject:SetActive(false)
					end
				end
			end

			local var_100_12 = 0.001

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_12 then
				local var_100_13 = (arg_97_1.time_ - var_100_9) / var_100_12
				local var_100_14 = Vector3.New(33.4, -430.8, 6.9)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1060, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_100_15 = 0
			local var_100_16 = 0.15

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[584].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(410131024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 6
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131024", "story_v_out_410131.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_410131", "410131024", "story_v_out_410131.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_410131", "410131024", "story_v_out_410131.awb")

						arg_97_1:RecordAudio("410131024", var_100_24)
						arg_97_1:RecordAudio("410131024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410131", "410131024", "story_v_out_410131.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410131", "410131024", "story_v_out_410131.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play410131025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410131025
		arg_101_1.duration_ = 8.37

		local var_101_0 = {
			zh = 5.233,
			ja = 8.366
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
				arg_101_0:Play410131026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "1012"

			if arg_101_1.actors_[var_104_0] == nil then
				local var_104_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_104_1) then
					local var_104_2 = Object.Instantiate(var_104_1, arg_101_1.canvasGo_.transform)

					var_104_2.transform:SetSiblingIndex(1)

					var_104_2.name = var_104_0
					var_104_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_[var_104_0] = var_104_2

					local var_104_3 = var_104_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs(var_104_3) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_4 = arg_101_1.actors_["1012"].transform
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.var_.moveOldPos1012 = var_104_4.localPosition
				var_104_4.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1012", 2)

				local var_104_6 = var_104_4.childCount

				for iter_104_2 = 0, var_104_6 - 1 do
					local var_104_7 = var_104_4:GetChild(iter_104_2)

					if var_104_7.name == "split_2" or not string.find(var_104_7.name, "split") then
						var_104_7.gameObject:SetActive(true)
					else
						var_104_7.gameObject:SetActive(false)
					end
				end
			end

			local var_104_8 = 0.001

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_8 then
				local var_104_9 = (arg_101_1.time_ - var_104_5) / var_104_8
				local var_104_10 = Vector3.New(-390, -465, 300)

				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1012, var_104_10, var_104_9)
			end

			if arg_101_1.time_ >= var_104_5 + var_104_8 and arg_101_1.time_ < var_104_5 + var_104_8 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_104_11 = arg_101_1.actors_["1012"]
			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.actorSpriteComps1012 == nil then
				arg_101_1.var_.actorSpriteComps1012 = var_104_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_13 = 0.034

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_13 and not isNil(var_104_11) then
				local var_104_14 = (arg_101_1.time_ - var_104_12) / var_104_13

				if arg_101_1.var_.actorSpriteComps1012 then
					for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_104_4 then
							if arg_101_1.isInRecall_ then
								local var_104_15 = Mathf.Lerp(iter_104_4.color.r, arg_101_1.hightColor1.r, var_104_14)
								local var_104_16 = Mathf.Lerp(iter_104_4.color.g, arg_101_1.hightColor1.g, var_104_14)
								local var_104_17 = Mathf.Lerp(iter_104_4.color.b, arg_101_1.hightColor1.b, var_104_14)

								iter_104_4.color = Color.New(var_104_15, var_104_16, var_104_17)
							else
								local var_104_18 = Mathf.Lerp(iter_104_4.color.r, 1, var_104_14)

								iter_104_4.color = Color.New(var_104_18, var_104_18, var_104_18)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_12 + var_104_13 and arg_101_1.time_ < var_104_12 + var_104_13 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.actorSpriteComps1012 then
				for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_104_6 then
						if arg_101_1.isInRecall_ then
							iter_104_6.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1012 = nil
			end

			local var_104_19 = arg_101_1.actors_["1060"]
			local var_104_20 = 0

			if var_104_20 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 and not isNil(var_104_19) and arg_101_1.var_.actorSpriteComps1060 == nil then
				arg_101_1.var_.actorSpriteComps1060 = var_104_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_21 = 0.034

			if var_104_20 <= arg_101_1.time_ and arg_101_1.time_ < var_104_20 + var_104_21 and not isNil(var_104_19) then
				local var_104_22 = (arg_101_1.time_ - var_104_20) / var_104_21

				if arg_101_1.var_.actorSpriteComps1060 then
					for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_104_8 then
							if arg_101_1.isInRecall_ then
								local var_104_23 = Mathf.Lerp(iter_104_8.color.r, arg_101_1.hightColor2.r, var_104_22)
								local var_104_24 = Mathf.Lerp(iter_104_8.color.g, arg_101_1.hightColor2.g, var_104_22)
								local var_104_25 = Mathf.Lerp(iter_104_8.color.b, arg_101_1.hightColor2.b, var_104_22)

								iter_104_8.color = Color.New(var_104_23, var_104_24, var_104_25)
							else
								local var_104_26 = Mathf.Lerp(iter_104_8.color.r, 0.5, var_104_22)

								iter_104_8.color = Color.New(var_104_26, var_104_26, var_104_26)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_20 + var_104_21 and arg_101_1.time_ < var_104_20 + var_104_21 + arg_104_0 and not isNil(var_104_19) and arg_101_1.var_.actorSpriteComps1060 then
				for iter_104_9, iter_104_10 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_104_10 then
						if arg_101_1.isInRecall_ then
							iter_104_10.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1060 = nil
			end

			local var_104_27 = arg_101_1.actors_["1060"].transform
			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.var_.moveOldPos1060 = var_104_27.localPosition
				var_104_27.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1060", 4)

				local var_104_29 = var_104_27.childCount

				for iter_104_11 = 0, var_104_29 - 1 do
					local var_104_30 = var_104_27:GetChild(iter_104_11)

					if var_104_30.name == "split_1" or not string.find(var_104_30.name, "split") then
						var_104_30.gameObject:SetActive(true)
					else
						var_104_30.gameObject:SetActive(false)
					end
				end
			end

			local var_104_31 = 0.001

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_31 then
				local var_104_32 = (arg_101_1.time_ - var_104_28) / var_104_31
				local var_104_33 = Vector3.New(420.9, -430.8, 6.9)

				var_104_27.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1060, var_104_33, var_104_32)
			end

			if arg_101_1.time_ >= var_104_28 + var_104_31 and arg_101_1.time_ < var_104_28 + var_104_31 + arg_104_0 then
				var_104_27.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_104_34 = 0
			local var_104_35 = 0.725

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_36 = arg_101_1:FormatText(StoryNameCfg[595].name)

				arg_101_1.leftNameTxt_.text = var_104_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_37 = arg_101_1:GetWordFromCfg(410131025)
				local var_104_38 = arg_101_1:FormatText(var_104_37.content)

				arg_101_1.text_.text = var_104_38

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_39 = 29
				local var_104_40 = utf8.len(var_104_38)
				local var_104_41 = var_104_39 <= 0 and var_104_35 or var_104_35 * (var_104_40 / var_104_39)

				if var_104_41 > 0 and var_104_35 < var_104_41 then
					arg_101_1.talkMaxDuration = var_104_41

					if var_104_41 + var_104_34 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_41 + var_104_34
					end
				end

				arg_101_1.text_.text = var_104_38
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131025", "story_v_out_410131.awb") ~= 0 then
					local var_104_42 = manager.audio:GetVoiceLength("story_v_out_410131", "410131025", "story_v_out_410131.awb") / 1000

					if var_104_42 + var_104_34 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_42 + var_104_34
					end

					if var_104_37.prefab_name ~= "" and arg_101_1.actors_[var_104_37.prefab_name] ~= nil then
						local var_104_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_37.prefab_name].transform, "story_v_out_410131", "410131025", "story_v_out_410131.awb")

						arg_101_1:RecordAudio("410131025", var_104_43)
						arg_101_1:RecordAudio("410131025", var_104_43)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410131", "410131025", "story_v_out_410131.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410131", "410131025", "story_v_out_410131.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_44 = math.max(var_104_35, arg_101_1.talkMaxDuration)

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_44 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_34) / var_104_44

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_34 + var_104_44 and arg_101_1.time_ < var_104_34 + var_104_44 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410131026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410131026
		arg_105_1.duration_ = 2.73

		local var_105_0 = {
			zh = 1.1,
			ja = 2.733
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
				arg_105_0:Play410131027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.1

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[595].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(410131026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 4
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131026", "story_v_out_410131.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131026", "story_v_out_410131.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_410131", "410131026", "story_v_out_410131.awb")

						arg_105_1:RecordAudio("410131026", var_108_9)
						arg_105_1:RecordAudio("410131026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410131", "410131026", "story_v_out_410131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410131", "410131026", "story_v_out_410131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410131027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410131027
		arg_109_1.duration_ = 6.87

		local var_109_0 = {
			zh = 5,
			ja = 6.866
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
				arg_109_0:Play410131028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1060"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1060 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1060", 4)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_4" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(420.9, -430.8, 6.9)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1060, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_112_7 = arg_109_1.actors_["1060"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_15 = arg_109_1.actors_["1012"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1012 == nil then
				arg_109_1.var_.actorSpriteComps1012 = var_112_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_17 = 0.034

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.actorSpriteComps1012 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								local var_112_19 = Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor2.r, var_112_18)
								local var_112_20 = Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor2.g, var_112_18)
								local var_112_21 = Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor2.b, var_112_18)

								iter_112_6.color = Color.New(var_112_19, var_112_20, var_112_21)
							else
								local var_112_22 = Mathf.Lerp(iter_112_6.color.r, 0.5, var_112_18)

								iter_112_6.color = Color.New(var_112_22, var_112_22, var_112_22)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1012 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_112_8 then
						if arg_109_1.isInRecall_ then
							iter_112_8.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1012 = nil
			end

			local var_112_23 = 0
			local var_112_24 = 0.625

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[584].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(410131027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 25
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131027", "story_v_out_410131.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_410131", "410131027", "story_v_out_410131.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_410131", "410131027", "story_v_out_410131.awb")

						arg_109_1:RecordAudio("410131027", var_112_32)
						arg_109_1:RecordAudio("410131027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410131", "410131027", "story_v_out_410131.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410131", "410131027", "story_v_out_410131.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play410131028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410131028
		arg_113_1.duration_ = 8.6

		local var_113_0 = {
			zh = 3.166,
			ja = 8.6
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
				arg_113_0:Play410131029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1012"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1012 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1012", 2)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_1" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(-390, -465, 300)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1012, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_116_7 = arg_113_1.actors_["1012"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1012 == nil then
				arg_113_1.var_.actorSpriteComps1012 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps1012 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1012 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1012 = nil
			end

			local var_116_15 = arg_113_1.actors_["1060"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1060 == nil then
				arg_113_1.var_.actorSpriteComps1060 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps1060 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 0.5, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1060 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1060 = nil
			end

			local var_116_23 = 0
			local var_116_24 = 0.3

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[595].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(410131028)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 12
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131028", "story_v_out_410131.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_410131", "410131028", "story_v_out_410131.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_410131", "410131028", "story_v_out_410131.awb")

						arg_113_1:RecordAudio("410131028", var_116_32)
						arg_113_1:RecordAudio("410131028", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410131", "410131028", "story_v_out_410131.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410131", "410131028", "story_v_out_410131.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410131029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410131029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play410131030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1060"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1060 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1060", 7)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(0, -2000, -40)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1060, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_120_7 = arg_117_1.actors_["1012"].transform
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.var_.moveOldPos1012 = var_120_7.localPosition
				var_120_7.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1012", 7)

				local var_120_9 = var_120_7.childCount

				for iter_120_1 = 0, var_120_9 - 1 do
					local var_120_10 = var_120_7:GetChild(iter_120_1)

					if var_120_10.name == "" or not string.find(var_120_10.name, "split") then
						var_120_10.gameObject:SetActive(true)
					else
						var_120_10.gameObject:SetActive(false)
					end
				end
			end

			local var_120_11 = 0.001

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_8) / var_120_11
				local var_120_13 = Vector3.New(0, -2000, 300)

				var_120_7.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1012, var_120_13, var_120_12)
			end

			if arg_117_1.time_ >= var_120_8 + var_120_11 and arg_117_1.time_ < var_120_8 + var_120_11 + arg_120_0 then
				var_120_7.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_120_14 = arg_117_1.actors_["1060"]
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps1060 == nil then
				arg_117_1.var_.actorSpriteComps1060 = var_120_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_16 = 0.034

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 and not isNil(var_120_14) then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16

				if arg_117_1.var_.actorSpriteComps1060 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_18 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, var_120_17)
								local var_120_19 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, var_120_17)
								local var_120_20 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, var_120_17)

								iter_120_3.color = Color.New(var_120_18, var_120_19, var_120_20)
							else
								local var_120_21 = Mathf.Lerp(iter_120_3.color.r, 0.5, var_120_17)

								iter_120_3.color = Color.New(var_120_21, var_120_21, var_120_21)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps1060 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1060 = nil
			end

			local var_120_22 = 0
			local var_120_23 = 0.7

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_24 = arg_117_1:GetWordFromCfg(410131029)
				local var_120_25 = arg_117_1:FormatText(var_120_24.content)

				arg_117_1.text_.text = var_120_25

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_26 = 28
				local var_120_27 = utf8.len(var_120_25)
				local var_120_28 = var_120_26 <= 0 and var_120_23 or var_120_23 * (var_120_27 / var_120_26)

				if var_120_28 > 0 and var_120_23 < var_120_28 then
					arg_117_1.talkMaxDuration = var_120_28

					if var_120_28 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_25
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_29 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 <= arg_117_1.time_ and arg_117_1.time_ < var_120_22 + var_120_29 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_22) / var_120_29

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_22 + var_120_29 and arg_117_1.time_ < var_120_22 + var_120_29 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410131030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410131030
		arg_121_1.duration_ = 11.63

		local var_121_0 = {
			zh = 9.366,
			ja = 11.633
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
				arg_121_0:Play410131031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = "LZ0108"

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
				local var_124_5 = arg_121_1.bgs_.LZ0108

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
					if iter_124_0 ~= "LZ0108" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_17 = 2

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17
				local var_124_19 = Color.New(0, 0, 0)

				var_124_19.a = Mathf.Lerp(0, 1, var_124_18)
				arg_121_1.mask_.color = var_124_19
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				local var_124_20 = Color.New(0, 0, 0)

				var_124_20.a = 1
				arg_121_1.mask_.color = var_124_20
			end

			local var_124_21 = 2

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_22 = 2

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_22 then
				local var_124_23 = (arg_121_1.time_ - var_124_21) / var_124_22
				local var_124_24 = Color.New(0, 0, 0)

				var_124_24.a = Mathf.Lerp(1, 0, var_124_23)
				arg_121_1.mask_.color = var_124_24
			end

			if arg_121_1.time_ >= var_124_21 + var_124_22 and arg_121_1.time_ < var_124_21 + var_124_22 + arg_124_0 then
				local var_124_25 = Color.New(0, 0, 0)
				local var_124_26 = 0

				arg_121_1.mask_.enabled = false
				var_124_25.a = var_124_26
				arg_121_1.mask_.color = var_124_25
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_27 = 4
			local var_124_28 = 0.675

			if var_124_27 < arg_121_1.time_ and arg_121_1.time_ <= var_124_27 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_29 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_29:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_30 = arg_121_1:FormatText(StoryNameCfg[595].name)

				arg_121_1.leftNameTxt_.text = var_124_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_31 = arg_121_1:GetWordFromCfg(410131030)
				local var_124_32 = arg_121_1:FormatText(var_124_31.content)

				arg_121_1.text_.text = var_124_32

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_33 = 27
				local var_124_34 = utf8.len(var_124_32)
				local var_124_35 = var_124_33 <= 0 and var_124_28 or var_124_28 * (var_124_34 / var_124_33)

				if var_124_35 > 0 and var_124_28 < var_124_35 then
					arg_121_1.talkMaxDuration = var_124_35
					var_124_27 = var_124_27 + 0.3

					if var_124_35 + var_124_27 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_35 + var_124_27
					end
				end

				arg_121_1.text_.text = var_124_32
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131030", "story_v_out_410131.awb") ~= 0 then
					local var_124_36 = manager.audio:GetVoiceLength("story_v_out_410131", "410131030", "story_v_out_410131.awb") / 1000

					if var_124_36 + var_124_27 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_36 + var_124_27
					end

					if var_124_31.prefab_name ~= "" and arg_121_1.actors_[var_124_31.prefab_name] ~= nil then
						local var_124_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_31.prefab_name].transform, "story_v_out_410131", "410131030", "story_v_out_410131.awb")

						arg_121_1:RecordAudio("410131030", var_124_37)
						arg_121_1:RecordAudio("410131030", var_124_37)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410131", "410131030", "story_v_out_410131.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410131", "410131030", "story_v_out_410131.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_38 = var_124_27 + 0.3
			local var_124_39 = math.max(var_124_28, arg_121_1.talkMaxDuration)

			if var_124_38 <= arg_121_1.time_ and arg_121_1.time_ < var_124_38 + var_124_39 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_38) / var_124_39

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_38 + var_124_39 and arg_121_1.time_ < var_124_38 + var_124_39 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play410131031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410131031
		arg_127_1.duration_ = 19.67

		local var_127_0 = {
			zh = 13.333,
			ja = 19.666
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
				arg_127_0:Play410131032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 1.65

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[595].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(410131031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 66
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131031", "story_v_out_410131.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131031", "story_v_out_410131.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_410131", "410131031", "story_v_out_410131.awb")

						arg_127_1:RecordAudio("410131031", var_130_9)
						arg_127_1:RecordAudio("410131031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410131", "410131031", "story_v_out_410131.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410131", "410131031", "story_v_out_410131.awb")
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
	Play410131032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410131032
		arg_131_1.duration_ = 6.23

		local var_131_0 = {
			zh = 5,
			ja = 6.233
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
				arg_131_0:Play410131033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.55

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[595].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(410131032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131032", "story_v_out_410131.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131032", "story_v_out_410131.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_410131", "410131032", "story_v_out_410131.awb")

						arg_131_1:RecordAudio("410131032", var_134_9)
						arg_131_1:RecordAudio("410131032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410131", "410131032", "story_v_out_410131.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410131", "410131032", "story_v_out_410131.awb")
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
	Play410131033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410131033
		arg_135_1.duration_ = 1.9

		local var_135_0 = {
			zh = 0.999999999999,
			ja = 1.9
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
				arg_135_0:Play410131034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.125

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[596].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(410131033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131033", "story_v_out_410131.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131033", "story_v_out_410131.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_410131", "410131033", "story_v_out_410131.awb")

						arg_135_1:RecordAudio("410131033", var_138_9)
						arg_135_1:RecordAudio("410131033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410131", "410131033", "story_v_out_410131.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410131", "410131033", "story_v_out_410131.awb")
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

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410131034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410131034
		arg_139_1.duration_ = 2.87

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play410131035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.075

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[604].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3046")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(410131034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131034", "story_v_out_410131.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131034", "story_v_out_410131.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_410131", "410131034", "story_v_out_410131.awb")

						arg_139_1:RecordAudio("410131034", var_142_9)
						arg_139_1:RecordAudio("410131034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410131", "410131034", "story_v_out_410131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410131", "410131034", "story_v_out_410131.awb")
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
	Play410131035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410131035
		arg_143_1.duration_ = 11.07

		local var_143_0 = {
			zh = 4.366,
			ja = 11.066
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
				arg_143_0:Play410131036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.375

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[595].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(410131035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131035", "story_v_out_410131.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131035", "story_v_out_410131.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_410131", "410131035", "story_v_out_410131.awb")

						arg_143_1:RecordAudio("410131035", var_146_9)
						arg_143_1:RecordAudio("410131035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410131", "410131035", "story_v_out_410131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410131", "410131035", "story_v_out_410131.awb")
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
	Play410131036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410131036
		arg_147_1.duration_ = 5.8

		local var_147_0 = {
			zh = 1.833,
			ja = 5.8
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
				arg_147_0:Play410131037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.15

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[584].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(410131036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131036", "story_v_out_410131.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131036", "story_v_out_410131.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_410131", "410131036", "story_v_out_410131.awb")

						arg_147_1:RecordAudio("410131036", var_150_9)
						arg_147_1:RecordAudio("410131036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410131", "410131036", "story_v_out_410131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410131", "410131036", "story_v_out_410131.awb")
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
	Play410131037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410131037
		arg_151_1.duration_ = 8.1

		local var_151_0 = {
			zh = 3.533,
			ja = 8.1
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
				arg_151_0:Play410131038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.425

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[595].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(410131037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 17
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131037", "story_v_out_410131.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131037", "story_v_out_410131.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_410131", "410131037", "story_v_out_410131.awb")

						arg_151_1:RecordAudio("410131037", var_154_9)
						arg_151_1:RecordAudio("410131037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410131", "410131037", "story_v_out_410131.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410131", "410131037", "story_v_out_410131.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play410131038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410131038
		arg_155_1.duration_ = 9.07

		local var_155_0 = {
			zh = 6.833,
			ja = 9.066
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
			arg_155_1.auto_ = false
		end

		function arg_155_1.playNext_(arg_157_0)
			arg_155_1.onStoryFinished_()
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.925

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[595].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(410131038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 37
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410131", "410131038", "story_v_out_410131.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_410131", "410131038", "story_v_out_410131.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_410131", "410131038", "story_v_out_410131.awb")

						arg_155_1:RecordAudio("410131038", var_158_9)
						arg_155_1:RecordAudio("410131038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410131", "410131038", "story_v_out_410131.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410131", "410131038", "story_v_out_410131.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L04f",
		"TextureConfig/Background/LZ0108"
	},
	voices = {
		"story_v_out_410131.awb"
	}
}
