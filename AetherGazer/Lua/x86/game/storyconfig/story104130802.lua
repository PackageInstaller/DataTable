return {
	Play413082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413082001
		arg_1_1.duration_ = 10.77

		local var_1_0 = {
			zh = 10.766,
			ja = 6.366
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F08i"

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
				local var_4_5 = arg_1_1.bgs_.F08i

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
					if iter_4_0 ~= "F08i" then
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
			local var_4_25 = 0.266666666666667

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

			local var_4_30 = 0.366666666666667
			local var_4_31 = 0.833333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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
			local var_4_37 = 0.3

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(413082001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082001", "story_v_out_413082.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_413082", "413082001", "story_v_out_413082.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_413082", "413082001", "story_v_out_413082.awb")

						arg_1_1:RecordAudio("413082001", var_4_46)
						arg_1_1:RecordAudio("413082001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413082", "413082001", "story_v_out_413082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413082", "413082001", "story_v_out_413082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

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
	Play413082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_123_02", "se_story_123_02_Vine", "")
			end

			local var_12_4 = 0.2
			local var_12_5 = 1

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				local var_12_6 = "play"
				local var_12_7 = "effect"

				arg_9_1:AudioAction(var_12_6, var_12_7, "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_12_8 = 0
			local var_12_9 = 1.575

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(413082002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 63
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_9 or var_12_9 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_9 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_15 and arg_9_1.time_ < var_12_8 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413082003
		arg_13_1.duration_ = 3.87

		local var_13_0 = {
			zh = 3.066,
			ja = 3.866
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
				arg_13_0:Play413082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10022"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

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

			local var_16_4 = arg_13_1.actors_["10022"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 3)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_6" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(0, -315, -320)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_16_11 = arg_13_1.actors_["10022"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 2

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_19 = arg_13_1.actors_["10022"]
			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				local var_16_21 = var_16_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_21 then
					arg_13_1.var_.alphaOldValue10022 = var_16_21.alpha
					arg_13_1.var_.characterEffect10022 = var_16_21
				end

				arg_13_1.var_.alphaOldValue10022 = 0
			end

			local var_16_22 = 0.5

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_20) / var_16_22
				local var_16_24 = Mathf.Lerp(arg_13_1.var_.alphaOldValue10022, 1, var_16_23)

				if arg_13_1.var_.characterEffect10022 then
					arg_13_1.var_.characterEffect10022.alpha = var_16_24
				end
			end

			if arg_13_1.time_ >= var_16_20 + var_16_22 and arg_13_1.time_ < var_16_20 + var_16_22 + arg_16_0 and arg_13_1.var_.characterEffect10022 then
				arg_13_1.var_.characterEffect10022.alpha = 1
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_25 = 0.3
			local var_16_26 = 0.3

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_27 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_27:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_28 = arg_13_1:FormatText(StoryNameCfg[614].name)

				arg_13_1.leftNameTxt_.text = var_16_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_29 = arg_13_1:GetWordFromCfg(413082003)
				local var_16_30 = arg_13_1:FormatText(var_16_29.content)

				arg_13_1.text_.text = var_16_30

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_31 = 12
				local var_16_32 = utf8.len(var_16_30)
				local var_16_33 = var_16_31 <= 0 and var_16_26 or var_16_26 * (var_16_32 / var_16_31)

				if var_16_33 > 0 and var_16_26 < var_16_33 then
					arg_13_1.talkMaxDuration = var_16_33
					var_16_25 = var_16_25 + 0.3

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_30
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082003", "story_v_out_413082.awb") ~= 0 then
					local var_16_34 = manager.audio:GetVoiceLength("story_v_out_413082", "413082003", "story_v_out_413082.awb") / 1000

					if var_16_34 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_25
					end

					if var_16_29.prefab_name ~= "" and arg_13_1.actors_[var_16_29.prefab_name] ~= nil then
						local var_16_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_29.prefab_name].transform, "story_v_out_413082", "413082003", "story_v_out_413082.awb")

						arg_13_1:RecordAudio("413082003", var_16_35)
						arg_13_1:RecordAudio("413082003", var_16_35)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413082", "413082003", "story_v_out_413082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413082", "413082003", "story_v_out_413082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_36 = var_16_25 + 0.3
			local var_16_37 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_36 <= arg_13_1.time_ and arg_13_1.time_ < var_16_36 + var_16_37 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_36) / var_16_37

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_36 + var_16_37 and arg_13_1.time_ < var_16_36 + var_16_37 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413082004
		arg_19_1.duration_ = 5.57

		local var_19_0 = {
			zh = 5.566,
			ja = 5.5
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play413082005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.625

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[614].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(413082004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 25
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082004", "story_v_out_413082.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082004", "story_v_out_413082.awb") / 1000

					if var_22_8 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_413082", "413082004", "story_v_out_413082.awb")

						arg_19_1:RecordAudio("413082004", var_22_9)
						arg_19_1:RecordAudio("413082004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413082", "413082004", "story_v_out_413082.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413082", "413082004", "story_v_out_413082.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_10 and arg_19_1.time_ < var_22_0 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play413082005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413082005
		arg_23_1.duration_ = 5.43

		local var_23_0 = {
			zh = 3.033,
			ja = 5.433
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413082006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.35

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[614].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_3 = arg_23_1:GetWordFromCfg(413082005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 14
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082005", "story_v_out_413082.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082005", "story_v_out_413082.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_413082", "413082005", "story_v_out_413082.awb")

						arg_23_1:RecordAudio("413082005", var_26_9)
						arg_23_1:RecordAudio("413082005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413082", "413082005", "story_v_out_413082.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413082", "413082005", "story_v_out_413082.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_10 and arg_23_1.time_ < var_26_0 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413082006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413082006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play413082007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10022"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos10022 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10022", 0)

				local var_30_2 = var_30_0.childCount

				for iter_30_0 = 0, var_30_2 - 1 do
					local var_30_3 = var_30_0:GetChild(iter_30_0)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_4 then
				local var_30_5 = (arg_27_1.time_ - var_30_1) / var_30_4
				local var_30_6 = Vector3.New(-5000, -315, -320)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10022, var_30_6, var_30_5)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_4 and arg_27_1.time_ < var_30_1 + var_30_4 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_30_7 = arg_27_1.actors_["10022"]
			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.actorSpriteComps10022 == nil then
				arg_27_1.var_.actorSpriteComps10022 = var_30_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_9 = 2

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 and not isNil(var_30_7) then
				local var_30_10 = (arg_27_1.time_ - var_30_8) / var_30_9

				if arg_27_1.var_.actorSpriteComps10022 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								local var_30_11 = Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor2.r, var_30_10)
								local var_30_12 = Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor2.g, var_30_10)
								local var_30_13 = Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor2.b, var_30_10)

								iter_30_2.color = Color.New(var_30_11, var_30_12, var_30_13)
							else
								local var_30_14 = Mathf.Lerp(iter_30_2.color.r, 0.5, var_30_10)

								iter_30_2.color = Color.New(var_30_14, var_30_14, var_30_14)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.actorSpriteComps10022 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_30_4 then
						if arg_27_1.isInRecall_ then
							iter_30_4.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10022 = nil
			end

			local var_30_15 = 0
			local var_30_16 = 1.55

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_17 = arg_27_1:GetWordFromCfg(413082006)
				local var_30_18 = arg_27_1:FormatText(var_30_17.content)

				arg_27_1.text_.text = var_30_18

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_19 = 62
				local var_30_20 = utf8.len(var_30_18)
				local var_30_21 = var_30_19 <= 0 and var_30_16 or var_30_16 * (var_30_20 / var_30_19)

				if var_30_21 > 0 and var_30_16 < var_30_21 then
					arg_27_1.talkMaxDuration = var_30_21

					if var_30_21 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_21 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_18
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_22 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_22 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_22

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_22 and arg_27_1.time_ < var_30_15 + var_30_22 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play413082007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413082007
		arg_31_1.duration_ = 6.1

		local var_31_0 = {
			zh = 4.266,
			ja = 6.1
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
				arg_31_0:Play413082008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10022"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10022 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10022", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "split_8" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(0, -315, -320)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10022, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_34_7 = arg_31_1.actors_["10022"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = var_34_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_9 = 2

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 and not isNil(var_34_7) then
				local var_34_10 = (arg_31_1.time_ - var_34_8) / var_34_9

				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_4 then
						if arg_31_1.isInRecall_ then
							iter_34_4.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_15 = 0
			local var_34_16 = 0.6

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[614].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(413082007)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082007", "story_v_out_413082.awb") ~= 0 then
					local var_34_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082007", "story_v_out_413082.awb") / 1000

					if var_34_23 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_15
					end

					if var_34_18.prefab_name ~= "" and arg_31_1.actors_[var_34_18.prefab_name] ~= nil then
						local var_34_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_18.prefab_name].transform, "story_v_out_413082", "413082007", "story_v_out_413082.awb")

						arg_31_1:RecordAudio("413082007", var_34_24)
						arg_31_1:RecordAudio("413082007", var_34_24)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413082", "413082007", "story_v_out_413082.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413082", "413082007", "story_v_out_413082.awb")
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
				actorName = "10022",
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
	Play413082008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413082008
		arg_35_1.duration_ = 6.6

		local var_35_0 = {
			zh = 3.4,
			ja = 6.6
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413082009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.45

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[614].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(413082008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082008", "story_v_out_413082.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082008", "story_v_out_413082.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_413082", "413082008", "story_v_out_413082.awb")

						arg_35_1:RecordAudio("413082008", var_38_9)
						arg_35_1:RecordAudio("413082008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413082", "413082008", "story_v_out_413082.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413082", "413082008", "story_v_out_413082.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play413082009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413082009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413082010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10022"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos10022 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10022", 0)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(-5000, -315, -320)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10022, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_42_7 = arg_39_1.actors_["10022"]
			local var_42_8 = 0

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 and not isNil(var_42_7) and arg_39_1.var_.actorSpriteComps10022 == nil then
				arg_39_1.var_.actorSpriteComps10022 = var_42_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_9 = 2

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_9 and not isNil(var_42_7) then
				local var_42_10 = (arg_39_1.time_ - var_42_8) / var_42_9

				if arg_39_1.var_.actorSpriteComps10022 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								local var_42_11 = Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor2.r, var_42_10)
								local var_42_12 = Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor2.g, var_42_10)
								local var_42_13 = Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor2.b, var_42_10)

								iter_42_2.color = Color.New(var_42_11, var_42_12, var_42_13)
							else
								local var_42_14 = Mathf.Lerp(iter_42_2.color.r, 0.5, var_42_10)

								iter_42_2.color = Color.New(var_42_14, var_42_14, var_42_14)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_8 + var_42_9 and arg_39_1.time_ < var_42_8 + var_42_9 + arg_42_0 and not isNil(var_42_7) and arg_39_1.var_.actorSpriteComps10022 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_42_4 then
						if arg_39_1.isInRecall_ then
							iter_42_4.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10022 = nil
			end

			local var_42_15 = 0
			local var_42_16 = 1.225

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_17 = arg_39_1:GetWordFromCfg(413082009)
				local var_42_18 = arg_39_1:FormatText(var_42_17.content)

				arg_39_1.text_.text = var_42_18

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 49
				local var_42_20 = utf8.len(var_42_18)
				local var_42_21 = var_42_19 <= 0 and var_42_16 or var_42_16 * (var_42_20 / var_42_19)

				if var_42_21 > 0 and var_42_16 < var_42_21 then
					arg_39_1.talkMaxDuration = var_42_21

					if var_42_21 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_21 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_18
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_22 and arg_39_1.time_ < var_42_15 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413082010
		arg_43_1.duration_ = 9.1

		local var_43_0 = {
			zh = 9.1,
			ja = 5.966
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
				arg_43_0:Play413082011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "10096"

			if arg_43_1.actors_[var_46_0] == nil then
				local var_46_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_46_1) then
					local var_46_2 = Object.Instantiate(var_46_1, arg_43_1.canvasGo_.transform)

					var_46_2.transform:SetSiblingIndex(1)

					var_46_2.name = var_46_0
					var_46_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_0] = var_46_2

					local var_46_3 = var_46_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs(var_46_3) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_4 = arg_43_1.actors_["10096"].transform
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.var_.moveOldPos10096 = var_46_4.localPosition
				var_46_4.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10096", 7)

				local var_46_6 = var_46_4.childCount

				for iter_46_2 = 0, var_46_6 - 1 do
					local var_46_7 = var_46_4:GetChild(iter_46_2)

					if var_46_7.name == "" or not string.find(var_46_7.name, "split") then
						var_46_7.gameObject:SetActive(true)
					else
						var_46_7.gameObject:SetActive(false)
					end
				end
			end

			local var_46_8 = 0.001

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_8 then
				local var_46_9 = (arg_43_1.time_ - var_46_5) / var_46_8
				local var_46_10 = Vector3.New(0, -2000, -180)

				var_46_4.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10096, var_46_10, var_46_9)
			end

			if arg_43_1.time_ >= var_46_5 + var_46_8 and arg_43_1.time_ < var_46_5 + var_46_8 + arg_46_0 then
				var_46_4.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_46_11 = arg_43_1.actors_["10096"]
			local var_46_12 = 0

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10096 == nil then
				arg_43_1.var_.actorSpriteComps10096 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_13 = 2

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_13 and not isNil(var_46_11) then
				local var_46_14 = (arg_43_1.time_ - var_46_12) / var_46_13

				if arg_43_1.var_.actorSpriteComps10096 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								local var_46_15 = Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, var_46_14)
								local var_46_16 = Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, var_46_14)
								local var_46_17 = Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, var_46_14)

								iter_46_4.color = Color.New(var_46_15, var_46_16, var_46_17)
							else
								local var_46_18 = Mathf.Lerp(iter_46_4.color.r, 1, var_46_14)

								iter_46_4.color = Color.New(var_46_18, var_46_18, var_46_18)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_12 + var_46_13 and arg_43_1.time_ < var_46_12 + var_46_13 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10096 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_46_6 then
						if arg_43_1.isInRecall_ then
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10096 = nil
			end

			local var_46_19 = 0
			local var_46_20 = 0.3

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_21 = arg_43_1:FormatText(StoryNameCfg[36].name)

				arg_43_1.leftNameTxt_.text = var_46_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_6")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_22 = arg_43_1:GetWordFromCfg(413082010)
				local var_46_23 = arg_43_1:FormatText(var_46_22.content)

				arg_43_1.text_.text = var_46_23

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_24 = 12
				local var_46_25 = utf8.len(var_46_23)
				local var_46_26 = var_46_24 <= 0 and var_46_20 or var_46_20 * (var_46_25 / var_46_24)

				if var_46_26 > 0 and var_46_20 < var_46_26 then
					arg_43_1.talkMaxDuration = var_46_26

					if var_46_26 + var_46_19 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_26 + var_46_19
					end
				end

				arg_43_1.text_.text = var_46_23
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082010", "story_v_out_413082.awb") ~= 0 then
					local var_46_27 = manager.audio:GetVoiceLength("story_v_out_413082", "413082010", "story_v_out_413082.awb") / 1000

					if var_46_27 + var_46_19 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_27 + var_46_19
					end

					if var_46_22.prefab_name ~= "" and arg_43_1.actors_[var_46_22.prefab_name] ~= nil then
						local var_46_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_22.prefab_name].transform, "story_v_out_413082", "413082010", "story_v_out_413082.awb")

						arg_43_1:RecordAudio("413082010", var_46_28)
						arg_43_1:RecordAudio("413082010", var_46_28)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413082", "413082010", "story_v_out_413082.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413082", "413082010", "story_v_out_413082.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_29 = math.max(var_46_20, arg_43_1.talkMaxDuration)

			if var_46_19 <= arg_43_1.time_ and arg_43_1.time_ < var_46_19 + var_46_29 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_19) / var_46_29

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_19 + var_46_29 and arg_43_1.time_ < var_46_19 + var_46_29 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413082011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413082011
		arg_47_1.duration_ = 7.3

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413082012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.25

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[36].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(413082011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 10
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082011", "story_v_out_413082.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082011", "story_v_out_413082.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_413082", "413082011", "story_v_out_413082.awb")

						arg_47_1:RecordAudio("413082011", var_50_9)
						arg_47_1:RecordAudio("413082011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413082", "413082011", "story_v_out_413082.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413082", "413082011", "story_v_out_413082.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play413082012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413082012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413082013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10096"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos10096 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10096", 0)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(-1500, -350, -180)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10096, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_54_7 = arg_51_1.actors_["10096"]
			local var_54_8 = 0

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps10096 == nil then
				arg_51_1.var_.actorSpriteComps10096 = var_54_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 2

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 and not isNil(var_54_7) then
				local var_54_10 = (arg_51_1.time_ - var_54_8) / var_54_9

				if arg_51_1.var_.actorSpriteComps10096 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								local var_54_11 = Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor2.r, var_54_10)
								local var_54_12 = Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor2.g, var_54_10)
								local var_54_13 = Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor2.b, var_54_10)

								iter_54_2.color = Color.New(var_54_11, var_54_12, var_54_13)
							else
								local var_54_14 = Mathf.Lerp(iter_54_2.color.r, 0.5, var_54_10)

								iter_54_2.color = Color.New(var_54_14, var_54_14, var_54_14)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps10096 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_54_4 then
						if arg_51_1.isInRecall_ then
							iter_54_4.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10096 = nil
			end

			local var_54_15 = 0
			local var_54_16 = 1.25

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_17 = arg_51_1:GetWordFromCfg(413082012)
				local var_54_18 = arg_51_1:FormatText(var_54_17.content)

				arg_51_1.text_.text = var_54_18

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 50
				local var_54_20 = utf8.len(var_54_18)
				local var_54_21 = var_54_19 <= 0 and var_54_16 or var_54_16 * (var_54_20 / var_54_19)

				if var_54_21 > 0 and var_54_16 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_18
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_22 and arg_51_1.time_ < var_54_15 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play413082013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413082013
		arg_55_1.duration_ = 5.83

		local var_55_0 = {
			zh = 5.833,
			ja = 5.7
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413082014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10022"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 3)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "split_6" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(0, -315, -320)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_58_7 = arg_55_1.actors_["10022"]
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.actorSpriteComps10022 == nil then
				arg_55_1.var_.actorSpriteComps10022 = var_58_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 and not isNil(var_58_7) then
				local var_58_10 = (arg_55_1.time_ - var_58_8) / var_58_9

				if arg_55_1.var_.actorSpriteComps10022 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								local var_58_11 = Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, var_58_10)
								local var_58_12 = Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, var_58_10)
								local var_58_13 = Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, var_58_10)

								iter_58_2.color = Color.New(var_58_11, var_58_12, var_58_13)
							else
								local var_58_14 = Mathf.Lerp(iter_58_2.color.r, 1, var_58_10)

								iter_58_2.color = Color.New(var_58_14, var_58_14, var_58_14)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.actorSpriteComps10022 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_58_4 then
						if arg_55_1.isInRecall_ then
							iter_58_4.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10022 = nil
			end

			local var_58_15 = 0
			local var_58_16 = 0.725

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[614].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(413082013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082013", "story_v_out_413082.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082013", "story_v_out_413082.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_413082", "413082013", "story_v_out_413082.awb")

						arg_55_1:RecordAudio("413082013", var_58_24)
						arg_55_1:RecordAudio("413082013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413082", "413082013", "story_v_out_413082.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413082", "413082013", "story_v_out_413082.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413082014
		arg_59_1.duration_ = 8.37

		local var_59_0 = {
			zh = 8.366,
			ja = 4.8
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
				arg_59_0:Play413082015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10022"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10022 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10022", 7)

				local var_62_2 = var_62_0.childCount

				for iter_62_0 = 0, var_62_2 - 1 do
					local var_62_3 = var_62_0:GetChild(iter_62_0)

					if var_62_3.name == "" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_4 then
				local var_62_5 = (arg_59_1.time_ - var_62_1) / var_62_4
				local var_62_6 = Vector3.New(0, -2000, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10022, var_62_6, var_62_5)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_4 and arg_59_1.time_ < var_62_1 + var_62_4 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_7 = 0
			local var_62_8 = 0.2

			if var_62_7 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_9 = arg_59_1:FormatText(StoryNameCfg[36].name)

				arg_59_1.leftNameTxt_.text = var_62_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_10 = arg_59_1:GetWordFromCfg(413082014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 8
				local var_62_13 = utf8.len(var_62_11)
				local var_62_14 = var_62_12 <= 0 and var_62_8 or var_62_8 * (var_62_13 / var_62_12)

				if var_62_14 > 0 and var_62_8 < var_62_14 then
					arg_59_1.talkMaxDuration = var_62_14

					if var_62_14 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082014", "story_v_out_413082.awb") ~= 0 then
					local var_62_15 = manager.audio:GetVoiceLength("story_v_out_413082", "413082014", "story_v_out_413082.awb") / 1000

					if var_62_15 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_7
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_413082", "413082014", "story_v_out_413082.awb")

						arg_59_1:RecordAudio("413082014", var_62_16)
						arg_59_1:RecordAudio("413082014", var_62_16)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413082", "413082014", "story_v_out_413082.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413082", "413082014", "story_v_out_413082.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_17 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_17 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_7) / var_62_17

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_7 + var_62_17 and arg_59_1.time_ < var_62_7 + var_62_17 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413082015
		arg_63_1.duration_ = 3.73

		local var_63_0 = {
			zh = 3.166,
			ja = 3.733
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
				arg_63_0:Play413082016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10022"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps10022 == nil then
				arg_63_1.var_.actorSpriteComps10022 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps10022 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps10022 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10022 = nil
			end

			local var_66_8 = arg_63_1.actors_["10096"]
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10096 == nil then
				arg_63_1.var_.actorSpriteComps10096 = var_66_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_10 = 2

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 and not isNil(var_66_8) then
				local var_66_11 = (arg_63_1.time_ - var_66_9) / var_66_10

				if arg_63_1.var_.actorSpriteComps10096 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								local var_66_12 = Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, var_66_11)
								local var_66_13 = Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, var_66_11)
								local var_66_14 = Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, var_66_11)

								iter_66_5.color = Color.New(var_66_12, var_66_13, var_66_14)
							else
								local var_66_15 = Mathf.Lerp(iter_66_5.color.r, 0.5, var_66_11)

								iter_66_5.color = Color.New(var_66_15, var_66_15, var_66_15)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10096 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_66_7 then
						if arg_63_1.isInRecall_ then
							iter_66_7.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10096 = nil
			end

			local var_66_16 = arg_63_1.actors_["10022"].transform
			local var_66_17 = 0

			if var_66_17 < arg_63_1.time_ and arg_63_1.time_ <= var_66_17 + arg_66_0 then
				arg_63_1.var_.moveOldPos10022 = var_66_16.localPosition
				var_66_16.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10022", 3)

				local var_66_18 = var_66_16.childCount

				for iter_66_8 = 0, var_66_18 - 1 do
					local var_66_19 = var_66_16:GetChild(iter_66_8)

					if var_66_19.name == "split_6" or not string.find(var_66_19.name, "split") then
						var_66_19.gameObject:SetActive(true)
					else
						var_66_19.gameObject:SetActive(false)
					end
				end
			end

			local var_66_20 = 0.001

			if var_66_17 <= arg_63_1.time_ and arg_63_1.time_ < var_66_17 + var_66_20 then
				local var_66_21 = (arg_63_1.time_ - var_66_17) / var_66_20
				local var_66_22 = Vector3.New(0, -315, -320)

				var_66_16.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10022, var_66_22, var_66_21)
			end

			if arg_63_1.time_ >= var_66_17 + var_66_20 and arg_63_1.time_ < var_66_17 + var_66_20 + arg_66_0 then
				var_66_16.localPosition = Vector3.New(0, -315, -320)
			end

			local var_66_23 = 0
			local var_66_24 = 0.45

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_25 = arg_63_1:FormatText(StoryNameCfg[614].name)

				arg_63_1.leftNameTxt_.text = var_66_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_26 = arg_63_1:GetWordFromCfg(413082015)
				local var_66_27 = arg_63_1:FormatText(var_66_26.content)

				arg_63_1.text_.text = var_66_27

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082015", "story_v_out_413082.awb") ~= 0 then
					local var_66_31 = manager.audio:GetVoiceLength("story_v_out_413082", "413082015", "story_v_out_413082.awb") / 1000

					if var_66_31 + var_66_23 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_31 + var_66_23
					end

					if var_66_26.prefab_name ~= "" and arg_63_1.actors_[var_66_26.prefab_name] ~= nil then
						local var_66_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_26.prefab_name].transform, "story_v_out_413082", "413082015", "story_v_out_413082.awb")

						arg_63_1:RecordAudio("413082015", var_66_32)
						arg_63_1:RecordAudio("413082015", var_66_32)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413082", "413082015", "story_v_out_413082.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413082", "413082015", "story_v_out_413082.awb")
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
				actorName = "10022",
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
	Play413082016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413082016
		arg_67_1.duration_ = 4.2

		local var_67_0 = {
			zh = 2.4,
			ja = 4.2
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
				arg_67_0:Play413082017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.3

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[614].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(413082016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082016", "story_v_out_413082.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082016", "story_v_out_413082.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_413082", "413082016", "story_v_out_413082.awb")

						arg_67_1:RecordAudio("413082016", var_70_9)
						arg_67_1:RecordAudio("413082016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413082", "413082016", "story_v_out_413082.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413082", "413082016", "story_v_out_413082.awb")
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
	Play413082017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413082017
		arg_71_1.duration_ = 6

		local var_71_0 = {
			zh = 5.1,
			ja = 6
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play413082018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10022"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10022 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10022", 3)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "split_2" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -315, -320)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10022, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_74_7 = 0
			local var_74_8 = 0.5

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_9 = arg_71_1:FormatText(StoryNameCfg[614].name)

				arg_71_1.leftNameTxt_.text = var_74_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(413082017)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 20
				local var_74_13 = utf8.len(var_74_11)
				local var_74_14 = var_74_12 <= 0 and var_74_8 or var_74_8 * (var_74_13 / var_74_12)

				if var_74_14 > 0 and var_74_8 < var_74_14 then
					arg_71_1.talkMaxDuration = var_74_14

					if var_74_14 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_7
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082017", "story_v_out_413082.awb") ~= 0 then
					local var_74_15 = manager.audio:GetVoiceLength("story_v_out_413082", "413082017", "story_v_out_413082.awb") / 1000

					if var_74_15 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_7
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_413082", "413082017", "story_v_out_413082.awb")

						arg_71_1:RecordAudio("413082017", var_74_16)
						arg_71_1:RecordAudio("413082017", var_74_16)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413082", "413082017", "story_v_out_413082.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413082", "413082017", "story_v_out_413082.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_17 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_17 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_7) / var_74_17

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_7 + var_74_17 and arg_71_1.time_ < var_74_7 + var_74_17 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413082018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413082019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10022"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10022 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10022", 0)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(-5000, -315, -320)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10022, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_78_7 = arg_75_1.actors_["10096"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10096 == nil then
				arg_75_1.var_.actorSpriteComps10096 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps10096 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								local var_78_11 = Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor2.r, var_78_10)
								local var_78_12 = Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor2.g, var_78_10)
								local var_78_13 = Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor2.b, var_78_10)

								iter_78_2.color = Color.New(var_78_11, var_78_12, var_78_13)
							else
								local var_78_14 = Mathf.Lerp(iter_78_2.color.r, 0.5, var_78_10)

								iter_78_2.color = Color.New(var_78_14, var_78_14, var_78_14)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10096 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10096 = nil
			end

			local var_78_15 = 0
			local var_78_16 = 0.266666666666667

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				local var_78_17 = "play"
				local var_78_18 = "music"

				arg_75_1:AudioAction(var_78_17, var_78_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_78_19 = ""
				local var_78_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_78_20 ~= "" then
					if arg_75_1.bgmTxt_.text ~= var_78_20 and arg_75_1.bgmTxt_.text ~= "" then
						if arg_75_1.bgmTxt2_.text ~= "" then
							arg_75_1.bgmTxt_.text = arg_75_1.bgmTxt2_.text
						end

						arg_75_1.bgmTxt2_.text = var_78_20

						arg_75_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_75_1.bgmTxt_.text = var_78_20
						arg_75_1.bgmTxt2_.text = var_78_20
					end

					if arg_75_1.bgmTimer then
						arg_75_1.bgmTimer:Stop()

						arg_75_1.bgmTimer = nil
					end

					if arg_75_1.settingData.show_music_name == 1 then
						arg_75_1.musicController:SetSelectedState("show")
						arg_75_1.musicAnimator_:Play("open", 0, 0)

						if arg_75_1.settingData.music_time ~= 0 then
							arg_75_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_75_1.settingData.music_time), function()
								if arg_75_1 == nil or isNil(arg_75_1.bgmTxt_) then
									return
								end

								arg_75_1.musicController:SetSelectedState("hide")
								arg_75_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_78_21 = 0
			local var_78_22 = 1.425

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_23 = arg_75_1:GetWordFromCfg(413082018)
				local var_78_24 = arg_75_1:FormatText(var_78_23.content)

				arg_75_1.text_.text = var_78_24

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_25 = 57
				local var_78_26 = utf8.len(var_78_24)
				local var_78_27 = var_78_25 <= 0 and var_78_22 or var_78_22 * (var_78_26 / var_78_25)

				if var_78_27 > 0 and var_78_22 < var_78_27 then
					arg_75_1.talkMaxDuration = var_78_27

					if var_78_27 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_21
					end
				end

				arg_75_1.text_.text = var_78_24
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_28 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_28 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_21) / var_78_28

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_21 + var_78_28 and arg_75_1.time_ < var_78_21 + var_78_28 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play413082019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 413082019
		arg_80_1.duration_ = 3.17

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play413082020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.266666666666667

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_2 = "play"
				local var_83_3 = "music"

				arg_80_1:AudioAction(var_83_2, var_83_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_83_4 = ""
				local var_83_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_83_5 ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_5 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_5

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_5
						arg_80_1.bgmTxt2_.text = var_83_5
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_6 = 0.266666666666667
			local var_83_7 = 0.125

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_8 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_8:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_80_1.dialogCg_.alpha = arg_85_0
				end))
				var_83_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_9 = arg_80_1:FormatText(StoryNameCfg[259].name)

				arg_80_1.leftNameTxt_.text = var_83_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_10 = arg_80_1:GetWordFromCfg(413082019)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_12 = 5
				local var_83_13 = utf8.len(var_83_11)
				local var_83_14 = var_83_12 <= 0 and var_83_7 or var_83_7 * (var_83_13 / var_83_12)

				if var_83_14 > 0 and var_83_7 < var_83_14 then
					arg_80_1.talkMaxDuration = var_83_14
					var_83_6 = var_83_6 + 0.3

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082019", "story_v_out_413082.awb") ~= 0 then
					local var_83_15 = manager.audio:GetVoiceLength("story_v_out_413082", "413082019", "story_v_out_413082.awb") / 1000

					if var_83_15 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_6
					end

					if var_83_10.prefab_name ~= "" and arg_80_1.actors_[var_83_10.prefab_name] ~= nil then
						local var_83_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_10.prefab_name].transform, "story_v_out_413082", "413082019", "story_v_out_413082.awb")

						arg_80_1:RecordAudio("413082019", var_83_16)
						arg_80_1:RecordAudio("413082019", var_83_16)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_413082", "413082019", "story_v_out_413082.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_413082", "413082019", "story_v_out_413082.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_17 = var_83_6 + 0.3
			local var_83_18 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_17) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_17 + var_83_18 and arg_80_1.time_ < var_83_17 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play413082020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413082020
		arg_87_1.duration_ = 8.57

		local var_87_0 = {
			zh = 7.56633333333333,
			ja = 8.56633333333333
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
				arg_87_0:Play413082021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_1 = 1.3

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_1 then
				local var_90_2 = (arg_87_1.time_ - var_90_0) / var_90_1
				local var_90_3 = Color.New(0, 0, 0)

				var_90_3.a = Mathf.Lerp(0, 1, var_90_2)
				arg_87_1.mask_.color = var_90_3
			end

			if arg_87_1.time_ >= var_90_0 + var_90_1 and arg_87_1.time_ < var_90_0 + var_90_1 + arg_90_0 then
				local var_90_4 = Color.New(0, 0, 0)

				var_90_4.a = 1
				arg_87_1.mask_.color = var_90_4
			end

			local var_90_5 = 1.30066666666667

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_6 = 2.43333333333333

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = Mathf.Lerp(1, 0, var_90_7)
				arg_87_1.mask_.color = var_90_8
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				local var_90_9 = Color.New(0, 0, 0)
				local var_90_10 = 0

				arg_87_1.mask_.enabled = false
				var_90_9.a = var_90_10
				arg_87_1.mask_.color = var_90_9
			end

			local var_90_11 = "SS1306"

			if arg_87_1.bgs_[var_90_11] == nil then
				local var_90_12 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_11)
				var_90_12.name = var_90_11
				var_90_12.transform.parent = arg_87_1.stage_.transform
				var_90_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_11] = var_90_12
			end

			local var_90_13 = arg_87_1.bgs_.SS1306.transform
			local var_90_14 = 1.30066666666667

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1.var_.moveOldPosSS1306 = var_90_13.localPosition
			end

			local var_90_15 = 0.001

			if var_90_14 <= arg_87_1.time_ and arg_87_1.time_ < var_90_14 + var_90_15 then
				local var_90_16 = (arg_87_1.time_ - var_90_14) / var_90_15
				local var_90_17 = Vector3.New(-1.22, 1, 7.11)

				var_90_13.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosSS1306, var_90_17, var_90_16)
			end

			if arg_87_1.time_ >= var_90_14 + var_90_15 and arg_87_1.time_ < var_90_14 + var_90_15 + arg_90_0 then
				var_90_13.localPosition = Vector3.New(-1.22, 1, 7.11)
			end

			local var_90_18 = arg_87_1.bgs_.SS1306.transform
			local var_90_19 = 1.31733333333333

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1.var_.moveOldPosSS1306 = var_90_18.localPosition
			end

			local var_90_20 = 2.916

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				local var_90_21 = (arg_87_1.time_ - var_90_19) / var_90_20
				local var_90_22 = Vector3.New(0, 1, 8.6)

				var_90_18.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosSS1306, var_90_22, var_90_21)
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				var_90_18.localPosition = Vector3.New(0, 1, 8.6)
			end

			local var_90_23 = 1.284

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				local var_90_24 = manager.ui.mainCamera.transform.localPosition
				local var_90_25 = Vector3.New(0, 0, 10) + Vector3.New(var_90_24.x, var_90_24.y, 0)
				local var_90_26 = arg_87_1.bgs_.SS1306

				var_90_26.transform.localPosition = var_90_25
				var_90_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_27 = var_90_26:GetComponent("SpriteRenderer")

				if var_90_27 and var_90_27.sprite then
					local var_90_28 = (var_90_26.transform.localPosition - var_90_24).z
					local var_90_29 = manager.ui.mainCameraCom_
					local var_90_30 = 2 * var_90_28 * Mathf.Tan(var_90_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_31 = var_90_30 * var_90_29.aspect
					local var_90_32 = var_90_27.sprite.bounds.size.x
					local var_90_33 = var_90_27.sprite.bounds.size.y
					local var_90_34 = var_90_31 / var_90_32
					local var_90_35 = var_90_30 / var_90_33
					local var_90_36 = var_90_35 < var_90_34 and var_90_34 or var_90_35

					var_90_26.transform.localScale = Vector3.New(var_90_36, var_90_36, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "SS1306" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_37 = "10094"

			if arg_87_1.actors_[var_90_37] == nil then
				local var_90_38 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_90_38) then
					local var_90_39 = Object.Instantiate(var_90_38, arg_87_1.canvasGo_.transform)

					var_90_39.transform:SetSiblingIndex(1)

					var_90_39.name = var_90_37
					var_90_39.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_[var_90_37] = var_90_39

					local var_90_40 = var_90_39:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_87_1.isInRecall_ then
						for iter_90_2, iter_90_3 in ipairs(var_90_40) do
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_41 = arg_87_1.actors_["10094"].transform
			local var_90_42 = 1.284

			if var_90_42 < arg_87_1.time_ and arg_87_1.time_ <= var_90_42 + arg_90_0 then
				arg_87_1.var_.moveOldPos10094 = var_90_41.localPosition
				var_90_41.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10094", 7)

				local var_90_43 = var_90_41.childCount

				for iter_90_4 = 0, var_90_43 - 1 do
					local var_90_44 = var_90_41:GetChild(iter_90_4)

					if var_90_44.name == "" or not string.find(var_90_44.name, "split") then
						var_90_44.gameObject:SetActive(true)
					else
						var_90_44.gameObject:SetActive(false)
					end
				end
			end

			local var_90_45 = 0.001

			if var_90_42 <= arg_87_1.time_ and arg_87_1.time_ < var_90_42 + var_90_45 then
				local var_90_46 = (arg_87_1.time_ - var_90_42) / var_90_45
				local var_90_47 = Vector3.New(0, -2000, 0)

				var_90_41.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10094, var_90_47, var_90_46)
			end

			if arg_87_1.time_ >= var_90_42 + var_90_45 and arg_87_1.time_ < var_90_42 + var_90_45 + arg_90_0 then
				var_90_41.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_48 = 2.83333333333333
			local var_90_49 = 0.375

			if var_90_48 < arg_87_1.time_ and arg_87_1.time_ <= var_90_48 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_50 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_50:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_51 = arg_87_1:FormatText(StoryNameCfg[259].name)

				arg_87_1.leftNameTxt_.text = var_90_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_52 = arg_87_1:GetWordFromCfg(413082020)
				local var_90_53 = arg_87_1:FormatText(var_90_52.content)

				arg_87_1.text_.text = var_90_53

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_54 = 15
				local var_90_55 = utf8.len(var_90_53)
				local var_90_56 = var_90_54 <= 0 and var_90_49 or var_90_49 * (var_90_55 / var_90_54)

				if var_90_56 > 0 and var_90_49 < var_90_56 then
					arg_87_1.talkMaxDuration = var_90_56
					var_90_48 = var_90_48 + 0.3

					if var_90_56 + var_90_48 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_56 + var_90_48
					end
				end

				arg_87_1.text_.text = var_90_53
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082020", "story_v_out_413082.awb") ~= 0 then
					local var_90_57 = manager.audio:GetVoiceLength("story_v_out_413082", "413082020", "story_v_out_413082.awb") / 1000

					if var_90_57 + var_90_48 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_57 + var_90_48
					end

					if var_90_52.prefab_name ~= "" and arg_87_1.actors_[var_90_52.prefab_name] ~= nil then
						local var_90_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_52.prefab_name].transform, "story_v_out_413082", "413082020", "story_v_out_413082.awb")

						arg_87_1:RecordAudio("413082020", var_90_58)
						arg_87_1:RecordAudio("413082020", var_90_58)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413082", "413082020", "story_v_out_413082.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413082", "413082020", "story_v_out_413082.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_59 = var_90_48 + 0.3
			local var_90_60 = math.max(var_90_49, arg_87_1.talkMaxDuration)

			if var_90_59 <= arg_87_1.time_ and arg_87_1.time_ < var_90_59 + var_90_60 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_59) / var_90_60

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_59 + var_90_60 and arg_87_1.time_ < var_90_59 + var_90_60 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.30066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.916,
				className = "StoryMoveNode",
				startTime = 1.31733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666668,
				className = "StoryMoveNode",
				startTime = 1.284,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play413082021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413082021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413082022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.833333333333333

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				local var_96_2 = "play"
				local var_96_3 = "music"

				arg_93_1:AudioAction(var_96_2, var_96_3, "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_96_4 = ""
				local var_96_5 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

				if var_96_5 ~= "" then
					if arg_93_1.bgmTxt_.text ~= var_96_5 and arg_93_1.bgmTxt_.text ~= "" then
						if arg_93_1.bgmTxt2_.text ~= "" then
							arg_93_1.bgmTxt_.text = arg_93_1.bgmTxt2_.text
						end

						arg_93_1.bgmTxt2_.text = var_96_5

						arg_93_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_93_1.bgmTxt_.text = var_96_5
						arg_93_1.bgmTxt2_.text = var_96_5
					end

					if arg_93_1.bgmTimer then
						arg_93_1.bgmTimer:Stop()

						arg_93_1.bgmTimer = nil
					end

					if arg_93_1.settingData.show_music_name == 1 then
						arg_93_1.musicController:SetSelectedState("show")
						arg_93_1.musicAnimator_:Play("open", 0, 0)

						if arg_93_1.settingData.music_time ~= 0 then
							arg_93_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_93_1.settingData.music_time), function()
								if arg_93_1 == nil or isNil(arg_93_1.bgmTxt_) then
									return
								end

								arg_93_1.musicController:SetSelectedState("hide")
								arg_93_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_96_6 = 0
			local var_96_7 = 1.675

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(413082021)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 67
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_7 or var_96_7 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_7 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_13 and arg_93_1.time_ < var_96_6 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413082022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 413082022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play413082023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.2

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(413082022)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 48
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play413082023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 413082023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play413082024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 1.425

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(413082023)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 57
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play413082024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 413082024
		arg_106_1.duration_ = 9.37

		local var_106_0 = {
			zh = 9.366,
			ja = 4.666
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
				arg_106_0:Play413082025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.55

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[614].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(413082024)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082024", "story_v_out_413082.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082024", "story_v_out_413082.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_413082", "413082024", "story_v_out_413082.awb")

						arg_106_1:RecordAudio("413082024", var_109_9)
						arg_106_1:RecordAudio("413082024", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_413082", "413082024", "story_v_out_413082.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_413082", "413082024", "story_v_out_413082.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play413082025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 413082025
		arg_110_1.duration_ = 4.47

		local var_110_0 = {
			zh = 4.466,
			ja = 2.866
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
				arg_110_0:Play413082026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.35

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[614].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(413082025)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 14
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082025", "story_v_out_413082.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082025", "story_v_out_413082.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_413082", "413082025", "story_v_out_413082.awb")

						arg_110_1:RecordAudio("413082025", var_113_9)
						arg_110_1:RecordAudio("413082025", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_413082", "413082025", "story_v_out_413082.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_413082", "413082025", "story_v_out_413082.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play413082026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 413082026
		arg_114_1.duration_ = 9.5

		local var_114_0 = {
			zh = 9.5,
			ja = 4.733
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play413082027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.2

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[36].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(413082026)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 8
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082026", "story_v_out_413082.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082026", "story_v_out_413082.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_413082", "413082026", "story_v_out_413082.awb")

						arg_114_1:RecordAudio("413082026", var_117_9)
						arg_114_1:RecordAudio("413082026", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_413082", "413082026", "story_v_out_413082.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_413082", "413082026", "story_v_out_413082.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play413082027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 413082027
		arg_118_1.duration_ = 6.17

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play413082028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_1 = 0.9

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_1 then
				local var_121_2 = (arg_118_1.time_ - var_121_0) / var_121_1
				local var_121_3 = Color.New(1, 1, 1)

				var_121_3.a = Mathf.Lerp(1, 0, var_121_2)
				arg_118_1.mask_.color = var_121_3
			end

			if arg_118_1.time_ >= var_121_0 + var_121_1 and arg_118_1.time_ < var_121_0 + var_121_1 + arg_121_0 then
				local var_121_4 = Color.New(1, 1, 1)
				local var_121_5 = 0

				arg_118_1.mask_.enabled = false
				var_121_4.a = var_121_5
				arg_118_1.mask_.color = var_121_4
			end

			local var_121_6 = arg_118_1.bgs_.SS1306.transform
			local var_121_7 = 0

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.var_.moveOldPosSS1306 = var_121_6.localPosition
			end

			local var_121_8 = 0.001

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_8 then
				local var_121_9 = (arg_118_1.time_ - var_121_7) / var_121_8
				local var_121_10 = Vector3.New(0, 1, 8.6)

				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosSS1306, var_121_10, var_121_9)
			end

			if arg_118_1.time_ >= var_121_7 + var_121_8 and arg_118_1.time_ < var_121_7 + var_121_8 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(0, 1, 8.6)
			end

			local var_121_11 = arg_118_1.bgs_.SS1306.transform
			local var_121_12 = 0.0166666666666667

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 then
				arg_118_1.var_.moveOldPosSS1306 = var_121_11.localPosition
			end

			local var_121_13 = 1.48333333333333

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_13 then
				local var_121_14 = (arg_118_1.time_ - var_121_12) / var_121_13
				local var_121_15 = Vector3.New(0, 1, 10)

				var_121_11.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosSS1306, var_121_15, var_121_14)
			end

			if arg_118_1.time_ >= var_121_12 + var_121_13 and arg_118_1.time_ < var_121_12 + var_121_13 + arg_121_0 then
				var_121_11.localPosition = Vector3.New(0, 1, 10)
			end

			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			local var_121_17 = 2.96666666666667

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_18 = 1.16666666666667
			local var_121_19 = 1.925

			if var_121_18 < arg_118_1.time_ and arg_118_1.time_ <= var_121_18 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_20 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_20:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_21 = arg_118_1:GetWordFromCfg(413082027)
				local var_121_22 = arg_118_1:FormatText(var_121_21.content)

				arg_118_1.text_.text = var_121_22

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_23 = 77
				local var_121_24 = utf8.len(var_121_22)
				local var_121_25 = var_121_23 <= 0 and var_121_19 or var_121_19 * (var_121_24 / var_121_23)

				if var_121_25 > 0 and var_121_19 < var_121_25 then
					arg_118_1.talkMaxDuration = var_121_25
					var_121_18 = var_121_18 + 0.3

					if var_121_25 + var_121_18 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_25 + var_121_18
					end
				end

				arg_118_1.text_.text = var_121_22
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_26 = var_121_18 + 0.3
			local var_121_27 = math.max(var_121_19, arg_118_1.talkMaxDuration)

			if var_121_26 <= arg_118_1.time_ and arg_118_1.time_ < var_121_26 + var_121_27 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_26) / var_121_27

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_26 + var_121_27 and arg_118_1.time_ < var_121_26 + var_121_27 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.48333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play413082028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 413082028
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play413082029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.55

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(413082028)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 62
				local var_127_5 = utf8.len(var_127_3)
				local var_127_6 = var_127_4 <= 0 and var_127_1 or var_127_1 * (var_127_5 / var_127_4)

				if var_127_6 > 0 and var_127_1 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_7 and arg_124_1.time_ < var_127_0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play413082029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 413082029
		arg_128_1.duration_ = 12.13

		local var_128_0 = {
			zh = 6.733,
			ja = 12.133
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play413082030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.575

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[996].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(413082029)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 23
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082029", "story_v_out_413082.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082029", "story_v_out_413082.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_413082", "413082029", "story_v_out_413082.awb")

						arg_128_1:RecordAudio("413082029", var_131_9)
						arg_128_1:RecordAudio("413082029", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_413082", "413082029", "story_v_out_413082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_413082", "413082029", "story_v_out_413082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play413082030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 413082030
		arg_132_1.duration_ = 5.63

		local var_132_0 = {
			zh = 3.966,
			ja = 5.633
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play413082031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.4

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[996].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_2")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(413082030)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 16
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082030", "story_v_out_413082.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082030", "story_v_out_413082.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_413082", "413082030", "story_v_out_413082.awb")

						arg_132_1:RecordAudio("413082030", var_135_9)
						arg_132_1:RecordAudio("413082030", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_413082", "413082030", "story_v_out_413082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_413082", "413082030", "story_v_out_413082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play413082031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 413082031
		arg_136_1.duration_ = 7.97

		local var_136_0 = {
			zh = 2,
			ja = 7.966
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play413082032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.2

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[992].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(413082031)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 8
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082031", "story_v_out_413082.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082031", "story_v_out_413082.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_413082", "413082031", "story_v_out_413082.awb")

						arg_136_1:RecordAudio("413082031", var_139_9)
						arg_136_1:RecordAudio("413082031", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_413082", "413082031", "story_v_out_413082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_413082", "413082031", "story_v_out_413082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play413082032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 413082032
		arg_140_1.duration_ = 6.3

		local var_140_0 = {
			zh = 6.3,
			ja = 5.2
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play413082033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.425

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[996].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(413082032)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 17
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082032", "story_v_out_413082.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082032", "story_v_out_413082.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_413082", "413082032", "story_v_out_413082.awb")

						arg_140_1:RecordAudio("413082032", var_143_9)
						arg_140_1:RecordAudio("413082032", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_413082", "413082032", "story_v_out_413082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_413082", "413082032", "story_v_out_413082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play413082033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 413082033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play413082034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.025

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_2 = arg_144_1:GetWordFromCfg(413082033)
				local var_147_3 = arg_144_1:FormatText(var_147_2.content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 41
				local var_147_5 = utf8.len(var_147_3)
				local var_147_6 = var_147_4 <= 0 and var_147_1 or var_147_1 * (var_147_5 / var_147_4)

				if var_147_6 > 0 and var_147_1 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_7 and arg_144_1.time_ < var_147_0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play413082034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 413082034
		arg_148_1.duration_ = 5.67

		local var_148_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play413082035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.225

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[996].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_8")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(413082034)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 9
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082034", "story_v_out_413082.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082034", "story_v_out_413082.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_413082", "413082034", "story_v_out_413082.awb")

						arg_148_1:RecordAudio("413082034", var_151_9)
						arg_148_1:RecordAudio("413082034", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_413082", "413082034", "story_v_out_413082.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_413082", "413082034", "story_v_out_413082.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play413082035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 413082035
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play413082036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 1.6

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(413082035)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 64
				local var_155_5 = utf8.len(var_155_3)
				local var_155_6 = var_155_4 <= 0 and var_155_1 or var_155_1 * (var_155_5 / var_155_4)

				if var_155_6 > 0 and var_155_1 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_7 and arg_152_1.time_ < var_155_0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play413082036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 413082036
		arg_156_1.duration_ = 3.73

		local var_156_0 = {
			zh = 3.733,
			ja = 2.1
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play413082037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_1 = 1.86666666666667

			if arg_156_1.time_ >= var_159_0 + var_159_1 and arg_156_1.time_ < var_159_0 + var_159_1 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_2 = 0
			local var_159_3 = 0.175

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[259].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(413082036)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 7
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082036", "story_v_out_413082.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_413082", "413082036", "story_v_out_413082.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_413082", "413082036", "story_v_out_413082.awb")

						arg_156_1:RecordAudio("413082036", var_159_11)
						arg_156_1:RecordAudio("413082036", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_413082", "413082036", "story_v_out_413082.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_413082", "413082036", "story_v_out_413082.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play413082037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 413082037
		arg_160_1.duration_ = 8.67

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play413082038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 2

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				local var_163_1 = manager.ui.mainCamera.transform.localPosition
				local var_163_2 = Vector3.New(0, 0, 10) + Vector3.New(var_163_1.x, var_163_1.y, 0)
				local var_163_3 = arg_160_1.bgs_.F08i

				var_163_3.transform.localPosition = var_163_2
				var_163_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_4 = var_163_3:GetComponent("SpriteRenderer")

				if var_163_4 and var_163_4.sprite then
					local var_163_5 = (var_163_3.transform.localPosition - var_163_1).z
					local var_163_6 = manager.ui.mainCameraCom_
					local var_163_7 = 2 * var_163_5 * Mathf.Tan(var_163_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_8 = var_163_7 * var_163_6.aspect
					local var_163_9 = var_163_4.sprite.bounds.size.x
					local var_163_10 = var_163_4.sprite.bounds.size.y
					local var_163_11 = var_163_8 / var_163_9
					local var_163_12 = var_163_7 / var_163_10
					local var_163_13 = var_163_12 < var_163_11 and var_163_11 or var_163_12

					var_163_3.transform.localScale = Vector3.New(var_163_13, var_163_13, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "F08i" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_14 = 3.46666666666667

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_15 = 0.3

			if arg_160_1.time_ >= var_163_14 + var_163_15 and arg_160_1.time_ < var_163_14 + var_163_15 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_17 = 2

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17
				local var_163_19 = Color.New(1, 1, 1)

				var_163_19.a = Mathf.Lerp(0, 1, var_163_18)
				arg_160_1.mask_.color = var_163_19
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				local var_163_20 = Color.New(1, 1, 1)

				var_163_20.a = 1
				arg_160_1.mask_.color = var_163_20
			end

			local var_163_21 = 2

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_22 = 1.46666666666667

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 then
				local var_163_23 = (arg_160_1.time_ - var_163_21) / var_163_22
				local var_163_24 = Color.New(1, 1, 1)

				var_163_24.a = Mathf.Lerp(1, 0, var_163_23)
				arg_160_1.mask_.color = var_163_24
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 then
				local var_163_25 = Color.New(1, 1, 1)
				local var_163_26 = 0

				arg_160_1.mask_.enabled = false
				var_163_25.a = var_163_26
				arg_160_1.mask_.color = var_163_25
			end

			local var_163_27 = arg_160_1.actors_["10094"].transform
			local var_163_28 = 1.966

			if var_163_28 < arg_160_1.time_ and arg_160_1.time_ <= var_163_28 + arg_163_0 then
				arg_160_1.var_.moveOldPos10094 = var_163_27.localPosition
				var_163_27.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10094", 7)

				local var_163_29 = var_163_27.childCount

				for iter_163_2 = 0, var_163_29 - 1 do
					local var_163_30 = var_163_27:GetChild(iter_163_2)

					if var_163_30.name == "" or not string.find(var_163_30.name, "split") then
						var_163_30.gameObject:SetActive(true)
					else
						var_163_30.gameObject:SetActive(false)
					end
				end
			end

			local var_163_31 = 0.001

			if var_163_28 <= arg_160_1.time_ and arg_160_1.time_ < var_163_28 + var_163_31 then
				local var_163_32 = (arg_160_1.time_ - var_163_28) / var_163_31
				local var_163_33 = Vector3.New(0, -2000, 0)

				var_163_27.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10094, var_163_33, var_163_32)
			end

			if arg_160_1.time_ >= var_163_28 + var_163_31 and arg_160_1.time_ < var_163_28 + var_163_31 + arg_163_0 then
				var_163_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_34 = arg_160_1.actors_["10094"]
			local var_163_35 = 1.966

			if var_163_35 < arg_160_1.time_ and arg_160_1.time_ <= var_163_35 + arg_163_0 and not isNil(var_163_34) and arg_160_1.var_.actorSpriteComps10094 == nil then
				arg_160_1.var_.actorSpriteComps10094 = var_163_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_36 = 0.0340000000000005

			if var_163_35 <= arg_160_1.time_ and arg_160_1.time_ < var_163_35 + var_163_36 and not isNil(var_163_34) then
				local var_163_37 = (arg_160_1.time_ - var_163_35) / var_163_36

				if arg_160_1.var_.actorSpriteComps10094 then
					for iter_163_3, iter_163_4 in pairs(arg_160_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_163_4 then
							if arg_160_1.isInRecall_ then
								local var_163_38 = Mathf.Lerp(iter_163_4.color.r, arg_160_1.hightColor2.r, var_163_37)
								local var_163_39 = Mathf.Lerp(iter_163_4.color.g, arg_160_1.hightColor2.g, var_163_37)
								local var_163_40 = Mathf.Lerp(iter_163_4.color.b, arg_160_1.hightColor2.b, var_163_37)

								iter_163_4.color = Color.New(var_163_38, var_163_39, var_163_40)
							else
								local var_163_41 = Mathf.Lerp(iter_163_4.color.r, 0.5, var_163_37)

								iter_163_4.color = Color.New(var_163_41, var_163_41, var_163_41)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_35 + var_163_36 and arg_160_1.time_ < var_163_35 + var_163_36 + arg_163_0 and not isNil(var_163_34) and arg_160_1.var_.actorSpriteComps10094 then
				for iter_163_5, iter_163_6 in pairs(arg_160_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_163_6 then
						if arg_160_1.isInRecall_ then
							iter_163_6.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10094 = nil
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_42 = 3.66666666666667
			local var_163_43 = 1.475

			if var_163_42 < arg_160_1.time_ and arg_160_1.time_ <= var_163_42 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_44 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_44:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_45 = arg_160_1:GetWordFromCfg(413082037)
				local var_163_46 = arg_160_1:FormatText(var_163_45.content)

				arg_160_1.text_.text = var_163_46

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_47 = 59
				local var_163_48 = utf8.len(var_163_46)
				local var_163_49 = var_163_47 <= 0 and var_163_43 or var_163_43 * (var_163_48 / var_163_47)

				if var_163_49 > 0 and var_163_43 < var_163_49 then
					arg_160_1.talkMaxDuration = var_163_49
					var_163_42 = var_163_42 + 0.3

					if var_163_49 + var_163_42 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_49 + var_163_42
					end
				end

				arg_160_1.text_.text = var_163_46
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_50 = var_163_42 + 0.3
			local var_163_51 = math.max(var_163_43, arg_160_1.talkMaxDuration)

			if var_163_50 <= arg_160_1.time_ and arg_160_1.time_ < var_163_50 + var_163_51 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_50) / var_163_51

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_50 + var_163_51 and arg_160_1.time_ < var_163_50 + var_163_51 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play413082038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 413082038
		arg_166_1.duration_ = 2

		local var_166_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play413082039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10022"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos10022 = var_169_0.localPosition
				var_169_0.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10022", 2)

				local var_169_2 = var_169_0.childCount

				for iter_169_0 = 0, var_169_2 - 1 do
					local var_169_3 = var_169_0:GetChild(iter_169_0)

					if var_169_3.name == "split_3" or not string.find(var_169_3.name, "split") then
						var_169_3.gameObject:SetActive(true)
					else
						var_169_3.gameObject:SetActive(false)
					end
				end
			end

			local var_169_4 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_4 then
				local var_169_5 = (arg_166_1.time_ - var_169_1) / var_169_4
				local var_169_6 = Vector3.New(-390, -315, -320)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10022, var_169_6, var_169_5)
			end

			if arg_166_1.time_ >= var_169_1 + var_169_4 and arg_166_1.time_ < var_169_1 + var_169_4 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_169_7 = arg_166_1.actors_["10022"]
			local var_169_8 = 0

			if var_169_8 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 and not isNil(var_169_7) and arg_166_1.var_.actorSpriteComps10022 == nil then
				arg_166_1.var_.actorSpriteComps10022 = var_169_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_9 = 2

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_9 and not isNil(var_169_7) then
				local var_169_10 = (arg_166_1.time_ - var_169_8) / var_169_9

				if arg_166_1.var_.actorSpriteComps10022 then
					for iter_169_1, iter_169_2 in pairs(arg_166_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_169_2 then
							if arg_166_1.isInRecall_ then
								local var_169_11 = Mathf.Lerp(iter_169_2.color.r, arg_166_1.hightColor1.r, var_169_10)
								local var_169_12 = Mathf.Lerp(iter_169_2.color.g, arg_166_1.hightColor1.g, var_169_10)
								local var_169_13 = Mathf.Lerp(iter_169_2.color.b, arg_166_1.hightColor1.b, var_169_10)

								iter_169_2.color = Color.New(var_169_11, var_169_12, var_169_13)
							else
								local var_169_14 = Mathf.Lerp(iter_169_2.color.r, 1, var_169_10)

								iter_169_2.color = Color.New(var_169_14, var_169_14, var_169_14)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_8 + var_169_9 and arg_166_1.time_ < var_169_8 + var_169_9 + arg_169_0 and not isNil(var_169_7) and arg_166_1.var_.actorSpriteComps10022 then
				for iter_169_3, iter_169_4 in pairs(arg_166_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_169_4 then
						if arg_166_1.isInRecall_ then
							iter_169_4.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10022 = nil
			end

			local var_169_15 = 0
			local var_169_16 = 0.2

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[614].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(413082038)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082038", "story_v_out_413082.awb") ~= 0 then
					local var_169_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082038", "story_v_out_413082.awb") / 1000

					if var_169_23 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_15
					end

					if var_169_18.prefab_name ~= "" and arg_166_1.actors_[var_169_18.prefab_name] ~= nil then
						local var_169_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_18.prefab_name].transform, "story_v_out_413082", "413082038", "story_v_out_413082.awb")

						arg_166_1:RecordAudio("413082038", var_169_24)
						arg_166_1:RecordAudio("413082038", var_169_24)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_413082", "413082038", "story_v_out_413082.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_413082", "413082038", "story_v_out_413082.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_25 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_25 and arg_166_1.time_ < var_169_15 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play413082039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 413082039
		arg_170_1.duration_ = 5.57

		local var_170_0 = {
			zh = 5.566,
			ja = 3.733
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play413082040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10022"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10022 == nil then
				arg_170_1.var_.actorSpriteComps10022 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10022 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor2.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor2.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor2.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 0.5, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10022 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10022 = nil
			end

			local var_173_8 = arg_170_1.actors_["10094"].transform
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.var_.moveOldPos10094 = var_173_8.localPosition
				var_173_8.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10094", 4)

				local var_173_10 = var_173_8.childCount

				for iter_173_4 = 0, var_173_10 - 1 do
					local var_173_11 = var_173_8:GetChild(iter_173_4)

					if var_173_11.name == "split_1" or not string.find(var_173_11.name, "split") then
						var_173_11.gameObject:SetActive(true)
					else
						var_173_11.gameObject:SetActive(false)
					end
				end
			end

			local var_173_12 = 0.001

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_12 then
				local var_173_13 = (arg_170_1.time_ - var_173_9) / var_173_12
				local var_173_14 = Vector3.New(390, -340, -414)

				var_173_8.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10094, var_173_14, var_173_13)
			end

			if arg_170_1.time_ >= var_173_9 + var_173_12 and arg_170_1.time_ < var_173_9 + var_173_12 + arg_173_0 then
				var_173_8.localPosition = Vector3.New(390, -340, -414)
			end

			local var_173_15 = arg_170_1.actors_["10094"]
			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.actorSpriteComps10094 == nil then
				arg_170_1.var_.actorSpriteComps10094 = var_173_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_17 = 2

			if var_173_16 <= arg_170_1.time_ and arg_170_1.time_ < var_173_16 + var_173_17 and not isNil(var_173_15) then
				local var_173_18 = (arg_170_1.time_ - var_173_16) / var_173_17

				if arg_170_1.var_.actorSpriteComps10094 then
					for iter_173_5, iter_173_6 in pairs(arg_170_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_173_6 then
							if arg_170_1.isInRecall_ then
								local var_173_19 = Mathf.Lerp(iter_173_6.color.r, arg_170_1.hightColor1.r, var_173_18)
								local var_173_20 = Mathf.Lerp(iter_173_6.color.g, arg_170_1.hightColor1.g, var_173_18)
								local var_173_21 = Mathf.Lerp(iter_173_6.color.b, arg_170_1.hightColor1.b, var_173_18)

								iter_173_6.color = Color.New(var_173_19, var_173_20, var_173_21)
							else
								local var_173_22 = Mathf.Lerp(iter_173_6.color.r, 1, var_173_18)

								iter_173_6.color = Color.New(var_173_22, var_173_22, var_173_22)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_16 + var_173_17 and arg_170_1.time_ < var_173_16 + var_173_17 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.actorSpriteComps10094 then
				for iter_173_7, iter_173_8 in pairs(arg_170_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_173_8 then
						if arg_170_1.isInRecall_ then
							iter_173_8.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10094 = nil
			end

			local var_173_23 = 0
			local var_173_24 = 0.3

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_25 = arg_170_1:FormatText(StoryNameCfg[259].name)

				arg_170_1.leftNameTxt_.text = var_173_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_26 = arg_170_1:GetWordFromCfg(413082039)
				local var_173_27 = arg_170_1:FormatText(var_173_26.content)

				arg_170_1.text_.text = var_173_27

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_28 = 12
				local var_173_29 = utf8.len(var_173_27)
				local var_173_30 = var_173_28 <= 0 and var_173_24 or var_173_24 * (var_173_29 / var_173_28)

				if var_173_30 > 0 and var_173_24 < var_173_30 then
					arg_170_1.talkMaxDuration = var_173_30

					if var_173_30 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_30 + var_173_23
					end
				end

				arg_170_1.text_.text = var_173_27
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082039", "story_v_out_413082.awb") ~= 0 then
					local var_173_31 = manager.audio:GetVoiceLength("story_v_out_413082", "413082039", "story_v_out_413082.awb") / 1000

					if var_173_31 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_31 + var_173_23
					end

					if var_173_26.prefab_name ~= "" and arg_170_1.actors_[var_173_26.prefab_name] ~= nil then
						local var_173_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_26.prefab_name].transform, "story_v_out_413082", "413082039", "story_v_out_413082.awb")

						arg_170_1:RecordAudio("413082039", var_173_32)
						arg_170_1:RecordAudio("413082039", var_173_32)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_413082", "413082039", "story_v_out_413082.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_413082", "413082039", "story_v_out_413082.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_33 = math.max(var_173_24, arg_170_1.talkMaxDuration)

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_33 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_23) / var_173_33

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_23 + var_173_33 and arg_170_1.time_ < var_173_23 + var_173_33 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413082040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 413082040
		arg_174_1.duration_ = 2.33

		local var_174_0 = {
			zh = 1.7,
			ja = 2.333
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play413082041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10094"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos10094 = var_177_0.localPosition
				var_177_0.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10094", 4)

				local var_177_2 = var_177_0.childCount

				for iter_177_0 = 0, var_177_2 - 1 do
					local var_177_3 = var_177_0:GetChild(iter_177_0)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_4 then
				local var_177_5 = (arg_174_1.time_ - var_177_1) / var_177_4
				local var_177_6 = Vector3.New(390, -340, -414)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10094, var_177_6, var_177_5)
			end

			if arg_174_1.time_ >= var_177_1 + var_177_4 and arg_174_1.time_ < var_177_1 + var_177_4 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_177_7 = 0
			local var_177_8 = 0.2

			if var_177_7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_9 = arg_174_1:FormatText(StoryNameCfg[259].name)

				arg_174_1.leftNameTxt_.text = var_177_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(413082040)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 8
				local var_177_13 = utf8.len(var_177_11)
				local var_177_14 = var_177_12 <= 0 and var_177_8 or var_177_8 * (var_177_13 / var_177_12)

				if var_177_14 > 0 and var_177_8 < var_177_14 then
					arg_174_1.talkMaxDuration = var_177_14

					if var_177_14 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_7
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082040", "story_v_out_413082.awb") ~= 0 then
					local var_177_15 = manager.audio:GetVoiceLength("story_v_out_413082", "413082040", "story_v_out_413082.awb") / 1000

					if var_177_15 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_7
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_413082", "413082040", "story_v_out_413082.awb")

						arg_174_1:RecordAudio("413082040", var_177_16)
						arg_174_1:RecordAudio("413082040", var_177_16)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_413082", "413082040", "story_v_out_413082.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_413082", "413082040", "story_v_out_413082.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_17 = math.max(var_177_8, arg_174_1.talkMaxDuration)

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_17 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_7) / var_177_17

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_7 + var_177_17 and arg_174_1.time_ < var_177_7 + var_177_17 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play413082041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 413082041
		arg_178_1.duration_ = 4.43

		local var_178_0 = {
			zh = 2.533,
			ja = 4.433
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play413082042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10022"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos10022 = var_181_0.localPosition
				var_181_0.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10022", 2)

				local var_181_2 = var_181_0.childCount

				for iter_181_0 = 0, var_181_2 - 1 do
					local var_181_3 = var_181_0:GetChild(iter_181_0)

					if var_181_3.name == "split_6" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_4 then
				local var_181_5 = (arg_178_1.time_ - var_181_1) / var_181_4
				local var_181_6 = Vector3.New(-390, -315, -320)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10022, var_181_6, var_181_5)
			end

			if arg_178_1.time_ >= var_181_1 + var_181_4 and arg_178_1.time_ < var_181_1 + var_181_4 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_181_7 = arg_178_1.actors_["10022"]
			local var_181_8 = 0

			if var_181_8 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.actorSpriteComps10022 == nil then
				arg_178_1.var_.actorSpriteComps10022 = var_181_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_9 = 2

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_9 and not isNil(var_181_7) then
				local var_181_10 = (arg_178_1.time_ - var_181_8) / var_181_9

				if arg_178_1.var_.actorSpriteComps10022 then
					for iter_181_1, iter_181_2 in pairs(arg_178_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_181_2 then
							if arg_178_1.isInRecall_ then
								local var_181_11 = Mathf.Lerp(iter_181_2.color.r, arg_178_1.hightColor1.r, var_181_10)
								local var_181_12 = Mathf.Lerp(iter_181_2.color.g, arg_178_1.hightColor1.g, var_181_10)
								local var_181_13 = Mathf.Lerp(iter_181_2.color.b, arg_178_1.hightColor1.b, var_181_10)

								iter_181_2.color = Color.New(var_181_11, var_181_12, var_181_13)
							else
								local var_181_14 = Mathf.Lerp(iter_181_2.color.r, 1, var_181_10)

								iter_181_2.color = Color.New(var_181_14, var_181_14, var_181_14)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_8 + var_181_9 and arg_178_1.time_ < var_181_8 + var_181_9 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.actorSpriteComps10022 then
				for iter_181_3, iter_181_4 in pairs(arg_178_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_181_4 then
						if arg_178_1.isInRecall_ then
							iter_181_4.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10022 = nil
			end

			local var_181_15 = arg_178_1.actors_["10094"]
			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 and not isNil(var_181_15) and arg_178_1.var_.actorSpriteComps10094 == nil then
				arg_178_1.var_.actorSpriteComps10094 = var_181_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_17 = 2

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_17 and not isNil(var_181_15) then
				local var_181_18 = (arg_178_1.time_ - var_181_16) / var_181_17

				if arg_178_1.var_.actorSpriteComps10094 then
					for iter_181_5, iter_181_6 in pairs(arg_178_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_181_6 then
							if arg_178_1.isInRecall_ then
								local var_181_19 = Mathf.Lerp(iter_181_6.color.r, arg_178_1.hightColor2.r, var_181_18)
								local var_181_20 = Mathf.Lerp(iter_181_6.color.g, arg_178_1.hightColor2.g, var_181_18)
								local var_181_21 = Mathf.Lerp(iter_181_6.color.b, arg_178_1.hightColor2.b, var_181_18)

								iter_181_6.color = Color.New(var_181_19, var_181_20, var_181_21)
							else
								local var_181_22 = Mathf.Lerp(iter_181_6.color.r, 0.5, var_181_18)

								iter_181_6.color = Color.New(var_181_22, var_181_22, var_181_22)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_16 + var_181_17 and arg_178_1.time_ < var_181_16 + var_181_17 + arg_181_0 and not isNil(var_181_15) and arg_178_1.var_.actorSpriteComps10094 then
				for iter_181_7, iter_181_8 in pairs(arg_178_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_181_8 then
						if arg_178_1.isInRecall_ then
							iter_181_8.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10094 = nil
			end

			local var_181_23 = 0
			local var_181_24 = 0.2

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_25 = arg_178_1:FormatText(StoryNameCfg[614].name)

				arg_178_1.leftNameTxt_.text = var_181_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_26 = arg_178_1:GetWordFromCfg(413082041)
				local var_181_27 = arg_178_1:FormatText(var_181_26.content)

				arg_178_1.text_.text = var_181_27

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_28 = 8
				local var_181_29 = utf8.len(var_181_27)
				local var_181_30 = var_181_28 <= 0 and var_181_24 or var_181_24 * (var_181_29 / var_181_28)

				if var_181_30 > 0 and var_181_24 < var_181_30 then
					arg_178_1.talkMaxDuration = var_181_30

					if var_181_30 + var_181_23 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_30 + var_181_23
					end
				end

				arg_178_1.text_.text = var_181_27
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082041", "story_v_out_413082.awb") ~= 0 then
					local var_181_31 = manager.audio:GetVoiceLength("story_v_out_413082", "413082041", "story_v_out_413082.awb") / 1000

					if var_181_31 + var_181_23 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_31 + var_181_23
					end

					if var_181_26.prefab_name ~= "" and arg_178_1.actors_[var_181_26.prefab_name] ~= nil then
						local var_181_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_26.prefab_name].transform, "story_v_out_413082", "413082041", "story_v_out_413082.awb")

						arg_178_1:RecordAudio("413082041", var_181_32)
						arg_178_1:RecordAudio("413082041", var_181_32)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_413082", "413082041", "story_v_out_413082.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_413082", "413082041", "story_v_out_413082.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_33 = math.max(var_181_24, arg_178_1.talkMaxDuration)

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_33 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_23) / var_181_33

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_23 + var_181_33 and arg_178_1.time_ < var_181_23 + var_181_33 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play413082042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 413082042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play413082043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10022"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10022 == nil then
				arg_182_1.var_.actorSpriteComps10022 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps10022 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 0.5, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10022 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10022 = nil
			end

			local var_185_8 = 0
			local var_185_9 = 1.7

			if var_185_8 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(413082042)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_12 = 68
				local var_185_13 = utf8.len(var_185_11)
				local var_185_14 = var_185_12 <= 0 and var_185_9 or var_185_9 * (var_185_13 / var_185_12)

				if var_185_14 > 0 and var_185_9 < var_185_14 then
					arg_182_1.talkMaxDuration = var_185_14

					if var_185_14 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_15 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_15 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_15

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_15 and arg_182_1.time_ < var_185_8 + var_185_15 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play413082043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 413082043
		arg_186_1.duration_ = 5.3

		local var_186_0 = {
			zh = 5.3,
			ja = 3.8
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play413082044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10022"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos10022 = var_189_0.localPosition
				var_189_0.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10022", 2)

				local var_189_2 = var_189_0.childCount

				for iter_189_0 = 0, var_189_2 - 1 do
					local var_189_3 = var_189_0:GetChild(iter_189_0)

					if var_189_3.name == "split_3" or not string.find(var_189_3.name, "split") then
						var_189_3.gameObject:SetActive(true)
					else
						var_189_3.gameObject:SetActive(false)
					end
				end
			end

			local var_189_4 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_4 then
				local var_189_5 = (arg_186_1.time_ - var_189_1) / var_189_4
				local var_189_6 = Vector3.New(-390, -315, -320)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10022, var_189_6, var_189_5)
			end

			if arg_186_1.time_ >= var_189_1 + var_189_4 and arg_186_1.time_ < var_189_1 + var_189_4 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_189_7 = arg_186_1.actors_["10022"]
			local var_189_8 = 0

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 and not isNil(var_189_7) and arg_186_1.var_.actorSpriteComps10022 == nil then
				arg_186_1.var_.actorSpriteComps10022 = var_189_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_9 = 2

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_9 and not isNil(var_189_7) then
				local var_189_10 = (arg_186_1.time_ - var_189_8) / var_189_9

				if arg_186_1.var_.actorSpriteComps10022 then
					for iter_189_1, iter_189_2 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_189_2 then
							if arg_186_1.isInRecall_ then
								local var_189_11 = Mathf.Lerp(iter_189_2.color.r, arg_186_1.hightColor1.r, var_189_10)
								local var_189_12 = Mathf.Lerp(iter_189_2.color.g, arg_186_1.hightColor1.g, var_189_10)
								local var_189_13 = Mathf.Lerp(iter_189_2.color.b, arg_186_1.hightColor1.b, var_189_10)

								iter_189_2.color = Color.New(var_189_11, var_189_12, var_189_13)
							else
								local var_189_14 = Mathf.Lerp(iter_189_2.color.r, 1, var_189_10)

								iter_189_2.color = Color.New(var_189_14, var_189_14, var_189_14)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_8 + var_189_9 and arg_186_1.time_ < var_189_8 + var_189_9 + arg_189_0 and not isNil(var_189_7) and arg_186_1.var_.actorSpriteComps10022 then
				for iter_189_3, iter_189_4 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_189_4 then
						if arg_186_1.isInRecall_ then
							iter_189_4.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10022 = nil
			end

			local var_189_15 = 0
			local var_189_16 = 0.625

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[614].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(413082043)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 25
				local var_189_21 = utf8.len(var_189_19)
				local var_189_22 = var_189_20 <= 0 and var_189_16 or var_189_16 * (var_189_21 / var_189_20)

				if var_189_22 > 0 and var_189_16 < var_189_22 then
					arg_186_1.talkMaxDuration = var_189_22

					if var_189_22 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_22 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_19
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082043", "story_v_out_413082.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082043", "story_v_out_413082.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_out_413082", "413082043", "story_v_out_413082.awb")

						arg_186_1:RecordAudio("413082043", var_189_24)
						arg_186_1:RecordAudio("413082043", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_413082", "413082043", "story_v_out_413082.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_413082", "413082043", "story_v_out_413082.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_25 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_25

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_25 and arg_186_1.time_ < var_189_15 + var_189_25 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413082044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 413082044
		arg_190_1.duration_ = 7.71

		local var_190_0 = {
			zh = 7.708,
			ja = 5.675
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play413082045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10022"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos10022 = var_193_0.localPosition
				var_193_0.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10022", 0)

				local var_193_2 = var_193_0.childCount

				for iter_193_0 = 0, var_193_2 - 1 do
					local var_193_3 = var_193_0:GetChild(iter_193_0)

					if var_193_3.name == "" or not string.find(var_193_3.name, "split") then
						var_193_3.gameObject:SetActive(true)
					else
						var_193_3.gameObject:SetActive(false)
					end
				end
			end

			local var_193_4 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_4 then
				local var_193_5 = (arg_190_1.time_ - var_193_1) / var_193_4
				local var_193_6 = Vector3.New(-5000, -315, -320)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10022, var_193_6, var_193_5)
			end

			if arg_190_1.time_ >= var_193_1 + var_193_4 and arg_190_1.time_ < var_193_1 + var_193_4 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_193_7 = "10092"

			if arg_190_1.actors_[var_193_7] == nil then
				local var_193_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_193_8) then
					local var_193_9 = Object.Instantiate(var_193_8, arg_190_1.canvasGo_.transform)

					var_193_9.transform:SetSiblingIndex(1)

					var_193_9.name = var_193_7
					var_193_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_190_1.actors_[var_193_7] = var_193_9

					local var_193_10 = var_193_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_190_1.isInRecall_ then
						for iter_193_1, iter_193_2 in ipairs(var_193_10) do
							iter_193_2.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_193_11 = arg_190_1.actors_["10092"].transform
			local var_193_12 = 0

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 then
				arg_190_1.var_.moveOldPos10092 = var_193_11.localPosition
				var_193_11.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10092", 0)

				local var_193_13 = var_193_11.childCount

				for iter_193_3 = 0, var_193_13 - 1 do
					local var_193_14 = var_193_11:GetChild(iter_193_3)

					if var_193_14.name == "" or not string.find(var_193_14.name, "split") then
						var_193_14.gameObject:SetActive(true)
					else
						var_193_14.gameObject:SetActive(false)
					end
				end
			end

			local var_193_15 = 0.001

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_15 then
				local var_193_16 = (arg_190_1.time_ - var_193_12) / var_193_15
				local var_193_17 = Vector3.New(-1500, -350, -180)

				var_193_11.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10092, var_193_17, var_193_16)
			end

			if arg_190_1.time_ >= var_193_12 + var_193_15 and arg_190_1.time_ < var_193_12 + var_193_15 + arg_193_0 then
				var_193_11.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_193_18 = arg_190_1.actors_["10094"].transform
			local var_193_19 = 0

			if var_193_19 < arg_190_1.time_ and arg_190_1.time_ <= var_193_19 + arg_193_0 then
				arg_190_1.var_.moveOldPos10094 = var_193_18.localPosition
				var_193_18.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10094", 3)

				local var_193_20 = var_193_18.childCount

				for iter_193_4 = 0, var_193_20 - 1 do
					local var_193_21 = var_193_18:GetChild(iter_193_4)

					if var_193_21.name == "" or not string.find(var_193_21.name, "split") then
						var_193_21.gameObject:SetActive(true)
					else
						var_193_21.gameObject:SetActive(false)
					end
				end
			end

			local var_193_22 = 0.001

			if var_193_19 <= arg_190_1.time_ and arg_190_1.time_ < var_193_19 + var_193_22 then
				local var_193_23 = (arg_190_1.time_ - var_193_19) / var_193_22
				local var_193_24 = Vector3.New(0, -340, -414)

				var_193_18.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10094, var_193_24, var_193_23)
			end

			if arg_190_1.time_ >= var_193_19 + var_193_22 and arg_190_1.time_ < var_193_19 + var_193_22 + arg_193_0 then
				var_193_18.localPosition = Vector3.New(0, -340, -414)
			end

			local var_193_25 = arg_190_1.actors_["10022"]
			local var_193_26 = 0

			if var_193_26 < arg_190_1.time_ and arg_190_1.time_ <= var_193_26 + arg_193_0 and not isNil(var_193_25) and arg_190_1.var_.actorSpriteComps10022 == nil then
				arg_190_1.var_.actorSpriteComps10022 = var_193_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_27 = 2

			if var_193_26 <= arg_190_1.time_ and arg_190_1.time_ < var_193_26 + var_193_27 and not isNil(var_193_25) then
				local var_193_28 = (arg_190_1.time_ - var_193_26) / var_193_27

				if arg_190_1.var_.actorSpriteComps10022 then
					for iter_193_5, iter_193_6 in pairs(arg_190_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_193_6 then
							if arg_190_1.isInRecall_ then
								local var_193_29 = Mathf.Lerp(iter_193_6.color.r, arg_190_1.hightColor2.r, var_193_28)
								local var_193_30 = Mathf.Lerp(iter_193_6.color.g, arg_190_1.hightColor2.g, var_193_28)
								local var_193_31 = Mathf.Lerp(iter_193_6.color.b, arg_190_1.hightColor2.b, var_193_28)

								iter_193_6.color = Color.New(var_193_29, var_193_30, var_193_31)
							else
								local var_193_32 = Mathf.Lerp(iter_193_6.color.r, 0.5, var_193_28)

								iter_193_6.color = Color.New(var_193_32, var_193_32, var_193_32)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_26 + var_193_27 and arg_190_1.time_ < var_193_26 + var_193_27 + arg_193_0 and not isNil(var_193_25) and arg_190_1.var_.actorSpriteComps10022 then
				for iter_193_7, iter_193_8 in pairs(arg_190_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_193_8 then
						if arg_190_1.isInRecall_ then
							iter_193_8.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10022 = nil
			end

			local var_193_33 = arg_190_1.actors_["10092"]
			local var_193_34 = 0

			if var_193_34 < arg_190_1.time_ and arg_190_1.time_ <= var_193_34 + arg_193_0 and not isNil(var_193_33) and arg_190_1.var_.actorSpriteComps10092 == nil then
				arg_190_1.var_.actorSpriteComps10092 = var_193_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_35 = 2

			if var_193_34 <= arg_190_1.time_ and arg_190_1.time_ < var_193_34 + var_193_35 and not isNil(var_193_33) then
				local var_193_36 = (arg_190_1.time_ - var_193_34) / var_193_35

				if arg_190_1.var_.actorSpriteComps10092 then
					for iter_193_9, iter_193_10 in pairs(arg_190_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_193_10 then
							if arg_190_1.isInRecall_ then
								local var_193_37 = Mathf.Lerp(iter_193_10.color.r, arg_190_1.hightColor2.r, var_193_36)
								local var_193_38 = Mathf.Lerp(iter_193_10.color.g, arg_190_1.hightColor2.g, var_193_36)
								local var_193_39 = Mathf.Lerp(iter_193_10.color.b, arg_190_1.hightColor2.b, var_193_36)

								iter_193_10.color = Color.New(var_193_37, var_193_38, var_193_39)
							else
								local var_193_40 = Mathf.Lerp(iter_193_10.color.r, 0.5, var_193_36)

								iter_193_10.color = Color.New(var_193_40, var_193_40, var_193_40)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_34 + var_193_35 and arg_190_1.time_ < var_193_34 + var_193_35 + arg_193_0 and not isNil(var_193_33) and arg_190_1.var_.actorSpriteComps10092 then
				for iter_193_11, iter_193_12 in pairs(arg_190_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_193_12 then
						if arg_190_1.isInRecall_ then
							iter_193_12.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10092 = nil
			end

			local var_193_41 = arg_190_1.actors_["10094"]
			local var_193_42 = 0

			if var_193_42 < arg_190_1.time_ and arg_190_1.time_ <= var_193_42 + arg_193_0 and not isNil(var_193_41) and arg_190_1.var_.actorSpriteComps10094 == nil then
				arg_190_1.var_.actorSpriteComps10094 = var_193_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_43 = 2

			if var_193_42 <= arg_190_1.time_ and arg_190_1.time_ < var_193_42 + var_193_43 and not isNil(var_193_41) then
				local var_193_44 = (arg_190_1.time_ - var_193_42) / var_193_43

				if arg_190_1.var_.actorSpriteComps10094 then
					for iter_193_13, iter_193_14 in pairs(arg_190_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_193_14 then
							if arg_190_1.isInRecall_ then
								local var_193_45 = Mathf.Lerp(iter_193_14.color.r, arg_190_1.hightColor1.r, var_193_44)
								local var_193_46 = Mathf.Lerp(iter_193_14.color.g, arg_190_1.hightColor1.g, var_193_44)
								local var_193_47 = Mathf.Lerp(iter_193_14.color.b, arg_190_1.hightColor1.b, var_193_44)

								iter_193_14.color = Color.New(var_193_45, var_193_46, var_193_47)
							else
								local var_193_48 = Mathf.Lerp(iter_193_14.color.r, 1, var_193_44)

								iter_193_14.color = Color.New(var_193_48, var_193_48, var_193_48)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_42 + var_193_43 and arg_190_1.time_ < var_193_42 + var_193_43 + arg_193_0 and not isNil(var_193_41) and arg_190_1.var_.actorSpriteComps10094 then
				for iter_193_15, iter_193_16 in pairs(arg_190_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_193_16 then
						if arg_190_1.isInRecall_ then
							iter_193_16.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10094 = nil
			end

			local var_193_49 = arg_190_1.actors_["10094"]
			local var_193_50 = 0

			if var_193_50 < arg_190_1.time_ and arg_190_1.time_ <= var_193_50 + arg_193_0 then
				local var_193_51 = var_193_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_193_51 then
					arg_190_1.var_.alphaOldValue10094 = var_193_51.alpha
					arg_190_1.var_.characterEffect10094 = var_193_51
				end

				arg_190_1.var_.alphaOldValue10094 = 0
			end

			local var_193_52 = 0.5

			if var_193_50 <= arg_190_1.time_ and arg_190_1.time_ < var_193_50 + var_193_52 then
				local var_193_53 = (arg_190_1.time_ - var_193_50) / var_193_52
				local var_193_54 = Mathf.Lerp(arg_190_1.var_.alphaOldValue10094, 1, var_193_53)

				if arg_190_1.var_.characterEffect10094 then
					arg_190_1.var_.characterEffect10094.alpha = var_193_54
				end
			end

			if arg_190_1.time_ >= var_193_50 + var_193_52 and arg_190_1.time_ < var_193_50 + var_193_52 + arg_193_0 and arg_190_1.var_.characterEffect10094 then
				arg_190_1.var_.characterEffect10094.alpha = 1
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_55 = 0.275
			local var_193_56 = 0.725

			if var_193_55 < arg_190_1.time_ and arg_190_1.time_ <= var_193_55 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_57 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_57:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_58 = arg_190_1:FormatText(StoryNameCfg[259].name)

				arg_190_1.leftNameTxt_.text = var_193_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_59 = arg_190_1:GetWordFromCfg(413082044)
				local var_193_60 = arg_190_1:FormatText(var_193_59.content)

				arg_190_1.text_.text = var_193_60

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_61 = 29
				local var_193_62 = utf8.len(var_193_60)
				local var_193_63 = var_193_61 <= 0 and var_193_56 or var_193_56 * (var_193_62 / var_193_61)

				if var_193_63 > 0 and var_193_56 < var_193_63 then
					arg_190_1.talkMaxDuration = var_193_63
					var_193_55 = var_193_55 + 0.3

					if var_193_63 + var_193_55 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_63 + var_193_55
					end
				end

				arg_190_1.text_.text = var_193_60
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082044", "story_v_out_413082.awb") ~= 0 then
					local var_193_64 = manager.audio:GetVoiceLength("story_v_out_413082", "413082044", "story_v_out_413082.awb") / 1000

					if var_193_64 + var_193_55 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_64 + var_193_55
					end

					if var_193_59.prefab_name ~= "" and arg_190_1.actors_[var_193_59.prefab_name] ~= nil then
						local var_193_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_59.prefab_name].transform, "story_v_out_413082", "413082044", "story_v_out_413082.awb")

						arg_190_1:RecordAudio("413082044", var_193_65)
						arg_190_1:RecordAudio("413082044", var_193_65)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_413082", "413082044", "story_v_out_413082.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_413082", "413082044", "story_v_out_413082.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_66 = var_193_55 + 0.3
			local var_193_67 = math.max(var_193_56, arg_190_1.talkMaxDuration)

			if var_193_66 <= arg_190_1.time_ and arg_190_1.time_ < var_193_66 + var_193_67 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_66) / var_193_67

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_66 + var_193_67 and arg_190_1.time_ < var_193_66 + var_193_67 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play413082045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413082045
		arg_196_1.duration_ = 10.5

		local var_196_0 = {
			zh = 5.466,
			ja = 10.5
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play413082046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.625

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[259].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(413082045)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 25
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082045", "story_v_out_413082.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082045", "story_v_out_413082.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_413082", "413082045", "story_v_out_413082.awb")

						arg_196_1:RecordAudio("413082045", var_199_9)
						arg_196_1:RecordAudio("413082045", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413082", "413082045", "story_v_out_413082.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413082", "413082045", "story_v_out_413082.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play413082046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413082046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413082047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10094"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10094 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10094", 7)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(0, -2000, 0)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10094, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_7 = arg_200_1.actors_["10094"]
			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps10094 == nil then
				arg_200_1.var_.actorSpriteComps10094 = var_203_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_9 = 2

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 and not isNil(var_203_7) then
				local var_203_10 = (arg_200_1.time_ - var_203_8) / var_203_9

				if arg_200_1.var_.actorSpriteComps10094 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								local var_203_11 = Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor2.r, var_203_10)
								local var_203_12 = Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor2.g, var_203_10)
								local var_203_13 = Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor2.b, var_203_10)

								iter_203_2.color = Color.New(var_203_11, var_203_12, var_203_13)
							else
								local var_203_14 = Mathf.Lerp(iter_203_2.color.r, 0.5, var_203_10)

								iter_203_2.color = Color.New(var_203_14, var_203_14, var_203_14)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps10094 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_203_4 then
						if arg_200_1.isInRecall_ then
							iter_203_4.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10094 = nil
			end

			local var_203_15 = 0
			local var_203_16 = 1.675

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_17 = arg_200_1:GetWordFromCfg(413082046)
				local var_203_18 = arg_200_1:FormatText(var_203_17.content)

				arg_200_1.text_.text = var_203_18

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_19 = 67
				local var_203_20 = utf8.len(var_203_18)
				local var_203_21 = var_203_19 <= 0 and var_203_16 or var_203_16 * (var_203_20 / var_203_19)

				if var_203_21 > 0 and var_203_16 < var_203_21 then
					arg_200_1.talkMaxDuration = var_203_21

					if var_203_21 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_21 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_18
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_22 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_22 and arg_200_1.time_ < var_203_15 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play413082047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413082047
		arg_204_1.duration_ = 2.87

		local var_204_0 = {
			zh = 2.866,
			ja = 2.633
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413082048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10022"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos10022 = var_207_0.localPosition
				var_207_0.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10022", 3)

				local var_207_2 = var_207_0.childCount

				for iter_207_0 = 0, var_207_2 - 1 do
					local var_207_3 = var_207_0:GetChild(iter_207_0)

					if var_207_3.name == "split_8" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_4 then
				local var_207_5 = (arg_204_1.time_ - var_207_1) / var_207_4
				local var_207_6 = Vector3.New(0, -315, -320)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10022, var_207_6, var_207_5)
			end

			if arg_204_1.time_ >= var_207_1 + var_207_4 and arg_204_1.time_ < var_207_1 + var_207_4 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_207_7 = arg_204_1.actors_["10022"]
			local var_207_8 = 0

			if var_207_8 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 and not isNil(var_207_7) and arg_204_1.var_.actorSpriteComps10022 == nil then
				arg_204_1.var_.actorSpriteComps10022 = var_207_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_9 = 2

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_9 and not isNil(var_207_7) then
				local var_207_10 = (arg_204_1.time_ - var_207_8) / var_207_9

				if arg_204_1.var_.actorSpriteComps10022 then
					for iter_207_1, iter_207_2 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_207_2 then
							if arg_204_1.isInRecall_ then
								local var_207_11 = Mathf.Lerp(iter_207_2.color.r, arg_204_1.hightColor1.r, var_207_10)
								local var_207_12 = Mathf.Lerp(iter_207_2.color.g, arg_204_1.hightColor1.g, var_207_10)
								local var_207_13 = Mathf.Lerp(iter_207_2.color.b, arg_204_1.hightColor1.b, var_207_10)

								iter_207_2.color = Color.New(var_207_11, var_207_12, var_207_13)
							else
								local var_207_14 = Mathf.Lerp(iter_207_2.color.r, 1, var_207_10)

								iter_207_2.color = Color.New(var_207_14, var_207_14, var_207_14)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_8 + var_207_9 and arg_204_1.time_ < var_207_8 + var_207_9 + arg_207_0 and not isNil(var_207_7) and arg_204_1.var_.actorSpriteComps10022 then
				for iter_207_3, iter_207_4 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_207_4 then
						if arg_204_1.isInRecall_ then
							iter_207_4.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10022 = nil
			end

			local var_207_15 = 0
			local var_207_16 = 0.425

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[614].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(413082047)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 17
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082047", "story_v_out_413082.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082047", "story_v_out_413082.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_413082", "413082047", "story_v_out_413082.awb")

						arg_204_1:RecordAudio("413082047", var_207_24)
						arg_204_1:RecordAudio("413082047", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_413082", "413082047", "story_v_out_413082.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_413082", "413082047", "story_v_out_413082.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play413082048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413082048
		arg_208_1.duration_ = 6.9

		local var_208_0 = {
			zh = 4.1,
			ja = 6.9
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play413082049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10022"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps10022 == nil then
				arg_208_1.var_.actorSpriteComps10022 = var_211_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_2 = 2

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.actorSpriteComps10022 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								local var_211_4 = Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor2.r, var_211_3)
								local var_211_5 = Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor2.g, var_211_3)
								local var_211_6 = Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor2.b, var_211_3)

								iter_211_1.color = Color.New(var_211_4, var_211_5, var_211_6)
							else
								local var_211_7 = Mathf.Lerp(iter_211_1.color.r, 0.5, var_211_3)

								iter_211_1.color = Color.New(var_211_7, var_211_7, var_211_7)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps10022 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_211_3 then
						if arg_208_1.isInRecall_ then
							iter_211_3.color = arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_211_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10022 = nil
			end

			local var_211_8 = 0
			local var_211_9 = 0.525

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_10 = arg_208_1:FormatText(StoryNameCfg[996].name)

				arg_208_1.leftNameTxt_.text = var_211_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_208_1.callingController_:SetSelectedState("calling")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_11 = arg_208_1:GetWordFromCfg(413082048)
				local var_211_12 = arg_208_1:FormatText(var_211_11.content)

				arg_208_1.text_.text = var_211_12

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_13 = 21
				local var_211_14 = utf8.len(var_211_12)
				local var_211_15 = var_211_13 <= 0 and var_211_9 or var_211_9 * (var_211_14 / var_211_13)

				if var_211_15 > 0 and var_211_9 < var_211_15 then
					arg_208_1.talkMaxDuration = var_211_15

					if var_211_15 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_15 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_12
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082048", "story_v_out_413082.awb") ~= 0 then
					local var_211_16 = manager.audio:GetVoiceLength("story_v_out_413082", "413082048", "story_v_out_413082.awb") / 1000

					if var_211_16 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_8
					end

					if var_211_11.prefab_name ~= "" and arg_208_1.actors_[var_211_11.prefab_name] ~= nil then
						local var_211_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_11.prefab_name].transform, "story_v_out_413082", "413082048", "story_v_out_413082.awb")

						arg_208_1:RecordAudio("413082048", var_211_17)
						arg_208_1:RecordAudio("413082048", var_211_17)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413082", "413082048", "story_v_out_413082.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413082", "413082048", "story_v_out_413082.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_18 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_18 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_8) / var_211_18

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_8 + var_211_18 and arg_208_1.time_ < var_211_8 + var_211_18 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play413082049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413082049
		arg_212_1.duration_ = 8.8

		local var_212_0 = {
			zh = 3.8,
			ja = 8.8
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play413082050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.575

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[996].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_212_1.callingController_:SetSelectedState("calling")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:GetWordFromCfg(413082049)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 23
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082049", "story_v_out_413082.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082049", "story_v_out_413082.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_413082", "413082049", "story_v_out_413082.awb")

						arg_212_1:RecordAudio("413082049", var_215_9)
						arg_212_1:RecordAudio("413082049", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413082", "413082049", "story_v_out_413082.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413082", "413082049", "story_v_out_413082.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play413082050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413082050
		arg_216_1.duration_ = 3.67

		local var_216_0 = {
			zh = 2.6,
			ja = 3.666
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play413082051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10022"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps10022 == nil then
				arg_216_1.var_.actorSpriteComps10022 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps10022 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 1, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps10022 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10022 = nil
			end

			local var_219_8 = 0
			local var_219_9 = 0.375

			if var_219_8 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_10 = arg_216_1:FormatText(StoryNameCfg[614].name)

				arg_216_1.leftNameTxt_.text = var_219_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_11 = arg_216_1:GetWordFromCfg(413082050)
				local var_219_12 = arg_216_1:FormatText(var_219_11.content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 15
				local var_219_14 = utf8.len(var_219_12)
				local var_219_15 = var_219_13 <= 0 and var_219_9 or var_219_9 * (var_219_14 / var_219_13)

				if var_219_15 > 0 and var_219_9 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082050", "story_v_out_413082.awb") ~= 0 then
					local var_219_16 = manager.audio:GetVoiceLength("story_v_out_413082", "413082050", "story_v_out_413082.awb") / 1000

					if var_219_16 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_8
					end

					if var_219_11.prefab_name ~= "" and arg_216_1.actors_[var_219_11.prefab_name] ~= nil then
						local var_219_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_11.prefab_name].transform, "story_v_out_413082", "413082050", "story_v_out_413082.awb")

						arg_216_1:RecordAudio("413082050", var_219_17)
						arg_216_1:RecordAudio("413082050", var_219_17)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413082", "413082050", "story_v_out_413082.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413082", "413082050", "story_v_out_413082.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_18 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_18 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_18

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_18 and arg_216_1.time_ < var_219_8 + var_219_18 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play413082051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413082051
		arg_220_1.duration_ = 10.7

		local var_220_0 = {
			zh = 5.366,
			ja = 10.7
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play413082052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10022"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 0.5, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_8 = 0
			local var_223_9 = 0.775

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_10 = arg_220_1:FormatText(StoryNameCfg[996].name)

				arg_220_1.leftNameTxt_.text = var_223_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_220_1.callingController_:SetSelectedState("calling")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_11 = arg_220_1:GetWordFromCfg(413082051)
				local var_223_12 = arg_220_1:FormatText(var_223_11.content)

				arg_220_1.text_.text = var_223_12

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 31
				local var_223_14 = utf8.len(var_223_12)
				local var_223_15 = var_223_13 <= 0 and var_223_9 or var_223_9 * (var_223_14 / var_223_13)

				if var_223_15 > 0 and var_223_9 < var_223_15 then
					arg_220_1.talkMaxDuration = var_223_15

					if var_223_15 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_15 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_12
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082051", "story_v_out_413082.awb") ~= 0 then
					local var_223_16 = manager.audio:GetVoiceLength("story_v_out_413082", "413082051", "story_v_out_413082.awb") / 1000

					if var_223_16 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_16 + var_223_8
					end

					if var_223_11.prefab_name ~= "" and arg_220_1.actors_[var_223_11.prefab_name] ~= nil then
						local var_223_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_11.prefab_name].transform, "story_v_out_413082", "413082051", "story_v_out_413082.awb")

						arg_220_1:RecordAudio("413082051", var_223_17)
						arg_220_1:RecordAudio("413082051", var_223_17)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413082", "413082051", "story_v_out_413082.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413082", "413082051", "story_v_out_413082.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_18 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_18 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_18

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_18 and arg_220_1.time_ < var_223_8 + var_223_18 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play413082052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413082052
		arg_224_1.duration_ = 11.57

		local var_224_0 = {
			zh = 5.033,
			ja = 11.566
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play413082053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.75

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[996].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_224_1.callingController_:SetSelectedState("calling")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(413082052)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 30
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082052", "story_v_out_413082.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082052", "story_v_out_413082.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_413082", "413082052", "story_v_out_413082.awb")

						arg_224_1:RecordAudio("413082052", var_227_9)
						arg_224_1:RecordAudio("413082052", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413082", "413082052", "story_v_out_413082.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413082", "413082052", "story_v_out_413082.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play413082053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413082053
		arg_228_1.duration_ = 5.43

		local var_228_0 = {
			zh = 5.166,
			ja = 5.433
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play413082054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10022"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10022 = var_231_0.localPosition
				var_231_0.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10022", 0)

				local var_231_2 = var_231_0.childCount

				for iter_231_0 = 0, var_231_2 - 1 do
					local var_231_3 = var_231_0:GetChild(iter_231_0)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_4 then
				local var_231_5 = (arg_228_1.time_ - var_231_1) / var_231_4
				local var_231_6 = Vector3.New(-5000, -315, -320)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10022, var_231_6, var_231_5)
			end

			if arg_228_1.time_ >= var_231_1 + var_231_4 and arg_228_1.time_ < var_231_1 + var_231_4 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_231_7 = arg_228_1.actors_["10092"].transform
			local var_231_8 = 0

			if var_231_8 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.var_.moveOldPos10092 = var_231_7.localPosition
				var_231_7.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10092", 0)

				local var_231_9 = var_231_7.childCount

				for iter_231_1 = 0, var_231_9 - 1 do
					local var_231_10 = var_231_7:GetChild(iter_231_1)

					if var_231_10.name == "" or not string.find(var_231_10.name, "split") then
						var_231_10.gameObject:SetActive(true)
					else
						var_231_10.gameObject:SetActive(false)
					end
				end
			end

			local var_231_11 = 0.001

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_11 then
				local var_231_12 = (arg_228_1.time_ - var_231_8) / var_231_11
				local var_231_13 = Vector3.New(-1500, -350, -180)

				var_231_7.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10092, var_231_13, var_231_12)
			end

			if arg_228_1.time_ >= var_231_8 + var_231_11 and arg_228_1.time_ < var_231_8 + var_231_11 + arg_231_0 then
				var_231_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_14 = arg_228_1.actors_["10094"].transform
			local var_231_15 = 0

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1.var_.moveOldPos10094 = var_231_14.localPosition
				var_231_14.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10094", 3)

				local var_231_16 = var_231_14.childCount

				for iter_231_2 = 0, var_231_16 - 1 do
					local var_231_17 = var_231_14:GetChild(iter_231_2)

					if var_231_17.name == "split_2" or not string.find(var_231_17.name, "split") then
						var_231_17.gameObject:SetActive(true)
					else
						var_231_17.gameObject:SetActive(false)
					end
				end
			end

			local var_231_18 = 0.001

			if var_231_15 <= arg_228_1.time_ and arg_228_1.time_ < var_231_15 + var_231_18 then
				local var_231_19 = (arg_228_1.time_ - var_231_15) / var_231_18
				local var_231_20 = Vector3.New(0, -340, -414)

				var_231_14.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10094, var_231_20, var_231_19)
			end

			if arg_228_1.time_ >= var_231_15 + var_231_18 and arg_228_1.time_ < var_231_15 + var_231_18 + arg_231_0 then
				var_231_14.localPosition = Vector3.New(0, -340, -414)
			end

			local var_231_21 = arg_228_1.actors_["10022"]
			local var_231_22 = 0

			if var_231_22 < arg_228_1.time_ and arg_228_1.time_ <= var_231_22 + arg_231_0 and not isNil(var_231_21) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_23 = 2

			if var_231_22 <= arg_228_1.time_ and arg_228_1.time_ < var_231_22 + var_231_23 and not isNil(var_231_21) then
				local var_231_24 = (arg_228_1.time_ - var_231_22) / var_231_23

				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_4 then
							if arg_228_1.isInRecall_ then
								local var_231_25 = Mathf.Lerp(iter_231_4.color.r, arg_228_1.hightColor2.r, var_231_24)
								local var_231_26 = Mathf.Lerp(iter_231_4.color.g, arg_228_1.hightColor2.g, var_231_24)
								local var_231_27 = Mathf.Lerp(iter_231_4.color.b, arg_228_1.hightColor2.b, var_231_24)

								iter_231_4.color = Color.New(var_231_25, var_231_26, var_231_27)
							else
								local var_231_28 = Mathf.Lerp(iter_231_4.color.r, 0.5, var_231_24)

								iter_231_4.color = Color.New(var_231_28, var_231_28, var_231_28)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_22 + var_231_23 and arg_228_1.time_ < var_231_22 + var_231_23 + arg_231_0 and not isNil(var_231_21) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_6 then
						if arg_228_1.isInRecall_ then
							iter_231_6.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_29 = arg_228_1.actors_["10092"]
			local var_231_30 = 0

			if var_231_30 < arg_228_1.time_ and arg_228_1.time_ <= var_231_30 + arg_231_0 and not isNil(var_231_29) and arg_228_1.var_.actorSpriteComps10092 == nil then
				arg_228_1.var_.actorSpriteComps10092 = var_231_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_31 = 2

			if var_231_30 <= arg_228_1.time_ and arg_228_1.time_ < var_231_30 + var_231_31 and not isNil(var_231_29) then
				local var_231_32 = (arg_228_1.time_ - var_231_30) / var_231_31

				if arg_228_1.var_.actorSpriteComps10092 then
					for iter_231_7, iter_231_8 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_231_8 then
							if arg_228_1.isInRecall_ then
								local var_231_33 = Mathf.Lerp(iter_231_8.color.r, arg_228_1.hightColor2.r, var_231_32)
								local var_231_34 = Mathf.Lerp(iter_231_8.color.g, arg_228_1.hightColor2.g, var_231_32)
								local var_231_35 = Mathf.Lerp(iter_231_8.color.b, arg_228_1.hightColor2.b, var_231_32)

								iter_231_8.color = Color.New(var_231_33, var_231_34, var_231_35)
							else
								local var_231_36 = Mathf.Lerp(iter_231_8.color.r, 0.5, var_231_32)

								iter_231_8.color = Color.New(var_231_36, var_231_36, var_231_36)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_30 + var_231_31 and arg_228_1.time_ < var_231_30 + var_231_31 + arg_231_0 and not isNil(var_231_29) and arg_228_1.var_.actorSpriteComps10092 then
				for iter_231_9, iter_231_10 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_231_10 then
						if arg_228_1.isInRecall_ then
							iter_231_10.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10092 = nil
			end

			local var_231_37 = arg_228_1.actors_["10094"]
			local var_231_38 = 0

			if var_231_38 < arg_228_1.time_ and arg_228_1.time_ <= var_231_38 + arg_231_0 and not isNil(var_231_37) and arg_228_1.var_.actorSpriteComps10094 == nil then
				arg_228_1.var_.actorSpriteComps10094 = var_231_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_39 = 2

			if var_231_38 <= arg_228_1.time_ and arg_228_1.time_ < var_231_38 + var_231_39 and not isNil(var_231_37) then
				local var_231_40 = (arg_228_1.time_ - var_231_38) / var_231_39

				if arg_228_1.var_.actorSpriteComps10094 then
					for iter_231_11, iter_231_12 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_231_12 then
							if arg_228_1.isInRecall_ then
								local var_231_41 = Mathf.Lerp(iter_231_12.color.r, arg_228_1.hightColor1.r, var_231_40)
								local var_231_42 = Mathf.Lerp(iter_231_12.color.g, arg_228_1.hightColor1.g, var_231_40)
								local var_231_43 = Mathf.Lerp(iter_231_12.color.b, arg_228_1.hightColor1.b, var_231_40)

								iter_231_12.color = Color.New(var_231_41, var_231_42, var_231_43)
							else
								local var_231_44 = Mathf.Lerp(iter_231_12.color.r, 1, var_231_40)

								iter_231_12.color = Color.New(var_231_44, var_231_44, var_231_44)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_38 + var_231_39 and arg_228_1.time_ < var_231_38 + var_231_39 + arg_231_0 and not isNil(var_231_37) and arg_228_1.var_.actorSpriteComps10094 then
				for iter_231_13, iter_231_14 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_231_14 then
						if arg_228_1.isInRecall_ then
							iter_231_14.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10094 = nil
			end

			local var_231_45 = 0
			local var_231_46 = 0.5

			if var_231_45 < arg_228_1.time_ and arg_228_1.time_ <= var_231_45 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_47 = arg_228_1:FormatText(StoryNameCfg[259].name)

				arg_228_1.leftNameTxt_.text = var_231_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_48 = arg_228_1:GetWordFromCfg(413082053)
				local var_231_49 = arg_228_1:FormatText(var_231_48.content)

				arg_228_1.text_.text = var_231_49

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_50 = 20
				local var_231_51 = utf8.len(var_231_49)
				local var_231_52 = var_231_50 <= 0 and var_231_46 or var_231_46 * (var_231_51 / var_231_50)

				if var_231_52 > 0 and var_231_46 < var_231_52 then
					arg_228_1.talkMaxDuration = var_231_52

					if var_231_52 + var_231_45 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_52 + var_231_45
					end
				end

				arg_228_1.text_.text = var_231_49
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082053", "story_v_out_413082.awb") ~= 0 then
					local var_231_53 = manager.audio:GetVoiceLength("story_v_out_413082", "413082053", "story_v_out_413082.awb") / 1000

					if var_231_53 + var_231_45 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_53 + var_231_45
					end

					if var_231_48.prefab_name ~= "" and arg_228_1.actors_[var_231_48.prefab_name] ~= nil then
						local var_231_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_48.prefab_name].transform, "story_v_out_413082", "413082053", "story_v_out_413082.awb")

						arg_228_1:RecordAudio("413082053", var_231_54)
						arg_228_1:RecordAudio("413082053", var_231_54)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413082", "413082053", "story_v_out_413082.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413082", "413082053", "story_v_out_413082.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_55 = math.max(var_231_46, arg_228_1.talkMaxDuration)

			if var_231_45 <= arg_228_1.time_ and arg_228_1.time_ < var_231_45 + var_231_55 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_45) / var_231_55

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_45 + var_231_55 and arg_228_1.time_ < var_231_45 + var_231_55 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play413082054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413082054
		arg_232_1.duration_ = 2

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play413082055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10022"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = var_235_0.localPosition
				var_235_0.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 4)

				local var_235_2 = var_235_0.childCount

				for iter_235_0 = 0, var_235_2 - 1 do
					local var_235_3 = var_235_0:GetChild(iter_235_0)

					if var_235_3.name == "split_6" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_4 then
				local var_235_5 = (arg_232_1.time_ - var_235_1) / var_235_4
				local var_235_6 = Vector3.New(390, -315, -320)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, var_235_6, var_235_5)
			end

			if arg_232_1.time_ >= var_235_1 + var_235_4 and arg_232_1.time_ < var_235_1 + var_235_4 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_235_7 = arg_232_1.actors_["10094"].transform
			local var_235_8 = 0

			if var_235_8 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.var_.moveOldPos10094 = var_235_7.localPosition
				var_235_7.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10094", 2)

				local var_235_9 = var_235_7.childCount

				for iter_235_1 = 0, var_235_9 - 1 do
					local var_235_10 = var_235_7:GetChild(iter_235_1)

					if var_235_10.name == "split_2" or not string.find(var_235_10.name, "split") then
						var_235_10.gameObject:SetActive(true)
					else
						var_235_10.gameObject:SetActive(false)
					end
				end
			end

			local var_235_11 = 0.001

			if var_235_8 <= arg_232_1.time_ and arg_232_1.time_ < var_235_8 + var_235_11 then
				local var_235_12 = (arg_232_1.time_ - var_235_8) / var_235_11
				local var_235_13 = Vector3.New(-390, -340, -414)

				var_235_7.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10094, var_235_13, var_235_12)
			end

			if arg_232_1.time_ >= var_235_8 + var_235_11 and arg_232_1.time_ < var_235_8 + var_235_11 + arg_235_0 then
				var_235_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_235_14 = arg_232_1.actors_["10022"]
			local var_235_15 = 0

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_16 = 2

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_16 and not isNil(var_235_14) then
				local var_235_17 = (arg_232_1.time_ - var_235_15) / var_235_16

				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								local var_235_18 = Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor1.r, var_235_17)
								local var_235_19 = Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor1.g, var_235_17)
								local var_235_20 = Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor1.b, var_235_17)

								iter_235_3.color = Color.New(var_235_18, var_235_19, var_235_20)
							else
								local var_235_21 = Mathf.Lerp(iter_235_3.color.r, 1, var_235_17)

								iter_235_3.color = Color.New(var_235_21, var_235_21, var_235_21)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_15 + var_235_16 and arg_232_1.time_ < var_235_15 + var_235_16 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_5 then
						if arg_232_1.isInRecall_ then
							iter_235_5.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_22 = arg_232_1.actors_["10094"]
			local var_235_23 = 0

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10094 == nil then
				arg_232_1.var_.actorSpriteComps10094 = var_235_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_24 = 2

			if var_235_23 <= arg_232_1.time_ and arg_232_1.time_ < var_235_23 + var_235_24 and not isNil(var_235_22) then
				local var_235_25 = (arg_232_1.time_ - var_235_23) / var_235_24

				if arg_232_1.var_.actorSpriteComps10094 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								local var_235_26 = Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor2.r, var_235_25)
								local var_235_27 = Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor2.g, var_235_25)
								local var_235_28 = Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor2.b, var_235_25)

								iter_235_7.color = Color.New(var_235_26, var_235_27, var_235_28)
							else
								local var_235_29 = Mathf.Lerp(iter_235_7.color.r, 0.5, var_235_25)

								iter_235_7.color = Color.New(var_235_29, var_235_29, var_235_29)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_23 + var_235_24 and arg_232_1.time_ < var_235_23 + var_235_24 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10094 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_235_9 then
						if arg_232_1.isInRecall_ then
							iter_235_9.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10094 = nil
			end

			local var_235_30 = 0
			local var_235_31 = 0.075

			if var_235_30 < arg_232_1.time_ and arg_232_1.time_ <= var_235_30 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_32 = arg_232_1:FormatText(StoryNameCfg[614].name)

				arg_232_1.leftNameTxt_.text = var_235_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_33 = arg_232_1:GetWordFromCfg(413082054)
				local var_235_34 = arg_232_1:FormatText(var_235_33.content)

				arg_232_1.text_.text = var_235_34

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_35 = 3
				local var_235_36 = utf8.len(var_235_34)
				local var_235_37 = var_235_35 <= 0 and var_235_31 or var_235_31 * (var_235_36 / var_235_35)

				if var_235_37 > 0 and var_235_31 < var_235_37 then
					arg_232_1.talkMaxDuration = var_235_37

					if var_235_37 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_37 + var_235_30
					end
				end

				arg_232_1.text_.text = var_235_34
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082054", "story_v_out_413082.awb") ~= 0 then
					local var_235_38 = manager.audio:GetVoiceLength("story_v_out_413082", "413082054", "story_v_out_413082.awb") / 1000

					if var_235_38 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_38 + var_235_30
					end

					if var_235_33.prefab_name ~= "" and arg_232_1.actors_[var_235_33.prefab_name] ~= nil then
						local var_235_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_33.prefab_name].transform, "story_v_out_413082", "413082054", "story_v_out_413082.awb")

						arg_232_1:RecordAudio("413082054", var_235_39)
						arg_232_1:RecordAudio("413082054", var_235_39)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413082", "413082054", "story_v_out_413082.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413082", "413082054", "story_v_out_413082.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_40 = math.max(var_235_31, arg_232_1.talkMaxDuration)

			if var_235_30 <= arg_232_1.time_ and arg_232_1.time_ < var_235_30 + var_235_40 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_30) / var_235_40

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_30 + var_235_40 and arg_232_1.time_ < var_235_30 + var_235_40 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play413082055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413082055
		arg_236_1.duration_ = 2.47

		local var_236_0 = {
			zh = 2.333,
			ja = 2.466
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413082056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10094"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10094 == nil then
				arg_236_1.var_.actorSpriteComps10094 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps10094 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 1, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10094 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10094 = nil
			end

			local var_239_8 = arg_236_1.actors_["10022"]
			local var_239_9 = 0

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_10 = 2

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_10 and not isNil(var_239_8) then
				local var_239_11 = (arg_236_1.time_ - var_239_9) / var_239_10

				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								local var_239_12 = Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor2.r, var_239_11)
								local var_239_13 = Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor2.g, var_239_11)
								local var_239_14 = Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor2.b, var_239_11)

								iter_239_5.color = Color.New(var_239_12, var_239_13, var_239_14)
							else
								local var_239_15 = Mathf.Lerp(iter_239_5.color.r, 0.5, var_239_11)

								iter_239_5.color = Color.New(var_239_15, var_239_15, var_239_15)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_9 + var_239_10 and arg_236_1.time_ < var_239_9 + var_239_10 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_7 then
						if arg_236_1.isInRecall_ then
							iter_239_7.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_16 = 0
			local var_239_17 = 0.25

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_18 = arg_236_1:FormatText(StoryNameCfg[259].name)

				arg_236_1.leftNameTxt_.text = var_239_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_19 = arg_236_1:GetWordFromCfg(413082055)
				local var_239_20 = arg_236_1:FormatText(var_239_19.content)

				arg_236_1.text_.text = var_239_20

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_21 = 10
				local var_239_22 = utf8.len(var_239_20)
				local var_239_23 = var_239_21 <= 0 and var_239_17 or var_239_17 * (var_239_22 / var_239_21)

				if var_239_23 > 0 and var_239_17 < var_239_23 then
					arg_236_1.talkMaxDuration = var_239_23

					if var_239_23 + var_239_16 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_23 + var_239_16
					end
				end

				arg_236_1.text_.text = var_239_20
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082055", "story_v_out_413082.awb") ~= 0 then
					local var_239_24 = manager.audio:GetVoiceLength("story_v_out_413082", "413082055", "story_v_out_413082.awb") / 1000

					if var_239_24 + var_239_16 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_24 + var_239_16
					end

					if var_239_19.prefab_name ~= "" and arg_236_1.actors_[var_239_19.prefab_name] ~= nil then
						local var_239_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_19.prefab_name].transform, "story_v_out_413082", "413082055", "story_v_out_413082.awb")

						arg_236_1:RecordAudio("413082055", var_239_25)
						arg_236_1:RecordAudio("413082055", var_239_25)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413082", "413082055", "story_v_out_413082.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413082", "413082055", "story_v_out_413082.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_26 = math.max(var_239_17, arg_236_1.talkMaxDuration)

			if var_239_16 <= arg_236_1.time_ and arg_236_1.time_ < var_239_16 + var_239_26 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_16) / var_239_26

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_16 + var_239_26 and arg_236_1.time_ < var_239_16 + var_239_26 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413082056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413082056
		arg_240_1.duration_ = 4.87

		local var_240_0 = {
			zh = 4.433,
			ja = 4.866
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413082057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.575

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[259].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(413082056)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 23
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082056", "story_v_out_413082.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082056", "story_v_out_413082.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_413082", "413082056", "story_v_out_413082.awb")

						arg_240_1:RecordAudio("413082056", var_243_9)
						arg_240_1:RecordAudio("413082056", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413082", "413082056", "story_v_out_413082.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413082", "413082056", "story_v_out_413082.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413082057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413082057
		arg_244_1.duration_ = 5

		local var_244_0 = {
			zh = 5,
			ja = 4.5
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
			arg_244_1.auto_ = false
		end

		function arg_244_1.playNext_(arg_246_0)
			arg_244_1.onStoryFinished_()
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.5

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[259].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(413082057)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 20
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082057", "story_v_out_413082.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082057", "story_v_out_413082.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_413082", "413082057", "story_v_out_413082.awb")

						arg_244_1:RecordAudio("413082057", var_247_9)
						arg_244_1:RecordAudio("413082057", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_413082", "413082057", "story_v_out_413082.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_413082", "413082057", "story_v_out_413082.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/SS1306"
	},
	voices = {
		"story_v_out_413082.awb"
	}
}
