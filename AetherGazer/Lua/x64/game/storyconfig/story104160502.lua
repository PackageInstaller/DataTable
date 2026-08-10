return {
	Play416052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.633333333333333

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I13f"

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
				local var_4_7 = arg_1_1.bgs_.I13f

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
					if iter_4_0 ~= "I13f" then
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

			local var_4_30 = 0.633333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_138", "se_story_138_swordattack", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 2

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(416052001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 80
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
	Play416052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 416052002
		arg_8_1.duration_ = 5.67

		local var_8_0 = {
			zh = 3.9,
			ja = 5.666
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play416052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1086"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

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

			local var_11_4 = arg_8_1.actors_["1086"].transform
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.var_.moveOldPos1086 = var_11_4.localPosition
				var_11_4.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1086", 3)

				local var_11_6 = var_11_4.childCount

				for iter_11_2 = 0, var_11_6 - 1 do
					local var_11_7 = var_11_4:GetChild(iter_11_2)

					if var_11_7.name == "split_6" or not string.find(var_11_7.name, "split") then
						var_11_7.gameObject:SetActive(true)
					else
						var_11_7.gameObject:SetActive(false)
					end
				end
			end

			local var_11_8 = 0.001

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_5) / var_11_8
				local var_11_10 = Vector3.New(0, -404.2, -237.9)

				var_11_4.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1086, var_11_10, var_11_9)
			end

			if arg_8_1.time_ >= var_11_5 + var_11_8 and arg_8_1.time_ < var_11_5 + var_11_8 + arg_11_0 then
				var_11_4.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_11_11 = arg_8_1.actors_["1086"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.actorSpriteComps1086 == nil then
				arg_8_1.var_.actorSpriteComps1086 = var_11_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_13 = 0.125

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.actorSpriteComps1086 then
					for iter_11_3, iter_11_4 in pairs(arg_8_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_11_4 then
							if arg_8_1.isInRecall_ then
								local var_11_15 = Mathf.Lerp(iter_11_4.color.r, arg_8_1.hightColor1.r, var_11_14)
								local var_11_16 = Mathf.Lerp(iter_11_4.color.g, arg_8_1.hightColor1.g, var_11_14)
								local var_11_17 = Mathf.Lerp(iter_11_4.color.b, arg_8_1.hightColor1.b, var_11_14)

								iter_11_4.color = Color.New(var_11_15, var_11_16, var_11_17)
							else
								local var_11_18 = Mathf.Lerp(iter_11_4.color.r, 1, var_11_14)

								iter_11_4.color = Color.New(var_11_18, var_11_18, var_11_18)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.actorSpriteComps1086 then
				for iter_11_5, iter_11_6 in pairs(arg_8_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_11_6 then
						if arg_8_1.isInRecall_ then
							iter_11_6.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1086 = nil
			end

			local var_11_19 = 0
			local var_11_20 = 0.2

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				local var_11_21 = "play"
				local var_11_22 = "music"

				arg_8_1:AudioAction(var_11_21, var_11_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_23 = ""
				local var_11_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_24 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_24 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_24

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_24
						arg_8_1.bgmTxt2_.text = var_11_24
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_25 = 0.4
			local var_11_26 = 0.533333333333333

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				local var_11_27 = "play"
				local var_11_28 = "music"

				arg_8_1:AudioAction(var_11_27, var_11_28, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_11_29 = ""
				local var_11_30 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if var_11_30 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_30 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_30

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_30
						arg_8_1.bgmTxt2_.text = var_11_30
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_31 = 0
			local var_11_32 = 0.4

			if var_11_31 < arg_8_1.time_ and arg_8_1.time_ <= var_11_31 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_33 = arg_8_1:FormatText(StoryNameCfg[1080].name)

				arg_8_1.leftNameTxt_.text = var_11_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_34 = arg_8_1:GetWordFromCfg(416052002)
				local var_11_35 = arg_8_1:FormatText(var_11_34.content)

				arg_8_1.text_.text = var_11_35

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_36 = 16
				local var_11_37 = utf8.len(var_11_35)
				local var_11_38 = var_11_36 <= 0 and var_11_32 or var_11_32 * (var_11_37 / var_11_36)

				if var_11_38 > 0 and var_11_32 < var_11_38 then
					arg_8_1.talkMaxDuration = var_11_38

					if var_11_38 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_38 + var_11_31
					end
				end

				arg_8_1.text_.text = var_11_35
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052002", "story_v_out_416052.awb") ~= 0 then
					local var_11_39 = manager.audio:GetVoiceLength("story_v_out_416052", "416052002", "story_v_out_416052.awb") / 1000

					if var_11_39 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_39 + var_11_31
					end

					if var_11_34.prefab_name ~= "" and arg_8_1.actors_[var_11_34.prefab_name] ~= nil then
						local var_11_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_34.prefab_name].transform, "story_v_out_416052", "416052002", "story_v_out_416052.awb")

						arg_8_1:RecordAudio("416052002", var_11_40)
						arg_8_1:RecordAudio("416052002", var_11_40)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_416052", "416052002", "story_v_out_416052.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_416052", "416052002", "story_v_out_416052.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_41 = math.max(var_11_32, arg_8_1.talkMaxDuration)

			if var_11_31 <= arg_8_1.time_ and arg_8_1.time_ < var_11_31 + var_11_41 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_31) / var_11_41

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_31 + var_11_41 and arg_8_1.time_ < var_11_31 + var_11_41 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416052003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 416052003
		arg_14_1.duration_ = 8.9

		local var_14_0 = {
			zh = 5.733,
			ja = 8.9
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play416052004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1086"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1086 == nil then
				arg_14_1.var_.actorSpriteComps1086 = var_17_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_2 = 0.125

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.actorSpriteComps1086 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								local var_17_4 = Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor2.r, var_17_3)
								local var_17_5 = Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor2.g, var_17_3)
								local var_17_6 = Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor2.b, var_17_3)

								iter_17_1.color = Color.New(var_17_4, var_17_5, var_17_6)
							else
								local var_17_7 = Mathf.Lerp(iter_17_1.color.r, 0.5, var_17_3)

								iter_17_1.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1086 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_17_3 then
						if arg_14_1.isInRecall_ then
							iter_17_3.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1086 = nil
			end

			local var_17_8 = "1028"

			if arg_14_1.actors_[var_17_8] == nil then
				local var_17_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_17_9) then
					local var_17_10 = Object.Instantiate(var_17_9, arg_14_1.canvasGo_.transform)

					var_17_10.transform:SetSiblingIndex(1)

					var_17_10.name = var_17_8
					var_17_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_[var_17_8] = var_17_10

					local var_17_11 = var_17_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_14_1.isInRecall_ then
						for iter_17_4, iter_17_5 in ipairs(var_17_11) do
							iter_17_5.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_12 = arg_14_1.actors_["1028"]
			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1028 == nil then
				arg_14_1.var_.actorSpriteComps1028 = var_17_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_14 = 0.125

			if var_17_13 <= arg_14_1.time_ and arg_14_1.time_ < var_17_13 + var_17_14 and not isNil(var_17_12) then
				local var_17_15 = (arg_14_1.time_ - var_17_13) / var_17_14

				if arg_14_1.var_.actorSpriteComps1028 then
					for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_17_7 then
							if arg_14_1.isInRecall_ then
								local var_17_16 = Mathf.Lerp(iter_17_7.color.r, arg_14_1.hightColor1.r, var_17_15)
								local var_17_17 = Mathf.Lerp(iter_17_7.color.g, arg_14_1.hightColor1.g, var_17_15)
								local var_17_18 = Mathf.Lerp(iter_17_7.color.b, arg_14_1.hightColor1.b, var_17_15)

								iter_17_7.color = Color.New(var_17_16, var_17_17, var_17_18)
							else
								local var_17_19 = Mathf.Lerp(iter_17_7.color.r, 1, var_17_15)

								iter_17_7.color = Color.New(var_17_19, var_17_19, var_17_19)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_13 + var_17_14 and arg_14_1.time_ < var_17_13 + var_17_14 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1028 then
				for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_17_9 then
						if arg_14_1.isInRecall_ then
							iter_17_9.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1028 = nil
			end

			local var_17_20 = arg_14_1.actors_["1086"].transform
			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1.var_.moveOldPos1086 = var_17_20.localPosition
				var_17_20.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1086", 2)

				local var_17_22 = var_17_20.childCount

				for iter_17_10 = 0, var_17_22 - 1 do
					local var_17_23 = var_17_20:GetChild(iter_17_10)

					if var_17_23.name == "" or not string.find(var_17_23.name, "split") then
						var_17_23.gameObject:SetActive(true)
					else
						var_17_23.gameObject:SetActive(false)
					end
				end
			end

			local var_17_24 = 0.001

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_24 then
				local var_17_25 = (arg_14_1.time_ - var_17_21) / var_17_24
				local var_17_26 = Vector3.New(-390, -404.2, -237.9)

				var_17_20.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1086, var_17_26, var_17_25)
			end

			if arg_14_1.time_ >= var_17_21 + var_17_24 and arg_14_1.time_ < var_17_21 + var_17_24 + arg_17_0 then
				var_17_20.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_17_27 = arg_14_1.actors_["1028"].transform
			local var_17_28 = 0

			if var_17_28 < arg_14_1.time_ and arg_14_1.time_ <= var_17_28 + arg_17_0 then
				arg_14_1.var_.moveOldPos1028 = var_17_27.localPosition
				var_17_27.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1028", 4)

				local var_17_29 = var_17_27.childCount

				for iter_17_11 = 0, var_17_29 - 1 do
					local var_17_30 = var_17_27:GetChild(iter_17_11)

					if var_17_30.name == "" or not string.find(var_17_30.name, "split") then
						var_17_30.gameObject:SetActive(true)
					else
						var_17_30.gameObject:SetActive(false)
					end
				end
			end

			local var_17_31 = 0.001

			if var_17_28 <= arg_14_1.time_ and arg_14_1.time_ < var_17_28 + var_17_31 then
				local var_17_32 = (arg_14_1.time_ - var_17_28) / var_17_31
				local var_17_33 = Vector3.New(390, -402.7, -156.1)

				var_17_27.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1028, var_17_33, var_17_32)
			end

			if arg_14_1.time_ >= var_17_28 + var_17_31 and arg_14_1.time_ < var_17_28 + var_17_31 + arg_17_0 then
				var_17_27.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_17_34 = 0
			local var_17_35 = 0.525

			if var_17_34 < arg_14_1.time_ and arg_14_1.time_ <= var_17_34 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_36 = arg_14_1:FormatText(StoryNameCfg[327].name)

				arg_14_1.leftNameTxt_.text = var_17_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_37 = arg_14_1:GetWordFromCfg(416052003)
				local var_17_38 = arg_14_1:FormatText(var_17_37.content)

				arg_14_1.text_.text = var_17_38

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_39 = 21
				local var_17_40 = utf8.len(var_17_38)
				local var_17_41 = var_17_39 <= 0 and var_17_35 or var_17_35 * (var_17_40 / var_17_39)

				if var_17_41 > 0 and var_17_35 < var_17_41 then
					arg_14_1.talkMaxDuration = var_17_41

					if var_17_41 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_41 + var_17_34
					end
				end

				arg_14_1.text_.text = var_17_38
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052003", "story_v_out_416052.awb") ~= 0 then
					local var_17_42 = manager.audio:GetVoiceLength("story_v_out_416052", "416052003", "story_v_out_416052.awb") / 1000

					if var_17_42 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_42 + var_17_34
					end

					if var_17_37.prefab_name ~= "" and arg_14_1.actors_[var_17_37.prefab_name] ~= nil then
						local var_17_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_37.prefab_name].transform, "story_v_out_416052", "416052003", "story_v_out_416052.awb")

						arg_14_1:RecordAudio("416052003", var_17_43)
						arg_14_1:RecordAudio("416052003", var_17_43)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_416052", "416052003", "story_v_out_416052.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_416052", "416052003", "story_v_out_416052.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_44 = math.max(var_17_35, arg_14_1.talkMaxDuration)

			if var_17_34 <= arg_14_1.time_ and arg_14_1.time_ < var_17_34 + var_17_44 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_34) / var_17_44

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_34 + var_17_44 and arg_14_1.time_ < var_17_34 + var_17_44 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play416052004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 416052004
		arg_18_1.duration_ = 6.8

		local var_18_0 = {
			zh = 6.8,
			ja = 6.4
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play416052005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1086"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1086 == nil then
				arg_18_1.var_.actorSpriteComps1086 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.125

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1086 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 1, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1086 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1086 = nil
			end

			local var_21_8 = arg_18_1.actors_["1028"]
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 and not isNil(var_21_8) and arg_18_1.var_.actorSpriteComps1028 == nil then
				arg_18_1.var_.actorSpriteComps1028 = var_21_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_10 = 0.125

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_10 and not isNil(var_21_8) then
				local var_21_11 = (arg_18_1.time_ - var_21_9) / var_21_10

				if arg_18_1.var_.actorSpriteComps1028 then
					for iter_21_4, iter_21_5 in pairs(arg_18_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_21_5 then
							if arg_18_1.isInRecall_ then
								local var_21_12 = Mathf.Lerp(iter_21_5.color.r, arg_18_1.hightColor2.r, var_21_11)
								local var_21_13 = Mathf.Lerp(iter_21_5.color.g, arg_18_1.hightColor2.g, var_21_11)
								local var_21_14 = Mathf.Lerp(iter_21_5.color.b, arg_18_1.hightColor2.b, var_21_11)

								iter_21_5.color = Color.New(var_21_12, var_21_13, var_21_14)
							else
								local var_21_15 = Mathf.Lerp(iter_21_5.color.r, 0.5, var_21_11)

								iter_21_5.color = Color.New(var_21_15, var_21_15, var_21_15)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_9 + var_21_10 and arg_18_1.time_ < var_21_9 + var_21_10 + arg_21_0 and not isNil(var_21_8) and arg_18_1.var_.actorSpriteComps1028 then
				for iter_21_6, iter_21_7 in pairs(arg_18_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_21_7 then
						if arg_18_1.isInRecall_ then
							iter_21_7.color = arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_21_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1028 = nil
			end

			local var_21_16 = 0
			local var_21_17 = 0.6

			if var_21_16 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_18 = arg_18_1:FormatText(StoryNameCfg[1080].name)

				arg_18_1.leftNameTxt_.text = var_21_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_19 = arg_18_1:GetWordFromCfg(416052004)
				local var_21_20 = arg_18_1:FormatText(var_21_19.content)

				arg_18_1.text_.text = var_21_20

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_21 = 24
				local var_21_22 = utf8.len(var_21_20)
				local var_21_23 = var_21_21 <= 0 and var_21_17 or var_21_17 * (var_21_22 / var_21_21)

				if var_21_23 > 0 and var_21_17 < var_21_23 then
					arg_18_1.talkMaxDuration = var_21_23

					if var_21_23 + var_21_16 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_16
					end
				end

				arg_18_1.text_.text = var_21_20
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052004", "story_v_out_416052.awb") ~= 0 then
					local var_21_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052004", "story_v_out_416052.awb") / 1000

					if var_21_24 + var_21_16 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_24 + var_21_16
					end

					if var_21_19.prefab_name ~= "" and arg_18_1.actors_[var_21_19.prefab_name] ~= nil then
						local var_21_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_19.prefab_name].transform, "story_v_out_416052", "416052004", "story_v_out_416052.awb")

						arg_18_1:RecordAudio("416052004", var_21_25)
						arg_18_1:RecordAudio("416052004", var_21_25)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_416052", "416052004", "story_v_out_416052.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_416052", "416052004", "story_v_out_416052.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_26 = math.max(var_21_17, arg_18_1.talkMaxDuration)

			if var_21_16 <= arg_18_1.time_ and arg_18_1.time_ < var_21_16 + var_21_26 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_16) / var_21_26

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_16 + var_21_26 and arg_18_1.time_ < var_21_16 + var_21_26 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play416052005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 416052005
		arg_22_1.duration_ = 5.13

		local var_22_0 = {
			zh = 5.133,
			ja = 3.2
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play416052006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1086"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1086 == nil then
				arg_22_1.var_.actorSpriteComps1086 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.125

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1086 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								local var_25_4 = Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, var_25_3)
								local var_25_5 = Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, var_25_3)
								local var_25_6 = Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, var_25_3)

								iter_25_1.color = Color.New(var_25_4, var_25_5, var_25_6)
							else
								local var_25_7 = Mathf.Lerp(iter_25_1.color.r, 0.5, var_25_3)

								iter_25_1.color = Color.New(var_25_7, var_25_7, var_25_7)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1086 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1086 = nil
			end

			local var_25_8 = arg_22_1.actors_["1028"]
			local var_25_9 = 0

			if var_25_9 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 and not isNil(var_25_8) and arg_22_1.var_.actorSpriteComps1028 == nil then
				arg_22_1.var_.actorSpriteComps1028 = var_25_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_10 = 0.125

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_10 and not isNil(var_25_8) then
				local var_25_11 = (arg_22_1.time_ - var_25_9) / var_25_10

				if arg_22_1.var_.actorSpriteComps1028 then
					for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_25_5 then
							if arg_22_1.isInRecall_ then
								local var_25_12 = Mathf.Lerp(iter_25_5.color.r, arg_22_1.hightColor1.r, var_25_11)
								local var_25_13 = Mathf.Lerp(iter_25_5.color.g, arg_22_1.hightColor1.g, var_25_11)
								local var_25_14 = Mathf.Lerp(iter_25_5.color.b, arg_22_1.hightColor1.b, var_25_11)

								iter_25_5.color = Color.New(var_25_12, var_25_13, var_25_14)
							else
								local var_25_15 = Mathf.Lerp(iter_25_5.color.r, 1, var_25_11)

								iter_25_5.color = Color.New(var_25_15, var_25_15, var_25_15)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_9 + var_25_10 and arg_22_1.time_ < var_25_9 + var_25_10 + arg_25_0 and not isNil(var_25_8) and arg_22_1.var_.actorSpriteComps1028 then
				for iter_25_6, iter_25_7 in pairs(arg_22_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_25_7 then
						if arg_22_1.isInRecall_ then
							iter_25_7.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1028 = nil
			end

			local var_25_16 = 0
			local var_25_17 = 0.225

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_18 = arg_22_1:FormatText(StoryNameCfg[327].name)

				arg_22_1.leftNameTxt_.text = var_25_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_19 = arg_22_1:GetWordFromCfg(416052005)
				local var_25_20 = arg_22_1:FormatText(var_25_19.content)

				arg_22_1.text_.text = var_25_20

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_21 = 9
				local var_25_22 = utf8.len(var_25_20)
				local var_25_23 = var_25_21 <= 0 and var_25_17 or var_25_17 * (var_25_22 / var_25_21)

				if var_25_23 > 0 and var_25_17 < var_25_23 then
					arg_22_1.talkMaxDuration = var_25_23

					if var_25_23 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_23 + var_25_16
					end
				end

				arg_22_1.text_.text = var_25_20
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052005", "story_v_out_416052.awb") ~= 0 then
					local var_25_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052005", "story_v_out_416052.awb") / 1000

					if var_25_24 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_24 + var_25_16
					end

					if var_25_19.prefab_name ~= "" and arg_22_1.actors_[var_25_19.prefab_name] ~= nil then
						local var_25_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_19.prefab_name].transform, "story_v_out_416052", "416052005", "story_v_out_416052.awb")

						arg_22_1:RecordAudio("416052005", var_25_25)
						arg_22_1:RecordAudio("416052005", var_25_25)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_416052", "416052005", "story_v_out_416052.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_416052", "416052005", "story_v_out_416052.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_26 = math.max(var_25_17, arg_22_1.talkMaxDuration)

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_26 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_16) / var_25_26

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_16 + var_25_26 and arg_22_1.time_ < var_25_16 + var_25_26 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play416052006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 416052006
		arg_26_1.duration_ = 6.57

		local var_26_0 = {
			zh = 6.566,
			ja = 5.033
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play416052007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1086"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 == nil then
				arg_26_1.var_.actorSpriteComps1086 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.125

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps1086 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								local var_29_4 = Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, var_29_3)
								local var_29_5 = Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, var_29_3)
								local var_29_6 = Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, var_29_3)

								iter_29_1.color = Color.New(var_29_4, var_29_5, var_29_6)
							else
								local var_29_7 = Mathf.Lerp(iter_29_1.color.r, 1, var_29_3)

								iter_29_1.color = Color.New(var_29_7, var_29_7, var_29_7)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1086 = nil
			end

			local var_29_8 = arg_26_1.actors_["1028"]
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1028 == nil then
				arg_26_1.var_.actorSpriteComps1028 = var_29_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_10 = 0.125

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_10 and not isNil(var_29_8) then
				local var_29_11 = (arg_26_1.time_ - var_29_9) / var_29_10

				if arg_26_1.var_.actorSpriteComps1028 then
					for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_29_5 then
							if arg_26_1.isInRecall_ then
								local var_29_12 = Mathf.Lerp(iter_29_5.color.r, arg_26_1.hightColor2.r, var_29_11)
								local var_29_13 = Mathf.Lerp(iter_29_5.color.g, arg_26_1.hightColor2.g, var_29_11)
								local var_29_14 = Mathf.Lerp(iter_29_5.color.b, arg_26_1.hightColor2.b, var_29_11)

								iter_29_5.color = Color.New(var_29_12, var_29_13, var_29_14)
							else
								local var_29_15 = Mathf.Lerp(iter_29_5.color.r, 0.5, var_29_11)

								iter_29_5.color = Color.New(var_29_15, var_29_15, var_29_15)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_9 + var_29_10 and arg_26_1.time_ < var_29_9 + var_29_10 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1028 then
				for iter_29_6, iter_29_7 in pairs(arg_26_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_29_7 then
						if arg_26_1.isInRecall_ then
							iter_29_7.color = arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_29_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1028 = nil
			end

			local var_29_16 = 0
			local var_29_17 = 0.6

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_18 = arg_26_1:FormatText(StoryNameCfg[1080].name)

				arg_26_1.leftNameTxt_.text = var_29_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_19 = arg_26_1:GetWordFromCfg(416052006)
				local var_29_20 = arg_26_1:FormatText(var_29_19.content)

				arg_26_1.text_.text = var_29_20

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_21 = 24
				local var_29_22 = utf8.len(var_29_20)
				local var_29_23 = var_29_21 <= 0 and var_29_17 or var_29_17 * (var_29_22 / var_29_21)

				if var_29_23 > 0 and var_29_17 < var_29_23 then
					arg_26_1.talkMaxDuration = var_29_23

					if var_29_23 + var_29_16 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_16
					end
				end

				arg_26_1.text_.text = var_29_20
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052006", "story_v_out_416052.awb") ~= 0 then
					local var_29_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052006", "story_v_out_416052.awb") / 1000

					if var_29_24 + var_29_16 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_24 + var_29_16
					end

					if var_29_19.prefab_name ~= "" and arg_26_1.actors_[var_29_19.prefab_name] ~= nil then
						local var_29_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_19.prefab_name].transform, "story_v_out_416052", "416052006", "story_v_out_416052.awb")

						arg_26_1:RecordAudio("416052006", var_29_25)
						arg_26_1:RecordAudio("416052006", var_29_25)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_416052", "416052006", "story_v_out_416052.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_416052", "416052006", "story_v_out_416052.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_26 = math.max(var_29_17, arg_26_1.talkMaxDuration)

			if var_29_16 <= arg_26_1.time_ and arg_26_1.time_ < var_29_16 + var_29_26 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_16) / var_29_26

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_16 + var_29_26 and arg_26_1.time_ < var_29_16 + var_29_26 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play416052007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 416052007
		arg_30_1.duration_ = 7.73

		local var_30_0 = {
			zh = 7.733,
			ja = 7.466
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play416052008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.65

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[1080].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(416052007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 26
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052007", "story_v_out_416052.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052007", "story_v_out_416052.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_416052", "416052007", "story_v_out_416052.awb")

						arg_30_1:RecordAudio("416052007", var_33_9)
						arg_30_1:RecordAudio("416052007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_416052", "416052007", "story_v_out_416052.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_416052", "416052007", "story_v_out_416052.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play416052008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 416052008
		arg_34_1.duration_ = 5.13

		local var_34_0 = {
			zh = 4.633,
			ja = 5.133
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play416052009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1086"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1086 = var_37_0.localPosition
				var_37_0.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1086", 2)

				local var_37_2 = var_37_0.childCount

				for iter_37_0 = 0, var_37_2 - 1 do
					local var_37_3 = var_37_0:GetChild(iter_37_0)

					if var_37_3.name == "split_5" or not string.find(var_37_3.name, "split") then
						var_37_3.gameObject:SetActive(true)
					else
						var_37_3.gameObject:SetActive(false)
					end
				end
			end

			local var_37_4 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_4 then
				local var_37_5 = (arg_34_1.time_ - var_37_1) / var_37_4
				local var_37_6 = Vector3.New(-390, -404.2, -237.9)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1086, var_37_6, var_37_5)
			end

			if arg_34_1.time_ >= var_37_1 + var_37_4 and arg_34_1.time_ < var_37_1 + var_37_4 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_37_7 = 0
			local var_37_8 = 0.65

			if var_37_7 < arg_34_1.time_ and arg_34_1.time_ <= var_37_7 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_9 = arg_34_1:FormatText(StoryNameCfg[1080].name)

				arg_34_1.leftNameTxt_.text = var_37_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_10 = arg_34_1:GetWordFromCfg(416052008)
				local var_37_11 = arg_34_1:FormatText(var_37_10.content)

				arg_34_1.text_.text = var_37_11

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_12 = 26
				local var_37_13 = utf8.len(var_37_11)
				local var_37_14 = var_37_12 <= 0 and var_37_8 or var_37_8 * (var_37_13 / var_37_12)

				if var_37_14 > 0 and var_37_8 < var_37_14 then
					arg_34_1.talkMaxDuration = var_37_14

					if var_37_14 + var_37_7 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_7
					end
				end

				arg_34_1.text_.text = var_37_11
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052008", "story_v_out_416052.awb") ~= 0 then
					local var_37_15 = manager.audio:GetVoiceLength("story_v_out_416052", "416052008", "story_v_out_416052.awb") / 1000

					if var_37_15 + var_37_7 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_15 + var_37_7
					end

					if var_37_10.prefab_name ~= "" and arg_34_1.actors_[var_37_10.prefab_name] ~= nil then
						local var_37_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_10.prefab_name].transform, "story_v_out_416052", "416052008", "story_v_out_416052.awb")

						arg_34_1:RecordAudio("416052008", var_37_16)
						arg_34_1:RecordAudio("416052008", var_37_16)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_416052", "416052008", "story_v_out_416052.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_416052", "416052008", "story_v_out_416052.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_17 = math.max(var_37_8, arg_34_1.talkMaxDuration)

			if var_37_7 <= arg_34_1.time_ and arg_34_1.time_ < var_37_7 + var_37_17 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_7) / var_37_17

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_7 + var_37_17 and arg_34_1.time_ < var_37_7 + var_37_17 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play416052009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 416052009
		arg_38_1.duration_ = 10.07

		local var_38_0 = {
			zh = 6.166,
			ja = 10.066
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play416052010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1086"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1086 == nil then
				arg_38_1.var_.actorSpriteComps1086 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.125

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1086 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor2.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor2.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor2.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 0.5, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1086 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1086 = nil
			end

			local var_41_8 = arg_38_1.actors_["1028"]
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1028 == nil then
				arg_38_1.var_.actorSpriteComps1028 = var_41_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_10 = 0.125

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_10 and not isNil(var_41_8) then
				local var_41_11 = (arg_38_1.time_ - var_41_9) / var_41_10

				if arg_38_1.var_.actorSpriteComps1028 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								local var_41_12 = Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor1.r, var_41_11)
								local var_41_13 = Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor1.g, var_41_11)
								local var_41_14 = Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor1.b, var_41_11)

								iter_41_5.color = Color.New(var_41_12, var_41_13, var_41_14)
							else
								local var_41_15 = Mathf.Lerp(iter_41_5.color.r, 1, var_41_11)

								iter_41_5.color = Color.New(var_41_15, var_41_15, var_41_15)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_9 + var_41_10 and arg_38_1.time_ < var_41_9 + var_41_10 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1028 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_41_7 then
						if arg_38_1.isInRecall_ then
							iter_41_7.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1028 = nil
			end

			local var_41_16 = 0
			local var_41_17 = 1

			if var_41_16 < arg_38_1.time_ and arg_38_1.time_ <= var_41_16 + arg_41_0 then
				local var_41_18 = "play"
				local var_41_19 = "effect"

				arg_38_1:AudioAction(var_41_18, var_41_19, "se_story_138", "se_story_138_clap", "")
			end

			local var_41_20 = 0
			local var_41_21 = 0.325

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_22 = arg_38_1:FormatText(StoryNameCfg[327].name)

				arg_38_1.leftNameTxt_.text = var_41_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_23 = arg_38_1:GetWordFromCfg(416052009)
				local var_41_24 = arg_38_1:FormatText(var_41_23.content)

				arg_38_1.text_.text = var_41_24

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_25 = 13
				local var_41_26 = utf8.len(var_41_24)
				local var_41_27 = var_41_25 <= 0 and var_41_21 or var_41_21 * (var_41_26 / var_41_25)

				if var_41_27 > 0 and var_41_21 < var_41_27 then
					arg_38_1.talkMaxDuration = var_41_27

					if var_41_27 + var_41_20 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_27 + var_41_20
					end
				end

				arg_38_1.text_.text = var_41_24
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052009", "story_v_out_416052.awb") ~= 0 then
					local var_41_28 = manager.audio:GetVoiceLength("story_v_out_416052", "416052009", "story_v_out_416052.awb") / 1000

					if var_41_28 + var_41_20 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_28 + var_41_20
					end

					if var_41_23.prefab_name ~= "" and arg_38_1.actors_[var_41_23.prefab_name] ~= nil then
						local var_41_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_23.prefab_name].transform, "story_v_out_416052", "416052009", "story_v_out_416052.awb")

						arg_38_1:RecordAudio("416052009", var_41_29)
						arg_38_1:RecordAudio("416052009", var_41_29)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_416052", "416052009", "story_v_out_416052.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_416052", "416052009", "story_v_out_416052.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_30 = math.max(var_41_21, arg_38_1.talkMaxDuration)

			if var_41_20 <= arg_38_1.time_ and arg_38_1.time_ < var_41_20 + var_41_30 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_20) / var_41_30

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_20 + var_41_30 and arg_38_1.time_ < var_41_20 + var_41_30 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play416052010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 416052010
		arg_42_1.duration_ = 6.67

		local var_42_0 = {
			zh = 5.433,
			ja = 6.666
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play416052011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1086"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1086 == nil then
				arg_42_1.var_.actorSpriteComps1086 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.125

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1086 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 1, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1086 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1086 = nil
			end

			local var_45_8 = arg_42_1.actors_["1028"]
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1028 == nil then
				arg_42_1.var_.actorSpriteComps1028 = var_45_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_10 = 0.125

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_10 and not isNil(var_45_8) then
				local var_45_11 = (arg_42_1.time_ - var_45_9) / var_45_10

				if arg_42_1.var_.actorSpriteComps1028 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								local var_45_12 = Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, var_45_11)
								local var_45_13 = Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, var_45_11)
								local var_45_14 = Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, var_45_11)

								iter_45_5.color = Color.New(var_45_12, var_45_13, var_45_14)
							else
								local var_45_15 = Mathf.Lerp(iter_45_5.color.r, 0.5, var_45_11)

								iter_45_5.color = Color.New(var_45_15, var_45_15, var_45_15)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_9 + var_45_10 and arg_42_1.time_ < var_45_9 + var_45_10 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1028 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_45_7 then
						if arg_42_1.isInRecall_ then
							iter_45_7.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1028 = nil
			end

			local var_45_16 = 0
			local var_45_17 = 0.45

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_18 = arg_42_1:FormatText(StoryNameCfg[1080].name)

				arg_42_1.leftNameTxt_.text = var_45_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_19 = arg_42_1:GetWordFromCfg(416052010)
				local var_45_20 = arg_42_1:FormatText(var_45_19.content)

				arg_42_1.text_.text = var_45_20

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_21 = 18
				local var_45_22 = utf8.len(var_45_20)
				local var_45_23 = var_45_21 <= 0 and var_45_17 or var_45_17 * (var_45_22 / var_45_21)

				if var_45_23 > 0 and var_45_17 < var_45_23 then
					arg_42_1.talkMaxDuration = var_45_23

					if var_45_23 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_16
					end
				end

				arg_42_1.text_.text = var_45_20
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052010", "story_v_out_416052.awb") ~= 0 then
					local var_45_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052010", "story_v_out_416052.awb") / 1000

					if var_45_24 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_24 + var_45_16
					end

					if var_45_19.prefab_name ~= "" and arg_42_1.actors_[var_45_19.prefab_name] ~= nil then
						local var_45_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_19.prefab_name].transform, "story_v_out_416052", "416052010", "story_v_out_416052.awb")

						arg_42_1:RecordAudio("416052010", var_45_25)
						arg_42_1:RecordAudio("416052010", var_45_25)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_416052", "416052010", "story_v_out_416052.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_416052", "416052010", "story_v_out_416052.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_26 = math.max(var_45_17, arg_42_1.talkMaxDuration)

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_26 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_16) / var_45_26

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_16 + var_45_26 and arg_42_1.time_ < var_45_16 + var_45_26 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play416052011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 416052011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play416052012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1028"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1028 = var_49_0.localPosition
				var_49_0.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1028", 7)

				local var_49_2 = var_49_0.childCount

				for iter_49_0 = 0, var_49_2 - 1 do
					local var_49_3 = var_49_0:GetChild(iter_49_0)

					if var_49_3.name == "" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_4 then
				local var_49_5 = (arg_46_1.time_ - var_49_1) / var_49_4
				local var_49_6 = Vector3.New(0, -2000, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1028, var_49_6, var_49_5)
			end

			if arg_46_1.time_ >= var_49_1 + var_49_4 and arg_46_1.time_ < var_49_1 + var_49_4 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_7 = arg_46_1.actors_["1086"].transform
			local var_49_8 = 0

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.var_.moveOldPos1086 = var_49_7.localPosition
				var_49_7.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1086", 7)

				local var_49_9 = var_49_7.childCount

				for iter_49_1 = 0, var_49_9 - 1 do
					local var_49_10 = var_49_7:GetChild(iter_49_1)

					if var_49_10.name == "" or not string.find(var_49_10.name, "split") then
						var_49_10.gameObject:SetActive(true)
					else
						var_49_10.gameObject:SetActive(false)
					end
				end
			end

			local var_49_11 = 0.001

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_11 then
				local var_49_12 = (arg_46_1.time_ - var_49_8) / var_49_11
				local var_49_13 = Vector3.New(0, -2000, 0)

				var_49_7.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1086, var_49_13, var_49_12)
			end

			if arg_46_1.time_ >= var_49_8 + var_49_11 and arg_46_1.time_ < var_49_8 + var_49_11 + arg_49_0 then
				var_49_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_14 = 0
			local var_49_15 = 1.1

			if var_49_14 < arg_46_1.time_ and arg_46_1.time_ <= var_49_14 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_16 = arg_46_1:GetWordFromCfg(416052011)
				local var_49_17 = arg_46_1:FormatText(var_49_16.content)

				arg_46_1.text_.text = var_49_17

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_18 = 44
				local var_49_19 = utf8.len(var_49_17)
				local var_49_20 = var_49_18 <= 0 and var_49_15 or var_49_15 * (var_49_19 / var_49_18)

				if var_49_20 > 0 and var_49_15 < var_49_20 then
					arg_46_1.talkMaxDuration = var_49_20

					if var_49_20 + var_49_14 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_14
					end
				end

				arg_46_1.text_.text = var_49_17
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_21 = math.max(var_49_15, arg_46_1.talkMaxDuration)

			if var_49_14 <= arg_46_1.time_ and arg_46_1.time_ < var_49_14 + var_49_21 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_14) / var_49_21

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_14 + var_49_21 and arg_46_1.time_ < var_49_14 + var_49_21 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play416052012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 416052012
		arg_50_1.duration_ = 14.9

		local var_50_0 = {
			zh = 8.9,
			ja = 14.9
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play416052013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.825

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[1085].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(416052012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 33
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052012", "story_v_out_416052.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052012", "story_v_out_416052.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_416052", "416052012", "story_v_out_416052.awb")

						arg_50_1:RecordAudio("416052012", var_53_9)
						arg_50_1:RecordAudio("416052012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_416052", "416052012", "story_v_out_416052.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_416052", "416052012", "story_v_out_416052.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play416052013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 416052013
		arg_54_1.duration_ = 8.57

		local var_54_0 = {
			zh = 8.533,
			ja = 8.566
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play416052014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.8

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[1085].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(416052013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 32
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052013", "story_v_out_416052.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052013", "story_v_out_416052.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_416052", "416052013", "story_v_out_416052.awb")

						arg_54_1:RecordAudio("416052013", var_57_9)
						arg_54_1:RecordAudio("416052013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_416052", "416052013", "story_v_out_416052.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_416052", "416052013", "story_v_out_416052.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play416052014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 416052014
		arg_58_1.duration_ = 10.57

		local var_58_0 = {
			zh = 6.5,
			ja = 10.566
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play416052015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.525

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1085].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(416052014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 21
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052014", "story_v_out_416052.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052014", "story_v_out_416052.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_416052", "416052014", "story_v_out_416052.awb")

						arg_58_1:RecordAudio("416052014", var_61_9)
						arg_58_1:RecordAudio("416052014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_416052", "416052014", "story_v_out_416052.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_416052", "416052014", "story_v_out_416052.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play416052015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 416052015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play416052016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.225

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(416052015)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 49
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play416052016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 416052016
		arg_66_1.duration_ = 5.5

		local var_66_0 = {
			zh = 4.166,
			ja = 5.5
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play416052017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1086"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1086 == nil then
				arg_66_1.var_.actorSpriteComps1086 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.125

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps1086 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 0.5, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1086 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1086 = nil
			end

			local var_69_8 = arg_66_1.actors_["1028"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1028 == nil then
				arg_66_1.var_.actorSpriteComps1028 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.125

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps1028 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								local var_69_12 = Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor1.r, var_69_11)
								local var_69_13 = Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor1.g, var_69_11)
								local var_69_14 = Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor1.b, var_69_11)

								iter_69_5.color = Color.New(var_69_12, var_69_13, var_69_14)
							else
								local var_69_15 = Mathf.Lerp(iter_69_5.color.r, 1, var_69_11)

								iter_69_5.color = Color.New(var_69_15, var_69_15, var_69_15)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1028 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1028 = nil
			end

			local var_69_16 = arg_66_1.actors_["1086"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos1086 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1086", 4)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "" or not string.find(var_69_19.name, "split") then
						var_69_19.gameObject:SetActive(true)
					else
						var_69_19.gameObject:SetActive(false)
					end
				end
			end

			local var_69_20 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(390, -404.2, -237.9)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1086, var_69_22, var_69_21)
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_69_23 = arg_66_1.actors_["1028"].transform
			local var_69_24 = 0

			if var_69_24 < arg_66_1.time_ and arg_66_1.time_ <= var_69_24 + arg_69_0 then
				arg_66_1.var_.moveOldPos1028 = var_69_23.localPosition
				var_69_23.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1028", 2)

				local var_69_25 = var_69_23.childCount

				for iter_69_9 = 0, var_69_25 - 1 do
					local var_69_26 = var_69_23:GetChild(iter_69_9)

					if var_69_26.name == "split_2" or not string.find(var_69_26.name, "split") then
						var_69_26.gameObject:SetActive(true)
					else
						var_69_26.gameObject:SetActive(false)
					end
				end
			end

			local var_69_27 = 0.001

			if var_69_24 <= arg_66_1.time_ and arg_66_1.time_ < var_69_24 + var_69_27 then
				local var_69_28 = (arg_66_1.time_ - var_69_24) / var_69_27
				local var_69_29 = Vector3.New(-390, -402.7, -156.1)

				var_69_23.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1028, var_69_29, var_69_28)
			end

			if arg_66_1.time_ >= var_69_24 + var_69_27 and arg_66_1.time_ < var_69_24 + var_69_27 + arg_69_0 then
				var_69_23.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_69_30 = 0
			local var_69_31 = 0.5

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_32 = arg_66_1:FormatText(StoryNameCfg[327].name)

				arg_66_1.leftNameTxt_.text = var_69_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_33 = arg_66_1:GetWordFromCfg(416052016)
				local var_69_34 = arg_66_1:FormatText(var_69_33.content)

				arg_66_1.text_.text = var_69_34

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_35 = 18
				local var_69_36 = utf8.len(var_69_34)
				local var_69_37 = var_69_35 <= 0 and var_69_31 or var_69_31 * (var_69_36 / var_69_35)

				if var_69_37 > 0 and var_69_31 < var_69_37 then
					arg_66_1.talkMaxDuration = var_69_37

					if var_69_37 + var_69_30 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_37 + var_69_30
					end
				end

				arg_66_1.text_.text = var_69_34
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052016", "story_v_out_416052.awb") ~= 0 then
					local var_69_38 = manager.audio:GetVoiceLength("story_v_out_416052", "416052016", "story_v_out_416052.awb") / 1000

					if var_69_38 + var_69_30 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_38 + var_69_30
					end

					if var_69_33.prefab_name ~= "" and arg_66_1.actors_[var_69_33.prefab_name] ~= nil then
						local var_69_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_33.prefab_name].transform, "story_v_out_416052", "416052016", "story_v_out_416052.awb")

						arg_66_1:RecordAudio("416052016", var_69_39)
						arg_66_1:RecordAudio("416052016", var_69_39)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_416052", "416052016", "story_v_out_416052.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_416052", "416052016", "story_v_out_416052.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_40 = math.max(var_69_31, arg_66_1.talkMaxDuration)

			if var_69_30 <= arg_66_1.time_ and arg_66_1.time_ < var_69_30 + var_69_40 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_30) / var_69_40

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_30 + var_69_40 and arg_66_1.time_ < var_69_30 + var_69_40 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play416052017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 416052017
		arg_70_1.duration_ = 9.3

		local var_70_0 = {
			zh = 4.8,
			ja = 9.3
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play416052018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.55

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[327].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(416052017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 22
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052017", "story_v_out_416052.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052017", "story_v_out_416052.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_416052", "416052017", "story_v_out_416052.awb")

						arg_70_1:RecordAudio("416052017", var_73_9)
						arg_70_1:RecordAudio("416052017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_416052", "416052017", "story_v_out_416052.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_416052", "416052017", "story_v_out_416052.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play416052018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 416052018
		arg_74_1.duration_ = 8.93

		local var_74_0 = {
			zh = 6,
			ja = 8.933
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play416052019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1086"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1086 == nil then
				arg_74_1.var_.actorSpriteComps1086 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.125

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1086 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 1, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1086 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1086 = nil
			end

			local var_77_8 = arg_74_1.actors_["1028"]
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps1028 == nil then
				arg_74_1.var_.actorSpriteComps1028 = var_77_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_10 = 0.125

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_10 and not isNil(var_77_8) then
				local var_77_11 = (arg_74_1.time_ - var_77_9) / var_77_10

				if arg_74_1.var_.actorSpriteComps1028 then
					for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_77_5 then
							if arg_74_1.isInRecall_ then
								local var_77_12 = Mathf.Lerp(iter_77_5.color.r, arg_74_1.hightColor2.r, var_77_11)
								local var_77_13 = Mathf.Lerp(iter_77_5.color.g, arg_74_1.hightColor2.g, var_77_11)
								local var_77_14 = Mathf.Lerp(iter_77_5.color.b, arg_74_1.hightColor2.b, var_77_11)

								iter_77_5.color = Color.New(var_77_12, var_77_13, var_77_14)
							else
								local var_77_15 = Mathf.Lerp(iter_77_5.color.r, 0.5, var_77_11)

								iter_77_5.color = Color.New(var_77_15, var_77_15, var_77_15)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_9 + var_77_10 and arg_74_1.time_ < var_77_9 + var_77_10 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps1028 then
				for iter_77_6, iter_77_7 in pairs(arg_74_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_77_7 then
						if arg_74_1.isInRecall_ then
							iter_77_7.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1028 = nil
			end

			local var_77_16 = 0
			local var_77_17 = 0.475

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_18 = arg_74_1:FormatText(StoryNameCfg[1080].name)

				arg_74_1.leftNameTxt_.text = var_77_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_19 = arg_74_1:GetWordFromCfg(416052018)
				local var_77_20 = arg_74_1:FormatText(var_77_19.content)

				arg_74_1.text_.text = var_77_20

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_21 = 19
				local var_77_22 = utf8.len(var_77_20)
				local var_77_23 = var_77_21 <= 0 and var_77_17 or var_77_17 * (var_77_22 / var_77_21)

				if var_77_23 > 0 and var_77_17 < var_77_23 then
					arg_74_1.talkMaxDuration = var_77_23

					if var_77_23 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_16
					end
				end

				arg_74_1.text_.text = var_77_20
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052018", "story_v_out_416052.awb") ~= 0 then
					local var_77_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052018", "story_v_out_416052.awb") / 1000

					if var_77_24 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_24 + var_77_16
					end

					if var_77_19.prefab_name ~= "" and arg_74_1.actors_[var_77_19.prefab_name] ~= nil then
						local var_77_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_19.prefab_name].transform, "story_v_out_416052", "416052018", "story_v_out_416052.awb")

						arg_74_1:RecordAudio("416052018", var_77_25)
						arg_74_1:RecordAudio("416052018", var_77_25)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_416052", "416052018", "story_v_out_416052.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_416052", "416052018", "story_v_out_416052.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_26 = math.max(var_77_17, arg_74_1.talkMaxDuration)

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_26 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_16) / var_77_26

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_16 + var_77_26 and arg_74_1.time_ < var_77_16 + var_77_26 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play416052019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 416052019
		arg_78_1.duration_ = 8.17

		local var_78_0 = {
			zh = 8.166,
			ja = 6.8
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play416052020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.725

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1080].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(416052019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 29
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052019", "story_v_out_416052.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052019", "story_v_out_416052.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_416052", "416052019", "story_v_out_416052.awb")

						arg_78_1:RecordAudio("416052019", var_81_9)
						arg_78_1:RecordAudio("416052019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_416052", "416052019", "story_v_out_416052.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_416052", "416052019", "story_v_out_416052.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play416052020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 416052020
		arg_82_1.duration_ = 4.7

		local var_82_0 = {
			zh = 3.266,
			ja = 4.7
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play416052021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1086"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1086 == nil then
				arg_82_1.var_.actorSpriteComps1086 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.125

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1086 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 0.5, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1086 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1086 = nil
			end

			local var_85_8 = arg_82_1.actors_["1028"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps1028 == nil then
				arg_82_1.var_.actorSpriteComps1028 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.125

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps1028 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor1.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor1.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor1.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 1, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps1028 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1028 = nil
			end

			local var_85_16 = arg_82_1.actors_["1028"].transform
			local var_85_17 = 0

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.var_.moveOldPos1028 = var_85_16.localPosition
				var_85_16.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1028", 2)

				local var_85_18 = var_85_16.childCount

				for iter_85_8 = 0, var_85_18 - 1 do
					local var_85_19 = var_85_16:GetChild(iter_85_8)

					if var_85_19.name == "" or not string.find(var_85_19.name, "split") then
						var_85_19.gameObject:SetActive(true)
					else
						var_85_19.gameObject:SetActive(false)
					end
				end
			end

			local var_85_20 = 0.001

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_20 then
				local var_85_21 = (arg_82_1.time_ - var_85_17) / var_85_20
				local var_85_22 = Vector3.New(-390, -402.7, -156.1)

				var_85_16.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1028, var_85_22, var_85_21)
			end

			if arg_82_1.time_ >= var_85_17 + var_85_20 and arg_82_1.time_ < var_85_17 + var_85_20 + arg_85_0 then
				var_85_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_85_23 = 0
			local var_85_24 = 0.35

			if var_85_23 < arg_82_1.time_ and arg_82_1.time_ <= var_85_23 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_25 = arg_82_1:FormatText(StoryNameCfg[327].name)

				arg_82_1.leftNameTxt_.text = var_85_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_26 = arg_82_1:GetWordFromCfg(416052020)
				local var_85_27 = arg_82_1:FormatText(var_85_26.content)

				arg_82_1.text_.text = var_85_27

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_28 = 14
				local var_85_29 = utf8.len(var_85_27)
				local var_85_30 = var_85_28 <= 0 and var_85_24 or var_85_24 * (var_85_29 / var_85_28)

				if var_85_30 > 0 and var_85_24 < var_85_30 then
					arg_82_1.talkMaxDuration = var_85_30

					if var_85_30 + var_85_23 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_30 + var_85_23
					end
				end

				arg_82_1.text_.text = var_85_27
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052020", "story_v_out_416052.awb") ~= 0 then
					local var_85_31 = manager.audio:GetVoiceLength("story_v_out_416052", "416052020", "story_v_out_416052.awb") / 1000

					if var_85_31 + var_85_23 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_31 + var_85_23
					end

					if var_85_26.prefab_name ~= "" and arg_82_1.actors_[var_85_26.prefab_name] ~= nil then
						local var_85_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_26.prefab_name].transform, "story_v_out_416052", "416052020", "story_v_out_416052.awb")

						arg_82_1:RecordAudio("416052020", var_85_32)
						arg_82_1:RecordAudio("416052020", var_85_32)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_416052", "416052020", "story_v_out_416052.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_416052", "416052020", "story_v_out_416052.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_33 = math.max(var_85_24, arg_82_1.talkMaxDuration)

			if var_85_23 <= arg_82_1.time_ and arg_82_1.time_ < var_85_23 + var_85_33 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_23) / var_85_33

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_23 + var_85_33 and arg_82_1.time_ < var_85_23 + var_85_33 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play416052021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 416052021
		arg_86_1.duration_ = 7

		local var_86_0 = {
			zh = 5.366,
			ja = 7
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play416052022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1086"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1086 == nil then
				arg_86_1.var_.actorSpriteComps1086 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.125

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps1086 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1086 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1086 = nil
			end

			local var_89_8 = arg_86_1.actors_["1028"]
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1028 == nil then
				arg_86_1.var_.actorSpriteComps1028 = var_89_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_10 = 0.125

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 and not isNil(var_89_8) then
				local var_89_11 = (arg_86_1.time_ - var_89_9) / var_89_10

				if arg_86_1.var_.actorSpriteComps1028 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								local var_89_12 = Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor2.r, var_89_11)
								local var_89_13 = Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor2.g, var_89_11)
								local var_89_14 = Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor2.b, var_89_11)

								iter_89_5.color = Color.New(var_89_12, var_89_13, var_89_14)
							else
								local var_89_15 = Mathf.Lerp(iter_89_5.color.r, 0.5, var_89_11)

								iter_89_5.color = Color.New(var_89_15, var_89_15, var_89_15)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1028 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_89_7 then
						if arg_86_1.isInRecall_ then
							iter_89_7.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1028 = nil
			end

			local var_89_16 = arg_86_1.actors_["1086"].transform
			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.var_.moveOldPos1086 = var_89_16.localPosition
				var_89_16.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1086", 4)

				local var_89_18 = var_89_16.childCount

				for iter_89_8 = 0, var_89_18 - 1 do
					local var_89_19 = var_89_16:GetChild(iter_89_8)

					if var_89_19.name == "split_6" or not string.find(var_89_19.name, "split") then
						var_89_19.gameObject:SetActive(true)
					else
						var_89_19.gameObject:SetActive(false)
					end
				end
			end

			local var_89_20 = 0.001

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_20 then
				local var_89_21 = (arg_86_1.time_ - var_89_17) / var_89_20
				local var_89_22 = Vector3.New(390, -404.2, -237.9)

				var_89_16.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1086, var_89_22, var_89_21)
			end

			if arg_86_1.time_ >= var_89_17 + var_89_20 and arg_86_1.time_ < var_89_17 + var_89_20 + arg_89_0 then
				var_89_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_89_23 = 0
			local var_89_24 = 0.625

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_25 = arg_86_1:FormatText(StoryNameCfg[1080].name)

				arg_86_1.leftNameTxt_.text = var_89_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_26 = arg_86_1:GetWordFromCfg(416052021)
				local var_89_27 = arg_86_1:FormatText(var_89_26.content)

				arg_86_1.text_.text = var_89_27

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_28 = 25
				local var_89_29 = utf8.len(var_89_27)
				local var_89_30 = var_89_28 <= 0 and var_89_24 or var_89_24 * (var_89_29 / var_89_28)

				if var_89_30 > 0 and var_89_24 < var_89_30 then
					arg_86_1.talkMaxDuration = var_89_30

					if var_89_30 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_30 + var_89_23
					end
				end

				arg_86_1.text_.text = var_89_27
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052021", "story_v_out_416052.awb") ~= 0 then
					local var_89_31 = manager.audio:GetVoiceLength("story_v_out_416052", "416052021", "story_v_out_416052.awb") / 1000

					if var_89_31 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_31 + var_89_23
					end

					if var_89_26.prefab_name ~= "" and arg_86_1.actors_[var_89_26.prefab_name] ~= nil then
						local var_89_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_26.prefab_name].transform, "story_v_out_416052", "416052021", "story_v_out_416052.awb")

						arg_86_1:RecordAudio("416052021", var_89_32)
						arg_86_1:RecordAudio("416052021", var_89_32)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_416052", "416052021", "story_v_out_416052.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_416052", "416052021", "story_v_out_416052.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = math.max(var_89_24, arg_86_1.talkMaxDuration)

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_33 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_23) / var_89_33

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_23 + var_89_33 and arg_86_1.time_ < var_89_23 + var_89_33 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416052022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 416052022
		arg_90_1.duration_ = 5

		local var_90_0 = {
			zh = 5,
			ja = 4.166
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play416052023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1086"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1086 == nil then
				arg_90_1.var_.actorSpriteComps1086 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.125

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1086 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1086 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1086 = nil
			end

			local var_93_8 = arg_90_1.actors_["1028"]
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps1028 == nil then
				arg_90_1.var_.actorSpriteComps1028 = var_93_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_10 = 0.125

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_10 and not isNil(var_93_8) then
				local var_93_11 = (arg_90_1.time_ - var_93_9) / var_93_10

				if arg_90_1.var_.actorSpriteComps1028 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								local var_93_12 = Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor1.r, var_93_11)
								local var_93_13 = Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor1.g, var_93_11)
								local var_93_14 = Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor1.b, var_93_11)

								iter_93_5.color = Color.New(var_93_12, var_93_13, var_93_14)
							else
								local var_93_15 = Mathf.Lerp(iter_93_5.color.r, 1, var_93_11)

								iter_93_5.color = Color.New(var_93_15, var_93_15, var_93_15)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_9 + var_93_10 and arg_90_1.time_ < var_93_9 + var_93_10 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps1028 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_93_7 then
						if arg_90_1.isInRecall_ then
							iter_93_7.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1028 = nil
			end

			local var_93_16 = 0
			local var_93_17 = 0.45

			if var_93_16 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_18 = arg_90_1:FormatText(StoryNameCfg[327].name)

				arg_90_1.leftNameTxt_.text = var_93_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_19 = arg_90_1:GetWordFromCfg(416052022)
				local var_93_20 = arg_90_1:FormatText(var_93_19.content)

				arg_90_1.text_.text = var_93_20

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_21 = 18
				local var_93_22 = utf8.len(var_93_20)
				local var_93_23 = var_93_21 <= 0 and var_93_17 or var_93_17 * (var_93_22 / var_93_21)

				if var_93_23 > 0 and var_93_17 < var_93_23 then
					arg_90_1.talkMaxDuration = var_93_23

					if var_93_23 + var_93_16 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_16
					end
				end

				arg_90_1.text_.text = var_93_20
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052022", "story_v_out_416052.awb") ~= 0 then
					local var_93_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052022", "story_v_out_416052.awb") / 1000

					if var_93_24 + var_93_16 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_24 + var_93_16
					end

					if var_93_19.prefab_name ~= "" and arg_90_1.actors_[var_93_19.prefab_name] ~= nil then
						local var_93_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_19.prefab_name].transform, "story_v_out_416052", "416052022", "story_v_out_416052.awb")

						arg_90_1:RecordAudio("416052022", var_93_25)
						arg_90_1:RecordAudio("416052022", var_93_25)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_416052", "416052022", "story_v_out_416052.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_416052", "416052022", "story_v_out_416052.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_26 = math.max(var_93_17, arg_90_1.talkMaxDuration)

			if var_93_16 <= arg_90_1.time_ and arg_90_1.time_ < var_93_16 + var_93_26 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_16) / var_93_26

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_16 + var_93_26 and arg_90_1.time_ < var_93_16 + var_93_26 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play416052023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 416052023
		arg_94_1.duration_ = 6.2

		local var_94_0 = {
			zh = 3.7,
			ja = 6.2
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play416052024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.475

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[327].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(416052023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 19
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052023", "story_v_out_416052.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_416052", "416052023", "story_v_out_416052.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_416052", "416052023", "story_v_out_416052.awb")

						arg_94_1:RecordAudio("416052023", var_97_9)
						arg_94_1:RecordAudio("416052023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_416052", "416052023", "story_v_out_416052.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_416052", "416052023", "story_v_out_416052.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play416052024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 416052024
		arg_98_1.duration_ = 5.93

		local var_98_0 = {
			zh = 5.933,
			ja = 5.666
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play416052025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1086"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1086 == nil then
				arg_98_1.var_.actorSpriteComps1086 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.125

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps1086 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 1, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1086 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1086 = nil
			end

			local var_101_8 = arg_98_1.actors_["1028"]
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.actorSpriteComps1028 == nil then
				arg_98_1.var_.actorSpriteComps1028 = var_101_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_10 = 0.125

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_10 and not isNil(var_101_8) then
				local var_101_11 = (arg_98_1.time_ - var_101_9) / var_101_10

				if arg_98_1.var_.actorSpriteComps1028 then
					for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_101_5 then
							if arg_98_1.isInRecall_ then
								local var_101_12 = Mathf.Lerp(iter_101_5.color.r, arg_98_1.hightColor2.r, var_101_11)
								local var_101_13 = Mathf.Lerp(iter_101_5.color.g, arg_98_1.hightColor2.g, var_101_11)
								local var_101_14 = Mathf.Lerp(iter_101_5.color.b, arg_98_1.hightColor2.b, var_101_11)

								iter_101_5.color = Color.New(var_101_12, var_101_13, var_101_14)
							else
								local var_101_15 = Mathf.Lerp(iter_101_5.color.r, 0.5, var_101_11)

								iter_101_5.color = Color.New(var_101_15, var_101_15, var_101_15)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_9 + var_101_10 and arg_98_1.time_ < var_101_9 + var_101_10 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.actorSpriteComps1028 then
				for iter_101_6, iter_101_7 in pairs(arg_98_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_101_7 then
						if arg_98_1.isInRecall_ then
							iter_101_7.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1028 = nil
			end

			local var_101_16 = 0
			local var_101_17 = 0.7

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_18 = arg_98_1:FormatText(StoryNameCfg[1080].name)

				arg_98_1.leftNameTxt_.text = var_101_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(416052024)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 28
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_17 or var_101_17 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_17 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23

					if var_101_23 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_16
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052024", "story_v_out_416052.awb") ~= 0 then
					local var_101_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052024", "story_v_out_416052.awb") / 1000

					if var_101_24 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_16
					end

					if var_101_19.prefab_name ~= "" and arg_98_1.actors_[var_101_19.prefab_name] ~= nil then
						local var_101_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_19.prefab_name].transform, "story_v_out_416052", "416052024", "story_v_out_416052.awb")

						arg_98_1:RecordAudio("416052024", var_101_25)
						arg_98_1:RecordAudio("416052024", var_101_25)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_416052", "416052024", "story_v_out_416052.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_416052", "416052024", "story_v_out_416052.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_26 = math.max(var_101_17, arg_98_1.talkMaxDuration)

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_26 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_16) / var_101_26

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_16 + var_101_26 and arg_98_1.time_ < var_101_16 + var_101_26 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play416052025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 416052025
		arg_102_1.duration_ = 8.6

		local var_102_0 = {
			zh = 6.3,
			ja = 8.6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play416052026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1086"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1086 == nil then
				arg_102_1.var_.actorSpriteComps1086 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.125

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps1086 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1086 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1086 = nil
			end

			local var_105_8 = arg_102_1.actors_["1028"]
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps1028 == nil then
				arg_102_1.var_.actorSpriteComps1028 = var_105_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_10 = 0.125

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 and not isNil(var_105_8) then
				local var_105_11 = (arg_102_1.time_ - var_105_9) / var_105_10

				if arg_102_1.var_.actorSpriteComps1028 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								local var_105_12 = Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor1.r, var_105_11)
								local var_105_13 = Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor1.g, var_105_11)
								local var_105_14 = Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor1.b, var_105_11)

								iter_105_5.color = Color.New(var_105_12, var_105_13, var_105_14)
							else
								local var_105_15 = Mathf.Lerp(iter_105_5.color.r, 1, var_105_11)

								iter_105_5.color = Color.New(var_105_15, var_105_15, var_105_15)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps1028 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_105_7 then
						if arg_102_1.isInRecall_ then
							iter_105_7.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1028 = nil
			end

			local var_105_16 = 0
			local var_105_17 = 0.725

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_18 = arg_102_1:FormatText(StoryNameCfg[327].name)

				arg_102_1.leftNameTxt_.text = var_105_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_19 = arg_102_1:GetWordFromCfg(416052025)
				local var_105_20 = arg_102_1:FormatText(var_105_19.content)

				arg_102_1.text_.text = var_105_20

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_21 = 29
				local var_105_22 = utf8.len(var_105_20)
				local var_105_23 = var_105_21 <= 0 and var_105_17 or var_105_17 * (var_105_22 / var_105_21)

				if var_105_23 > 0 and var_105_17 < var_105_23 then
					arg_102_1.talkMaxDuration = var_105_23

					if var_105_23 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_16
					end
				end

				arg_102_1.text_.text = var_105_20
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052025", "story_v_out_416052.awb") ~= 0 then
					local var_105_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052025", "story_v_out_416052.awb") / 1000

					if var_105_24 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_16
					end

					if var_105_19.prefab_name ~= "" and arg_102_1.actors_[var_105_19.prefab_name] ~= nil then
						local var_105_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_19.prefab_name].transform, "story_v_out_416052", "416052025", "story_v_out_416052.awb")

						arg_102_1:RecordAudio("416052025", var_105_25)
						arg_102_1:RecordAudio("416052025", var_105_25)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_416052", "416052025", "story_v_out_416052.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_416052", "416052025", "story_v_out_416052.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_26 = math.max(var_105_17, arg_102_1.talkMaxDuration)

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_26 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_16) / var_105_26

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_16 + var_105_26 and arg_102_1.time_ < var_105_16 + var_105_26 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play416052026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 416052026
		arg_106_1.duration_ = 8.57

		local var_106_0 = {
			zh = 7.2,
			ja = 8.566
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play416052027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1086"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1086 == nil then
				arg_106_1.var_.actorSpriteComps1086 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.125

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps1086 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1086 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1086 = nil
			end

			local var_109_8 = arg_106_1.actors_["1028"]
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps1028 == nil then
				arg_106_1.var_.actorSpriteComps1028 = var_109_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_10 = 0.125

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_10 and not isNil(var_109_8) then
				local var_109_11 = (arg_106_1.time_ - var_109_9) / var_109_10

				if arg_106_1.var_.actorSpriteComps1028 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								local var_109_12 = Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, var_109_11)
								local var_109_13 = Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, var_109_11)
								local var_109_14 = Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, var_109_11)

								iter_109_5.color = Color.New(var_109_12, var_109_13, var_109_14)
							else
								local var_109_15 = Mathf.Lerp(iter_109_5.color.r, 0.5, var_109_11)

								iter_109_5.color = Color.New(var_109_15, var_109_15, var_109_15)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_9 + var_109_10 and arg_106_1.time_ < var_109_9 + var_109_10 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps1028 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_109_7 then
						if arg_106_1.isInRecall_ then
							iter_109_7.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1028 = nil
			end

			local var_109_16 = arg_106_1.actors_["1086"].transform
			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.var_.moveOldPos1086 = var_109_16.localPosition
				var_109_16.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("1086", 4)

				local var_109_18 = var_109_16.childCount

				for iter_109_8 = 0, var_109_18 - 1 do
					local var_109_19 = var_109_16:GetChild(iter_109_8)

					if var_109_19.name == "split_1" or not string.find(var_109_19.name, "split") then
						var_109_19.gameObject:SetActive(true)
					else
						var_109_19.gameObject:SetActive(false)
					end
				end
			end

			local var_109_20 = 0.001

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_20 then
				local var_109_21 = (arg_106_1.time_ - var_109_17) / var_109_20
				local var_109_22 = Vector3.New(390, -404.2, -237.9)

				var_109_16.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1086, var_109_22, var_109_21)
			end

			if arg_106_1.time_ >= var_109_17 + var_109_20 and arg_106_1.time_ < var_109_17 + var_109_20 + arg_109_0 then
				var_109_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_109_23 = 0
			local var_109_24 = 0.775

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_25 = arg_106_1:FormatText(StoryNameCfg[1080].name)

				arg_106_1.leftNameTxt_.text = var_109_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(416052026)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 31
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_24 or var_109_24 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_24 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30

					if var_109_30 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_23
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052026", "story_v_out_416052.awb") ~= 0 then
					local var_109_31 = manager.audio:GetVoiceLength("story_v_out_416052", "416052026", "story_v_out_416052.awb") / 1000

					if var_109_31 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_31 + var_109_23
					end

					if var_109_26.prefab_name ~= "" and arg_106_1.actors_[var_109_26.prefab_name] ~= nil then
						local var_109_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_26.prefab_name].transform, "story_v_out_416052", "416052026", "story_v_out_416052.awb")

						arg_106_1:RecordAudio("416052026", var_109_32)
						arg_106_1:RecordAudio("416052026", var_109_32)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_416052", "416052026", "story_v_out_416052.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_416052", "416052026", "story_v_out_416052.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_33 = math.max(var_109_24, arg_106_1.talkMaxDuration)

			if var_109_23 <= arg_106_1.time_ and arg_106_1.time_ < var_109_23 + var_109_33 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_23) / var_109_33

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_23 + var_109_33 and arg_106_1.time_ < var_109_23 + var_109_33 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416052027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 416052027
		arg_110_1.duration_ = 6.73

		local var_110_0 = {
			zh = 5.2,
			ja = 6.733
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play416052028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1086"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1086 == nil then
				arg_110_1.var_.actorSpriteComps1086 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.125

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps1086 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 0.5, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1086 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1086 = nil
			end

			local var_113_8 = arg_110_1.actors_["1028"]
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps1028 == nil then
				arg_110_1.var_.actorSpriteComps1028 = var_113_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_10 = 0.125

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 and not isNil(var_113_8) then
				local var_113_11 = (arg_110_1.time_ - var_113_9) / var_113_10

				if arg_110_1.var_.actorSpriteComps1028 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								local var_113_12 = Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor1.r, var_113_11)
								local var_113_13 = Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor1.g, var_113_11)
								local var_113_14 = Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor1.b, var_113_11)

								iter_113_5.color = Color.New(var_113_12, var_113_13, var_113_14)
							else
								local var_113_15 = Mathf.Lerp(iter_113_5.color.r, 1, var_113_11)

								iter_113_5.color = Color.New(var_113_15, var_113_15, var_113_15)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps1028 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_113_7 then
						if arg_110_1.isInRecall_ then
							iter_113_7.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1028 = nil
			end

			local var_113_16 = 0
			local var_113_17 = 0.5

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_18 = arg_110_1:FormatText(StoryNameCfg[327].name)

				arg_110_1.leftNameTxt_.text = var_113_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_19 = arg_110_1:GetWordFromCfg(416052027)
				local var_113_20 = arg_110_1:FormatText(var_113_19.content)

				arg_110_1.text_.text = var_113_20

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_21 = 20
				local var_113_22 = utf8.len(var_113_20)
				local var_113_23 = var_113_21 <= 0 and var_113_17 or var_113_17 * (var_113_22 / var_113_21)

				if var_113_23 > 0 and var_113_17 < var_113_23 then
					arg_110_1.talkMaxDuration = var_113_23

					if var_113_23 + var_113_16 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_16
					end
				end

				arg_110_1.text_.text = var_113_20
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052027", "story_v_out_416052.awb") ~= 0 then
					local var_113_24 = manager.audio:GetVoiceLength("story_v_out_416052", "416052027", "story_v_out_416052.awb") / 1000

					if var_113_24 + var_113_16 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_24 + var_113_16
					end

					if var_113_19.prefab_name ~= "" and arg_110_1.actors_[var_113_19.prefab_name] ~= nil then
						local var_113_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_19.prefab_name].transform, "story_v_out_416052", "416052027", "story_v_out_416052.awb")

						arg_110_1:RecordAudio("416052027", var_113_25)
						arg_110_1:RecordAudio("416052027", var_113_25)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_416052", "416052027", "story_v_out_416052.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_416052", "416052027", "story_v_out_416052.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_26 = math.max(var_113_17, arg_110_1.talkMaxDuration)

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_26 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_16) / var_113_26

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_16 + var_113_26 and arg_110_1.time_ < var_113_16 + var_113_26 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play416052028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 416052028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play416052029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1028"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1028 = var_117_0.localPosition
				var_117_0.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("1028", 7)

				local var_117_2 = var_117_0.childCount

				for iter_117_0 = 0, var_117_2 - 1 do
					local var_117_3 = var_117_0:GetChild(iter_117_0)

					if var_117_3.name == "" or not string.find(var_117_3.name, "split") then
						var_117_3.gameObject:SetActive(true)
					else
						var_117_3.gameObject:SetActive(false)
					end
				end
			end

			local var_117_4 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_4 then
				local var_117_5 = (arg_114_1.time_ - var_117_1) / var_117_4
				local var_117_6 = Vector3.New(0, -2000, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1028, var_117_6, var_117_5)
			end

			if arg_114_1.time_ >= var_117_1 + var_117_4 and arg_114_1.time_ < var_117_1 + var_117_4 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_7 = arg_114_1.actors_["1086"].transform
			local var_117_8 = 0

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.var_.moveOldPos1086 = var_117_7.localPosition
				var_117_7.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("1086", 7)

				local var_117_9 = var_117_7.childCount

				for iter_117_1 = 0, var_117_9 - 1 do
					local var_117_10 = var_117_7:GetChild(iter_117_1)

					if var_117_10.name == "" or not string.find(var_117_10.name, "split") then
						var_117_10.gameObject:SetActive(true)
					else
						var_117_10.gameObject:SetActive(false)
					end
				end
			end

			local var_117_11 = 0.001

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_11 then
				local var_117_12 = (arg_114_1.time_ - var_117_8) / var_117_11
				local var_117_13 = Vector3.New(0, -2000, 0)

				var_117_7.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1086, var_117_13, var_117_12)
			end

			if arg_114_1.time_ >= var_117_8 + var_117_11 and arg_114_1.time_ < var_117_8 + var_117_11 + arg_117_0 then
				var_117_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_14 = 0.833333333333333
			local var_117_15 = 0.2

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				local var_117_16 = "play"
				local var_117_17 = "effect"

				arg_114_1:AudioAction(var_117_16, var_117_17, "se_story_120_04", "se_story_120_04_punch_hit", "")
			end

			local var_117_18 = 0
			local var_117_19 = 0.2

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				local var_117_20 = "play"
				local var_117_21 = "music"

				arg_114_1:AudioAction(var_117_20, var_117_21, "ui_battle", "ui_battle_stopbgm", "")

				local var_117_22 = ""
				local var_117_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_117_23 ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_23 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_23

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_23
						arg_114_1.bgmTxt2_.text = var_117_23
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_117_24 = 0
			local var_117_25 = 1.25

			if var_117_24 < arg_114_1.time_ and arg_114_1.time_ <= var_117_24 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_26 = arg_114_1:GetWordFromCfg(416052028)
				local var_117_27 = arg_114_1:FormatText(var_117_26.content)

				arg_114_1.text_.text = var_117_27

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_28 = 50
				local var_117_29 = utf8.len(var_117_27)
				local var_117_30 = var_117_28 <= 0 and var_117_25 or var_117_25 * (var_117_29 / var_117_28)

				if var_117_30 > 0 and var_117_25 < var_117_30 then
					arg_114_1.talkMaxDuration = var_117_30

					if var_117_30 + var_117_24 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_30 + var_117_24
					end
				end

				arg_114_1.text_.text = var_117_27
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_31 = math.max(var_117_25, arg_114_1.talkMaxDuration)

			if var_117_24 <= arg_114_1.time_ and arg_114_1.time_ < var_117_24 + var_117_31 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_24) / var_117_31

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_24 + var_117_31 and arg_114_1.time_ < var_117_24 + var_117_31 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416052029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416052029
		arg_119_1.duration_ = 11.2

		local var_119_0 = {
			zh = 5.833,
			ja = 11.2
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
				arg_119_0:Play416052030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "1148"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(var_122_1, arg_119_1.canvasGo_.transform)

					var_122_2.transform:SetSiblingIndex(1)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_119_1.isInRecall_ then
						for iter_122_0, iter_122_1 in ipairs(var_122_3) do
							iter_122_1.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_122_4 = arg_119_1.actors_["1148"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.actorSpriteComps1148 == nil then
				arg_119_1.var_.actorSpriteComps1148 = var_122_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_6 = 0.125

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.actorSpriteComps1148 then
					for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_122_3 then
							if arg_119_1.isInRecall_ then
								local var_122_8 = Mathf.Lerp(iter_122_3.color.r, arg_119_1.hightColor1.r, var_122_7)
								local var_122_9 = Mathf.Lerp(iter_122_3.color.g, arg_119_1.hightColor1.g, var_122_7)
								local var_122_10 = Mathf.Lerp(iter_122_3.color.b, arg_119_1.hightColor1.b, var_122_7)

								iter_122_3.color = Color.New(var_122_8, var_122_9, var_122_10)
							else
								local var_122_11 = Mathf.Lerp(iter_122_3.color.r, 1, var_122_7)

								iter_122_3.color = Color.New(var_122_11, var_122_11, var_122_11)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.actorSpriteComps1148 then
				for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_122_5 then
						if arg_119_1.isInRecall_ then
							iter_122_5.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1148 = nil
			end

			local var_122_12 = arg_119_1.actors_["1148"].transform
			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.var_.moveOldPos1148 = var_122_12.localPosition
				var_122_12.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1148", 3)

				local var_122_14 = var_122_12.childCount

				for iter_122_6 = 0, var_122_14 - 1 do
					local var_122_15 = var_122_12:GetChild(iter_122_6)

					if var_122_15.name == "split_3" or not string.find(var_122_15.name, "split") then
						var_122_15.gameObject:SetActive(true)
					else
						var_122_15.gameObject:SetActive(false)
					end
				end
			end

			local var_122_16 = 0.001

			if var_122_13 <= arg_119_1.time_ and arg_119_1.time_ < var_122_13 + var_122_16 then
				local var_122_17 = (arg_119_1.time_ - var_122_13) / var_122_16
				local var_122_18 = Vector3.New(33.4, -430.8, 6.9)

				var_122_12.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1148, var_122_18, var_122_17)
			end

			if arg_119_1.time_ >= var_122_13 + var_122_16 and arg_119_1.time_ < var_122_13 + var_122_16 + arg_122_0 then
				var_122_12.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_122_19 = 0
			local var_122_20 = 0.55

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_21 = arg_119_1:FormatText(StoryNameCfg[8].name)

				arg_119_1.leftNameTxt_.text = var_122_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_22 = arg_119_1:GetWordFromCfg(416052029)
				local var_122_23 = arg_119_1:FormatText(var_122_22.content)

				arg_119_1.text_.text = var_122_23

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_24 = 22
				local var_122_25 = utf8.len(var_122_23)
				local var_122_26 = var_122_24 <= 0 and var_122_20 or var_122_20 * (var_122_25 / var_122_24)

				if var_122_26 > 0 and var_122_20 < var_122_26 then
					arg_119_1.talkMaxDuration = var_122_26

					if var_122_26 + var_122_19 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_26 + var_122_19
					end
				end

				arg_119_1.text_.text = var_122_23
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052029", "story_v_out_416052.awb") ~= 0 then
					local var_122_27 = manager.audio:GetVoiceLength("story_v_out_416052", "416052029", "story_v_out_416052.awb") / 1000

					if var_122_27 + var_122_19 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_19
					end

					if var_122_22.prefab_name ~= "" and arg_119_1.actors_[var_122_22.prefab_name] ~= nil then
						local var_122_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_22.prefab_name].transform, "story_v_out_416052", "416052029", "story_v_out_416052.awb")

						arg_119_1:RecordAudio("416052029", var_122_28)
						arg_119_1:RecordAudio("416052029", var_122_28)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416052", "416052029", "story_v_out_416052.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416052", "416052029", "story_v_out_416052.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_29 = math.max(var_122_20, arg_119_1.talkMaxDuration)

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_29 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_19) / var_122_29

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_19 + var_122_29 and arg_119_1.time_ < var_122_19 + var_122_29 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416052030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416052030
		arg_123_1.duration_ = 2.8

		local var_123_0 = {
			zh = 2.8,
			ja = 2.2
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
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1148"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1148 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1148", 3)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "split_4" or not string.find(var_126_3.name, "split") then
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

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1148, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_126_7 = 0
			local var_126_8 = 0.125

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_9 = arg_123_1:FormatText(StoryNameCfg[8].name)

				arg_123_1.leftNameTxt_.text = var_126_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(416052030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 5
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_8 or var_126_8 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_8 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416052", "416052030", "story_v_out_416052.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_416052", "416052030", "story_v_out_416052.awb") / 1000

					if var_126_15 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_7
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_416052", "416052030", "story_v_out_416052.awb")

						arg_123_1:RecordAudio("416052030", var_126_16)
						arg_123_1:RecordAudio("416052030", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416052", "416052030", "story_v_out_416052.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416052", "416052030", "story_v_out_416052.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_17 and arg_123_1.time_ < var_126_7 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	assets = {
		"TextureConfig/Background/I13f"
	},
	voices = {
		"story_v_out_416052.awb"
	}
}
