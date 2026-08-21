return {
	Play410211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST66"

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
				local var_4_5 = arg_1_1.bgs_.ST66

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
					if iter_4_0 ~= "ST66" then
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

			local var_4_22 = 0
			local var_4_23 = 0.166666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.3
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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
			local var_4_35 = 1.05

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(410211001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 42
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410211002
		arg_9_1.duration_ = 15.23

		local var_9_0 = {
			ja = 15.233,
			CriLanguages = 9.166,
			zh = 9.166
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1061"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

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

			local var_12_4 = arg_9_1.actors_["1061"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1061", 2)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(-390, -490, 18)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_12_11 = "10059"

			if arg_9_1.actors_[var_12_11] == nil then
				local var_12_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_12_12) then
					local var_12_13 = Object.Instantiate(var_12_12, arg_9_1.canvasGo_.transform)

					var_12_13.transform:SetSiblingIndex(1)

					var_12_13.name = var_12_11
					var_12_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_11] = var_12_13

					local var_12_14 = var_12_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_3, iter_12_4 in ipairs(var_12_14) do
							iter_12_4.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_15 = arg_9_1.actors_["10059"].transform
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.var_.moveOldPos10059 = var_12_15.localPosition
				var_12_15.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10059", 4)

				local var_12_17 = var_12_15.childCount

				for iter_12_5 = 0, var_12_17 - 1 do
					local var_12_18 = var_12_15:GetChild(iter_12_5)

					if var_12_18.name == "" or not string.find(var_12_18.name, "split") then
						var_12_18.gameObject:SetActive(true)
					else
						var_12_18.gameObject:SetActive(false)
					end
				end
			end

			local var_12_19 = 0.001

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_19 then
				local var_12_20 = (arg_9_1.time_ - var_12_16) / var_12_19
				local var_12_21 = Vector3.New(390, -530, 35)

				var_12_15.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10059, var_12_21, var_12_20)
			end

			if arg_9_1.time_ >= var_12_16 + var_12_19 and arg_9_1.time_ < var_12_16 + var_12_19 + arg_12_0 then
				var_12_15.localPosition = Vector3.New(390, -530, 35)
			end

			local var_12_22 = arg_9_1.actors_["1061"]
			local var_12_23 = 0

			if var_12_23 < arg_9_1.time_ and arg_9_1.time_ <= var_12_23 + arg_12_0 and not isNil(var_12_22) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_24 = 0.034

			if var_12_23 <= arg_9_1.time_ and arg_9_1.time_ < var_12_23 + var_12_24 and not isNil(var_12_22) then
				local var_12_25 = (arg_9_1.time_ - var_12_23) / var_12_24

				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								local var_12_26 = Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor1.r, var_12_25)
								local var_12_27 = Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor1.g, var_12_25)
								local var_12_28 = Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor1.b, var_12_25)

								iter_12_7.color = Color.New(var_12_26, var_12_27, var_12_28)
							else
								local var_12_29 = Mathf.Lerp(iter_12_7.color.r, 1, var_12_25)

								iter_12_7.color = Color.New(var_12_29, var_12_29, var_12_29)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_23 + var_12_24 and arg_9_1.time_ < var_12_23 + var_12_24 + arg_12_0 and not isNil(var_12_22) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_9 then
						if arg_9_1.isInRecall_ then
							iter_12_9.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_30 = arg_9_1.actors_["10059"]
			local var_12_31 = 0

			if var_12_31 < arg_9_1.time_ and arg_9_1.time_ <= var_12_31 + arg_12_0 and not isNil(var_12_30) and arg_9_1.var_.actorSpriteComps10059 == nil then
				arg_9_1.var_.actorSpriteComps10059 = var_12_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_32 = 0.034

			if var_12_31 <= arg_9_1.time_ and arg_9_1.time_ < var_12_31 + var_12_32 and not isNil(var_12_30) then
				local var_12_33 = (arg_9_1.time_ - var_12_31) / var_12_32

				if arg_9_1.var_.actorSpriteComps10059 then
					for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_12_11 then
							if arg_9_1.isInRecall_ then
								local var_12_34 = Mathf.Lerp(iter_12_11.color.r, arg_9_1.hightColor2.r, var_12_33)
								local var_12_35 = Mathf.Lerp(iter_12_11.color.g, arg_9_1.hightColor2.g, var_12_33)
								local var_12_36 = Mathf.Lerp(iter_12_11.color.b, arg_9_1.hightColor2.b, var_12_33)

								iter_12_11.color = Color.New(var_12_34, var_12_35, var_12_36)
							else
								local var_12_37 = Mathf.Lerp(iter_12_11.color.r, 0.5, var_12_33)

								iter_12_11.color = Color.New(var_12_37, var_12_37, var_12_37)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_31 + var_12_32 and arg_9_1.time_ < var_12_31 + var_12_32 + arg_12_0 and not isNil(var_12_30) and arg_9_1.var_.actorSpriteComps10059 then
				for iter_12_12, iter_12_13 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_12_13 then
						if arg_9_1.isInRecall_ then
							iter_12_13.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10059 = nil
			end

			local var_12_38 = 0
			local var_12_39 = 0.975

			if var_12_38 < arg_9_1.time_ and arg_9_1.time_ <= var_12_38 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_40 = arg_9_1:FormatText(StoryNameCfg[612].name)

				arg_9_1.leftNameTxt_.text = var_12_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_41 = arg_9_1:GetWordFromCfg(410211002)
				local var_12_42 = arg_9_1:FormatText(var_12_41.content)

				arg_9_1.text_.text = var_12_42

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_43 = 39
				local var_12_44 = utf8.len(var_12_42)
				local var_12_45 = var_12_43 <= 0 and var_12_39 or var_12_39 * (var_12_44 / var_12_43)

				if var_12_45 > 0 and var_12_39 < var_12_45 then
					arg_9_1.talkMaxDuration = var_12_45

					if var_12_45 + var_12_38 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_45 + var_12_38
					end
				end

				arg_9_1.text_.text = var_12_42
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") ~= 0 then
					local var_12_46 = manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") / 1000

					if var_12_46 + var_12_38 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_46 + var_12_38
					end

					if var_12_41.prefab_name ~= "" and arg_9_1.actors_[var_12_41.prefab_name] ~= nil then
						local var_12_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_41.prefab_name].transform, "story_v_out_410211", "410211002", "story_v_out_410211.awb")

						arg_9_1:RecordAudio("410211002", var_12_47)
						arg_9_1:RecordAudio("410211002", var_12_47)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410211", "410211002", "story_v_out_410211.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410211", "410211002", "story_v_out_410211.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_48 = math.max(var_12_39, arg_9_1.talkMaxDuration)

			if var_12_38 <= arg_9_1.time_ and arg_9_1.time_ < var_12_38 + var_12_48 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_38) / var_12_48

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_38 + var_12_48 and arg_9_1.time_ < var_12_38 + var_12_48 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_9_1:InitPlayNodeList()
	end,
	Play410211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410211003
		arg_13_1.duration_ = 1.9

		local var_13_0 = {
			ja = 1.6,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_13_0:Play410211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1061"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 2)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(-390, -490, 18)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_16_7 = arg_13_1.actors_["10059"].transform
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.var_.moveOldPos10059 = var_16_7.localPosition
				var_16_7.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10059", 4)

				local var_16_9 = var_16_7.childCount

				for iter_16_1 = 0, var_16_9 - 1 do
					local var_16_10 = var_16_7:GetChild(iter_16_1)

					if var_16_10.name == "" or not string.find(var_16_10.name, "split") then
						var_16_10.gameObject:SetActive(true)
					else
						var_16_10.gameObject:SetActive(false)
					end
				end
			end

			local var_16_11 = 0.001

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_11 then
				local var_16_12 = (arg_13_1.time_ - var_16_8) / var_16_11
				local var_16_13 = Vector3.New(390, -530, 35)

				var_16_7.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10059, var_16_13, var_16_12)
			end

			if arg_13_1.time_ >= var_16_8 + var_16_11 and arg_13_1.time_ < var_16_8 + var_16_11 + arg_16_0 then
				var_16_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_16_14 = arg_13_1.actors_["1061"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_16 = 0.034

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_18 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor2.r, var_16_17)
								local var_16_19 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor2.g, var_16_17)
								local var_16_20 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor2.b, var_16_17)

								iter_16_3.color = Color.New(var_16_18, var_16_19, var_16_20)
							else
								local var_16_21 = Mathf.Lerp(iter_16_3.color.r, 0.5, var_16_17)

								iter_16_3.color = Color.New(var_16_21, var_16_21, var_16_21)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_22 = arg_13_1.actors_["10059"]
			local var_16_23 = 0

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.actorSpriteComps10059 == nil then
				arg_13_1.var_.actorSpriteComps10059 = var_16_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_24 = 0.034

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_24 and not isNil(var_16_22) then
				local var_16_25 = (arg_13_1.time_ - var_16_23) / var_16_24

				if arg_13_1.var_.actorSpriteComps10059 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								local var_16_26 = Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor1.r, var_16_25)
								local var_16_27 = Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor1.g, var_16_25)
								local var_16_28 = Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor1.b, var_16_25)

								iter_16_7.color = Color.New(var_16_26, var_16_27, var_16_28)
							else
								local var_16_29 = Mathf.Lerp(iter_16_7.color.r, 1, var_16_25)

								iter_16_7.color = Color.New(var_16_29, var_16_29, var_16_29)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_23 + var_16_24 and arg_13_1.time_ < var_16_23 + var_16_24 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.actorSpriteComps10059 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_16_9 then
						if arg_13_1.isInRecall_ then
							iter_16_9.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10059 = nil
			end

			local var_16_30 = 0
			local var_16_31 = 0.15

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_32 = arg_13_1:FormatText(StoryNameCfg[596].name)

				arg_13_1.leftNameTxt_.text = var_16_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_33 = arg_13_1:GetWordFromCfg(410211003)
				local var_16_34 = arg_13_1:FormatText(var_16_33.content)

				arg_13_1.text_.text = var_16_34

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_35 = 6
				local var_16_36 = utf8.len(var_16_34)
				local var_16_37 = var_16_35 <= 0 and var_16_31 or var_16_31 * (var_16_36 / var_16_35)

				if var_16_37 > 0 and var_16_31 < var_16_37 then
					arg_13_1.talkMaxDuration = var_16_37

					if var_16_37 + var_16_30 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_37 + var_16_30
					end
				end

				arg_13_1.text_.text = var_16_34
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") ~= 0 then
					local var_16_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") / 1000

					if var_16_38 + var_16_30 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_38 + var_16_30
					end

					if var_16_33.prefab_name ~= "" and arg_13_1.actors_[var_16_33.prefab_name] ~= nil then
						local var_16_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_33.prefab_name].transform, "story_v_out_410211", "410211003", "story_v_out_410211.awb")

						arg_13_1:RecordAudio("410211003", var_16_39)
						arg_13_1:RecordAudio("410211003", var_16_39)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410211", "410211003", "story_v_out_410211.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410211", "410211003", "story_v_out_410211.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_40 = math.max(var_16_31, arg_13_1.talkMaxDuration)

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_40 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_30) / var_16_40

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_30 + var_16_40 and arg_13_1.time_ < var_16_30 + var_16_40 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play410211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410211004
		arg_17_1.duration_ = 17.5

		local var_17_0 = {
			ja = 17.5,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_17_0:Play410211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1061"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 2)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(-390, -490, 18)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_20_7 = arg_17_1.actors_["10059"].transform
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.var_.moveOldPos10059 = var_20_7.localPosition
				var_20_7.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10059", 4)

				local var_20_9 = var_20_7.childCount

				for iter_20_1 = 0, var_20_9 - 1 do
					local var_20_10 = var_20_7:GetChild(iter_20_1)

					if var_20_10.name == "" or not string.find(var_20_10.name, "split") then
						var_20_10.gameObject:SetActive(true)
					else
						var_20_10.gameObject:SetActive(false)
					end
				end
			end

			local var_20_11 = 0.001

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_8) / var_20_11
				local var_20_13 = Vector3.New(390, -530, 35)

				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10059, var_20_13, var_20_12)
			end

			if arg_17_1.time_ >= var_20_8 + var_20_11 and arg_17_1.time_ < var_20_8 + var_20_11 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_20_14 = arg_17_1.actors_["1061"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_16 = 0.034

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_18 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_17)
								local var_20_19 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_17)
								local var_20_20 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_17)

								iter_20_3.color = Color.New(var_20_18, var_20_19, var_20_20)
							else
								local var_20_21 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_17)

								iter_20_3.color = Color.New(var_20_21, var_20_21, var_20_21)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_22 = arg_17_1.actors_["10059"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps10059 == nil then
				arg_17_1.var_.actorSpriteComps10059 = var_20_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_24 = 0.034

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.actorSpriteComps10059 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_26 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_25)
								local var_20_27 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_25)
								local var_20_28 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_25)

								iter_20_7.color = Color.New(var_20_26, var_20_27, var_20_28)
							else
								local var_20_29 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_25)

								iter_20_7.color = Color.New(var_20_29, var_20_29, var_20_29)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps10059 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10059 = nil
			end

			local var_20_30 = 0
			local var_20_31 = 1.225

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(410211004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 49
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") ~= 0 then
					local var_20_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") / 1000

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end

					if var_20_33.prefab_name ~= "" and arg_17_1.actors_[var_20_33.prefab_name] ~= nil then
						local var_20_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_33.prefab_name].transform, "story_v_out_410211", "410211004", "story_v_out_410211.awb")

						arg_17_1:RecordAudio("410211004", var_20_39)
						arg_17_1:RecordAudio("410211004", var_20_39)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410211", "410211004", "story_v_out_410211.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410211", "410211004", "story_v_out_410211.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_40 and arg_17_1.time_ < var_20_30 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410211005
		arg_21_1.duration_ = 4.4

		local var_21_0 = {
			ja = 4.4,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_21_0:Play410211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1061"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 2)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(-390, -490, 18)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_24_7 = arg_21_1.actors_["10059"].transform
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.var_.moveOldPos10059 = var_24_7.localPosition
				var_24_7.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10059", 4)

				local var_24_9 = var_24_7.childCount

				for iter_24_1 = 0, var_24_9 - 1 do
					local var_24_10 = var_24_7:GetChild(iter_24_1)

					if var_24_10.name == "" or not string.find(var_24_10.name, "split") then
						var_24_10.gameObject:SetActive(true)
					else
						var_24_10.gameObject:SetActive(false)
					end
				end
			end

			local var_24_11 = 0.001

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_8) / var_24_11
				local var_24_13 = Vector3.New(390, -530, 35)

				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10059, var_24_13, var_24_12)
			end

			if arg_21_1.time_ >= var_24_8 + var_24_11 and arg_21_1.time_ < var_24_8 + var_24_11 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_24_14 = arg_21_1.actors_["1061"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_16 = 0.034

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_18 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor2.r, var_24_17)
								local var_24_19 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor2.g, var_24_17)
								local var_24_20 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor2.b, var_24_17)

								iter_24_3.color = Color.New(var_24_18, var_24_19, var_24_20)
							else
								local var_24_21 = Mathf.Lerp(iter_24_3.color.r, 0.5, var_24_17)

								iter_24_3.color = Color.New(var_24_21, var_24_21, var_24_21)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_22 = arg_21_1.actors_["10059"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_24 = 0.034

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								local var_24_26 = Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor1.r, var_24_25)
								local var_24_27 = Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor1.g, var_24_25)
								local var_24_28 = Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor1.b, var_24_25)

								iter_24_7.color = Color.New(var_24_26, var_24_27, var_24_28)
							else
								local var_24_29 = Mathf.Lerp(iter_24_7.color.r, 1, var_24_25)

								iter_24_7.color = Color.New(var_24_29, var_24_29, var_24_29)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 0.225

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[596].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(410211005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 9
				local var_24_36 = utf8.len(var_24_34)
				local var_24_37 = var_24_35 <= 0 and var_24_31 or var_24_31 * (var_24_36 / var_24_35)

				if var_24_37 > 0 and var_24_31 < var_24_37 then
					arg_21_1.talkMaxDuration = var_24_37

					if var_24_37 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_34
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_410211", "410211005", "story_v_out_410211.awb")

						arg_21_1:RecordAudio("410211005", var_24_39)
						arg_21_1:RecordAudio("410211005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410211", "410211005", "story_v_out_410211.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410211", "410211005", "story_v_out_410211.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_40 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_40 and arg_21_1.time_ < var_24_30 + var_24_40 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_21_1:InitPlayNodeList()
	end,
	Play410211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410211006
		arg_25_1.duration_ = 7.27

		local var_25_0 = {
			ja = 7.266,
			CriLanguages = 3.833,
			zh = 3.833
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
				arg_25_0:Play410211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1061"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-390, -490, 18)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_28_7 = arg_25_1.actors_["10059"].transform
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.var_.moveOldPos10059 = var_28_7.localPosition
				var_28_7.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10059", 4)

				local var_28_9 = var_28_7.childCount

				for iter_28_1 = 0, var_28_9 - 1 do
					local var_28_10 = var_28_7:GetChild(iter_28_1)

					if var_28_10.name == "" or not string.find(var_28_10.name, "split") then
						var_28_10.gameObject:SetActive(true)
					else
						var_28_10.gameObject:SetActive(false)
					end
				end
			end

			local var_28_11 = 0.001

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_8) / var_28_11
				local var_28_13 = Vector3.New(390, -530, 35)

				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10059, var_28_13, var_28_12)
			end

			if arg_25_1.time_ >= var_28_8 + var_28_11 and arg_25_1.time_ < var_28_8 + var_28_11 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_28_14 = arg_25_1.actors_["1061"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_16 = 0.034

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								local var_28_18 = Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, var_28_17)
								local var_28_19 = Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, var_28_17)
								local var_28_20 = Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, var_28_17)

								iter_28_3.color = Color.New(var_28_18, var_28_19, var_28_20)
							else
								local var_28_21 = Mathf.Lerp(iter_28_3.color.r, 1, var_28_17)

								iter_28_3.color = Color.New(var_28_21, var_28_21, var_28_21)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_5 then
						if arg_25_1.isInRecall_ then
							iter_28_5.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_22 = arg_25_1.actors_["10059"]
			local var_28_23 = 0

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_24 = 0.034

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_24 and not isNil(var_28_22) then
				local var_28_25 = (arg_25_1.time_ - var_28_23) / var_28_24

				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_28_7 then
							if arg_25_1.isInRecall_ then
								local var_28_26 = Mathf.Lerp(iter_28_7.color.r, arg_25_1.hightColor2.r, var_28_25)
								local var_28_27 = Mathf.Lerp(iter_28_7.color.g, arg_25_1.hightColor2.g, var_28_25)
								local var_28_28 = Mathf.Lerp(iter_28_7.color.b, arg_25_1.hightColor2.b, var_28_25)

								iter_28_7.color = Color.New(var_28_26, var_28_27, var_28_28)
							else
								local var_28_29 = Mathf.Lerp(iter_28_7.color.r, 0.5, var_28_25)

								iter_28_7.color = Color.New(var_28_29, var_28_29, var_28_29)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_23 + var_28_24 and arg_25_1.time_ < var_28_23 + var_28_24 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_9 then
						if arg_25_1.isInRecall_ then
							iter_28_9.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_30 = 0
			local var_28_31 = 0.475

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_32 = arg_25_1:FormatText(StoryNameCfg[612].name)

				arg_25_1.leftNameTxt_.text = var_28_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_33 = arg_25_1:GetWordFromCfg(410211006)
				local var_28_34 = arg_25_1:FormatText(var_28_33.content)

				arg_25_1.text_.text = var_28_34

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_35 = 19
				local var_28_36 = utf8.len(var_28_34)
				local var_28_37 = var_28_35 <= 0 and var_28_31 or var_28_31 * (var_28_36 / var_28_35)

				if var_28_37 > 0 and var_28_31 < var_28_37 then
					arg_25_1.talkMaxDuration = var_28_37

					if var_28_37 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_34
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") ~= 0 then
					local var_28_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") / 1000

					if var_28_38 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_38 + var_28_30
					end

					if var_28_33.prefab_name ~= "" and arg_25_1.actors_[var_28_33.prefab_name] ~= nil then
						local var_28_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_33.prefab_name].transform, "story_v_out_410211", "410211006", "story_v_out_410211.awb")

						arg_25_1:RecordAudio("410211006", var_28_39)
						arg_25_1:RecordAudio("410211006", var_28_39)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410211", "410211006", "story_v_out_410211.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410211", "410211006", "story_v_out_410211.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_40 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_40

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_40 and arg_25_1.time_ < var_28_30 + var_28_40 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play410211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410211007
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10060"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(var_32_1, arg_29_1.canvasGo_.transform)

					var_32_2.transform:SetSiblingIndex(1)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs(var_32_3) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["10060"].transform
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.var_.moveOldPos10060 = var_32_4.localPosition
				var_32_4.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10060", 4)

				local var_32_6 = var_32_4.childCount

				for iter_32_2 = 0, var_32_6 - 1 do
					local var_32_7 = var_32_4:GetChild(iter_32_2)

					if var_32_7.name == "" or not string.find(var_32_7.name, "split") then
						var_32_7.gameObject:SetActive(true)
					else
						var_32_7.gameObject:SetActive(false)
					end
				end
			end

			local var_32_8 = 0.001

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_8 then
				local var_32_9 = (arg_29_1.time_ - var_32_5) / var_32_8
				local var_32_10 = Vector3.New(390, -400, 0)

				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10060, var_32_10, var_32_9)
			end

			if arg_29_1.time_ >= var_32_5 + var_32_8 and arg_29_1.time_ < var_32_5 + var_32_8 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(390, -400, 0)
			end

			local var_32_11 = arg_29_1.actors_["10059"].transform
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.var_.moveOldPos10059 = var_32_11.localPosition
				var_32_11.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10059", 7)

				local var_32_13 = var_32_11.childCount

				for iter_32_3 = 0, var_32_13 - 1 do
					local var_32_14 = var_32_11:GetChild(iter_32_3)

					if var_32_14.name == "" or not string.find(var_32_14.name, "split") then
						var_32_14.gameObject:SetActive(true)
					else
						var_32_14.gameObject:SetActive(false)
					end
				end
			end

			local var_32_15 = 0.001

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_15 then
				local var_32_16 = (arg_29_1.time_ - var_32_12) / var_32_15
				local var_32_17 = Vector3.New(0, -2000, 35)

				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10059, var_32_17, var_32_16)
			end

			if arg_29_1.time_ >= var_32_12 + var_32_15 and arg_29_1.time_ < var_32_12 + var_32_15 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_32_18 = arg_29_1.actors_["10060"]
			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 and not isNil(var_32_18) and arg_29_1.var_.actorSpriteComps10060 == nil then
				arg_29_1.var_.actorSpriteComps10060 = var_32_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_20 = 0.034

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 and not isNil(var_32_18) then
				local var_32_21 = (arg_29_1.time_ - var_32_19) / var_32_20

				if arg_29_1.var_.actorSpriteComps10060 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_22 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, var_32_21)
								local var_32_23 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, var_32_21)
								local var_32_24 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, var_32_21)

								iter_32_5.color = Color.New(var_32_22, var_32_23, var_32_24)
							else
								local var_32_25 = Mathf.Lerp(iter_32_5.color.r, 1, var_32_21)

								iter_32_5.color = Color.New(var_32_25, var_32_25, var_32_25)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 and not isNil(var_32_18) and arg_29_1.var_.actorSpriteComps10060 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10060 = nil
			end

			local var_32_26 = arg_29_1.actors_["10059"]
			local var_32_27 = 0

			if var_32_27 < arg_29_1.time_ and arg_29_1.time_ <= var_32_27 + arg_32_0 and not isNil(var_32_26) and arg_29_1.var_.actorSpriteComps10059 == nil then
				arg_29_1.var_.actorSpriteComps10059 = var_32_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_28 = 0.034

			if var_32_27 <= arg_29_1.time_ and arg_29_1.time_ < var_32_27 + var_32_28 and not isNil(var_32_26) then
				local var_32_29 = (arg_29_1.time_ - var_32_27) / var_32_28

				if arg_29_1.var_.actorSpriteComps10059 then
					for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_32_9 then
							if arg_29_1.isInRecall_ then
								local var_32_30 = Mathf.Lerp(iter_32_9.color.r, arg_29_1.hightColor2.r, var_32_29)
								local var_32_31 = Mathf.Lerp(iter_32_9.color.g, arg_29_1.hightColor2.g, var_32_29)
								local var_32_32 = Mathf.Lerp(iter_32_9.color.b, arg_29_1.hightColor2.b, var_32_29)

								iter_32_9.color = Color.New(var_32_30, var_32_31, var_32_32)
							else
								local var_32_33 = Mathf.Lerp(iter_32_9.color.r, 0.5, var_32_29)

								iter_32_9.color = Color.New(var_32_33, var_32_33, var_32_33)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_27 + var_32_28 and arg_29_1.time_ < var_32_27 + var_32_28 + arg_32_0 and not isNil(var_32_26) and arg_29_1.var_.actorSpriteComps10059 then
				for iter_32_10, iter_32_11 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_32_11 then
						if arg_29_1.isInRecall_ then
							iter_32_11.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10059 = nil
			end

			local var_32_34 = arg_29_1.actors_["1061"]
			local var_32_35 = 0

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 and not isNil(var_32_34) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_36 = 0.034

			if var_32_35 <= arg_29_1.time_ and arg_29_1.time_ < var_32_35 + var_32_36 and not isNil(var_32_34) then
				local var_32_37 = (arg_29_1.time_ - var_32_35) / var_32_36

				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_12, iter_32_13 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_13 then
							if arg_29_1.isInRecall_ then
								local var_32_38 = Mathf.Lerp(iter_32_13.color.r, arg_29_1.hightColor2.r, var_32_37)
								local var_32_39 = Mathf.Lerp(iter_32_13.color.g, arg_29_1.hightColor2.g, var_32_37)
								local var_32_40 = Mathf.Lerp(iter_32_13.color.b, arg_29_1.hightColor2.b, var_32_37)

								iter_32_13.color = Color.New(var_32_38, var_32_39, var_32_40)
							else
								local var_32_41 = Mathf.Lerp(iter_32_13.color.r, 0.5, var_32_37)

								iter_32_13.color = Color.New(var_32_41, var_32_41, var_32_41)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_35 + var_32_36 and arg_29_1.time_ < var_32_35 + var_32_36 + arg_32_0 and not isNil(var_32_34) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_14, iter_32_15 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_15 then
						if arg_29_1.isInRecall_ then
							iter_32_15.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_15.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_42 = 0
			local var_32_43 = 0.05

			if var_32_42 < arg_29_1.time_ and arg_29_1.time_ <= var_32_42 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_44 = arg_29_1:FormatText(StoryNameCfg[597].name)

				arg_29_1.leftNameTxt_.text = var_32_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_45 = arg_29_1:GetWordFromCfg(410211007)
				local var_32_46 = arg_29_1:FormatText(var_32_45.content)

				arg_29_1.text_.text = var_32_46

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_47 = 2
				local var_32_48 = utf8.len(var_32_46)
				local var_32_49 = var_32_47 <= 0 and var_32_43 or var_32_43 * (var_32_48 / var_32_47)

				if var_32_49 > 0 and var_32_43 < var_32_49 then
					arg_29_1.talkMaxDuration = var_32_49

					if var_32_49 + var_32_42 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_49 + var_32_42
					end
				end

				arg_29_1.text_.text = var_32_46
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") ~= 0 then
					local var_32_50 = manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") / 1000

					if var_32_50 + var_32_42 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_50 + var_32_42
					end

					if var_32_45.prefab_name ~= "" and arg_29_1.actors_[var_32_45.prefab_name] ~= nil then
						local var_32_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_45.prefab_name].transform, "story_v_out_410211", "410211007", "story_v_out_410211.awb")

						arg_29_1:RecordAudio("410211007", var_32_51)
						arg_29_1:RecordAudio("410211007", var_32_51)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410211", "410211007", "story_v_out_410211.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410211", "410211007", "story_v_out_410211.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_52 = math.max(var_32_43, arg_29_1.talkMaxDuration)

			if var_32_42 <= arg_29_1.time_ and arg_29_1.time_ < var_32_42 + var_32_52 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_42) / var_32_52

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_42 + var_32_52 and arg_29_1.time_ < var_32_42 + var_32_52 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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

		arg_29_1:InitPlayNodeList()
	end,
	Play410211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410211008
		arg_33_1.duration_ = 5.07

		local var_33_0 = {
			ja = 5.066,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_33_0:Play410211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10060", 4)

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
				local var_36_6 = Vector3.New(390, -400, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_36_7 = arg_33_1.actors_["10060"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10060 == nil then
				arg_33_1.var_.actorSpriteComps10060 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10060 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.3

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[597].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410211008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410211", "410211008", "story_v_out_410211.awb")

						arg_33_1:RecordAudio("410211008", var_36_24)
						arg_33_1:RecordAudio("410211008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410211", "410211008", "story_v_out_410211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410211", "410211008", "story_v_out_410211.awb")
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
				actorName = "10060",
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
	Play410211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410211009
		arg_37_1.duration_ = 14.93

		local var_37_0 = {
			ja = 14.933,
			CriLanguages = 9,
			zh = 9
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
				arg_37_0:Play410211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1061"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 2)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_5" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-390, -490, 18)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_40_7 = arg_37_1.actors_["1061"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_15 = arg_37_1.actors_["10060"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps10060 == nil then
				arg_37_1.var_.actorSpriteComps10060 = var_40_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_17 = 0.034

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.actorSpriteComps10060 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_40_6 then
							if arg_37_1.isInRecall_ then
								local var_40_19 = Mathf.Lerp(iter_40_6.color.r, arg_37_1.hightColor2.r, var_40_18)
								local var_40_20 = Mathf.Lerp(iter_40_6.color.g, arg_37_1.hightColor2.g, var_40_18)
								local var_40_21 = Mathf.Lerp(iter_40_6.color.b, arg_37_1.hightColor2.b, var_40_18)

								iter_40_6.color = Color.New(var_40_19, var_40_20, var_40_21)
							else
								local var_40_22 = Mathf.Lerp(iter_40_6.color.r, 0.5, var_40_18)

								iter_40_6.color = Color.New(var_40_22, var_40_22, var_40_22)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps10060 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_40_8 then
						if arg_37_1.isInRecall_ then
							iter_40_8.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10060 = nil
			end

			local var_40_23 = 0
			local var_40_24 = 1

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_25 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:GetWordFromCfg(410211009)
				local var_40_27 = arg_37_1:FormatText(var_40_26.content)

				arg_37_1.text_.text = var_40_27

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 40
				local var_40_29 = utf8.len(var_40_27)
				local var_40_30 = var_40_28 <= 0 and var_40_24 or var_40_24 * (var_40_29 / var_40_28)

				if var_40_30 > 0 and var_40_24 < var_40_30 then
					arg_37_1.talkMaxDuration = var_40_30

					if var_40_30 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_30 + var_40_23
					end
				end

				arg_37_1.text_.text = var_40_27
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") ~= 0 then
					local var_40_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") / 1000

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end

					if var_40_26.prefab_name ~= "" and arg_37_1.actors_[var_40_26.prefab_name] ~= nil then
						local var_40_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_26.prefab_name].transform, "story_v_out_410211", "410211009", "story_v_out_410211.awb")

						arg_37_1:RecordAudio("410211009", var_40_32)
						arg_37_1:RecordAudio("410211009", var_40_32)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410211", "410211009", "story_v_out_410211.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410211", "410211009", "story_v_out_410211.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_33 = math.max(var_40_24, arg_37_1.talkMaxDuration)

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_33 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_23) / var_40_33

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_23 + var_40_33 and arg_37_1.time_ < var_40_23 + var_40_33 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410211010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play410211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10060"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10060 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10060", 7)

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
				local var_44_6 = Vector3.New(0, -2000, 18)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10060, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_44_7 = arg_41_1.actors_["10060"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10060 == nil then
				arg_41_1.var_.actorSpriteComps10060 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10060 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 0.5, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10060 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10060 = nil
			end

			local var_44_15 = arg_41_1.actors_["1061"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = var_44_15.localPosition
				var_44_15.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 7)

				local var_44_17 = var_44_15.childCount

				for iter_44_5 = 0, var_44_17 - 1 do
					local var_44_18 = var_44_15:GetChild(iter_44_5)

					if var_44_18.name == "" or not string.find(var_44_18.name, "split") then
						var_44_18.gameObject:SetActive(true)
					else
						var_44_18.gameObject:SetActive(false)
					end
				end
			end

			local var_44_19 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_19 then
				local var_44_20 = (arg_41_1.time_ - var_44_16) / var_44_19
				local var_44_21 = Vector3.New(0, -2000, 18)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, var_44_21, var_44_20)
			end

			if arg_41_1.time_ >= var_44_16 + var_44_19 and arg_41_1.time_ < var_44_16 + var_44_19 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_44_22 = 0
			local var_44_23 = 1.725

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_24 = arg_41_1:GetWordFromCfg(410211010)
				local var_44_25 = arg_41_1:FormatText(var_44_24.content)

				arg_41_1.text_.text = var_44_25

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_26 = 69
				local var_44_27 = utf8.len(var_44_25)
				local var_44_28 = var_44_26 <= 0 and var_44_23 or var_44_23 * (var_44_27 / var_44_26)

				if var_44_28 > 0 and var_44_23 < var_44_28 then
					arg_41_1.talkMaxDuration = var_44_28

					if var_44_28 + var_44_22 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_28 + var_44_22
					end
				end

				arg_41_1.text_.text = var_44_25
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_29 = math.max(var_44_23, arg_41_1.talkMaxDuration)

			if var_44_22 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_29 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_22) / var_44_29

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_22 + var_44_29 and arg_41_1.time_ < var_44_22 + var_44_29 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410211011
		arg_45_1.duration_ = 7.27

		local var_45_0 = {
			ja = 7.266,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_45_0:Play410211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10059"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10059 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10059", 4)

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
				local var_48_6 = Vector3.New(390, -530, 35)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10059, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_48_7 = arg_45_1.actors_["10059"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10059 == nil then
				arg_45_1.var_.actorSpriteComps10059 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10059 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10059 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10059 = nil
			end

			local var_48_15 = arg_45_1.actors_["1061"].transform
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = var_48_15.localPosition
				var_48_15.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 2)

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
				local var_48_21 = Vector3.New(-390, -490, 18)

				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, var_48_21, var_48_20)
			end

			if arg_45_1.time_ >= var_48_16 + var_48_19 and arg_45_1.time_ < var_48_16 + var_48_19 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_48_22 = arg_45_1.actors_["1061"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_24 = 0.034

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_26 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_25)
								local var_48_27 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_25)
								local var_48_28 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_25)

								iter_48_7.color = Color.New(var_48_26, var_48_27, var_48_28)
							else
								local var_48_29 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_25)

								iter_48_7.color = Color.New(var_48_29, var_48_29, var_48_29)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_30 = 0
			local var_48_31 = 0.8

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[596].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(410211011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 32
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_410211", "410211011", "story_v_out_410211.awb")

						arg_45_1:RecordAudio("410211011", var_48_39)
						arg_45_1:RecordAudio("410211011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410211", "410211011", "story_v_out_410211.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410211", "410211011", "story_v_out_410211.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410211012
		arg_49_1.duration_ = 15.8

		local var_49_0 = {
			ja = 15.8,
			CriLanguages = 7.433,
			zh = 7.433
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
				arg_49_0:Play410211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 2)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(-390, -490, 18)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_52_7 = arg_49_1.actors_["1061"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_15 = arg_49_1.actors_["10059"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10059 == nil then
				arg_49_1.var_.actorSpriteComps10059 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 0.034

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps10059 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								local var_52_19 = Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, var_52_18)
								local var_52_20 = Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, var_52_18)
								local var_52_21 = Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, var_52_18)

								iter_52_6.color = Color.New(var_52_19, var_52_20, var_52_21)
							else
								local var_52_22 = Mathf.Lerp(iter_52_6.color.r, 0.5, var_52_18)

								iter_52_6.color = Color.New(var_52_22, var_52_22, var_52_22)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10059 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10059 = nil
			end

			local var_52_23 = 0
			local var_52_24 = 0.85

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[612].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(410211012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 34
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_410211", "410211012", "story_v_out_410211.awb")

						arg_49_1:RecordAudio("410211012", var_52_32)
						arg_49_1:RecordAudio("410211012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410211", "410211012", "story_v_out_410211.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410211", "410211012", "story_v_out_410211.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410211013
		arg_53_1.duration_ = 6.73

		local var_53_0 = {
			ja = 6.733,
			CriLanguages = 4.333,
			zh = 4.333
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
				arg_53_0:Play410211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10059"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10059 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10059", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(390, -530, 35)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10059, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_56_7 = arg_53_1.actors_["10059"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10059 == nil then
				arg_53_1.var_.actorSpriteComps10059 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10059 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								local var_56_11 = Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, var_56_10)
								local var_56_12 = Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, var_56_10)
								local var_56_13 = Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, var_56_10)

								iter_56_2.color = Color.New(var_56_11, var_56_12, var_56_13)
							else
								local var_56_14 = Mathf.Lerp(iter_56_2.color.r, 1, var_56_10)

								iter_56_2.color = Color.New(var_56_14, var_56_14, var_56_14)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10059 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10059 = nil
			end

			local var_56_15 = arg_53_1.actors_["1061"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_17 = 0.034

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_6 then
							if arg_53_1.isInRecall_ then
								local var_56_19 = Mathf.Lerp(iter_56_6.color.r, arg_53_1.hightColor2.r, var_56_18)
								local var_56_20 = Mathf.Lerp(iter_56_6.color.g, arg_53_1.hightColor2.g, var_56_18)
								local var_56_21 = Mathf.Lerp(iter_56_6.color.b, arg_53_1.hightColor2.b, var_56_18)

								iter_56_6.color = Color.New(var_56_19, var_56_20, var_56_21)
							else
								local var_56_22 = Mathf.Lerp(iter_56_6.color.r, 0.5, var_56_18)

								iter_56_6.color = Color.New(var_56_22, var_56_22, var_56_22)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_8 then
						if arg_53_1.isInRecall_ then
							iter_56_8.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_23 = 0
			local var_56_24 = 0.5

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[596].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(410211013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 20
				local var_56_29 = utf8.len(var_56_27)
				local var_56_30 = var_56_28 <= 0 and var_56_24 or var_56_24 * (var_56_29 / var_56_28)

				if var_56_30 > 0 and var_56_24 < var_56_30 then
					arg_53_1.talkMaxDuration = var_56_30

					if var_56_30 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_23
					end
				end

				arg_53_1.text_.text = var_56_27
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_410211", "410211013", "story_v_out_410211.awb")

						arg_53_1:RecordAudio("410211013", var_56_32)
						arg_53_1:RecordAudio("410211013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410211", "410211013", "story_v_out_410211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410211", "410211013", "story_v_out_410211.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_33 = math.max(var_56_24, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_33 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_33

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_33 and arg_53_1.time_ < var_56_23 + var_56_33 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play410211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410211014
		arg_57_1.duration_ = 12.33

		local var_57_0 = {
			ja = 12.333,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_57_0:Play410211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10059"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10059 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10059", 4)

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
				local var_60_6 = Vector3.New(390, -530, 35)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10059, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -530, 35)
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
			local var_60_16 = 0.925

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

				local var_60_18 = arg_57_1:GetWordFromCfg(410211014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_410211", "410211014", "story_v_out_410211.awb")

						arg_57_1:RecordAudio("410211014", var_60_24)
						arg_57_1:RecordAudio("410211014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410211", "410211014", "story_v_out_410211.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410211", "410211014", "story_v_out_410211.awb")
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
	Play410211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410211015
		arg_61_1.duration_ = 3.9

		local var_61_0 = {
			ja = 3.9,
			CriLanguages = 3.4,
			zh = 3.4
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
				arg_61_0:Play410211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1061"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_5" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -490, 18)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_64_7 = arg_61_1.actors_["1061"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								local var_64_11 = Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, var_64_10)
								local var_64_12 = Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, var_64_10)
								local var_64_13 = Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, var_64_10)

								iter_64_2.color = Color.New(var_64_11, var_64_12, var_64_13)
							else
								local var_64_14 = Mathf.Lerp(iter_64_2.color.r, 1, var_64_10)

								iter_64_2.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_15 = arg_61_1.actors_["10059"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10059 == nil then
				arg_61_1.var_.actorSpriteComps10059 = var_64_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_17 = 0.034

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.actorSpriteComps10059 then
					for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_64_6 then
							if arg_61_1.isInRecall_ then
								local var_64_19 = Mathf.Lerp(iter_64_6.color.r, arg_61_1.hightColor2.r, var_64_18)
								local var_64_20 = Mathf.Lerp(iter_64_6.color.g, arg_61_1.hightColor2.g, var_64_18)
								local var_64_21 = Mathf.Lerp(iter_64_6.color.b, arg_61_1.hightColor2.b, var_64_18)

								iter_64_6.color = Color.New(var_64_19, var_64_20, var_64_21)
							else
								local var_64_22 = Mathf.Lerp(iter_64_6.color.r, 0.5, var_64_18)

								iter_64_6.color = Color.New(var_64_22, var_64_22, var_64_22)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10059 then
				for iter_64_7, iter_64_8 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_64_8 then
						if arg_61_1.isInRecall_ then
							iter_64_8.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10059 = nil
			end

			local var_64_23 = 0
			local var_64_24 = 0.25

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[612].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(410211015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 10
				local var_64_29 = utf8.len(var_64_27)
				local var_64_30 = var_64_28 <= 0 and var_64_24 or var_64_24 * (var_64_29 / var_64_28)

				if var_64_30 > 0 and var_64_24 < var_64_30 then
					arg_61_1.talkMaxDuration = var_64_30

					if var_64_30 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_23
					end
				end

				arg_61_1.text_.text = var_64_27
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_410211", "410211015", "story_v_out_410211.awb")

						arg_61_1:RecordAudio("410211015", var_64_32)
						arg_61_1:RecordAudio("410211015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410211", "410211015", "story_v_out_410211.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410211", "410211015", "story_v_out_410211.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_33 = math.max(var_64_24, arg_61_1.talkMaxDuration)

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_33 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_33

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_33 and arg_61_1.time_ < var_64_23 + var_64_33 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410211016
		arg_65_1.duration_ = 2.9

		local var_65_0 = {
			ja = 2.9,
			CriLanguages = 1.3,
			zh = 1.3
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
				arg_65_0:Play410211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10059"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(390, -530, 35)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_68_7 = arg_65_1.actors_["10059"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_15 = arg_65_1.actors_["1061"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.1

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[596].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(410211016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 4
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_410211", "410211016", "story_v_out_410211.awb")

						arg_65_1:RecordAudio("410211016", var_68_32)
						arg_65_1:RecordAudio("410211016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410211", "410211016", "story_v_out_410211.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410211", "410211016", "story_v_out_410211.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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
	Play410211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410211017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10059"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10059 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10059", 7)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(0, -2000, 35)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10059, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_72_7 = arg_69_1.actors_["1061"].transform
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_7.localPosition
				var_72_7.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 7)

				local var_72_9 = var_72_7.childCount

				for iter_72_1 = 0, var_72_9 - 1 do
					local var_72_10 = var_72_7:GetChild(iter_72_1)

					if var_72_10.name == "" or not string.find(var_72_10.name, "split") then
						var_72_10.gameObject:SetActive(true)
					else
						var_72_10.gameObject:SetActive(false)
					end
				end
			end

			local var_72_11 = 0.001

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_8) / var_72_11
				local var_72_13 = Vector3.New(0, -2000, 18)

				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, var_72_13, var_72_12)
			end

			if arg_69_1.time_ >= var_72_8 + var_72_11 and arg_69_1.time_ < var_72_8 + var_72_11 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_72_14 = 0
			local var_72_15 = 0.525

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(410211017)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 21
				local var_72_19 = utf8.len(var_72_17)
				local var_72_20 = var_72_18 <= 0 and var_72_15 or var_72_15 * (var_72_19 / var_72_18)

				if var_72_20 > 0 and var_72_15 < var_72_20 then
					arg_69_1.talkMaxDuration = var_72_20

					if var_72_20 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_14
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_15, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_21 and arg_69_1.time_ < var_72_14 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410211018
		arg_73_1.duration_ = 4.17

		local var_73_0 = {
			ja = 4.166,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_73_0:Play410211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10059"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 4)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(390, -530, 35)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_76_7 = arg_73_1.actors_["10059"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 1, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_15 = arg_73_1.actors_["1061"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061 = var_76_15.localPosition
				var_76_15.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1061", 2)

				local var_76_17 = var_76_15.childCount

				for iter_76_5 = 0, var_76_17 - 1 do
					local var_76_18 = var_76_15:GetChild(iter_76_5)

					if var_76_18.name == "" or not string.find(var_76_18.name, "split") then
						var_76_18.gameObject:SetActive(true)
					else
						var_76_18.gameObject:SetActive(false)
					end
				end
			end

			local var_76_19 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_19 then
				local var_76_20 = (arg_73_1.time_ - var_76_16) / var_76_19
				local var_76_21 = Vector3.New(-390, -490, 18)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061, var_76_21, var_76_20)
			end

			if arg_73_1.time_ >= var_76_16 + var_76_19 and arg_73_1.time_ < var_76_16 + var_76_19 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_76_22 = arg_73_1.actors_["1061"]
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps1061 == nil then
				arg_73_1.var_.actorSpriteComps1061 = var_76_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_24 = 0.034

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 and not isNil(var_76_22) then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24

				if arg_73_1.var_.actorSpriteComps1061 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								local var_76_26 = Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor2.r, var_76_25)
								local var_76_27 = Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor2.g, var_76_25)
								local var_76_28 = Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor2.b, var_76_25)

								iter_76_7.color = Color.New(var_76_26, var_76_27, var_76_28)
							else
								local var_76_29 = Mathf.Lerp(iter_76_7.color.r, 0.5, var_76_25)

								iter_76_7.color = Color.New(var_76_29, var_76_29, var_76_29)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps1061 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_76_9 then
						if arg_73_1.isInRecall_ then
							iter_76_9.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1061 = nil
			end

			local var_76_30 = 0
			local var_76_31 = 0.35

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

				local var_76_33 = arg_73_1:GetWordFromCfg(410211018)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_410211", "410211018", "story_v_out_410211.awb")

						arg_73_1:RecordAudio("410211018", var_76_39)
						arg_73_1:RecordAudio("410211018", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410211", "410211018", "story_v_out_410211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410211", "410211018", "story_v_out_410211.awb")
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
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410211019
		arg_77_1.duration_ = 12.5

		local var_77_0 = {
			ja = 12.5,
			CriLanguages = 8,
			zh = 8
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
				arg_77_0:Play410211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "ST64a"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 2

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.ST64a

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST64a" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_17 = 2

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Color.New(0, 0, 0)

				var_80_19.a = Mathf.Lerp(0, 1, var_80_18)
				arg_77_1.mask_.color = var_80_19
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				local var_80_20 = Color.New(0, 0, 0)

				var_80_20.a = 1
				arg_77_1.mask_.color = var_80_20
			end

			local var_80_21 = 2

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_22 = 2

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Color.New(0, 0, 0)

				var_80_24.a = Mathf.Lerp(1, 0, var_80_23)
				arg_77_1.mask_.color = var_80_24
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				local var_80_25 = Color.New(0, 0, 0)
				local var_80_26 = 0

				arg_77_1.mask_.enabled = false
				var_80_25.a = var_80_26
				arg_77_1.mask_.color = var_80_25
			end

			local var_80_27 = arg_77_1.actors_["1061"].transform
			local var_80_28 = 4

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = var_80_27.localPosition
				var_80_27.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 3)

				local var_80_29 = var_80_27.childCount

				for iter_80_2 = 0, var_80_29 - 1 do
					local var_80_30 = var_80_27:GetChild(iter_80_2)

					if var_80_30.name == "" or not string.find(var_80_30.name, "split") then
						var_80_30.gameObject:SetActive(true)
					else
						var_80_30.gameObject:SetActive(false)
					end
				end
			end

			local var_80_31 = 0.001

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_31 then
				local var_80_32 = (arg_77_1.time_ - var_80_28) / var_80_31
				local var_80_33 = Vector3.New(0, -490, 18)

				var_80_27.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, var_80_33, var_80_32)
			end

			if arg_77_1.time_ >= var_80_28 + var_80_31 and arg_77_1.time_ < var_80_28 + var_80_31 + arg_80_0 then
				var_80_27.localPosition = Vector3.New(0, -490, 18)
			end

			local var_80_34 = arg_77_1.actors_["1061"]
			local var_80_35 = 4

			if var_80_35 < arg_77_1.time_ and arg_77_1.time_ <= var_80_35 + arg_80_0 and not isNil(var_80_34) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_36 = 0.034

			if var_80_35 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_36 and not isNil(var_80_34) then
				local var_80_37 = (arg_77_1.time_ - var_80_35) / var_80_36

				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_4 then
							if arg_77_1.isInRecall_ then
								local var_80_38 = Mathf.Lerp(iter_80_4.color.r, arg_77_1.hightColor1.r, var_80_37)
								local var_80_39 = Mathf.Lerp(iter_80_4.color.g, arg_77_1.hightColor1.g, var_80_37)
								local var_80_40 = Mathf.Lerp(iter_80_4.color.b, arg_77_1.hightColor1.b, var_80_37)

								iter_80_4.color = Color.New(var_80_38, var_80_39, var_80_40)
							else
								local var_80_41 = Mathf.Lerp(iter_80_4.color.r, 1, var_80_37)

								iter_80_4.color = Color.New(var_80_41, var_80_41, var_80_41)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_35 + var_80_36 and arg_77_1.time_ < var_80_35 + var_80_36 + arg_80_0 and not isNil(var_80_34) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_6 then
						if arg_77_1.isInRecall_ then
							iter_80_6.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_42 = arg_77_1.actors_["10059"].transform
			local var_80_43 = 2

			if var_80_43 < arg_77_1.time_ and arg_77_1.time_ <= var_80_43 + arg_80_0 then
				arg_77_1.var_.moveOldPos10059 = var_80_42.localPosition
				var_80_42.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10059", 7)

				local var_80_44 = var_80_42.childCount

				for iter_80_7 = 0, var_80_44 - 1 do
					local var_80_45 = var_80_42:GetChild(iter_80_7)

					if var_80_45.name == "" or not string.find(var_80_45.name, "split") then
						var_80_45.gameObject:SetActive(true)
					else
						var_80_45.gameObject:SetActive(false)
					end
				end
			end

			local var_80_46 = 0.001

			if var_80_43 <= arg_77_1.time_ and arg_77_1.time_ < var_80_43 + var_80_46 then
				local var_80_47 = (arg_77_1.time_ - var_80_43) / var_80_46
				local var_80_48 = Vector3.New(0, -2000, 18)

				var_80_42.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10059, var_80_48, var_80_47)
			end

			if arg_77_1.time_ >= var_80_43 + var_80_46 and arg_77_1.time_ < var_80_43 + var_80_46 + arg_80_0 then
				var_80_42.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_80_49 = arg_77_1.actors_["1061"].transform
			local var_80_50 = 2

			if var_80_50 < arg_77_1.time_ and arg_77_1.time_ <= var_80_50 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = var_80_49.localPosition
				var_80_49.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 7)

				local var_80_51 = var_80_49.childCount

				for iter_80_8 = 0, var_80_51 - 1 do
					local var_80_52 = var_80_49:GetChild(iter_80_8)

					if var_80_52.name == "" or not string.find(var_80_52.name, "split") then
						var_80_52.gameObject:SetActive(true)
					else
						var_80_52.gameObject:SetActive(false)
					end
				end
			end

			local var_80_53 = 0.001

			if var_80_50 <= arg_77_1.time_ and arg_77_1.time_ < var_80_50 + var_80_53 then
				local var_80_54 = (arg_77_1.time_ - var_80_50) / var_80_53
				local var_80_55 = Vector3.New(0, -2000, 18)

				var_80_49.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, var_80_55, var_80_54)
			end

			if arg_77_1.time_ >= var_80_50 + var_80_53 and arg_77_1.time_ < var_80_50 + var_80_53 + arg_80_0 then
				var_80_49.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_80_56 = 2

			arg_77_1.isInRecall_ = false

			if var_80_56 < arg_77_1.time_ and arg_77_1.time_ <= var_80_56 + arg_80_0 then
				arg_77_1.screenFilterGo_:SetActive(true)

				arg_77_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_80_9, iter_80_10 in pairs(arg_77_1.actors_) do
					local var_80_57 = iter_80_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_80_11, iter_80_12 in ipairs(var_80_57) do
						if iter_80_12.color.r > 0.51 then
							iter_80_12.color = Color.New(1, 1, 1)
						else
							iter_80_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_80_58 = 0.0166666666666667

			if var_80_56 <= arg_77_1.time_ and arg_77_1.time_ < var_80_56 + var_80_58 then
				local var_80_59 = (arg_77_1.time_ - var_80_56) / var_80_58

				arg_77_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_80_59)
			end

			if arg_77_1.time_ >= var_80_56 + var_80_58 and arg_77_1.time_ < var_80_56 + var_80_58 + arg_80_0 then
				arg_77_1.screenFilterEffect_.weight = 1
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_60 = 4
			local var_80_61 = 0.475

			if var_80_60 < arg_77_1.time_ and arg_77_1.time_ <= var_80_60 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_62 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_62:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_63 = arg_77_1:FormatText(StoryNameCfg[612].name)

				arg_77_1.leftNameTxt_.text = var_80_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_64 = arg_77_1:GetWordFromCfg(410211019)
				local var_80_65 = arg_77_1:FormatText(var_80_64.content)

				arg_77_1.text_.text = var_80_65

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_66 = 19
				local var_80_67 = utf8.len(var_80_65)
				local var_80_68 = var_80_66 <= 0 and var_80_61 or var_80_61 * (var_80_67 / var_80_66)

				if var_80_68 > 0 and var_80_61 < var_80_68 then
					arg_77_1.talkMaxDuration = var_80_68
					var_80_60 = var_80_60 + 0.3

					if var_80_68 + var_80_60 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_68 + var_80_60
					end
				end

				arg_77_1.text_.text = var_80_65
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") ~= 0 then
					local var_80_69 = manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") / 1000

					if var_80_69 + var_80_60 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_69 + var_80_60
					end

					if var_80_64.prefab_name ~= "" and arg_77_1.actors_[var_80_64.prefab_name] ~= nil then
						local var_80_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_64.prefab_name].transform, "story_v_out_410211", "410211019", "story_v_out_410211.awb")

						arg_77_1:RecordAudio("410211019", var_80_70)
						arg_77_1:RecordAudio("410211019", var_80_70)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410211", "410211019", "story_v_out_410211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410211", "410211019", "story_v_out_410211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_71 = var_80_60 + 0.3
			local var_80_72 = math.max(var_80_61, arg_77_1.talkMaxDuration)

			if var_80_71 <= arg_77_1.time_ and arg_77_1.time_ < var_80_71 + var_80_72 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_71) / var_80_72

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_71 + var_80_72 and arg_77_1.time_ < var_80_71 + var_80_72 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410211020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410211020
		arg_83_1.duration_ = 8.6

		local var_83_0 = {
			ja = 6.166,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_83_0:Play410211021(arg_83_1)
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

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[612].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(410211020)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_410211", "410211020", "story_v_out_410211.awb")

						arg_83_1:RecordAudio("410211020", var_86_9)
						arg_83_1:RecordAudio("410211020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410211", "410211020", "story_v_out_410211.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410211", "410211020", "story_v_out_410211.awb")
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
	Play410211021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410211021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play410211022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1061"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = var_90_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_2 = 0.034

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_4 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor2.r, var_90_3)
								local var_90_5 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor2.g, var_90_3)
								local var_90_6 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor2.b, var_90_3)

								iter_90_1.color = Color.New(var_90_4, var_90_5, var_90_6)
							else
								local var_90_7 = Mathf.Lerp(iter_90_1.color.r, 0.5, var_90_3)

								iter_90_1.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_8 = 0
			local var_90_9 = 0.8

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(410211021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_12 = 32
				local var_90_13 = utf8.len(var_90_11)
				local var_90_14 = var_90_12 <= 0 and var_90_9 or var_90_9 * (var_90_13 / var_90_12)

				if var_90_14 > 0 and var_90_9 < var_90_14 then
					arg_87_1.talkMaxDuration = var_90_14

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_15 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_15 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_15

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_15 and arg_87_1.time_ < var_90_8 + var_90_15 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play410211022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410211022
		arg_91_1.duration_ = 9.87

		local var_91_0 = {
			ja = 8.8,
			CriLanguages = 9.866,
			zh = 9.866
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
				arg_91_0:Play410211023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1061"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1061 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1061", 3)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(0, -490, 18)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1061, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_94_7 = arg_91_1.actors_["1061"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								local var_94_11 = Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, var_94_10)
								local var_94_12 = Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, var_94_10)
								local var_94_13 = Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, var_94_10)

								iter_94_2.color = Color.New(var_94_11, var_94_12, var_94_13)
							else
								local var_94_14 = Mathf.Lerp(iter_94_2.color.r, 1, var_94_10)

								iter_94_2.color = Color.New(var_94_14, var_94_14, var_94_14)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_15 = 0
			local var_94_16 = 1.175

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[612].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(410211022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 47
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_out_410211", "410211022", "story_v_out_410211.awb")

						arg_91_1:RecordAudio("410211022", var_94_24)
						arg_91_1:RecordAudio("410211022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410211", "410211022", "story_v_out_410211.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410211", "410211022", "story_v_out_410211.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play410211023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410211023
		arg_95_1.duration_ = 12.03

		local var_95_0 = {
			ja = 12.033,
			CriLanguages = 11.533,
			zh = 11.533
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
				arg_95_0:Play410211024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1061"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 3)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(0, -490, 18)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_98_7 = arg_95_1.actors_["1061"]
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 0.034

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 and not isNil(var_98_7) then
				local var_98_10 = (arg_95_1.time_ - var_98_8) / var_98_9

				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								local var_98_11 = Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, var_98_10)
								local var_98_12 = Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, var_98_10)
								local var_98_13 = Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, var_98_10)

								iter_98_2.color = Color.New(var_98_11, var_98_12, var_98_13)
							else
								local var_98_14 = Mathf.Lerp(iter_98_2.color.r, 1, var_98_10)

								iter_98_2.color = Color.New(var_98_14, var_98_14, var_98_14)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_4 then
						if arg_95_1.isInRecall_ then
							iter_98_4.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_15 = 0
			local var_98_16 = 1.15

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[612].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(410211023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 46
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_410211", "410211023", "story_v_out_410211.awb")

						arg_95_1:RecordAudio("410211023", var_98_24)
						arg_95_1:RecordAudio("410211023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410211", "410211023", "story_v_out_410211.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410211", "410211023", "story_v_out_410211.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play410211024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410211024
		arg_99_1.duration_ = 4.93

		local var_99_0 = {
			ja = 4.933,
			CriLanguages = 3.666,
			zh = 3.666
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
				arg_99_0:Play410211025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1061"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.034

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 0.5, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_8 = 0
			local var_102_9 = 0.3

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_10 = arg_99_1:FormatText(StoryNameCfg[610].name)

				arg_99_1.leftNameTxt_.text = var_102_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_11 = arg_99_1:GetWordFromCfg(410211024)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 12
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_9 or var_102_9 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_9 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") / 1000

					if var_102_16 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_8
					end

					if var_102_11.prefab_name ~= "" and arg_99_1.actors_[var_102_11.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_11.prefab_name].transform, "story_v_out_410211", "410211024", "story_v_out_410211.awb")

						arg_99_1:RecordAudio("410211024", var_102_17)
						arg_99_1:RecordAudio("410211024", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410211", "410211024", "story_v_out_410211.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410211", "410211024", "story_v_out_410211.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_8) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_18 and arg_99_1.time_ < var_102_8 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play410211025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410211025
		arg_103_1.duration_ = 11.3

		local var_103_0 = {
			ja = 11.3,
			CriLanguages = 10.7,
			zh = 10.7
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410211026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1061"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1061 = var_106_0.localPosition
				var_106_0.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1061", 3)

				local var_106_2 = var_106_0.childCount

				for iter_106_0 = 0, var_106_2 - 1 do
					local var_106_3 = var_106_0:GetChild(iter_106_0)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_4 then
				local var_106_5 = (arg_103_1.time_ - var_106_1) / var_106_4
				local var_106_6 = Vector3.New(0, -490, 18)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1061, var_106_6, var_106_5)
			end

			if arg_103_1.time_ >= var_106_1 + var_106_4 and arg_103_1.time_ < var_106_1 + var_106_4 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_106_7 = arg_103_1.actors_["1061"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1061 == nil then
				arg_103_1.var_.actorSpriteComps1061 = var_106_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 0.034

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.actorSpriteComps1061 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								local var_106_11 = Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor1.r, var_106_10)
								local var_106_12 = Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor1.g, var_106_10)
								local var_106_13 = Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor1.b, var_106_10)

								iter_106_2.color = Color.New(var_106_11, var_106_12, var_106_13)
							else
								local var_106_14 = Mathf.Lerp(iter_106_2.color.r, 1, var_106_10)

								iter_106_2.color = Color.New(var_106_14, var_106_14, var_106_14)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1061 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_106_4 then
						if arg_103_1.isInRecall_ then
							iter_106_4.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1061 = nil
			end

			local var_106_15 = 0
			local var_106_16 = 1.225

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[612].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(410211025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 49
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_410211", "410211025", "story_v_out_410211.awb")

						arg_103_1:RecordAudio("410211025", var_106_24)
						arg_103_1:RecordAudio("410211025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410211", "410211025", "story_v_out_410211.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410211", "410211025", "story_v_out_410211.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play410211026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410211026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410211027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1061"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1061 == nil then
				arg_107_1.var_.actorSpriteComps1061 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.034

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps1061 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 0.5, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1061 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1061 = nil
			end

			local var_110_8 = 0
			local var_110_9 = 0.375

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(410211026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 15
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_9 or var_110_9 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_9 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_15 and arg_107_1.time_ < var_110_8 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410211027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410211027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410211028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.475

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(410211027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 59
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410211028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410211028
		arg_115_1.duration_ = 16.9

		local var_115_0 = {
			ja = 16.9,
			CriLanguages = 12.233,
			zh = 12.233
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play410211029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1061"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1061 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1061", 3)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(0, -490, 18)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1061, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_118_7 = arg_115_1.actors_["1061"]
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.034

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_9 and not isNil(var_118_7) then
				local var_118_10 = (arg_115_1.time_ - var_118_8) / var_118_9

				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								local var_118_11 = Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor1.r, var_118_10)
								local var_118_12 = Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor1.g, var_118_10)
								local var_118_13 = Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor1.b, var_118_10)

								iter_118_2.color = Color.New(var_118_11, var_118_12, var_118_13)
							else
								local var_118_14 = Mathf.Lerp(iter_118_2.color.r, 1, var_118_10)

								iter_118_2.color = Color.New(var_118_14, var_118_14, var_118_14)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_8 + var_118_9 and arg_115_1.time_ < var_118_8 + var_118_9 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_4 then
						if arg_115_1.isInRecall_ then
							iter_118_4.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_15 = 0
			local var_118_16 = 1.35

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[612].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(410211028)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 54
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_410211", "410211028", "story_v_out_410211.awb")

						arg_115_1:RecordAudio("410211028", var_118_24)
						arg_115_1:RecordAudio("410211028", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410211", "410211028", "story_v_out_410211.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410211", "410211028", "story_v_out_410211.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play410211029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410211029
		arg_119_1.duration_ = 12.07

		local var_119_0 = {
			ja = 12.066,
			CriLanguages = 11.3,
			zh = 11.3
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play410211030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1061"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -490, 18)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_122_7 = arg_119_1.actors_["1061"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.034

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 1, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 1.375

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[612].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(410211029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 55
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_410211", "410211029", "story_v_out_410211.awb")

						arg_119_1:RecordAudio("410211029", var_122_24)
						arg_119_1:RecordAudio("410211029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410211", "410211029", "story_v_out_410211.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410211", "410211029", "story_v_out_410211.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play410211030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410211030
		arg_123_1.duration_ = 6.07

		local var_123_0 = {
			ja = 6.066,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_123_0:Play410211031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1061"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1061 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1061", 3)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "split_5" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(0, -490, 18)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1061, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_126_7 = arg_123_1.actors_["1061"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.034

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								local var_126_11 = Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor1.r, var_126_10)
								local var_126_12 = Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor1.g, var_126_10)
								local var_126_13 = Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor1.b, var_126_10)

								iter_126_2.color = Color.New(var_126_11, var_126_12, var_126_13)
							else
								local var_126_14 = Mathf.Lerp(iter_126_2.color.r, 1, var_126_10)

								iter_126_2.color = Color.New(var_126_14, var_126_14, var_126_14)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_15 = 0
			local var_126_16 = 0.525

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[612].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(410211030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 21
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_410211", "410211030", "story_v_out_410211.awb")

						arg_123_1:RecordAudio("410211030", var_126_24)
						arg_123_1:RecordAudio("410211030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410211", "410211030", "story_v_out_410211.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410211", "410211030", "story_v_out_410211.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410211031
		arg_127_1.duration_ = 8.63

		local var_127_0 = {
			ja = 8.633,
			CriLanguages = 8.366,
			zh = 8.366
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
				arg_127_0:Play410211032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "10063"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10063")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(var_130_1, arg_127_1.canvasGo_.transform)

					var_130_2.transform:SetSiblingIndex(1)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_127_1.isInRecall_ then
						for iter_130_0, iter_130_1 in ipairs(var_130_3) do
							iter_130_1.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_130_4 = arg_127_1.actors_["10063"].transform
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.var_.moveOldPos10063 = var_130_4.localPosition
				var_130_4.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10063", 3)

				local var_130_6 = var_130_4.childCount

				for iter_130_2 = 0, var_130_6 - 1 do
					local var_130_7 = var_130_4:GetChild(iter_130_2)

					if var_130_7.name == "" or not string.find(var_130_7.name, "split") then
						var_130_7.gameObject:SetActive(true)
					else
						var_130_7.gameObject:SetActive(false)
					end
				end
			end

			local var_130_8 = 0.001

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_8 then
				local var_130_9 = (arg_127_1.time_ - var_130_5) / var_130_8
				local var_130_10 = Vector3.New(0, -535, -105)

				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10063, var_130_10, var_130_9)
			end

			if arg_127_1.time_ >= var_130_5 + var_130_8 and arg_127_1.time_ < var_130_5 + var_130_8 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, -535, -105)
			end

			local var_130_11 = arg_127_1.actors_["10063"]
			local var_130_12 = 0

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps10063 == nil then
				arg_127_1.var_.actorSpriteComps10063 = var_130_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_13 = 0.034

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_13 and not isNil(var_130_11) then
				local var_130_14 = (arg_127_1.time_ - var_130_12) / var_130_13

				if arg_127_1.var_.actorSpriteComps10063 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								local var_130_15 = Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor1.r, var_130_14)
								local var_130_16 = Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor1.g, var_130_14)
								local var_130_17 = Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor1.b, var_130_14)

								iter_130_4.color = Color.New(var_130_15, var_130_16, var_130_17)
							else
								local var_130_18 = Mathf.Lerp(iter_130_4.color.r, 1, var_130_14)

								iter_130_4.color = Color.New(var_130_18, var_130_18, var_130_18)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_12 + var_130_13 and arg_127_1.time_ < var_130_12 + var_130_13 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps10063 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_130_6 then
						if arg_127_1.isInRecall_ then
							iter_130_6.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10063 = nil
			end

			local var_130_19 = arg_127_1.actors_["1061"].transform
			local var_130_20 = 0

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1.var_.moveOldPos1061 = var_130_19.localPosition
				var_130_19.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1061", 7)

				local var_130_21 = var_130_19.childCount

				for iter_130_7 = 0, var_130_21 - 1 do
					local var_130_22 = var_130_19:GetChild(iter_130_7)

					if var_130_22.name == "" or not string.find(var_130_22.name, "split") then
						var_130_22.gameObject:SetActive(true)
					else
						var_130_22.gameObject:SetActive(false)
					end
				end
			end

			local var_130_23 = 0.001

			if var_130_20 <= arg_127_1.time_ and arg_127_1.time_ < var_130_20 + var_130_23 then
				local var_130_24 = (arg_127_1.time_ - var_130_20) / var_130_23
				local var_130_25 = Vector3.New(0, -2000, 18)

				var_130_19.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1061, var_130_25, var_130_24)
			end

			if arg_127_1.time_ >= var_130_20 + var_130_23 and arg_127_1.time_ < var_130_20 + var_130_23 + arg_130_0 then
				var_130_19.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_130_26 = 0
			local var_130_27 = 0.625

			if var_130_26 < arg_127_1.time_ and arg_127_1.time_ <= var_130_26 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_28 = arg_127_1:FormatText(StoryNameCfg[591].name)

				arg_127_1.leftNameTxt_.text = var_130_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_29 = arg_127_1:GetWordFromCfg(410211031)
				local var_130_30 = arg_127_1:FormatText(var_130_29.content)

				arg_127_1.text_.text = var_130_30

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_31 = 25
				local var_130_32 = utf8.len(var_130_30)
				local var_130_33 = var_130_31 <= 0 and var_130_27 or var_130_27 * (var_130_32 / var_130_31)

				if var_130_33 > 0 and var_130_27 < var_130_33 then
					arg_127_1.talkMaxDuration = var_130_33

					if var_130_33 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_33 + var_130_26
					end
				end

				arg_127_1.text_.text = var_130_30
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") ~= 0 then
					local var_130_34 = manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") / 1000

					if var_130_34 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_34 + var_130_26
					end

					if var_130_29.prefab_name ~= "" and arg_127_1.actors_[var_130_29.prefab_name] ~= nil then
						local var_130_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_29.prefab_name].transform, "story_v_out_410211", "410211031", "story_v_out_410211.awb")

						arg_127_1:RecordAudio("410211031", var_130_35)
						arg_127_1:RecordAudio("410211031", var_130_35)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410211", "410211031", "story_v_out_410211.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410211", "410211031", "story_v_out_410211.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_36 = math.max(var_130_27, arg_127_1.talkMaxDuration)

			if var_130_26 <= arg_127_1.time_ and arg_127_1.time_ < var_130_26 + var_130_36 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_26) / var_130_36

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_26 + var_130_36 and arg_127_1.time_ < var_130_26 + var_130_36 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play410211032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410211032
		arg_131_1.duration_ = 2.27

		local var_131_0 = {
			ja = 2.266,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_131_0:Play410211033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1061"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 3)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "split_2" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(0, -490, 18)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_134_7 = arg_131_1.actors_["1061"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								local var_134_11 = Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor1.r, var_134_10)
								local var_134_12 = Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor1.g, var_134_10)
								local var_134_13 = Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor1.b, var_134_10)

								iter_134_2.color = Color.New(var_134_11, var_134_12, var_134_13)
							else
								local var_134_14 = Mathf.Lerp(iter_134_2.color.r, 1, var_134_10)

								iter_134_2.color = Color.New(var_134_14, var_134_14, var_134_14)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_4 then
						if arg_131_1.isInRecall_ then
							iter_134_4.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_15 = arg_131_1.actors_["10063"].transform
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.var_.moveOldPos10063 = var_134_15.localPosition
				var_134_15.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10063", 7)

				local var_134_17 = var_134_15.childCount

				for iter_134_5 = 0, var_134_17 - 1 do
					local var_134_18 = var_134_15:GetChild(iter_134_5)

					if var_134_18.name == "" or not string.find(var_134_18.name, "split") then
						var_134_18.gameObject:SetActive(true)
					else
						var_134_18.gameObject:SetActive(false)
					end
				end
			end

			local var_134_19 = 0.001

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_19 then
				local var_134_20 = (arg_131_1.time_ - var_134_16) / var_134_19
				local var_134_21 = Vector3.New(0, -2000, -105)

				var_134_15.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10063, var_134_21, var_134_20)
			end

			if arg_131_1.time_ >= var_134_16 + var_134_19 and arg_131_1.time_ < var_134_16 + var_134_19 + arg_134_0 then
				var_134_15.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_134_22 = 0
			local var_134_23 = 0.1

			if var_134_22 < arg_131_1.time_ and arg_131_1.time_ <= var_134_22 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_24 = arg_131_1:FormatText(StoryNameCfg[612].name)

				arg_131_1.leftNameTxt_.text = var_134_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_25 = arg_131_1:GetWordFromCfg(410211032)
				local var_134_26 = arg_131_1:FormatText(var_134_25.content)

				arg_131_1.text_.text = var_134_26

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_27 = 4
				local var_134_28 = utf8.len(var_134_26)
				local var_134_29 = var_134_27 <= 0 and var_134_23 or var_134_23 * (var_134_28 / var_134_27)

				if var_134_29 > 0 and var_134_23 < var_134_29 then
					arg_131_1.talkMaxDuration = var_134_29

					if var_134_29 + var_134_22 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_22
					end
				end

				arg_131_1.text_.text = var_134_26
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") ~= 0 then
					local var_134_30 = manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") / 1000

					if var_134_30 + var_134_22 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_30 + var_134_22
					end

					if var_134_25.prefab_name ~= "" and arg_131_1.actors_[var_134_25.prefab_name] ~= nil then
						local var_134_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_25.prefab_name].transform, "story_v_out_410211", "410211032", "story_v_out_410211.awb")

						arg_131_1:RecordAudio("410211032", var_134_31)
						arg_131_1:RecordAudio("410211032", var_134_31)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410211", "410211032", "story_v_out_410211.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410211", "410211032", "story_v_out_410211.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_32 = math.max(var_134_23, arg_131_1.talkMaxDuration)

			if var_134_22 <= arg_131_1.time_ and arg_131_1.time_ < var_134_22 + var_134_32 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_22) / var_134_32

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_22 + var_134_32 and arg_131_1.time_ < var_134_22 + var_134_32 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play410211033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410211033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play410211034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1061"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.034

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 0.5, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 1.05

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(410211033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_12 = 42
				local var_138_13 = utf8.len(var_138_11)
				local var_138_14 = var_138_12 <= 0 and var_138_9 or var_138_9 * (var_138_13 / var_138_12)

				if var_138_14 > 0 and var_138_9 < var_138_14 then
					arg_135_1.talkMaxDuration = var_138_14

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_15 and arg_135_1.time_ < var_138_8 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410211034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410211034
		arg_139_1.duration_ = 12.23

		local var_139_0 = {
			ja = 12.233,
			CriLanguages = 9.933,
			zh = 9.933
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
				arg_139_0:Play410211035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1061"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1061 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1061", 3)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(0, -490, 18)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1061, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_142_7 = arg_139_1.actors_["1061"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1061 == nil then
				arg_139_1.var_.actorSpriteComps1061 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps1061 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 1, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1061 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1061 = nil
			end

			local var_142_15 = 0
			local var_142_16 = 0.975

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[612].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(410211034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_410211", "410211034", "story_v_out_410211.awb")

						arg_139_1:RecordAudio("410211034", var_142_24)
						arg_139_1:RecordAudio("410211034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410211", "410211034", "story_v_out_410211.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410211", "410211034", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410211035
		arg_143_1.duration_ = 19.6

		local var_143_0 = {
			ja = 19.6,
			CriLanguages = 12.6,
			zh = 12.6
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
				arg_143_0:Play410211036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1061"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1061 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1061", 3)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(0, -490, 18)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1061, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_146_7 = arg_143_1.actors_["1061"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1061 == nil then
				arg_143_1.var_.actorSpriteComps1061 = var_146_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.034

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.actorSpriteComps1061 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								local var_146_11 = Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, var_146_10)
								local var_146_12 = Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, var_146_10)
								local var_146_13 = Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, var_146_10)

								iter_146_2.color = Color.New(var_146_11, var_146_12, var_146_13)
							else
								local var_146_14 = Mathf.Lerp(iter_146_2.color.r, 1, var_146_10)

								iter_146_2.color = Color.New(var_146_14, var_146_14, var_146_14)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1061 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_146_4 then
						if arg_143_1.isInRecall_ then
							iter_146_4.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1061 = nil
			end

			local var_146_15 = 0
			local var_146_16 = 1.175

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_17 = arg_143_1:FormatText(StoryNameCfg[612].name)

				arg_143_1.leftNameTxt_.text = var_146_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_18 = arg_143_1:GetWordFromCfg(410211035)
				local var_146_19 = arg_143_1:FormatText(var_146_18.content)

				arg_143_1.text_.text = var_146_19

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 47
				local var_146_21 = utf8.len(var_146_19)
				local var_146_22 = var_146_20 <= 0 and var_146_16 or var_146_16 * (var_146_21 / var_146_20)

				if var_146_22 > 0 and var_146_16 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22

					if var_146_22 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_19
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") ~= 0 then
					local var_146_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") / 1000

					if var_146_23 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_23 + var_146_15
					end

					if var_146_18.prefab_name ~= "" and arg_143_1.actors_[var_146_18.prefab_name] ~= nil then
						local var_146_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_18.prefab_name].transform, "story_v_out_410211", "410211035", "story_v_out_410211.awb")

						arg_143_1:RecordAudio("410211035", var_146_24)
						arg_143_1:RecordAudio("410211035", var_146_24)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410211", "410211035", "story_v_out_410211.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410211", "410211035", "story_v_out_410211.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_25 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_25 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_25

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_25 and arg_143_1.time_ < var_146_15 + var_146_25 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play410211036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410211036
		arg_147_1.duration_ = 6.67

		local var_147_0 = {
			ja = 6.466,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_147_0:Play410211037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "L04i"

			if arg_147_1.bgs_[var_150_0] == nil then
				local var_150_1 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_150_0)
				var_150_1.name = var_150_0
				var_150_1.transform.parent = arg_147_1.stage_.transform
				var_150_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_[var_150_0] = var_150_1
			end

			local var_150_2 = 2

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				local var_150_3 = manager.ui.mainCamera.transform.localPosition
				local var_150_4 = Vector3.New(0, 0, 10) + Vector3.New(var_150_3.x, var_150_3.y, 0)
				local var_150_5 = arg_147_1.bgs_.L04i

				var_150_5.transform.localPosition = var_150_4
				var_150_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_6 = var_150_5:GetComponent("SpriteRenderer")

				if var_150_6 and var_150_6.sprite then
					local var_150_7 = (var_150_5.transform.localPosition - var_150_3).z
					local var_150_8 = manager.ui.mainCameraCom_
					local var_150_9 = 2 * var_150_7 * Mathf.Tan(var_150_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_150_10 = var_150_9 * var_150_8.aspect
					local var_150_11 = var_150_6.sprite.bounds.size.x
					local var_150_12 = var_150_6.sprite.bounds.size.y
					local var_150_13 = var_150_10 / var_150_11
					local var_150_14 = var_150_9 / var_150_12
					local var_150_15 = var_150_14 < var_150_13 and var_150_13 or var_150_14

					var_150_5.transform.localScale = Vector3.New(var_150_15, var_150_15, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "L04i" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_17 = 2

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Color.New(0, 0, 0)

				var_150_19.a = Mathf.Lerp(0, 1, var_150_18)
				arg_147_1.mask_.color = var_150_19
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				local var_150_20 = Color.New(0, 0, 0)

				var_150_20.a = 1
				arg_147_1.mask_.color = var_150_20
			end

			local var_150_21 = 2

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_22 = 2

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_22 then
				local var_150_23 = (arg_147_1.time_ - var_150_21) / var_150_22
				local var_150_24 = Color.New(0, 0, 0)

				var_150_24.a = Mathf.Lerp(1, 0, var_150_23)
				arg_147_1.mask_.color = var_150_24
			end

			if arg_147_1.time_ >= var_150_21 + var_150_22 and arg_147_1.time_ < var_150_21 + var_150_22 + arg_150_0 then
				local var_150_25 = Color.New(0, 0, 0)
				local var_150_26 = 0

				arg_147_1.mask_.enabled = false
				var_150_25.a = var_150_26
				arg_147_1.mask_.color = var_150_25
			end

			local var_150_27 = arg_147_1.actors_["1061"].transform
			local var_150_28 = 4

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_27.localPosition
				var_150_27.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 2)

				local var_150_29 = var_150_27.childCount

				for iter_150_2 = 0, var_150_29 - 1 do
					local var_150_30 = var_150_27:GetChild(iter_150_2)

					if var_150_30.name == "" or not string.find(var_150_30.name, "split") then
						var_150_30.gameObject:SetActive(true)
					else
						var_150_30.gameObject:SetActive(false)
					end
				end
			end

			local var_150_31 = 0.001

			if var_150_28 <= arg_147_1.time_ and arg_147_1.time_ < var_150_28 + var_150_31 then
				local var_150_32 = (arg_147_1.time_ - var_150_28) / var_150_31
				local var_150_33 = Vector3.New(-390, -490, 18)

				var_150_27.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, var_150_33, var_150_32)
			end

			if arg_147_1.time_ >= var_150_28 + var_150_31 and arg_147_1.time_ < var_150_28 + var_150_31 + arg_150_0 then
				var_150_27.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_150_34 = arg_147_1.actors_["10059"].transform
			local var_150_35 = 4

			if var_150_35 < arg_147_1.time_ and arg_147_1.time_ <= var_150_35 + arg_150_0 then
				arg_147_1.var_.moveOldPos10059 = var_150_34.localPosition
				var_150_34.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10059", 4)

				local var_150_36 = var_150_34.childCount

				for iter_150_3 = 0, var_150_36 - 1 do
					local var_150_37 = var_150_34:GetChild(iter_150_3)

					if var_150_37.name == "" or not string.find(var_150_37.name, "split") then
						var_150_37.gameObject:SetActive(true)
					else
						var_150_37.gameObject:SetActive(false)
					end
				end
			end

			local var_150_38 = 0.001

			if var_150_35 <= arg_147_1.time_ and arg_147_1.time_ < var_150_35 + var_150_38 then
				local var_150_39 = (arg_147_1.time_ - var_150_35) / var_150_38
				local var_150_40 = Vector3.New(390, -530, 35)

				var_150_34.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10059, var_150_40, var_150_39)
			end

			if arg_147_1.time_ >= var_150_35 + var_150_38 and arg_147_1.time_ < var_150_35 + var_150_38 + arg_150_0 then
				var_150_34.localPosition = Vector3.New(390, -530, 35)
			end

			local var_150_41 = arg_147_1.actors_["10063"].transform
			local var_150_42 = 4

			if var_150_42 < arg_147_1.time_ and arg_147_1.time_ <= var_150_42 + arg_150_0 then
				arg_147_1.var_.moveOldPos10063 = var_150_41.localPosition
				var_150_41.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10063", 7)

				local var_150_43 = var_150_41.childCount

				for iter_150_4 = 0, var_150_43 - 1 do
					local var_150_44 = var_150_41:GetChild(iter_150_4)

					if var_150_44.name == "" or not string.find(var_150_44.name, "split") then
						var_150_44.gameObject:SetActive(true)
					else
						var_150_44.gameObject:SetActive(false)
					end
				end
			end

			local var_150_45 = 0.001

			if var_150_42 <= arg_147_1.time_ and arg_147_1.time_ < var_150_42 + var_150_45 then
				local var_150_46 = (arg_147_1.time_ - var_150_42) / var_150_45
				local var_150_47 = Vector3.New(0, -2000, -105)

				var_150_41.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10063, var_150_47, var_150_46)
			end

			if arg_147_1.time_ >= var_150_42 + var_150_45 and arg_147_1.time_ < var_150_42 + var_150_45 + arg_150_0 then
				var_150_41.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_150_48 = arg_147_1.actors_["1061"]
			local var_150_49 = 4

			if var_150_49 < arg_147_1.time_ and arg_147_1.time_ <= var_150_49 + arg_150_0 and not isNil(var_150_48) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_50 = 0.034

			if var_150_49 <= arg_147_1.time_ and arg_147_1.time_ < var_150_49 + var_150_50 and not isNil(var_150_48) then
				local var_150_51 = (arg_147_1.time_ - var_150_49) / var_150_50

				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_150_6 then
							if arg_147_1.isInRecall_ then
								local var_150_52 = Mathf.Lerp(iter_150_6.color.r, arg_147_1.hightColor1.r, var_150_51)
								local var_150_53 = Mathf.Lerp(iter_150_6.color.g, arg_147_1.hightColor1.g, var_150_51)
								local var_150_54 = Mathf.Lerp(iter_150_6.color.b, arg_147_1.hightColor1.b, var_150_51)

								iter_150_6.color = Color.New(var_150_52, var_150_53, var_150_54)
							else
								local var_150_55 = Mathf.Lerp(iter_150_6.color.r, 1, var_150_51)

								iter_150_6.color = Color.New(var_150_55, var_150_55, var_150_55)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_49 + var_150_50 and arg_147_1.time_ < var_150_49 + var_150_50 + arg_150_0 and not isNil(var_150_48) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_8 then
						if arg_147_1.isInRecall_ then
							iter_150_8.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_56 = arg_147_1.actors_["10059"]
			local var_150_57 = 4

			if var_150_57 < arg_147_1.time_ and arg_147_1.time_ <= var_150_57 + arg_150_0 and not isNil(var_150_56) and arg_147_1.var_.actorSpriteComps10059 == nil then
				arg_147_1.var_.actorSpriteComps10059 = var_150_56:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_58 = 0.034

			if var_150_57 <= arg_147_1.time_ and arg_147_1.time_ < var_150_57 + var_150_58 and not isNil(var_150_56) then
				local var_150_59 = (arg_147_1.time_ - var_150_57) / var_150_58

				if arg_147_1.var_.actorSpriteComps10059 then
					for iter_150_9, iter_150_10 in pairs(arg_147_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_150_10 then
							if arg_147_1.isInRecall_ then
								local var_150_60 = Mathf.Lerp(iter_150_10.color.r, arg_147_1.hightColor2.r, var_150_59)
								local var_150_61 = Mathf.Lerp(iter_150_10.color.g, arg_147_1.hightColor2.g, var_150_59)
								local var_150_62 = Mathf.Lerp(iter_150_10.color.b, arg_147_1.hightColor2.b, var_150_59)

								iter_150_10.color = Color.New(var_150_60, var_150_61, var_150_62)
							else
								local var_150_63 = Mathf.Lerp(iter_150_10.color.r, 0.5, var_150_59)

								iter_150_10.color = Color.New(var_150_63, var_150_63, var_150_63)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_57 + var_150_58 and arg_147_1.time_ < var_150_57 + var_150_58 + arg_150_0 and not isNil(var_150_56) and arg_147_1.var_.actorSpriteComps10059 then
				for iter_150_11, iter_150_12 in pairs(arg_147_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_150_12 then
						if arg_147_1.isInRecall_ then
							iter_150_12.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10059 = nil
			end

			local var_150_64 = arg_147_1.actors_["10063"]
			local var_150_65 = 4

			if var_150_65 < arg_147_1.time_ and arg_147_1.time_ <= var_150_65 + arg_150_0 and not isNil(var_150_64) and arg_147_1.var_.actorSpriteComps10063 == nil then
				arg_147_1.var_.actorSpriteComps10063 = var_150_64:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_66 = 0.034

			if var_150_65 <= arg_147_1.time_ and arg_147_1.time_ < var_150_65 + var_150_66 and not isNil(var_150_64) then
				local var_150_67 = (arg_147_1.time_ - var_150_65) / var_150_66

				if arg_147_1.var_.actorSpriteComps10063 then
					for iter_150_13, iter_150_14 in pairs(arg_147_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_150_14 then
							if arg_147_1.isInRecall_ then
								local var_150_68 = Mathf.Lerp(iter_150_14.color.r, arg_147_1.hightColor2.r, var_150_67)
								local var_150_69 = Mathf.Lerp(iter_150_14.color.g, arg_147_1.hightColor2.g, var_150_67)
								local var_150_70 = Mathf.Lerp(iter_150_14.color.b, arg_147_1.hightColor2.b, var_150_67)

								iter_150_14.color = Color.New(var_150_68, var_150_69, var_150_70)
							else
								local var_150_71 = Mathf.Lerp(iter_150_14.color.r, 0.5, var_150_67)

								iter_150_14.color = Color.New(var_150_71, var_150_71, var_150_71)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_65 + var_150_66 and arg_147_1.time_ < var_150_65 + var_150_66 + arg_150_0 and not isNil(var_150_64) and arg_147_1.var_.actorSpriteComps10063 then
				for iter_150_15, iter_150_16 in pairs(arg_147_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_150_16 then
						if arg_147_1.isInRecall_ then
							iter_150_16.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_16.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10063 = nil
			end

			local var_150_72 = arg_147_1.actors_["1061"].transform
			local var_150_73 = 2

			if var_150_73 < arg_147_1.time_ and arg_147_1.time_ <= var_150_73 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_72.localPosition
				var_150_72.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 7)

				local var_150_74 = var_150_72.childCount

				for iter_150_17 = 0, var_150_74 - 1 do
					local var_150_75 = var_150_72:GetChild(iter_150_17)

					if var_150_75.name == "" or not string.find(var_150_75.name, "split") then
						var_150_75.gameObject:SetActive(true)
					else
						var_150_75.gameObject:SetActive(false)
					end
				end
			end

			local var_150_76 = 0.001

			if var_150_73 <= arg_147_1.time_ and arg_147_1.time_ < var_150_73 + var_150_76 then
				local var_150_77 = (arg_147_1.time_ - var_150_73) / var_150_76
				local var_150_78 = Vector3.New(0, -2000, 18)

				var_150_72.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, var_150_78, var_150_77)
			end

			if arg_147_1.time_ >= var_150_73 + var_150_76 and arg_147_1.time_ < var_150_73 + var_150_76 + arg_150_0 then
				var_150_72.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_150_79 = 4

			arg_147_1.isInRecall_ = false

			if var_150_79 < arg_147_1.time_ and arg_147_1.time_ <= var_150_79 + arg_150_0 then
				arg_147_1.screenFilterGo_:SetActive(false)

				for iter_150_18, iter_150_19 in pairs(arg_147_1.actors_) do
					local var_150_80 = iter_150_19:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_150_20, iter_150_21 in ipairs(var_150_80) do
						if iter_150_21.color.r > 0.51 then
							iter_150_21.color = Color.New(1, 1, 1)
						else
							iter_150_21.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_150_81 = 0.0166666666666667

			if var_150_79 <= arg_147_1.time_ and arg_147_1.time_ < var_150_79 + var_150_81 then
				local var_150_82 = (arg_147_1.time_ - var_150_79) / var_150_81

				arg_147_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_150_82)
			end

			if arg_147_1.time_ >= var_150_79 + var_150_81 and arg_147_1.time_ < var_150_79 + var_150_81 + arg_150_0 then
				arg_147_1.screenFilterEffect_.weight = 0
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_83 = 4
			local var_150_84 = 0.275

			if var_150_83 < arg_147_1.time_ and arg_147_1.time_ <= var_150_83 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_85 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_85:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_85:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_85:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_86 = arg_147_1:FormatText(StoryNameCfg[612].name)

				arg_147_1.leftNameTxt_.text = var_150_86

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_87 = arg_147_1:GetWordFromCfg(410211036)
				local var_150_88 = arg_147_1:FormatText(var_150_87.content)

				arg_147_1.text_.text = var_150_88

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_89 = 11
				local var_150_90 = utf8.len(var_150_88)
				local var_150_91 = var_150_89 <= 0 and var_150_84 or var_150_84 * (var_150_90 / var_150_89)

				if var_150_91 > 0 and var_150_84 < var_150_91 then
					arg_147_1.talkMaxDuration = var_150_91
					var_150_83 = var_150_83 + 0.3

					if var_150_91 + var_150_83 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_91 + var_150_83
					end
				end

				arg_147_1.text_.text = var_150_88
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") ~= 0 then
					local var_150_92 = manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") / 1000

					if var_150_92 + var_150_83 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_92 + var_150_83
					end

					if var_150_87.prefab_name ~= "" and arg_147_1.actors_[var_150_87.prefab_name] ~= nil then
						local var_150_93 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_87.prefab_name].transform, "story_v_out_410211", "410211036", "story_v_out_410211.awb")

						arg_147_1:RecordAudio("410211036", var_150_93)
						arg_147_1:RecordAudio("410211036", var_150_93)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410211", "410211036", "story_v_out_410211.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410211", "410211036", "story_v_out_410211.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_94 = var_150_83 + 0.3
			local var_150_95 = math.max(var_150_84, arg_147_1.talkMaxDuration)

			if var_150_94 <= arg_147_1.time_ and arg_147_1.time_ < var_150_94 + var_150_95 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_94) / var_150_95

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_94 + var_150_95 and arg_147_1.time_ < var_150_94 + var_150_95 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play410211037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410211037
		arg_153_1.duration_ = 2.83

		local var_153_0 = {
			ja = 2.833,
			CriLanguages = 1.833,
			zh = 1.833
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play410211038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1061"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1061 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1061", 2)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(-390, -490, 18)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1061, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_156_7 = arg_153_1.actors_["1061"]
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1061 == nil then
				arg_153_1.var_.actorSpriteComps1061 = var_156_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.034

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 and not isNil(var_156_7) then
				local var_156_10 = (arg_153_1.time_ - var_156_8) / var_156_9

				if arg_153_1.var_.actorSpriteComps1061 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								local var_156_11 = Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, var_156_10)
								local var_156_12 = Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, var_156_10)
								local var_156_13 = Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, var_156_10)

								iter_156_2.color = Color.New(var_156_11, var_156_12, var_156_13)
							else
								local var_156_14 = Mathf.Lerp(iter_156_2.color.r, 1, var_156_10)

								iter_156_2.color = Color.New(var_156_14, var_156_14, var_156_14)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1061 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_156_4 then
						if arg_153_1.isInRecall_ then
							iter_156_4.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1061 = nil
			end

			local var_156_15 = 0
			local var_156_16 = 0.15

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[612].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(410211037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_410211", "410211037", "story_v_out_410211.awb")

						arg_153_1:RecordAudio("410211037", var_156_24)
						arg_153_1:RecordAudio("410211037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410211", "410211037", "story_v_out_410211.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410211", "410211037", "story_v_out_410211.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play410211038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410211038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410211039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1061"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.034

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.95

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(410211038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_12 = 38
				local var_160_13 = utf8.len(var_160_11)
				local var_160_14 = var_160_12 <= 0 and var_160_9 or var_160_9 * (var_160_13 / var_160_12)

				if var_160_14 > 0 and var_160_9 < var_160_14 then
					arg_157_1.talkMaxDuration = var_160_14

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_15 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_15 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_15

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_15 and arg_157_1.time_ < var_160_8 + var_160_15 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play410211039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410211039
		arg_161_1.duration_ = 3.17

		local var_161_0 = {
			ja = 3.166,
			CriLanguages = 1.633,
			zh = 1.633
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410211040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10059"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10059 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10059", 4)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(390, -530, 35)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10059, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_164_7 = arg_161_1.actors_["10059"]
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps10059 == nil then
				arg_161_1.var_.actorSpriteComps10059 = var_164_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 0.034

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 and not isNil(var_164_7) then
				local var_164_10 = (arg_161_1.time_ - var_164_8) / var_164_9

				if arg_161_1.var_.actorSpriteComps10059 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								local var_164_11 = Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, var_164_10)
								local var_164_12 = Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, var_164_10)
								local var_164_13 = Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, var_164_10)

								iter_164_2.color = Color.New(var_164_11, var_164_12, var_164_13)
							else
								local var_164_14 = Mathf.Lerp(iter_164_2.color.r, 1, var_164_10)

								iter_164_2.color = Color.New(var_164_14, var_164_14, var_164_14)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps10059 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_164_4 then
						if arg_161_1.isInRecall_ then
							iter_164_4.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10059 = nil
			end

			local var_164_15 = 0
			local var_164_16 = 0.175

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[596].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(410211039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_410211", "410211039", "story_v_out_410211.awb")

						arg_161_1:RecordAudio("410211039", var_164_24)
						arg_161_1:RecordAudio("410211039", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410211", "410211039", "story_v_out_410211.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410211", "410211039", "story_v_out_410211.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play410211040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410211040
		arg_165_1.duration_ = 12.97

		local var_165_0 = {
			ja = 12.966,
			CriLanguages = 11.266,
			zh = 11.266
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410211041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1061"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1061 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1061", 2)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(-390, -490, 18)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1061, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_168_7 = arg_165_1.actors_["1061"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps1061 == nil then
				arg_165_1.var_.actorSpriteComps1061 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 and not isNil(var_168_7) then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps1061 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								local var_168_11 = Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, var_168_10)
								local var_168_12 = Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, var_168_10)
								local var_168_13 = Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, var_168_10)

								iter_168_2.color = Color.New(var_168_11, var_168_12, var_168_13)
							else
								local var_168_14 = Mathf.Lerp(iter_168_2.color.r, 1, var_168_10)

								iter_168_2.color = Color.New(var_168_14, var_168_14, var_168_14)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps1061 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_168_4 then
						if arg_165_1.isInRecall_ then
							iter_168_4.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1061 = nil
			end

			local var_168_15 = arg_165_1.actors_["10059"]
			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps10059 == nil then
				arg_165_1.var_.actorSpriteComps10059 = var_168_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_17 = 0.034

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 and not isNil(var_168_15) then
				local var_168_18 = (arg_165_1.time_ - var_168_16) / var_168_17

				if arg_165_1.var_.actorSpriteComps10059 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								local var_168_19 = Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor2.r, var_168_18)
								local var_168_20 = Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor2.g, var_168_18)
								local var_168_21 = Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor2.b, var_168_18)

								iter_168_6.color = Color.New(var_168_19, var_168_20, var_168_21)
							else
								local var_168_22 = Mathf.Lerp(iter_168_6.color.r, 0.5, var_168_18)

								iter_168_6.color = Color.New(var_168_22, var_168_22, var_168_22)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps10059 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_168_8 then
						if arg_165_1.isInRecall_ then
							iter_168_8.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10059 = nil
			end

			local var_168_23 = 0
			local var_168_24 = 1.35

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_25 = arg_165_1:FormatText(StoryNameCfg[612].name)

				arg_165_1.leftNameTxt_.text = var_168_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_26 = arg_165_1:GetWordFromCfg(410211040)
				local var_168_27 = arg_165_1:FormatText(var_168_26.content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_28 = 54
				local var_168_29 = utf8.len(var_168_27)
				local var_168_30 = var_168_28 <= 0 and var_168_24 or var_168_24 * (var_168_29 / var_168_28)

				if var_168_30 > 0 and var_168_24 < var_168_30 then
					arg_165_1.talkMaxDuration = var_168_30

					if var_168_30 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_30 + var_168_23
					end
				end

				arg_165_1.text_.text = var_168_27
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") ~= 0 then
					local var_168_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") / 1000

					if var_168_31 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_31 + var_168_23
					end

					if var_168_26.prefab_name ~= "" and arg_165_1.actors_[var_168_26.prefab_name] ~= nil then
						local var_168_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_26.prefab_name].transform, "story_v_out_410211", "410211040", "story_v_out_410211.awb")

						arg_165_1:RecordAudio("410211040", var_168_32)
						arg_165_1:RecordAudio("410211040", var_168_32)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410211", "410211040", "story_v_out_410211.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410211", "410211040", "story_v_out_410211.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_33 = math.max(var_168_24, arg_165_1.talkMaxDuration)

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_33 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_23) / var_168_33

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_23 + var_168_33 and arg_165_1.time_ < var_168_23 + var_168_33 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play410211041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410211041
		arg_169_1.duration_ = 4.9

		local var_169_0 = {
			ja = 4.433,
			CriLanguages = 4.9,
			zh = 4.9
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
				arg_169_0:Play410211042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10059"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10059 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10059", 4)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(390, -530, 35)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10059, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_172_7 = arg_169_1.actors_["1061"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1061 == nil then
				arg_169_1.var_.actorSpriteComps1061 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps1061 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								local var_172_11 = Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor2.r, var_172_10)
								local var_172_12 = Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor2.g, var_172_10)
								local var_172_13 = Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor2.b, var_172_10)

								iter_172_2.color = Color.New(var_172_11, var_172_12, var_172_13)
							else
								local var_172_14 = Mathf.Lerp(iter_172_2.color.r, 0.5, var_172_10)

								iter_172_2.color = Color.New(var_172_14, var_172_14, var_172_14)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1061 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1061 = nil
			end

			local var_172_15 = arg_169_1.actors_["10059"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10059 == nil then
				arg_169_1.var_.actorSpriteComps10059 = var_172_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_17 = 0.034

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.actorSpriteComps10059 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								local var_172_19 = Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor1.r, var_172_18)
								local var_172_20 = Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor1.g, var_172_18)
								local var_172_21 = Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor1.b, var_172_18)

								iter_172_6.color = Color.New(var_172_19, var_172_20, var_172_21)
							else
								local var_172_22 = Mathf.Lerp(iter_172_6.color.r, 1, var_172_18)

								iter_172_6.color = Color.New(var_172_22, var_172_22, var_172_22)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10059 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_172_8 then
						if arg_169_1.isInRecall_ then
							iter_172_8.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10059 = nil
			end

			local var_172_23 = 0
			local var_172_24 = 0.425

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_25 = arg_169_1:FormatText(StoryNameCfg[596].name)

				arg_169_1.leftNameTxt_.text = var_172_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(410211041)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 17
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") ~= 0 then
					local var_172_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") / 1000

					if var_172_31 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_31 + var_172_23
					end

					if var_172_26.prefab_name ~= "" and arg_169_1.actors_[var_172_26.prefab_name] ~= nil then
						local var_172_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_26.prefab_name].transform, "story_v_out_410211", "410211041", "story_v_out_410211.awb")

						arg_169_1:RecordAudio("410211041", var_172_32)
						arg_169_1:RecordAudio("410211041", var_172_32)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410211", "410211041", "story_v_out_410211.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410211", "410211041", "story_v_out_410211.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_33 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_23) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_23 + var_172_33 and arg_169_1.time_ < var_172_23 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play410211042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410211042
		arg_173_1.duration_ = 3.83

		local var_173_0 = {
			ja = 3.833,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_173_0:Play410211043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1061"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 2)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(-390, -490, 18)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_176_7 = arg_173_1.actors_["1061"]
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_9 = 0.034

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 and not isNil(var_176_7) then
				local var_176_10 = (arg_173_1.time_ - var_176_8) / var_176_9

				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								local var_176_11 = Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, var_176_10)
								local var_176_12 = Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, var_176_10)
								local var_176_13 = Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, var_176_10)

								iter_176_2.color = Color.New(var_176_11, var_176_12, var_176_13)
							else
								local var_176_14 = Mathf.Lerp(iter_176_2.color.r, 1, var_176_10)

								iter_176_2.color = Color.New(var_176_14, var_176_14, var_176_14)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						if arg_173_1.isInRecall_ then
							iter_176_4.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_15 = arg_173_1.actors_["10059"]
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10059 == nil then
				arg_173_1.var_.actorSpriteComps10059 = var_176_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_17 = 0.034

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 and not isNil(var_176_15) then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17

				if arg_173_1.var_.actorSpriteComps10059 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								local var_176_19 = Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, var_176_18)
								local var_176_20 = Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, var_176_18)
								local var_176_21 = Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, var_176_18)

								iter_176_6.color = Color.New(var_176_19, var_176_20, var_176_21)
							else
								local var_176_22 = Mathf.Lerp(iter_176_6.color.r, 0.5, var_176_18)

								iter_176_6.color = Color.New(var_176_22, var_176_22, var_176_22)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10059 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_176_8 then
						if arg_173_1.isInRecall_ then
							iter_176_8.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10059 = nil
			end

			local var_176_23 = 0
			local var_176_24 = 0.325

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_25 = arg_173_1:FormatText(StoryNameCfg[612].name)

				arg_173_1.leftNameTxt_.text = var_176_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(410211042)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 13
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_24 or var_176_24 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_24 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") ~= 0 then
					local var_176_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") / 1000

					if var_176_31 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_31 + var_176_23
					end

					if var_176_26.prefab_name ~= "" and arg_173_1.actors_[var_176_26.prefab_name] ~= nil then
						local var_176_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_26.prefab_name].transform, "story_v_out_410211", "410211042", "story_v_out_410211.awb")

						arg_173_1:RecordAudio("410211042", var_176_32)
						arg_173_1:RecordAudio("410211042", var_176_32)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410211", "410211042", "story_v_out_410211.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410211", "410211042", "story_v_out_410211.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_33 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_33 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_23) / var_176_33

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_23 + var_176_33 and arg_173_1.time_ < var_176_23 + var_176_33 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410211043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410211043
		arg_177_1.duration_ = 4.73

		local var_177_0 = {
			ja = 4.733,
			CriLanguages = 4.3,
			zh = 4.3
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
				arg_177_0:Play410211044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10059"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10059 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10059", 4)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(390, -530, 35)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10059, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_180_7 = arg_177_1.actors_["1061"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 0.034

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 and not isNil(var_180_7) then
				local var_180_10 = (arg_177_1.time_ - var_180_8) / var_180_9

				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								local var_180_11 = Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor2.r, var_180_10)
								local var_180_12 = Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor2.g, var_180_10)
								local var_180_13 = Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor2.b, var_180_10)

								iter_180_2.color = Color.New(var_180_11, var_180_12, var_180_13)
							else
								local var_180_14 = Mathf.Lerp(iter_180_2.color.r, 0.5, var_180_10)

								iter_180_2.color = Color.New(var_180_14, var_180_14, var_180_14)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_4 then
						if arg_177_1.isInRecall_ then
							iter_180_4.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_15 = arg_177_1.actors_["10059"]
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps10059 == nil then
				arg_177_1.var_.actorSpriteComps10059 = var_180_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_17 = 0.034

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 and not isNil(var_180_15) then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17

				if arg_177_1.var_.actorSpriteComps10059 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_180_6 then
							if arg_177_1.isInRecall_ then
								local var_180_19 = Mathf.Lerp(iter_180_6.color.r, arg_177_1.hightColor1.r, var_180_18)
								local var_180_20 = Mathf.Lerp(iter_180_6.color.g, arg_177_1.hightColor1.g, var_180_18)
								local var_180_21 = Mathf.Lerp(iter_180_6.color.b, arg_177_1.hightColor1.b, var_180_18)

								iter_180_6.color = Color.New(var_180_19, var_180_20, var_180_21)
							else
								local var_180_22 = Mathf.Lerp(iter_180_6.color.r, 1, var_180_18)

								iter_180_6.color = Color.New(var_180_22, var_180_22, var_180_22)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps10059 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_180_8 then
						if arg_177_1.isInRecall_ then
							iter_180_8.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10059 = nil
			end

			local var_180_23 = 0
			local var_180_24 = 0.275

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_25 = arg_177_1:FormatText(StoryNameCfg[596].name)

				arg_177_1.leftNameTxt_.text = var_180_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(410211043)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_28 = 11
				local var_180_29 = utf8.len(var_180_27)
				local var_180_30 = var_180_28 <= 0 and var_180_24 or var_180_24 * (var_180_29 / var_180_28)

				if var_180_30 > 0 and var_180_24 < var_180_30 then
					arg_177_1.talkMaxDuration = var_180_30

					if var_180_30 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_23
					end
				end

				arg_177_1.text_.text = var_180_27
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") ~= 0 then
					local var_180_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") / 1000

					if var_180_31 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_23
					end

					if var_180_26.prefab_name ~= "" and arg_177_1.actors_[var_180_26.prefab_name] ~= nil then
						local var_180_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_26.prefab_name].transform, "story_v_out_410211", "410211043", "story_v_out_410211.awb")

						arg_177_1:RecordAudio("410211043", var_180_32)
						arg_177_1:RecordAudio("410211043", var_180_32)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410211", "410211043", "story_v_out_410211.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410211", "410211043", "story_v_out_410211.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_33 = math.max(var_180_24, arg_177_1.talkMaxDuration)

			if var_180_23 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_33 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_23) / var_180_33

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_23 + var_180_33 and arg_177_1.time_ < var_180_23 + var_180_33 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play410211044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410211044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410211045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10059"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10059 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10059", 7)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(0, -2000, 18)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10059, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_184_7 = arg_181_1.actors_["1061"].transform
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.var_.moveOldPos1061 = var_184_7.localPosition
				var_184_7.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1061", 7)

				local var_184_9 = var_184_7.childCount

				for iter_184_1 = 0, var_184_9 - 1 do
					local var_184_10 = var_184_7:GetChild(iter_184_1)

					if var_184_10.name == "" or not string.find(var_184_10.name, "split") then
						var_184_10.gameObject:SetActive(true)
					else
						var_184_10.gameObject:SetActive(false)
					end
				end
			end

			local var_184_11 = 0.001

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_8) / var_184_11
				local var_184_13 = Vector3.New(0, -2000, 18)

				var_184_7.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1061, var_184_13, var_184_12)
			end

			if arg_181_1.time_ >= var_184_8 + var_184_11 and arg_181_1.time_ < var_184_8 + var_184_11 + arg_184_0 then
				var_184_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_184_14 = arg_181_1.actors_["10059"]
			local var_184_15 = 0

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10059 == nil then
				arg_181_1.var_.actorSpriteComps10059 = var_184_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_16 = 0.034

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_16 and not isNil(var_184_14) then
				local var_184_17 = (arg_181_1.time_ - var_184_15) / var_184_16

				if arg_181_1.var_.actorSpriteComps10059 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								local var_184_18 = Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, var_184_17)
								local var_184_19 = Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, var_184_17)
								local var_184_20 = Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, var_184_17)

								iter_184_3.color = Color.New(var_184_18, var_184_19, var_184_20)
							else
								local var_184_21 = Mathf.Lerp(iter_184_3.color.r, 0.5, var_184_17)

								iter_184_3.color = Color.New(var_184_21, var_184_21, var_184_21)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_15 + var_184_16 and arg_181_1.time_ < var_184_15 + var_184_16 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10059 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_184_5 then
						if arg_181_1.isInRecall_ then
							iter_184_5.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10059 = nil
			end

			local var_184_22 = arg_181_1.actors_["1061"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps1061 == nil then
				arg_181_1.var_.actorSpriteComps1061 = var_184_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_24 = 0.034

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.actorSpriteComps1061 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								local var_184_26 = Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor2.r, var_184_25)
								local var_184_27 = Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor2.g, var_184_25)
								local var_184_28 = Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor2.b, var_184_25)

								iter_184_7.color = Color.New(var_184_26, var_184_27, var_184_28)
							else
								local var_184_29 = Mathf.Lerp(iter_184_7.color.r, 0.5, var_184_25)

								iter_184_7.color = Color.New(var_184_29, var_184_29, var_184_29)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps1061 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_184_9 then
						if arg_181_1.isInRecall_ then
							iter_184_9.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1061 = nil
			end

			local var_184_30 = 0
			local var_184_31 = 1.125

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_32 = arg_181_1:GetWordFromCfg(410211044)
				local var_184_33 = arg_181_1:FormatText(var_184_32.content)

				arg_181_1.text_.text = var_184_33

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_34 = 45
				local var_184_35 = utf8.len(var_184_33)
				local var_184_36 = var_184_34 <= 0 and var_184_31 or var_184_31 * (var_184_35 / var_184_34)

				if var_184_36 > 0 and var_184_31 < var_184_36 then
					arg_181_1.talkMaxDuration = var_184_36

					if var_184_36 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_36 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_33
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_37 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_37 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_37

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_37 and arg_181_1.time_ < var_184_30 + var_184_37 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play410211045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410211045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410211046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.9

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(410211045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 36
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play410211046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410211046
		arg_189_1.duration_ = 1.63

		local var_189_0 = {
			ja = 1.4,
			CriLanguages = 1.633,
			zh = 1.633
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410211047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10063"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10063 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10063", 2)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_5" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(-390, -535, -105)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10063, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -535, -105)
			end

			local var_192_7 = arg_189_1.actors_["10059"].transform
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.var_.moveOldPos10059 = var_192_7.localPosition
				var_192_7.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10059", 4)

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
				local var_192_13 = Vector3.New(390, -530, 35)

				var_192_7.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10059, var_192_13, var_192_12)
			end

			if arg_189_1.time_ >= var_192_8 + var_192_11 and arg_189_1.time_ < var_192_8 + var_192_11 + arg_192_0 then
				var_192_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_192_14 = arg_189_1.actors_["10063"]
			local var_192_15 = 0

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.actorSpriteComps10063 == nil then
				arg_189_1.var_.actorSpriteComps10063 = var_192_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_16 = 0.034

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_16 and not isNil(var_192_14) then
				local var_192_17 = (arg_189_1.time_ - var_192_15) / var_192_16

				if arg_189_1.var_.actorSpriteComps10063 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								local var_192_18 = Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor1.r, var_192_17)
								local var_192_19 = Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor1.g, var_192_17)
								local var_192_20 = Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor1.b, var_192_17)

								iter_192_3.color = Color.New(var_192_18, var_192_19, var_192_20)
							else
								local var_192_21 = Mathf.Lerp(iter_192_3.color.r, 1, var_192_17)

								iter_192_3.color = Color.New(var_192_21, var_192_21, var_192_21)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_15 + var_192_16 and arg_189_1.time_ < var_192_15 + var_192_16 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.actorSpriteComps10063 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_192_5 then
						if arg_189_1.isInRecall_ then
							iter_192_5.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10063 = nil
			end

			local var_192_22 = arg_189_1.actors_["10059"]
			local var_192_23 = 0

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 and not isNil(var_192_22) and arg_189_1.var_.actorSpriteComps10059 == nil then
				arg_189_1.var_.actorSpriteComps10059 = var_192_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_24 = 0.034

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_24 and not isNil(var_192_22) then
				local var_192_25 = (arg_189_1.time_ - var_192_23) / var_192_24

				if arg_189_1.var_.actorSpriteComps10059 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								local var_192_26 = Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, var_192_25)
								local var_192_27 = Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, var_192_25)
								local var_192_28 = Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, var_192_25)

								iter_192_7.color = Color.New(var_192_26, var_192_27, var_192_28)
							else
								local var_192_29 = Mathf.Lerp(iter_192_7.color.r, 0.5, var_192_25)

								iter_192_7.color = Color.New(var_192_29, var_192_29, var_192_29)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_23 + var_192_24 and arg_189_1.time_ < var_192_23 + var_192_24 + arg_192_0 and not isNil(var_192_22) and arg_189_1.var_.actorSpriteComps10059 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_192_9 then
						if arg_189_1.isInRecall_ then
							iter_192_9.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10059 = nil
			end

			local var_192_30 = 0
			local var_192_31 = 0.1

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_32 = arg_189_1:FormatText(StoryNameCfg[591].name)

				arg_189_1.leftNameTxt_.text = var_192_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_33 = arg_189_1:GetWordFromCfg(410211046)
				local var_192_34 = arg_189_1:FormatText(var_192_33.content)

				arg_189_1.text_.text = var_192_34

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_35 = 4
				local var_192_36 = utf8.len(var_192_34)
				local var_192_37 = var_192_35 <= 0 and var_192_31 or var_192_31 * (var_192_36 / var_192_35)

				if var_192_37 > 0 and var_192_31 < var_192_37 then
					arg_189_1.talkMaxDuration = var_192_37

					if var_192_37 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_37 + var_192_30
					end
				end

				arg_189_1.text_.text = var_192_34
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") ~= 0 then
					local var_192_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") / 1000

					if var_192_38 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_38 + var_192_30
					end

					if var_192_33.prefab_name ~= "" and arg_189_1.actors_[var_192_33.prefab_name] ~= nil then
						local var_192_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_33.prefab_name].transform, "story_v_out_410211", "410211046", "story_v_out_410211.awb")

						arg_189_1:RecordAudio("410211046", var_192_39)
						arg_189_1:RecordAudio("410211046", var_192_39)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410211", "410211046", "story_v_out_410211.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410211", "410211046", "story_v_out_410211.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_40 = math.max(var_192_31, arg_189_1.talkMaxDuration)

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_40 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_30) / var_192_40

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_30 + var_192_40 and arg_189_1.time_ < var_192_30 + var_192_40 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_189_1:InitPlayNodeList()
	end,
	Play410211047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410211047
		arg_193_1.duration_ = 4.27

		local var_193_0 = {
			ja = 4.266,
			CriLanguages = 2.533,
			zh = 2.533
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
				arg_193_0:Play410211048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10063"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10063 == nil then
				arg_193_1.var_.actorSpriteComps10063 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.034

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10063 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10063 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10063 = nil
			end

			local var_196_8 = arg_193_1.actors_["10059"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10059 == nil then
				arg_193_1.var_.actorSpriteComps10059 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.034

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10059 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor1.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor1.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor1.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 1, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10059 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10059 = nil
			end

			local var_196_16 = 0
			local var_196_17 = 0.25

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_18 = arg_193_1:FormatText(StoryNameCfg[596].name)

				arg_193_1.leftNameTxt_.text = var_196_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_19 = arg_193_1:GetWordFromCfg(410211047)
				local var_196_20 = arg_193_1:FormatText(var_196_19.content)

				arg_193_1.text_.text = var_196_20

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_21 = 10
				local var_196_22 = utf8.len(var_196_20)
				local var_196_23 = var_196_21 <= 0 and var_196_17 or var_196_17 * (var_196_22 / var_196_21)

				if var_196_23 > 0 and var_196_17 < var_196_23 then
					arg_193_1.talkMaxDuration = var_196_23

					if var_196_23 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_16
					end
				end

				arg_193_1.text_.text = var_196_20
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") ~= 0 then
					local var_196_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") / 1000

					if var_196_24 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_24 + var_196_16
					end

					if var_196_19.prefab_name ~= "" and arg_193_1.actors_[var_196_19.prefab_name] ~= nil then
						local var_196_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_19.prefab_name].transform, "story_v_out_410211", "410211047", "story_v_out_410211.awb")

						arg_193_1:RecordAudio("410211047", var_196_25)
						arg_193_1:RecordAudio("410211047", var_196_25)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410211", "410211047", "story_v_out_410211.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410211", "410211047", "story_v_out_410211.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_26 = math.max(var_196_17, arg_193_1.talkMaxDuration)

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_26 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_16) / var_196_26

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_16 + var_196_26 and arg_193_1.time_ < var_196_16 + var_196_26 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play410211048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410211048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410211049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10063"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10063 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10063", 7)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(0, -2000, -105)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10063, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_200_7 = arg_197_1.actors_["10059"].transform
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.var_.moveOldPos10059 = var_200_7.localPosition
				var_200_7.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10059", 7)

				local var_200_9 = var_200_7.childCount

				for iter_200_1 = 0, var_200_9 - 1 do
					local var_200_10 = var_200_7:GetChild(iter_200_1)

					if var_200_10.name == "" or not string.find(var_200_10.name, "split") then
						var_200_10.gameObject:SetActive(true)
					else
						var_200_10.gameObject:SetActive(false)
					end
				end
			end

			local var_200_11 = 0.001

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_11 then
				local var_200_12 = (arg_197_1.time_ - var_200_8) / var_200_11
				local var_200_13 = Vector3.New(0, -2000, 35)

				var_200_7.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10059, var_200_13, var_200_12)
			end

			if arg_197_1.time_ >= var_200_8 + var_200_11 and arg_197_1.time_ < var_200_8 + var_200_11 + arg_200_0 then
				var_200_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_200_14 = 0
			local var_200_15 = 1.15

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_16 = arg_197_1:GetWordFromCfg(410211048)
				local var_200_17 = arg_197_1:FormatText(var_200_16.content)

				arg_197_1.text_.text = var_200_17

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_18 = 46
				local var_200_19 = utf8.len(var_200_17)
				local var_200_20 = var_200_18 <= 0 and var_200_15 or var_200_15 * (var_200_19 / var_200_18)

				if var_200_20 > 0 and var_200_15 < var_200_20 then
					arg_197_1.talkMaxDuration = var_200_20

					if var_200_20 + var_200_14 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_14
					end
				end

				arg_197_1.text_.text = var_200_17
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_15, arg_197_1.talkMaxDuration)

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_14) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_14 + var_200_21 and arg_197_1.time_ < var_200_14 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_197_1:InitPlayNodeList()
	end,
	Play410211049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410211049
		arg_201_1.duration_ = 4.67

		local var_201_0 = {
			ja = 2.6,
			CriLanguages = 4.666,
			zh = 4.666
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
				arg_201_0:Play410211050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10059"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10059 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10059", 4)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(390, -530, 35)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10059, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_204_7 = arg_201_1.actors_["1061"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos1061 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1061", 2)

				local var_204_9 = var_204_7.childCount

				for iter_204_1 = 0, var_204_9 - 1 do
					local var_204_10 = var_204_7:GetChild(iter_204_1)

					if var_204_10.name == "" or not string.find(var_204_10.name, "split") then
						var_204_10.gameObject:SetActive(true)
					else
						var_204_10.gameObject:SetActive(false)
					end
				end
			end

			local var_204_11 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_8) / var_204_11
				local var_204_13 = Vector3.New(-390, -490, 18)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1061, var_204_13, var_204_12)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_11 and arg_201_1.time_ < var_204_8 + var_204_11 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_204_14 = arg_201_1.actors_["10059"]
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10059 == nil then
				arg_201_1.var_.actorSpriteComps10059 = var_204_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_16 = 0.034

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_16 and not isNil(var_204_14) then
				local var_204_17 = (arg_201_1.time_ - var_204_15) / var_204_16

				if arg_201_1.var_.actorSpriteComps10059 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								local var_204_18 = Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor1.r, var_204_17)
								local var_204_19 = Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor1.g, var_204_17)
								local var_204_20 = Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor1.b, var_204_17)

								iter_204_3.color = Color.New(var_204_18, var_204_19, var_204_20)
							else
								local var_204_21 = Mathf.Lerp(iter_204_3.color.r, 1, var_204_17)

								iter_204_3.color = Color.New(var_204_21, var_204_21, var_204_21)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_15 + var_204_16 and arg_201_1.time_ < var_204_15 + var_204_16 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10059 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_204_5 then
						if arg_201_1.isInRecall_ then
							iter_204_5.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10059 = nil
			end

			local var_204_22 = arg_201_1.actors_["1061"]
			local var_204_23 = 0

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps1061 == nil then
				arg_201_1.var_.actorSpriteComps1061 = var_204_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_24 = 0.034

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 and not isNil(var_204_22) then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24

				if arg_201_1.var_.actorSpriteComps1061 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								local var_204_26 = Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor2.r, var_204_25)
								local var_204_27 = Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor2.g, var_204_25)
								local var_204_28 = Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor2.b, var_204_25)

								iter_204_7.color = Color.New(var_204_26, var_204_27, var_204_28)
							else
								local var_204_29 = Mathf.Lerp(iter_204_7.color.r, 0.5, var_204_25)

								iter_204_7.color = Color.New(var_204_29, var_204_29, var_204_29)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps1061 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_204_9 then
						if arg_201_1.isInRecall_ then
							iter_204_9.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1061 = nil
			end

			local var_204_30 = 0
			local var_204_31 = 0.45

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[596].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(410211049)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 18
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_410211", "410211049", "story_v_out_410211.awb")

						arg_201_1:RecordAudio("410211049", var_204_39)
						arg_201_1:RecordAudio("410211049", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410211", "410211049", "story_v_out_410211.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410211", "410211049", "story_v_out_410211.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410211050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410211050
		arg_205_1.duration_ = 4.53

		local var_205_0 = {
			ja = 4.533,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_205_0:Play410211051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1061"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 2)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_5" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(-390, -490, 18)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_208_7 = arg_205_1.actors_["10059"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10059 == nil then
				arg_205_1.var_.actorSpriteComps10059 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps10059 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor2.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor2.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor2.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 0.5, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10059 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10059 = nil
			end

			local var_208_15 = arg_205_1.actors_["1061"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_17 = 0.034

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 and not isNil(var_208_15) then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17

				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								local var_208_19 = Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor1.r, var_208_18)
								local var_208_20 = Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor1.g, var_208_18)
								local var_208_21 = Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor1.b, var_208_18)

								iter_208_6.color = Color.New(var_208_19, var_208_20, var_208_21)
							else
								local var_208_22 = Mathf.Lerp(iter_208_6.color.r, 1, var_208_18)

								iter_208_6.color = Color.New(var_208_22, var_208_22, var_208_22)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_8 then
						if arg_205_1.isInRecall_ then
							iter_208_8.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_23 = 0
			local var_208_24 = 0.2

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[612].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(410211050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 8
				local var_208_29 = utf8.len(var_208_27)
				local var_208_30 = var_208_28 <= 0 and var_208_24 or var_208_24 * (var_208_29 / var_208_28)

				if var_208_30 > 0 and var_208_24 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30

					if var_208_30 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_23
					end
				end

				arg_205_1.text_.text = var_208_27
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_410211", "410211050", "story_v_out_410211.awb")

						arg_205_1:RecordAudio("410211050", var_208_32)
						arg_205_1:RecordAudio("410211050", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410211", "410211050", "story_v_out_410211.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410211", "410211050", "story_v_out_410211.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = math.max(var_208_24, arg_205_1.talkMaxDuration)

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_33 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_33

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_33 and arg_205_1.time_ < var_208_23 + var_208_33 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play410211051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410211051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410211052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10059"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10059 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10059", 7)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(0, -2000, 35)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10059, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_212_7 = arg_209_1.actors_["1061"].transform
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.var_.moveOldPos1061 = var_212_7.localPosition
				var_212_7.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1061", 7)

				local var_212_9 = var_212_7.childCount

				for iter_212_1 = 0, var_212_9 - 1 do
					local var_212_10 = var_212_7:GetChild(iter_212_1)

					if var_212_10.name == "" or not string.find(var_212_10.name, "split") then
						var_212_10.gameObject:SetActive(true)
					else
						var_212_10.gameObject:SetActive(false)
					end
				end
			end

			local var_212_11 = 0.001

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_8) / var_212_11
				local var_212_13 = Vector3.New(0, -2000, 18)

				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1061, var_212_13, var_212_12)
			end

			if arg_209_1.time_ >= var_212_8 + var_212_11 and arg_209_1.time_ < var_212_8 + var_212_11 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_212_14 = 0
			local var_212_15 = 1.5

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_16 = arg_209_1:GetWordFromCfg(410211051)
				local var_212_17 = arg_209_1:FormatText(var_212_16.content)

				arg_209_1.text_.text = var_212_17

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_18 = 60
				local var_212_19 = utf8.len(var_212_17)
				local var_212_20 = var_212_18 <= 0 and var_212_15 or var_212_15 * (var_212_19 / var_212_18)

				if var_212_20 > 0 and var_212_15 < var_212_20 then
					arg_209_1.talkMaxDuration = var_212_20

					if var_212_20 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_17
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_21 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_21 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_14) / var_212_21

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_14 + var_212_21 and arg_209_1.time_ < var_212_14 + var_212_21 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play410211052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410211052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410211053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.675

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(410211052)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 67
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410211053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410211053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410211054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.05

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[604].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3046")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(410211053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 2
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410211054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410211054
		arg_221_1.duration_ = 1.17

		local var_221_0 = {
			ja = 1.133,
			CriLanguages = 1.166,
			zh = 1.166
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
				arg_221_0:Play410211055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10059"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10059 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10059", 3)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(0, -530, 35)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10059, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -530, 35)
			end

			local var_224_7 = arg_221_1.actors_["10059"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10059 == nil then
				arg_221_1.var_.actorSpriteComps10059 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10059 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10059 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10059 = nil
			end

			local var_224_15 = 0
			local var_224_16 = 0.075

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[596].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(410211054)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 3
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_410211", "410211054", "story_v_out_410211.awb")

						arg_221_1:RecordAudio("410211054", var_224_24)
						arg_221_1:RecordAudio("410211054", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410211", "410211054", "story_v_out_410211.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410211", "410211054", "story_v_out_410211.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play410211055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410211055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play410211056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10059"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10059 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10059", 7)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(0, -2000, 18)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10059, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_228_7 = arg_225_1.actors_["10059"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10059 == nil then
				arg_225_1.var_.actorSpriteComps10059 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps10059 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor2.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor2.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor2.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 0.5, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10059 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10059 = nil
			end

			local var_228_15 = 0
			local var_228_16 = 0.625

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_17 = arg_225_1:GetWordFromCfg(410211055)
				local var_228_18 = arg_225_1:FormatText(var_228_17.content)

				arg_225_1.text_.text = var_228_18

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_19 = 25
				local var_228_20 = utf8.len(var_228_18)
				local var_228_21 = var_228_19 <= 0 and var_228_16 or var_228_16 * (var_228_20 / var_228_19)

				if var_228_21 > 0 and var_228_16 < var_228_21 then
					arg_225_1.talkMaxDuration = var_228_21

					if var_228_21 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_21 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_18
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_22 and arg_225_1.time_ < var_228_15 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play410211056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410211056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play410211057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.275

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(410211056)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 51
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play410211057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410211057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410211058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.6

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(410211057)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 24
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play410211058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410211058
		arg_237_1.duration_ = 6.1

		local var_237_0 = {
			ja = 6.1,
			CriLanguages = 3.466,
			zh = 3.466
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410211059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10063"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10063 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10063", 3)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_3" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(0, -490, 18)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10063, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_240_7 = arg_237_1.actors_["10063"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10063 == nil then
				arg_237_1.var_.actorSpriteComps10063 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps10063 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 1, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10063 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10063 = nil
			end

			local var_240_15 = 0
			local var_240_16 = 0.275

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[591].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(410211058)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 11
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_out_410211", "410211058", "story_v_out_410211.awb")

						arg_237_1:RecordAudio("410211058", var_240_24)
						arg_237_1:RecordAudio("410211058", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410211", "410211058", "story_v_out_410211.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410211", "410211058", "story_v_out_410211.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play410211059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410211059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play410211060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10063"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10063 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10063", 7)

				local var_244_2 = var_244_0.childCount

				for iter_244_0 = 0, var_244_2 - 1 do
					local var_244_3 = var_244_0:GetChild(iter_244_0)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_4 then
				local var_244_5 = (arg_241_1.time_ - var_244_1) / var_244_4
				local var_244_6 = Vector3.New(0, -2000, 18)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10063, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_244_7 = arg_241_1.actors_["10063"]
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps10063 == nil then
				arg_241_1.var_.actorSpriteComps10063 = var_244_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 and not isNil(var_244_7) then
				local var_244_10 = (arg_241_1.time_ - var_244_8) / var_244_9

				if arg_241_1.var_.actorSpriteComps10063 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								local var_244_11 = Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor2.r, var_244_10)
								local var_244_12 = Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor2.g, var_244_10)
								local var_244_13 = Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor2.b, var_244_10)

								iter_244_2.color = Color.New(var_244_11, var_244_12, var_244_13)
							else
								local var_244_14 = Mathf.Lerp(iter_244_2.color.r, 0.5, var_244_10)

								iter_244_2.color = Color.New(var_244_14, var_244_14, var_244_14)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps10063 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_244_4 then
						if arg_241_1.isInRecall_ then
							iter_244_4.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10063 = nil
			end

			local var_244_15 = 0
			local var_244_16 = 1.7

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_17 = arg_241_1:GetWordFromCfg(410211059)
				local var_244_18 = arg_241_1:FormatText(var_244_17.content)

				arg_241_1.text_.text = var_244_18

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_19 = 68
				local var_244_20 = utf8.len(var_244_18)
				local var_244_21 = var_244_19 <= 0 and var_244_16 or var_244_16 * (var_244_20 / var_244_19)

				if var_244_21 > 0 and var_244_16 < var_244_21 then
					arg_241_1.talkMaxDuration = var_244_21

					if var_244_21 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_21 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_18
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_22 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_22 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_22

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_22 and arg_241_1.time_ < var_244_15 + var_244_22 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play410211060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410211060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410211061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.35

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(410211060)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 54
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410211061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410211061
		arg_249_1.duration_ = 6.87

		local var_249_0 = {
			ja = 6.866,
			CriLanguages = 3.5,
			zh = 3.5
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play410211062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1061"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 2)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "split_5" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(-390, -490, 18)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_252_7 = arg_249_1.actors_["10059"].transform
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.var_.moveOldPos10059 = var_252_7.localPosition
				var_252_7.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10059", 4)

				local var_252_9 = var_252_7.childCount

				for iter_252_1 = 0, var_252_9 - 1 do
					local var_252_10 = var_252_7:GetChild(iter_252_1)

					if var_252_10.name == "" or not string.find(var_252_10.name, "split") then
						var_252_10.gameObject:SetActive(true)
					else
						var_252_10.gameObject:SetActive(false)
					end
				end
			end

			local var_252_11 = 0.001

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_11 then
				local var_252_12 = (arg_249_1.time_ - var_252_8) / var_252_11
				local var_252_13 = Vector3.New(390, -530, 35)

				var_252_7.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10059, var_252_13, var_252_12)
			end

			if arg_249_1.time_ >= var_252_8 + var_252_11 and arg_249_1.time_ < var_252_8 + var_252_11 + arg_252_0 then
				var_252_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_252_14 = arg_249_1.actors_["1061"]
			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_16 = 0.034

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_16 and not isNil(var_252_14) then
				local var_252_17 = (arg_249_1.time_ - var_252_15) / var_252_16

				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								local var_252_18 = Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor1.r, var_252_17)
								local var_252_19 = Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor1.g, var_252_17)
								local var_252_20 = Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor1.b, var_252_17)

								iter_252_3.color = Color.New(var_252_18, var_252_19, var_252_20)
							else
								local var_252_21 = Mathf.Lerp(iter_252_3.color.r, 1, var_252_17)

								iter_252_3.color = Color.New(var_252_21, var_252_21, var_252_21)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_15 + var_252_16 and arg_249_1.time_ < var_252_15 + var_252_16 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_5 then
						if arg_249_1.isInRecall_ then
							iter_252_5.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_22 = arg_249_1.actors_["10059"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10059 == nil then
				arg_249_1.var_.actorSpriteComps10059 = var_252_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_24 = 0.034

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.actorSpriteComps10059 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								local var_252_26 = Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor2.r, var_252_25)
								local var_252_27 = Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor2.g, var_252_25)
								local var_252_28 = Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor2.b, var_252_25)

								iter_252_7.color = Color.New(var_252_26, var_252_27, var_252_28)
							else
								local var_252_29 = Mathf.Lerp(iter_252_7.color.r, 0.5, var_252_25)

								iter_252_7.color = Color.New(var_252_29, var_252_29, var_252_29)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10059 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_252_9 then
						if arg_249_1.isInRecall_ then
							iter_252_9.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10059 = nil
			end

			local var_252_30 = 0
			local var_252_31 = 0.45

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[612].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(410211061)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 18
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_410211", "410211061", "story_v_out_410211.awb")

						arg_249_1:RecordAudio("410211061", var_252_39)
						arg_249_1:RecordAudio("410211061", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410211", "410211061", "story_v_out_410211.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410211", "410211061", "story_v_out_410211.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_249_1:InitPlayNodeList()
	end,
	Play410211062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410211062
		arg_253_1.duration_ = 12.33

		local var_253_0 = {
			ja = 12.333,
			CriLanguages = 6.466,
			zh = 6.466
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410211063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10059"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10059 == nil then
				arg_253_1.var_.actorSpriteComps10059 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.034

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps10059 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 1, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10059 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10059 = nil
			end

			local var_256_8 = arg_253_1.actors_["1061"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1061 == nil then
				arg_253_1.var_.actorSpriteComps1061 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.034

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps1061 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1061 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1061 = nil
			end

			local var_256_16 = 0
			local var_256_17 = 0.825

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_18 = arg_253_1:FormatText(StoryNameCfg[596].name)

				arg_253_1.leftNameTxt_.text = var_256_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_19 = arg_253_1:GetWordFromCfg(410211062)
				local var_256_20 = arg_253_1:FormatText(var_256_19.content)

				arg_253_1.text_.text = var_256_20

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_21 = 33
				local var_256_22 = utf8.len(var_256_20)
				local var_256_23 = var_256_21 <= 0 and var_256_17 or var_256_17 * (var_256_22 / var_256_21)

				if var_256_23 > 0 and var_256_17 < var_256_23 then
					arg_253_1.talkMaxDuration = var_256_23

					if var_256_23 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_23 + var_256_16
					end
				end

				arg_253_1.text_.text = var_256_20
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") ~= 0 then
					local var_256_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") / 1000

					if var_256_24 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_24 + var_256_16
					end

					if var_256_19.prefab_name ~= "" and arg_253_1.actors_[var_256_19.prefab_name] ~= nil then
						local var_256_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_19.prefab_name].transform, "story_v_out_410211", "410211062", "story_v_out_410211.awb")

						arg_253_1:RecordAudio("410211062", var_256_25)
						arg_253_1:RecordAudio("410211062", var_256_25)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410211", "410211062", "story_v_out_410211.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410211", "410211062", "story_v_out_410211.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_26 = math.max(var_256_17, arg_253_1.talkMaxDuration)

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_26 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_16) / var_256_26

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_16 + var_256_26 and arg_253_1.time_ < var_256_16 + var_256_26 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410211063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410211063
		arg_257_1.duration_ = 3.37

		local var_257_0 = {
			ja = 3.366,
			CriLanguages = 1.4,
			zh = 1.4
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410211064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1061"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 2)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "split_5" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(-390, -490, 18)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_260_7 = arg_257_1.actors_["1061"]
			local var_260_8 = 0

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_9 = 0.034

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 and not isNil(var_260_7) then
				local var_260_10 = (arg_257_1.time_ - var_260_8) / var_260_9

				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								local var_260_11 = Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, var_260_10)
								local var_260_12 = Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, var_260_10)
								local var_260_13 = Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, var_260_10)

								iter_260_2.color = Color.New(var_260_11, var_260_12, var_260_13)
							else
								local var_260_14 = Mathf.Lerp(iter_260_2.color.r, 1, var_260_10)

								iter_260_2.color = Color.New(var_260_14, var_260_14, var_260_14)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_4 then
						if arg_257_1.isInRecall_ then
							iter_260_4.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_15 = arg_257_1.actors_["10059"]
			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.actorSpriteComps10059 == nil then
				arg_257_1.var_.actorSpriteComps10059 = var_260_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_17 = 0.034

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 and not isNil(var_260_15) then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17

				if arg_257_1.var_.actorSpriteComps10059 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_260_6 then
							if arg_257_1.isInRecall_ then
								local var_260_19 = Mathf.Lerp(iter_260_6.color.r, arg_257_1.hightColor2.r, var_260_18)
								local var_260_20 = Mathf.Lerp(iter_260_6.color.g, arg_257_1.hightColor2.g, var_260_18)
								local var_260_21 = Mathf.Lerp(iter_260_6.color.b, arg_257_1.hightColor2.b, var_260_18)

								iter_260_6.color = Color.New(var_260_19, var_260_20, var_260_21)
							else
								local var_260_22 = Mathf.Lerp(iter_260_6.color.r, 0.5, var_260_18)

								iter_260_6.color = Color.New(var_260_22, var_260_22, var_260_22)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.actorSpriteComps10059 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_260_8 then
						if arg_257_1.isInRecall_ then
							iter_260_8.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10059 = nil
			end

			local var_260_23 = 0
			local var_260_24 = 0.175

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_25 = arg_257_1:FormatText(StoryNameCfg[612].name)

				arg_257_1.leftNameTxt_.text = var_260_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_26 = arg_257_1:GetWordFromCfg(410211063)
				local var_260_27 = arg_257_1:FormatText(var_260_26.content)

				arg_257_1.text_.text = var_260_27

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_28 = 7
				local var_260_29 = utf8.len(var_260_27)
				local var_260_30 = var_260_28 <= 0 and var_260_24 or var_260_24 * (var_260_29 / var_260_28)

				if var_260_30 > 0 and var_260_24 < var_260_30 then
					arg_257_1.talkMaxDuration = var_260_30

					if var_260_30 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_30 + var_260_23
					end
				end

				arg_257_1.text_.text = var_260_27
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") ~= 0 then
					local var_260_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") / 1000

					if var_260_31 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_31 + var_260_23
					end

					if var_260_26.prefab_name ~= "" and arg_257_1.actors_[var_260_26.prefab_name] ~= nil then
						local var_260_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_26.prefab_name].transform, "story_v_out_410211", "410211063", "story_v_out_410211.awb")

						arg_257_1:RecordAudio("410211063", var_260_32)
						arg_257_1:RecordAudio("410211063", var_260_32)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410211", "410211063", "story_v_out_410211.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410211", "410211063", "story_v_out_410211.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_33 = math.max(var_260_24, arg_257_1.talkMaxDuration)

			if var_260_23 <= arg_257_1.time_ and arg_257_1.time_ < var_260_23 + var_260_33 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_23) / var_260_33

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_23 + var_260_33 and arg_257_1.time_ < var_260_23 + var_260_33 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play410211064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410211064
		arg_261_1.duration_ = 4.63

		local var_261_0 = {
			ja = 4.266,
			CriLanguages = 4.633,
			zh = 4.633
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play410211065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1061"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.034

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor2.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor2.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor2.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 0.5, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_8 = arg_261_1.actors_["10059"]
			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10059 == nil then
				arg_261_1.var_.actorSpriteComps10059 = var_264_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_10 = 0.034

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 and not isNil(var_264_8) then
				local var_264_11 = (arg_261_1.time_ - var_264_9) / var_264_10

				if arg_261_1.var_.actorSpriteComps10059 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								local var_264_12 = Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor1.r, var_264_11)
								local var_264_13 = Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor1.g, var_264_11)
								local var_264_14 = Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor1.b, var_264_11)

								iter_264_5.color = Color.New(var_264_12, var_264_13, var_264_14)
							else
								local var_264_15 = Mathf.Lerp(iter_264_5.color.r, 1, var_264_11)

								iter_264_5.color = Color.New(var_264_15, var_264_15, var_264_15)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10059 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_264_7 then
						if arg_261_1.isInRecall_ then
							iter_264_7.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10059 = nil
			end

			local var_264_16 = 0
			local var_264_17 = 0.375

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_18 = arg_261_1:FormatText(StoryNameCfg[596].name)

				arg_261_1.leftNameTxt_.text = var_264_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_19 = arg_261_1:GetWordFromCfg(410211064)
				local var_264_20 = arg_261_1:FormatText(var_264_19.content)

				arg_261_1.text_.text = var_264_20

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_21 = 15
				local var_264_22 = utf8.len(var_264_20)
				local var_264_23 = var_264_21 <= 0 and var_264_17 or var_264_17 * (var_264_22 / var_264_21)

				if var_264_23 > 0 and var_264_17 < var_264_23 then
					arg_261_1.talkMaxDuration = var_264_23

					if var_264_23 + var_264_16 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_16
					end
				end

				arg_261_1.text_.text = var_264_20
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") ~= 0 then
					local var_264_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") / 1000

					if var_264_24 + var_264_16 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_24 + var_264_16
					end

					if var_264_19.prefab_name ~= "" and arg_261_1.actors_[var_264_19.prefab_name] ~= nil then
						local var_264_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_19.prefab_name].transform, "story_v_out_410211", "410211064", "story_v_out_410211.awb")

						arg_261_1:RecordAudio("410211064", var_264_25)
						arg_261_1:RecordAudio("410211064", var_264_25)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410211", "410211064", "story_v_out_410211.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410211", "410211064", "story_v_out_410211.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_26 = math.max(var_264_17, arg_261_1.talkMaxDuration)

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_26 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_16) / var_264_26

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_16 + var_264_26 and arg_261_1.time_ < var_264_16 + var_264_26 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play410211065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410211065
		arg_265_1.duration_ = 9.4

		local var_265_0 = {
			ja = 8.9,
			CriLanguages = 9.4,
			zh = 9.4
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play410211066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1061"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.034

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 1, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_8 = arg_265_1.actors_["10059"]
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps10059 == nil then
				arg_265_1.var_.actorSpriteComps10059 = var_268_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_10 = 0.034

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 and not isNil(var_268_8) then
				local var_268_11 = (arg_265_1.time_ - var_268_9) / var_268_10

				if arg_265_1.var_.actorSpriteComps10059 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								local var_268_12 = Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, var_268_11)
								local var_268_13 = Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, var_268_11)
								local var_268_14 = Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, var_268_11)

								iter_268_5.color = Color.New(var_268_12, var_268_13, var_268_14)
							else
								local var_268_15 = Mathf.Lerp(iter_268_5.color.r, 0.5, var_268_11)

								iter_268_5.color = Color.New(var_268_15, var_268_15, var_268_15)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps10059 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_268_7 then
						if arg_265_1.isInRecall_ then
							iter_268_7.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10059 = nil
			end

			local var_268_16 = 0
			local var_268_17 = 1.025

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_18 = arg_265_1:FormatText(StoryNameCfg[612].name)

				arg_265_1.leftNameTxt_.text = var_268_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_19 = arg_265_1:GetWordFromCfg(410211065)
				local var_268_20 = arg_265_1:FormatText(var_268_19.content)

				arg_265_1.text_.text = var_268_20

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_21 = 41
				local var_268_22 = utf8.len(var_268_20)
				local var_268_23 = var_268_21 <= 0 and var_268_17 or var_268_17 * (var_268_22 / var_268_21)

				if var_268_23 > 0 and var_268_17 < var_268_23 then
					arg_265_1.talkMaxDuration = var_268_23

					if var_268_23 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_16
					end
				end

				arg_265_1.text_.text = var_268_20
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") ~= 0 then
					local var_268_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") / 1000

					if var_268_24 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_24 + var_268_16
					end

					if var_268_19.prefab_name ~= "" and arg_265_1.actors_[var_268_19.prefab_name] ~= nil then
						local var_268_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_19.prefab_name].transform, "story_v_out_410211", "410211065", "story_v_out_410211.awb")

						arg_265_1:RecordAudio("410211065", var_268_25)
						arg_265_1:RecordAudio("410211065", var_268_25)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410211", "410211065", "story_v_out_410211.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410211", "410211065", "story_v_out_410211.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_26 = math.max(var_268_17, arg_265_1.talkMaxDuration)

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_16) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_16 + var_268_26 and arg_265_1.time_ < var_268_16 + var_268_26 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410211066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410211066
		arg_269_1.duration_ = 6

		local var_269_0 = {
			ja = 6,
			CriLanguages = 1.466,
			zh = 1.466
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play410211067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1061"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.034

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 0.5, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_8 = arg_269_1.actors_["10059"]
			local var_272_9 = 0

			if var_272_9 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10059 == nil then
				arg_269_1.var_.actorSpriteComps10059 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_10 = 0.034

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_10 and not isNil(var_272_8) then
				local var_272_11 = (arg_269_1.time_ - var_272_9) / var_272_10

				if arg_269_1.var_.actorSpriteComps10059 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								local var_272_12 = Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor1.r, var_272_11)
								local var_272_13 = Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor1.g, var_272_11)
								local var_272_14 = Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor1.b, var_272_11)

								iter_272_5.color = Color.New(var_272_12, var_272_13, var_272_14)
							else
								local var_272_15 = Mathf.Lerp(iter_272_5.color.r, 1, var_272_11)

								iter_272_5.color = Color.New(var_272_15, var_272_15, var_272_15)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_9 + var_272_10 and arg_269_1.time_ < var_272_9 + var_272_10 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10059 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_272_7 then
						if arg_269_1.isInRecall_ then
							iter_272_7.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10059 = nil
			end

			local var_272_16 = 0
			local var_272_17 = 0.2

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_18 = arg_269_1:FormatText(StoryNameCfg[596].name)

				arg_269_1.leftNameTxt_.text = var_272_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_19 = arg_269_1:GetWordFromCfg(410211066)
				local var_272_20 = arg_269_1:FormatText(var_272_19.content)

				arg_269_1.text_.text = var_272_20

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_21 = 8
				local var_272_22 = utf8.len(var_272_20)
				local var_272_23 = var_272_21 <= 0 and var_272_17 or var_272_17 * (var_272_22 / var_272_21)

				if var_272_23 > 0 and var_272_17 < var_272_23 then
					arg_269_1.talkMaxDuration = var_272_23

					if var_272_23 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_16
					end
				end

				arg_269_1.text_.text = var_272_20
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") ~= 0 then
					local var_272_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") / 1000

					if var_272_24 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_24 + var_272_16
					end

					if var_272_19.prefab_name ~= "" and arg_269_1.actors_[var_272_19.prefab_name] ~= nil then
						local var_272_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_19.prefab_name].transform, "story_v_out_410211", "410211066", "story_v_out_410211.awb")

						arg_269_1:RecordAudio("410211066", var_272_25)
						arg_269_1:RecordAudio("410211066", var_272_25)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410211", "410211066", "story_v_out_410211.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410211", "410211066", "story_v_out_410211.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_26 = math.max(var_272_17, arg_269_1.talkMaxDuration)

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_26 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_16) / var_272_26

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_16 + var_272_26 and arg_269_1.time_ < var_272_16 + var_272_26 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410211067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410211067
		arg_273_1.duration_ = 3.2

		local var_273_0 = {
			ja = 3.2,
			CriLanguages = 1.4,
			zh = 1.4
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play410211068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1061"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.034

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								local var_276_4 = Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor1.r, var_276_3)
								local var_276_5 = Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor1.g, var_276_3)
								local var_276_6 = Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor1.b, var_276_3)

								iter_276_1.color = Color.New(var_276_4, var_276_5, var_276_6)
							else
								local var_276_7 = Mathf.Lerp(iter_276_1.color.r, 1, var_276_3)

								iter_276_1.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_3 then
						if arg_273_1.isInRecall_ then
							iter_276_3.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_8 = arg_273_1.actors_["10059"]
			local var_276_9 = 0

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.actorSpriteComps10059 == nil then
				arg_273_1.var_.actorSpriteComps10059 = var_276_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_10 = 0.034

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_10 and not isNil(var_276_8) then
				local var_276_11 = (arg_273_1.time_ - var_276_9) / var_276_10

				if arg_273_1.var_.actorSpriteComps10059 then
					for iter_276_4, iter_276_5 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_276_5 then
							if arg_273_1.isInRecall_ then
								local var_276_12 = Mathf.Lerp(iter_276_5.color.r, arg_273_1.hightColor2.r, var_276_11)
								local var_276_13 = Mathf.Lerp(iter_276_5.color.g, arg_273_1.hightColor2.g, var_276_11)
								local var_276_14 = Mathf.Lerp(iter_276_5.color.b, arg_273_1.hightColor2.b, var_276_11)

								iter_276_5.color = Color.New(var_276_12, var_276_13, var_276_14)
							else
								local var_276_15 = Mathf.Lerp(iter_276_5.color.r, 0.5, var_276_11)

								iter_276_5.color = Color.New(var_276_15, var_276_15, var_276_15)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_9 + var_276_10 and arg_273_1.time_ < var_276_9 + var_276_10 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.actorSpriteComps10059 then
				for iter_276_6, iter_276_7 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_276_7 then
						if arg_273_1.isInRecall_ then
							iter_276_7.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10059 = nil
			end

			local var_276_16 = 0
			local var_276_17 = 0.175

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_18 = arg_273_1:FormatText(StoryNameCfg[612].name)

				arg_273_1.leftNameTxt_.text = var_276_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_19 = arg_273_1:GetWordFromCfg(410211067)
				local var_276_20 = arg_273_1:FormatText(var_276_19.content)

				arg_273_1.text_.text = var_276_20

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_21 = 7
				local var_276_22 = utf8.len(var_276_20)
				local var_276_23 = var_276_21 <= 0 and var_276_17 or var_276_17 * (var_276_22 / var_276_21)

				if var_276_23 > 0 and var_276_17 < var_276_23 then
					arg_273_1.talkMaxDuration = var_276_23

					if var_276_23 + var_276_16 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_16
					end
				end

				arg_273_1.text_.text = var_276_20
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") ~= 0 then
					local var_276_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") / 1000

					if var_276_24 + var_276_16 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_24 + var_276_16
					end

					if var_276_19.prefab_name ~= "" and arg_273_1.actors_[var_276_19.prefab_name] ~= nil then
						local var_276_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_19.prefab_name].transform, "story_v_out_410211", "410211067", "story_v_out_410211.awb")

						arg_273_1:RecordAudio("410211067", var_276_25)
						arg_273_1:RecordAudio("410211067", var_276_25)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410211", "410211067", "story_v_out_410211.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410211", "410211067", "story_v_out_410211.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_26 = math.max(var_276_17, arg_273_1.talkMaxDuration)

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_26 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_16) / var_276_26

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_16 + var_276_26 and arg_273_1.time_ < var_276_16 + var_276_26 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play410211068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410211068
		arg_277_1.duration_ = 13.1

		local var_277_0 = {
			ja = 13.1,
			CriLanguages = 9.066,
			zh = 9.066
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play410211069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1061"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 2)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(-390, -490, 18)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_280_7 = arg_277_1.actors_["1061"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 1, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 1.1

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[612].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(410211068)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 44
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_410211", "410211068", "story_v_out_410211.awb")

						arg_277_1:RecordAudio("410211068", var_280_24)
						arg_277_1:RecordAudio("410211068", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410211", "410211068", "story_v_out_410211.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410211", "410211068", "story_v_out_410211.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410211069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410211069
		arg_281_1.duration_ = 8.1

		local var_281_0 = {
			ja = 8.1,
			CriLanguages = 5.066,
			zh = 5.066
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
				arg_281_0:Play410211070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1061"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1061 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1061", 2)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(-390, -490, 18)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1061, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_284_7 = arg_281_1.actors_["1061"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.034

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								local var_284_11 = Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, var_284_10)
								local var_284_12 = Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, var_284_10)
								local var_284_13 = Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, var_284_10)

								iter_284_2.color = Color.New(var_284_11, var_284_12, var_284_13)
							else
								local var_284_14 = Mathf.Lerp(iter_284_2.color.r, 1, var_284_10)

								iter_284_2.color = Color.New(var_284_14, var_284_14, var_284_14)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_4 then
						if arg_281_1.isInRecall_ then
							iter_284_4.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_15 = 0
			local var_284_16 = 0.675

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[612].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(410211069)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 27
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_410211", "410211069", "story_v_out_410211.awb")

						arg_281_1:RecordAudio("410211069", var_284_24)
						arg_281_1:RecordAudio("410211069", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410211", "410211069", "story_v_out_410211.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410211", "410211069", "story_v_out_410211.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play410211070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410211070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410211071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1061"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.034

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 0.5, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 1.325

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(410211070)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_12 = 53
				local var_288_13 = utf8.len(var_288_11)
				local var_288_14 = var_288_12 <= 0 and var_288_9 or var_288_9 * (var_288_13 / var_288_12)

				if var_288_14 > 0 and var_288_9 < var_288_14 then
					arg_285_1.talkMaxDuration = var_288_14

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_15 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_15 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_15

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_15 and arg_285_1.time_ < var_288_8 + var_288_15 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play410211071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410211071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410211072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.225

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(410211071)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 49
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play410211072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410211072
		arg_293_1.duration_ = 1.5

		local var_293_0 = {
			ja = 1.5,
			CriLanguages = 1.133,
			zh = 1.133
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
				arg_293_0:Play410211073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1061"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1061 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1061", 2)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "split_5" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(-390, -490, 18)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1061, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_296_7 = arg_293_1.actors_["1061"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1061 == nil then
				arg_293_1.var_.actorSpriteComps1061 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps1061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								local var_296_11 = Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, var_296_10)
								local var_296_12 = Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, var_296_10)
								local var_296_13 = Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, var_296_10)

								iter_296_2.color = Color.New(var_296_11, var_296_12, var_296_13)
							else
								local var_296_14 = Mathf.Lerp(iter_296_2.color.r, 1, var_296_10)

								iter_296_2.color = Color.New(var_296_14, var_296_14, var_296_14)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1061 = nil
			end

			local var_296_15 = 0
			local var_296_16 = 0.125

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[612].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(410211072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_410211", "410211072", "story_v_out_410211.awb")

						arg_293_1:RecordAudio("410211072", var_296_24)
						arg_293_1:RecordAudio("410211072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410211", "410211072", "story_v_out_410211.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410211", "410211072", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410211073
		arg_297_1.duration_ = 9.17

		local var_297_0 = {
			ja = 9.166,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_297_0:Play410211074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1061"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.034

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 0.5, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_8 = arg_297_1.actors_["10059"]
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps10059 == nil then
				arg_297_1.var_.actorSpriteComps10059 = var_300_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_10 = 0.034

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 and not isNil(var_300_8) then
				local var_300_11 = (arg_297_1.time_ - var_300_9) / var_300_10

				if arg_297_1.var_.actorSpriteComps10059 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								local var_300_12 = Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor1.r, var_300_11)
								local var_300_13 = Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor1.g, var_300_11)
								local var_300_14 = Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor1.b, var_300_11)

								iter_300_5.color = Color.New(var_300_12, var_300_13, var_300_14)
							else
								local var_300_15 = Mathf.Lerp(iter_300_5.color.r, 1, var_300_11)

								iter_300_5.color = Color.New(var_300_15, var_300_15, var_300_15)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps10059 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_300_7 then
						if arg_297_1.isInRecall_ then
							iter_300_7.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10059 = nil
			end

			local var_300_16 = 0
			local var_300_17 = 0.675

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_18 = arg_297_1:FormatText(StoryNameCfg[596].name)

				arg_297_1.leftNameTxt_.text = var_300_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_19 = arg_297_1:GetWordFromCfg(410211073)
				local var_300_20 = arg_297_1:FormatText(var_300_19.content)

				arg_297_1.text_.text = var_300_20

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_21 = 27
				local var_300_22 = utf8.len(var_300_20)
				local var_300_23 = var_300_21 <= 0 and var_300_17 or var_300_17 * (var_300_22 / var_300_21)

				if var_300_23 > 0 and var_300_17 < var_300_23 then
					arg_297_1.talkMaxDuration = var_300_23

					if var_300_23 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_16
					end
				end

				arg_297_1.text_.text = var_300_20
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") ~= 0 then
					local var_300_24 = manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") / 1000

					if var_300_24 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_16
					end

					if var_300_19.prefab_name ~= "" and arg_297_1.actors_[var_300_19.prefab_name] ~= nil then
						local var_300_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_19.prefab_name].transform, "story_v_out_410211", "410211073", "story_v_out_410211.awb")

						arg_297_1:RecordAudio("410211073", var_300_25)
						arg_297_1:RecordAudio("410211073", var_300_25)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410211", "410211073", "story_v_out_410211.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410211", "410211073", "story_v_out_410211.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_26 = math.max(var_300_17, arg_297_1.talkMaxDuration)

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_26 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_16) / var_300_26

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_16 + var_300_26 and arg_297_1.time_ < var_300_16 + var_300_26 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410211074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410211074
		arg_301_1.duration_ = 2.83

		local var_301_0 = {
			ja = 2.833,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_301_0:Play410211075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1061"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1061 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1061", 2)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(-390, -490, 18)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1061, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_304_7 = arg_301_1.actors_["1061"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 0.034

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								local var_304_11 = Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, var_304_10)
								local var_304_12 = Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, var_304_10)
								local var_304_13 = Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, var_304_10)

								iter_304_2.color = Color.New(var_304_11, var_304_12, var_304_13)
							else
								local var_304_14 = Mathf.Lerp(iter_304_2.color.r, 1, var_304_10)

								iter_304_2.color = Color.New(var_304_14, var_304_14, var_304_14)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_4 then
						if arg_301_1.isInRecall_ then
							iter_304_4.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_15 = arg_301_1.actors_["10059"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps10059 == nil then
				arg_301_1.var_.actorSpriteComps10059 = var_304_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_17 = 0.034

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.actorSpriteComps10059 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_304_6 then
							if arg_301_1.isInRecall_ then
								local var_304_19 = Mathf.Lerp(iter_304_6.color.r, arg_301_1.hightColor2.r, var_304_18)
								local var_304_20 = Mathf.Lerp(iter_304_6.color.g, arg_301_1.hightColor2.g, var_304_18)
								local var_304_21 = Mathf.Lerp(iter_304_6.color.b, arg_301_1.hightColor2.b, var_304_18)

								iter_304_6.color = Color.New(var_304_19, var_304_20, var_304_21)
							else
								local var_304_22 = Mathf.Lerp(iter_304_6.color.r, 0.5, var_304_18)

								iter_304_6.color = Color.New(var_304_22, var_304_22, var_304_22)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps10059 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_304_8 then
						if arg_301_1.isInRecall_ then
							iter_304_8.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10059 = nil
			end

			local var_304_23 = 0
			local var_304_24 = 0.225

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[612].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(410211074)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_410211", "410211074", "story_v_out_410211.awb")

						arg_301_1:RecordAudio("410211074", var_304_32)
						arg_301_1:RecordAudio("410211074", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410211", "410211074", "story_v_out_410211.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410211", "410211074", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410211075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
			arg_305_1.auto_ = false
		end

		function arg_305_1.playNext_(arg_307_0)
			arg_305_1.onStoryFinished_()
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1061"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1061 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1061", 7)

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
				local var_308_6 = Vector3.New(0, -2000, 18)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1061, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_308_7 = arg_305_1.actors_["10059"].transform
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.var_.moveOldPos10059 = var_308_7.localPosition
				var_308_7.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10059", 7)

				local var_308_9 = var_308_7.childCount

				for iter_308_1 = 0, var_308_9 - 1 do
					local var_308_10 = var_308_7:GetChild(iter_308_1)

					if var_308_10.name == "" or not string.find(var_308_10.name, "split") then
						var_308_10.gameObject:SetActive(true)
					else
						var_308_10.gameObject:SetActive(false)
					end
				end
			end

			local var_308_11 = 0.001

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_11 then
				local var_308_12 = (arg_305_1.time_ - var_308_8) / var_308_11
				local var_308_13 = Vector3.New(0, -2000, 35)

				var_308_7.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10059, var_308_13, var_308_12)
			end

			if arg_305_1.time_ >= var_308_8 + var_308_11 and arg_305_1.time_ < var_308_8 + var_308_11 + arg_308_0 then
				var_308_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_308_14 = 0
			local var_308_15 = 0.975

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_16 = arg_305_1:GetWordFromCfg(410211075)
				local var_308_17 = arg_305_1:FormatText(var_308_16.content)

				arg_305_1.text_.text = var_308_17

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_18 = 39
				local var_308_19 = utf8.len(var_308_17)
				local var_308_20 = var_308_18 <= 0 and var_308_15 or var_308_15 * (var_308_19 / var_308_18)

				if var_308_20 > 0 and var_308_15 < var_308_20 then
					arg_305_1.talkMaxDuration = var_308_20

					if var_308_20 + var_308_14 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_14
					end
				end

				arg_305_1.text_.text = var_308_17
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_21 = math.max(var_308_15, arg_305_1.talkMaxDuration)

			if var_308_14 <= arg_305_1.time_ and arg_305_1.time_ < var_308_14 + var_308_21 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_14) / var_308_21

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_14 + var_308_21 and arg_305_1.time_ < var_308_14 + var_308_21 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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

		arg_305_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST66",
		"TextureConfig/Background/ST64a",
		"TextureConfig/Background/L04i"
	},
	voices = {
		"story_v_out_410211.awb"
	}
}
