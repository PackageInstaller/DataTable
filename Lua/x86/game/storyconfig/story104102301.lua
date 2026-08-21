return {
	Play410231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410231001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST63"

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
				local var_4_5 = arg_1_1.bgs_.ST63

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
					if iter_4_0 ~= "ST63" then
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
			local var_4_35 = 0.675

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

				local var_4_37 = arg_1_1:GetWordFromCfg(410231001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 27
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
	Play410231002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410231002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410231003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1

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

				local var_12_2 = arg_9_1:GetWordFromCfg(410231002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 40
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
	Play410231003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410231003
		arg_13_1.duration_ = 6.57

		local var_13_0 = {
			ja = 6.2,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_13_0:Play410231004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1061"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

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

			local var_16_4 = arg_13_1.actors_["1061"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 3)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_7" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(0, -490, 18)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -490, 18)
			end

			local var_16_11 = arg_13_1.actors_["1061"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_19 = 0
			local var_16_20 = 0.45

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[612].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(410231003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231003", "story_v_out_410231.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_410231", "410231003", "story_v_out_410231.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_410231", "410231003", "story_v_out_410231.awb")

						arg_13_1:RecordAudio("410231003", var_16_28)
						arg_13_1:RecordAudio("410231003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410231", "410231003", "story_v_out_410231.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410231", "410231003", "story_v_out_410231.awb")
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
				actorName = "1061",
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
	Play410231004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410231004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410231005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1061"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.034

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 1.1

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(410231004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 44
				local var_20_13 = utf8.len(var_20_11)
				local var_20_14 = var_20_12 <= 0 and var_20_9 or var_20_9 * (var_20_13 / var_20_12)

				if var_20_14 > 0 and var_20_9 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_15 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_15

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_15 and arg_17_1.time_ < var_20_8 + var_20_15 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410231005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410231005
		arg_21_1.duration_ = 6

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play410231006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.166666666666667

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "play"
				local var_24_3 = "effect"

				arg_21_1:AudioAction(var_24_2, var_24_3, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_24_4 = arg_21_1.actors_["1061"].transform
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_4.localPosition
				var_24_4.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 7)

				local var_24_6 = var_24_4.childCount

				for iter_24_0 = 0, var_24_6 - 1 do
					local var_24_7 = var_24_4:GetChild(iter_24_0)

					if var_24_7.name == "" or not string.find(var_24_7.name, "split") then
						var_24_7.gameObject:SetActive(true)
					else
						var_24_7.gameObject:SetActive(false)
					end
				end
			end

			local var_24_8 = 0.001

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_5) / var_24_8
				local var_24_10 = Vector3.New(0, -2000, 18)

				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, var_24_10, var_24_9)
			end

			if arg_21_1.time_ >= var_24_5 + var_24_8 and arg_21_1.time_ < var_24_5 + var_24_8 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_24_11 = 0

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_12 = 1

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_11) / var_24_12
				local var_24_14 = Color.New(1, 1, 1)

				var_24_14.a = Mathf.Lerp(1, 0, var_24_13)
				arg_21_1.mask_.color = var_24_14
			end

			if arg_21_1.time_ >= var_24_11 + var_24_12 and arg_21_1.time_ < var_24_11 + var_24_12 + arg_24_0 then
				local var_24_15 = Color.New(1, 1, 1)
				local var_24_16 = 0

				arg_21_1.mask_.enabled = false
				var_24_15.a = var_24_16
				arg_21_1.mask_.color = var_24_15
			end

			local var_24_17 = manager.ui.mainCamera.transform
			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_17.localPosition
			end

			local var_24_19 = 1.5

			if var_24_18 <= arg_21_1.time_ and arg_21_1.time_ < var_24_18 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_18) / 0.066
				local var_24_21, var_24_22 = math.modf(var_24_20)

				var_24_17.localPosition = Vector3.New(var_24_22 * 0.13, var_24_22 * 0.13, var_24_22 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= var_24_18 + var_24_19 and arg_21_1.time_ < var_24_18 + var_24_19 + arg_24_0 then
				var_24_17.localPosition = arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_23 = 1
			local var_24_24 = 0.075

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_25 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_25:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(410231005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 3
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30
					var_24_23 = var_24_23 + 0.3

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_31 = var_24_23 + 0.3
			local var_24_32 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_31 <= arg_21_1.time_ and arg_21_1.time_ < var_24_31 + var_24_32 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_31) / var_24_32

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_31 + var_24_32 and arg_21_1.time_ < var_24_31 + var_24_32 + arg_24_0 then
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
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play410231006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 410231006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play410231007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 1.775

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(410231006)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 71
				local var_30_5 = utf8.len(var_30_3)
				local var_30_6 = var_30_4 <= 0 and var_30_1 or var_30_1 * (var_30_5 / var_30_4)

				if var_30_6 > 0 and var_30_1 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_7 and arg_27_1.time_ < var_30_0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play410231007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 410231007
		arg_31_1.duration_ = 6.97

		local var_31_0 = {
			ja = 6.966,
			CriLanguages = 6.933,
			zh = 6.933
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play410231008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1061"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1061 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1061", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "split_7" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(0, -490, 18)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1061, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_34_7 = arg_31_1.actors_["1061"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.actorSpriteComps1061 == nil then
				arg_31_1.var_.actorSpriteComps1061 = var_34_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_9 = 0.034

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 and not isNil(var_34_7) then
				local var_34_10 = (arg_31_1.time_ - var_34_8) / var_34_9

				if arg_31_1.var_.actorSpriteComps1061 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_34_2 then
							if arg_31_1.isInRecall_ then
								local var_34_11 = Mathf.Lerp(iter_34_2.color.r, arg_31_1.hightColor1.r, var_34_10)
								local var_34_12 = Mathf.Lerp(iter_34_2.color.g, arg_31_1.hightColor1.g, var_34_10)
								local var_34_13 = Mathf.Lerp(iter_34_2.color.b, arg_31_1.hightColor1.b, var_34_10)

								iter_34_2.color = Color.New(var_34_11, var_34_12, var_34_13)
							else
								local var_34_14 = Mathf.Lerp(iter_34_2.color.r, 1, var_34_10)

								iter_34_2.color = Color.New(var_34_14, var_34_14, var_34_14)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.actorSpriteComps1061 then
				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_34_4 then
						if arg_31_1.isInRecall_ then
							iter_34_4.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps1061 = nil
			end

			local var_34_15 = 0
			local var_34_16 = 0.775

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[612].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(410231007)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 31
				local var_34_21 = utf8.len(var_34_19)
				local var_34_22 = var_34_20 <= 0 and var_34_16 or var_34_16 * (var_34_21 / var_34_20)

				if var_34_22 > 0 and var_34_16 < var_34_22 then
					arg_31_1.talkMaxDuration = var_34_22

					if var_34_22 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_19
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231007", "story_v_out_410231.awb") ~= 0 then
					local var_34_23 = manager.audio:GetVoiceLength("story_v_out_410231", "410231007", "story_v_out_410231.awb") / 1000

					if var_34_23 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_15
					end

					if var_34_18.prefab_name ~= "" and arg_31_1.actors_[var_34_18.prefab_name] ~= nil then
						local var_34_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_18.prefab_name].transform, "story_v_out_410231", "410231007", "story_v_out_410231.awb")

						arg_31_1:RecordAudio("410231007", var_34_24)
						arg_31_1:RecordAudio("410231007", var_34_24)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_410231", "410231007", "story_v_out_410231.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_410231", "410231007", "story_v_out_410231.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_25 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_25 and arg_31_1.time_ < var_34_15 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play410231008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 410231008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play410231009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1061"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1061 = var_38_0.localPosition
				var_38_0.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1061", 7)

				local var_38_2 = var_38_0.childCount

				for iter_38_0 = 0, var_38_2 - 1 do
					local var_38_3 = var_38_0:GetChild(iter_38_0)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_1) / var_38_4
				local var_38_6 = Vector3.New(0, -2000, 18)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1061, var_38_6, var_38_5)
			end

			if arg_35_1.time_ >= var_38_1 + var_38_4 and arg_35_1.time_ < var_38_1 + var_38_4 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_38_7 = 0
			local var_38_8 = 1.125

			if var_38_7 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_9 = arg_35_1:GetWordFromCfg(410231008)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 45
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_8 or var_38_8 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_8 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_7 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_7
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_8, arg_35_1.talkMaxDuration)

			if var_38_7 <= arg_35_1.time_ and arg_35_1.time_ < var_38_7 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_7) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_7 + var_38_14 and arg_35_1.time_ < var_38_7 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play410231009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 410231009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play410231010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.65

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(410231009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 26
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play410231010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 410231010
		arg_43_1.duration_ = 6.97

		local var_43_0 = {
			ja = 3.966,
			CriLanguages = 6.966,
			zh = 6.966
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
				arg_43_0:Play410231011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1061"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1061 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1061", 2)

				local var_46_2 = var_46_0.childCount

				for iter_46_0 = 0, var_46_2 - 1 do
					local var_46_3 = var_46_0:GetChild(iter_46_0)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_4 then
				local var_46_5 = (arg_43_1.time_ - var_46_1) / var_46_4
				local var_46_6 = Vector3.New(-390, -490, 18)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1061, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_46_7 = arg_43_1.actors_["1061"]
			local var_46_8 = 0

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps1061 == nil then
				arg_43_1.var_.actorSpriteComps1061 = var_46_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 0.034

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 and not isNil(var_46_7) then
				local var_46_10 = (arg_43_1.time_ - var_46_8) / var_46_9

				if arg_43_1.var_.actorSpriteComps1061 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								local var_46_11 = Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor1.r, var_46_10)
								local var_46_12 = Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor1.g, var_46_10)
								local var_46_13 = Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor1.b, var_46_10)

								iter_46_2.color = Color.New(var_46_11, var_46_12, var_46_13)
							else
								local var_46_14 = Mathf.Lerp(iter_46_2.color.r, 1, var_46_10)

								iter_46_2.color = Color.New(var_46_14, var_46_14, var_46_14)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps1061 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_46_4 then
						if arg_43_1.isInRecall_ then
							iter_46_4.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1061 = nil
			end

			local var_46_15 = "10059"

			if arg_43_1.actors_[var_46_15] == nil then
				local var_46_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_46_16) then
					local var_46_17 = Object.Instantiate(var_46_16, arg_43_1.canvasGo_.transform)

					var_46_17.transform:SetSiblingIndex(1)

					var_46_17.name = var_46_15
					var_46_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_15] = var_46_17

					local var_46_18 = var_46_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_43_1.isInRecall_ then
						for iter_46_5, iter_46_6 in ipairs(var_46_18) do
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_19 = arg_43_1.actors_["10059"].transform
			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				arg_43_1.var_.moveOldPos10059 = var_46_19.localPosition
				var_46_19.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10059", 4)

				local var_46_21 = var_46_19.childCount

				for iter_46_7 = 0, var_46_21 - 1 do
					local var_46_22 = var_46_19:GetChild(iter_46_7)

					if var_46_22.name == "" or not string.find(var_46_22.name, "split") then
						var_46_22.gameObject:SetActive(true)
					else
						var_46_22.gameObject:SetActive(false)
					end
				end
			end

			local var_46_23 = 0.001

			if var_46_20 <= arg_43_1.time_ and arg_43_1.time_ < var_46_20 + var_46_23 then
				local var_46_24 = (arg_43_1.time_ - var_46_20) / var_46_23
				local var_46_25 = Vector3.New(390, -530, 35)

				var_46_19.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10059, var_46_25, var_46_24)
			end

			if arg_43_1.time_ >= var_46_20 + var_46_23 and arg_43_1.time_ < var_46_20 + var_46_23 + arg_46_0 then
				var_46_19.localPosition = Vector3.New(390, -530, 35)
			end

			local var_46_26 = arg_43_1.actors_["10059"]
			local var_46_27 = 0

			if var_46_27 < arg_43_1.time_ and arg_43_1.time_ <= var_46_27 + arg_46_0 and not isNil(var_46_26) and arg_43_1.var_.actorSpriteComps10059 == nil then
				arg_43_1.var_.actorSpriteComps10059 = var_46_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_28 = 0.034

			if var_46_27 <= arg_43_1.time_ and arg_43_1.time_ < var_46_27 + var_46_28 and not isNil(var_46_26) then
				local var_46_29 = (arg_43_1.time_ - var_46_27) / var_46_28

				if arg_43_1.var_.actorSpriteComps10059 then
					for iter_46_8, iter_46_9 in pairs(arg_43_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_46_9 then
							if arg_43_1.isInRecall_ then
								local var_46_30 = Mathf.Lerp(iter_46_9.color.r, arg_43_1.hightColor2.r, var_46_29)
								local var_46_31 = Mathf.Lerp(iter_46_9.color.g, arg_43_1.hightColor2.g, var_46_29)
								local var_46_32 = Mathf.Lerp(iter_46_9.color.b, arg_43_1.hightColor2.b, var_46_29)

								iter_46_9.color = Color.New(var_46_30, var_46_31, var_46_32)
							else
								local var_46_33 = Mathf.Lerp(iter_46_9.color.r, 0.5, var_46_29)

								iter_46_9.color = Color.New(var_46_33, var_46_33, var_46_33)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_27 + var_46_28 and arg_43_1.time_ < var_46_27 + var_46_28 + arg_46_0 and not isNil(var_46_26) and arg_43_1.var_.actorSpriteComps10059 then
				for iter_46_10, iter_46_11 in pairs(arg_43_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_46_11 then
						if arg_43_1.isInRecall_ then
							iter_46_11.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10059 = nil
			end

			local var_46_34 = 0
			local var_46_35 = 0.7

			if var_46_34 < arg_43_1.time_ and arg_43_1.time_ <= var_46_34 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_36 = arg_43_1:FormatText(StoryNameCfg[612].name)

				arg_43_1.leftNameTxt_.text = var_46_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_37 = arg_43_1:GetWordFromCfg(410231010)
				local var_46_38 = arg_43_1:FormatText(var_46_37.content)

				arg_43_1.text_.text = var_46_38

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_39 = 28
				local var_46_40 = utf8.len(var_46_38)
				local var_46_41 = var_46_39 <= 0 and var_46_35 or var_46_35 * (var_46_40 / var_46_39)

				if var_46_41 > 0 and var_46_35 < var_46_41 then
					arg_43_1.talkMaxDuration = var_46_41

					if var_46_41 + var_46_34 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_41 + var_46_34
					end
				end

				arg_43_1.text_.text = var_46_38
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231010", "story_v_out_410231.awb") ~= 0 then
					local var_46_42 = manager.audio:GetVoiceLength("story_v_out_410231", "410231010", "story_v_out_410231.awb") / 1000

					if var_46_42 + var_46_34 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_42 + var_46_34
					end

					if var_46_37.prefab_name ~= "" and arg_43_1.actors_[var_46_37.prefab_name] ~= nil then
						local var_46_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_37.prefab_name].transform, "story_v_out_410231", "410231010", "story_v_out_410231.awb")

						arg_43_1:RecordAudio("410231010", var_46_43)
						arg_43_1:RecordAudio("410231010", var_46_43)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_410231", "410231010", "story_v_out_410231.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_410231", "410231010", "story_v_out_410231.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_44 = math.max(var_46_35, arg_43_1.talkMaxDuration)

			if var_46_34 <= arg_43_1.time_ and arg_43_1.time_ < var_46_34 + var_46_44 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_34) / var_46_44

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_34 + var_46_44 and arg_43_1.time_ < var_46_34 + var_46_44 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play410231011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 410231011
		arg_47_1.duration_ = 5.67

		local var_47_0 = {
			ja = 5.666,
			CriLanguages = 2.933,
			zh = 2.933
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play410231012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10059"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10059 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10059", 4)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_3" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(390, -530, 35)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10059, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_50_7 = arg_47_1.actors_["10059"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10059 == nil then
				arg_47_1.var_.actorSpriteComps10059 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 0.034

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 and not isNil(var_50_7) then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps10059 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								local var_50_11 = Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, var_50_10)
								local var_50_12 = Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, var_50_10)
								local var_50_13 = Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, var_50_10)

								iter_50_2.color = Color.New(var_50_11, var_50_12, var_50_13)
							else
								local var_50_14 = Mathf.Lerp(iter_50_2.color.r, 1, var_50_10)

								iter_50_2.color = Color.New(var_50_14, var_50_14, var_50_14)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10059 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_50_4 then
						if arg_47_1.isInRecall_ then
							iter_50_4.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10059 = nil
			end

			local var_50_15 = arg_47_1.actors_["1061"]
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps1061 == nil then
				arg_47_1.var_.actorSpriteComps1061 = var_50_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_17 = 0.034

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 and not isNil(var_50_15) then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17

				if arg_47_1.var_.actorSpriteComps1061 then
					for iter_50_5, iter_50_6 in pairs(arg_47_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_50_6 then
							if arg_47_1.isInRecall_ then
								local var_50_19 = Mathf.Lerp(iter_50_6.color.r, arg_47_1.hightColor2.r, var_50_18)
								local var_50_20 = Mathf.Lerp(iter_50_6.color.g, arg_47_1.hightColor2.g, var_50_18)
								local var_50_21 = Mathf.Lerp(iter_50_6.color.b, arg_47_1.hightColor2.b, var_50_18)

								iter_50_6.color = Color.New(var_50_19, var_50_20, var_50_21)
							else
								local var_50_22 = Mathf.Lerp(iter_50_6.color.r, 0.5, var_50_18)

								iter_50_6.color = Color.New(var_50_22, var_50_22, var_50_22)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps1061 then
				for iter_50_7, iter_50_8 in pairs(arg_47_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_50_8 then
						if arg_47_1.isInRecall_ then
							iter_50_8.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1061 = nil
			end

			local var_50_23 = 0
			local var_50_24 = 0.375

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_25 = arg_47_1:FormatText(StoryNameCfg[596].name)

				arg_47_1.leftNameTxt_.text = var_50_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_26 = arg_47_1:GetWordFromCfg(410231011)
				local var_50_27 = arg_47_1:FormatText(var_50_26.content)

				arg_47_1.text_.text = var_50_27

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_28 = 15
				local var_50_29 = utf8.len(var_50_27)
				local var_50_30 = var_50_28 <= 0 and var_50_24 or var_50_24 * (var_50_29 / var_50_28)

				if var_50_30 > 0 and var_50_24 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30

					if var_50_30 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_23
					end
				end

				arg_47_1.text_.text = var_50_27
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231011", "story_v_out_410231.awb") ~= 0 then
					local var_50_31 = manager.audio:GetVoiceLength("story_v_out_410231", "410231011", "story_v_out_410231.awb") / 1000

					if var_50_31 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_31 + var_50_23
					end

					if var_50_26.prefab_name ~= "" and arg_47_1.actors_[var_50_26.prefab_name] ~= nil then
						local var_50_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_26.prefab_name].transform, "story_v_out_410231", "410231011", "story_v_out_410231.awb")

						arg_47_1:RecordAudio("410231011", var_50_32)
						arg_47_1:RecordAudio("410231011", var_50_32)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_410231", "410231011", "story_v_out_410231.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_410231", "410231011", "story_v_out_410231.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_33 = math.max(var_50_24, arg_47_1.talkMaxDuration)

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_33 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_23) / var_50_33

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_23 + var_50_33 and arg_47_1.time_ < var_50_23 + var_50_33 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play410231012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 410231012
		arg_51_1.duration_ = 6.07

		local var_51_0 = {
			ja = 6.066,
			CriLanguages = 4.266,
			zh = 4.266
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play410231013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.575

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[596].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(410231012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 23
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231012", "story_v_out_410231.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_410231", "410231012", "story_v_out_410231.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_410231", "410231012", "story_v_out_410231.awb")

						arg_51_1:RecordAudio("410231012", var_54_9)
						arg_51_1:RecordAudio("410231012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_410231", "410231012", "story_v_out_410231.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_410231", "410231012", "story_v_out_410231.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play410231013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 410231013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play410231014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10059"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10059 == nil then
				arg_55_1.var_.actorSpriteComps10059 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.034

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps10059 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 0.5, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10059 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10059 = nil
			end

			local var_58_8 = 0
			local var_58_9 = 1

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(410231013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 40
				local var_58_13 = utf8.len(var_58_11)
				local var_58_14 = var_58_12 <= 0 and var_58_9 or var_58_9 * (var_58_13 / var_58_12)

				if var_58_14 > 0 and var_58_9 < var_58_14 then
					arg_55_1.talkMaxDuration = var_58_14

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_15 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_15 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_15

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_15 and arg_55_1.time_ < var_58_8 + var_58_15 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play410231014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410231014
		arg_59_1.duration_ = 2.1

		local var_59_0 = {
			ja = 2.033,
			CriLanguages = 2.1,
			zh = 2.1
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play410231015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1061"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1061 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1061", 2)

				local var_62_2 = var_62_0.childCount

				for iter_62_0 = 0, var_62_2 - 1 do
					local var_62_3 = var_62_0:GetChild(iter_62_0)

					if var_62_3.name == "split_5" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_4 then
				local var_62_5 = (arg_59_1.time_ - var_62_1) / var_62_4
				local var_62_6 = Vector3.New(-390, -490, 18)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1061, var_62_6, var_62_5)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_4 and arg_59_1.time_ < var_62_1 + var_62_4 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_62_7 = arg_59_1.actors_["1061"]
			local var_62_8 = 0

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.actorSpriteComps1061 == nil then
				arg_59_1.var_.actorSpriteComps1061 = var_62_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_9 = 0.034

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 and not isNil(var_62_7) then
				local var_62_10 = (arg_59_1.time_ - var_62_8) / var_62_9

				if arg_59_1.var_.actorSpriteComps1061 then
					for iter_62_1, iter_62_2 in pairs(arg_59_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_62_2 then
							if arg_59_1.isInRecall_ then
								local var_62_11 = Mathf.Lerp(iter_62_2.color.r, arg_59_1.hightColor1.r, var_62_10)
								local var_62_12 = Mathf.Lerp(iter_62_2.color.g, arg_59_1.hightColor1.g, var_62_10)
								local var_62_13 = Mathf.Lerp(iter_62_2.color.b, arg_59_1.hightColor1.b, var_62_10)

								iter_62_2.color = Color.New(var_62_11, var_62_12, var_62_13)
							else
								local var_62_14 = Mathf.Lerp(iter_62_2.color.r, 1, var_62_10)

								iter_62_2.color = Color.New(var_62_14, var_62_14, var_62_14)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.actorSpriteComps1061 then
				for iter_62_3, iter_62_4 in pairs(arg_59_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_62_4 then
						if arg_59_1.isInRecall_ then
							iter_62_4.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1061 = nil
			end

			local var_62_15 = 0
			local var_62_16 = 0.125

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[612].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(410231014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 5
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231014", "story_v_out_410231.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_410231", "410231014", "story_v_out_410231.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_410231", "410231014", "story_v_out_410231.awb")

						arg_59_1:RecordAudio("410231014", var_62_24)
						arg_59_1:RecordAudio("410231014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_410231", "410231014", "story_v_out_410231.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_410231", "410231014", "story_v_out_410231.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play410231015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410231015
		arg_63_1.duration_ = 10.03

		local var_63_0 = {
			ja = 10.033,
			CriLanguages = 9.366,
			zh = 9.366
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play410231016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10059"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos10059 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10059", 4)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(390, -530, 35)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10059, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_66_7 = arg_63_1.actors_["10059"]
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10059 == nil then
				arg_63_1.var_.actorSpriteComps10059 = var_66_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_9 = 0.034

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 and not isNil(var_66_7) then
				local var_66_10 = (arg_63_1.time_ - var_66_8) / var_66_9

				if arg_63_1.var_.actorSpriteComps10059 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								local var_66_11 = Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, var_66_10)
								local var_66_12 = Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, var_66_10)
								local var_66_13 = Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, var_66_10)

								iter_66_2.color = Color.New(var_66_11, var_66_12, var_66_13)
							else
								local var_66_14 = Mathf.Lerp(iter_66_2.color.r, 1, var_66_10)

								iter_66_2.color = Color.New(var_66_14, var_66_14, var_66_14)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10059 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_66_4 then
						if arg_63_1.isInRecall_ then
							iter_66_4.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10059 = nil
			end

			local var_66_15 = arg_63_1.actors_["1061"]
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.actorSpriteComps1061 == nil then
				arg_63_1.var_.actorSpriteComps1061 = var_66_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_17 = 0.034

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 and not isNil(var_66_15) then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17

				if arg_63_1.var_.actorSpriteComps1061 then
					for iter_66_5, iter_66_6 in pairs(arg_63_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_66_6 then
							if arg_63_1.isInRecall_ then
								local var_66_19 = Mathf.Lerp(iter_66_6.color.r, arg_63_1.hightColor2.r, var_66_18)
								local var_66_20 = Mathf.Lerp(iter_66_6.color.g, arg_63_1.hightColor2.g, var_66_18)
								local var_66_21 = Mathf.Lerp(iter_66_6.color.b, arg_63_1.hightColor2.b, var_66_18)

								iter_66_6.color = Color.New(var_66_19, var_66_20, var_66_21)
							else
								local var_66_22 = Mathf.Lerp(iter_66_6.color.r, 0.5, var_66_18)

								iter_66_6.color = Color.New(var_66_22, var_66_22, var_66_22)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.actorSpriteComps1061 then
				for iter_66_7, iter_66_8 in pairs(arg_63_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_66_8 then
						if arg_63_1.isInRecall_ then
							iter_66_8.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1061 = nil
			end

			local var_66_23 = 0
			local var_66_24 = 0.975

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_25 = arg_63_1:FormatText(StoryNameCfg[596].name)

				arg_63_1.leftNameTxt_.text = var_66_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_26 = arg_63_1:GetWordFromCfg(410231015)
				local var_66_27 = arg_63_1:FormatText(var_66_26.content)

				arg_63_1.text_.text = var_66_27

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_28 = 39
				local var_66_29 = utf8.len(var_66_27)
				local var_66_30 = var_66_28 <= 0 and var_66_24 or var_66_24 * (var_66_29 / var_66_28)

				if var_66_30 > 0 and var_66_24 < var_66_30 then
					arg_63_1.talkMaxDuration = var_66_30

					if var_66_30 + var_66_23 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_30 + var_66_23
					end
				end

				arg_63_1.text_.text = var_66_27
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231015", "story_v_out_410231.awb") ~= 0 then
					local var_66_31 = manager.audio:GetVoiceLength("story_v_out_410231", "410231015", "story_v_out_410231.awb") / 1000

					if var_66_31 + var_66_23 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_31 + var_66_23
					end

					if var_66_26.prefab_name ~= "" and arg_63_1.actors_[var_66_26.prefab_name] ~= nil then
						local var_66_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_26.prefab_name].transform, "story_v_out_410231", "410231015", "story_v_out_410231.awb")

						arg_63_1:RecordAudio("410231015", var_66_32)
						arg_63_1:RecordAudio("410231015", var_66_32)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410231", "410231015", "story_v_out_410231.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410231", "410231015", "story_v_out_410231.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_33 = math.max(var_66_24, arg_63_1.talkMaxDuration)

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_33 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_23) / var_66_33

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_23 + var_66_33 and arg_63_1.time_ < var_66_23 + var_66_33 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play410231016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410231016
		arg_67_1.duration_ = 11.8

		local var_67_0 = {
			ja = 11.8,
			CriLanguages = 9.066,
			zh = 9.066
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play410231017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.875

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[596].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(410231016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 33
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410231", "410231016", "story_v_out_410231.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_410231", "410231016", "story_v_out_410231.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_410231", "410231016", "story_v_out_410231.awb")

						arg_67_1:RecordAudio("410231016", var_70_9)
						arg_67_1:RecordAudio("410231016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_410231", "410231016", "story_v_out_410231.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_410231", "410231016", "story_v_out_410231.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play410231017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410231017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
			arg_71_1.auto_ = false
		end

		function arg_71_1.playNext_(arg_73_0)
			arg_71_1.onStoryFinished_()
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10059"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10059 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10059", 7)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -2000, 35)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10059, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_74_7 = arg_71_1.actors_["1061"].transform
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.var_.moveOldPos1061 = var_74_7.localPosition
				var_74_7.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1061", 3)

				local var_74_9 = var_74_7.childCount

				for iter_74_1 = 0, var_74_9 - 1 do
					local var_74_10 = var_74_7:GetChild(iter_74_1)

					if var_74_10.name == "" or not string.find(var_74_10.name, "split") then
						var_74_10.gameObject:SetActive(true)
					else
						var_74_10.gameObject:SetActive(false)
					end
				end
			end

			local var_74_11 = 0.001

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_8) / var_74_11
				local var_74_13 = Vector3.New(0, -490, 18)

				var_74_7.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1061, var_74_13, var_74_12)
			end

			if arg_71_1.time_ >= var_74_8 + var_74_11 and arg_71_1.time_ < var_74_8 + var_74_11 + arg_74_0 then
				var_74_7.localPosition = Vector3.New(0, -490, 18)
			end

			local var_74_14 = 0
			local var_74_15 = 0.675

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_16 = arg_71_1:GetWordFromCfg(410231017)
				local var_74_17 = arg_71_1:FormatText(var_74_16.content)

				arg_71_1.text_.text = var_74_17

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_18 = 27
				local var_74_19 = utf8.len(var_74_17)
				local var_74_20 = var_74_18 <= 0 and var_74_15 or var_74_15 * (var_74_19 / var_74_18)

				if var_74_20 > 0 and var_74_15 < var_74_20 then
					arg_71_1.talkMaxDuration = var_74_20

					if var_74_20 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_14
					end
				end

				arg_71_1.text_.text = var_74_17
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_15, arg_71_1.talkMaxDuration)

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_14) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_14 + var_74_21 and arg_71_1.time_ < var_74_14 + var_74_21 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST63"
	},
	voices = {
		"story_v_out_410231.awb"
	}
}
