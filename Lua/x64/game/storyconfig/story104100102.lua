return {
	Play410012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L02f"

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
				local var_4_5 = arg_1_1.bgs_.L02f

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
					if iter_4_0 ~= "L02f" then
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
			local var_4_23 = 1

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

			local var_4_28 = 1.56666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

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
			local var_4_35 = 1.25

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

				local var_4_37 = arg_1_1:GetWordFromCfg(410012001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 50
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
	Play410012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.7

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

				local var_12_2 = arg_9_1:GetWordFromCfg(410012002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 68
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
	Play410012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410012003
		arg_13_1.duration_ = 2.5

		local var_13_0 = {
			zh = 1.133,
			ja = 2.5
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
				arg_13_0:Play410012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1060"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_16_4 = arg_13_1.actors_["1060"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos1060 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1060", 3)

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
				local var_16_10 = Vector3.New(33.4, -430.8, 6.9)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1060, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_16_11 = arg_13_1.actors_["1060"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1060 == nil then
				arg_13_1.var_.actorSpriteComps1060 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps1060 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1060 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1060 = nil
			end

			local var_16_19 = 0
			local var_16_20 = 0.125

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[584].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(410012003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012003", "story_v_out_410012.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_410012", "410012003", "story_v_out_410012.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_410012", "410012003", "story_v_out_410012.awb")

						arg_13_1:RecordAudio("410012003", var_16_28)
						arg_13_1:RecordAudio("410012003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410012", "410012003", "story_v_out_410012.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410012", "410012003", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410012004
		arg_17_1.duration_ = 2.27

		local var_17_0 = {
			zh = 1.266,
			ja = 2.266
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
				arg_17_0:Play410012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1060"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1060 == nil then
				arg_17_1.var_.actorSpriteComps1060 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.034

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1060 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1060 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1060 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.175

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[589].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(410012004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012004", "story_v_out_410012.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012004", "story_v_out_410012.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_410012", "410012004", "story_v_out_410012.awb")

						arg_17_1:RecordAudio("410012004", var_20_17)
						arg_17_1:RecordAudio("410012004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410012", "410012004", "story_v_out_410012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410012", "410012004", "story_v_out_410012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_18 and arg_17_1.time_ < var_20_8 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410012005
		arg_21_1.duration_ = 4.07

		local var_21_0 = {
			zh = 3.133,
			ja = 4.066
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
				arg_21_0:Play410012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1060"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1060 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1060", 3)

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
				local var_24_6 = Vector3.New(33.4, -430.8, 6.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1060, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_24_7 = arg_21_1.actors_["1060"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.425

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[584].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410012005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 17
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012005", "story_v_out_410012.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012005", "story_v_out_410012.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410012", "410012005", "story_v_out_410012.awb")

						arg_21_1:RecordAudio("410012005", var_24_24)
						arg_21_1:RecordAudio("410012005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410012", "410012005", "story_v_out_410012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410012", "410012005", "story_v_out_410012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play410012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410012006
		arg_25_1.duration_ = 12.43

		local var_25_0 = {
			zh = 5.2,
			ja = 12.433
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
				arg_25_0:Play410012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1060"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.625

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[589].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(410012006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 25
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012006", "story_v_out_410012.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012006", "story_v_out_410012.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_410012", "410012006", "story_v_out_410012.awb")

						arg_25_1:RecordAudio("410012006", var_28_17)
						arg_25_1:RecordAudio("410012006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410012", "410012006", "story_v_out_410012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410012", "410012006", "story_v_out_410012.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_18 and arg_25_1.time_ < var_28_8 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play410012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410012007
		arg_29_1.duration_ = 14.27

		local var_29_0 = {
			zh = 7.8,
			ja = 14.266
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
				arg_29_0:Play410012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.925

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[589].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(410012007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 37
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012007", "story_v_out_410012.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012007", "story_v_out_410012.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_410012", "410012007", "story_v_out_410012.awb")

						arg_29_1:RecordAudio("410012007", var_32_9)
						arg_29_1:RecordAudio("410012007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410012", "410012007", "story_v_out_410012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410012", "410012007", "story_v_out_410012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410012008
		arg_33_1.duration_ = 4.7

		local var_33_0 = {
			zh = 2.666,
			ja = 4.7
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
				arg_33_0:Play410012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_4" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(33.4, -430.8, 6.9)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
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

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.375

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[584].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410012008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012008", "story_v_out_410012.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012008", "story_v_out_410012.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410012", "410012008", "story_v_out_410012.awb")

						arg_33_1:RecordAudio("410012008", var_36_24)
						arg_33_1:RecordAudio("410012008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410012", "410012008", "story_v_out_410012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410012", "410012008", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410012009
		arg_37_1.duration_ = 11.3

		local var_37_0 = {
			zh = 8.2,
			ja = 11.3
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
				arg_37_0:Play410012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1060"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1060 == nil then
				arg_37_1.var_.actorSpriteComps1060 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1060 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1060 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1060 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 1.125

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_10 = arg_37_1:FormatText(StoryNameCfg[589].name)

				arg_37_1.leftNameTxt_.text = var_40_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_11 = arg_37_1:GetWordFromCfg(410012009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 45
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_9 or var_40_9 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_9 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012009", "story_v_out_410012.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012009", "story_v_out_410012.awb") / 1000

					if var_40_16 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_8
					end

					if var_40_11.prefab_name ~= "" and arg_37_1.actors_[var_40_11.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_11.prefab_name].transform, "story_v_out_410012", "410012009", "story_v_out_410012.awb")

						arg_37_1:RecordAudio("410012009", var_40_17)
						arg_37_1:RecordAudio("410012009", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410012", "410012009", "story_v_out_410012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410012", "410012009", "story_v_out_410012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_18 and arg_37_1.time_ < var_40_8 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410012010
		arg_41_1.duration_ = 7.27

		local var_41_0 = {
			zh = 4.3,
			ja = 7.266
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
				arg_41_0:Play410012011(arg_41_1)
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
			local var_44_16 = 0.45

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

				local var_44_18 = arg_41_1:GetWordFromCfg(410012010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012010", "story_v_out_410012.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012010", "story_v_out_410012.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_410012", "410012010", "story_v_out_410012.awb")

						arg_41_1:RecordAudio("410012010", var_44_24)
						arg_41_1:RecordAudio("410012010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410012", "410012010", "story_v_out_410012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410012", "410012010", "story_v_out_410012.awb")
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
	Play410012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410012011
		arg_45_1.duration_ = 11.2

		local var_45_0 = {
			zh = 8.3,
			ja = 11.2
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
				arg_45_0:Play410012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1060"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1060 == nil then
				arg_45_1.var_.actorSpriteComps1060 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1060 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1060 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1060 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.975

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_10 = arg_45_1:FormatText(StoryNameCfg[589].name)

				arg_45_1.leftNameTxt_.text = var_48_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_11 = arg_45_1:GetWordFromCfg(410012011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 39
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_9 or var_48_9 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_9 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012011", "story_v_out_410012.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012011", "story_v_out_410012.awb") / 1000

					if var_48_16 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_8
					end

					if var_48_11.prefab_name ~= "" and arg_45_1.actors_[var_48_11.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_11.prefab_name].transform, "story_v_out_410012", "410012011", "story_v_out_410012.awb")

						arg_45_1:RecordAudio("410012011", var_48_17)
						arg_45_1:RecordAudio("410012011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410012", "410012011", "story_v_out_410012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410012", "410012011", "story_v_out_410012.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_18 and arg_45_1.time_ < var_48_8 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410012012
		arg_49_1.duration_ = 8.13

		local var_49_0 = {
			zh = 4.9,
			ja = 8.133
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
				arg_49_0:Play410012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1060"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 3)

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
				local var_52_6 = Vector3.New(33.4, -430.8, 6.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_52_7 = arg_49_1.actors_["1060"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 == nil then
				arg_49_1.var_.actorSpriteComps1060 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1060 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 0.65

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[584].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(410012012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 26
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012012", "story_v_out_410012.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012012", "story_v_out_410012.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_410012", "410012012", "story_v_out_410012.awb")

						arg_49_1:RecordAudio("410012012", var_52_24)
						arg_49_1:RecordAudio("410012012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410012", "410012012", "story_v_out_410012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410012", "410012012", "story_v_out_410012.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play410012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410012013
		arg_53_1.duration_ = 6.63

		local var_53_0 = {
			zh = 5.366,
			ja = 6.633
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
				arg_53_0:Play410012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1060"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1060 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1060", 3)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(33.4, -430.8, 6.9)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1060, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_56_7 = arg_53_1.actors_["1060"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			local var_56_15 = 0
			local var_56_16 = 0.625

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[584].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(410012013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012013", "story_v_out_410012.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012013", "story_v_out_410012.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_410012", "410012013", "story_v_out_410012.awb")

						arg_53_1:RecordAudio("410012013", var_56_24)
						arg_53_1:RecordAudio("410012013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410012", "410012013", "story_v_out_410012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410012", "410012013", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410012014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410012015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1060"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1060 == nil then
				arg_57_1.var_.actorSpriteComps1060 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1060 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1060 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1060 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 1.6

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(410012014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 64
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_9 or var_60_9 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_9 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_15 and arg_57_1.time_ < var_60_8 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410012015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410012015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410012016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(410012015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 40
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410012016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410012016
		arg_65_1.duration_ = 9.27

		local var_65_0 = {
			zh = 4.333,
			ja = 9.266
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
				arg_65_0:Play410012017(arg_65_1)
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

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[589].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(410012016)
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012016", "story_v_out_410012.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012016", "story_v_out_410012.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_410012", "410012016", "story_v_out_410012.awb")

						arg_65_1:RecordAudio("410012016", var_68_9)
						arg_65_1:RecordAudio("410012016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410012", "410012016", "story_v_out_410012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410012", "410012016", "story_v_out_410012.awb")
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
	Play410012017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410012017
		arg_69_1.duration_ = 10.23

		local var_69_0 = {
			zh = 6.166,
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
				arg_69_0:Play410012018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1060"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1060 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1060", 3)

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
				local var_72_6 = Vector3.New(33.4, -430.8, 6.9)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1060, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_72_7 = arg_69_1.actors_["1060"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1060 == nil then
				arg_69_1.var_.actorSpriteComps1060 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1060 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1060 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1060 = nil
			end

			local var_72_15 = 0
			local var_72_16 = 0.725

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[584].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(410012017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 29
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012017", "story_v_out_410012.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012017", "story_v_out_410012.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_410012", "410012017", "story_v_out_410012.awb")

						arg_69_1:RecordAudio("410012017", var_72_24)
						arg_69_1:RecordAudio("410012017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410012", "410012017", "story_v_out_410012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410012", "410012017", "story_v_out_410012.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
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
	Play410012018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410012018
		arg_73_1.duration_ = 11.67

		local var_73_0 = {
			zh = 7.233,
			ja = 11.666
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
				arg_73_0:Play410012019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1060"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1060 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1060", 3)

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
				local var_76_6 = Vector3.New(33.4, -430.8, 6.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1060, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_76_7 = arg_73_1.actors_["1060"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1060 == nil then
				arg_73_1.var_.actorSpriteComps1060 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps1060 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1060 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1060 = nil
			end

			local var_76_15 = 0
			local var_76_16 = 0.925

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[584].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(410012018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 37
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012018", "story_v_out_410012.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012018", "story_v_out_410012.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_410012", "410012018", "story_v_out_410012.awb")

						arg_73_1:RecordAudio("410012018", var_76_24)
						arg_73_1:RecordAudio("410012018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410012", "410012018", "story_v_out_410012.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410012", "410012018", "story_v_out_410012.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
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
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play410012019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410012019
		arg_77_1.duration_ = 9.47

		local var_77_0 = {
			zh = 3.5,
			ja = 9.466
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
				arg_77_0:Play410012020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1060"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1060 == nil then
				arg_77_1.var_.actorSpriteComps1060 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.034

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1060 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1060 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1060 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.275

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[589].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(410012019)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012019", "story_v_out_410012.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012019", "story_v_out_410012.awb") / 1000

					if var_80_16 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_8
					end

					if var_80_11.prefab_name ~= "" and arg_77_1.actors_[var_80_11.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_11.prefab_name].transform, "story_v_out_410012", "410012019", "story_v_out_410012.awb")

						arg_77_1:RecordAudio("410012019", var_80_17)
						arg_77_1:RecordAudio("410012019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410012", "410012019", "story_v_out_410012.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410012", "410012019", "story_v_out_410012.awb")
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
	Play410012020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410012020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play410012021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.625

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(410012020)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 25
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play410012021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410012021
		arg_85_1.duration_ = 7.17

		local var_85_0 = {
			zh = 2.9,
			ja = 7.166
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
				arg_85_0:Play410012022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.35

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[589].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(410012021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 14
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012021", "story_v_out_410012.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012021", "story_v_out_410012.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_410012", "410012021", "story_v_out_410012.awb")

						arg_85_1:RecordAudio("410012021", var_88_9)
						arg_85_1:RecordAudio("410012021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410012", "410012021", "story_v_out_410012.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410012", "410012021", "story_v_out_410012.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play410012022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410012022
		arg_89_1.duration_ = 8.97

		local var_89_0 = {
			zh = 3.4,
			ja = 8.966
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
				arg_89_0:Play410012023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1060"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1060 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1060", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(33.4, -430.8, 6.9)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1060, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_92_7 = arg_89_1.actors_["1060"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1060 == nil then
				arg_89_1.var_.actorSpriteComps1060 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.034

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps1060 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 1, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1060 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1060 = nil
			end

			local var_92_15 = 0
			local var_92_16 = 0.425

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[584].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(410012022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 17
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012022", "story_v_out_410012.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012022", "story_v_out_410012.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_410012", "410012022", "story_v_out_410012.awb")

						arg_89_1:RecordAudio("410012022", var_92_24)
						arg_89_1:RecordAudio("410012022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410012", "410012022", "story_v_out_410012.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410012", "410012022", "story_v_out_410012.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play410012023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410012023
		arg_93_1.duration_ = 8.8

		local var_93_0 = {
			zh = 8.633,
			ja = 8.8
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
				arg_93_0:Play410012024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1060"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1060 == nil then
				arg_93_1.var_.actorSpriteComps1060 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1060 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1060 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1060 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 1.075

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_10 = arg_93_1:FormatText(StoryNameCfg[589].name)

				arg_93_1.leftNameTxt_.text = var_96_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_11 = arg_93_1:GetWordFromCfg(410012023)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 43
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_9 or var_96_9 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_9 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012023", "story_v_out_410012.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012023", "story_v_out_410012.awb") / 1000

					if var_96_16 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_8
					end

					if var_96_11.prefab_name ~= "" and arg_93_1.actors_[var_96_11.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_11.prefab_name].transform, "story_v_out_410012", "410012023", "story_v_out_410012.awb")

						arg_93_1:RecordAudio("410012023", var_96_17)
						arg_93_1:RecordAudio("410012023", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410012", "410012023", "story_v_out_410012.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410012", "410012023", "story_v_out_410012.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_18 and arg_93_1.time_ < var_96_8 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410012024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410012024
		arg_97_1.duration_ = 12.3

		local var_97_0 = {
			zh = 7.966,
			ja = 12.3
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
				arg_97_0:Play410012025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.925

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[589].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(410012024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012024", "story_v_out_410012.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012024", "story_v_out_410012.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_410012", "410012024", "story_v_out_410012.awb")

						arg_97_1:RecordAudio("410012024", var_100_9)
						arg_97_1:RecordAudio("410012024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410012", "410012024", "story_v_out_410012.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410012", "410012024", "story_v_out_410012.awb")
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
	Play410012025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410012025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410012026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.05

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(410012025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 42
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play410012026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410012026
		arg_105_1.duration_ = 4.93

		local var_105_0 = {
			zh = 3,
			ja = 4.933
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
				arg_105_0:Play410012027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1060"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1060 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1060", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(33.4, -430.8, 6.9)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1060, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_108_7 = arg_105_1.actors_["1060"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1060 == nil then
				arg_105_1.var_.actorSpriteComps1060 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 0.034

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps1060 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1060 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1060 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.375

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[584].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(410012026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 15
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012026", "story_v_out_410012.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012026", "story_v_out_410012.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_410012", "410012026", "story_v_out_410012.awb")

						arg_105_1:RecordAudio("410012026", var_108_24)
						arg_105_1:RecordAudio("410012026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410012", "410012026", "story_v_out_410012.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410012", "410012026", "story_v_out_410012.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play410012027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410012027
		arg_109_1.duration_ = 4.2

		local var_109_0 = {
			zh = 1.766,
			ja = 4.2
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
				arg_109_0:Play410012028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1060"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.034

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 0.5, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.175

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_10 = arg_109_1:FormatText(StoryNameCfg[589].name)

				arg_109_1.leftNameTxt_.text = var_112_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_11 = arg_109_1:GetWordFromCfg(410012027)
				local var_112_12 = arg_109_1:FormatText(var_112_11.content)

				arg_109_1.text_.text = var_112_12

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 7
				local var_112_14 = utf8.len(var_112_12)
				local var_112_15 = var_112_13 <= 0 and var_112_9 or var_112_9 * (var_112_14 / var_112_13)

				if var_112_15 > 0 and var_112_9 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_12
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012027", "story_v_out_410012.awb") ~= 0 then
					local var_112_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012027", "story_v_out_410012.awb") / 1000

					if var_112_16 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_8
					end

					if var_112_11.prefab_name ~= "" and arg_109_1.actors_[var_112_11.prefab_name] ~= nil then
						local var_112_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_11.prefab_name].transform, "story_v_out_410012", "410012027", "story_v_out_410012.awb")

						arg_109_1:RecordAudio("410012027", var_112_17)
						arg_109_1:RecordAudio("410012027", var_112_17)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410012", "410012027", "story_v_out_410012.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410012", "410012027", "story_v_out_410012.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_18 and arg_109_1.time_ < var_112_8 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play410012028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410012028
		arg_113_1.duration_ = 11.43

		local var_113_0 = {
			zh = 9.633,
			ja = 11.433
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
				arg_113_0:Play410012029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "ST65"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 2

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.ST65

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST65" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_17 = 2

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Color.New(0, 0, 0)

				var_116_19.a = Mathf.Lerp(0, 1, var_116_18)
				arg_113_1.mask_.color = var_116_19
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				local var_116_20 = Color.New(0, 0, 0)

				var_116_20.a = 1
				arg_113_1.mask_.color = var_116_20
			end

			local var_116_21 = 2

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_22 = 2

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_22 then
				local var_116_23 = (arg_113_1.time_ - var_116_21) / var_116_22
				local var_116_24 = Color.New(0, 0, 0)

				var_116_24.a = Mathf.Lerp(1, 0, var_116_23)
				arg_113_1.mask_.color = var_116_24
			end

			if arg_113_1.time_ >= var_116_21 + var_116_22 and arg_113_1.time_ < var_116_21 + var_116_22 + arg_116_0 then
				local var_116_25 = Color.New(0, 0, 0)
				local var_116_26 = 0

				arg_113_1.mask_.enabled = false
				var_116_25.a = var_116_26
				arg_113_1.mask_.color = var_116_25
			end

			local var_116_27 = arg_113_1.actors_["1060"].transform
			local var_116_28 = 2

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.var_.moveOldPos1060 = var_116_27.localPosition
				var_116_27.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1060", 7)

				local var_116_29 = var_116_27.childCount

				for iter_116_2 = 0, var_116_29 - 1 do
					local var_116_30 = var_116_27:GetChild(iter_116_2)

					if var_116_30.name == "" or not string.find(var_116_30.name, "split") then
						var_116_30.gameObject:SetActive(true)
					else
						var_116_30.gameObject:SetActive(false)
					end
				end
			end

			local var_116_31 = 0.001

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_31 then
				local var_116_32 = (arg_113_1.time_ - var_116_28) / var_116_31
				local var_116_33 = Vector3.New(0, -2000, -40)

				var_116_27.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1060, var_116_33, var_116_32)
			end

			if arg_113_1.time_ >= var_116_28 + var_116_31 and arg_113_1.time_ < var_116_28 + var_116_31 + arg_116_0 then
				var_116_27.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_116_34 = 4
			local var_116_35 = 1

			if var_116_34 < arg_113_1.time_ and arg_113_1.time_ <= var_116_34 + arg_116_0 then
				local var_116_36 = "play"
				local var_116_37 = "effect"

				arg_113_1:AudioAction(var_116_36, var_116_37, "se_story_128", "se_story_128_cheer", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_38 = 4
			local var_116_39 = 0.775

			if var_116_38 < arg_113_1.time_ and arg_113_1.time_ <= var_116_38 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_40 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_40:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_41 = arg_113_1:FormatText(StoryNameCfg[590].name)

				arg_113_1.leftNameTxt_.text = var_116_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_42 = arg_113_1:GetWordFromCfg(410012028)
				local var_116_43 = arg_113_1:FormatText(var_116_42.content)

				arg_113_1.text_.text = var_116_43

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_44 = 30
				local var_116_45 = utf8.len(var_116_43)
				local var_116_46 = var_116_44 <= 0 and var_116_39 or var_116_39 * (var_116_45 / var_116_44)

				if var_116_46 > 0 and var_116_39 < var_116_46 then
					arg_113_1.talkMaxDuration = var_116_46
					var_116_38 = var_116_38 + 0.3

					if var_116_46 + var_116_38 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_46 + var_116_38
					end
				end

				arg_113_1.text_.text = var_116_43
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012028", "story_v_out_410012.awb") ~= 0 then
					local var_116_47 = manager.audio:GetVoiceLength("story_v_out_410012", "410012028", "story_v_out_410012.awb") / 1000

					if var_116_47 + var_116_38 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_47 + var_116_38
					end

					if var_116_42.prefab_name ~= "" and arg_113_1.actors_[var_116_42.prefab_name] ~= nil then
						local var_116_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_42.prefab_name].transform, "story_v_out_410012", "410012028", "story_v_out_410012.awb")

						arg_113_1:RecordAudio("410012028", var_116_48)
						arg_113_1:RecordAudio("410012028", var_116_48)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410012", "410012028", "story_v_out_410012.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410012", "410012028", "story_v_out_410012.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_49 = var_116_38 + 0.3
			local var_116_50 = math.max(var_116_39, arg_113_1.talkMaxDuration)

			if var_116_49 <= arg_113_1.time_ and arg_113_1.time_ < var_116_49 + var_116_50 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_49) / var_116_50

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_49 + var_116_50 and arg_113_1.time_ < var_116_49 + var_116_50 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410012029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410012029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play410012030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.275

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(410012029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 51
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play410012030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410012030
		arg_123_1.duration_ = 2.9

		local var_123_0 = {
			zh = 2.9,
			ja = 1.8
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
				arg_123_0:Play410012031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1060"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1060 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1060", 3)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(33.4, -430.8, 6.9)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1060, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_126_7 = arg_123_1.actors_["1060"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps1060 == nil then
				arg_123_1.var_.actorSpriteComps1060 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.034

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps1060 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps1060 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1060 = nil
			end

			local var_126_15 = 0
			local var_126_16 = 0.15

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[584].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(410012030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012030", "story_v_out_410012.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012030", "story_v_out_410012.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_410012", "410012030", "story_v_out_410012.awb")

						arg_123_1:RecordAudio("410012030", var_126_24)
						arg_123_1:RecordAudio("410012030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410012", "410012030", "story_v_out_410012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410012", "410012030", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410012031
		arg_127_1.duration_ = 13.8

		local var_127_0 = {
			zh = 7.2,
			ja = 13.8
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
				arg_127_0:Play410012032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1060"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1060 == nil then
				arg_127_1.var_.actorSpriteComps1060 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.034

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps1060 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 0.5, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1060 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1060 = nil
			end

			local var_130_8 = 0
			local var_130_9 = 0.75

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_10 = arg_127_1:FormatText(StoryNameCfg[590].name)

				arg_127_1.leftNameTxt_.text = var_130_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_11 = arg_127_1:GetWordFromCfg(410012031)
				local var_130_12 = arg_127_1:FormatText(var_130_11.content)

				arg_127_1.text_.text = var_130_12

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 30
				local var_130_14 = utf8.len(var_130_12)
				local var_130_15 = var_130_13 <= 0 and var_130_9 or var_130_9 * (var_130_14 / var_130_13)

				if var_130_15 > 0 and var_130_9 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_12
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012031", "story_v_out_410012.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012031", "story_v_out_410012.awb") / 1000

					if var_130_16 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_8
					end

					if var_130_11.prefab_name ~= "" and arg_127_1.actors_[var_130_11.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_11.prefab_name].transform, "story_v_out_410012", "410012031", "story_v_out_410012.awb")

						arg_127_1:RecordAudio("410012031", var_130_17)
						arg_127_1:RecordAudio("410012031", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410012", "410012031", "story_v_out_410012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410012", "410012031", "story_v_out_410012.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_18 and arg_127_1.time_ < var_130_8 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play410012032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410012032
		arg_131_1.duration_ = 3.53

		local var_131_0 = {
			zh = 3.533,
			ja = 3.5
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
				arg_131_0:Play410012033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1060"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1060 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1060", 3)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(33.4, -430.8, 6.9)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1060, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_134_7 = arg_131_1.actors_["1060"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1060 == nil then
				arg_131_1.var_.actorSpriteComps1060 = var_134_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.actorSpriteComps1060 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1060 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_134_4 then
						if arg_131_1.isInRecall_ then
							iter_134_4.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1060 = nil
			end

			local var_134_15 = 0
			local var_134_16 = 0.325

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[584].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(410012032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 13
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012032", "story_v_out_410012.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012032", "story_v_out_410012.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_410012", "410012032", "story_v_out_410012.awb")

						arg_131_1:RecordAudio("410012032", var_134_24)
						arg_131_1:RecordAudio("410012032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410012", "410012032", "story_v_out_410012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410012", "410012032", "story_v_out_410012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play410012033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410012033
		arg_135_1.duration_ = 10.03

		local var_135_0 = {
			zh = 4.166,
			ja = 10.033
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
				arg_135_0:Play410012034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.4

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[590].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(410012033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012033", "story_v_out_410012.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012033", "story_v_out_410012.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_410012", "410012033", "story_v_out_410012.awb")

						arg_135_1:RecordAudio("410012033", var_138_9)
						arg_135_1:RecordAudio("410012033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410012", "410012033", "story_v_out_410012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410012", "410012033", "story_v_out_410012.awb")
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
	Play410012034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410012034
		arg_139_1.duration_ = 4.77

		local var_139_0 = {
			zh = 4.366,
			ja = 4.766
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
				arg_139_0:Play410012035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "10061"

			if arg_139_1.actors_[var_142_0] == nil then
				local var_142_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

				if not isNil(var_142_1) then
					local var_142_2 = Object.Instantiate(var_142_1, arg_139_1.canvasGo_.transform)

					var_142_2.transform:SetSiblingIndex(1)

					var_142_2.name = var_142_0
					var_142_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_139_1.actors_[var_142_0] = var_142_2

					local var_142_3 = var_142_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_139_1.isInRecall_ then
						for iter_142_0, iter_142_1 in ipairs(var_142_3) do
							iter_142_1.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_142_4 = arg_139_1.actors_["10061"].transform
			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.var_.moveOldPos10061 = var_142_4.localPosition
				var_142_4.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10061", 3)

				local var_142_6 = var_142_4.childCount

				for iter_142_2 = 0, var_142_6 - 1 do
					local var_142_7 = var_142_4:GetChild(iter_142_2)

					if var_142_7.name == "" or not string.find(var_142_7.name, "split") then
						var_142_7.gameObject:SetActive(true)
					else
						var_142_7.gameObject:SetActive(false)
					end
				end
			end

			local var_142_8 = 0.001

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_8 then
				local var_142_9 = (arg_139_1.time_ - var_142_5) / var_142_8
				local var_142_10 = Vector3.New(0, -517.5, -100)

				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10061, var_142_10, var_142_9)
			end

			if arg_139_1.time_ >= var_142_5 + var_142_8 and arg_139_1.time_ < var_142_5 + var_142_8 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_142_11 = arg_139_1.actors_["10061"]
			local var_142_12 = 0

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.actorSpriteComps10061 == nil then
				arg_139_1.var_.actorSpriteComps10061 = var_142_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_13 = 0.034

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_13 and not isNil(var_142_11) then
				local var_142_14 = (arg_139_1.time_ - var_142_12) / var_142_13

				if arg_139_1.var_.actorSpriteComps10061 then
					for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_142_4 then
							if arg_139_1.isInRecall_ then
								local var_142_15 = Mathf.Lerp(iter_142_4.color.r, arg_139_1.hightColor1.r, var_142_14)
								local var_142_16 = Mathf.Lerp(iter_142_4.color.g, arg_139_1.hightColor1.g, var_142_14)
								local var_142_17 = Mathf.Lerp(iter_142_4.color.b, arg_139_1.hightColor1.b, var_142_14)

								iter_142_4.color = Color.New(var_142_15, var_142_16, var_142_17)
							else
								local var_142_18 = Mathf.Lerp(iter_142_4.color.r, 1, var_142_14)

								iter_142_4.color = Color.New(var_142_18, var_142_18, var_142_18)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_12 + var_142_13 and arg_139_1.time_ < var_142_12 + var_142_13 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.actorSpriteComps10061 then
				for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_142_6 then
						if arg_139_1.isInRecall_ then
							iter_142_6.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10061 = nil
			end

			local var_142_19 = 0
			local var_142_20 = 0.05

			if var_142_19 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_21 = arg_139_1:FormatText(StoryNameCfg[591].name)

				arg_139_1.leftNameTxt_.text = var_142_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_22 = arg_139_1:GetWordFromCfg(410012034)
				local var_142_23 = arg_139_1:FormatText(var_142_22.content)

				arg_139_1.text_.text = var_142_23

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_24 = 2
				local var_142_25 = utf8.len(var_142_23)
				local var_142_26 = var_142_24 <= 0 and var_142_20 or var_142_20 * (var_142_25 / var_142_24)

				if var_142_26 > 0 and var_142_20 < var_142_26 then
					arg_139_1.talkMaxDuration = var_142_26

					if var_142_26 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_26 + var_142_19
					end
				end

				arg_139_1.text_.text = var_142_23
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012034", "story_v_out_410012.awb") ~= 0 then
					local var_142_27 = manager.audio:GetVoiceLength("story_v_out_410012", "410012034", "story_v_out_410012.awb") / 1000

					if var_142_27 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_19
					end

					if var_142_22.prefab_name ~= "" and arg_139_1.actors_[var_142_22.prefab_name] ~= nil then
						local var_142_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_22.prefab_name].transform, "story_v_out_410012", "410012034", "story_v_out_410012.awb")

						arg_139_1:RecordAudio("410012034", var_142_28)
						arg_139_1:RecordAudio("410012034", var_142_28)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410012", "410012034", "story_v_out_410012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410012", "410012034", "story_v_out_410012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_29 = math.max(var_142_20, arg_139_1.talkMaxDuration)

			if var_142_19 <= arg_139_1.time_ and arg_139_1.time_ < var_142_19 + var_142_29 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_19) / var_142_29

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_19 + var_142_29 and arg_139_1.time_ < var_142_19 + var_142_29 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410012035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play410012036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10061"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10061 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10061", 7)

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
				local var_146_6 = Vector3.New(0, -2000, -100)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10061, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_146_7 = arg_143_1.actors_["10061"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps10061 == nil then
				arg_143_1.var_.actorSpriteComps10061 = var_146_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.034

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.actorSpriteComps10061 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								local var_146_11 = Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor2.r, var_146_10)
								local var_146_12 = Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor2.g, var_146_10)
								local var_146_13 = Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor2.b, var_146_10)

								iter_146_2.color = Color.New(var_146_11, var_146_12, var_146_13)
							else
								local var_146_14 = Mathf.Lerp(iter_146_2.color.r, 0.5, var_146_10)

								iter_146_2.color = Color.New(var_146_14, var_146_14, var_146_14)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps10061 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_146_4 then
						if arg_143_1.isInRecall_ then
							iter_146_4.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10061 = nil
			end

			local var_146_15 = 0
			local var_146_16 = 1.25

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_17 = arg_143_1:GetWordFromCfg(410012035)
				local var_146_18 = arg_143_1:FormatText(var_146_17.content)

				arg_143_1.text_.text = var_146_18

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_19 = 50
				local var_146_20 = utf8.len(var_146_18)
				local var_146_21 = var_146_19 <= 0 and var_146_16 or var_146_16 * (var_146_20 / var_146_19)

				if var_146_21 > 0 and var_146_16 < var_146_21 then
					arg_143_1.talkMaxDuration = var_146_21

					if var_146_21 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_21 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_18
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_22 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_22 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_22

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_22 and arg_143_1.time_ < var_146_15 + var_146_22 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410012036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play410012037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.875

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(410012036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 75
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play410012037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410012037
		arg_151_1.duration_ = 20.4

		local var_151_0 = {
			zh = 7.3,
			ja = 20.4
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
				arg_151_0:Play410012038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = "10062"

			if arg_151_1.actors_[var_154_0] == nil then
				local var_154_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_154_1) then
					local var_154_2 = Object.Instantiate(var_154_1, arg_151_1.canvasGo_.transform)

					var_154_2.transform:SetSiblingIndex(1)

					var_154_2.name = var_154_0
					var_154_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_151_1.actors_[var_154_0] = var_154_2

					local var_154_3 = var_154_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_151_1.isInRecall_ then
						for iter_154_0, iter_154_1 in ipairs(var_154_3) do
							iter_154_1.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_154_4 = arg_151_1.actors_["10062"].transform
			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.var_.moveOldPos10062 = var_154_4.localPosition
				var_154_4.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10062", 3)

				local var_154_6 = var_154_4.childCount

				for iter_154_2 = 0, var_154_6 - 1 do
					local var_154_7 = var_154_4:GetChild(iter_154_2)

					if var_154_7.name == "" or not string.find(var_154_7.name, "split") then
						var_154_7.gameObject:SetActive(true)
					else
						var_154_7.gameObject:SetActive(false)
					end
				end
			end

			local var_154_8 = 0.001

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_8 then
				local var_154_9 = (arg_151_1.time_ - var_154_5) / var_154_8
				local var_154_10 = Vector3.New(0, -390, -290)

				var_154_4.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10062, var_154_10, var_154_9)
			end

			if arg_151_1.time_ >= var_154_5 + var_154_8 and arg_151_1.time_ < var_154_5 + var_154_8 + arg_154_0 then
				var_154_4.localPosition = Vector3.New(0, -390, -290)
			end

			local var_154_11 = arg_151_1.actors_["10062"]
			local var_154_12 = 0

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 and not isNil(var_154_11) and arg_151_1.var_.actorSpriteComps10062 == nil then
				arg_151_1.var_.actorSpriteComps10062 = var_154_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_13 = 0.034

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_13 and not isNil(var_154_11) then
				local var_154_14 = (arg_151_1.time_ - var_154_12) / var_154_13

				if arg_151_1.var_.actorSpriteComps10062 then
					for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_154_4 then
							if arg_151_1.isInRecall_ then
								local var_154_15 = Mathf.Lerp(iter_154_4.color.r, arg_151_1.hightColor1.r, var_154_14)
								local var_154_16 = Mathf.Lerp(iter_154_4.color.g, arg_151_1.hightColor1.g, var_154_14)
								local var_154_17 = Mathf.Lerp(iter_154_4.color.b, arg_151_1.hightColor1.b, var_154_14)

								iter_154_4.color = Color.New(var_154_15, var_154_16, var_154_17)
							else
								local var_154_18 = Mathf.Lerp(iter_154_4.color.r, 1, var_154_14)

								iter_154_4.color = Color.New(var_154_18, var_154_18, var_154_18)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_12 + var_154_13 and arg_151_1.time_ < var_154_12 + var_154_13 + arg_154_0 and not isNil(var_154_11) and arg_151_1.var_.actorSpriteComps10062 then
				for iter_154_5, iter_154_6 in pairs(arg_151_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_154_6 then
						if arg_151_1.isInRecall_ then
							iter_154_6.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10062 = nil
			end

			local var_154_19 = 0
			local var_154_20 = 0.725

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_21 = arg_151_1:FormatText(StoryNameCfg[592].name)

				arg_151_1.leftNameTxt_.text = var_154_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_22 = arg_151_1:GetWordFromCfg(410012037)
				local var_154_23 = arg_151_1:FormatText(var_154_22.content)

				arg_151_1.text_.text = var_154_23

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_24 = 29
				local var_154_25 = utf8.len(var_154_23)
				local var_154_26 = var_154_24 <= 0 and var_154_20 or var_154_20 * (var_154_25 / var_154_24)

				if var_154_26 > 0 and var_154_20 < var_154_26 then
					arg_151_1.talkMaxDuration = var_154_26

					if var_154_26 + var_154_19 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_26 + var_154_19
					end
				end

				arg_151_1.text_.text = var_154_23
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012037", "story_v_out_410012.awb") ~= 0 then
					local var_154_27 = manager.audio:GetVoiceLength("story_v_out_410012", "410012037", "story_v_out_410012.awb") / 1000

					if var_154_27 + var_154_19 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_27 + var_154_19
					end

					if var_154_22.prefab_name ~= "" and arg_151_1.actors_[var_154_22.prefab_name] ~= nil then
						local var_154_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_22.prefab_name].transform, "story_v_out_410012", "410012037", "story_v_out_410012.awb")

						arg_151_1:RecordAudio("410012037", var_154_28)
						arg_151_1:RecordAudio("410012037", var_154_28)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410012", "410012037", "story_v_out_410012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410012", "410012037", "story_v_out_410012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_29 = math.max(var_154_20, arg_151_1.talkMaxDuration)

			if var_154_19 <= arg_151_1.time_ and arg_151_1.time_ < var_154_19 + var_154_29 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_19) / var_154_29

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_19 + var_154_29 and arg_151_1.time_ < var_154_19 + var_154_29 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play410012038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410012038
		arg_155_1.duration_ = 6.13

		local var_155_0 = {
			zh = 1.6,
			ja = 6.133
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
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play410012039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10062"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10062 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10062", 3)

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
				local var_158_6 = Vector3.New(0, -390, -290)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10062, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_158_7 = arg_155_1.actors_["10062"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10062 == nil then
				arg_155_1.var_.actorSpriteComps10062 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.034

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10062 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10062 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10062 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 1

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				local var_158_17 = "play"
				local var_158_18 = "effect"

				arg_155_1:AudioAction(var_158_17, var_158_18, "se_story_128", "se_story_128_bell", "")
			end

			local var_158_19 = 0
			local var_158_20 = 0.075

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_21 = arg_155_1:FormatText(StoryNameCfg[592].name)

				arg_155_1.leftNameTxt_.text = var_158_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_22 = arg_155_1:GetWordFromCfg(410012038)
				local var_158_23 = arg_155_1:FormatText(var_158_22.content)

				arg_155_1.text_.text = var_158_23

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_24 = 3
				local var_158_25 = utf8.len(var_158_23)
				local var_158_26 = var_158_24 <= 0 and var_158_20 or var_158_20 * (var_158_25 / var_158_24)

				if var_158_26 > 0 and var_158_20 < var_158_26 then
					arg_155_1.talkMaxDuration = var_158_26

					if var_158_26 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_26 + var_158_19
					end
				end

				arg_155_1.text_.text = var_158_23
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012038", "story_v_out_410012.awb") ~= 0 then
					local var_158_27 = manager.audio:GetVoiceLength("story_v_out_410012", "410012038", "story_v_out_410012.awb") / 1000

					if var_158_27 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_27 + var_158_19
					end

					if var_158_22.prefab_name ~= "" and arg_155_1.actors_[var_158_22.prefab_name] ~= nil then
						local var_158_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_22.prefab_name].transform, "story_v_out_410012", "410012038", "story_v_out_410012.awb")

						arg_155_1:RecordAudio("410012038", var_158_28)
						arg_155_1:RecordAudio("410012038", var_158_28)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410012", "410012038", "story_v_out_410012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410012", "410012038", "story_v_out_410012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_29 = math.max(var_158_20, arg_155_1.talkMaxDuration)

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_29 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_19) / var_158_29

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_19 + var_158_29 and arg_155_1.time_ < var_158_19 + var_158_29 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410012039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410012039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play410012040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10062"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10062 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10062", 7)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(0, -2000, -290)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10062, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_162_7 = arg_159_1.actors_["10062"]
			local var_162_8 = 0

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10062 == nil then
				arg_159_1.var_.actorSpriteComps10062 = var_162_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_9 = 0.034

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_9 and not isNil(var_162_7) then
				local var_162_10 = (arg_159_1.time_ - var_162_8) / var_162_9

				if arg_159_1.var_.actorSpriteComps10062 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								local var_162_11 = Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor2.r, var_162_10)
								local var_162_12 = Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor2.g, var_162_10)
								local var_162_13 = Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor2.b, var_162_10)

								iter_162_2.color = Color.New(var_162_11, var_162_12, var_162_13)
							else
								local var_162_14 = Mathf.Lerp(iter_162_2.color.r, 0.5, var_162_10)

								iter_162_2.color = Color.New(var_162_14, var_162_14, var_162_14)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_8 + var_162_9 and arg_159_1.time_ < var_162_8 + var_162_9 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10062 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_162_4 then
						if arg_159_1.isInRecall_ then
							iter_162_4.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10062 = nil
			end

			local var_162_15 = 0
			local var_162_16 = 1.125

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_17 = arg_159_1:GetWordFromCfg(410012039)
				local var_162_18 = arg_159_1:FormatText(var_162_17.content)

				arg_159_1.text_.text = var_162_18

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_19 = 45
				local var_162_20 = utf8.len(var_162_18)
				local var_162_21 = var_162_19 <= 0 and var_162_16 or var_162_16 * (var_162_20 / var_162_19)

				if var_162_21 > 0 and var_162_16 < var_162_21 then
					arg_159_1.talkMaxDuration = var_162_21

					if var_162_21 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_21 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_18
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_22 and arg_159_1.time_ < var_162_15 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play410012040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410012040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play410012041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.725

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(410012040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 69
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play410012041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410012041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play410012042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.375

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(410012041)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 55
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play410012042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410012042
		arg_171_1.duration_ = 14.1

		local var_171_0 = {
			zh = 14.1,
			ja = 13.2
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play410012043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1060"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1060 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1060", 3)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(33.4, -430.8, 6.9)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1060, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_174_7 = arg_171_1.actors_["1060"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1060 == nil then
				arg_171_1.var_.actorSpriteComps1060 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.034

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps1060 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 1, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1060 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1060 = nil
			end

			local var_174_15 = 0
			local var_174_16 = 1.525

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[584].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(410012042)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 61
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012042", "story_v_out_410012.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012042", "story_v_out_410012.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_410012", "410012042", "story_v_out_410012.awb")

						arg_171_1:RecordAudio("410012042", var_174_24)
						arg_171_1:RecordAudio("410012042", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410012", "410012042", "story_v_out_410012.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410012", "410012042", "story_v_out_410012.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410012043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410012043
		arg_175_1.duration_ = 6.6

		local var_175_0 = {
			zh = 4.566,
			ja = 6.6
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play410012044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1060"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1060 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1060", 3)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(33.4, -430.8, 6.9)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1060, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_178_7 = arg_175_1.actors_["1060"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps1060 == nil then
				arg_175_1.var_.actorSpriteComps1060 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 0.034

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps1060 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor1.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor1.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor1.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 1, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps1060 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1060 = nil
			end

			local var_178_15 = 0
			local var_178_16 = 0.575

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[584].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(410012043)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 23
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012043", "story_v_out_410012.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012043", "story_v_out_410012.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_410012", "410012043", "story_v_out_410012.awb")

						arg_175_1:RecordAudio("410012043", var_178_24)
						arg_175_1:RecordAudio("410012043", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410012", "410012043", "story_v_out_410012.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410012", "410012043", "story_v_out_410012.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play410012044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410012044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play410012045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1060"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1060 == nil then
				arg_179_1.var_.actorSpriteComps1060 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.034

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps1060 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 0.5, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1060 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1060 = nil
			end

			local var_182_8 = 0
			local var_182_9 = 1.2

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(410012044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_12 = 48
				local var_182_13 = utf8.len(var_182_11)
				local var_182_14 = var_182_12 <= 0 and var_182_9 or var_182_9 * (var_182_13 / var_182_12)

				if var_182_14 > 0 and var_182_9 < var_182_14 then
					arg_179_1.talkMaxDuration = var_182_14

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_15 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_15 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_15

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_15 and arg_179_1.time_ < var_182_8 + var_182_15 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410012045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410012045
		arg_183_1.duration_ = 7.37

		local var_183_0 = {
			zh = 5.133,
			ja = 7.366
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play410012046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1060"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1060 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1060", 3)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(33.4, -430.8, 6.9)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1060, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_186_7 = arg_183_1.actors_["1060"]
			local var_186_8 = 0

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps1060 == nil then
				arg_183_1.var_.actorSpriteComps1060 = var_186_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_9 = 0.034

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 and not isNil(var_186_7) then
				local var_186_10 = (arg_183_1.time_ - var_186_8) / var_186_9

				if arg_183_1.var_.actorSpriteComps1060 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								local var_186_11 = Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor1.r, var_186_10)
								local var_186_12 = Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor1.g, var_186_10)
								local var_186_13 = Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor1.b, var_186_10)

								iter_186_2.color = Color.New(var_186_11, var_186_12, var_186_13)
							else
								local var_186_14 = Mathf.Lerp(iter_186_2.color.r, 1, var_186_10)

								iter_186_2.color = Color.New(var_186_14, var_186_14, var_186_14)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps1060 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_186_4 then
						if arg_183_1.isInRecall_ then
							iter_186_4.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1060 = nil
			end

			local var_186_15 = 0
			local var_186_16 = 0.65

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[584].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(410012045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 26
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012045", "story_v_out_410012.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012045", "story_v_out_410012.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_410012", "410012045", "story_v_out_410012.awb")

						arg_183_1:RecordAudio("410012045", var_186_24)
						arg_183_1:RecordAudio("410012045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410012", "410012045", "story_v_out_410012.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410012", "410012045", "story_v_out_410012.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play410012046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410012046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play410012047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1060"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1060 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1060", 7)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(0, -2000, -40)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1060, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_190_7 = arg_187_1.actors_["1060"]
			local var_190_8 = 0

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps1060 == nil then
				arg_187_1.var_.actorSpriteComps1060 = var_190_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 0.034

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 and not isNil(var_190_7) then
				local var_190_10 = (arg_187_1.time_ - var_190_8) / var_190_9

				if arg_187_1.var_.actorSpriteComps1060 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								local var_190_11 = Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor2.r, var_190_10)
								local var_190_12 = Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor2.g, var_190_10)
								local var_190_13 = Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor2.b, var_190_10)

								iter_190_2.color = Color.New(var_190_11, var_190_12, var_190_13)
							else
								local var_190_14 = Mathf.Lerp(iter_190_2.color.r, 0.5, var_190_10)

								iter_190_2.color = Color.New(var_190_14, var_190_14, var_190_14)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps1060 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_190_4 then
						if arg_187_1.isInRecall_ then
							iter_190_4.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1060 = nil
			end

			local var_190_15 = 0
			local var_190_16 = 1.35

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_17 = arg_187_1:GetWordFromCfg(410012046)
				local var_190_18 = arg_187_1:FormatText(var_190_17.content)

				arg_187_1.text_.text = var_190_18

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_19 = 54
				local var_190_20 = utf8.len(var_190_18)
				local var_190_21 = var_190_19 <= 0 and var_190_16 or var_190_16 * (var_190_20 / var_190_19)

				if var_190_21 > 0 and var_190_16 < var_190_21 then
					arg_187_1.talkMaxDuration = var_190_21

					if var_190_21 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_21 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_18
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_22 and arg_187_1.time_ < var_190_15 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play410012047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410012047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play410012048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.25

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(410012047)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 50
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play410012048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410012048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play410012049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				local var_198_2 = "play"
				local var_198_3 = "effect"

				arg_195_1:AudioAction(var_198_2, var_198_3, "se_story_128", "se_story_128_cheer", "")
			end

			local var_198_4 = 0
			local var_198_5 = 1.275

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(410012048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_8 = 51
				local var_198_9 = utf8.len(var_198_7)
				local var_198_10 = var_198_8 <= 0 and var_198_5 or var_198_5 * (var_198_9 / var_198_8)

				if var_198_10 > 0 and var_198_5 < var_198_10 then
					arg_195_1.talkMaxDuration = var_198_10

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_11 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_11 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_11

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_11 and arg_195_1.time_ < var_198_4 + var_198_11 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play410012049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410012049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play410012050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.125

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(410012049)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 45
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play410012050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410012050
		arg_203_1.duration_ = 8.87

		local var_203_0 = {
			zh = 6.566,
			ja = 8.866
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play410012051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10062"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10062 = var_206_0.localPosition
				var_206_0.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10062", 3)

				local var_206_2 = var_206_0.childCount

				for iter_206_0 = 0, var_206_2 - 1 do
					local var_206_3 = var_206_0:GetChild(iter_206_0)

					if var_206_3.name == "split_2" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_4 then
				local var_206_5 = (arg_203_1.time_ - var_206_1) / var_206_4
				local var_206_6 = Vector3.New(0, -390, -290)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10062, var_206_6, var_206_5)
			end

			if arg_203_1.time_ >= var_206_1 + var_206_4 and arg_203_1.time_ < var_206_1 + var_206_4 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_206_7 = arg_203_1.actors_["10062"]
			local var_206_8 = 0

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps10062 == nil then
				arg_203_1.var_.actorSpriteComps10062 = var_206_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_9 = 0.034

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 and not isNil(var_206_7) then
				local var_206_10 = (arg_203_1.time_ - var_206_8) / var_206_9

				if arg_203_1.var_.actorSpriteComps10062 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								local var_206_11 = Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, var_206_10)
								local var_206_12 = Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, var_206_10)
								local var_206_13 = Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, var_206_10)

								iter_206_2.color = Color.New(var_206_11, var_206_12, var_206_13)
							else
								local var_206_14 = Mathf.Lerp(iter_206_2.color.r, 1, var_206_10)

								iter_206_2.color = Color.New(var_206_14, var_206_14, var_206_14)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps10062 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_206_4 then
						if arg_203_1.isInRecall_ then
							iter_206_4.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10062 = nil
			end

			local var_206_15 = 0
			local var_206_16 = 0.575

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[592].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(410012050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 23
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012050", "story_v_out_410012.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012050", "story_v_out_410012.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_410012", "410012050", "story_v_out_410012.awb")

						arg_203_1:RecordAudio("410012050", var_206_24)
						arg_203_1:RecordAudio("410012050", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_410012", "410012050", "story_v_out_410012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_410012", "410012050", "story_v_out_410012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410012051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410012051
		arg_207_1.duration_ = 10.13

		local var_207_0 = {
			zh = 7.6,
			ja = 10.133
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
				arg_207_0:Play410012052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10062"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10062 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10062", 4)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "split_2" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(370, -390, -290)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10062, var_210_6, var_210_5)
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_210_7 = arg_207_1.actors_["1060"].transform
			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.var_.moveOldPos1060 = var_210_7.localPosition
				var_210_7.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1060", 2)

				local var_210_9 = var_210_7.childCount

				for iter_210_1 = 0, var_210_9 - 1 do
					local var_210_10 = var_210_7:GetChild(iter_210_1)

					if var_210_10.name == "split_1" or not string.find(var_210_10.name, "split") then
						var_210_10.gameObject:SetActive(true)
					else
						var_210_10.gameObject:SetActive(false)
					end
				end
			end

			local var_210_11 = 0.001

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_8) / var_210_11
				local var_210_13 = Vector3.New(-440.94, -430.8, 6.9)

				var_210_7.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1060, var_210_13, var_210_12)
			end

			if arg_207_1.time_ >= var_210_8 + var_210_11 and arg_207_1.time_ < var_210_8 + var_210_11 + arg_210_0 then
				var_210_7.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_210_14 = arg_207_1.actors_["10062"]
			local var_210_15 = 0

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 and not isNil(var_210_14) and arg_207_1.var_.actorSpriteComps10062 == nil then
				arg_207_1.var_.actorSpriteComps10062 = var_210_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_16 = 0.034

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_16 and not isNil(var_210_14) then
				local var_210_17 = (arg_207_1.time_ - var_210_15) / var_210_16

				if arg_207_1.var_.actorSpriteComps10062 then
					for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_210_3 then
							if arg_207_1.isInRecall_ then
								local var_210_18 = Mathf.Lerp(iter_210_3.color.r, arg_207_1.hightColor2.r, var_210_17)
								local var_210_19 = Mathf.Lerp(iter_210_3.color.g, arg_207_1.hightColor2.g, var_210_17)
								local var_210_20 = Mathf.Lerp(iter_210_3.color.b, arg_207_1.hightColor2.b, var_210_17)

								iter_210_3.color = Color.New(var_210_18, var_210_19, var_210_20)
							else
								local var_210_21 = Mathf.Lerp(iter_210_3.color.r, 0.5, var_210_17)

								iter_210_3.color = Color.New(var_210_21, var_210_21, var_210_21)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_15 + var_210_16 and arg_207_1.time_ < var_210_15 + var_210_16 + arg_210_0 and not isNil(var_210_14) and arg_207_1.var_.actorSpriteComps10062 then
				for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_210_5 then
						if arg_207_1.isInRecall_ then
							iter_210_5.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10062 = nil
			end

			local var_210_22 = arg_207_1.actors_["1060"]
			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.actorSpriteComps1060 == nil then
				arg_207_1.var_.actorSpriteComps1060 = var_210_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_24 = 0.034

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 and not isNil(var_210_22) then
				local var_210_25 = (arg_207_1.time_ - var_210_23) / var_210_24

				if arg_207_1.var_.actorSpriteComps1060 then
					for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_210_7 then
							if arg_207_1.isInRecall_ then
								local var_210_26 = Mathf.Lerp(iter_210_7.color.r, arg_207_1.hightColor1.r, var_210_25)
								local var_210_27 = Mathf.Lerp(iter_210_7.color.g, arg_207_1.hightColor1.g, var_210_25)
								local var_210_28 = Mathf.Lerp(iter_210_7.color.b, arg_207_1.hightColor1.b, var_210_25)

								iter_210_7.color = Color.New(var_210_26, var_210_27, var_210_28)
							else
								local var_210_29 = Mathf.Lerp(iter_210_7.color.r, 1, var_210_25)

								iter_210_7.color = Color.New(var_210_29, var_210_29, var_210_29)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.actorSpriteComps1060 then
				for iter_210_8, iter_210_9 in pairs(arg_207_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_210_9 then
						if arg_207_1.isInRecall_ then
							iter_210_9.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1060 = nil
			end

			local var_210_30 = 0
			local var_210_31 = 0.775

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[584].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(410012051)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 31
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012051", "story_v_out_410012.awb") ~= 0 then
					local var_210_38 = manager.audio:GetVoiceLength("story_v_out_410012", "410012051", "story_v_out_410012.awb") / 1000

					if var_210_38 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_38 + var_210_30
					end

					if var_210_33.prefab_name ~= "" and arg_207_1.actors_[var_210_33.prefab_name] ~= nil then
						local var_210_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_33.prefab_name].transform, "story_v_out_410012", "410012051", "story_v_out_410012.awb")

						arg_207_1:RecordAudio("410012051", var_210_39)
						arg_207_1:RecordAudio("410012051", var_210_39)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_410012", "410012051", "story_v_out_410012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_410012", "410012051", "story_v_out_410012.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_40 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_40 and arg_207_1.time_ < var_210_30 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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

		arg_207_1:InitPlayNodeList()
	end,
	Play410012052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410012052
		arg_211_1.duration_ = 4.07

		local var_211_0 = {
			zh = 1.933,
			ja = 4.066
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play410012053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10061"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10061 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10061", 4)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "split_5" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(390, -517.5, -100)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10061, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_214_7 = arg_211_1.actors_["10062"].transform
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.var_.moveOldPos10062 = var_214_7.localPosition
				var_214_7.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10062", 7)

				local var_214_9 = var_214_7.childCount

				for iter_214_1 = 0, var_214_9 - 1 do
					local var_214_10 = var_214_7:GetChild(iter_214_1)

					if var_214_10.name == "" or not string.find(var_214_10.name, "split") then
						var_214_10.gameObject:SetActive(true)
					else
						var_214_10.gameObject:SetActive(false)
					end
				end
			end

			local var_214_11 = 0.001

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_11 then
				local var_214_12 = (arg_211_1.time_ - var_214_8) / var_214_11
				local var_214_13 = Vector3.New(0, -2000, -290)

				var_214_7.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10062, var_214_13, var_214_12)
			end

			if arg_211_1.time_ >= var_214_8 + var_214_11 and arg_211_1.time_ < var_214_8 + var_214_11 + arg_214_0 then
				var_214_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_214_14 = arg_211_1.actors_["10061"]
			local var_214_15 = 0

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 and not isNil(var_214_14) and arg_211_1.var_.actorSpriteComps10061 == nil then
				arg_211_1.var_.actorSpriteComps10061 = var_214_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_16 = 0.034

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_16 and not isNil(var_214_14) then
				local var_214_17 = (arg_211_1.time_ - var_214_15) / var_214_16

				if arg_211_1.var_.actorSpriteComps10061 then
					for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_214_3 then
							if arg_211_1.isInRecall_ then
								local var_214_18 = Mathf.Lerp(iter_214_3.color.r, arg_211_1.hightColor1.r, var_214_17)
								local var_214_19 = Mathf.Lerp(iter_214_3.color.g, arg_211_1.hightColor1.g, var_214_17)
								local var_214_20 = Mathf.Lerp(iter_214_3.color.b, arg_211_1.hightColor1.b, var_214_17)

								iter_214_3.color = Color.New(var_214_18, var_214_19, var_214_20)
							else
								local var_214_21 = Mathf.Lerp(iter_214_3.color.r, 1, var_214_17)

								iter_214_3.color = Color.New(var_214_21, var_214_21, var_214_21)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_15 + var_214_16 and arg_211_1.time_ < var_214_15 + var_214_16 + arg_214_0 and not isNil(var_214_14) and arg_211_1.var_.actorSpriteComps10061 then
				for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_214_5 then
						if arg_211_1.isInRecall_ then
							iter_214_5.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10061 = nil
			end

			local var_214_22 = arg_211_1.actors_["10062"]
			local var_214_23 = 0

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 and not isNil(var_214_22) and arg_211_1.var_.actorSpriteComps10062 == nil then
				arg_211_1.var_.actorSpriteComps10062 = var_214_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_24 = 0.034

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_24 and not isNil(var_214_22) then
				local var_214_25 = (arg_211_1.time_ - var_214_23) / var_214_24

				if arg_211_1.var_.actorSpriteComps10062 then
					for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_214_7 then
							if arg_211_1.isInRecall_ then
								local var_214_26 = Mathf.Lerp(iter_214_7.color.r, arg_211_1.hightColor2.r, var_214_25)
								local var_214_27 = Mathf.Lerp(iter_214_7.color.g, arg_211_1.hightColor2.g, var_214_25)
								local var_214_28 = Mathf.Lerp(iter_214_7.color.b, arg_211_1.hightColor2.b, var_214_25)

								iter_214_7.color = Color.New(var_214_26, var_214_27, var_214_28)
							else
								local var_214_29 = Mathf.Lerp(iter_214_7.color.r, 0.5, var_214_25)

								iter_214_7.color = Color.New(var_214_29, var_214_29, var_214_29)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_23 + var_214_24 and arg_211_1.time_ < var_214_23 + var_214_24 + arg_214_0 and not isNil(var_214_22) and arg_211_1.var_.actorSpriteComps10062 then
				for iter_214_8, iter_214_9 in pairs(arg_211_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_214_9 then
						if arg_211_1.isInRecall_ then
							iter_214_9.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10062 = nil
			end

			local var_214_30 = arg_211_1.actors_["1060"]
			local var_214_31 = 0

			if var_214_31 < arg_211_1.time_ and arg_211_1.time_ <= var_214_31 + arg_214_0 and not isNil(var_214_30) and arg_211_1.var_.actorSpriteComps1060 == nil then
				arg_211_1.var_.actorSpriteComps1060 = var_214_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_32 = 0.034

			if var_214_31 <= arg_211_1.time_ and arg_211_1.time_ < var_214_31 + var_214_32 and not isNil(var_214_30) then
				local var_214_33 = (arg_211_1.time_ - var_214_31) / var_214_32

				if arg_211_1.var_.actorSpriteComps1060 then
					for iter_214_10, iter_214_11 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_214_11 then
							if arg_211_1.isInRecall_ then
								local var_214_34 = Mathf.Lerp(iter_214_11.color.r, arg_211_1.hightColor2.r, var_214_33)
								local var_214_35 = Mathf.Lerp(iter_214_11.color.g, arg_211_1.hightColor2.g, var_214_33)
								local var_214_36 = Mathf.Lerp(iter_214_11.color.b, arg_211_1.hightColor2.b, var_214_33)

								iter_214_11.color = Color.New(var_214_34, var_214_35, var_214_36)
							else
								local var_214_37 = Mathf.Lerp(iter_214_11.color.r, 0.5, var_214_33)

								iter_214_11.color = Color.New(var_214_37, var_214_37, var_214_37)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_31 + var_214_32 and arg_211_1.time_ < var_214_31 + var_214_32 + arg_214_0 and not isNil(var_214_30) and arg_211_1.var_.actorSpriteComps1060 then
				for iter_214_12, iter_214_13 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_214_13 then
						if arg_211_1.isInRecall_ then
							iter_214_13.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1060 = nil
			end

			local var_214_38 = 0
			local var_214_39 = 0.225

			if var_214_38 < arg_211_1.time_ and arg_211_1.time_ <= var_214_38 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_40 = arg_211_1:FormatText(StoryNameCfg[591].name)

				arg_211_1.leftNameTxt_.text = var_214_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_41 = arg_211_1:GetWordFromCfg(410012052)
				local var_214_42 = arg_211_1:FormatText(var_214_41.content)

				arg_211_1.text_.text = var_214_42

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_43 = 9
				local var_214_44 = utf8.len(var_214_42)
				local var_214_45 = var_214_43 <= 0 and var_214_39 or var_214_39 * (var_214_44 / var_214_43)

				if var_214_45 > 0 and var_214_39 < var_214_45 then
					arg_211_1.talkMaxDuration = var_214_45

					if var_214_45 + var_214_38 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_45 + var_214_38
					end
				end

				arg_211_1.text_.text = var_214_42
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012052", "story_v_out_410012.awb") ~= 0 then
					local var_214_46 = manager.audio:GetVoiceLength("story_v_out_410012", "410012052", "story_v_out_410012.awb") / 1000

					if var_214_46 + var_214_38 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_46 + var_214_38
					end

					if var_214_41.prefab_name ~= "" and arg_211_1.actors_[var_214_41.prefab_name] ~= nil then
						local var_214_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_41.prefab_name].transform, "story_v_out_410012", "410012052", "story_v_out_410012.awb")

						arg_211_1:RecordAudio("410012052", var_214_47)
						arg_211_1:RecordAudio("410012052", var_214_47)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410012", "410012052", "story_v_out_410012.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410012", "410012052", "story_v_out_410012.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_48 = math.max(var_214_39, arg_211_1.talkMaxDuration)

			if var_214_38 <= arg_211_1.time_ and arg_211_1.time_ < var_214_38 + var_214_48 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_38) / var_214_48

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_38 + var_214_48 and arg_211_1.time_ < var_214_38 + var_214_48 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410012053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410012053
		arg_215_1.duration_ = 7.03

		local var_215_0 = {
			zh = 4.4,
			ja = 7.033
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
				arg_215_0:Play410012054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1060"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1060 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1060", 2)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1060, var_218_6, var_218_5)
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_218_7 = arg_215_1.actors_["1060"]
			local var_218_8 = 0

			if var_218_8 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1060 == nil then
				arg_215_1.var_.actorSpriteComps1060 = var_218_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_9 = 0.034

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 and not isNil(var_218_7) then
				local var_218_10 = (arg_215_1.time_ - var_218_8) / var_218_9

				if arg_215_1.var_.actorSpriteComps1060 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								local var_218_11 = Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, var_218_10)
								local var_218_12 = Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, var_218_10)
								local var_218_13 = Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, var_218_10)

								iter_218_2.color = Color.New(var_218_11, var_218_12, var_218_13)
							else
								local var_218_14 = Mathf.Lerp(iter_218_2.color.r, 1, var_218_10)

								iter_218_2.color = Color.New(var_218_14, var_218_14, var_218_14)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1060 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_218_4 then
						if arg_215_1.isInRecall_ then
							iter_218_4.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1060 = nil
			end

			local var_218_15 = arg_215_1.actors_["10061"]
			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.actorSpriteComps10061 == nil then
				arg_215_1.var_.actorSpriteComps10061 = var_218_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_17 = 0.034

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 and not isNil(var_218_15) then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17

				if arg_215_1.var_.actorSpriteComps10061 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								local var_218_19 = Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, var_218_18)
								local var_218_20 = Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, var_218_18)
								local var_218_21 = Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, var_218_18)

								iter_218_6.color = Color.New(var_218_19, var_218_20, var_218_21)
							else
								local var_218_22 = Mathf.Lerp(iter_218_6.color.r, 0.5, var_218_18)

								iter_218_6.color = Color.New(var_218_22, var_218_22, var_218_22)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.actorSpriteComps10061 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_218_8 then
						if arg_215_1.isInRecall_ then
							iter_218_8.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10061 = nil
			end

			local var_218_23 = 0
			local var_218_24 = 0.575

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_25 = arg_215_1:FormatText(StoryNameCfg[584].name)

				arg_215_1.leftNameTxt_.text = var_218_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(410012053)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 23
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_24 or var_218_24 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_24 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_23
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012053", "story_v_out_410012.awb") ~= 0 then
					local var_218_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012053", "story_v_out_410012.awb") / 1000

					if var_218_31 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_23
					end

					if var_218_26.prefab_name ~= "" and arg_215_1.actors_[var_218_26.prefab_name] ~= nil then
						local var_218_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_26.prefab_name].transform, "story_v_out_410012", "410012053", "story_v_out_410012.awb")

						arg_215_1:RecordAudio("410012053", var_218_32)
						arg_215_1:RecordAudio("410012053", var_218_32)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410012", "410012053", "story_v_out_410012.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410012", "410012053", "story_v_out_410012.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_33 = math.max(var_218_24, arg_215_1.talkMaxDuration)

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_33 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_33

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_33 and arg_215_1.time_ < var_218_23 + var_218_33 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play410012054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410012054
		arg_219_1.duration_ = 10.87

		local var_219_0 = {
			zh = 5.666,
			ja = 10.866
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410012055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10062"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos10062 = var_222_0.localPosition
				var_222_0.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10062", 4)

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
				local var_222_6 = Vector3.New(370, -390, -290)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10062, var_222_6, var_222_5)
			end

			if arg_219_1.time_ >= var_222_1 + var_222_4 and arg_219_1.time_ < var_222_1 + var_222_4 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_222_7 = arg_219_1.actors_["10061"].transform
			local var_222_8 = 0

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.var_.moveOldPos10061 = var_222_7.localPosition
				var_222_7.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10061", 7)

				local var_222_9 = var_222_7.childCount

				for iter_222_1 = 0, var_222_9 - 1 do
					local var_222_10 = var_222_7:GetChild(iter_222_1)

					if var_222_10.name == "" or not string.find(var_222_10.name, "split") then
						var_222_10.gameObject:SetActive(true)
					else
						var_222_10.gameObject:SetActive(false)
					end
				end
			end

			local var_222_11 = 0.001

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_11 then
				local var_222_12 = (arg_219_1.time_ - var_222_8) / var_222_11
				local var_222_13 = Vector3.New(0, -2000, -100)

				var_222_7.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10061, var_222_13, var_222_12)
			end

			if arg_219_1.time_ >= var_222_8 + var_222_11 and arg_219_1.time_ < var_222_8 + var_222_11 + arg_222_0 then
				var_222_7.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_222_14 = arg_219_1.actors_["10062"]
			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 and not isNil(var_222_14) and arg_219_1.var_.actorSpriteComps10062 == nil then
				arg_219_1.var_.actorSpriteComps10062 = var_222_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_16 = 0.034

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 and not isNil(var_222_14) then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16

				if arg_219_1.var_.actorSpriteComps10062 then
					for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_222_3 then
							if arg_219_1.isInRecall_ then
								local var_222_18 = Mathf.Lerp(iter_222_3.color.r, arg_219_1.hightColor1.r, var_222_17)
								local var_222_19 = Mathf.Lerp(iter_222_3.color.g, arg_219_1.hightColor1.g, var_222_17)
								local var_222_20 = Mathf.Lerp(iter_222_3.color.b, arg_219_1.hightColor1.b, var_222_17)

								iter_222_3.color = Color.New(var_222_18, var_222_19, var_222_20)
							else
								local var_222_21 = Mathf.Lerp(iter_222_3.color.r, 1, var_222_17)

								iter_222_3.color = Color.New(var_222_21, var_222_21, var_222_21)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 and not isNil(var_222_14) and arg_219_1.var_.actorSpriteComps10062 then
				for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_222_5 then
						if arg_219_1.isInRecall_ then
							iter_222_5.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10062 = nil
			end

			local var_222_22 = arg_219_1.actors_["10061"]
			local var_222_23 = 0

			if var_222_23 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 and not isNil(var_222_22) and arg_219_1.var_.actorSpriteComps10061 == nil then
				arg_219_1.var_.actorSpriteComps10061 = var_222_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_24 = 0.034

			if var_222_23 <= arg_219_1.time_ and arg_219_1.time_ < var_222_23 + var_222_24 and not isNil(var_222_22) then
				local var_222_25 = (arg_219_1.time_ - var_222_23) / var_222_24

				if arg_219_1.var_.actorSpriteComps10061 then
					for iter_222_6, iter_222_7 in pairs(arg_219_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_222_7 then
							if arg_219_1.isInRecall_ then
								local var_222_26 = Mathf.Lerp(iter_222_7.color.r, arg_219_1.hightColor2.r, var_222_25)
								local var_222_27 = Mathf.Lerp(iter_222_7.color.g, arg_219_1.hightColor2.g, var_222_25)
								local var_222_28 = Mathf.Lerp(iter_222_7.color.b, arg_219_1.hightColor2.b, var_222_25)

								iter_222_7.color = Color.New(var_222_26, var_222_27, var_222_28)
							else
								local var_222_29 = Mathf.Lerp(iter_222_7.color.r, 0.5, var_222_25)

								iter_222_7.color = Color.New(var_222_29, var_222_29, var_222_29)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_23 + var_222_24 and arg_219_1.time_ < var_222_23 + var_222_24 + arg_222_0 and not isNil(var_222_22) and arg_219_1.var_.actorSpriteComps10061 then
				for iter_222_8, iter_222_9 in pairs(arg_219_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_222_9 then
						if arg_219_1.isInRecall_ then
							iter_222_9.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10061 = nil
			end

			local var_222_30 = arg_219_1.actors_["1060"]
			local var_222_31 = 0

			if var_222_31 < arg_219_1.time_ and arg_219_1.time_ <= var_222_31 + arg_222_0 and not isNil(var_222_30) and arg_219_1.var_.actorSpriteComps1060 == nil then
				arg_219_1.var_.actorSpriteComps1060 = var_222_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_32 = 0.034

			if var_222_31 <= arg_219_1.time_ and arg_219_1.time_ < var_222_31 + var_222_32 and not isNil(var_222_30) then
				local var_222_33 = (arg_219_1.time_ - var_222_31) / var_222_32

				if arg_219_1.var_.actorSpriteComps1060 then
					for iter_222_10, iter_222_11 in pairs(arg_219_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_222_11 then
							if arg_219_1.isInRecall_ then
								local var_222_34 = Mathf.Lerp(iter_222_11.color.r, arg_219_1.hightColor2.r, var_222_33)
								local var_222_35 = Mathf.Lerp(iter_222_11.color.g, arg_219_1.hightColor2.g, var_222_33)
								local var_222_36 = Mathf.Lerp(iter_222_11.color.b, arg_219_1.hightColor2.b, var_222_33)

								iter_222_11.color = Color.New(var_222_34, var_222_35, var_222_36)
							else
								local var_222_37 = Mathf.Lerp(iter_222_11.color.r, 0.5, var_222_33)

								iter_222_11.color = Color.New(var_222_37, var_222_37, var_222_37)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_31 + var_222_32 and arg_219_1.time_ < var_222_31 + var_222_32 + arg_222_0 and not isNil(var_222_30) and arg_219_1.var_.actorSpriteComps1060 then
				for iter_222_12, iter_222_13 in pairs(arg_219_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_222_13 then
						if arg_219_1.isInRecall_ then
							iter_222_13.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1060 = nil
			end

			local var_222_38 = 0
			local var_222_39 = 0.45

			if var_222_38 < arg_219_1.time_ and arg_219_1.time_ <= var_222_38 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_40 = arg_219_1:FormatText(StoryNameCfg[592].name)

				arg_219_1.leftNameTxt_.text = var_222_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_41 = arg_219_1:GetWordFromCfg(410012054)
				local var_222_42 = arg_219_1:FormatText(var_222_41.content)

				arg_219_1.text_.text = var_222_42

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_43 = 18
				local var_222_44 = utf8.len(var_222_42)
				local var_222_45 = var_222_43 <= 0 and var_222_39 or var_222_39 * (var_222_44 / var_222_43)

				if var_222_45 > 0 and var_222_39 < var_222_45 then
					arg_219_1.talkMaxDuration = var_222_45

					if var_222_45 + var_222_38 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_45 + var_222_38
					end
				end

				arg_219_1.text_.text = var_222_42
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012054", "story_v_out_410012.awb") ~= 0 then
					local var_222_46 = manager.audio:GetVoiceLength("story_v_out_410012", "410012054", "story_v_out_410012.awb") / 1000

					if var_222_46 + var_222_38 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_46 + var_222_38
					end

					if var_222_41.prefab_name ~= "" and arg_219_1.actors_[var_222_41.prefab_name] ~= nil then
						local var_222_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_41.prefab_name].transform, "story_v_out_410012", "410012054", "story_v_out_410012.awb")

						arg_219_1:RecordAudio("410012054", var_222_47)
						arg_219_1:RecordAudio("410012054", var_222_47)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_410012", "410012054", "story_v_out_410012.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_410012", "410012054", "story_v_out_410012.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_48 = math.max(var_222_39, arg_219_1.talkMaxDuration)

			if var_222_38 <= arg_219_1.time_ and arg_219_1.time_ < var_222_38 + var_222_48 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_38) / var_222_48

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_38 + var_222_48 and arg_219_1.time_ < var_222_38 + var_222_48 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410012055
		arg_223_1.duration_ = 5.17

		local var_223_0 = {
			zh = 1.1,
			ja = 5.166
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
				arg_223_0:Play410012056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1060"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1060 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1060", 2)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1060, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_226_7 = arg_223_1.actors_["1060"]
			local var_226_8 = 0

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1060 == nil then
				arg_223_1.var_.actorSpriteComps1060 = var_226_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_9 = 0.034

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 and not isNil(var_226_7) then
				local var_226_10 = (arg_223_1.time_ - var_226_8) / var_226_9

				if arg_223_1.var_.actorSpriteComps1060 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								local var_226_11 = Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, var_226_10)
								local var_226_12 = Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, var_226_10)
								local var_226_13 = Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, var_226_10)

								iter_226_2.color = Color.New(var_226_11, var_226_12, var_226_13)
							else
								local var_226_14 = Mathf.Lerp(iter_226_2.color.r, 1, var_226_10)

								iter_226_2.color = Color.New(var_226_14, var_226_14, var_226_14)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1060 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_226_4 then
						if arg_223_1.isInRecall_ then
							iter_226_4.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1060 = nil
			end

			local var_226_15 = arg_223_1.actors_["10062"]
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.actorSpriteComps10062 == nil then
				arg_223_1.var_.actorSpriteComps10062 = var_226_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_17 = 0.034

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 and not isNil(var_226_15) then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17

				if arg_223_1.var_.actorSpriteComps10062 then
					for iter_226_5, iter_226_6 in pairs(arg_223_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_226_6 then
							if arg_223_1.isInRecall_ then
								local var_226_19 = Mathf.Lerp(iter_226_6.color.r, arg_223_1.hightColor2.r, var_226_18)
								local var_226_20 = Mathf.Lerp(iter_226_6.color.g, arg_223_1.hightColor2.g, var_226_18)
								local var_226_21 = Mathf.Lerp(iter_226_6.color.b, arg_223_1.hightColor2.b, var_226_18)

								iter_226_6.color = Color.New(var_226_19, var_226_20, var_226_21)
							else
								local var_226_22 = Mathf.Lerp(iter_226_6.color.r, 0.5, var_226_18)

								iter_226_6.color = Color.New(var_226_22, var_226_22, var_226_22)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.actorSpriteComps10062 then
				for iter_226_7, iter_226_8 in pairs(arg_223_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_226_8 then
						if arg_223_1.isInRecall_ then
							iter_226_8.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10062 = nil
			end

			local var_226_23 = 0
			local var_226_24 = 0.15

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_25 = arg_223_1:FormatText(StoryNameCfg[584].name)

				arg_223_1.leftNameTxt_.text = var_226_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_26 = arg_223_1:GetWordFromCfg(410012055)
				local var_226_27 = arg_223_1:FormatText(var_226_26.content)

				arg_223_1.text_.text = var_226_27

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_28 = 6
				local var_226_29 = utf8.len(var_226_27)
				local var_226_30 = var_226_28 <= 0 and var_226_24 or var_226_24 * (var_226_29 / var_226_28)

				if var_226_30 > 0 and var_226_24 < var_226_30 then
					arg_223_1.talkMaxDuration = var_226_30

					if var_226_30 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_30 + var_226_23
					end
				end

				arg_223_1.text_.text = var_226_27
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012055", "story_v_out_410012.awb") ~= 0 then
					local var_226_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012055", "story_v_out_410012.awb") / 1000

					if var_226_31 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_31 + var_226_23
					end

					if var_226_26.prefab_name ~= "" and arg_223_1.actors_[var_226_26.prefab_name] ~= nil then
						local var_226_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_26.prefab_name].transform, "story_v_out_410012", "410012055", "story_v_out_410012.awb")

						arg_223_1:RecordAudio("410012055", var_226_32)
						arg_223_1:RecordAudio("410012055", var_226_32)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410012", "410012055", "story_v_out_410012.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410012", "410012055", "story_v_out_410012.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_33 = math.max(var_226_24, arg_223_1.talkMaxDuration)

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_33 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_23) / var_226_33

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_23 + var_226_33 and arg_223_1.time_ < var_226_23 + var_226_33 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play410012056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410012056
		arg_227_1.duration_ = 11.17

		local var_227_0 = {
			zh = 8.566,
			ja = 11.166
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
				arg_227_0:Play410012057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10062"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos10062 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10062", 4)

				local var_230_2 = var_230_0.childCount

				for iter_230_0 = 0, var_230_2 - 1 do
					local var_230_3 = var_230_0:GetChild(iter_230_0)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_4 then
				local var_230_5 = (arg_227_1.time_ - var_230_1) / var_230_4
				local var_230_6 = Vector3.New(370, -390, -290)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10062, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_230_7 = arg_227_1.actors_["10062"]
			local var_230_8 = 0

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10062 == nil then
				arg_227_1.var_.actorSpriteComps10062 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_9 = 0.034

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 and not isNil(var_230_7) then
				local var_230_10 = (arg_227_1.time_ - var_230_8) / var_230_9

				if arg_227_1.var_.actorSpriteComps10062 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_11 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, var_230_10)
								local var_230_12 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, var_230_10)
								local var_230_13 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, var_230_10)

								iter_230_2.color = Color.New(var_230_11, var_230_12, var_230_13)
							else
								local var_230_14 = Mathf.Lerp(iter_230_2.color.r, 1, var_230_10)

								iter_230_2.color = Color.New(var_230_14, var_230_14, var_230_14)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10062 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10062 = nil
			end

			local var_230_15 = arg_227_1.actors_["1060"]
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1060 == nil then
				arg_227_1.var_.actorSpriteComps1060 = var_230_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_17 = 0.034

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 and not isNil(var_230_15) then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17

				if arg_227_1.var_.actorSpriteComps1060 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								local var_230_19 = Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor2.r, var_230_18)
								local var_230_20 = Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor2.g, var_230_18)
								local var_230_21 = Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor2.b, var_230_18)

								iter_230_6.color = Color.New(var_230_19, var_230_20, var_230_21)
							else
								local var_230_22 = Mathf.Lerp(iter_230_6.color.r, 0.5, var_230_18)

								iter_230_6.color = Color.New(var_230_22, var_230_22, var_230_22)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1060 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_230_8 then
						if arg_227_1.isInRecall_ then
							iter_230_8.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1060 = nil
			end

			local var_230_23 = 0
			local var_230_24 = 0.8

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_25 = arg_227_1:FormatText(StoryNameCfg[592].name)

				arg_227_1.leftNameTxt_.text = var_230_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_26 = arg_227_1:GetWordFromCfg(410012056)
				local var_230_27 = arg_227_1:FormatText(var_230_26.content)

				arg_227_1.text_.text = var_230_27

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_28 = 32
				local var_230_29 = utf8.len(var_230_27)
				local var_230_30 = var_230_28 <= 0 and var_230_24 or var_230_24 * (var_230_29 / var_230_28)

				if var_230_30 > 0 and var_230_24 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30

					if var_230_30 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_23
					end
				end

				arg_227_1.text_.text = var_230_27
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012056", "story_v_out_410012.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012056", "story_v_out_410012.awb") / 1000

					if var_230_31 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_23
					end

					if var_230_26.prefab_name ~= "" and arg_227_1.actors_[var_230_26.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_26.prefab_name].transform, "story_v_out_410012", "410012056", "story_v_out_410012.awb")

						arg_227_1:RecordAudio("410012056", var_230_32)
						arg_227_1:RecordAudio("410012056", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410012", "410012056", "story_v_out_410012.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410012", "410012056", "story_v_out_410012.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_24, arg_227_1.talkMaxDuration)

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_23) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_23 + var_230_33 and arg_227_1.time_ < var_230_23 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410012057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410012057
		arg_231_1.duration_ = 11.97

		local var_231_0 = {
			zh = 6.766,
			ja = 11.966
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
				arg_231_0:Play410012058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10062"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10062 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10062", 4)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(370, -390, -290)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10062, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_234_7 = arg_231_1.actors_["10062"]
			local var_234_8 = 0

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10062 == nil then
				arg_231_1.var_.actorSpriteComps10062 = var_234_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_9 = 0.034

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 and not isNil(var_234_7) then
				local var_234_10 = (arg_231_1.time_ - var_234_8) / var_234_9

				if arg_231_1.var_.actorSpriteComps10062 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								local var_234_11 = Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor1.r, var_234_10)
								local var_234_12 = Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor1.g, var_234_10)
								local var_234_13 = Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor1.b, var_234_10)

								iter_234_2.color = Color.New(var_234_11, var_234_12, var_234_13)
							else
								local var_234_14 = Mathf.Lerp(iter_234_2.color.r, 1, var_234_10)

								iter_234_2.color = Color.New(var_234_14, var_234_14, var_234_14)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10062 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_234_4 then
						if arg_231_1.isInRecall_ then
							iter_234_4.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10062 = nil
			end

			local var_234_15 = 0
			local var_234_16 = 0.7

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[592].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(410012057)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 28
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012057", "story_v_out_410012.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012057", "story_v_out_410012.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_410012", "410012057", "story_v_out_410012.awb")

						arg_231_1:RecordAudio("410012057", var_234_24)
						arg_231_1:RecordAudio("410012057", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_410012", "410012057", "story_v_out_410012.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_410012", "410012057", "story_v_out_410012.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play410012058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410012058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play410012059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10062"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10062 = var_238_0.localPosition
				var_238_0.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10062", 3)

				local var_238_2 = var_238_0.childCount

				for iter_238_0 = 0, var_238_2 - 1 do
					local var_238_3 = var_238_0:GetChild(iter_238_0)

					if var_238_3.name == "" or not string.find(var_238_3.name, "split") then
						var_238_3.gameObject:SetActive(true)
					else
						var_238_3.gameObject:SetActive(false)
					end
				end
			end

			local var_238_4 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_4 then
				local var_238_5 = (arg_235_1.time_ - var_238_1) / var_238_4
				local var_238_6 = Vector3.New(0, -390, -290)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10062, var_238_6, var_238_5)
			end

			if arg_235_1.time_ >= var_238_1 + var_238_4 and arg_235_1.time_ < var_238_1 + var_238_4 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_238_7 = arg_235_1.actors_["10062"]
			local var_238_8 = 0

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps10062 == nil then
				arg_235_1.var_.actorSpriteComps10062 = var_238_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_9 = 0.034

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_9 and not isNil(var_238_7) then
				local var_238_10 = (arg_235_1.time_ - var_238_8) / var_238_9

				if arg_235_1.var_.actorSpriteComps10062 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								local var_238_11 = Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor2.r, var_238_10)
								local var_238_12 = Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor2.g, var_238_10)
								local var_238_13 = Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor2.b, var_238_10)

								iter_238_2.color = Color.New(var_238_11, var_238_12, var_238_13)
							else
								local var_238_14 = Mathf.Lerp(iter_238_2.color.r, 0.5, var_238_10)

								iter_238_2.color = Color.New(var_238_14, var_238_14, var_238_14)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_8 + var_238_9 and arg_235_1.time_ < var_238_8 + var_238_9 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps10062 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_238_4 then
						if arg_235_1.isInRecall_ then
							iter_238_4.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10062 = nil
			end

			local var_238_15 = arg_235_1.actors_["1060"].transform
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.var_.moveOldPos1060 = var_238_15.localPosition
				var_238_15.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1060", 7)

				local var_238_17 = var_238_15.childCount

				for iter_238_5 = 0, var_238_17 - 1 do
					local var_238_18 = var_238_15:GetChild(iter_238_5)

					if var_238_18.name == "" or not string.find(var_238_18.name, "split") then
						var_238_18.gameObject:SetActive(true)
					else
						var_238_18.gameObject:SetActive(false)
					end
				end
			end

			local var_238_19 = 0.001

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_19 then
				local var_238_20 = (arg_235_1.time_ - var_238_16) / var_238_19
				local var_238_21 = Vector3.New(0, -2000, -40)

				var_238_15.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1060, var_238_21, var_238_20)
			end

			if arg_235_1.time_ >= var_238_16 + var_238_19 and arg_235_1.time_ < var_238_16 + var_238_19 + arg_238_0 then
				var_238_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_238_22 = 0
			local var_238_23 = 1.4

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(410012058)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 56
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_23 or var_238_23 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_23 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_22 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_22
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_29 = math.max(var_238_23, arg_235_1.talkMaxDuration)

			if var_238_22 <= arg_235_1.time_ and arg_235_1.time_ < var_238_22 + var_238_29 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_22) / var_238_29

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_22 + var_238_29 and arg_235_1.time_ < var_238_22 + var_238_29 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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

		arg_235_1:InitPlayNodeList()
	end,
	Play410012059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410012059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play410012060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10062"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos10062 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10062", 7)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(0, -2000, -290)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10062, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_242_7 = arg_239_1.actors_["10062"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10062 == nil then
				arg_239_1.var_.actorSpriteComps10062 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 0.034

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps10062 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								local var_242_11 = Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor2.r, var_242_10)
								local var_242_12 = Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor2.g, var_242_10)
								local var_242_13 = Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor2.b, var_242_10)

								iter_242_2.color = Color.New(var_242_11, var_242_12, var_242_13)
							else
								local var_242_14 = Mathf.Lerp(iter_242_2.color.r, 0.5, var_242_10)

								iter_242_2.color = Color.New(var_242_14, var_242_14, var_242_14)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10062 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10062 = nil
			end

			local var_242_15 = 0
			local var_242_16 = 1.475

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_17 = arg_239_1:GetWordFromCfg(410012059)
				local var_242_18 = arg_239_1:FormatText(var_242_17.content)

				arg_239_1.text_.text = var_242_18

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_19 = 59
				local var_242_20 = utf8.len(var_242_18)
				local var_242_21 = var_242_19 <= 0 and var_242_16 or var_242_16 * (var_242_20 / var_242_19)

				if var_242_21 > 0 and var_242_16 < var_242_21 then
					arg_239_1.talkMaxDuration = var_242_21

					if var_242_21 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_21 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_18
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_22 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_22 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_22

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_22 and arg_239_1.time_ < var_242_15 + var_242_22 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play410012060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410012060
		arg_243_1.duration_ = 9.6

		local var_243_0 = {
			zh = 9.6,
			ja = 8.566
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
				arg_243_0:Play410012061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1060"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1060 = var_246_0.localPosition
				var_246_0.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1060", 2)

				local var_246_2 = var_246_0.childCount

				for iter_246_0 = 0, var_246_2 - 1 do
					local var_246_3 = var_246_0:GetChild(iter_246_0)

					if var_246_3.name == "" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_4 then
				local var_246_5 = (arg_243_1.time_ - var_246_1) / var_246_4
				local var_246_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1060, var_246_6, var_246_5)
			end

			if arg_243_1.time_ >= var_246_1 + var_246_4 and arg_243_1.time_ < var_246_1 + var_246_4 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_246_7 = arg_243_1.actors_["10061"].transform
			local var_246_8 = 0

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.var_.moveOldPos10061 = var_246_7.localPosition
				var_246_7.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10061", 4)

				local var_246_9 = var_246_7.childCount

				for iter_246_1 = 0, var_246_9 - 1 do
					local var_246_10 = var_246_7:GetChild(iter_246_1)

					if var_246_10.name == "" or not string.find(var_246_10.name, "split") then
						var_246_10.gameObject:SetActive(true)
					else
						var_246_10.gameObject:SetActive(false)
					end
				end
			end

			local var_246_11 = 0.001

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_11 then
				local var_246_12 = (arg_243_1.time_ - var_246_8) / var_246_11
				local var_246_13 = Vector3.New(390, -517.5, -100)

				var_246_7.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10061, var_246_13, var_246_12)
			end

			if arg_243_1.time_ >= var_246_8 + var_246_11 and arg_243_1.time_ < var_246_8 + var_246_11 + arg_246_0 then
				var_246_7.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_246_14 = arg_243_1.actors_["1060"]
			local var_246_15 = 0

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 and not isNil(var_246_14) and arg_243_1.var_.actorSpriteComps1060 == nil then
				arg_243_1.var_.actorSpriteComps1060 = var_246_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_16 = 0.034

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_16 and not isNil(var_246_14) then
				local var_246_17 = (arg_243_1.time_ - var_246_15) / var_246_16

				if arg_243_1.var_.actorSpriteComps1060 then
					for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_246_3 then
							if arg_243_1.isInRecall_ then
								local var_246_18 = Mathf.Lerp(iter_246_3.color.r, arg_243_1.hightColor1.r, var_246_17)
								local var_246_19 = Mathf.Lerp(iter_246_3.color.g, arg_243_1.hightColor1.g, var_246_17)
								local var_246_20 = Mathf.Lerp(iter_246_3.color.b, arg_243_1.hightColor1.b, var_246_17)

								iter_246_3.color = Color.New(var_246_18, var_246_19, var_246_20)
							else
								local var_246_21 = Mathf.Lerp(iter_246_3.color.r, 1, var_246_17)

								iter_246_3.color = Color.New(var_246_21, var_246_21, var_246_21)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_15 + var_246_16 and arg_243_1.time_ < var_246_15 + var_246_16 + arg_246_0 and not isNil(var_246_14) and arg_243_1.var_.actorSpriteComps1060 then
				for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_246_5 then
						if arg_243_1.isInRecall_ then
							iter_246_5.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1060 = nil
			end

			local var_246_22 = arg_243_1.actors_["10061"]
			local var_246_23 = 0

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.actorSpriteComps10061 == nil then
				arg_243_1.var_.actorSpriteComps10061 = var_246_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_24 = 0.034

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 and not isNil(var_246_22) then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24

				if arg_243_1.var_.actorSpriteComps10061 then
					for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_246_7 then
							if arg_243_1.isInRecall_ then
								local var_246_26 = Mathf.Lerp(iter_246_7.color.r, arg_243_1.hightColor2.r, var_246_25)
								local var_246_27 = Mathf.Lerp(iter_246_7.color.g, arg_243_1.hightColor2.g, var_246_25)
								local var_246_28 = Mathf.Lerp(iter_246_7.color.b, arg_243_1.hightColor2.b, var_246_25)

								iter_246_7.color = Color.New(var_246_26, var_246_27, var_246_28)
							else
								local var_246_29 = Mathf.Lerp(iter_246_7.color.r, 0.5, var_246_25)

								iter_246_7.color = Color.New(var_246_29, var_246_29, var_246_29)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.actorSpriteComps10061 then
				for iter_246_8, iter_246_9 in pairs(arg_243_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_246_9 then
						if arg_243_1.isInRecall_ then
							iter_246_9.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10061 = nil
			end

			local var_246_30 = arg_243_1.actors_["10062"].transform
			local var_246_31 = 0

			if var_246_31 < arg_243_1.time_ and arg_243_1.time_ <= var_246_31 + arg_246_0 then
				arg_243_1.var_.moveOldPos10062 = var_246_30.localPosition
				var_246_30.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10062", 7)

				local var_246_32 = var_246_30.childCount

				for iter_246_10 = 0, var_246_32 - 1 do
					local var_246_33 = var_246_30:GetChild(iter_246_10)

					if var_246_33.name == "" or not string.find(var_246_33.name, "split") then
						var_246_33.gameObject:SetActive(true)
					else
						var_246_33.gameObject:SetActive(false)
					end
				end
			end

			local var_246_34 = 0.001

			if var_246_31 <= arg_243_1.time_ and arg_243_1.time_ < var_246_31 + var_246_34 then
				local var_246_35 = (arg_243_1.time_ - var_246_31) / var_246_34
				local var_246_36 = Vector3.New(0, -2000, -290)

				var_246_30.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10062, var_246_36, var_246_35)
			end

			if arg_243_1.time_ >= var_246_31 + var_246_34 and arg_243_1.time_ < var_246_31 + var_246_34 + arg_246_0 then
				var_246_30.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_246_37 = 0
			local var_246_38 = 1.025

			if var_246_37 < arg_243_1.time_ and arg_243_1.time_ <= var_246_37 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_39 = arg_243_1:FormatText(StoryNameCfg[584].name)

				arg_243_1.leftNameTxt_.text = var_246_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_40 = arg_243_1:GetWordFromCfg(410012060)
				local var_246_41 = arg_243_1:FormatText(var_246_40.content)

				arg_243_1.text_.text = var_246_41

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_42 = 41
				local var_246_43 = utf8.len(var_246_41)
				local var_246_44 = var_246_42 <= 0 and var_246_38 or var_246_38 * (var_246_43 / var_246_42)

				if var_246_44 > 0 and var_246_38 < var_246_44 then
					arg_243_1.talkMaxDuration = var_246_44

					if var_246_44 + var_246_37 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_44 + var_246_37
					end
				end

				arg_243_1.text_.text = var_246_41
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012060", "story_v_out_410012.awb") ~= 0 then
					local var_246_45 = manager.audio:GetVoiceLength("story_v_out_410012", "410012060", "story_v_out_410012.awb") / 1000

					if var_246_45 + var_246_37 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_45 + var_246_37
					end

					if var_246_40.prefab_name ~= "" and arg_243_1.actors_[var_246_40.prefab_name] ~= nil then
						local var_246_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_40.prefab_name].transform, "story_v_out_410012", "410012060", "story_v_out_410012.awb")

						arg_243_1:RecordAudio("410012060", var_246_46)
						arg_243_1:RecordAudio("410012060", var_246_46)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410012", "410012060", "story_v_out_410012.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410012", "410012060", "story_v_out_410012.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_47 = math.max(var_246_38, arg_243_1.talkMaxDuration)

			if var_246_37 <= arg_243_1.time_ and arg_243_1.time_ < var_246_37 + var_246_47 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_37) / var_246_47

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_37 + var_246_47 and arg_243_1.time_ < var_246_37 + var_246_47 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410012061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410012061
		arg_247_1.duration_ = 2.13

		local var_247_0 = {
			zh = 1.233,
			ja = 2.133
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play410012062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10061"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10061 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10061", 4)

				local var_250_2 = var_250_0.childCount

				for iter_250_0 = 0, var_250_2 - 1 do
					local var_250_3 = var_250_0:GetChild(iter_250_0)

					if var_250_3.name == "split_5" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_4 then
				local var_250_5 = (arg_247_1.time_ - var_250_1) / var_250_4
				local var_250_6 = Vector3.New(390, -517.5, -100)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10061, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_250_7 = arg_247_1.actors_["10061"]
			local var_250_8 = 0

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 and not isNil(var_250_7) and arg_247_1.var_.actorSpriteComps10061 == nil then
				arg_247_1.var_.actorSpriteComps10061 = var_250_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_9 = 0.034

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_9 and not isNil(var_250_7) then
				local var_250_10 = (arg_247_1.time_ - var_250_8) / var_250_9

				if arg_247_1.var_.actorSpriteComps10061 then
					for iter_250_1, iter_250_2 in pairs(arg_247_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_250_2 then
							if arg_247_1.isInRecall_ then
								local var_250_11 = Mathf.Lerp(iter_250_2.color.r, arg_247_1.hightColor1.r, var_250_10)
								local var_250_12 = Mathf.Lerp(iter_250_2.color.g, arg_247_1.hightColor1.g, var_250_10)
								local var_250_13 = Mathf.Lerp(iter_250_2.color.b, arg_247_1.hightColor1.b, var_250_10)

								iter_250_2.color = Color.New(var_250_11, var_250_12, var_250_13)
							else
								local var_250_14 = Mathf.Lerp(iter_250_2.color.r, 1, var_250_10)

								iter_250_2.color = Color.New(var_250_14, var_250_14, var_250_14)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_8 + var_250_9 and arg_247_1.time_ < var_250_8 + var_250_9 + arg_250_0 and not isNil(var_250_7) and arg_247_1.var_.actorSpriteComps10061 then
				for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_250_4 then
						if arg_247_1.isInRecall_ then
							iter_250_4.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10061 = nil
			end

			local var_250_15 = arg_247_1.actors_["1060"]
			local var_250_16 = 0

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.actorSpriteComps1060 == nil then
				arg_247_1.var_.actorSpriteComps1060 = var_250_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_17 = 0.034

			if var_250_16 <= arg_247_1.time_ and arg_247_1.time_ < var_250_16 + var_250_17 and not isNil(var_250_15) then
				local var_250_18 = (arg_247_1.time_ - var_250_16) / var_250_17

				if arg_247_1.var_.actorSpriteComps1060 then
					for iter_250_5, iter_250_6 in pairs(arg_247_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_250_6 then
							if arg_247_1.isInRecall_ then
								local var_250_19 = Mathf.Lerp(iter_250_6.color.r, arg_247_1.hightColor2.r, var_250_18)
								local var_250_20 = Mathf.Lerp(iter_250_6.color.g, arg_247_1.hightColor2.g, var_250_18)
								local var_250_21 = Mathf.Lerp(iter_250_6.color.b, arg_247_1.hightColor2.b, var_250_18)

								iter_250_6.color = Color.New(var_250_19, var_250_20, var_250_21)
							else
								local var_250_22 = Mathf.Lerp(iter_250_6.color.r, 0.5, var_250_18)

								iter_250_6.color = Color.New(var_250_22, var_250_22, var_250_22)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_16 + var_250_17 and arg_247_1.time_ < var_250_16 + var_250_17 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.actorSpriteComps1060 then
				for iter_250_7, iter_250_8 in pairs(arg_247_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_250_8 then
						if arg_247_1.isInRecall_ then
							iter_250_8.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1060 = nil
			end

			local var_250_23 = 0
			local var_250_24 = 0.05

			if var_250_23 < arg_247_1.time_ and arg_247_1.time_ <= var_250_23 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_25 = arg_247_1:FormatText(StoryNameCfg[591].name)

				arg_247_1.leftNameTxt_.text = var_250_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_26 = arg_247_1:GetWordFromCfg(410012061)
				local var_250_27 = arg_247_1:FormatText(var_250_26.content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_28 = 2
				local var_250_29 = utf8.len(var_250_27)
				local var_250_30 = var_250_28 <= 0 and var_250_24 or var_250_24 * (var_250_29 / var_250_28)

				if var_250_30 > 0 and var_250_24 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30

					if var_250_30 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_23
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012061", "story_v_out_410012.awb") ~= 0 then
					local var_250_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012061", "story_v_out_410012.awb") / 1000

					if var_250_31 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_31 + var_250_23
					end

					if var_250_26.prefab_name ~= "" and arg_247_1.actors_[var_250_26.prefab_name] ~= nil then
						local var_250_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_26.prefab_name].transform, "story_v_out_410012", "410012061", "story_v_out_410012.awb")

						arg_247_1:RecordAudio("410012061", var_250_32)
						arg_247_1:RecordAudio("410012061", var_250_32)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_410012", "410012061", "story_v_out_410012.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_410012", "410012061", "story_v_out_410012.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_33 = math.max(var_250_24, arg_247_1.talkMaxDuration)

			if var_250_23 <= arg_247_1.time_ and arg_247_1.time_ < var_250_23 + var_250_33 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_23) / var_250_33

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_23 + var_250_33 and arg_247_1.time_ < var_250_23 + var_250_33 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 410012062
		arg_251_1.duration_ = 5.5

		local var_251_0 = {
			zh = 2.1,
			ja = 5.5
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play410012063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1060"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1060 = var_254_0.localPosition
				var_254_0.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1060", 2)

				local var_254_2 = var_254_0.childCount

				for iter_254_0 = 0, var_254_2 - 1 do
					local var_254_3 = var_254_0:GetChild(iter_254_0)

					if var_254_3.name == "" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_4 then
				local var_254_5 = (arg_251_1.time_ - var_254_1) / var_254_4
				local var_254_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1060, var_254_6, var_254_5)
			end

			if arg_251_1.time_ >= var_254_1 + var_254_4 and arg_251_1.time_ < var_254_1 + var_254_4 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_254_7 = arg_251_1.actors_["1060"]
			local var_254_8 = 0

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1060 == nil then
				arg_251_1.var_.actorSpriteComps1060 = var_254_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_9 = 0.034

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 and not isNil(var_254_7) then
				local var_254_10 = (arg_251_1.time_ - var_254_8) / var_254_9

				if arg_251_1.var_.actorSpriteComps1060 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								local var_254_11 = Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, var_254_10)
								local var_254_12 = Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, var_254_10)
								local var_254_13 = Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, var_254_10)

								iter_254_2.color = Color.New(var_254_11, var_254_12, var_254_13)
							else
								local var_254_14 = Mathf.Lerp(iter_254_2.color.r, 1, var_254_10)

								iter_254_2.color = Color.New(var_254_14, var_254_14, var_254_14)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1060 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_254_4 then
						if arg_251_1.isInRecall_ then
							iter_254_4.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1060 = nil
			end

			local var_254_15 = arg_251_1.actors_["10061"]
			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.actorSpriteComps10061 == nil then
				arg_251_1.var_.actorSpriteComps10061 = var_254_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_17 = 0.034

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 and not isNil(var_254_15) then
				local var_254_18 = (arg_251_1.time_ - var_254_16) / var_254_17

				if arg_251_1.var_.actorSpriteComps10061 then
					for iter_254_5, iter_254_6 in pairs(arg_251_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_254_6 then
							if arg_251_1.isInRecall_ then
								local var_254_19 = Mathf.Lerp(iter_254_6.color.r, arg_251_1.hightColor2.r, var_254_18)
								local var_254_20 = Mathf.Lerp(iter_254_6.color.g, arg_251_1.hightColor2.g, var_254_18)
								local var_254_21 = Mathf.Lerp(iter_254_6.color.b, arg_251_1.hightColor2.b, var_254_18)

								iter_254_6.color = Color.New(var_254_19, var_254_20, var_254_21)
							else
								local var_254_22 = Mathf.Lerp(iter_254_6.color.r, 0.5, var_254_18)

								iter_254_6.color = Color.New(var_254_22, var_254_22, var_254_22)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.actorSpriteComps10061 then
				for iter_254_7, iter_254_8 in pairs(arg_251_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_254_8 then
						if arg_251_1.isInRecall_ then
							iter_254_8.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10061 = nil
			end

			local var_254_23 = 0
			local var_254_24 = 0.25

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[584].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_26 = arg_251_1:GetWordFromCfg(410012062)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 10
				local var_254_29 = utf8.len(var_254_27)
				local var_254_30 = var_254_28 <= 0 and var_254_24 or var_254_24 * (var_254_29 / var_254_28)

				if var_254_30 > 0 and var_254_24 < var_254_30 then
					arg_251_1.talkMaxDuration = var_254_30

					if var_254_30 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_23
					end
				end

				arg_251_1.text_.text = var_254_27
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012062", "story_v_out_410012.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012062", "story_v_out_410012.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_410012", "410012062", "story_v_out_410012.awb")

						arg_251_1:RecordAudio("410012062", var_254_32)
						arg_251_1:RecordAudio("410012062", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_410012", "410012062", "story_v_out_410012.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_410012", "410012062", "story_v_out_410012.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_33 = math.max(var_254_24, arg_251_1.talkMaxDuration)

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_33 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_23) / var_254_33

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_23 + var_254_33 and arg_251_1.time_ < var_254_23 + var_254_33 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play410012063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 410012063
		arg_255_1.duration_ = 9.63

		local var_255_0 = {
			zh = 9.633,
			ja = 6.3
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
				arg_255_0:Play410012064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 2

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				local var_258_1 = manager.ui.mainCamera.transform.localPosition
				local var_258_2 = Vector3.New(0, 0, 10) + Vector3.New(var_258_1.x, var_258_1.y, 0)
				local var_258_3 = arg_255_1.bgs_.L02f

				var_258_3.transform.localPosition = var_258_2
				var_258_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_4 = var_258_3:GetComponent("SpriteRenderer")

				if var_258_4 and var_258_4.sprite then
					local var_258_5 = (var_258_3.transform.localPosition - var_258_1).z
					local var_258_6 = manager.ui.mainCameraCom_
					local var_258_7 = 2 * var_258_5 * Mathf.Tan(var_258_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_258_8 = var_258_7 * var_258_6.aspect
					local var_258_9 = var_258_4.sprite.bounds.size.x
					local var_258_10 = var_258_4.sprite.bounds.size.y
					local var_258_11 = var_258_8 / var_258_9
					local var_258_12 = var_258_7 / var_258_10
					local var_258_13 = var_258_12 < var_258_11 and var_258_11 or var_258_12

					var_258_3.transform.localScale = Vector3.New(var_258_13, var_258_13, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "L02f" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_15 = 2

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 then
				local var_258_16 = (arg_255_1.time_ - var_258_14) / var_258_15
				local var_258_17 = Color.New(0, 0, 0)

				var_258_17.a = Mathf.Lerp(0, 1, var_258_16)
				arg_255_1.mask_.color = var_258_17
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 then
				local var_258_18 = Color.New(0, 0, 0)

				var_258_18.a = 1
				arg_255_1.mask_.color = var_258_18
			end

			local var_258_19 = 2

			if var_258_19 < arg_255_1.time_ and arg_255_1.time_ <= var_258_19 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_20 = 2

			if var_258_19 <= arg_255_1.time_ and arg_255_1.time_ < var_258_19 + var_258_20 then
				local var_258_21 = (arg_255_1.time_ - var_258_19) / var_258_20
				local var_258_22 = Color.New(0, 0, 0)

				var_258_22.a = Mathf.Lerp(1, 0, var_258_21)
				arg_255_1.mask_.color = var_258_22
			end

			if arg_255_1.time_ >= var_258_19 + var_258_20 and arg_255_1.time_ < var_258_19 + var_258_20 + arg_258_0 then
				local var_258_23 = Color.New(0, 0, 0)
				local var_258_24 = 0

				arg_255_1.mask_.enabled = false
				var_258_23.a = var_258_24
				arg_255_1.mask_.color = var_258_23
			end

			local var_258_25 = arg_255_1.actors_["10061"].transform
			local var_258_26 = 2

			if var_258_26 < arg_255_1.time_ and arg_255_1.time_ <= var_258_26 + arg_258_0 then
				arg_255_1.var_.moveOldPos10061 = var_258_25.localPosition
				var_258_25.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10061", 7)

				local var_258_27 = var_258_25.childCount

				for iter_258_2 = 0, var_258_27 - 1 do
					local var_258_28 = var_258_25:GetChild(iter_258_2)

					if var_258_28.name == "split_3" or not string.find(var_258_28.name, "split") then
						var_258_28.gameObject:SetActive(true)
					else
						var_258_28.gameObject:SetActive(false)
					end
				end
			end

			local var_258_29 = 0.001

			if var_258_26 <= arg_255_1.time_ and arg_255_1.time_ < var_258_26 + var_258_29 then
				local var_258_30 = (arg_255_1.time_ - var_258_26) / var_258_29
				local var_258_31 = Vector3.New(0, -2000, -100)

				var_258_25.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10061, var_258_31, var_258_30)
			end

			if arg_255_1.time_ >= var_258_26 + var_258_29 and arg_255_1.time_ < var_258_26 + var_258_29 + arg_258_0 then
				var_258_25.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_258_32 = arg_255_1.actors_["1060"].transform
			local var_258_33 = 2

			if var_258_33 < arg_255_1.time_ and arg_255_1.time_ <= var_258_33 + arg_258_0 then
				arg_255_1.var_.moveOldPos1060 = var_258_32.localPosition
				var_258_32.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1060", 7)

				local var_258_34 = var_258_32.childCount

				for iter_258_3 = 0, var_258_34 - 1 do
					local var_258_35 = var_258_32:GetChild(iter_258_3)

					if var_258_35.name == "" or not string.find(var_258_35.name, "split") then
						var_258_35.gameObject:SetActive(true)
					else
						var_258_35.gameObject:SetActive(false)
					end
				end
			end

			local var_258_36 = 0.001

			if var_258_33 <= arg_255_1.time_ and arg_255_1.time_ < var_258_33 + var_258_36 then
				local var_258_37 = (arg_255_1.time_ - var_258_33) / var_258_36
				local var_258_38 = Vector3.New(0, -2000, -40)

				var_258_32.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1060, var_258_38, var_258_37)
			end

			if arg_255_1.time_ >= var_258_33 + var_258_36 and arg_255_1.time_ < var_258_33 + var_258_36 + arg_258_0 then
				var_258_32.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_258_39 = arg_255_1.actors_["10061"]
			local var_258_40 = 4

			if var_258_40 < arg_255_1.time_ and arg_255_1.time_ <= var_258_40 + arg_258_0 and not isNil(var_258_39) and arg_255_1.var_.actorSpriteComps10061 == nil then
				arg_255_1.var_.actorSpriteComps10061 = var_258_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_41 = 0.034

			if var_258_40 <= arg_255_1.time_ and arg_255_1.time_ < var_258_40 + var_258_41 and not isNil(var_258_39) then
				local var_258_42 = (arg_255_1.time_ - var_258_40) / var_258_41

				if arg_255_1.var_.actorSpriteComps10061 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								local var_258_43 = Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor1.r, var_258_42)
								local var_258_44 = Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor1.g, var_258_42)
								local var_258_45 = Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor1.b, var_258_42)

								iter_258_5.color = Color.New(var_258_43, var_258_44, var_258_45)
							else
								local var_258_46 = Mathf.Lerp(iter_258_5.color.r, 1, var_258_42)

								iter_258_5.color = Color.New(var_258_46, var_258_46, var_258_46)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_40 + var_258_41 and arg_255_1.time_ < var_258_40 + var_258_41 + arg_258_0 and not isNil(var_258_39) and arg_255_1.var_.actorSpriteComps10061 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10061 = nil
			end

			local var_258_47 = arg_255_1.actors_["1060"]
			local var_258_48 = 2

			if var_258_48 < arg_255_1.time_ and arg_255_1.time_ <= var_258_48 + arg_258_0 and not isNil(var_258_47) and arg_255_1.var_.actorSpriteComps1060 == nil then
				arg_255_1.var_.actorSpriteComps1060 = var_258_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_49 = 0.034

			if var_258_48 <= arg_255_1.time_ and arg_255_1.time_ < var_258_48 + var_258_49 and not isNil(var_258_47) then
				local var_258_50 = (arg_255_1.time_ - var_258_48) / var_258_49

				if arg_255_1.var_.actorSpriteComps1060 then
					for iter_258_8, iter_258_9 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_258_9 then
							if arg_255_1.isInRecall_ then
								local var_258_51 = Mathf.Lerp(iter_258_9.color.r, arg_255_1.hightColor2.r, var_258_50)
								local var_258_52 = Mathf.Lerp(iter_258_9.color.g, arg_255_1.hightColor2.g, var_258_50)
								local var_258_53 = Mathf.Lerp(iter_258_9.color.b, arg_255_1.hightColor2.b, var_258_50)

								iter_258_9.color = Color.New(var_258_51, var_258_52, var_258_53)
							else
								local var_258_54 = Mathf.Lerp(iter_258_9.color.r, 0.5, var_258_50)

								iter_258_9.color = Color.New(var_258_54, var_258_54, var_258_54)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_48 + var_258_49 and arg_255_1.time_ < var_258_48 + var_258_49 + arg_258_0 and not isNil(var_258_47) and arg_255_1.var_.actorSpriteComps1060 then
				for iter_258_10, iter_258_11 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_258_11 then
						if arg_255_1.isInRecall_ then
							iter_258_11.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1060 = nil
			end

			local var_258_55 = arg_255_1.actors_["10061"].transform
			local var_258_56 = 4

			if var_258_56 < arg_255_1.time_ and arg_255_1.time_ <= var_258_56 + arg_258_0 then
				arg_255_1.var_.moveOldPos10061 = var_258_55.localPosition
				var_258_55.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10061", 3)

				local var_258_57 = var_258_55.childCount

				for iter_258_12 = 0, var_258_57 - 1 do
					local var_258_58 = var_258_55:GetChild(iter_258_12)

					if var_258_58.name == "split_3" or not string.find(var_258_58.name, "split") then
						var_258_58.gameObject:SetActive(true)
					else
						var_258_58.gameObject:SetActive(false)
					end
				end
			end

			local var_258_59 = 0.001

			if var_258_56 <= arg_255_1.time_ and arg_255_1.time_ < var_258_56 + var_258_59 then
				local var_258_60 = (arg_255_1.time_ - var_258_56) / var_258_59
				local var_258_61 = Vector3.New(0, -517.5, -100)

				var_258_55.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10061, var_258_61, var_258_60)
			end

			if arg_255_1.time_ >= var_258_56 + var_258_59 and arg_255_1.time_ < var_258_56 + var_258_59 + arg_258_0 then
				var_258_55.localPosition = Vector3.New(0, -517.5, -100)
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_62 = 4
			local var_258_63 = 0.7

			if var_258_62 < arg_255_1.time_ and arg_255_1.time_ <= var_258_62 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_64 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_64:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_65 = arg_255_1:FormatText(StoryNameCfg[591].name)

				arg_255_1.leftNameTxt_.text = var_258_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_66 = arg_255_1:GetWordFromCfg(410012063)
				local var_258_67 = arg_255_1:FormatText(var_258_66.content)

				arg_255_1.text_.text = var_258_67

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_68 = 28
				local var_258_69 = utf8.len(var_258_67)
				local var_258_70 = var_258_68 <= 0 and var_258_63 or var_258_63 * (var_258_69 / var_258_68)

				if var_258_70 > 0 and var_258_63 < var_258_70 then
					arg_255_1.talkMaxDuration = var_258_70
					var_258_62 = var_258_62 + 0.3

					if var_258_70 + var_258_62 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_70 + var_258_62
					end
				end

				arg_255_1.text_.text = var_258_67
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012063", "story_v_out_410012.awb") ~= 0 then
					local var_258_71 = manager.audio:GetVoiceLength("story_v_out_410012", "410012063", "story_v_out_410012.awb") / 1000

					if var_258_71 + var_258_62 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_71 + var_258_62
					end

					if var_258_66.prefab_name ~= "" and arg_255_1.actors_[var_258_66.prefab_name] ~= nil then
						local var_258_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_66.prefab_name].transform, "story_v_out_410012", "410012063", "story_v_out_410012.awb")

						arg_255_1:RecordAudio("410012063", var_258_72)
						arg_255_1:RecordAudio("410012063", var_258_72)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_410012", "410012063", "story_v_out_410012.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_410012", "410012063", "story_v_out_410012.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_73 = var_258_62 + 0.3
			local var_258_74 = math.max(var_258_63, arg_255_1.talkMaxDuration)

			if var_258_73 <= arg_255_1.time_ and arg_255_1.time_ < var_258_73 + var_258_74 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_73) / var_258_74

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_73 + var_258_74 and arg_255_1.time_ < var_258_73 + var_258_74 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play410012064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410012064
		arg_261_1.duration_ = 5.5

		local var_261_0 = {
			zh = 1.233,
			ja = 5.5
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
				arg_261_0:Play410012065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1060"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1060 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1060", 2)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1060, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_264_7 = arg_261_1.actors_["10061"].transform
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.var_.moveOldPos10061 = var_264_7.localPosition
				var_264_7.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10061", 4)

				local var_264_9 = var_264_7.childCount

				for iter_264_1 = 0, var_264_9 - 1 do
					local var_264_10 = var_264_7:GetChild(iter_264_1)

					if var_264_10.name == "" or not string.find(var_264_10.name, "split") then
						var_264_10.gameObject:SetActive(true)
					else
						var_264_10.gameObject:SetActive(false)
					end
				end
			end

			local var_264_11 = 0.001

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_11 then
				local var_264_12 = (arg_261_1.time_ - var_264_8) / var_264_11
				local var_264_13 = Vector3.New(390, -517.5, -100)

				var_264_7.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10061, var_264_13, var_264_12)
			end

			if arg_261_1.time_ >= var_264_8 + var_264_11 and arg_261_1.time_ < var_264_8 + var_264_11 + arg_264_0 then
				var_264_7.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_264_14 = arg_261_1.actors_["1060"]
			local var_264_15 = 0

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.actorSpriteComps1060 == nil then
				arg_261_1.var_.actorSpriteComps1060 = var_264_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_16 = 0.034

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_16 and not isNil(var_264_14) then
				local var_264_17 = (arg_261_1.time_ - var_264_15) / var_264_16

				if arg_261_1.var_.actorSpriteComps1060 then
					for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_264_3 then
							if arg_261_1.isInRecall_ then
								local var_264_18 = Mathf.Lerp(iter_264_3.color.r, arg_261_1.hightColor1.r, var_264_17)
								local var_264_19 = Mathf.Lerp(iter_264_3.color.g, arg_261_1.hightColor1.g, var_264_17)
								local var_264_20 = Mathf.Lerp(iter_264_3.color.b, arg_261_1.hightColor1.b, var_264_17)

								iter_264_3.color = Color.New(var_264_18, var_264_19, var_264_20)
							else
								local var_264_21 = Mathf.Lerp(iter_264_3.color.r, 1, var_264_17)

								iter_264_3.color = Color.New(var_264_21, var_264_21, var_264_21)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_15 + var_264_16 and arg_261_1.time_ < var_264_15 + var_264_16 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.actorSpriteComps1060 then
				for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_264_5 then
						if arg_261_1.isInRecall_ then
							iter_264_5.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1060 = nil
			end

			local var_264_22 = arg_261_1.actors_["10061"]
			local var_264_23 = 0

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 and not isNil(var_264_22) and arg_261_1.var_.actorSpriteComps10061 == nil then
				arg_261_1.var_.actorSpriteComps10061 = var_264_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_24 = 0.034

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_24 and not isNil(var_264_22) then
				local var_264_25 = (arg_261_1.time_ - var_264_23) / var_264_24

				if arg_261_1.var_.actorSpriteComps10061 then
					for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_264_7 then
							if arg_261_1.isInRecall_ then
								local var_264_26 = Mathf.Lerp(iter_264_7.color.r, arg_261_1.hightColor2.r, var_264_25)
								local var_264_27 = Mathf.Lerp(iter_264_7.color.g, arg_261_1.hightColor2.g, var_264_25)
								local var_264_28 = Mathf.Lerp(iter_264_7.color.b, arg_261_1.hightColor2.b, var_264_25)

								iter_264_7.color = Color.New(var_264_26, var_264_27, var_264_28)
							else
								local var_264_29 = Mathf.Lerp(iter_264_7.color.r, 0.5, var_264_25)

								iter_264_7.color = Color.New(var_264_29, var_264_29, var_264_29)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_23 + var_264_24 and arg_261_1.time_ < var_264_23 + var_264_24 + arg_264_0 and not isNil(var_264_22) and arg_261_1.var_.actorSpriteComps10061 then
				for iter_264_8, iter_264_9 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_264_9 then
						if arg_261_1.isInRecall_ then
							iter_264_9.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10061 = nil
			end

			local var_264_30 = 0
			local var_264_31 = 0.15

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_32 = arg_261_1:FormatText(StoryNameCfg[584].name)

				arg_261_1.leftNameTxt_.text = var_264_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_33 = arg_261_1:GetWordFromCfg(410012064)
				local var_264_34 = arg_261_1:FormatText(var_264_33.content)

				arg_261_1.text_.text = var_264_34

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_35 = 6
				local var_264_36 = utf8.len(var_264_34)
				local var_264_37 = var_264_35 <= 0 and var_264_31 or var_264_31 * (var_264_36 / var_264_35)

				if var_264_37 > 0 and var_264_31 < var_264_37 then
					arg_261_1.talkMaxDuration = var_264_37

					if var_264_37 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_37 + var_264_30
					end
				end

				arg_261_1.text_.text = var_264_34
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012064", "story_v_out_410012.awb") ~= 0 then
					local var_264_38 = manager.audio:GetVoiceLength("story_v_out_410012", "410012064", "story_v_out_410012.awb") / 1000

					if var_264_38 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_38 + var_264_30
					end

					if var_264_33.prefab_name ~= "" and arg_261_1.actors_[var_264_33.prefab_name] ~= nil then
						local var_264_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_33.prefab_name].transform, "story_v_out_410012", "410012064", "story_v_out_410012.awb")

						arg_261_1:RecordAudio("410012064", var_264_39)
						arg_261_1:RecordAudio("410012064", var_264_39)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410012", "410012064", "story_v_out_410012.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410012", "410012064", "story_v_out_410012.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_40 = math.max(var_264_31, arg_261_1.talkMaxDuration)

			if var_264_30 <= arg_261_1.time_ and arg_261_1.time_ < var_264_30 + var_264_40 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_30) / var_264_40

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_30 + var_264_40 and arg_261_1.time_ < var_264_30 + var_264_40 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play410012065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410012065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play410012066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1060"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1060 == nil then
				arg_265_1.var_.actorSpriteComps1060 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.034

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps1060 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 0.5, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1060 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1060 = nil
			end

			local var_268_8 = 0
			local var_268_9 = 1.3

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(410012065)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_12 = 52
				local var_268_13 = utf8.len(var_268_11)
				local var_268_14 = var_268_12 <= 0 and var_268_9 or var_268_9 * (var_268_13 / var_268_12)

				if var_268_14 > 0 and var_268_9 < var_268_14 then
					arg_265_1.talkMaxDuration = var_268_14

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_15 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_15 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_15

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_15 and arg_265_1.time_ < var_268_8 + var_268_15 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410012066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410012066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play410012067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.9

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(410012066)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 36
				local var_272_5 = utf8.len(var_272_3)
				local var_272_6 = var_272_4 <= 0 and var_272_1 or var_272_1 * (var_272_5 / var_272_4)

				if var_272_6 > 0 and var_272_1 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_7 and arg_269_1.time_ < var_272_0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410012067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410012067
		arg_273_1.duration_ = 12.77

		local var_273_0 = {
			zh = 6.5,
			ja = 12.766
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
				arg_273_0:Play410012068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1060"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 2)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_1" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_276_7 = arg_273_1.actors_["1060"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 == nil then
				arg_273_1.var_.actorSpriteComps1060 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1060 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1060 = nil
			end

			local var_276_15 = 0
			local var_276_16 = 0.7

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[584].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(410012067)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 28
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012067", "story_v_out_410012.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012067", "story_v_out_410012.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_out_410012", "410012067", "story_v_out_410012.awb")

						arg_273_1:RecordAudio("410012067", var_276_24)
						arg_273_1:RecordAudio("410012067", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410012", "410012067", "story_v_out_410012.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410012", "410012067", "story_v_out_410012.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play410012068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410012068
		arg_277_1.duration_ = 10.67

		local var_277_0 = {
			zh = 9.066,
			ja = 10.666
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
				arg_277_0:Play410012069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1060"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1060 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1060", 2)

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
				local var_280_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1060, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_280_7 = arg_277_1.actors_["1060"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1060 == nil then
				arg_277_1.var_.actorSpriteComps1060 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps1060 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1060 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1060 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 1.175

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[584].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(410012068)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012068", "story_v_out_410012.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012068", "story_v_out_410012.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_410012", "410012068", "story_v_out_410012.awb")

						arg_277_1:RecordAudio("410012068", var_280_24)
						arg_277_1:RecordAudio("410012068", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410012", "410012068", "story_v_out_410012.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410012", "410012068", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410012069
		arg_281_1.duration_ = 6.3

		local var_281_0 = {
			zh = 2.166,
			ja = 6.3
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
				arg_281_0:Play410012070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10061"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10061 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10061", 4)

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
				local var_284_6 = Vector3.New(390, -517.5, -100)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10061, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_284_7 = arg_281_1.actors_["10061"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps10061 == nil then
				arg_281_1.var_.actorSpriteComps10061 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.034

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps10061 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps10061 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_284_4 then
						if arg_281_1.isInRecall_ then
							iter_284_4.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10061 = nil
			end

			local var_284_15 = arg_281_1.actors_["1060"]
			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.actorSpriteComps1060 == nil then
				arg_281_1.var_.actorSpriteComps1060 = var_284_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_17 = 0.034

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 and not isNil(var_284_15) then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17

				if arg_281_1.var_.actorSpriteComps1060 then
					for iter_284_5, iter_284_6 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_284_6 then
							if arg_281_1.isInRecall_ then
								local var_284_19 = Mathf.Lerp(iter_284_6.color.r, arg_281_1.hightColor2.r, var_284_18)
								local var_284_20 = Mathf.Lerp(iter_284_6.color.g, arg_281_1.hightColor2.g, var_284_18)
								local var_284_21 = Mathf.Lerp(iter_284_6.color.b, arg_281_1.hightColor2.b, var_284_18)

								iter_284_6.color = Color.New(var_284_19, var_284_20, var_284_21)
							else
								local var_284_22 = Mathf.Lerp(iter_284_6.color.r, 0.5, var_284_18)

								iter_284_6.color = Color.New(var_284_22, var_284_22, var_284_22)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.actorSpriteComps1060 then
				for iter_284_7, iter_284_8 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_284_8 then
						if arg_281_1.isInRecall_ then
							iter_284_8.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1060 = nil
			end

			local var_284_23 = 0
			local var_284_24 = 0.275

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_25 = arg_281_1:FormatText(StoryNameCfg[591].name)

				arg_281_1.leftNameTxt_.text = var_284_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_26 = arg_281_1:GetWordFromCfg(410012069)
				local var_284_27 = arg_281_1:FormatText(var_284_26.content)

				arg_281_1.text_.text = var_284_27

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_28 = 11
				local var_284_29 = utf8.len(var_284_27)
				local var_284_30 = var_284_28 <= 0 and var_284_24 or var_284_24 * (var_284_29 / var_284_28)

				if var_284_30 > 0 and var_284_24 < var_284_30 then
					arg_281_1.talkMaxDuration = var_284_30

					if var_284_30 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_30 + var_284_23
					end
				end

				arg_281_1.text_.text = var_284_27
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012069", "story_v_out_410012.awb") ~= 0 then
					local var_284_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012069", "story_v_out_410012.awb") / 1000

					if var_284_31 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_31 + var_284_23
					end

					if var_284_26.prefab_name ~= "" and arg_281_1.actors_[var_284_26.prefab_name] ~= nil then
						local var_284_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_26.prefab_name].transform, "story_v_out_410012", "410012069", "story_v_out_410012.awb")

						arg_281_1:RecordAudio("410012069", var_284_32)
						arg_281_1:RecordAudio("410012069", var_284_32)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410012", "410012069", "story_v_out_410012.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410012", "410012069", "story_v_out_410012.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_33 = math.max(var_284_24, arg_281_1.talkMaxDuration)

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_33 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_23) / var_284_33

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_23 + var_284_33 and arg_281_1.time_ < var_284_23 + var_284_33 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410012070
		arg_285_1.duration_ = 7.2

		local var_285_0 = {
			zh = 2.9,
			ja = 7.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410012071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1060"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 2)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_288_7 = arg_285_1.actors_["1060"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_15 = arg_285_1.actors_["10061"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10061 == nil then
				arg_285_1.var_.actorSpriteComps10061 = var_288_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_17 = 0.034

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.actorSpriteComps10061 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								local var_288_19 = Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, var_288_18)
								local var_288_20 = Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, var_288_18)
								local var_288_21 = Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, var_288_18)

								iter_288_6.color = Color.New(var_288_19, var_288_20, var_288_21)
							else
								local var_288_22 = Mathf.Lerp(iter_288_6.color.r, 0.5, var_288_18)

								iter_288_6.color = Color.New(var_288_22, var_288_22, var_288_22)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10061 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_288_8 then
						if arg_285_1.isInRecall_ then
							iter_288_8.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10061 = nil
			end

			local var_288_23 = 0
			local var_288_24 = 0.325

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_25 = arg_285_1:FormatText(StoryNameCfg[584].name)

				arg_285_1.leftNameTxt_.text = var_288_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(410012070)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 13
				local var_288_29 = utf8.len(var_288_27)
				local var_288_30 = var_288_28 <= 0 and var_288_24 or var_288_24 * (var_288_29 / var_288_28)

				if var_288_30 > 0 and var_288_24 < var_288_30 then
					arg_285_1.talkMaxDuration = var_288_30

					if var_288_30 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_30 + var_288_23
					end
				end

				arg_285_1.text_.text = var_288_27
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012070", "story_v_out_410012.awb") ~= 0 then
					local var_288_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012070", "story_v_out_410012.awb") / 1000

					if var_288_31 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_23
					end

					if var_288_26.prefab_name ~= "" and arg_285_1.actors_[var_288_26.prefab_name] ~= nil then
						local var_288_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_26.prefab_name].transform, "story_v_out_410012", "410012070", "story_v_out_410012.awb")

						arg_285_1:RecordAudio("410012070", var_288_32)
						arg_285_1:RecordAudio("410012070", var_288_32)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410012", "410012070", "story_v_out_410012.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410012", "410012070", "story_v_out_410012.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_33 = math.max(var_288_24, arg_285_1.talkMaxDuration)

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_33 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_23) / var_288_33

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_23 + var_288_33 and arg_285_1.time_ < var_288_23 + var_288_33 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play410012071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410012071
		arg_289_1.duration_ = 11.47

		local var_289_0 = {
			zh = 9.266,
			ja = 11.466
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410012072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10061"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10061 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10061", 4)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(390, -517.5, -100)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10061, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_292_7 = arg_289_1.actors_["10061"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10061 == nil then
				arg_289_1.var_.actorSpriteComps10061 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps10061 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								local var_292_11 = Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, var_292_10)
								local var_292_12 = Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, var_292_10)
								local var_292_13 = Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, var_292_10)

								iter_292_2.color = Color.New(var_292_11, var_292_12, var_292_13)
							else
								local var_292_14 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

								iter_292_2.color = Color.New(var_292_14, var_292_14, var_292_14)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10061 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10061 = nil
			end

			local var_292_15 = arg_289_1.actors_["1060"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1060 == nil then
				arg_289_1.var_.actorSpriteComps1060 = var_292_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_17 = 0.034

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.actorSpriteComps1060 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								local var_292_19 = Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, var_292_18)
								local var_292_20 = Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, var_292_18)
								local var_292_21 = Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, var_292_18)

								iter_292_6.color = Color.New(var_292_19, var_292_20, var_292_21)
							else
								local var_292_22 = Mathf.Lerp(iter_292_6.color.r, 0.5, var_292_18)

								iter_292_6.color = Color.New(var_292_22, var_292_22, var_292_22)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1060 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_292_8 then
						if arg_289_1.isInRecall_ then
							iter_292_8.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1060 = nil
			end

			local var_292_23 = 0
			local var_292_24 = 0.975

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[591].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(410012071)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 39
				local var_292_29 = utf8.len(var_292_27)
				local var_292_30 = var_292_28 <= 0 and var_292_24 or var_292_24 * (var_292_29 / var_292_28)

				if var_292_30 > 0 and var_292_24 < var_292_30 then
					arg_289_1.talkMaxDuration = var_292_30

					if var_292_30 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_30 + var_292_23
					end
				end

				arg_289_1.text_.text = var_292_27
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012071", "story_v_out_410012.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012071", "story_v_out_410012.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_410012", "410012071", "story_v_out_410012.awb")

						arg_289_1:RecordAudio("410012071", var_292_32)
						arg_289_1:RecordAudio("410012071", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410012", "410012071", "story_v_out_410012.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410012", "410012071", "story_v_out_410012.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_33 = math.max(var_292_24, arg_289_1.talkMaxDuration)

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_33 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_23) / var_292_33

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_23 + var_292_33 and arg_289_1.time_ < var_292_23 + var_292_33 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play410012072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410012072
		arg_293_1.duration_ = 19.73

		local var_293_0 = {
			zh = 12.133,
			ja = 19.733
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
				arg_293_0:Play410012073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10061"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10061 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10061", 4)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(390, -517.5, -100)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10061, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_296_7 = arg_293_1.actors_["10061"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10061 == nil then
				arg_293_1.var_.actorSpriteComps10061 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps10061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10061 = nil
			end

			local var_296_15 = 0
			local var_296_16 = 1.15

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[591].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(410012072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012072", "story_v_out_410012.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012072", "story_v_out_410012.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_410012", "410012072", "story_v_out_410012.awb")

						arg_293_1:RecordAudio("410012072", var_296_24)
						arg_293_1:RecordAudio("410012072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410012", "410012072", "story_v_out_410012.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410012", "410012072", "story_v_out_410012.awb")
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
				actorName = "10061",
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
	Play410012073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410012073
		arg_297_1.duration_ = 11.33

		local var_297_0 = {
			zh = 5.666,
			ja = 11.333
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
				arg_297_0:Play410012074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10061"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos10061 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10061", 4)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(390, -517.5, -100)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10061, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_300_7 = arg_297_1.actors_["10061"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps10061 == nil then
				arg_297_1.var_.actorSpriteComps10061 = var_300_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_9 = 0.034

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.actorSpriteComps10061 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								local var_300_11 = Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, var_300_10)
								local var_300_12 = Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, var_300_10)
								local var_300_13 = Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, var_300_10)

								iter_300_2.color = Color.New(var_300_11, var_300_12, var_300_13)
							else
								local var_300_14 = Mathf.Lerp(iter_300_2.color.r, 1, var_300_10)

								iter_300_2.color = Color.New(var_300_14, var_300_14, var_300_14)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps10061 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_300_4 then
						if arg_297_1.isInRecall_ then
							iter_300_4.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10061 = nil
			end

			local var_300_15 = 0
			local var_300_16 = 0.475

			if var_300_15 < arg_297_1.time_ and arg_297_1.time_ <= var_300_15 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_17 = arg_297_1:FormatText(StoryNameCfg[591].name)

				arg_297_1.leftNameTxt_.text = var_300_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_18 = arg_297_1:GetWordFromCfg(410012073)
				local var_300_19 = arg_297_1:FormatText(var_300_18.content)

				arg_297_1.text_.text = var_300_19

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_20 = 19
				local var_300_21 = utf8.len(var_300_19)
				local var_300_22 = var_300_20 <= 0 and var_300_16 or var_300_16 * (var_300_21 / var_300_20)

				if var_300_22 > 0 and var_300_16 < var_300_22 then
					arg_297_1.talkMaxDuration = var_300_22

					if var_300_22 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_22 + var_300_15
					end
				end

				arg_297_1.text_.text = var_300_19
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012073", "story_v_out_410012.awb") ~= 0 then
					local var_300_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012073", "story_v_out_410012.awb") / 1000

					if var_300_23 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_15
					end

					if var_300_18.prefab_name ~= "" and arg_297_1.actors_[var_300_18.prefab_name] ~= nil then
						local var_300_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_18.prefab_name].transform, "story_v_out_410012", "410012073", "story_v_out_410012.awb")

						arg_297_1:RecordAudio("410012073", var_300_24)
						arg_297_1:RecordAudio("410012073", var_300_24)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410012", "410012073", "story_v_out_410012.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410012", "410012073", "story_v_out_410012.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_16, arg_297_1.talkMaxDuration)

			if var_300_15 <= arg_297_1.time_ and arg_297_1.time_ < var_300_15 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_15) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_15 + var_300_25 and arg_297_1.time_ < var_300_15 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410012074
		arg_301_1.duration_ = 5.3

		local var_301_0 = {
			zh = 0.999999999999,
			ja = 5.3
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
				arg_301_0:Play410012075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1060"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1060 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1060", 2)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "split_4" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1060, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_304_7 = arg_301_1.actors_["1060"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1060 == nil then
				arg_301_1.var_.actorSpriteComps1060 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 0.034

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps1060 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1060 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_304_4 then
						if arg_301_1.isInRecall_ then
							iter_304_4.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1060 = nil
			end

			local var_304_15 = arg_301_1.actors_["10061"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps10061 == nil then
				arg_301_1.var_.actorSpriteComps10061 = var_304_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_17 = 0.034

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.actorSpriteComps10061 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps10061 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_304_8 then
						if arg_301_1.isInRecall_ then
							iter_304_8.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10061 = nil
			end

			local var_304_23 = 0
			local var_304_24 = 0.1

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[584].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(410012074)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012074", "story_v_out_410012.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012074", "story_v_out_410012.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_410012", "410012074", "story_v_out_410012.awb")

						arg_301_1:RecordAudio("410012074", var_304_32)
						arg_301_1:RecordAudio("410012074", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410012", "410012074", "story_v_out_410012.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410012", "410012074", "story_v_out_410012.awb")
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
				actorName = "1060",
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
	Play410012075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410012075
		arg_305_1.duration_ = 13.07

		local var_305_0 = {
			zh = 12.766,
			ja = 13.066
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
				arg_305_0:Play410012076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10061"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos10061 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10061", 4)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "split_3" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(390, -517.5, -100)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10061, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_308_7 = arg_305_1.actors_["10061"]
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10061 == nil then
				arg_305_1.var_.actorSpriteComps10061 = var_308_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_9 = 0.034

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 and not isNil(var_308_7) then
				local var_308_10 = (arg_305_1.time_ - var_308_8) / var_308_9

				if arg_305_1.var_.actorSpriteComps10061 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								local var_308_11 = Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, var_308_10)
								local var_308_12 = Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, var_308_10)
								local var_308_13 = Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, var_308_10)

								iter_308_2.color = Color.New(var_308_11, var_308_12, var_308_13)
							else
								local var_308_14 = Mathf.Lerp(iter_308_2.color.r, 1, var_308_10)

								iter_308_2.color = Color.New(var_308_14, var_308_14, var_308_14)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10061 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_308_4 then
						if arg_305_1.isInRecall_ then
							iter_308_4.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10061 = nil
			end

			local var_308_15 = arg_305_1.actors_["1060"]
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 and not isNil(var_308_15) and arg_305_1.var_.actorSpriteComps1060 == nil then
				arg_305_1.var_.actorSpriteComps1060 = var_308_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_17 = 0.034

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 and not isNil(var_308_15) then
				local var_308_18 = (arg_305_1.time_ - var_308_16) / var_308_17

				if arg_305_1.var_.actorSpriteComps1060 then
					for iter_308_5, iter_308_6 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_308_6 then
							if arg_305_1.isInRecall_ then
								local var_308_19 = Mathf.Lerp(iter_308_6.color.r, arg_305_1.hightColor2.r, var_308_18)
								local var_308_20 = Mathf.Lerp(iter_308_6.color.g, arg_305_1.hightColor2.g, var_308_18)
								local var_308_21 = Mathf.Lerp(iter_308_6.color.b, arg_305_1.hightColor2.b, var_308_18)

								iter_308_6.color = Color.New(var_308_19, var_308_20, var_308_21)
							else
								local var_308_22 = Mathf.Lerp(iter_308_6.color.r, 0.5, var_308_18)

								iter_308_6.color = Color.New(var_308_22, var_308_22, var_308_22)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 and not isNil(var_308_15) and arg_305_1.var_.actorSpriteComps1060 then
				for iter_308_7, iter_308_8 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_308_8 then
						if arg_305_1.isInRecall_ then
							iter_308_8.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1060 = nil
			end

			local var_308_23 = 0
			local var_308_24 = 1.1

			if var_308_23 < arg_305_1.time_ and arg_305_1.time_ <= var_308_23 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_25 = arg_305_1:FormatText(StoryNameCfg[591].name)

				arg_305_1.leftNameTxt_.text = var_308_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_26 = arg_305_1:GetWordFromCfg(410012075)
				local var_308_27 = arg_305_1:FormatText(var_308_26.content)

				arg_305_1.text_.text = var_308_27

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_28 = 44
				local var_308_29 = utf8.len(var_308_27)
				local var_308_30 = var_308_28 <= 0 and var_308_24 or var_308_24 * (var_308_29 / var_308_28)

				if var_308_30 > 0 and var_308_24 < var_308_30 then
					arg_305_1.talkMaxDuration = var_308_30

					if var_308_30 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_30 + var_308_23
					end
				end

				arg_305_1.text_.text = var_308_27
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012075", "story_v_out_410012.awb") ~= 0 then
					local var_308_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012075", "story_v_out_410012.awb") / 1000

					if var_308_31 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_31 + var_308_23
					end

					if var_308_26.prefab_name ~= "" and arg_305_1.actors_[var_308_26.prefab_name] ~= nil then
						local var_308_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_26.prefab_name].transform, "story_v_out_410012", "410012075", "story_v_out_410012.awb")

						arg_305_1:RecordAudio("410012075", var_308_32)
						arg_305_1:RecordAudio("410012075", var_308_32)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410012", "410012075", "story_v_out_410012.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410012", "410012075", "story_v_out_410012.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_33 = math.max(var_308_24, arg_305_1.talkMaxDuration)

			if var_308_23 <= arg_305_1.time_ and arg_305_1.time_ < var_308_23 + var_308_33 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_23) / var_308_33

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_23 + var_308_33 and arg_305_1.time_ < var_308_23 + var_308_33 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410012076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play410012077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10061"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos10061 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10061", 7)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(0, -2000, -100)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10061, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_312_7 = arg_309_1.actors_["1060"].transform
			local var_312_8 = 0

			if var_312_8 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.var_.moveOldPos1060 = var_312_7.localPosition
				var_312_7.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1060", 7)

				local var_312_9 = var_312_7.childCount

				for iter_312_1 = 0, var_312_9 - 1 do
					local var_312_10 = var_312_7:GetChild(iter_312_1)

					if var_312_10.name == "" or not string.find(var_312_10.name, "split") then
						var_312_10.gameObject:SetActive(true)
					else
						var_312_10.gameObject:SetActive(false)
					end
				end
			end

			local var_312_11 = 0.001

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_11 then
				local var_312_12 = (arg_309_1.time_ - var_312_8) / var_312_11
				local var_312_13 = Vector3.New(0, -2000, -40)

				var_312_7.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1060, var_312_13, var_312_12)
			end

			if arg_309_1.time_ >= var_312_8 + var_312_11 and arg_309_1.time_ < var_312_8 + var_312_11 + arg_312_0 then
				var_312_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_312_14 = arg_309_1.actors_["10061"]
			local var_312_15 = 0

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 and not isNil(var_312_14) and arg_309_1.var_.actorSpriteComps10061 == nil then
				arg_309_1.var_.actorSpriteComps10061 = var_312_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_16 = 0.034

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_16 and not isNil(var_312_14) then
				local var_312_17 = (arg_309_1.time_ - var_312_15) / var_312_16

				if arg_309_1.var_.actorSpriteComps10061 then
					for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_312_3 then
							if arg_309_1.isInRecall_ then
								local var_312_18 = Mathf.Lerp(iter_312_3.color.r, arg_309_1.hightColor2.r, var_312_17)
								local var_312_19 = Mathf.Lerp(iter_312_3.color.g, arg_309_1.hightColor2.g, var_312_17)
								local var_312_20 = Mathf.Lerp(iter_312_3.color.b, arg_309_1.hightColor2.b, var_312_17)

								iter_312_3.color = Color.New(var_312_18, var_312_19, var_312_20)
							else
								local var_312_21 = Mathf.Lerp(iter_312_3.color.r, 0.5, var_312_17)

								iter_312_3.color = Color.New(var_312_21, var_312_21, var_312_21)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_15 + var_312_16 and arg_309_1.time_ < var_312_15 + var_312_16 + arg_312_0 and not isNil(var_312_14) and arg_309_1.var_.actorSpriteComps10061 then
				for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_312_5 then
						if arg_309_1.isInRecall_ then
							iter_312_5.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps10061 = nil
			end

			local var_312_22 = arg_309_1.actors_["1060"]
			local var_312_23 = 0

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 and not isNil(var_312_22) and arg_309_1.var_.actorSpriteComps1060 == nil then
				arg_309_1.var_.actorSpriteComps1060 = var_312_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_24 = 0.034

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_24 and not isNil(var_312_22) then
				local var_312_25 = (arg_309_1.time_ - var_312_23) / var_312_24

				if arg_309_1.var_.actorSpriteComps1060 then
					for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_312_7 then
							if arg_309_1.isInRecall_ then
								local var_312_26 = Mathf.Lerp(iter_312_7.color.r, arg_309_1.hightColor2.r, var_312_25)
								local var_312_27 = Mathf.Lerp(iter_312_7.color.g, arg_309_1.hightColor2.g, var_312_25)
								local var_312_28 = Mathf.Lerp(iter_312_7.color.b, arg_309_1.hightColor2.b, var_312_25)

								iter_312_7.color = Color.New(var_312_26, var_312_27, var_312_28)
							else
								local var_312_29 = Mathf.Lerp(iter_312_7.color.r, 0.5, var_312_25)

								iter_312_7.color = Color.New(var_312_29, var_312_29, var_312_29)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_23 + var_312_24 and arg_309_1.time_ < var_312_23 + var_312_24 + arg_312_0 and not isNil(var_312_22) and arg_309_1.var_.actorSpriteComps1060 then
				for iter_312_8, iter_312_9 in pairs(arg_309_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_312_9 then
						if arg_309_1.isInRecall_ then
							iter_312_9.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1060 = nil
			end

			local var_312_30 = 0
			local var_312_31 = 1.55

			if var_312_30 < arg_309_1.time_ and arg_309_1.time_ <= var_312_30 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_32 = arg_309_1:GetWordFromCfg(410012076)
				local var_312_33 = arg_309_1:FormatText(var_312_32.content)

				arg_309_1.text_.text = var_312_33

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_34 = 62
				local var_312_35 = utf8.len(var_312_33)
				local var_312_36 = var_312_34 <= 0 and var_312_31 or var_312_31 * (var_312_35 / var_312_34)

				if var_312_36 > 0 and var_312_31 < var_312_36 then
					arg_309_1.talkMaxDuration = var_312_36

					if var_312_36 + var_312_30 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_36 + var_312_30
					end
				end

				arg_309_1.text_.text = var_312_33
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_37 = math.max(var_312_31, arg_309_1.talkMaxDuration)

			if var_312_30 <= arg_309_1.time_ and arg_309_1.time_ < var_312_30 + var_312_37 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_30) / var_312_37

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_30 + var_312_37 and arg_309_1.time_ < var_312_30 + var_312_37 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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

		arg_309_1:InitPlayNodeList()
	end,
	Play410012077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410012077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play410012078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.475

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(410012077)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 19
				local var_316_5 = utf8.len(var_316_3)
				local var_316_6 = var_316_4 <= 0 and var_316_1 or var_316_1 * (var_316_5 / var_316_4)

				if var_316_6 > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_7 and arg_313_1.time_ < var_316_0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play410012078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410012078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play410012079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.65

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(410012078)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 66
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play410012079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410012079
		arg_321_1.duration_ = 4

		local var_321_0 = {
			zh = 3.566,
			ja = 4
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play410012080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1060"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1060 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1060", 2)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1060, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_324_7 = arg_321_1.actors_["10061"].transform
			local var_324_8 = 0

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.var_.moveOldPos10061 = var_324_7.localPosition
				var_324_7.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10061", 4)

				local var_324_9 = var_324_7.childCount

				for iter_324_1 = 0, var_324_9 - 1 do
					local var_324_10 = var_324_7:GetChild(iter_324_1)

					if var_324_10.name == "split_3" or not string.find(var_324_10.name, "split") then
						var_324_10.gameObject:SetActive(true)
					else
						var_324_10.gameObject:SetActive(false)
					end
				end
			end

			local var_324_11 = 0.001

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_11 then
				local var_324_12 = (arg_321_1.time_ - var_324_8) / var_324_11
				local var_324_13 = Vector3.New(390, -517.5, -100)

				var_324_7.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10061, var_324_13, var_324_12)
			end

			if arg_321_1.time_ >= var_324_8 + var_324_11 and arg_321_1.time_ < var_324_8 + var_324_11 + arg_324_0 then
				var_324_7.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_324_14 = arg_321_1.actors_["1060"]
			local var_324_15 = 0

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 and not isNil(var_324_14) and arg_321_1.var_.actorSpriteComps1060 == nil then
				arg_321_1.var_.actorSpriteComps1060 = var_324_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_16 = 0.034

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_16 and not isNil(var_324_14) then
				local var_324_17 = (arg_321_1.time_ - var_324_15) / var_324_16

				if arg_321_1.var_.actorSpriteComps1060 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								local var_324_18 = Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor2.r, var_324_17)
								local var_324_19 = Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor2.g, var_324_17)
								local var_324_20 = Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor2.b, var_324_17)

								iter_324_3.color = Color.New(var_324_18, var_324_19, var_324_20)
							else
								local var_324_21 = Mathf.Lerp(iter_324_3.color.r, 0.5, var_324_17)

								iter_324_3.color = Color.New(var_324_21, var_324_21, var_324_21)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_15 + var_324_16 and arg_321_1.time_ < var_324_15 + var_324_16 + arg_324_0 and not isNil(var_324_14) and arg_321_1.var_.actorSpriteComps1060 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_324_5 then
						if arg_321_1.isInRecall_ then
							iter_324_5.color = arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_324_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps1060 = nil
			end

			local var_324_22 = arg_321_1.actors_["10061"]
			local var_324_23 = 0

			if var_324_23 < arg_321_1.time_ and arg_321_1.time_ <= var_324_23 + arg_324_0 and not isNil(var_324_22) and arg_321_1.var_.actorSpriteComps10061 == nil then
				arg_321_1.var_.actorSpriteComps10061 = var_324_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_24 = 0.034

			if var_324_23 <= arg_321_1.time_ and arg_321_1.time_ < var_324_23 + var_324_24 and not isNil(var_324_22) then
				local var_324_25 = (arg_321_1.time_ - var_324_23) / var_324_24

				if arg_321_1.var_.actorSpriteComps10061 then
					for iter_324_6, iter_324_7 in pairs(arg_321_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_324_7 then
							if arg_321_1.isInRecall_ then
								local var_324_26 = Mathf.Lerp(iter_324_7.color.r, arg_321_1.hightColor1.r, var_324_25)
								local var_324_27 = Mathf.Lerp(iter_324_7.color.g, arg_321_1.hightColor1.g, var_324_25)
								local var_324_28 = Mathf.Lerp(iter_324_7.color.b, arg_321_1.hightColor1.b, var_324_25)

								iter_324_7.color = Color.New(var_324_26, var_324_27, var_324_28)
							else
								local var_324_29 = Mathf.Lerp(iter_324_7.color.r, 1, var_324_25)

								iter_324_7.color = Color.New(var_324_29, var_324_29, var_324_29)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_23 + var_324_24 and arg_321_1.time_ < var_324_23 + var_324_24 + arg_324_0 and not isNil(var_324_22) and arg_321_1.var_.actorSpriteComps10061 then
				for iter_324_8, iter_324_9 in pairs(arg_321_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_324_9 then
						if arg_321_1.isInRecall_ then
							iter_324_9.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10061 = nil
			end

			local var_324_30 = 0
			local var_324_31 = 0.275

			if var_324_30 < arg_321_1.time_ and arg_321_1.time_ <= var_324_30 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_32 = arg_321_1:FormatText(StoryNameCfg[591].name)

				arg_321_1.leftNameTxt_.text = var_324_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_33 = arg_321_1:GetWordFromCfg(410012079)
				local var_324_34 = arg_321_1:FormatText(var_324_33.content)

				arg_321_1.text_.text = var_324_34

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_35 = 11
				local var_324_36 = utf8.len(var_324_34)
				local var_324_37 = var_324_35 <= 0 and var_324_31 or var_324_31 * (var_324_36 / var_324_35)

				if var_324_37 > 0 and var_324_31 < var_324_37 then
					arg_321_1.talkMaxDuration = var_324_37

					if var_324_37 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_37 + var_324_30
					end
				end

				arg_321_1.text_.text = var_324_34
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012079", "story_v_out_410012.awb") ~= 0 then
					local var_324_38 = manager.audio:GetVoiceLength("story_v_out_410012", "410012079", "story_v_out_410012.awb") / 1000

					if var_324_38 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_38 + var_324_30
					end

					if var_324_33.prefab_name ~= "" and arg_321_1.actors_[var_324_33.prefab_name] ~= nil then
						local var_324_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_33.prefab_name].transform, "story_v_out_410012", "410012079", "story_v_out_410012.awb")

						arg_321_1:RecordAudio("410012079", var_324_39)
						arg_321_1:RecordAudio("410012079", var_324_39)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410012", "410012079", "story_v_out_410012.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410012", "410012079", "story_v_out_410012.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_40 = math.max(var_324_31, arg_321_1.talkMaxDuration)

			if var_324_30 <= arg_321_1.time_ and arg_321_1.time_ < var_324_30 + var_324_40 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_30) / var_324_40

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_30 + var_324_40 and arg_321_1.time_ < var_324_30 + var_324_40 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play410012080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410012080
		arg_325_1.duration_ = 14.53

		local var_325_0 = {
			zh = 11.766,
			ja = 14.533
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
				arg_325_0:Play410012081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10061"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos10061 = var_328_0.localPosition
				var_328_0.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10061", 4)

				local var_328_2 = var_328_0.childCount

				for iter_328_0 = 0, var_328_2 - 1 do
					local var_328_3 = var_328_0:GetChild(iter_328_0)

					if var_328_3.name == "" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_4 then
				local var_328_5 = (arg_325_1.time_ - var_328_1) / var_328_4
				local var_328_6 = Vector3.New(390, -517.5, -100)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10061, var_328_6, var_328_5)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_4 and arg_325_1.time_ < var_328_1 + var_328_4 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_328_7 = arg_325_1.actors_["10061"]
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10061 == nil then
				arg_325_1.var_.actorSpriteComps10061 = var_328_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_9 = 0.034

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 and not isNil(var_328_7) then
				local var_328_10 = (arg_325_1.time_ - var_328_8) / var_328_9

				if arg_325_1.var_.actorSpriteComps10061 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_328_2 then
							if arg_325_1.isInRecall_ then
								local var_328_11 = Mathf.Lerp(iter_328_2.color.r, arg_325_1.hightColor1.r, var_328_10)
								local var_328_12 = Mathf.Lerp(iter_328_2.color.g, arg_325_1.hightColor1.g, var_328_10)
								local var_328_13 = Mathf.Lerp(iter_328_2.color.b, arg_325_1.hightColor1.b, var_328_10)

								iter_328_2.color = Color.New(var_328_11, var_328_12, var_328_13)
							else
								local var_328_14 = Mathf.Lerp(iter_328_2.color.r, 1, var_328_10)

								iter_328_2.color = Color.New(var_328_14, var_328_14, var_328_14)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10061 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_328_4 then
						if arg_325_1.isInRecall_ then
							iter_328_4.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10061 = nil
			end

			local var_328_15 = 0
			local var_328_16 = 1.1

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_17 = arg_325_1:FormatText(StoryNameCfg[591].name)

				arg_325_1.leftNameTxt_.text = var_328_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_18 = arg_325_1:GetWordFromCfg(410012080)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012080", "story_v_out_410012.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012080", "story_v_out_410012.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_out_410012", "410012080", "story_v_out_410012.awb")

						arg_325_1:RecordAudio("410012080", var_328_24)
						arg_325_1:RecordAudio("410012080", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_410012", "410012080", "story_v_out_410012.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_410012", "410012080", "story_v_out_410012.awb")
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
				actorName = "10061",
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
	Play410012081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410012081
		arg_329_1.duration_ = 8.33

		local var_329_0 = {
			zh = 7.933,
			ja = 8.333
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
				arg_329_0:Play410012082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1060"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1060 == nil then
				arg_329_1.var_.actorSpriteComps1060 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.034

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1060 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1060 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1060 = nil
			end

			local var_332_8 = arg_329_1.actors_["10061"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10061 == nil then
				arg_329_1.var_.actorSpriteComps10061 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.034

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps10061 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10061 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10061 = nil
			end

			local var_332_16 = 0
			local var_332_17 = 0.875

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_18 = arg_329_1:FormatText(StoryNameCfg[584].name)

				arg_329_1.leftNameTxt_.text = var_332_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_19 = arg_329_1:GetWordFromCfg(410012081)
				local var_332_20 = arg_329_1:FormatText(var_332_19.content)

				arg_329_1.text_.text = var_332_20

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_21 = 35
				local var_332_22 = utf8.len(var_332_20)
				local var_332_23 = var_332_21 <= 0 and var_332_17 or var_332_17 * (var_332_22 / var_332_21)

				if var_332_23 > 0 and var_332_17 < var_332_23 then
					arg_329_1.talkMaxDuration = var_332_23

					if var_332_23 + var_332_16 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_23 + var_332_16
					end
				end

				arg_329_1.text_.text = var_332_20
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012081", "story_v_out_410012.awb") ~= 0 then
					local var_332_24 = manager.audio:GetVoiceLength("story_v_out_410012", "410012081", "story_v_out_410012.awb") / 1000

					if var_332_24 + var_332_16 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_24 + var_332_16
					end

					if var_332_19.prefab_name ~= "" and arg_329_1.actors_[var_332_19.prefab_name] ~= nil then
						local var_332_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_19.prefab_name].transform, "story_v_out_410012", "410012081", "story_v_out_410012.awb")

						arg_329_1:RecordAudio("410012081", var_332_25)
						arg_329_1:RecordAudio("410012081", var_332_25)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410012", "410012081", "story_v_out_410012.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410012", "410012081", "story_v_out_410012.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_26 = math.max(var_332_17, arg_329_1.talkMaxDuration)

			if var_332_16 <= arg_329_1.time_ and arg_329_1.time_ < var_332_16 + var_332_26 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_16) / var_332_26

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_16 + var_332_26 and arg_329_1.time_ < var_332_16 + var_332_26 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play410012082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410012082
		arg_333_1.duration_ = 7.3

		local var_333_0 = {
			zh = 3.2,
			ja = 7.3
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
				arg_333_0:Play410012083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1060"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1060 == nil then
				arg_333_1.var_.actorSpriteComps1060 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.034

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1060 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 0.5, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1060 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1060 = nil
			end

			local var_336_8 = arg_333_1.actors_["10061"]
			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10061 == nil then
				arg_333_1.var_.actorSpriteComps10061 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_10 = 0.034

			if var_336_9 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 and not isNil(var_336_8) then
				local var_336_11 = (arg_333_1.time_ - var_336_9) / var_336_10

				if arg_333_1.var_.actorSpriteComps10061 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								local var_336_12 = Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor1.r, var_336_11)
								local var_336_13 = Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor1.g, var_336_11)
								local var_336_14 = Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor1.b, var_336_11)

								iter_336_5.color = Color.New(var_336_12, var_336_13, var_336_14)
							else
								local var_336_15 = Mathf.Lerp(iter_336_5.color.r, 1, var_336_11)

								iter_336_5.color = Color.New(var_336_15, var_336_15, var_336_15)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10061 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_336_7 then
						if arg_333_1.isInRecall_ then
							iter_336_7.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10061 = nil
			end

			local var_336_16 = 0
			local var_336_17 = 0.4

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_18 = arg_333_1:FormatText(StoryNameCfg[591].name)

				arg_333_1.leftNameTxt_.text = var_336_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_19 = arg_333_1:GetWordFromCfg(410012082)
				local var_336_20 = arg_333_1:FormatText(var_336_19.content)

				arg_333_1.text_.text = var_336_20

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_21 = 16
				local var_336_22 = utf8.len(var_336_20)
				local var_336_23 = var_336_21 <= 0 and var_336_17 or var_336_17 * (var_336_22 / var_336_21)

				if var_336_23 > 0 and var_336_17 < var_336_23 then
					arg_333_1.talkMaxDuration = var_336_23

					if var_336_23 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_16
					end
				end

				arg_333_1.text_.text = var_336_20
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012082", "story_v_out_410012.awb") ~= 0 then
					local var_336_24 = manager.audio:GetVoiceLength("story_v_out_410012", "410012082", "story_v_out_410012.awb") / 1000

					if var_336_24 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_24 + var_336_16
					end

					if var_336_19.prefab_name ~= "" and arg_333_1.actors_[var_336_19.prefab_name] ~= nil then
						local var_336_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_19.prefab_name].transform, "story_v_out_410012", "410012082", "story_v_out_410012.awb")

						arg_333_1:RecordAudio("410012082", var_336_25)
						arg_333_1:RecordAudio("410012082", var_336_25)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410012", "410012082", "story_v_out_410012.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410012", "410012082", "story_v_out_410012.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_26 = math.max(var_336_17, arg_333_1.talkMaxDuration)

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_26 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_16) / var_336_26

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_16 + var_336_26 and arg_333_1.time_ < var_336_16 + var_336_26 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play410012083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410012083
		arg_337_1.duration_ = 6.83

		local var_337_0 = {
			zh = 1.633,
			ja = 6.833
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play410012084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1060"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1060 == nil then
				arg_337_1.var_.actorSpriteComps1060 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.034

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps1060 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_4 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, var_340_3)
								local var_340_5 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, var_340_3)
								local var_340_6 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, var_340_3)

								iter_340_1.color = Color.New(var_340_4, var_340_5, var_340_6)
							else
								local var_340_7 = Mathf.Lerp(iter_340_1.color.r, 1, var_340_3)

								iter_340_1.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1060 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1060 = nil
			end

			local var_340_8 = arg_337_1.actors_["10061"]
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps10061 == nil then
				arg_337_1.var_.actorSpriteComps10061 = var_340_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_10 = 0.034

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_10 and not isNil(var_340_8) then
				local var_340_11 = (arg_337_1.time_ - var_340_9) / var_340_10

				if arg_337_1.var_.actorSpriteComps10061 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								local var_340_12 = Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor2.r, var_340_11)
								local var_340_13 = Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor2.g, var_340_11)
								local var_340_14 = Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor2.b, var_340_11)

								iter_340_5.color = Color.New(var_340_12, var_340_13, var_340_14)
							else
								local var_340_15 = Mathf.Lerp(iter_340_5.color.r, 0.5, var_340_11)

								iter_340_5.color = Color.New(var_340_15, var_340_15, var_340_15)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_9 + var_340_10 and arg_337_1.time_ < var_340_9 + var_340_10 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps10061 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_340_7 then
						if arg_337_1.isInRecall_ then
							iter_340_7.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10061 = nil
			end

			local var_340_16 = 0
			local var_340_17 = 0.225

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_18 = arg_337_1:FormatText(StoryNameCfg[584].name)

				arg_337_1.leftNameTxt_.text = var_340_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_19 = arg_337_1:GetWordFromCfg(410012083)
				local var_340_20 = arg_337_1:FormatText(var_340_19.content)

				arg_337_1.text_.text = var_340_20

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_21 = 9
				local var_340_22 = utf8.len(var_340_20)
				local var_340_23 = var_340_21 <= 0 and var_340_17 or var_340_17 * (var_340_22 / var_340_21)

				if var_340_23 > 0 and var_340_17 < var_340_23 then
					arg_337_1.talkMaxDuration = var_340_23

					if var_340_23 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_16
					end
				end

				arg_337_1.text_.text = var_340_20
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012083", "story_v_out_410012.awb") ~= 0 then
					local var_340_24 = manager.audio:GetVoiceLength("story_v_out_410012", "410012083", "story_v_out_410012.awb") / 1000

					if var_340_24 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_24 + var_340_16
					end

					if var_340_19.prefab_name ~= "" and arg_337_1.actors_[var_340_19.prefab_name] ~= nil then
						local var_340_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_19.prefab_name].transform, "story_v_out_410012", "410012083", "story_v_out_410012.awb")

						arg_337_1:RecordAudio("410012083", var_340_25)
						arg_337_1:RecordAudio("410012083", var_340_25)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_410012", "410012083", "story_v_out_410012.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_410012", "410012083", "story_v_out_410012.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_26 = math.max(var_340_17, arg_337_1.talkMaxDuration)

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_26 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_16) / var_340_26

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_16 + var_340_26 and arg_337_1.time_ < var_340_16 + var_340_26 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play410012084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410012084
		arg_341_1.duration_ = 3.73

		local var_341_0 = {
			zh = 2.466,
			ja = 3.733
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
				arg_341_0:Play410012085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10061"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10061 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10061", 4)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "split_3" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(390, -517.5, -100)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10061, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_344_7 = arg_341_1.actors_["10061"]
			local var_344_8 = 0

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps10061 == nil then
				arg_341_1.var_.actorSpriteComps10061 = var_344_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_9 = 0.034

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_9 and not isNil(var_344_7) then
				local var_344_10 = (arg_341_1.time_ - var_344_8) / var_344_9

				if arg_341_1.var_.actorSpriteComps10061 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								local var_344_11 = Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor1.r, var_344_10)
								local var_344_12 = Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor1.g, var_344_10)
								local var_344_13 = Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor1.b, var_344_10)

								iter_344_2.color = Color.New(var_344_11, var_344_12, var_344_13)
							else
								local var_344_14 = Mathf.Lerp(iter_344_2.color.r, 1, var_344_10)

								iter_344_2.color = Color.New(var_344_14, var_344_14, var_344_14)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_8 + var_344_9 and arg_341_1.time_ < var_344_8 + var_344_9 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps10061 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_344_4 then
						if arg_341_1.isInRecall_ then
							iter_344_4.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps10061 = nil
			end

			local var_344_15 = arg_341_1.actors_["1060"]
			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps1060 == nil then
				arg_341_1.var_.actorSpriteComps1060 = var_344_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_17 = 0.034

			if var_344_16 <= arg_341_1.time_ and arg_341_1.time_ < var_344_16 + var_344_17 and not isNil(var_344_15) then
				local var_344_18 = (arg_341_1.time_ - var_344_16) / var_344_17

				if arg_341_1.var_.actorSpriteComps1060 then
					for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_344_6 then
							if arg_341_1.isInRecall_ then
								local var_344_19 = Mathf.Lerp(iter_344_6.color.r, arg_341_1.hightColor2.r, var_344_18)
								local var_344_20 = Mathf.Lerp(iter_344_6.color.g, arg_341_1.hightColor2.g, var_344_18)
								local var_344_21 = Mathf.Lerp(iter_344_6.color.b, arg_341_1.hightColor2.b, var_344_18)

								iter_344_6.color = Color.New(var_344_19, var_344_20, var_344_21)
							else
								local var_344_22 = Mathf.Lerp(iter_344_6.color.r, 0.5, var_344_18)

								iter_344_6.color = Color.New(var_344_22, var_344_22, var_344_22)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps1060 then
				for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_344_8 then
						if arg_341_1.isInRecall_ then
							iter_344_8.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1060 = nil
			end

			local var_344_23 = 0
			local var_344_24 = 0.3

			if var_344_23 < arg_341_1.time_ and arg_341_1.time_ <= var_344_23 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_25 = arg_341_1:FormatText(StoryNameCfg[591].name)

				arg_341_1.leftNameTxt_.text = var_344_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_26 = arg_341_1:GetWordFromCfg(410012084)
				local var_344_27 = arg_341_1:FormatText(var_344_26.content)

				arg_341_1.text_.text = var_344_27

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_28 = 12
				local var_344_29 = utf8.len(var_344_27)
				local var_344_30 = var_344_28 <= 0 and var_344_24 or var_344_24 * (var_344_29 / var_344_28)

				if var_344_30 > 0 and var_344_24 < var_344_30 then
					arg_341_1.talkMaxDuration = var_344_30

					if var_344_30 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_30 + var_344_23
					end
				end

				arg_341_1.text_.text = var_344_27
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012084", "story_v_out_410012.awb") ~= 0 then
					local var_344_31 = manager.audio:GetVoiceLength("story_v_out_410012", "410012084", "story_v_out_410012.awb") / 1000

					if var_344_31 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_31 + var_344_23
					end

					if var_344_26.prefab_name ~= "" and arg_341_1.actors_[var_344_26.prefab_name] ~= nil then
						local var_344_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_26.prefab_name].transform, "story_v_out_410012", "410012084", "story_v_out_410012.awb")

						arg_341_1:RecordAudio("410012084", var_344_32)
						arg_341_1:RecordAudio("410012084", var_344_32)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_410012", "410012084", "story_v_out_410012.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_410012", "410012084", "story_v_out_410012.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_33 = math.max(var_344_24, arg_341_1.talkMaxDuration)

			if var_344_23 <= arg_341_1.time_ and arg_341_1.time_ < var_344_23 + var_344_33 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_23) / var_344_33

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_23 + var_344_33 and arg_341_1.time_ < var_344_23 + var_344_33 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410012085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play410012086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10061"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10061 == nil then
				arg_345_1.var_.actorSpriteComps10061 = var_348_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_2 = 0.034

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.actorSpriteComps10061 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10061 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_348_3 then
						if arg_345_1.isInRecall_ then
							iter_348_3.color = arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_348_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10061 = nil
			end

			local var_348_8 = 0
			local var_348_9 = 1.15

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_10 = arg_345_1:GetWordFromCfg(410012085)
				local var_348_11 = arg_345_1:FormatText(var_348_10.content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_12 = 46
				local var_348_13 = utf8.len(var_348_11)
				local var_348_14 = var_348_12 <= 0 and var_348_9 or var_348_9 * (var_348_13 / var_348_12)

				if var_348_14 > 0 and var_348_9 < var_348_14 then
					arg_345_1.talkMaxDuration = var_348_14

					if var_348_14 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_15 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_15 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_15

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_15 and arg_345_1.time_ < var_348_8 + var_348_15 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play410012086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410012086
		arg_349_1.duration_ = 9

		local var_349_0 = {
			zh = 8.833,
			ja = 9
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play410012087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10061"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos10061 = var_352_0.localPosition
				var_352_0.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10061", 3)

				local var_352_2 = var_352_0.childCount

				for iter_352_0 = 0, var_352_2 - 1 do
					local var_352_3 = var_352_0:GetChild(iter_352_0)

					if var_352_3.name == "" or not string.find(var_352_3.name, "split") then
						var_352_3.gameObject:SetActive(true)
					else
						var_352_3.gameObject:SetActive(false)
					end
				end
			end

			local var_352_4 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_4 then
				local var_352_5 = (arg_349_1.time_ - var_352_1) / var_352_4
				local var_352_6 = Vector3.New(0, -517.5, -100)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10061, var_352_6, var_352_5)
			end

			if arg_349_1.time_ >= var_352_1 + var_352_4 and arg_349_1.time_ < var_352_1 + var_352_4 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_352_7 = arg_349_1.actors_["1060"].transform
			local var_352_8 = 0

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.var_.moveOldPos1060 = var_352_7.localPosition
				var_352_7.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("1060", 7)

				local var_352_9 = var_352_7.childCount

				for iter_352_1 = 0, var_352_9 - 1 do
					local var_352_10 = var_352_7:GetChild(iter_352_1)

					if var_352_10.name == "" or not string.find(var_352_10.name, "split") then
						var_352_10.gameObject:SetActive(true)
					else
						var_352_10.gameObject:SetActive(false)
					end
				end
			end

			local var_352_11 = 0.001

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_11 then
				local var_352_12 = (arg_349_1.time_ - var_352_8) / var_352_11
				local var_352_13 = Vector3.New(0, -2000, -40)

				var_352_7.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1060, var_352_13, var_352_12)
			end

			if arg_349_1.time_ >= var_352_8 + var_352_11 and arg_349_1.time_ < var_352_8 + var_352_11 + arg_352_0 then
				var_352_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_352_14 = arg_349_1.actors_["10061"]
			local var_352_15 = 0

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.actorSpriteComps10061 == nil then
				arg_349_1.var_.actorSpriteComps10061 = var_352_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_16 = 0.034

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_16 and not isNil(var_352_14) then
				local var_352_17 = (arg_349_1.time_ - var_352_15) / var_352_16

				if arg_349_1.var_.actorSpriteComps10061 then
					for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_352_3 then
							if arg_349_1.isInRecall_ then
								local var_352_18 = Mathf.Lerp(iter_352_3.color.r, arg_349_1.hightColor1.r, var_352_17)
								local var_352_19 = Mathf.Lerp(iter_352_3.color.g, arg_349_1.hightColor1.g, var_352_17)
								local var_352_20 = Mathf.Lerp(iter_352_3.color.b, arg_349_1.hightColor1.b, var_352_17)

								iter_352_3.color = Color.New(var_352_18, var_352_19, var_352_20)
							else
								local var_352_21 = Mathf.Lerp(iter_352_3.color.r, 1, var_352_17)

								iter_352_3.color = Color.New(var_352_21, var_352_21, var_352_21)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_15 + var_352_16 and arg_349_1.time_ < var_352_15 + var_352_16 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.actorSpriteComps10061 then
				for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_352_5 then
						if arg_349_1.isInRecall_ then
							iter_352_5.color = arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_352_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10061 = nil
			end

			local var_352_22 = arg_349_1.actors_["1060"]
			local var_352_23 = 0

			if var_352_23 < arg_349_1.time_ and arg_349_1.time_ <= var_352_23 + arg_352_0 and not isNil(var_352_22) and arg_349_1.var_.actorSpriteComps1060 == nil then
				arg_349_1.var_.actorSpriteComps1060 = var_352_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_24 = 0.034

			if var_352_23 <= arg_349_1.time_ and arg_349_1.time_ < var_352_23 + var_352_24 and not isNil(var_352_22) then
				local var_352_25 = (arg_349_1.time_ - var_352_23) / var_352_24

				if arg_349_1.var_.actorSpriteComps1060 then
					for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_352_7 then
							if arg_349_1.isInRecall_ then
								local var_352_26 = Mathf.Lerp(iter_352_7.color.r, arg_349_1.hightColor2.r, var_352_25)
								local var_352_27 = Mathf.Lerp(iter_352_7.color.g, arg_349_1.hightColor2.g, var_352_25)
								local var_352_28 = Mathf.Lerp(iter_352_7.color.b, arg_349_1.hightColor2.b, var_352_25)

								iter_352_7.color = Color.New(var_352_26, var_352_27, var_352_28)
							else
								local var_352_29 = Mathf.Lerp(iter_352_7.color.r, 0.5, var_352_25)

								iter_352_7.color = Color.New(var_352_29, var_352_29, var_352_29)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_23 + var_352_24 and arg_349_1.time_ < var_352_23 + var_352_24 + arg_352_0 and not isNil(var_352_22) and arg_349_1.var_.actorSpriteComps1060 then
				for iter_352_8, iter_352_9 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_352_9 then
						if arg_349_1.isInRecall_ then
							iter_352_9.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps1060 = nil
			end

			local var_352_30 = 0
			local var_352_31 = 0.85

			if var_352_30 < arg_349_1.time_ and arg_349_1.time_ <= var_352_30 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_32 = arg_349_1:FormatText(StoryNameCfg[591].name)

				arg_349_1.leftNameTxt_.text = var_352_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_33 = arg_349_1:GetWordFromCfg(410012086)
				local var_352_34 = arg_349_1:FormatText(var_352_33.content)

				arg_349_1.text_.text = var_352_34

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_35 = 34
				local var_352_36 = utf8.len(var_352_34)
				local var_352_37 = var_352_35 <= 0 and var_352_31 or var_352_31 * (var_352_36 / var_352_35)

				if var_352_37 > 0 and var_352_31 < var_352_37 then
					arg_349_1.talkMaxDuration = var_352_37

					if var_352_37 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_37 + var_352_30
					end
				end

				arg_349_1.text_.text = var_352_34
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012086", "story_v_out_410012.awb") ~= 0 then
					local var_352_38 = manager.audio:GetVoiceLength("story_v_out_410012", "410012086", "story_v_out_410012.awb") / 1000

					if var_352_38 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_38 + var_352_30
					end

					if var_352_33.prefab_name ~= "" and arg_349_1.actors_[var_352_33.prefab_name] ~= nil then
						local var_352_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_33.prefab_name].transform, "story_v_out_410012", "410012086", "story_v_out_410012.awb")

						arg_349_1:RecordAudio("410012086", var_352_39)
						arg_349_1:RecordAudio("410012086", var_352_39)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_410012", "410012086", "story_v_out_410012.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_410012", "410012086", "story_v_out_410012.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_40 = math.max(var_352_31, arg_349_1.talkMaxDuration)

			if var_352_30 <= arg_349_1.time_ and arg_349_1.time_ < var_352_30 + var_352_40 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_30) / var_352_40

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_30 + var_352_40 and arg_349_1.time_ < var_352_30 + var_352_40 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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

		arg_349_1:InitPlayNodeList()
	end,
	Play410012087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410012087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play410012088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10061"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps10061 == nil then
				arg_353_1.var_.actorSpriteComps10061 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.034

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps10061 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor2.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor2.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor2.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 0.5, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps10061 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10061 = nil
			end

			local var_356_8 = 0
			local var_356_9 = 1.75

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(410012087)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_12 = 70
				local var_356_13 = utf8.len(var_356_11)
				local var_356_14 = var_356_12 <= 0 and var_356_9 or var_356_9 * (var_356_13 / var_356_12)

				if var_356_14 > 0 and var_356_9 < var_356_14 then
					arg_353_1.talkMaxDuration = var_356_14

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_15 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_15 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_15

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_15 and arg_353_1.time_ < var_356_8 + var_356_15 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play410012088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 410012088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play410012089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.8

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(410012088)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 32
				local var_360_5 = utf8.len(var_360_3)
				local var_360_6 = var_360_4 <= 0 and var_360_1 or var_360_1 * (var_360_5 / var_360_4)

				if var_360_6 > 0 and var_360_1 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_7 and arg_357_1.time_ < var_360_0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play410012089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 410012089
		arg_361_1.duration_ = 4.63

		local var_361_0 = {
			zh = 4.1,
			ja = 4.633
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play410012090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.55

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[36].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:GetWordFromCfg(410012089)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 22
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012089", "story_v_out_410012.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012089", "story_v_out_410012.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_410012", "410012089", "story_v_out_410012.awb")

						arg_361_1:RecordAudio("410012089", var_364_9)
						arg_361_1:RecordAudio("410012089", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_410012", "410012089", "story_v_out_410012.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_410012", "410012089", "story_v_out_410012.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_10 and arg_361_1.time_ < var_364_0 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play410012090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410012090
		arg_365_1.duration_ = 2.1

		local var_365_0 = {
			zh = 2.1,
			ja = 2
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
				arg_365_0:Play410012091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10061"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos10061 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10061", 3)

				local var_368_2 = var_368_0.childCount

				for iter_368_0 = 0, var_368_2 - 1 do
					local var_368_3 = var_368_0:GetChild(iter_368_0)

					if var_368_3.name == "split_5" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_4 then
				local var_368_5 = (arg_365_1.time_ - var_368_1) / var_368_4
				local var_368_6 = Vector3.New(0, -517.5, -100)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10061, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_368_7 = arg_365_1.actors_["10061"]
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10061 == nil then
				arg_365_1.var_.actorSpriteComps10061 = var_368_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 0.034

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_9 and not isNil(var_368_7) then
				local var_368_10 = (arg_365_1.time_ - var_368_8) / var_368_9

				if arg_365_1.var_.actorSpriteComps10061 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								local var_368_11 = Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, var_368_10)
								local var_368_12 = Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, var_368_10)
								local var_368_13 = Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, var_368_10)

								iter_368_2.color = Color.New(var_368_11, var_368_12, var_368_13)
							else
								local var_368_14 = Mathf.Lerp(iter_368_2.color.r, 1, var_368_10)

								iter_368_2.color = Color.New(var_368_14, var_368_14, var_368_14)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_8 + var_368_9 and arg_365_1.time_ < var_368_8 + var_368_9 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10061 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_368_4 then
						if arg_365_1.isInRecall_ then
							iter_368_4.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10061 = nil
			end

			local var_368_15 = 0
			local var_368_16 = 0.175

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_17 = arg_365_1:FormatText(StoryNameCfg[591].name)

				arg_365_1.leftNameTxt_.text = var_368_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_18 = arg_365_1:GetWordFromCfg(410012090)
				local var_368_19 = arg_365_1:FormatText(var_368_18.content)

				arg_365_1.text_.text = var_368_19

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_20 = 7
				local var_368_21 = utf8.len(var_368_19)
				local var_368_22 = var_368_20 <= 0 and var_368_16 or var_368_16 * (var_368_21 / var_368_20)

				if var_368_22 > 0 and var_368_16 < var_368_22 then
					arg_365_1.talkMaxDuration = var_368_22

					if var_368_22 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_19
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012090", "story_v_out_410012.awb") ~= 0 then
					local var_368_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012090", "story_v_out_410012.awb") / 1000

					if var_368_23 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_15
					end

					if var_368_18.prefab_name ~= "" and arg_365_1.actors_[var_368_18.prefab_name] ~= nil then
						local var_368_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_18.prefab_name].transform, "story_v_out_410012", "410012090", "story_v_out_410012.awb")

						arg_365_1:RecordAudio("410012090", var_368_24)
						arg_365_1:RecordAudio("410012090", var_368_24)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410012", "410012090", "story_v_out_410012.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410012", "410012090", "story_v_out_410012.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_25 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_25 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_25

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_25 and arg_365_1.time_ < var_368_15 + var_368_25 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play410012091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 410012091
		arg_369_1.duration_ = 3.9

		local var_369_0 = {
			zh = 2.066,
			ja = 3.9
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
				arg_369_0:Play410012092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10061"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10061 == nil then
				arg_369_1.var_.actorSpriteComps10061 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.034

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps10061 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor2.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor2.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor2.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 0.5, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10061 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10061 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.2

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_10 = arg_369_1:FormatText(StoryNameCfg[605].name)

				arg_369_1.leftNameTxt_.text = var_372_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_4")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_11 = arg_369_1:GetWordFromCfg(410012091)
				local var_372_12 = arg_369_1:FormatText(var_372_11.content)

				arg_369_1.text_.text = var_372_12

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 8
				local var_372_14 = utf8.len(var_372_12)
				local var_372_15 = var_372_13 <= 0 and var_372_9 or var_372_9 * (var_372_14 / var_372_13)

				if var_372_15 > 0 and var_372_9 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_12
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012091", "story_v_out_410012.awb") ~= 0 then
					local var_372_16 = manager.audio:GetVoiceLength("story_v_out_410012", "410012091", "story_v_out_410012.awb") / 1000

					if var_372_16 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_16 + var_372_8
					end

					if var_372_11.prefab_name ~= "" and arg_369_1.actors_[var_372_11.prefab_name] ~= nil then
						local var_372_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_11.prefab_name].transform, "story_v_out_410012", "410012091", "story_v_out_410012.awb")

						arg_369_1:RecordAudio("410012091", var_372_17)
						arg_369_1:RecordAudio("410012091", var_372_17)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_410012", "410012091", "story_v_out_410012.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_410012", "410012091", "story_v_out_410012.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_18 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_18 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_18

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_18 and arg_369_1.time_ < var_372_8 + var_372_18 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play410012092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 410012092
		arg_373_1.duration_ = 7.03

		local var_373_0 = {
			zh = 5.466,
			ja = 7.033
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play410012093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10061"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos10061 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10061", 3)

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
				local var_376_6 = Vector3.New(0, -517.5, -100)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10061, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_376_7 = arg_373_1.actors_["10061"]
			local var_376_8 = 0

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps10061 == nil then
				arg_373_1.var_.actorSpriteComps10061 = var_376_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_9 = 0.034

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_9 and not isNil(var_376_7) then
				local var_376_10 = (arg_373_1.time_ - var_376_8) / var_376_9

				if arg_373_1.var_.actorSpriteComps10061 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_376_2 then
							if arg_373_1.isInRecall_ then
								local var_376_11 = Mathf.Lerp(iter_376_2.color.r, arg_373_1.hightColor1.r, var_376_10)
								local var_376_12 = Mathf.Lerp(iter_376_2.color.g, arg_373_1.hightColor1.g, var_376_10)
								local var_376_13 = Mathf.Lerp(iter_376_2.color.b, arg_373_1.hightColor1.b, var_376_10)

								iter_376_2.color = Color.New(var_376_11, var_376_12, var_376_13)
							else
								local var_376_14 = Mathf.Lerp(iter_376_2.color.r, 1, var_376_10)

								iter_376_2.color = Color.New(var_376_14, var_376_14, var_376_14)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_8 + var_376_9 and arg_373_1.time_ < var_376_8 + var_376_9 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps10061 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_376_4 then
						if arg_373_1.isInRecall_ then
							iter_376_4.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10061 = nil
			end

			local var_376_15 = 0
			local var_376_16 = 0.65

			if var_376_15 < arg_373_1.time_ and arg_373_1.time_ <= var_376_15 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_17 = arg_373_1:FormatText(StoryNameCfg[591].name)

				arg_373_1.leftNameTxt_.text = var_376_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_18 = arg_373_1:GetWordFromCfg(410012092)
				local var_376_19 = arg_373_1:FormatText(var_376_18.content)

				arg_373_1.text_.text = var_376_19

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_20 = 26
				local var_376_21 = utf8.len(var_376_19)
				local var_376_22 = var_376_20 <= 0 and var_376_16 or var_376_16 * (var_376_21 / var_376_20)

				if var_376_22 > 0 and var_376_16 < var_376_22 then
					arg_373_1.talkMaxDuration = var_376_22

					if var_376_22 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_22 + var_376_15
					end
				end

				arg_373_1.text_.text = var_376_19
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012092", "story_v_out_410012.awb") ~= 0 then
					local var_376_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012092", "story_v_out_410012.awb") / 1000

					if var_376_23 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_23 + var_376_15
					end

					if var_376_18.prefab_name ~= "" and arg_373_1.actors_[var_376_18.prefab_name] ~= nil then
						local var_376_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_18.prefab_name].transform, "story_v_out_410012", "410012092", "story_v_out_410012.awb")

						arg_373_1:RecordAudio("410012092", var_376_24)
						arg_373_1:RecordAudio("410012092", var_376_24)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_410012", "410012092", "story_v_out_410012.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_410012", "410012092", "story_v_out_410012.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_25 = math.max(var_376_16, arg_373_1.talkMaxDuration)

			if var_376_15 <= arg_373_1.time_ and arg_373_1.time_ < var_376_15 + var_376_25 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_15) / var_376_25

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_15 + var_376_25 and arg_373_1.time_ < var_376_15 + var_376_25 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410012093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 410012093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play410012094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10061"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos10061 = var_380_0.localPosition
				var_380_0.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10061", 7)

				local var_380_2 = var_380_0.childCount

				for iter_380_0 = 0, var_380_2 - 1 do
					local var_380_3 = var_380_0:GetChild(iter_380_0)

					if var_380_3.name == "" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_4 then
				local var_380_5 = (arg_377_1.time_ - var_380_1) / var_380_4
				local var_380_6 = Vector3.New(0, -2000, -100)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10061, var_380_6, var_380_5)
			end

			if arg_377_1.time_ >= var_380_1 + var_380_4 and arg_377_1.time_ < var_380_1 + var_380_4 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_380_7 = arg_377_1.actors_["10061"]
			local var_380_8 = 0

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps10061 == nil then
				arg_377_1.var_.actorSpriteComps10061 = var_380_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_9 = 0.034

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_9 and not isNil(var_380_7) then
				local var_380_10 = (arg_377_1.time_ - var_380_8) / var_380_9

				if arg_377_1.var_.actorSpriteComps10061 then
					for iter_380_1, iter_380_2 in pairs(arg_377_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_380_2 then
							if arg_377_1.isInRecall_ then
								local var_380_11 = Mathf.Lerp(iter_380_2.color.r, arg_377_1.hightColor2.r, var_380_10)
								local var_380_12 = Mathf.Lerp(iter_380_2.color.g, arg_377_1.hightColor2.g, var_380_10)
								local var_380_13 = Mathf.Lerp(iter_380_2.color.b, arg_377_1.hightColor2.b, var_380_10)

								iter_380_2.color = Color.New(var_380_11, var_380_12, var_380_13)
							else
								local var_380_14 = Mathf.Lerp(iter_380_2.color.r, 0.5, var_380_10)

								iter_380_2.color = Color.New(var_380_14, var_380_14, var_380_14)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_8 + var_380_9 and arg_377_1.time_ < var_380_8 + var_380_9 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps10061 then
				for iter_380_3, iter_380_4 in pairs(arg_377_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_380_4 then
						if arg_377_1.isInRecall_ then
							iter_380_4.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10061 = nil
			end

			local var_380_15 = 0
			local var_380_16 = 1

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_17 = arg_377_1:GetWordFromCfg(410012093)
				local var_380_18 = arg_377_1:FormatText(var_380_17.content)

				arg_377_1.text_.text = var_380_18

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_19 = 40
				local var_380_20 = utf8.len(var_380_18)
				local var_380_21 = var_380_19 <= 0 and var_380_16 or var_380_16 * (var_380_20 / var_380_19)

				if var_380_21 > 0 and var_380_16 < var_380_21 then
					arg_377_1.talkMaxDuration = var_380_21

					if var_380_21 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_21 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_18
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_22 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_22 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_22

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_22 and arg_377_1.time_ < var_380_15 + var_380_22 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play410012094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 410012094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play410012095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.85

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(410012094)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 34
				local var_384_5 = utf8.len(var_384_3)
				local var_384_6 = var_384_4 <= 0 and var_384_1 or var_384_1 * (var_384_5 / var_384_4)

				if var_384_6 > 0 and var_384_1 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_7 and arg_381_1.time_ < var_384_0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play410012095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 410012095
		arg_385_1.duration_ = 1.33

		local var_385_0 = {
			zh = 0.999999999999,
			ja = 1.333
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play410012096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 0.05

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_2 = arg_385_1:FormatText(StoryNameCfg[584].name)

				arg_385_1.leftNameTxt_.text = var_388_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1060_split_1_1")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:GetWordFromCfg(410012095)
				local var_388_4 = arg_385_1:FormatText(var_388_3.content)

				arg_385_1.text_.text = var_388_4

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 2
				local var_388_6 = utf8.len(var_388_4)
				local var_388_7 = var_388_5 <= 0 and var_388_1 or var_388_1 * (var_388_6 / var_388_5)

				if var_388_7 > 0 and var_388_1 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_4
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012095", "story_v_out_410012.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_out_410012", "410012095", "story_v_out_410012.awb") / 1000

					if var_388_8 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_0
					end

					if var_388_3.prefab_name ~= "" and arg_385_1.actors_[var_388_3.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_3.prefab_name].transform, "story_v_out_410012", "410012095", "story_v_out_410012.awb")

						arg_385_1:RecordAudio("410012095", var_388_9)
						arg_385_1:RecordAudio("410012095", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_410012", "410012095", "story_v_out_410012.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_410012", "410012095", "story_v_out_410012.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_10 and arg_385_1.time_ < var_388_0 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play410012096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 410012096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play410012097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = "1056"

			if arg_389_1.actors_[var_392_0] == nil then
				local var_392_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_392_1) then
					local var_392_2 = Object.Instantiate(var_392_1, arg_389_1.canvasGo_.transform)

					var_392_2.transform:SetSiblingIndex(1)

					var_392_2.name = var_392_0
					var_392_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_389_1.actors_[var_392_0] = var_392_2

					local var_392_3 = var_392_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_389_1.isInRecall_ then
						for iter_392_0, iter_392_1 in ipairs(var_392_3) do
							iter_392_1.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_392_4 = arg_389_1.actors_["1056"].transform
			local var_392_5 = 0

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.var_.moveOldPos1056 = var_392_4.localPosition
				var_392_4.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1056", 3)

				local var_392_6 = var_392_4.childCount

				for iter_392_2 = 0, var_392_6 - 1 do
					local var_392_7 = var_392_4:GetChild(iter_392_2)

					if var_392_7.name == "split_2" or not string.find(var_392_7.name, "split") then
						var_392_7.gameObject:SetActive(true)
					else
						var_392_7.gameObject:SetActive(false)
					end
				end
			end

			local var_392_8 = 0.001

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_8 then
				local var_392_9 = (arg_389_1.time_ - var_392_5) / var_392_8
				local var_392_10 = Vector3.New(0, -350, -180)

				var_392_4.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1056, var_392_10, var_392_9)
			end

			if arg_389_1.time_ >= var_392_5 + var_392_8 and arg_389_1.time_ < var_392_5 + var_392_8 + arg_392_0 then
				var_392_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_392_11 = arg_389_1.actors_["1056"]
			local var_392_12 = 0

			if var_392_12 < arg_389_1.time_ and arg_389_1.time_ <= var_392_12 + arg_392_0 and not isNil(var_392_11) and arg_389_1.var_.actorSpriteComps1056 == nil then
				arg_389_1.var_.actorSpriteComps1056 = var_392_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_13 = 0.034

			if var_392_12 <= arg_389_1.time_ and arg_389_1.time_ < var_392_12 + var_392_13 and not isNil(var_392_11) then
				local var_392_14 = (arg_389_1.time_ - var_392_12) / var_392_13

				if arg_389_1.var_.actorSpriteComps1056 then
					for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_392_4 then
							if arg_389_1.isInRecall_ then
								local var_392_15 = Mathf.Lerp(iter_392_4.color.r, arg_389_1.hightColor2.r, var_392_14)
								local var_392_16 = Mathf.Lerp(iter_392_4.color.g, arg_389_1.hightColor2.g, var_392_14)
								local var_392_17 = Mathf.Lerp(iter_392_4.color.b, arg_389_1.hightColor2.b, var_392_14)

								iter_392_4.color = Color.New(var_392_15, var_392_16, var_392_17)
							else
								local var_392_18 = Mathf.Lerp(iter_392_4.color.r, 0.5, var_392_14)

								iter_392_4.color = Color.New(var_392_18, var_392_18, var_392_18)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_12 + var_392_13 and arg_389_1.time_ < var_392_12 + var_392_13 + arg_392_0 and not isNil(var_392_11) and arg_389_1.var_.actorSpriteComps1056 then
				for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_392_6 then
						if arg_389_1.isInRecall_ then
							iter_392_6.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1056 = nil
			end

			local var_392_19 = 0
			local var_392_20 = 1.75

			if var_392_19 < arg_389_1.time_ and arg_389_1.time_ <= var_392_19 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_21 = arg_389_1:GetWordFromCfg(410012096)
				local var_392_22 = arg_389_1:FormatText(var_392_21.content)

				arg_389_1.text_.text = var_392_22

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_23 = 70
				local var_392_24 = utf8.len(var_392_22)
				local var_392_25 = var_392_23 <= 0 and var_392_20 or var_392_20 * (var_392_24 / var_392_23)

				if var_392_25 > 0 and var_392_20 < var_392_25 then
					arg_389_1.talkMaxDuration = var_392_25

					if var_392_25 + var_392_19 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_25 + var_392_19
					end
				end

				arg_389_1.text_.text = var_392_22
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_26 = math.max(var_392_20, arg_389_1.talkMaxDuration)

			if var_392_19 <= arg_389_1.time_ and arg_389_1.time_ < var_392_19 + var_392_26 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_19) / var_392_26

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_19 + var_392_26 and arg_389_1.time_ < var_392_19 + var_392_26 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410012097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 410012097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play410012098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1056"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1056 = var_396_0.localPosition
				var_396_0.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1056", 3)

				local var_396_2 = var_396_0.childCount

				for iter_396_0 = 0, var_396_2 - 1 do
					local var_396_3 = var_396_0:GetChild(iter_396_0)

					if var_396_3.name == "" or not string.find(var_396_3.name, "split") then
						var_396_3.gameObject:SetActive(true)
					else
						var_396_3.gameObject:SetActive(false)
					end
				end
			end

			local var_396_4 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_4 then
				local var_396_5 = (arg_393_1.time_ - var_396_1) / var_396_4
				local var_396_6 = Vector3.New(0, -350, -180)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1056, var_396_6, var_396_5)
			end

			if arg_393_1.time_ >= var_396_1 + var_396_4 and arg_393_1.time_ < var_396_1 + var_396_4 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_396_7 = arg_393_1.actors_["1056"]
			local var_396_8 = 0

			if var_396_8 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1056 == nil then
				arg_393_1.var_.actorSpriteComps1056 = var_396_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_9 = 0.034

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_9 and not isNil(var_396_7) then
				local var_396_10 = (arg_393_1.time_ - var_396_8) / var_396_9

				if arg_393_1.var_.actorSpriteComps1056 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_396_2 then
							if arg_393_1.isInRecall_ then
								local var_396_11 = Mathf.Lerp(iter_396_2.color.r, arg_393_1.hightColor2.r, var_396_10)
								local var_396_12 = Mathf.Lerp(iter_396_2.color.g, arg_393_1.hightColor2.g, var_396_10)
								local var_396_13 = Mathf.Lerp(iter_396_2.color.b, arg_393_1.hightColor2.b, var_396_10)

								iter_396_2.color = Color.New(var_396_11, var_396_12, var_396_13)
							else
								local var_396_14 = Mathf.Lerp(iter_396_2.color.r, 0.5, var_396_10)

								iter_396_2.color = Color.New(var_396_14, var_396_14, var_396_14)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_8 + var_396_9 and arg_393_1.time_ < var_396_8 + var_396_9 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1056 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_396_4 then
						if arg_393_1.isInRecall_ then
							iter_396_4.color = arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_396_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1056 = nil
			end

			local var_396_15 = 0
			local var_396_16 = 1.6

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_17 = arg_393_1:GetWordFromCfg(410012097)
				local var_396_18 = arg_393_1:FormatText(var_396_17.content)

				arg_393_1.text_.text = var_396_18

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_19 = 64
				local var_396_20 = utf8.len(var_396_18)
				local var_396_21 = var_396_19 <= 0 and var_396_16 or var_396_16 * (var_396_20 / var_396_19)

				if var_396_21 > 0 and var_396_16 < var_396_21 then
					arg_393_1.talkMaxDuration = var_396_21

					if var_396_21 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_21 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_18
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_22 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_22 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_22

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_22 and arg_393_1.time_ < var_396_15 + var_396_22 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play410012098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 410012098
		arg_397_1.duration_ = 6.47

		local var_397_0 = {
			zh = 4.766,
			ja = 6.466
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
			arg_397_1.auto_ = false
		end

		function arg_397_1.playNext_(arg_399_0)
			arg_397_1.onStoryFinished_()
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1056"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos1056 = var_400_0.localPosition
				var_400_0.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("1056", 3)

				local var_400_2 = var_400_0.childCount

				for iter_400_0 = 0, var_400_2 - 1 do
					local var_400_3 = var_400_0:GetChild(iter_400_0)

					if var_400_3.name == "split_4" or not string.find(var_400_3.name, "split") then
						var_400_3.gameObject:SetActive(true)
					else
						var_400_3.gameObject:SetActive(false)
					end
				end
			end

			local var_400_4 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_4 then
				local var_400_5 = (arg_397_1.time_ - var_400_1) / var_400_4
				local var_400_6 = Vector3.New(0, -350, -180)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1056, var_400_6, var_400_5)
			end

			if arg_397_1.time_ >= var_400_1 + var_400_4 and arg_397_1.time_ < var_400_1 + var_400_4 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_400_7 = arg_397_1.actors_["1056"]
			local var_400_8 = 0

			if var_400_8 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 and not isNil(var_400_7) and arg_397_1.var_.actorSpriteComps1056 == nil then
				arg_397_1.var_.actorSpriteComps1056 = var_400_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_9 = 0.034

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_9 and not isNil(var_400_7) then
				local var_400_10 = (arg_397_1.time_ - var_400_8) / var_400_9

				if arg_397_1.var_.actorSpriteComps1056 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								local var_400_11 = Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, var_400_10)
								local var_400_12 = Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, var_400_10)
								local var_400_13 = Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, var_400_10)

								iter_400_2.color = Color.New(var_400_11, var_400_12, var_400_13)
							else
								local var_400_14 = Mathf.Lerp(iter_400_2.color.r, 1, var_400_10)

								iter_400_2.color = Color.New(var_400_14, var_400_14, var_400_14)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_8 + var_400_9 and arg_397_1.time_ < var_400_8 + var_400_9 + arg_400_0 and not isNil(var_400_7) and arg_397_1.var_.actorSpriteComps1056 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_400_4 then
						if arg_397_1.isInRecall_ then
							iter_400_4.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps1056 = nil
			end

			local var_400_15 = 0
			local var_400_16 = 0.45

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[605].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(410012098)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 18
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410012", "410012098", "story_v_out_410012.awb") ~= 0 then
					local var_400_23 = manager.audio:GetVoiceLength("story_v_out_410012", "410012098", "story_v_out_410012.awb") / 1000

					if var_400_23 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_15
					end

					if var_400_18.prefab_name ~= "" and arg_397_1.actors_[var_400_18.prefab_name] ~= nil then
						local var_400_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_18.prefab_name].transform, "story_v_out_410012", "410012098", "story_v_out_410012.awb")

						arg_397_1:RecordAudio("410012098", var_400_24)
						arg_397_1:RecordAudio("410012098", var_400_24)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_410012", "410012098", "story_v_out_410012.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_410012", "410012098", "story_v_out_410012.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_25 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_25 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_25

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_25 and arg_397_1.time_ < var_400_15 + var_400_25 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L02f",
		"TextureConfig/Background/ST65"
	},
	voices = {
		"story_v_out_410012.awb"
	}
}
