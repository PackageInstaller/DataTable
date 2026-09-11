return {
	Play417111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417111001
		arg_1_1.duration_ = 9.52

		local var_1_0 = {
			zh = 7.51666666666667,
			ja = 9.51666666666667
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
				arg_1_0:Play417111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_4_0.name = "I07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07a

				arg_1_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 5.56666666666667

			if 5.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = "10072"

			if arg_1_1.actors_["10072"] == nil then
				local var_4_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10072")

				if not isNil(var_4_6) then
					local var_4_7 = Object.Instantiate(var_4_6, arg_1_1.canvasGo_.transform)

					var_4_7.transform:SetSiblingIndex(1)

					var_4_7.name = var_4_5
					var_4_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_5] = var_4_7

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_8 = arg_1_1.actors_["10072"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps10072 == nil then
				arg_1_1.var_.actorSpriteComps10072 = var_4_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_9 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.actorSpriteComps10072 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10072:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_9), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_9), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_9)))
							else
								local var_4_10 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 0) / var_4_9)

								iter_4_5.color = Color.New(var_4_10, var_4_10, var_4_10)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps10072 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10072:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10072 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501040).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_17 + 3 and arg_1_1.time_ < var_4_17 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_18 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 1.2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = Color.New(0, 0, 0)

				var_4_20.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_18) / var_4_19)
				arg_1_1.mask_.color = var_4_20
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = 1
				arg_1_1.mask_.color = var_4_21
			end

			local var_4_22 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_23 = 1.2

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = Color.New(0, 0, 0)

				var_4_24.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_22) / var_4_23)
				arg_1_1.mask_.color = var_4_24
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				local var_4_25 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_25.a = 0
				arg_1_1.mask_.color = var_4_25
			end

			local var_4_26 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_27 = 1

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = Color.New(0, 0, 0)

				var_4_28.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_26) / var_4_27)
				arg_1_1.mask_.color = var_4_28
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				local var_4_29 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_29.a = 0
				arg_1_1.mask_.color = var_4_29
			end

			local var_4_30 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_30 + 3 and arg_1_1.time_ < var_4_30 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_31 = 5.61666666666667
			local var_4_32 = 0.25

			if 5.61666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1136].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_34 = arg_1_1:GetWordFromCfg(417111001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 10 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 10)

				if (10 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 10)) > 0 and var_4_32 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_31 = var_4_31 + 0.3

					if var_4_37 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111001", "story_v_out_417111.awb") ~= 0 then
					local var_4_38 = manager.audio:GetVoiceLength("story_v_out_417111", "417111001", "story_v_out_417111.awb") / 1000

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_417111", "417111001", "story_v_out_417111.awb")

						arg_1_1:RecordAudio("417111001", var_4_39)
						arg_1_1:RecordAudio("417111001", var_4_39)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417111", "417111001", "story_v_out_417111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417111", "417111001", "story_v_out_417111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_31 + 0.3
			local var_4_41 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_31 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417111002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417111002
		arg_10_1.duration_ = 4

		local var_10_0 = {
			zh = 4,
			ja = 3.766
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417111003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["1034"] == nil then
				local var_13_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_13_0) then
					local var_13_1 = Object.Instantiate(var_13_0, arg_10_1.canvasGo_.transform)

					var_13_1.transform:SetSiblingIndex(1)

					var_13_1.name = "1034"
					var_13_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_["1034"] = var_13_1

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs((var_13_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_2 = arg_10_1.actors_["1034"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_3 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_3 and not isNil(var_13_2) then
				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								iter_13_3.color = Color.New(Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor1.r, (arg_10_1.time_ - 0) / var_13_3), Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor1.g, (arg_10_1.time_ - 0) / var_13_3), (Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor1.b, (arg_10_1.time_ - 0) / var_13_3)))
							else
								local var_13_4 = Mathf.Lerp(iter_13_3.color.r, 1, (arg_10_1.time_ - 0) / var_13_3)

								iter_13_3.color = Color.New(var_13_4, var_13_4, var_13_4)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= 0 + var_13_3 and arg_10_1.time_ < 0 + var_13_3 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_5 then
						iter_13_5.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_5 = arg_10_1.actors_["10072"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.actorSpriteComps10072 == nil then
				arg_10_1.var_.actorSpriteComps10072 = var_13_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 and not isNil(var_13_5) then
				if arg_10_1.var_.actorSpriteComps10072 then
					for iter_13_6, iter_13_7 in pairs(arg_10_1.var_.actorSpriteComps10072:ToTable()) do
						if iter_13_7 then
							if arg_10_1.isInRecall_ then
								iter_13_7.color = Color.New(Mathf.Lerp(iter_13_7.color.r, arg_10_1.hightColor2.r, (arg_10_1.time_ - 0) / var_13_6), Mathf.Lerp(iter_13_7.color.g, arg_10_1.hightColor2.g, (arg_10_1.time_ - 0) / var_13_6), (Mathf.Lerp(iter_13_7.color.b, arg_10_1.hightColor2.b, (arg_10_1.time_ - 0) / var_13_6)))
							else
								local var_13_7 = Mathf.Lerp(iter_13_7.color.r, 0.5, (arg_10_1.time_ - 0) / var_13_6)

								iter_13_7.color = Color.New(var_13_7, var_13_7, var_13_7)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.actorSpriteComps10072 then
				for iter_13_8, iter_13_9 in pairs(arg_10_1.var_.actorSpriteComps10072:ToTable()) do
					if iter_13_9 then
						iter_13_9.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_10_1.var_.actorSpriteComps10072 = nil
			end

			local var_13_8 = arg_10_1.actors_["1034"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1034 = var_13_8.localPosition
				var_13_8.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1034", 3)

				for iter_13_10 = 0, var_13_8.childCount - 1 do
					local var_13_9 = var_13_8:GetChild(iter_13_10)

					if var_13_9.name == "" or not string.find(var_13_9.name, "split") then
						var_13_9.gameObject:SetActive(true)
					else
						var_13_9.gameObject:SetActive(false)
					end
				end
			end

			local var_13_10 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_10 then
				var_13_8.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_10_1.time_ - 0) / var_13_10)
			end

			if arg_10_1.time_ >= 0 + var_13_10 and arg_10_1.time_ < 0 + var_13_10 + arg_13_0 then
				var_13_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_13_11 = 0
			local var_13_12 = 0.475

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_13 = arg_10_1:GetWordFromCfg(417111002)
				local var_13_14 = arg_10_1:FormatText(var_13_13.content)

				arg_10_1.text_.text = var_13_14

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_16 = 19 <= 0 and var_13_12 or var_13_12 * (utf8.len(var_13_14) / 19)

				if (19 <= 0 and var_13_12 or var_13_12 * (utf8.len(var_13_14) / 19)) > 0 and var_13_12 < var_13_16 then
					arg_10_1.talkMaxDuration = var_13_16

					if var_13_16 + var_13_11 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_16 + var_13_11
					end
				end

				arg_10_1.text_.text = var_13_14
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111002", "story_v_out_417111.awb") ~= 0 then
					local var_13_17 = manager.audio:GetVoiceLength("story_v_out_417111", "417111002", "story_v_out_417111.awb") / 1000

					if var_13_17 + var_13_11 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_17 + var_13_11
					end

					if var_13_13.prefab_name ~= "" and arg_10_1.actors_[var_13_13.prefab_name] ~= nil then
						local var_13_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_13.prefab_name].transform, "story_v_out_417111", "417111002", "story_v_out_417111.awb")

						arg_10_1:RecordAudio("417111002", var_13_18)
						arg_10_1:RecordAudio("417111002", var_13_18)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417111", "417111002", "story_v_out_417111.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417111", "417111002", "story_v_out_417111.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_19 = math.max(var_13_12, arg_10_1.talkMaxDuration)

			if var_13_11 <= arg_10_1.time_ and arg_10_1.time_ < var_13_11 + var_13_19 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_11) / var_13_19

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_11 + var_13_19 and arg_10_1.time_ < var_13_11 + var_13_19 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play417111003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417111003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417111004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["1034"]) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = arg_14_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["1034"]) then
				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								iter_17_1.color = Color.New(Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor2.r, (arg_14_1.time_ - 0) / var_17_0), Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor2.g, (arg_14_1.time_ - 0) / var_17_0), (Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor2.b, (arg_14_1.time_ - 0) / var_17_0)))
							else
								local var_17_1 = Mathf.Lerp(iter_17_1.color.r, 0.5, (arg_14_1.time_ - 0) / var_17_0)

								iter_17_1.color = Color.New(var_17_1, var_17_1, var_17_1)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["1034"]) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_3 then
						iter_17_3.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_2 = 0
			local var_17_3 = 1.35

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_4 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417111003).content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_6 = 54 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_4) / 54)

				if (54 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_4) / 54)) > 0 and var_17_3 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_2
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_3, arg_14_1.talkMaxDuration)

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_2) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_2 + var_17_7 and arg_14_1.time_ < var_17_2 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417111004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417111004
		arg_18_1.duration_ = 6.4

		local var_18_0 = {
			zh = 5.633,
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
				arg_18_0:Play417111005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = arg_18_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1034"]) then
				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								iter_21_1.color = Color.New(Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, (arg_18_1.time_ - 0) / var_21_0), Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, (arg_18_1.time_ - 0) / var_21_0), (Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, (arg_18_1.time_ - 0) / var_21_0)))
							else
								local var_21_1 = Mathf.Lerp(iter_21_1.color.r, 1, (arg_18_1.time_ - 0) / var_21_0)

								iter_21_1.color = Color.New(var_21_1, var_21_1, var_21_1)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_2 = 0
			local var_21_3 = 0.7

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_4 = arg_18_1:GetWordFromCfg(417111004)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_7 = 28 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 28)

				if (28 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 28)) > 0 and var_21_3 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_2
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111004", "story_v_out_417111.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111004", "story_v_out_417111.awb") / 1000

					if var_21_8 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_2
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_417111", "417111004", "story_v_out_417111.awb")

						arg_18_1:RecordAudio("417111004", var_21_9)
						arg_18_1:RecordAudio("417111004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417111", "417111004", "story_v_out_417111.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417111", "417111004", "story_v_out_417111.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_3, arg_18_1.talkMaxDuration)

			if var_21_2 <= arg_18_1.time_ and arg_18_1.time_ < var_21_2 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_2) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_2 + var_21_10 and arg_18_1.time_ < var_21_2 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417111005
		arg_22_1.duration_ = 2.2

		local var_22_0 = {
			zh = 2.2,
			ja = 1.733
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
				arg_22_0:Play417111006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["1034"]) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = arg_22_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["1034"]) then
				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 0.5, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1034"]) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_2 = 0
			local var_25_3 = 0.2

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_4 = arg_22_1:GetWordFromCfg(417111005)
				local var_25_5 = arg_22_1:FormatText(var_25_4.content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 8 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 8)

				if (8 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 8)) > 0 and var_25_3 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111005", "story_v_out_417111.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111005", "story_v_out_417111.awb") / 1000

					if var_25_8 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_2
					end

					if var_25_4.prefab_name ~= "" and arg_22_1.actors_[var_25_4.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_4.prefab_name].transform, "story_v_out_417111", "417111005", "story_v_out_417111.awb")

						arg_22_1:RecordAudio("417111005", var_25_9)
						arg_22_1:RecordAudio("417111005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417111", "417111005", "story_v_out_417111.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417111", "417111005", "story_v_out_417111.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_3, arg_22_1.talkMaxDuration)

			if var_25_2 <= arg_22_1.time_ and arg_22_1.time_ < var_25_2 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_2) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_2 + var_25_10 and arg_22_1.time_ < var_25_2 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417111006
		arg_26_1.duration_ = 6.83

		local var_26_0 = {
			zh = 5.666,
			ja = 6.833
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
				arg_26_0:Play417111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1034"]) and arg_26_1.var_.actorSpriteComps1034 == nil then
				arg_26_1.var_.actorSpriteComps1034 = arg_26_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1034"]) then
				if arg_26_1.var_.actorSpriteComps1034 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								iter_29_1.color = Color.New(Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, (arg_26_1.time_ - 0) / var_29_0), Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, (arg_26_1.time_ - 0) / var_29_0), (Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, (arg_26_1.time_ - 0) / var_29_0)))
							else
								local var_29_1 = Mathf.Lerp(iter_29_1.color.r, 1, (arg_26_1.time_ - 0) / var_29_0)

								iter_29_1.color = Color.New(var_29_1, var_29_1, var_29_1)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1034"]) and arg_26_1.var_.actorSpriteComps1034 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps1034 = nil
			end

			local var_29_2 = arg_26_1.actors_["1034"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1034 = var_29_2.localPosition
				var_29_2.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1034", 3)

				for iter_29_4 = 0, var_29_2.childCount - 1 do
					local var_29_3 = var_29_2:GetChild(iter_29_4)

					if var_29_3.name == "" or not string.find(var_29_3.name, "split") then
						var_29_3.gameObject:SetActive(true)
					else
						var_29_3.gameObject:SetActive(false)
					end
				end
			end

			local var_29_4 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				var_29_2.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_26_1.time_ - 0) / var_29_4)
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				var_29_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_29_5 = 0
			local var_29_6 = 0.7

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_7 = arg_26_1:GetWordFromCfg(417111006)
				local var_29_8 = arg_26_1:FormatText(var_29_7.content)

				arg_26_1.text_.text = var_29_8

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_10 = 28 <= 0 and var_29_6 or var_29_6 * (utf8.len(var_29_8) / 28)

				if (28 <= 0 and var_29_6 or var_29_6 * (utf8.len(var_29_8) / 28)) > 0 and var_29_6 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_5
					end
				end

				arg_26_1.text_.text = var_29_8
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111006", "story_v_out_417111.awb") ~= 0 then
					local var_29_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111006", "story_v_out_417111.awb") / 1000

					if var_29_11 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_5
					end

					if var_29_7.prefab_name ~= "" and arg_26_1.actors_[var_29_7.prefab_name] ~= nil then
						local var_29_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_7.prefab_name].transform, "story_v_out_417111", "417111006", "story_v_out_417111.awb")

						arg_26_1:RecordAudio("417111006", var_29_12)
						arg_26_1:RecordAudio("417111006", var_29_12)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417111", "417111006", "story_v_out_417111.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417111", "417111006", "story_v_out_417111.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_13 = math.max(var_29_6, arg_26_1.talkMaxDuration)

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_13 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_5) / var_29_13

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_5 + var_29_13 and arg_26_1.time_ < var_29_5 + var_29_13 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play417111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417111007
		arg_30_1.duration_ = 4.67

		local var_30_0 = {
			zh = 2,
			ja = 4.666
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
				arg_30_0:Play417111008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = arg_30_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1034"]) then
				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 0.5, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.3

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_4 = arg_30_1:GetWordFromCfg(417111007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 12 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 12)

				if (12 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 12)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111007", "story_v_out_417111.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111007", "story_v_out_417111.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417111", "417111007", "story_v_out_417111.awb")

						arg_30_1:RecordAudio("417111007", var_33_9)
						arg_30_1:RecordAudio("417111007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417111", "417111007", "story_v_out_417111.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417111", "417111007", "story_v_out_417111.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_10 and arg_30_1.time_ < var_33_2 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417111008
		arg_34_1.duration_ = 8.5

		local var_34_0 = {
			zh = 7,
			ja = 8.5
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
				arg_34_0:Play417111009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1034"]) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = arg_34_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1034"]) then
				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 1, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1034"]) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_2 = 0
			local var_37_3 = 0.825

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(417111008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 33 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 33)

				if (33 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 33)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111008", "story_v_out_417111.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111008", "story_v_out_417111.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_417111", "417111008", "story_v_out_417111.awb")

						arg_34_1:RecordAudio("417111008", var_37_9)
						arg_34_1:RecordAudio("417111008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417111", "417111008", "story_v_out_417111.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417111", "417111008", "story_v_out_417111.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_10 and arg_34_1.time_ < var_37_2 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417111009
		arg_38_1.duration_ = 9.63

		local var_38_0 = {
			zh = 9.633,
			ja = 8.4
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
				arg_38_0:Play417111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = arg_38_1.actors_["1034"].transform.localPosition
				arg_38_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 3)

				for iter_41_0 = 0, arg_38_1.actors_["1034"].transform.childCount - 1 do
					local var_41_0 = arg_38_1.actors_["1034"].transform:GetChild(iter_41_0)

					if var_41_0.name == "split_6" or not string.find(var_41_0.name, "split") then
						var_41_0.gameObject:SetActive(true)
					else
						var_41_0.gameObject:SetActive(false)
					end
				end
			end

			local var_41_1 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_1 then
				arg_38_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_38_1.time_ - 0) / var_41_1)
			end

			if arg_38_1.time_ >= 0 + var_41_1 and arg_38_1.time_ < 0 + var_41_1 + arg_41_0 then
				arg_38_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_41_2 = 0
			local var_41_3 = 1.175

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_4 = arg_38_1:GetWordFromCfg(417111009)
				local var_41_5 = arg_38_1:FormatText(var_41_4.content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 47 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 47)

				if (47 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 47)) > 0 and var_41_3 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111009", "story_v_out_417111.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111009", "story_v_out_417111.awb") / 1000

					if var_41_8 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_2
					end

					if var_41_4.prefab_name ~= "" and arg_38_1.actors_[var_41_4.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_4.prefab_name].transform, "story_v_out_417111", "417111009", "story_v_out_417111.awb")

						arg_38_1:RecordAudio("417111009", var_41_9)
						arg_38_1:RecordAudio("417111009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417111", "417111009", "story_v_out_417111.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417111", "417111009", "story_v_out_417111.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_10 and arg_38_1.time_ < var_41_2 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417111010
		arg_42_1.duration_ = 5.3

		local var_42_0 = {
			zh = 5.3,
			ja = 3.566
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
				arg_42_0:Play417111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = arg_42_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1034"]) then
				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_2 = 0
			local var_45_3 = 0.775

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_4 = arg_42_1:GetWordFromCfg(417111010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 31)

				if (31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 31)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111010", "story_v_out_417111.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111010", "story_v_out_417111.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_417111", "417111010", "story_v_out_417111.awb")

						arg_42_1:RecordAudio("417111010", var_45_9)
						arg_42_1:RecordAudio("417111010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417111", "417111010", "story_v_out_417111.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417111", "417111010", "story_v_out_417111.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_10 and arg_42_1.time_ < var_45_2 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417111011
		arg_46_1.duration_ = 6.3

		local var_46_0 = {
			zh = 5.166,
			ja = 6.3
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.675

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:GetWordFromCfg(417111011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 27 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 27)

				if (27 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 27)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111011", "story_v_out_417111.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111011", "story_v_out_417111.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_417111", "417111011", "story_v_out_417111.awb")

						arg_46_1:RecordAudio("417111011", var_49_6)
						arg_46_1:RecordAudio("417111011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417111", "417111011", "story_v_out_417111.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417111", "417111011", "story_v_out_417111.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417111012
		arg_50_1.duration_ = 4.03

		local var_50_0 = {
			zh = 3.466,
			ja = 4.033
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
				arg_50_0:Play417111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1034"]) and arg_50_1.var_.actorSpriteComps1034 == nil then
				arg_50_1.var_.actorSpriteComps1034 = arg_50_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1034"]) then
				if arg_50_1.var_.actorSpriteComps1034 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 1, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1034"]) and arg_50_1.var_.actorSpriteComps1034 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps1034 = nil
			end

			local var_53_2 = arg_50_1.actors_["1034"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 3)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_53_5 = 0
			local var_53_6 = 0.275

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(417111012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 11 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 11)

				if (11 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 11)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111012", "story_v_out_417111.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111012", "story_v_out_417111.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_417111", "417111012", "story_v_out_417111.awb")

						arg_50_1:RecordAudio("417111012", var_53_12)
						arg_50_1:RecordAudio("417111012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417111", "417111012", "story_v_out_417111.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417111", "417111012", "story_v_out_417111.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417111013
		arg_54_1.duration_ = 2.57

		local var_54_0 = {
			zh = 2.566,
			ja = 1.633
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
				arg_54_0:Play417111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1034"]) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = arg_54_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1034"]) then
				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor2.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor2.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor2.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 0.5, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1034"]) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_2 = 0
			local var_57_3 = 0.225

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_4 = arg_54_1:GetWordFromCfg(417111013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 9 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 9)

				if (9 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 9)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111013", "story_v_out_417111.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111013", "story_v_out_417111.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_417111", "417111013", "story_v_out_417111.awb")

						arg_54_1:RecordAudio("417111013", var_57_9)
						arg_54_1:RecordAudio("417111013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417111", "417111013", "story_v_out_417111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417111", "417111013", "story_v_out_417111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417111014
		arg_58_1.duration_ = 13.67

		local var_58_0 = {
			zh = 7.666,
			ja = 13.666
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
				arg_58_0:Play417111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(417111014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 40 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 40)

				if (40 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 40)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111014", "story_v_out_417111.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111014", "story_v_out_417111.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_417111", "417111014", "story_v_out_417111.awb")

						arg_58_1:RecordAudio("417111014", var_61_6)
						arg_58_1:RecordAudio("417111014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417111", "417111014", "story_v_out_417111.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417111", "417111014", "story_v_out_417111.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417111015
		arg_62_1.duration_ = 2.6

		local var_62_0 = {
			zh = 1.366,
			ja = 2.6
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play417111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1034"]) and arg_62_1.var_.actorSpriteComps1034 == nil then
				arg_62_1.var_.actorSpriteComps1034 = arg_62_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1034"]) then
				if arg_62_1.var_.actorSpriteComps1034 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1034"]) and arg_62_1.var_.actorSpriteComps1034 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps1034 = nil
			end

			local var_65_2 = arg_62_1.actors_["1034"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1034 = var_65_2.localPosition
				var_65_2.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1034", 3)

				for iter_65_4 = 0, var_65_2.childCount - 1 do
					local var_65_3 = var_65_2:GetChild(iter_65_4)

					if var_65_3.name == "split_5" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_2.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_62_1.time_ - 0) / var_65_4)
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_65_5 = 0
			local var_65_6 = 0.1

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_7 = arg_62_1:GetWordFromCfg(417111015)
				local var_65_8 = arg_62_1:FormatText(var_65_7.content)

				arg_62_1.text_.text = var_65_8

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 4 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 4)

				if (4 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 4)) > 0 and var_65_6 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_8
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111015", "story_v_out_417111.awb") ~= 0 then
					local var_65_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111015", "story_v_out_417111.awb") / 1000

					if var_65_11 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_5
					end

					if var_65_7.prefab_name ~= "" and arg_62_1.actors_[var_65_7.prefab_name] ~= nil then
						local var_65_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_7.prefab_name].transform, "story_v_out_417111", "417111015", "story_v_out_417111.awb")

						arg_62_1:RecordAudio("417111015", var_65_12)
						arg_62_1:RecordAudio("417111015", var_65_12)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417111", "417111015", "story_v_out_417111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417111", "417111015", "story_v_out_417111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_13 = math.max(var_65_6, arg_62_1.talkMaxDuration)

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_13 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_5) / var_65_13

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_5 + var_65_13 and arg_62_1.time_ < var_65_5 + var_65_13 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play417111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417111016
		arg_66_1.duration_ = 12.9

		local var_66_0 = {
			zh = 8.9,
			ja = 12.9
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
				arg_66_0:Play417111017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1034"]) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = arg_66_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1034"]) then
				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1034"]) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_2 = 0
			local var_69_3 = 1.225

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_4 = arg_66_1:GetWordFromCfg(417111016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 49 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 49)

				if (49 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 49)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111016", "story_v_out_417111.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111016", "story_v_out_417111.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_417111", "417111016", "story_v_out_417111.awb")

						arg_66_1:RecordAudio("417111016", var_69_9)
						arg_66_1:RecordAudio("417111016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417111", "417111016", "story_v_out_417111.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417111", "417111016", "story_v_out_417111.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417111017
		arg_70_1.duration_ = 9.33

		local var_70_0 = {
			zh = 9.333,
			ja = 8.233
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
				arg_70_0:Play417111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.275

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(417111017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 51 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 51)

				if (51 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 51)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111017", "story_v_out_417111.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111017", "story_v_out_417111.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_417111", "417111017", "story_v_out_417111.awb")

						arg_70_1:RecordAudio("417111017", var_73_6)
						arg_70_1:RecordAudio("417111017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417111", "417111017", "story_v_out_417111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417111", "417111017", "story_v_out_417111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417111018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417111018
		arg_74_1.duration_ = 4.67

		local var_74_0 = {
			zh = 1.733,
			ja = 4.666
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
				arg_74_0:Play417111019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1034"]) and arg_74_1.var_.actorSpriteComps1034 == nil then
				arg_74_1.var_.actorSpriteComps1034 = arg_74_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1034"]) then
				if arg_74_1.var_.actorSpriteComps1034 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 1, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1034"]) and arg_74_1.var_.actorSpriteComps1034 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			local var_77_2 = arg_74_1.actors_["1034"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1034 = var_77_2.localPosition
				var_77_2.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1034", 3)

				for iter_77_4 = 0, var_77_2.childCount - 1 do
					local var_77_3 = var_77_2:GetChild(iter_77_4)

					if var_77_3.name == "split_6" or not string.find(var_77_3.name, "split") then
						var_77_3.gameObject:SetActive(true)
					else
						var_77_3.gameObject:SetActive(false)
					end
				end
			end

			local var_77_4 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				var_77_2.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_74_1.time_ - 0) / var_77_4)
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				var_77_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_77_5 = 0
			local var_77_6 = 0.225

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(417111018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 9 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 9)

				if (9 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 9)) > 0 and var_77_6 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10

					if var_77_10 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111018", "story_v_out_417111.awb") ~= 0 then
					local var_77_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111018", "story_v_out_417111.awb") / 1000

					if var_77_11 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_5
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_417111", "417111018", "story_v_out_417111.awb")

						arg_74_1:RecordAudio("417111018", var_77_12)
						arg_74_1:RecordAudio("417111018", var_77_12)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417111", "417111018", "story_v_out_417111.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417111", "417111018", "story_v_out_417111.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_13 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_13 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_13

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_13 and arg_74_1.time_ < var_77_5 + var_77_13 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play417111019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417111019
		arg_78_1.duration_ = 1.3

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417111020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1034"]) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = arg_78_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1034"]) then
				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor2.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor2.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor2.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 0.5, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1034"]) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_2 = 0
			local var_81_3 = 0.125

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_4 = arg_78_1:GetWordFromCfg(417111019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 5 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 5)

				if (5 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 5)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111019", "story_v_out_417111.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111019", "story_v_out_417111.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_417111", "417111019", "story_v_out_417111.awb")

						arg_78_1:RecordAudio("417111019", var_81_9)
						arg_78_1:RecordAudio("417111019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417111", "417111019", "story_v_out_417111.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417111", "417111019", "story_v_out_417111.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417111020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417111020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417111021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.15

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(417111020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 46 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 46)

				if (46 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 46)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417111021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417111021
		arg_86_1.duration_ = 4.63

		local var_86_0 = {
			zh = 4.633,
			ja = 3
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
				arg_86_0:Play417111022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1034"]) and arg_86_1.var_.actorSpriteComps1034 == nil then
				arg_86_1.var_.actorSpriteComps1034 = arg_86_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1034"]) then
				if arg_86_1.var_.actorSpriteComps1034 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 1, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1034"]) and arg_86_1.var_.actorSpriteComps1034 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps1034 = nil
			end

			local var_89_2 = 0
			local var_89_3 = 0.375

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:GetWordFromCfg(417111021)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 15 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 15)

				if (15 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 15)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111021", "story_v_out_417111.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111021", "story_v_out_417111.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_out_417111", "417111021", "story_v_out_417111.awb")

						arg_86_1:RecordAudio("417111021", var_89_9)
						arg_86_1:RecordAudio("417111021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417111", "417111021", "story_v_out_417111.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417111", "417111021", "story_v_out_417111.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_10 and arg_86_1.time_ < var_89_2 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417111022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417111022
		arg_90_1.duration_ = 1.37

		local var_90_0 = {
			zh = 1.366,
			ja = 1.3
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
				arg_90_0:Play417111023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1034"]) and arg_90_1.var_.actorSpriteComps1034 == nil then
				arg_90_1.var_.actorSpriteComps1034 = arg_90_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1034"]) then
				if arg_90_1.var_.actorSpriteComps1034 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1034"]) and arg_90_1.var_.actorSpriteComps1034 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps1034 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.175

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_4 = arg_90_1:GetWordFromCfg(417111022)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 7 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 7)

				if (7 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 7)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111022", "story_v_out_417111.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111022", "story_v_out_417111.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_417111", "417111022", "story_v_out_417111.awb")

						arg_90_1:RecordAudio("417111022", var_93_9)
						arg_90_1:RecordAudio("417111022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417111", "417111022", "story_v_out_417111.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417111", "417111022", "story_v_out_417111.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_10 and arg_90_1.time_ < var_93_2 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417111023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417111023
		arg_94_1.duration_ = 11.87

		local var_94_0 = {
			zh = 9.9,
			ja = 11.866
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
				arg_94_0:Play417111024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1034"]) and arg_94_1.var_.actorSpriteComps1034 == nil then
				arg_94_1.var_.actorSpriteComps1034 = arg_94_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1034"]) then
				if arg_94_1.var_.actorSpriteComps1034 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 1, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1034"]) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			local var_97_2 = arg_94_1.actors_["1034"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1034 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1034", 3)

				for iter_97_4 = 0, var_97_2.childCount - 1 do
					local var_97_3 = var_97_2:GetChild(iter_97_4)

					if var_97_3.name == "split_6" or not string.find(var_97_3.name, "split") then
						var_97_3.gameObject:SetActive(true)
					else
						var_97_3.gameObject:SetActive(false)
					end
				end
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_94_1.time_ - 0) / var_97_4)
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_97_5 = 0
			local var_97_6 = 1.075

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(417111023)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 43 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 43)

				if (43 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 43)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111023", "story_v_out_417111.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111023", "story_v_out_417111.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_417111", "417111023", "story_v_out_417111.awb")

						arg_94_1:RecordAudio("417111023", var_97_12)
						arg_94_1:RecordAudio("417111023", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417111", "417111023", "story_v_out_417111.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417111", "417111023", "story_v_out_417111.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_13 and arg_94_1.time_ < var_97_5 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play417111024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417111024
		arg_98_1.duration_ = 5.33

		local var_98_0 = {
			zh = 3.833,
			ja = 5.333
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
				arg_98_0:Play417111025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.4

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(417111024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 16 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 16)

				if (16 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 16)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111024", "story_v_out_417111.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111024", "story_v_out_417111.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_417111", "417111024", "story_v_out_417111.awb")

						arg_98_1:RecordAudio("417111024", var_101_6)
						arg_98_1:RecordAudio("417111024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417111", "417111024", "story_v_out_417111.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417111", "417111024", "story_v_out_417111.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417111025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417111025
		arg_102_1.duration_ = 5

		local var_102_0 = {
			zh = 3.833,
			ja = 5
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
				arg_102_0:Play417111026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1034"]) and arg_102_1.var_.actorSpriteComps1034 == nil then
				arg_102_1.var_.actorSpriteComps1034 = arg_102_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1034"]) then
				if arg_102_1.var_.actorSpriteComps1034 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1034"]) and arg_102_1.var_.actorSpriteComps1034 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps1034 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_4 = arg_102_1:GetWordFromCfg(417111025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 20 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 20)

				if (20 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 20)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111025", "story_v_out_417111.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111025", "story_v_out_417111.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_417111", "417111025", "story_v_out_417111.awb")

						arg_102_1:RecordAudio("417111025", var_105_9)
						arg_102_1:RecordAudio("417111025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417111", "417111025", "story_v_out_417111.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417111", "417111025", "story_v_out_417111.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417111026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417111026
		arg_106_1.duration_ = 6.87

		local var_106_0 = {
			zh = 2,
			ja = 6.866
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
				arg_106_0:Play417111027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1034"]) and arg_106_1.var_.actorSpriteComps1034 == nil then
				arg_106_1.var_.actorSpriteComps1034 = arg_106_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1034"]) then
				if arg_106_1.var_.actorSpriteComps1034 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1034"]) and arg_106_1.var_.actorSpriteComps1034 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps1034 = nil
			end

			local var_109_2 = 0
			local var_109_3 = 0.25

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(417111026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 10 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 10)

				if (10 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 10)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111026", "story_v_out_417111.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111026", "story_v_out_417111.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_417111", "417111026", "story_v_out_417111.awb")

						arg_106_1:RecordAudio("417111026", var_109_9)
						arg_106_1:RecordAudio("417111026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417111", "417111026", "story_v_out_417111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417111", "417111026", "story_v_out_417111.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417111027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417111027
		arg_110_1.duration_ = 12.57

		local var_110_0 = {
			zh = 11.433,
			ja = 12.566
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
				arg_110_0:Play417111028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 1.55

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(417111027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 62 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 62)

				if (62 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 62)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111027", "story_v_out_417111.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111027", "story_v_out_417111.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_417111", "417111027", "story_v_out_417111.awb")

						arg_110_1:RecordAudio("417111027", var_113_6)
						arg_110_1:RecordAudio("417111027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417111", "417111027", "story_v_out_417111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417111", "417111027", "story_v_out_417111.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417111028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417111028
		arg_114_1.duration_ = 12.17

		local var_114_0 = {
			zh = 10.1,
			ja = 12.166
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
				arg_114_0:Play417111029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(417111028)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 53 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 53)

				if (53 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 53)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111028", "story_v_out_417111.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111028", "story_v_out_417111.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_417111", "417111028", "story_v_out_417111.awb")

						arg_114_1:RecordAudio("417111028", var_117_6)
						arg_114_1:RecordAudio("417111028", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417111", "417111028", "story_v_out_417111.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417111", "417111028", "story_v_out_417111.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play417111029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417111029
		arg_118_1.duration_ = 3.7

		local var_118_0 = {
			zh = 3.166,
			ja = 3.7
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play417111030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1034"]) and arg_118_1.var_.actorSpriteComps1034 == nil then
				arg_118_1.var_.actorSpriteComps1034 = arg_118_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1034"]) then
				if arg_118_1.var_.actorSpriteComps1034 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1034"]) and arg_118_1.var_.actorSpriteComps1034 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps1034 = nil
			end

			local var_121_2 = 0
			local var_121_3 = 0.425

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_4 = arg_118_1:GetWordFromCfg(417111029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 17 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 17)

				if (17 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 17)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111029", "story_v_out_417111.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111029", "story_v_out_417111.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_417111", "417111029", "story_v_out_417111.awb")

						arg_118_1:RecordAudio("417111029", var_121_9)
						arg_118_1:RecordAudio("417111029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417111", "417111029", "story_v_out_417111.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417111", "417111029", "story_v_out_417111.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_10 and arg_118_1.time_ < var_121_2 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play417111030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417111030
		arg_122_1.duration_ = 13.37

		local var_122_0 = {
			zh = 13.366,
			ja = 11.7
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417111031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1034"]) and arg_122_1.var_.actorSpriteComps1034 == nil then
				arg_122_1.var_.actorSpriteComps1034 = arg_122_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1034"]) then
				if arg_122_1.var_.actorSpriteComps1034 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 1, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1034"]) and arg_122_1.var_.actorSpriteComps1034 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps1034 = nil
			end

			local var_125_2 = 0
			local var_125_3 = 1.625

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(417111030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 65 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 65)

				if (65 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 65)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111030", "story_v_out_417111.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111030", "story_v_out_417111.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_417111", "417111030", "story_v_out_417111.awb")

						arg_122_1:RecordAudio("417111030", var_125_9)
						arg_122_1:RecordAudio("417111030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417111", "417111030", "story_v_out_417111.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417111", "417111030", "story_v_out_417111.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417111031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417111031
		arg_126_1.duration_ = 15.7

		local var_126_0 = {
			zh = 11.3,
			ja = 15.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417111032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.325

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(417111031)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 53 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 53)

				if (53 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 53)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111031", "story_v_out_417111.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111031", "story_v_out_417111.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_417111", "417111031", "story_v_out_417111.awb")

						arg_126_1:RecordAudio("417111031", var_129_6)
						arg_126_1:RecordAudio("417111031", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417111", "417111031", "story_v_out_417111.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417111", "417111031", "story_v_out_417111.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417111032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417111032
		arg_130_1.duration_ = 9.57

		local var_130_0 = {
			zh = 7.066,
			ja = 9.566
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417111033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.825

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:GetWordFromCfg(417111032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 33 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 33)

				if (33 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 33)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111032", "story_v_out_417111.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111032", "story_v_out_417111.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_417111", "417111032", "story_v_out_417111.awb")

						arg_130_1:RecordAudio("417111032", var_133_6)
						arg_130_1:RecordAudio("417111032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417111", "417111032", "story_v_out_417111.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417111", "417111032", "story_v_out_417111.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417111033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417111033
		arg_134_1.duration_ = 7

		local var_134_0 = {
			zh = 3.566,
			ja = 7
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417111034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.425

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:GetWordFromCfg(417111033)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 17 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 17)

				if (17 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 17)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111033", "story_v_out_417111.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111033", "story_v_out_417111.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_417111", "417111033", "story_v_out_417111.awb")

						arg_134_1:RecordAudio("417111033", var_137_6)
						arg_134_1:RecordAudio("417111033", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417111", "417111033", "story_v_out_417111.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417111", "417111033", "story_v_out_417111.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417111034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417111034
		arg_138_1.duration_ = 1.27

		local var_138_0 = {
			zh = 1.1,
			ja = 1.266
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417111035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1034"]) and arg_138_1.var_.actorSpriteComps1034 == nil then
				arg_138_1.var_.actorSpriteComps1034 = arg_138_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1034"]) then
				if arg_138_1.var_.actorSpriteComps1034 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1034"]) and arg_138_1.var_.actorSpriteComps1034 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps1034 = nil
			end

			local var_141_2 = 0
			local var_141_3 = 0.1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_4 = arg_138_1:GetWordFromCfg(417111034)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_7 = 4 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 4)

				if (4 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 4)) > 0 and var_141_3 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_2
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111034", "story_v_out_417111.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111034", "story_v_out_417111.awb") / 1000

					if var_141_8 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_2
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_out_417111", "417111034", "story_v_out_417111.awb")

						arg_138_1:RecordAudio("417111034", var_141_9)
						arg_138_1:RecordAudio("417111034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417111", "417111034", "story_v_out_417111.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417111", "417111034", "story_v_out_417111.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_3, arg_138_1.talkMaxDuration)

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_2) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_2 + var_141_10 and arg_138_1.time_ < var_141_2 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417111035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417111035
		arg_142_1.duration_ = 7.77

		local var_142_0 = {
			zh = 3.833,
			ja = 7.766
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417111036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1034"]) and arg_142_1.var_.actorSpriteComps1034 == nil then
				arg_142_1.var_.actorSpriteComps1034 = arg_142_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1034"]) then
				if arg_142_1.var_.actorSpriteComps1034 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 1, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1034"]) and arg_142_1.var_.actorSpriteComps1034 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps1034 = nil
			end

			local var_145_2 = 0
			local var_145_3 = 0.475

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(417111035)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 19 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 19)

				if (19 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 19)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111035", "story_v_out_417111.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111035", "story_v_out_417111.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_417111", "417111035", "story_v_out_417111.awb")

						arg_142_1:RecordAudio("417111035", var_145_9)
						arg_142_1:RecordAudio("417111035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417111", "417111035", "story_v_out_417111.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417111", "417111035", "story_v_out_417111.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417111036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417111036
		arg_146_1.duration_ = 9.1

		local var_146_0 = {
			zh = 9.1,
			ja = 7.933
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417111037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1034 = arg_146_1.actors_["1034"].transform.localPosition
				arg_146_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1034", 3)

				for iter_149_0 = 0, arg_146_1.actors_["1034"].transform.childCount - 1 do
					local var_149_0 = arg_146_1.actors_["1034"].transform:GetChild(iter_149_0)

					if var_149_0.name == "split_3" or not string.find(var_149_0.name, "split") then
						var_149_0.gameObject:SetActive(true)
					else
						var_149_0.gameObject:SetActive(false)
					end
				end
			end

			local var_149_1 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 then
				arg_146_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_146_1.time_ - 0) / var_149_1)
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 then
				arg_146_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_149_2 = 0
			local var_149_3 = 0.925

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:GetWordFromCfg(417111036)
				local var_149_5 = arg_146_1:FormatText(var_149_4.content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 37 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 37)

				if (37 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 37)) > 0 and var_149_3 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111036", "story_v_out_417111.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111036", "story_v_out_417111.awb") / 1000

					if var_149_8 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_2
					end

					if var_149_4.prefab_name ~= "" and arg_146_1.actors_[var_149_4.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_4.prefab_name].transform, "story_v_out_417111", "417111036", "story_v_out_417111.awb")

						arg_146_1:RecordAudio("417111036", var_149_9)
						arg_146_1:RecordAudio("417111036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417111", "417111036", "story_v_out_417111.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417111", "417111036", "story_v_out_417111.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_10 and arg_146_1.time_ < var_149_2 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play417111037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417111037
		arg_150_1.duration_ = 6.6

		local var_150_0 = {
			zh = 6.6,
			ja = 4.466
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417111038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.65

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(417111037)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 26 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 26)

				if (26 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 26)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111037", "story_v_out_417111.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111037", "story_v_out_417111.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_417111", "417111037", "story_v_out_417111.awb")

						arg_150_1:RecordAudio("417111037", var_153_6)
						arg_150_1:RecordAudio("417111037", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417111", "417111037", "story_v_out_417111.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417111", "417111037", "story_v_out_417111.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417111038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417111038
		arg_154_1.duration_ = 10.57

		local var_154_0 = {
			zh = 8.1,
			ja = 10.566
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417111039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if arg_154_1.bgs_.ST73 == nil then
				local var_157_0 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_157_0.name = "ST73"
				var_157_0.transform.parent = arg_154_1.stage_.transform
				var_157_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_.ST73 = var_157_0
			end

			if 2.00066666666667 < arg_154_1.time_ and arg_154_1.time_ <= 2.00066666666667 + arg_157_0 then
				local var_157_1 = arg_154_1.bgs_.ST73

				arg_154_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_157_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_2 = var_157_1:GetComponent("SpriteRenderer")

				if var_157_2 and var_157_2.sprite then
					local var_157_3 = 2 * (var_157_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_157_1.transform.localScale = Vector3.New(var_157_3 / var_157_2.sprite.bounds.size.y < var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x and var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x or var_157_3 / var_157_2.sprite.bounds.size.y, var_157_3 / var_157_2.sprite.bounds.size.y < var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x and var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x or var_157_3 / var_157_2.sprite.bounds.size.y, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "ST73" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_4 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			if arg_154_1.time_ >= var_157_4 + 0.3 and arg_154_1.time_ < var_157_4 + 0.3 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_5 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_6 = 2

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 then
				local var_157_7 = Color.New(0, 0, 0)

				var_157_7.a = Mathf.Lerp(0, 1, (arg_154_1.time_ - var_157_5) / var_157_6)
				arg_154_1.mask_.color = var_157_7
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 then
				local var_157_8 = Color.New(0, 0, 0)

				var_157_8.a = 1
				arg_154_1.mask_.color = var_157_8
			end

			local var_157_9 = 2

			if 2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_10 = 2

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_10 then
				local var_157_11 = Color.New(0, 0, 0)

				var_157_11.a = Mathf.Lerp(1, 0, (arg_154_1.time_ - var_157_9) / var_157_10)
				arg_154_1.mask_.color = var_157_11
			end

			if arg_154_1.time_ >= var_157_9 + var_157_10 and arg_154_1.time_ < var_157_9 + var_157_10 + arg_157_0 then
				local var_157_12 = Color.New(0, 0, 0)

				arg_154_1.mask_.enabled = false
				var_157_12.a = 0
				arg_154_1.mask_.color = var_157_12
			end

			local var_157_13 = "10128"

			if arg_154_1.actors_["10128"] == nil then
				local var_157_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_157_14) then
					local var_157_15 = Object.Instantiate(var_157_14, arg_154_1.canvasGo_.transform)

					var_157_15.transform:SetSiblingIndex(1)

					var_157_15.name = var_157_13
					var_157_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_154_1.actors_[var_157_13] = var_157_15

					if arg_154_1.isInRecall_ then
						for iter_157_2, iter_157_3 in ipairs((var_157_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_157_16 = arg_154_1.actors_["10128"]

			if 1.96666666666667 < arg_154_1.time_ and arg_154_1.time_ <= 1.96666666666667 + arg_157_0 and not isNil(var_157_16) and arg_154_1.var_.actorSpriteComps10128 == nil then
				arg_154_1.var_.actorSpriteComps10128 = var_157_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_17 = 0.2

			if 1.96666666666667 <= arg_154_1.time_ and arg_154_1.time_ < 1.96666666666667 + var_157_17 and not isNil(var_157_16) then
				if arg_154_1.var_.actorSpriteComps10128 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								iter_157_5.color = Color.New(Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 1.96666666666667) / var_157_17), Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 1.96666666666667) / var_157_17), (Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 1.96666666666667) / var_157_17)))
							else
								local var_157_18 = Mathf.Lerp(iter_157_5.color.r, 1, (arg_154_1.time_ - 1.96666666666667) / var_157_17)

								iter_157_5.color = Color.New(var_157_18, var_157_18, var_157_18)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 1.96666666666667 + var_157_17 and arg_154_1.time_ < 1.96666666666667 + var_157_17 + arg_157_0 and not isNil(var_157_16) and arg_154_1.var_.actorSpriteComps10128 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_157_7 then
						iter_157_7.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps10128 = nil
			end

			local var_157_19 = arg_154_1.actors_["1034"]

			if 1.96666666666667 < arg_154_1.time_ and arg_154_1.time_ <= 1.96666666666667 + arg_157_0 and not isNil(var_157_19) and arg_154_1.var_.actorSpriteComps1034 == nil then
				arg_154_1.var_.actorSpriteComps1034 = var_157_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_20 = 0.2

			if 1.96666666666667 <= arg_154_1.time_ and arg_154_1.time_ < 1.96666666666667 + var_157_20 and not isNil(var_157_19) then
				if arg_154_1.var_.actorSpriteComps1034 then
					for iter_157_8, iter_157_9 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_157_9 then
							if arg_154_1.isInRecall_ then
								iter_157_9.color = Color.New(Mathf.Lerp(iter_157_9.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 1.96666666666667) / var_157_20), Mathf.Lerp(iter_157_9.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 1.96666666666667) / var_157_20), (Mathf.Lerp(iter_157_9.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 1.96666666666667) / var_157_20)))
							else
								local var_157_21 = Mathf.Lerp(iter_157_9.color.r, 0.5, (arg_154_1.time_ - 1.96666666666667) / var_157_20)

								iter_157_9.color = Color.New(var_157_21, var_157_21, var_157_21)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 1.96666666666667 + var_157_20 and arg_154_1.time_ < 1.96666666666667 + var_157_20 + arg_157_0 and not isNil(var_157_19) and arg_154_1.var_.actorSpriteComps1034 then
				for iter_157_10, iter_157_11 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_157_11 then
						iter_157_11.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps1034 = nil
			end

			local var_157_22 = arg_154_1.actors_["1034"].transform

			if 1.98333333333333 < arg_154_1.time_ and arg_154_1.time_ <= 1.98333333333333 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = var_157_22.localPosition
				var_157_22.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 7)

				for iter_157_12 = 0, var_157_22.childCount - 1 do
					local var_157_23 = var_157_22:GetChild(iter_157_12)

					if var_157_23.name == "" or not string.find(var_157_23.name, "split") then
						var_157_23.gameObject:SetActive(true)
					else
						var_157_23.gameObject:SetActive(false)
					end
				end
			end

			local var_157_24 = 0.001

			if 1.98333333333333 <= arg_154_1.time_ and arg_154_1.time_ < 1.98333333333333 + var_157_24 then
				var_157_22.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_154_1.time_ - 1.98333333333333) / var_157_24)
			end

			if arg_154_1.time_ >= 1.98333333333333 + var_157_24 and arg_154_1.time_ < 1.98333333333333 + var_157_24 + arg_157_0 then
				var_157_22.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_157_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_27 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_27

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_27
						arg_154_1.bgmTxt2_.text = var_157_27
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_154_1.time_ and arg_154_1.time_ <= 1.66666666666667 + arg_157_0 then
				arg_154_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_157_30 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_30 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_30

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_30
						arg_154_1.bgmTxt2_.text = var_157_30
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_31 = 3.7
			local var_157_32 = 0.55

			if 3.7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_31 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_33 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_33:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_154_1.dialogCg_.alpha = arg_160_0
				end))
				var_157_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_34 = arg_154_1:GetWordFromCfg(417111038)
				local var_157_35 = arg_154_1:FormatText(var_157_34.content)

				arg_154_1.text_.text = var_157_35

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_37 = 22 <= 0 and var_157_32 or var_157_32 * (utf8.len(var_157_35) / 22)

				if (22 <= 0 and var_157_32 or var_157_32 * (utf8.len(var_157_35) / 22)) > 0 and var_157_32 < var_157_37 then
					arg_154_1.talkMaxDuration = var_157_37
					var_157_31 = var_157_31 + 0.3

					if var_157_37 + var_157_31 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_37 + var_157_31
					end
				end

				arg_154_1.text_.text = var_157_35
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111038", "story_v_out_417111.awb") ~= 0 then
					local var_157_38 = manager.audio:GetVoiceLength("story_v_out_417111", "417111038", "story_v_out_417111.awb") / 1000

					if var_157_38 + var_157_31 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_38 + var_157_31
					end

					if var_157_34.prefab_name ~= "" and arg_154_1.actors_[var_157_34.prefab_name] ~= nil then
						local var_157_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_34.prefab_name].transform, "story_v_out_417111", "417111038", "story_v_out_417111.awb")

						arg_154_1:RecordAudio("417111038", var_157_39)
						arg_154_1:RecordAudio("417111038", var_157_39)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417111", "417111038", "story_v_out_417111.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417111", "417111038", "story_v_out_417111.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_40 = var_157_31 + 0.3
			local var_157_41 = math.max(var_157_32, arg_154_1.talkMaxDuration)

			if var_157_31 + 0.3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_40 + var_157_41 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_40) / var_157_41

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_40 + var_157_41 and arg_154_1.time_ < var_157_40 + var_157_41 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play417111039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417111039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417111040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10128"]) and arg_162_1.var_.actorSpriteComps10128 == nil then
				arg_162_1.var_.actorSpriteComps10128 = arg_162_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10128"]) then
				if arg_162_1.var_.actorSpriteComps10128 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 0.5, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10128"]) and arg_162_1.var_.actorSpriteComps10128 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_162_1.var_.actorSpriteComps10128 = nil
			end

			local var_165_2 = 0
			local var_165_3 = 1.225

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(417111039).content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 49 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 49)

				if (49 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 49)) > 0 and var_165_3 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_7 and arg_162_1.time_ < var_165_2 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417111040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417111040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417111041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0.8 < arg_166_1.time_ and arg_166_1.time_ <= 0.8 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_teacup02", "")
			end

			local var_169_1 = 0
			local var_169_2 = 1.7

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(417111040).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 68 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 68)

				if (68 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 68)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417111041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417111041
		arg_170_1.duration_ = 4.1

		local var_170_0 = {
			zh = 1.366,
			ja = 4.1
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
				arg_170_0:Play417111042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.125

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:GetWordFromCfg(417111041)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 5 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 5)

				if (5 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 5)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111041", "story_v_out_417111.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111041", "story_v_out_417111.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_417111", "417111041", "story_v_out_417111.awb")

						arg_170_1:RecordAudio("417111041", var_173_6)
						arg_170_1:RecordAudio("417111041", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417111", "417111041", "story_v_out_417111.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417111", "417111041", "story_v_out_417111.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417111042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417111042
		arg_174_1.duration_ = 4.4

		local var_174_0 = {
			zh = 3.1,
			ja = 4.4
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
				arg_174_0:Play417111043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10128"]) and arg_174_1.var_.actorSpriteComps10128 == nil then
				arg_174_1.var_.actorSpriteComps10128 = arg_174_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10128"]) then
				if arg_174_1.var_.actorSpriteComps10128 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10128"]) and arg_174_1.var_.actorSpriteComps10128 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_2 = arg_174_1.actors_["10128"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10128 = var_177_2.localPosition
				var_177_2.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10128", 3)

				for iter_177_4 = 0, var_177_2.childCount - 1 do
					local var_177_3 = var_177_2:GetChild(iter_177_4)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_2.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_174_1.time_ - 0) / var_177_4)
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_177_5 = 0
			local var_177_6 = 0.4

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(417111042)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 16 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 16)

				if (16 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 16)) > 0 and var_177_6 < var_177_10 then
					arg_174_1.talkMaxDuration = var_177_10

					if var_177_10 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111042", "story_v_out_417111.awb") ~= 0 then
					local var_177_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111042", "story_v_out_417111.awb") / 1000

					if var_177_11 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_5
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_out_417111", "417111042", "story_v_out_417111.awb")

						arg_174_1:RecordAudio("417111042", var_177_12)
						arg_174_1:RecordAudio("417111042", var_177_12)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417111", "417111042", "story_v_out_417111.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417111", "417111042", "story_v_out_417111.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_13 and arg_174_1.time_ < var_177_5 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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
	Play417111043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417111043
		arg_178_1.duration_ = 10.7

		local var_178_0 = {
			zh = 8.233,
			ja = 10.7
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
				arg_178_0:Play417111044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.05

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:GetWordFromCfg(417111043)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 42 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 42)

				if (42 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 42)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111043", "story_v_out_417111.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111043", "story_v_out_417111.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_417111", "417111043", "story_v_out_417111.awb")

						arg_178_1:RecordAudio("417111043", var_181_6)
						arg_178_1:RecordAudio("417111043", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417111", "417111043", "story_v_out_417111.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417111", "417111043", "story_v_out_417111.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play417111044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417111044
		arg_182_1.duration_ = 10.63

		local var_182_0 = {
			zh = 6.766,
			ja = 10.633
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play417111045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10128 = arg_182_1.actors_["10128"].transform.localPosition
				arg_182_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10128", 3)

				for iter_185_0 = 0, arg_182_1.actors_["10128"].transform.childCount - 1 do
					local var_185_0 = arg_182_1.actors_["10128"].transform:GetChild(iter_185_0)

					if var_185_0.name == "split_6" or not string.find(var_185_0.name, "split") then
						var_185_0.gameObject:SetActive(true)
					else
						var_185_0.gameObject:SetActive(false)
					end
				end
			end

			local var_185_1 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_1 then
				arg_182_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_182_1.time_ - 0) / var_185_1)
			end

			if arg_182_1.time_ >= 0 + var_185_1 and arg_182_1.time_ < 0 + var_185_1 + arg_185_0 then
				arg_182_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_185_2 = 0
			local var_185_3 = 0.725

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(417111044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 29 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 29)

				if (29 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 29)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111044", "story_v_out_417111.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111044", "story_v_out_417111.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_417111", "417111044", "story_v_out_417111.awb")

						arg_182_1:RecordAudio("417111044", var_185_9)
						arg_182_1:RecordAudio("417111044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417111", "417111044", "story_v_out_417111.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417111", "417111044", "story_v_out_417111.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play417111045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417111045
		arg_186_1.duration_ = 5.27

		local var_186_0 = {
			zh = 3.2,
			ja = 5.266
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
				arg_186_0:Play417111046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10128"]) and arg_186_1.var_.actorSpriteComps10128 == nil then
				arg_186_1.var_.actorSpriteComps10128 = arg_186_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10128"]) then
				if arg_186_1.var_.actorSpriteComps10128 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10128"]) and arg_186_1.var_.actorSpriteComps10128 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps10128 = nil
			end

			local var_189_2 = 0
			local var_189_3 = 0.325

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_4 = arg_186_1:GetWordFromCfg(417111045)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 13 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 13)

				if (13 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 13)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111045", "story_v_out_417111.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111045", "story_v_out_417111.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_417111", "417111045", "story_v_out_417111.awb")

						arg_186_1:RecordAudio("417111045", var_189_9)
						arg_186_1:RecordAudio("417111045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417111", "417111045", "story_v_out_417111.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417111", "417111045", "story_v_out_417111.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417111046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417111046
		arg_190_1.duration_ = 5.47

		local var_190_0 = {
			zh = 1.3,
			ja = 5.466
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
				arg_190_0:Play417111047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10128"]) and arg_190_1.var_.actorSpriteComps10128 == nil then
				arg_190_1.var_.actorSpriteComps10128 = arg_190_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10128"]) then
				if arg_190_1.var_.actorSpriteComps10128 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 1, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10128"]) and arg_190_1.var_.actorSpriteComps10128 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps10128 = nil
			end

			local var_193_2 = 0
			local var_193_3 = 0.15

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:GetWordFromCfg(417111046)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 6 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 6)

				if (6 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 6)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111046", "story_v_out_417111.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111046", "story_v_out_417111.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_417111", "417111046", "story_v_out_417111.awb")

						arg_190_1:RecordAudio("417111046", var_193_9)
						arg_190_1:RecordAudio("417111046", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_417111", "417111046", "story_v_out_417111.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_417111", "417111046", "story_v_out_417111.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417111047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417111047
		arg_194_1.duration_ = 12.9

		local var_194_0 = {
			zh = 8.3,
			ja = 12.9
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417111048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1.125

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:GetWordFromCfg(417111047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 46 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 46)

				if (46 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 46)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111047", "story_v_out_417111.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111047", "story_v_out_417111.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_417111", "417111047", "story_v_out_417111.awb")

						arg_194_1:RecordAudio("417111047", var_197_6)
						arg_194_1:RecordAudio("417111047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417111", "417111047", "story_v_out_417111.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417111", "417111047", "story_v_out_417111.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play417111048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417111048
		arg_198_1.duration_ = 9.83

		local var_198_0 = {
			zh = 4.2,
			ja = 9.833
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417111049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10128 = arg_198_1.actors_["10128"].transform.localPosition
				arg_198_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10128", 3)

				for iter_201_0 = 0, arg_198_1.actors_["10128"].transform.childCount - 1 do
					local var_201_0 = arg_198_1.actors_["10128"].transform:GetChild(iter_201_0)

					if var_201_0.name == "" or not string.find(var_201_0.name, "split") then
						var_201_0.gameObject:SetActive(true)
					else
						var_201_0.gameObject:SetActive(false)
					end
				end
			end

			local var_201_1 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				arg_198_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_198_1.time_ - 0) / var_201_1)
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 then
				arg_198_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_201_2 = 0
			local var_201_3 = 0.525

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(417111048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 21 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 21)

				if (21 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 21)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111048", "story_v_out_417111.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111048", "story_v_out_417111.awb") / 1000

					if var_201_8 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_2
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_417111", "417111048", "story_v_out_417111.awb")

						arg_198_1:RecordAudio("417111048", var_201_9)
						arg_198_1:RecordAudio("417111048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417111", "417111048", "story_v_out_417111.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417111", "417111048", "story_v_out_417111.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_10 and arg_198_1.time_ < var_201_2 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play417111049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417111049
		arg_202_1.duration_ = 10.9

		local var_202_0 = {
			zh = 4.3,
			ja = 10.9
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417111050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10128"]) and arg_202_1.var_.actorSpriteComps10128 == nil then
				arg_202_1.var_.actorSpriteComps10128 = arg_202_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10128"]) then
				if arg_202_1.var_.actorSpriteComps10128 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10128"]) and arg_202_1.var_.actorSpriteComps10128 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps10128 = nil
			end

			local var_205_2 = 0
			local var_205_3 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_4 = arg_202_1:GetWordFromCfg(417111049)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 16 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 16)

				if (16 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 16)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111049", "story_v_out_417111.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111049", "story_v_out_417111.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_out_417111", "417111049", "story_v_out_417111.awb")

						arg_202_1:RecordAudio("417111049", var_205_9)
						arg_202_1:RecordAudio("417111049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417111", "417111049", "story_v_out_417111.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417111", "417111049", "story_v_out_417111.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417111050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417111050
		arg_206_1.duration_ = 7.2

		local var_206_0 = {
			zh = 7.2,
			ja = 6.966
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417111051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10128"]) and arg_206_1.var_.actorSpriteComps10128 == nil then
				arg_206_1.var_.actorSpriteComps10128 = arg_206_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10128"]) then
				if arg_206_1.var_.actorSpriteComps10128 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10128"]) and arg_206_1.var_.actorSpriteComps10128 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps10128 = nil
			end

			local var_209_2 = 0
			local var_209_3 = 0.875

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(417111050)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 35 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 35)

				if (35 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 35)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111050", "story_v_out_417111.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111050", "story_v_out_417111.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_417111", "417111050", "story_v_out_417111.awb")

						arg_206_1:RecordAudio("417111050", var_209_9)
						arg_206_1:RecordAudio("417111050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417111", "417111050", "story_v_out_417111.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417111", "417111050", "story_v_out_417111.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play417111051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417111051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417111052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10128"]) and arg_210_1.var_.actorSpriteComps10128 == nil then
				arg_210_1.var_.actorSpriteComps10128 = arg_210_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10128"]) then
				if arg_210_1.var_.actorSpriteComps10128 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10128"]) and arg_210_1.var_.actorSpriteComps10128 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps10128 = nil
			end

			local var_213_2 = 0
			local var_213_3 = 0.7

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(417111051).content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 28 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_4) / 28)

				if (28 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_4) / 28)) > 0 and var_213_3 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_7 and arg_210_1.time_ < var_213_2 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417111052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417111052
		arg_214_1.duration_ = 5.8

		local var_214_0 = {
			zh = 5.8,
			ja = 5.3
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417111053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.6

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(417111052)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 24 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 24)

				if (24 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 24)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111052", "story_v_out_417111.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111052", "story_v_out_417111.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_417111", "417111052", "story_v_out_417111.awb")

						arg_214_1:RecordAudio("417111052", var_217_6)
						arg_214_1:RecordAudio("417111052", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417111", "417111052", "story_v_out_417111.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417111", "417111052", "story_v_out_417111.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417111053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417111053
		arg_218_1.duration_ = 6.8

		local var_218_0 = {
			zh = 4.1,
			ja = 6.8
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417111054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10128"]) and arg_218_1.var_.actorSpriteComps10128 == nil then
				arg_218_1.var_.actorSpriteComps10128 = arg_218_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10128"]) then
				if arg_218_1.var_.actorSpriteComps10128 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10128"]) and arg_218_1.var_.actorSpriteComps10128 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps10128 = nil
			end

			local var_221_2 = arg_218_1.actors_["10128"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10128 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10128", 3)

				for iter_221_4 = 0, var_221_2.childCount - 1 do
					local var_221_3 = var_221_2:GetChild(iter_221_4)

					if var_221_3.name == "split_6" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_221_5 = 0
			local var_221_6 = 0.525

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:GetWordFromCfg(417111053)
				local var_221_8 = arg_218_1:FormatText(var_221_7.content)

				arg_218_1.text_.text = var_221_8

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 21 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 21)

				if (21 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 21)) > 0 and var_221_6 < var_221_10 then
					arg_218_1.talkMaxDuration = var_221_10

					if var_221_10 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_8
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111053", "story_v_out_417111.awb") ~= 0 then
					local var_221_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111053", "story_v_out_417111.awb") / 1000

					if var_221_11 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_5
					end

					if var_221_7.prefab_name ~= "" and arg_218_1.actors_[var_221_7.prefab_name] ~= nil then
						local var_221_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_7.prefab_name].transform, "story_v_out_417111", "417111053", "story_v_out_417111.awb")

						arg_218_1:RecordAudio("417111053", var_221_12)
						arg_218_1:RecordAudio("417111053", var_221_12)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417111", "417111053", "story_v_out_417111.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417111", "417111053", "story_v_out_417111.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_13 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_13 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_13

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_13 and arg_218_1.time_ < var_221_5 + var_221_13 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play417111054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417111054
		arg_222_1.duration_ = 10.3

		local var_222_0 = {
			zh = 6.7,
			ja = 10.3
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417111055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10128"]) and arg_222_1.var_.actorSpriteComps10128 == nil then
				arg_222_1.var_.actorSpriteComps10128 = arg_222_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10128"]) then
				if arg_222_1.var_.actorSpriteComps10128 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10128"]) and arg_222_1.var_.actorSpriteComps10128 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10128 = nil
			end

			local var_225_2 = 0
			local var_225_3 = 0.725

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_4 = arg_222_1:GetWordFromCfg(417111054)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 29 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 29)

				if (29 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 29)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111054", "story_v_out_417111.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111054", "story_v_out_417111.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_out_417111", "417111054", "story_v_out_417111.awb")

						arg_222_1:RecordAudio("417111054", var_225_9)
						arg_222_1:RecordAudio("417111054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417111", "417111054", "story_v_out_417111.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417111", "417111054", "story_v_out_417111.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417111055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417111055
		arg_226_1.duration_ = 3.33

		local var_226_0 = {
			zh = 2.633,
			ja = 3.333
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417111056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10128"]) and arg_226_1.var_.actorSpriteComps10128 == nil then
				arg_226_1.var_.actorSpriteComps10128 = arg_226_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10128"]) then
				if arg_226_1.var_.actorSpriteComps10128 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10128"]) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_2 = 0
			local var_229_3 = 0.35

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:GetWordFromCfg(417111055)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 14 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 14)

				if (14 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 14)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111055", "story_v_out_417111.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111055", "story_v_out_417111.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_417111", "417111055", "story_v_out_417111.awb")

						arg_226_1:RecordAudio("417111055", var_229_9)
						arg_226_1:RecordAudio("417111055", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417111", "417111055", "story_v_out_417111.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417111", "417111055", "story_v_out_417111.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_10 and arg_226_1.time_ < var_229_2 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417111056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417111056
		arg_230_1.duration_ = 8.73

		local var_230_0 = {
			zh = 4.166,
			ja = 8.733
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417111057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.6

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(417111056)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 24 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 24)

				if (24 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 24)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111056", "story_v_out_417111.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111056", "story_v_out_417111.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_417111", "417111056", "story_v_out_417111.awb")

						arg_230_1:RecordAudio("417111056", var_233_6)
						arg_230_1:RecordAudio("417111056", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417111", "417111056", "story_v_out_417111.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417111", "417111056", "story_v_out_417111.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417111057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417111057
		arg_234_1.duration_ = 12.53

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417111058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 2.00066666666667 < arg_234_1.time_ and arg_234_1.time_ <= 2.00066666666667 + arg_237_0 then
				local var_237_0 = arg_234_1.bgs_.I07a

				arg_234_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_237_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_1 = var_237_0:GetComponent("SpriteRenderer")

				if var_237_1 and var_237_1.sprite then
					local var_237_2 = 2 * (var_237_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_237_0.transform.localScale = Vector3.New(var_237_2 / var_237_1.sprite.bounds.size.y < var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x and var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x or var_237_2 / var_237_1.sprite.bounds.size.y, var_237_2 / var_237_1.sprite.bounds.size.y < var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x and var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x or var_237_2 / var_237_1.sprite.bounds.size.y, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "I07a" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_3 = 0

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_4 = 2

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_4 then
				local var_237_5 = Color.New(0, 0, 0)

				var_237_5.a = Mathf.Lerp(0, 1, (arg_234_1.time_ - var_237_3) / var_237_4)
				arg_234_1.mask_.color = var_237_5
			end

			if arg_234_1.time_ >= var_237_3 + var_237_4 and arg_234_1.time_ < var_237_3 + var_237_4 + arg_237_0 then
				local var_237_6 = Color.New(0, 0, 0)

				var_237_6.a = 1
				arg_234_1.mask_.color = var_237_6
			end

			local var_237_7 = 7.53466666666666

			if 7.53466666666666 < arg_234_1.time_ and arg_234_1.time_ <= var_237_7 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= var_237_7 + 0.3 and arg_234_1.time_ < var_237_7 + 0.3 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_8 = arg_234_1.actors_["10128"]

			if 1.96666666666667 < arg_234_1.time_ and arg_234_1.time_ <= 1.96666666666667 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10128 == nil then
				arg_234_1.var_.actorSpriteComps10128 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_9 = 0.2

			if 1.96666666666667 <= arg_234_1.time_ and arg_234_1.time_ < 1.96666666666667 + var_237_9 and not isNil(var_237_8) then
				if arg_234_1.var_.actorSpriteComps10128 then
					for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_237_3 then
							if arg_234_1.isInRecall_ then
								iter_237_3.color = Color.New(Mathf.Lerp(iter_237_3.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 1.96666666666667) / var_237_9), Mathf.Lerp(iter_237_3.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 1.96666666666667) / var_237_9), (Mathf.Lerp(iter_237_3.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 1.96666666666667) / var_237_9)))
							else
								local var_237_10 = Mathf.Lerp(iter_237_3.color.r, 0.5, (arg_234_1.time_ - 1.96666666666667) / var_237_9)

								iter_237_3.color = Color.New(var_237_10, var_237_10, var_237_10)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 1.96666666666667 + var_237_9 and arg_234_1.time_ < 1.96666666666667 + var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10128 then
				for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_237_5 then
						iter_237_5.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps10128 = nil
			end

			local var_237_11 = arg_234_1.actors_["10128"].transform

			if 1.96666666666667 < arg_234_1.time_ and arg_234_1.time_ <= 1.96666666666667 + arg_237_0 then
				arg_234_1.var_.moveOldPos10128 = var_237_11.localPosition
				var_237_11.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10128", 7)

				for iter_237_6 = 0, var_237_11.childCount - 1 do
					local var_237_12 = var_237_11:GetChild(iter_237_6)

					if var_237_12.name == "" or not string.find(var_237_12.name, "split") then
						var_237_12.gameObject:SetActive(true)
					else
						var_237_12.gameObject:SetActive(false)
					end
				end
			end

			local var_237_13 = 0.001

			if 1.96666666666667 <= arg_234_1.time_ and arg_234_1.time_ < 1.96666666666667 + var_237_13 then
				var_237_11.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_234_1.time_ - 1.96666666666667) / var_237_13)
			end

			if arg_234_1.time_ >= 1.96666666666667 + var_237_13 and arg_234_1.time_ < 1.96666666666667 + var_237_13 + arg_237_0 then
				var_237_11.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_237_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_16 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_16

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_16
						arg_234_1.bgmTxt2_.text = var_237_16
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_234_1.time_ and arg_234_1.time_ <= 1.7 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_237_19 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_19 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_19

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_19
						arg_234_1.bgmTxt2_.text = var_237_19
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 7.40066666666666 < arg_234_1.time_ and arg_234_1.time_ <= 7.40066666666666 + arg_237_0 then
				arg_234_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_dooropen", "")
			end

			local var_237_21 = 2.00066666666667

			if 2.00066666666667 < arg_234_1.time_ and arg_234_1.time_ <= var_237_21 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = false

				arg_234_1:SetGaussion(false)
			end

			local var_237_22 = 1

			if var_237_21 <= arg_234_1.time_ and arg_234_1.time_ < var_237_21 + var_237_22 then
				local var_237_23 = Color.New(0, 0, 0)

				var_237_23.a = Mathf.Lerp(1, 0, (arg_234_1.time_ - var_237_21) / var_237_22)
				arg_234_1.mask_.color = var_237_23
			end

			if arg_234_1.time_ >= var_237_21 + var_237_22 and arg_234_1.time_ < var_237_21 + var_237_22 + arg_237_0 then
				local var_237_24 = Color.New(0, 0, 0)

				arg_234_1.mask_.enabled = false
				var_237_24.a = 0
				arg_234_1.mask_.color = var_237_24
			end

			local var_237_25 = 2.00066666666667

			if 2.00066666666667 < arg_234_1.time_ and arg_234_1.time_ <= var_237_25 + arg_237_0 then
				arg_234_1.timestampController_:SetSelectedState("show")
				arg_234_1.timestampAni_:Play("in")

				arg_234_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")

				arg_234_1.timestampColorController_:SetSelectedState("cold")
				arg_234_1.timeColdImg_:SetAlpha(0.031)

				arg_234_1.text_timeText_.text = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(501083).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_timeText_)

				arg_234_1.text_siteText_.text = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(501084).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_siteText_)
			end

			if arg_234_1.time_ >= var_237_25 + 3 and arg_234_1.time_ < var_237_25 + 3 + arg_237_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_234_1.timestampAni_, "out", function()
					arg_234_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_237_26 = 5.00066666666666

			if 5.00066666666666 < arg_234_1.time_ and arg_234_1.time_ <= var_237_26 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_27 = 1.2

			if var_237_26 <= arg_234_1.time_ and arg_234_1.time_ < var_237_26 + var_237_27 then
				local var_237_28 = Color.New(0, 0, 0)

				var_237_28.a = Mathf.Lerp(0, 1, (arg_234_1.time_ - var_237_26) / var_237_27)
				arg_234_1.mask_.color = var_237_28
			end

			if arg_234_1.time_ >= var_237_26 + var_237_27 and arg_234_1.time_ < var_237_26 + var_237_27 + arg_237_0 then
				local var_237_29 = Color.New(0, 0, 0)

				var_237_29.a = 1
				arg_234_1.mask_.color = var_237_29
			end

			local var_237_30 = 6.20066666666666

			if 6.20066666666666 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_31 = 1.2

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_31 then
				local var_237_32 = Color.New(0, 0, 0)

				var_237_32.a = Mathf.Lerp(1, 0, (arg_234_1.time_ - var_237_30) / var_237_31)
				arg_234_1.mask_.color = var_237_32
			end

			if arg_234_1.time_ >= var_237_30 + var_237_31 and arg_234_1.time_ < var_237_30 + var_237_31 + arg_237_0 then
				local var_237_33 = Color.New(0, 0, 0)

				arg_234_1.mask_.enabled = false
				var_237_33.a = 0
				arg_234_1.mask_.color = var_237_33
			end

			local var_237_34 = 2.00066666666667

			if 2.00066666666667 < arg_234_1.time_ and arg_234_1.time_ <= var_237_34 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= var_237_34 + 3 and arg_234_1.time_ < var_237_34 + 3 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_35 = 7.53466666666666
			local var_237_36 = 1.4

			if 7.53466666666666 < arg_234_1.time_ and arg_234_1.time_ <= var_237_35 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_37 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_37:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_234_1.dialogCg_.alpha = arg_241_0
				end))
				var_237_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_38 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(417111057).content)

				arg_234_1.text_.text = var_237_38

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_40 = 56 <= 0 and var_237_36 or var_237_36 * (utf8.len(var_237_38) / 56)

				if (56 <= 0 and var_237_36 or var_237_36 * (utf8.len(var_237_38) / 56)) > 0 and var_237_36 < var_237_40 then
					arg_234_1.talkMaxDuration = var_237_40
					var_237_35 = var_237_35 + 0.3

					if var_237_40 + var_237_35 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_40 + var_237_35
					end
				end

				arg_234_1.text_.text = var_237_38
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_41 = var_237_35 + 0.3
			local var_237_42 = math.max(var_237_36, arg_234_1.talkMaxDuration)

			if var_237_35 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_41 + var_237_42 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_41) / var_237_42

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_41 + var_237_42 and arg_234_1.time_ < var_237_41 + var_237_42 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417111058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 417111058
		arg_243_1.duration_ = 3.77

		local var_243_0 = {
			zh = 3.766,
			ja = 3.033
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
				arg_243_0:Play417111059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.325

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(417111058)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 13 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 13)

				if (13 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 13)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111058", "story_v_out_417111.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111058", "story_v_out_417111.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_417111", "417111058", "story_v_out_417111.awb")

						arg_243_1:RecordAudio("417111058", var_246_6)
						arg_243_1:RecordAudio("417111058", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_417111", "417111058", "story_v_out_417111.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_417111", "417111058", "story_v_out_417111.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play417111059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417111059
		arg_247_1.duration_ = 3.2

		local var_247_0 = {
			zh = 3.2,
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
				arg_247_0:Play417111060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.actors_["10113"] == nil then
				local var_250_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_250_0) then
					local var_250_1 = Object.Instantiate(var_250_0, arg_247_1.canvasGo_.transform)

					var_250_1.transform:SetSiblingIndex(1)

					var_250_1.name = "10113"
					var_250_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_247_1.actors_["10113"] = var_250_1

					if arg_247_1.isInRecall_ then
						for iter_250_0, iter_250_1 in ipairs((var_250_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_250_1.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_250_2 = arg_247_1.actors_["10113"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10113 == nil then
				arg_247_1.var_.actorSpriteComps10113 = var_250_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_3 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.actorSpriteComps10113 then
					for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_250_3 then
							if arg_247_1.isInRecall_ then
								iter_250_3.color = Color.New(Mathf.Lerp(iter_250_3.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_3), Mathf.Lerp(iter_250_3.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_3), (Mathf.Lerp(iter_250_3.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_3)))
							else
								local var_250_4 = Mathf.Lerp(iter_250_3.color.r, 1, (arg_247_1.time_ - 0) / var_250_3)

								iter_250_3.color = Color.New(var_250_4, var_250_4, var_250_4)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10113 then
				for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_250_5 then
						iter_250_5.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10113 = nil
			end

			local var_250_5 = arg_247_1.actors_["1034"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.actorSpriteComps1034 == nil then
				arg_247_1.var_.actorSpriteComps1034 = var_250_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_6 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_6 and not isNil(var_250_5) then
				if arg_247_1.var_.actorSpriteComps1034 then
					for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_250_7 then
							if arg_247_1.isInRecall_ then
								iter_250_7.color = Color.New(Mathf.Lerp(iter_250_7.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_6), Mathf.Lerp(iter_250_7.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_6), (Mathf.Lerp(iter_250_7.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_6)))
							else
								local var_250_7 = Mathf.Lerp(iter_250_7.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_6)

								iter_250_7.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_6 and arg_247_1.time_ < 0 + var_250_6 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.actorSpriteComps1034 then
				for iter_250_8, iter_250_9 in pairs(arg_247_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_250_9 then
						iter_250_9.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps1034 = nil
			end

			local var_250_8 = arg_247_1.actors_["1034"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1034 = var_250_8.localPosition
				var_250_8.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1034", 7)

				for iter_250_10 = 0, var_250_8.childCount - 1 do
					local var_250_9 = var_250_8:GetChild(iter_250_10)

					if var_250_9.name == "" or not string.find(var_250_9.name, "split") then
						var_250_9.gameObject:SetActive(true)
					else
						var_250_9.gameObject:SetActive(false)
					end
				end
			end

			local var_250_10 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_10 then
				var_250_8.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_10)
			end

			if arg_247_1.time_ >= 0 + var_250_10 and arg_247_1.time_ < 0 + var_250_10 + arg_250_0 then
				var_250_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_11 = arg_247_1.actors_["10113"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10113 = var_250_11.localPosition
				var_250_11.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10113", 3)

				for iter_250_11 = 0, var_250_11.childCount - 1 do
					local var_250_12 = var_250_11:GetChild(iter_250_11)

					if var_250_12.name == "" or not string.find(var_250_12.name, "split") then
						var_250_12.gameObject:SetActive(true)
					else
						var_250_12.gameObject:SetActive(false)
					end
				end
			end

			local var_250_13 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_13 then
				var_250_11.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_247_1.time_ - 0) / var_250_13)
			end

			if arg_247_1.time_ >= 0 + var_250_13 and arg_247_1.time_ < 0 + var_250_13 + arg_250_0 then
				var_250_11.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_250_14 = 0
			local var_250_15 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_16 = arg_247_1:GetWordFromCfg(417111059)
				local var_250_17 = arg_247_1:FormatText(var_250_16.content)

				arg_247_1.text_.text = var_250_17

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_19 = 17 <= 0 and var_250_15 or var_250_15 * (utf8.len(var_250_17) / 17)

				if (17 <= 0 and var_250_15 or var_250_15 * (utf8.len(var_250_17) / 17)) > 0 and var_250_15 < var_250_19 then
					arg_247_1.talkMaxDuration = var_250_19

					if var_250_19 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_14
					end
				end

				arg_247_1.text_.text = var_250_17
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111059", "story_v_out_417111.awb") ~= 0 then
					local var_250_20 = manager.audio:GetVoiceLength("story_v_out_417111", "417111059", "story_v_out_417111.awb") / 1000

					if var_250_20 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_20 + var_250_14
					end

					if var_250_16.prefab_name ~= "" and arg_247_1.actors_[var_250_16.prefab_name] ~= nil then
						local var_250_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_16.prefab_name].transform, "story_v_out_417111", "417111059", "story_v_out_417111.awb")

						arg_247_1:RecordAudio("417111059", var_250_21)
						arg_247_1:RecordAudio("417111059", var_250_21)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_417111", "417111059", "story_v_out_417111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_417111", "417111059", "story_v_out_417111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = math.max(var_250_15, arg_247_1.talkMaxDuration)

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_22 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_14) / var_250_22

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_14 + var_250_22 and arg_247_1.time_ < var_250_14 + var_250_22 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 417111060
		arg_251_1.duration_ = 9.43

		local var_251_0 = {
			zh = 5.4,
			ja = 9.433
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
				arg_251_0:Play417111061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1034"]) and arg_251_1.var_.actorSpriteComps1034 == nil then
				arg_251_1.var_.actorSpriteComps1034 = arg_251_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1034"]) then
				if arg_251_1.var_.actorSpriteComps1034 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 1, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1034"]) and arg_251_1.var_.actorSpriteComps1034 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1034 = nil
			end

			local var_254_2 = arg_251_1.actors_["10113"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10113 == nil then
				arg_251_1.var_.actorSpriteComps10113 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps10113 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								iter_254_5.color = Color.New(Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_3), Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_3), (Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_3)))
							else
								local var_254_4 = Mathf.Lerp(iter_254_5.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_3)

								iter_254_5.color = Color.New(var_254_4, var_254_4, var_254_4)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10113 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_254_7 then
						iter_254_7.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10113 = nil
			end

			local var_254_5 = arg_251_1.actors_["1034"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1034 = var_254_5.localPosition
				var_254_5.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1034", 2)

				for iter_254_8 = 0, var_254_5.childCount - 1 do
					local var_254_6 = var_254_5:GetChild(iter_254_8)

					if var_254_6.name == "" or not string.find(var_254_6.name, "split") then
						var_254_6.gameObject:SetActive(true)
					else
						var_254_6.gameObject:SetActive(false)
					end
				end
			end

			local var_254_7 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				var_254_5.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_251_1.time_ - 0) / var_254_7)
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				var_254_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_254_8 = arg_251_1.actors_["10113"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10113 = var_254_8.localPosition
				var_254_8.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10113", 4)

				for iter_254_9 = 0, var_254_8.childCount - 1 do
					local var_254_9 = var_254_8:GetChild(iter_254_9)

					if var_254_9.name == "" or not string.find(var_254_9.name, "split") then
						var_254_9.gameObject:SetActive(true)
					else
						var_254_9.gameObject:SetActive(false)
					end
				end
			end

			local var_254_10 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_10 then
				var_254_8.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_251_1.time_ - 0) / var_254_10)
			end

			if arg_251_1.time_ >= 0 + var_254_10 and arg_251_1.time_ < 0 + var_254_10 + arg_254_0 then
				var_254_8.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_254_11 = 0
			local var_254_12 = 0.475

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_11 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:GetWordFromCfg(417111060)
				local var_254_14 = arg_251_1:FormatText(var_254_13.content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_16 = 19 <= 0 and var_254_12 or var_254_12 * (utf8.len(var_254_14) / 19)

				if (19 <= 0 and var_254_12 or var_254_12 * (utf8.len(var_254_14) / 19)) > 0 and var_254_12 < var_254_16 then
					arg_251_1.talkMaxDuration = var_254_16

					if var_254_16 + var_254_11 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_16 + var_254_11
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111060", "story_v_out_417111.awb") ~= 0 then
					local var_254_17 = manager.audio:GetVoiceLength("story_v_out_417111", "417111060", "story_v_out_417111.awb") / 1000

					if var_254_17 + var_254_11 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_17 + var_254_11
					end

					if var_254_13.prefab_name ~= "" and arg_251_1.actors_[var_254_13.prefab_name] ~= nil then
						local var_254_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_13.prefab_name].transform, "story_v_out_417111", "417111060", "story_v_out_417111.awb")

						arg_251_1:RecordAudio("417111060", var_254_18)
						arg_251_1:RecordAudio("417111060", var_254_18)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_417111", "417111060", "story_v_out_417111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_417111", "417111060", "story_v_out_417111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_19 = math.max(var_254_12, arg_251_1.talkMaxDuration)

			if var_254_11 <= arg_251_1.time_ and arg_251_1.time_ < var_254_11 + var_254_19 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_11) / var_254_19

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_11 + var_254_19 and arg_251_1.time_ < var_254_11 + var_254_19 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 417111061
		arg_255_1.duration_ = 9.87

		local var_255_0 = {
			zh = 7.466,
			ja = 9.866
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
				arg_255_0:Play417111062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10113"]) and arg_255_1.var_.actorSpriteComps10113 == nil then
				arg_255_1.var_.actorSpriteComps10113 = arg_255_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10113"]) then
				if arg_255_1.var_.actorSpriteComps10113 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10113"]) and arg_255_1.var_.actorSpriteComps10113 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10113 = nil
			end

			local var_258_2 = arg_255_1.actors_["1034"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1034 == nil then
				arg_255_1.var_.actorSpriteComps1034 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps1034 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								iter_258_5.color = Color.New(Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_5.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_5.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1034 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_258_7 then
						iter_258_7.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps1034 = nil
			end

			local var_258_5 = 0
			local var_258_6 = 1.025

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(417111061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 41 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 41)

				if (41 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 41)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111061", "story_v_out_417111.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111061", "story_v_out_417111.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_417111", "417111061", "story_v_out_417111.awb")

						arg_255_1:RecordAudio("417111061", var_258_12)
						arg_255_1:RecordAudio("417111061", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_417111", "417111061", "story_v_out_417111.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_417111", "417111061", "story_v_out_417111.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play417111062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 417111062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play417111063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10113"]) and arg_259_1.var_.actorSpriteComps10113 == nil then
				arg_259_1.var_.actorSpriteComps10113 = arg_259_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10113"]) then
				if arg_259_1.var_.actorSpriteComps10113 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10113"]) and arg_259_1.var_.actorSpriteComps10113 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps10113 = nil
			end

			local var_262_2 = 0
			local var_262_3 = 1.5

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(417111062).content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_6 = 60 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 60)

				if (60 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 60)) > 0 and var_262_3 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_7 and arg_259_1.time_ < var_262_2 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play417111063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417111063
		arg_263_1.duration_ = 4.03

		local var_263_0 = {
			zh = 2.766,
			ja = 4.033
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play417111064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1034"]) and arg_263_1.var_.actorSpriteComps1034 == nil then
				arg_263_1.var_.actorSpriteComps1034 = arg_263_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1034"]) then
				if arg_263_1.var_.actorSpriteComps1034 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 1, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1034"]) and arg_263_1.var_.actorSpriteComps1034 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps1034 = nil
			end

			local var_266_2 = arg_263_1.actors_["1034"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1034 = var_266_2.localPosition
				var_266_2.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1034", 2)

				for iter_266_4 = 0, var_266_2.childCount - 1 do
					local var_266_3 = var_266_2:GetChild(iter_266_4)

					if var_266_3.name == "" or not string.find(var_266_3.name, "split") then
						var_266_3.gameObject:SetActive(true)
					else
						var_266_3.gameObject:SetActive(false)
					end
				end
			end

			local var_266_4 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				var_266_2.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_263_1.time_ - 0) / var_266_4)
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_266_5 = 0
			local var_266_6 = 0.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(417111063)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 12 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 12)

				if (12 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 12)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111063", "story_v_out_417111.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111063", "story_v_out_417111.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_417111", "417111063", "story_v_out_417111.awb")

						arg_263_1:RecordAudio("417111063", var_266_12)
						arg_263_1:RecordAudio("417111063", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_417111", "417111063", "story_v_out_417111.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_417111", "417111063", "story_v_out_417111.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_13 and arg_263_1.time_ < var_266_5 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play417111064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417111064
		arg_267_1.duration_ = 6.73

		local var_267_0 = {
			zh = 5.666,
			ja = 6.733
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play417111065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10113"]) and arg_267_1.var_.actorSpriteComps10113 == nil then
				arg_267_1.var_.actorSpriteComps10113 = arg_267_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10113"]) then
				if arg_267_1.var_.actorSpriteComps10113 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10113"]) and arg_267_1.var_.actorSpriteComps10113 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps10113 = nil
			end

			local var_270_2 = arg_267_1.actors_["1034"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1034 == nil then
				arg_267_1.var_.actorSpriteComps1034 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps1034 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								iter_270_5.color = Color.New(Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_5.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_5.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1034 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_270_7 then
						iter_270_7.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps1034 = nil
			end

			local var_270_5 = 0
			local var_270_6 = 0.725

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(417111064)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 29 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 29)

				if (29 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 29)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111064", "story_v_out_417111.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111064", "story_v_out_417111.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_417111", "417111064", "story_v_out_417111.awb")

						arg_267_1:RecordAudio("417111064", var_270_12)
						arg_267_1:RecordAudio("417111064", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_417111", "417111064", "story_v_out_417111.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_417111", "417111064", "story_v_out_417111.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417111065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417111065
		arg_271_1.duration_ = 11.1

		local var_271_0 = {
			zh = 9.433,
			ja = 11.1
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play417111066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1034"]) and arg_271_1.var_.actorSpriteComps1034 == nil then
				arg_271_1.var_.actorSpriteComps1034 = arg_271_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1034"]) then
				if arg_271_1.var_.actorSpriteComps1034 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 1, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1034"]) and arg_271_1.var_.actorSpriteComps1034 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps1034 = nil
			end

			local var_274_2 = arg_271_1.actors_["10113"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10113 == nil then
				arg_271_1.var_.actorSpriteComps10113 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps10113 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								iter_274_5.color = Color.New(Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_5.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_5.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10113 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_274_7 then
						iter_274_7.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps10113 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 1.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(417111065)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 44 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 44)

				if (44 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 44)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111065", "story_v_out_417111.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111065", "story_v_out_417111.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_417111", "417111065", "story_v_out_417111.awb")

						arg_271_1:RecordAudio("417111065", var_274_12)
						arg_271_1:RecordAudio("417111065", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_417111", "417111065", "story_v_out_417111.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_417111", "417111065", "story_v_out_417111.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play417111066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417111066
		arg_275_1.duration_ = 13.5

		local var_275_0 = {
			zh = 9.7,
			ja = 13.5
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play417111067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10113"]) and arg_275_1.var_.actorSpriteComps10113 == nil then
				arg_275_1.var_.actorSpriteComps10113 = arg_275_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10113"]) then
				if arg_275_1.var_.actorSpriteComps10113 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 1, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10113"]) and arg_275_1.var_.actorSpriteComps10113 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10113 = nil
			end

			local var_278_2 = arg_275_1.actors_["1034"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps1034 == nil then
				arg_275_1.var_.actorSpriteComps1034 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps1034 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								iter_278_5.color = Color.New(Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_3), Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_3), (Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_3)))
							else
								local var_278_4 = Mathf.Lerp(iter_278_5.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_3)

								iter_278_5.color = Color.New(var_278_4, var_278_4, var_278_4)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps1034 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_278_7 then
						iter_278_7.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps1034 = nil
			end

			local var_278_5 = 0
			local var_278_6 = 1.15

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(417111066)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 46 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 46)

				if (46 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 46)) > 0 and var_278_6 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111066", "story_v_out_417111.awb") ~= 0 then
					local var_278_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111066", "story_v_out_417111.awb") / 1000

					if var_278_11 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_5
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_417111", "417111066", "story_v_out_417111.awb")

						arg_275_1:RecordAudio("417111066", var_278_12)
						arg_275_1:RecordAudio("417111066", var_278_12)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_417111", "417111066", "story_v_out_417111.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_417111", "417111066", "story_v_out_417111.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_13 and arg_275_1.time_ < var_278_5 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play417111067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417111067
		arg_279_1.duration_ = 6.1

		local var_279_0 = {
			zh = 3.6,
			ja = 6.1
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play417111068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1034"]) and arg_279_1.var_.actorSpriteComps1034 == nil then
				arg_279_1.var_.actorSpriteComps1034 = arg_279_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1034"]) then
				if arg_279_1.var_.actorSpriteComps1034 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 1, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1034"]) and arg_279_1.var_.actorSpriteComps1034 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps1034 = nil
			end

			local var_282_2 = arg_279_1.actors_["10113"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10113 == nil then
				arg_279_1.var_.actorSpriteComps10113 = var_282_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_3 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.actorSpriteComps10113 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								iter_282_5.color = Color.New(Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, (arg_279_1.time_ - 0) / var_282_3), Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, (arg_279_1.time_ - 0) / var_282_3), (Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, (arg_279_1.time_ - 0) / var_282_3)))
							else
								local var_282_4 = Mathf.Lerp(iter_282_5.color.r, 0.5, (arg_279_1.time_ - 0) / var_282_3)

								iter_282_5.color = Color.New(var_282_4, var_282_4, var_282_4)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10113 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_282_7 then
						iter_282_7.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10113 = nil
			end

			local var_282_5 = arg_279_1.actors_["1034"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1034 = var_282_5.localPosition
				var_282_5.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1034", 2)

				for iter_282_8 = 0, var_282_5.childCount - 1 do
					local var_282_6 = var_282_5:GetChild(iter_282_8)

					if var_282_6.name == "split_6" or not string.find(var_282_6.name, "split") then
						var_282_6.gameObject:SetActive(true)
					else
						var_282_6.gameObject:SetActive(false)
					end
				end
			end

			local var_282_7 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				var_282_5.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_279_1.time_ - 0) / var_282_7)
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				var_282_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_282_8 = 0
			local var_282_9 = 0.45

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(417111067)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 18 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 18)

				if (18 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 18)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111067", "story_v_out_417111.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111067", "story_v_out_417111.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_417111", "417111067", "story_v_out_417111.awb")

						arg_279_1:RecordAudio("417111067", var_282_15)
						arg_279_1:RecordAudio("417111067", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417111", "417111067", "story_v_out_417111.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417111", "417111067", "story_v_out_417111.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play417111068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417111068
		arg_283_1.duration_ = 3.47

		local var_283_0 = {
			zh = 3.266,
			ja = 3.466
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play417111069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10113"]) and arg_283_1.var_.actorSpriteComps10113 == nil then
				arg_283_1.var_.actorSpriteComps10113 = arg_283_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10113"]) then
				if arg_283_1.var_.actorSpriteComps10113 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10113"]) and arg_283_1.var_.actorSpriteComps10113 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps10113 = nil
			end

			local var_286_2 = arg_283_1.actors_["1034"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps1034 == nil then
				arg_283_1.var_.actorSpriteComps1034 = var_286_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_3 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.actorSpriteComps1034 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_286_5 then
							if arg_283_1.isInRecall_ then
								iter_286_5.color = Color.New(Mathf.Lerp(iter_286_5.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_3), Mathf.Lerp(iter_286_5.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_3), (Mathf.Lerp(iter_286_5.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_3)))
							else
								local var_286_4 = Mathf.Lerp(iter_286_5.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_3)

								iter_286_5.color = Color.New(var_286_4, var_286_4, var_286_4)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps1034 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_286_7 then
						iter_286_7.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps1034 = nil
			end

			local var_286_5 = arg_283_1.actors_["10113"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10113 = var_286_5.localPosition
				var_286_5.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10113", 4)

				for iter_286_8 = 0, var_286_5.childCount - 1 do
					local var_286_6 = var_286_5:GetChild(iter_286_8)

					if var_286_6.name == "split_6" or not string.find(var_286_6.name, "split") then
						var_286_6.gameObject:SetActive(true)
					else
						var_286_6.gameObject:SetActive(false)
					end
				end
			end

			local var_286_7 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				var_286_5.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_283_1.time_ - 0) / var_286_7)
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				var_286_5.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_286_8 = 0
			local var_286_9 = 0.4

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(417111068)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 16 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 16)

				if (16 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 16)) > 0 and var_286_9 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111068", "story_v_out_417111.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111068", "story_v_out_417111.awb") / 1000

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_out_417111", "417111068", "story_v_out_417111.awb")

						arg_283_1:RecordAudio("417111068", var_286_15)
						arg_283_1:RecordAudio("417111068", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_417111", "417111068", "story_v_out_417111.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_417111", "417111068", "story_v_out_417111.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play417111069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417111069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play417111070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10113"]) and arg_287_1.var_.actorSpriteComps10113 == nil then
				arg_287_1.var_.actorSpriteComps10113 = arg_287_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10113"]) then
				if arg_287_1.var_.actorSpriteComps10113 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor2.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor2.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor2.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 0.5, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10113"]) and arg_287_1.var_.actorSpriteComps10113 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps10113 = nil
			end

			local var_290_2 = arg_287_1.actors_["1034"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1034 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1034", 2)

				for iter_290_4 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_4)

					if var_290_3.name == "split_6" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_290_5 = 0
			local var_290_6 = 0.825

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(417111069).content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 33 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 33)

				if (33 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 33)) > 0 and var_290_6 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_10 and arg_287_1.time_ < var_290_5 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play417111070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417111070
		arg_291_1.duration_ = 3.83

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play417111071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 1.06666666666667 < arg_291_1.time_ and arg_291_1.time_ <= 1.06666666666667 + arg_294_0 and not isNil(arg_291_1.actors_["1034"]) and arg_291_1.var_.actorSpriteComps1034 == nil then
				arg_291_1.var_.actorSpriteComps1034 = arg_291_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 1.06666666666667 <= arg_291_1.time_ and arg_291_1.time_ < 1.06666666666667 + var_294_0 and not isNil(arg_291_1.actors_["1034"]) then
				if arg_291_1.var_.actorSpriteComps1034 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 1.06666666666667) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 1.06666666666667) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 1.06666666666667) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 1, (arg_291_1.time_ - 1.06666666666667) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 1.06666666666667 + var_294_0 and arg_291_1.time_ < 1.06666666666667 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1034"]) and arg_291_1.var_.actorSpriteComps1034 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps1034 = nil
			end

			local var_294_2 = arg_291_1.actors_["1034"].transform

			if 1.06666666666667 < arg_291_1.time_ and arg_291_1.time_ <= 1.06666666666667 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034 = var_294_2.localPosition
				var_294_2.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1034", 7)

				for iter_294_4 = 0, var_294_2.childCount - 1 do
					local var_294_3 = var_294_2:GetChild(iter_294_4)

					if var_294_3.name == "" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if 1.06666666666667 <= arg_291_1.time_ and arg_291_1.time_ < 1.06666666666667 + var_294_4 then
				var_294_2.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 1.06666666666667) / var_294_4)
			end

			if arg_291_1.time_ >= 1.06666666666667 + var_294_4 and arg_291_1.time_ < 1.06666666666667 + var_294_4 + arg_294_0 then
				var_294_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_5 = arg_291_1.actors_["10113"].transform

			if 1.06666666666667 < arg_291_1.time_ and arg_291_1.time_ <= 1.06666666666667 + arg_294_0 then
				arg_291_1.var_.moveOldPos10113 = var_294_5.localPosition
				var_294_5.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10113", 7)

				for iter_294_5 = 0, var_294_5.childCount - 1 do
					local var_294_6 = var_294_5:GetChild(iter_294_5)

					if var_294_6.name == "" or not string.find(var_294_6.name, "split") then
						var_294_6.gameObject:SetActive(true)
					else
						var_294_6.gameObject:SetActive(false)
					end
				end
			end

			local var_294_7 = 0.001

			if 1.06666666666667 <= arg_291_1.time_ and arg_291_1.time_ < 1.06666666666667 + var_294_7 then
				var_294_5.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 1.06666666666667) / var_294_7)
			end

			if arg_291_1.time_ >= 1.06666666666667 + var_294_7 and arg_291_1.time_ < 1.06666666666667 + var_294_7 + arg_294_0 then
				var_294_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.1 < arg_291_1.time_ and arg_291_1.time_ <= 1.1 + arg_294_0 then
				arg_291_1.cswbg_:SetActive(true)

				local var_294_8 = arg_291_1.cswt_:GetComponent("RectTransform")

				arg_291_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_294_8.offsetMin = Vector2.New(400, 105)
				var_294_8.offsetMax = Vector2.New(-400, -200)
				arg_291_1.cswt_.text = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(419104).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.cswt_)

				arg_291_1.cswt_.fontSize = 100
				arg_291_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_291_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_291_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.1 < arg_291_1.time_ and arg_291_1.time_ <= 1.1 + arg_294_0 then
				local var_294_9 = arg_291_1.fswbg_.transform:Find("textbox/adapt/content") or arg_291_1.fswbg_.transform:Find("textbox/content")
				local var_294_10 = arg_291_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_294_11 = var_294_9:GetComponent("RectTransform")

				var_294_9:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_294_11.offsetMin = Vector2.New(0, 0)
				var_294_11.offsetMax = Vector2.New(0, 0)
			end

			if 1.1 < arg_291_1.time_ and arg_291_1.time_ <= 1.1 + arg_294_0 then
				arg_291_1.fswbg_:SetActive(true)
				arg_291_1.dialog_:SetActive(false)

				arg_291_1.fswtw_.percent = 0
				arg_291_1.fswt_.text = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(417111070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.fswt_)

				arg_291_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_291_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_291_1.fswtw_:SetDirty()

				arg_291_1.typewritterCharCountI18N = 0

				SetActive(arg_291_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_291_1:ShowNextGo(false)
			end

			local var_294_12 = 1.86666666666667

			if 1.86666666666667 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 then
				arg_291_1.var_.oldValueTypewriter = arg_291_1.fswtw_.percent

				SetActive(arg_291_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_291_1:ShowNextGo(false)
			end

			local var_294_13 = 8
			local var_294_14 = 0.533333333333333
			local var_294_15, var_294_16 = arg_291_1:GetPercentByPara(arg_291_1:FormatText(arg_291_1:GetWordFromCfg(417111070).content), 1)

			if var_294_12 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				local var_294_17 = var_294_13 <= 0 and var_294_14 or var_294_14 * ((var_294_16 - arg_291_1.typewritterCharCountI18N) / var_294_13)

				if (var_294_13 <= 0 and var_294_14 or var_294_14 * ((var_294_16 - arg_291_1.typewritterCharCountI18N) / var_294_13)) > 0 and var_294_14 < var_294_17 then
					arg_291_1.talkMaxDuration = var_294_17

					if var_294_17 + var_294_12 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_17 + var_294_12
					end
				end
			end

			local var_294_18 = math.max(0.533333333333333, arg_291_1.talkMaxDuration)

			if var_294_12 <= arg_291_1.time_ and arg_291_1.time_ < var_294_12 + var_294_18 then
				arg_291_1.fswtw_.percent = Mathf.Lerp(arg_291_1.var_.oldValueTypewriter, var_294_15, (arg_291_1.time_ - var_294_12) / var_294_18)
				arg_291_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_291_1.fswtw_:SetDirty()
			end

			if arg_291_1.time_ >= var_294_12 + var_294_18 and arg_291_1.time_ < var_294_12 + var_294_18 + arg_294_0 then
				arg_291_1.fswtw_.percent = var_294_15

				arg_291_1.fswtw_:SetDirty()
				arg_291_1:ShowNextGo(true)

				arg_291_1.typewritterCharCountI18N = var_294_16
			end

			local var_294_19 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_19 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_20 = 1.1

			if var_294_19 <= arg_291_1.time_ and arg_291_1.time_ < var_294_19 + var_294_20 then
				local var_294_21 = Color.New(0, 0, 0)

				var_294_21.a = Mathf.Lerp(0, 1, (arg_291_1.time_ - var_294_19) / var_294_20)
				arg_291_1.mask_.color = var_294_21
			end

			if arg_291_1.time_ >= var_294_19 + var_294_20 and arg_291_1.time_ < var_294_19 + var_294_20 + arg_294_0 then
				local var_294_22 = Color.New(0, 0, 0)

				var_294_22.a = 1
				arg_291_1.mask_.color = var_294_22
			end

			local var_294_23 = 1.1

			if 1.1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_24 = 2

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_24 then
				local var_294_25 = Color.New(0, 0, 0)

				var_294_25.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_23) / var_294_24)
				arg_291_1.mask_.color = var_294_25
			end

			if arg_291_1.time_ >= var_294_23 + var_294_24 and arg_291_1.time_ < var_294_23 + var_294_24 + arg_294_0 then
				local var_294_26 = Color.New(0, 0, 0)

				arg_291_1.mask_.enabled = false
				var_294_26.a = 0
				arg_291_1.mask_.color = var_294_26
			end

			local var_294_27 = "STblack"

			if arg_291_1.bgs_.STblack == nil then
				local var_294_28 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_28:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_294_27)
				var_294_28.name = var_294_27
				var_294_28.transform.parent = arg_291_1.stage_.transform
				var_294_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_[var_294_27] = var_294_28
			end

			if 1.1 < arg_291_1.time_ and arg_291_1.time_ <= 1.1 + arg_294_0 then
				local var_294_29 = arg_291_1.bgs_.STblack

				arg_291_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_30 = var_294_29:GetComponent("SpriteRenderer")

				if var_294_30 and var_294_30.sprite then
					local var_294_31 = 2 * (var_294_29.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_29.transform.localScale = Vector3.New(var_294_31 / var_294_30.sprite.bounds.size.y < var_294_31 * manager.ui.mainCameraCom_.aspect / var_294_30.sprite.bounds.size.x and var_294_31 * manager.ui.mainCameraCom_.aspect / var_294_30.sprite.bounds.size.x or var_294_31 / var_294_30.sprite.bounds.size.y, var_294_31 / var_294_30.sprite.bounds.size.y < var_294_31 * manager.ui.mainCameraCom_.aspect / var_294_30.sprite.bounds.size.x and var_294_31 * manager.ui.mainCameraCom_.aspect / var_294_30.sprite.bounds.size.x or var_294_31 / var_294_30.sprite.bounds.size.y, 0)
				end

				for iter_294_6, iter_294_7 in pairs(arg_291_1.bgs_) do
					if iter_294_6 ~= "STblack" then
						iter_294_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_32 = 1.76666666666667
			local var_294_33 = manager.audio:GetVoiceLength("story_v_out_417111", "417111070", "") / 1000

			if var_294_33 > 0 and 2.066 < var_294_33 and var_294_33 + var_294_32 > arg_291_1.duration_ then
				arg_291_1.duration_ = var_294_33 + var_294_32
			end

			if var_294_32 < arg_291_1.time_ and arg_291_1.time_ <= var_294_32 + arg_294_0 then
				arg_291_1:AudioAction("play", "voice", "story_v_out_417111", "417111070", "")
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play417111071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417111071
		arg_295_1.duration_ = 12.33

		local var_295_0 = {
			zh = 11.333,
			ja = 12.333
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play417111072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 3.1 < arg_295_1.time_ and arg_295_1.time_ <= 3.1 + arg_298_0 and not isNil(arg_295_1.actors_["10113"]) and arg_295_1.var_.actorSpriteComps10113 == nil then
				arg_295_1.var_.actorSpriteComps10113 = arg_295_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 3.1 <= arg_295_1.time_ and arg_295_1.time_ < 3.1 + var_298_0 and not isNil(arg_295_1.actors_["10113"]) then
				if arg_295_1.var_.actorSpriteComps10113 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 3.1) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 3.1) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 3.1) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 3.1) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 3.1 + var_298_0 and arg_295_1.time_ < 3.1 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10113"]) and arg_295_1.var_.actorSpriteComps10113 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10113 = nil
			end

			local var_298_2 = arg_295_1.actors_["10113"].transform

			if 3.1 < arg_295_1.time_ and arg_295_1.time_ <= 3.1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10113 = var_298_2.localPosition
				var_298_2.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10113", 3)

				for iter_298_4 = 0, var_298_2.childCount - 1 do
					local var_298_3 = var_298_2:GetChild(iter_298_4)

					if var_298_3.name == "" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if 3.1 <= arg_295_1.time_ and arg_295_1.time_ < 3.1 + var_298_4 then
				var_298_2.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_295_1.time_ - 3.1) / var_298_4)
			end

			if arg_295_1.time_ >= 3.1 + var_298_4 and arg_295_1.time_ < 3.1 + var_298_4 + arg_298_0 then
				var_298_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 1.3 < arg_295_1.time_ and arg_295_1.time_ <= 1.3 + arg_298_0 then
				arg_295_1.cswbg_:SetActive(false)
			end

			if 1.3 < arg_295_1.time_ and arg_295_1.time_ <= 1.3 + arg_298_0 then
				local var_298_5 = arg_295_1.fswbg_.transform:Find("textbox/adapt/content") or arg_295_1.fswbg_.transform:Find("textbox/content")
				local var_298_6 = arg_295_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_298_7 = var_298_5:GetComponent("RectTransform")

				var_298_5:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_298_7.offsetMin = Vector2.New(0, 0)
				var_298_7.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_295_1.time_ and arg_295_1.time_ <= 1.3 + arg_298_0 then
				arg_295_1.fswbg_:SetActive(false)
				arg_295_1.dialog_:SetActive(false)
				SetActive(arg_295_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_295_1:ShowNextGo(false)
			end

			if 1.334 < arg_295_1.time_ and arg_295_1.time_ <= 1.334 + arg_298_0 then
				arg_295_1.fswbg_:SetActive(false)
				arg_295_1.dialog_:SetActive(false)
				SetActive(arg_295_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_295_1:ShowNextGo(false)
			end

			local var_298_8 = 0

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_9 = 1.3

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_9 then
				local var_298_10 = Color.New(0, 0, 0)

				var_298_10.a = Mathf.Lerp(0, 1, (arg_295_1.time_ - var_298_8) / var_298_9)
				arg_295_1.mask_.color = var_298_10
			end

			if arg_295_1.time_ >= var_298_8 + var_298_9 and arg_295_1.time_ < var_298_8 + var_298_9 + arg_298_0 then
				local var_298_11 = Color.New(0, 0, 0)

				var_298_11.a = 1
				arg_295_1.mask_.color = var_298_11
			end

			local var_298_12 = 1.3

			if 1.3 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_13 = 2

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_13 then
				local var_298_14 = Color.New(0, 0, 0)

				var_298_14.a = Mathf.Lerp(1, 0, (arg_295_1.time_ - var_298_12) / var_298_13)
				arg_295_1.mask_.color = var_298_14
			end

			if arg_295_1.time_ >= var_298_12 + var_298_13 and arg_295_1.time_ < var_298_12 + var_298_13 + arg_298_0 then
				local var_298_15 = Color.New(0, 0, 0)

				arg_295_1.mask_.enabled = false
				var_298_15.a = 0
				arg_295_1.mask_.color = var_298_15
			end

			if 1.3 < arg_295_1.time_ and arg_295_1.time_ <= 1.3 + arg_298_0 then
				local var_298_16 = arg_295_1.bgs_.I07a

				arg_295_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_298_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_17 = var_298_16:GetComponent("SpriteRenderer")

				if var_298_17 and var_298_17.sprite then
					local var_298_18 = 2 * (var_298_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_298_16.transform.localScale = Vector3.New(var_298_18 / var_298_17.sprite.bounds.size.y < var_298_18 * manager.ui.mainCameraCom_.aspect / var_298_17.sprite.bounds.size.x and var_298_18 * manager.ui.mainCameraCom_.aspect / var_298_17.sprite.bounds.size.x or var_298_18 / var_298_17.sprite.bounds.size.y, var_298_18 / var_298_17.sprite.bounds.size.y < var_298_18 * manager.ui.mainCameraCom_.aspect / var_298_17.sprite.bounds.size.x and var_298_18 * manager.ui.mainCameraCom_.aspect / var_298_17.sprite.bounds.size.x or var_298_18 / var_298_17.sprite.bounds.size.y, 0)
				end

				for iter_298_5, iter_298_6 in pairs(arg_295_1.bgs_) do
					if iter_298_5 ~= "I07a" then
						iter_298_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 3.099999999999 < arg_295_1.time_ and arg_295_1.time_ <= 3.099999999999 + arg_298_0 then
				local var_298_19 = arg_295_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_298_19 then
					arg_295_1.var_.alphaOldValue10113 = var_298_19.alpha
					arg_295_1.var_.characterEffect10113 = var_298_19
				end

				arg_295_1.var_.alphaOldValue10113 = 0
			end

			local var_298_20 = 0.200000000001

			if 3.099999999999 <= arg_295_1.time_ and arg_295_1.time_ < 3.099999999999 + var_298_20 then
				if arg_295_1.var_.characterEffect10113 then
					arg_295_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_295_1.var_.alphaOldValue10113, 1, (arg_295_1.time_ - 3.099999999999) / var_298_20)
				end
			end

			if arg_295_1.time_ >= 3.099999999999 + var_298_20 and arg_295_1.time_ < 3.099999999999 + var_298_20 + arg_298_0 and arg_295_1.var_.characterEffect10113 then
				arg_295_1.var_.characterEffect10113.alpha = 1
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_21 = 3.3
			local var_298_22 = 0.925

			if 3.3 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_23 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_23:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_24 = arg_295_1:GetWordFromCfg(417111071)
				local var_298_25 = arg_295_1:FormatText(var_298_24.content)

				arg_295_1.text_.text = var_298_25

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_27 = 37 <= 0 and var_298_22 or var_298_22 * (utf8.len(var_298_25) / 37)

				if (37 <= 0 and var_298_22 or var_298_22 * (utf8.len(var_298_25) / 37)) > 0 and var_298_22 < var_298_27 then
					arg_295_1.talkMaxDuration = var_298_27
					var_298_21 = var_298_21 + 0.3

					if var_298_27 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_27 + var_298_21
					end
				end

				arg_295_1.text_.text = var_298_25
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111071", "story_v_out_417111.awb") ~= 0 then
					local var_298_28 = manager.audio:GetVoiceLength("story_v_out_417111", "417111071", "story_v_out_417111.awb") / 1000

					if var_298_28 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_28 + var_298_21
					end

					if var_298_24.prefab_name ~= "" and arg_295_1.actors_[var_298_24.prefab_name] ~= nil then
						local var_298_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_24.prefab_name].transform, "story_v_out_417111", "417111071", "story_v_out_417111.awb")

						arg_295_1:RecordAudio("417111071", var_298_29)
						arg_295_1:RecordAudio("417111071", var_298_29)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417111", "417111071", "story_v_out_417111.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417111", "417111071", "story_v_out_417111.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_30 = var_298_21 + 0.3
			local var_298_31 = math.max(var_298_22, arg_295_1.talkMaxDuration)

			if var_298_21 + 0.3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_30 + var_298_31 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_30) / var_298_31

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_30 + var_298_31 and arg_295_1.time_ < var_298_30 + var_298_31 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play417111072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 417111072
		arg_301_1.duration_ = 6.83

		local var_301_0 = {
			zh = 6.833,
			ja = 5.2
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
				arg_301_0:Play417111073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10113 = arg_301_1.actors_["10113"].transform.localPosition
				arg_301_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10113", 3)

				for iter_304_0 = 0, arg_301_1.actors_["10113"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10113"].transform:GetChild(iter_304_0)

					if var_304_0.name == "" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10113"].transform.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_304_2 = 0
			local var_304_3 = 0.8

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(417111072)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 32 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 32)

				if (32 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 32)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111072", "story_v_out_417111.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111072", "story_v_out_417111.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_417111", "417111072", "story_v_out_417111.awb")

						arg_301_1:RecordAudio("417111072", var_304_9)
						arg_301_1:RecordAudio("417111072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_417111", "417111072", "story_v_out_417111.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_417111", "417111072", "story_v_out_417111.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 417111073
		arg_305_1.duration_ = 1.4

		local var_305_0 = {
			zh = 1.3,
			ja = 1.4
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
				arg_305_0:Play417111074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1034"]) and arg_305_1.var_.actorSpriteComps1034 == nil then
				arg_305_1.var_.actorSpriteComps1034 = arg_305_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1034"]) then
				if arg_305_1.var_.actorSpriteComps1034 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								iter_308_1.color = Color.New(Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_0), Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_0), (Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_0)))
							else
								local var_308_1 = Mathf.Lerp(iter_308_1.color.r, 1, (arg_305_1.time_ - 0) / var_308_0)

								iter_308_1.color = Color.New(var_308_1, var_308_1, var_308_1)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1034"]) and arg_305_1.var_.actorSpriteComps1034 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1034 = nil
			end

			local var_308_2 = arg_305_1.actors_["10113"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10113 == nil then
				arg_305_1.var_.actorSpriteComps10113 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps10113 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								iter_308_5.color = Color.New(Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_5.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_5.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10113 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_308_7 then
						iter_308_7.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps10113 = nil
			end

			local var_308_5 = arg_305_1.actors_["1034"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1034 = var_308_5.localPosition
				var_308_5.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1034", 3)

				for iter_308_8 = 0, var_308_5.childCount - 1 do
					local var_308_6 = var_308_5:GetChild(iter_308_8)

					if var_308_6.name == "" or not string.find(var_308_6.name, "split") then
						var_308_6.gameObject:SetActive(true)
					else
						var_308_6.gameObject:SetActive(false)
					end
				end
			end

			local var_308_7 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				var_308_5.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_305_1.time_ - 0) / var_308_7)
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				var_308_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_308_8 = arg_305_1.actors_["10113"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10113 = var_308_8.localPosition
				var_308_8.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10113", 7)

				for iter_308_9 = 0, var_308_8.childCount - 1 do
					local var_308_9 = var_308_8:GetChild(iter_308_9)

					if var_308_9.name == "" or not string.find(var_308_9.name, "split") then
						var_308_9.gameObject:SetActive(true)
					else
						var_308_9.gameObject:SetActive(false)
					end
				end
			end

			local var_308_10 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_10 then
				var_308_8.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_305_1.time_ - 0) / var_308_10)
			end

			if arg_305_1.time_ >= 0 + var_308_10 and arg_305_1.time_ < 0 + var_308_10 + arg_308_0 then
				var_308_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_308_11 = 0
			local var_308_12 = 0.125

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_13 = arg_305_1:GetWordFromCfg(417111073)
				local var_308_14 = arg_305_1:FormatText(var_308_13.content)

				arg_305_1.text_.text = var_308_14

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_16 = 5 <= 0 and var_308_12 or var_308_12 * (utf8.len(var_308_14) / 5)

				if (5 <= 0 and var_308_12 or var_308_12 * (utf8.len(var_308_14) / 5)) > 0 and var_308_12 < var_308_16 then
					arg_305_1.talkMaxDuration = var_308_16

					if var_308_16 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_16 + var_308_11
					end
				end

				arg_305_1.text_.text = var_308_14
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111073", "story_v_out_417111.awb") ~= 0 then
					local var_308_17 = manager.audio:GetVoiceLength("story_v_out_417111", "417111073", "story_v_out_417111.awb") / 1000

					if var_308_17 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_17 + var_308_11
					end

					if var_308_13.prefab_name ~= "" and arg_305_1.actors_[var_308_13.prefab_name] ~= nil then
						local var_308_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_13.prefab_name].transform, "story_v_out_417111", "417111073", "story_v_out_417111.awb")

						arg_305_1:RecordAudio("417111073", var_308_18)
						arg_305_1:RecordAudio("417111073", var_308_18)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_417111", "417111073", "story_v_out_417111.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_417111", "417111073", "story_v_out_417111.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_19 = math.max(var_308_12, arg_305_1.talkMaxDuration)

			if var_308_11 <= arg_305_1.time_ and arg_305_1.time_ < var_308_11 + var_308_19 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_11) / var_308_19

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_11 + var_308_19 and arg_305_1.time_ < var_308_11 + var_308_19 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 417111074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play417111075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1034"]) and arg_309_1.var_.actorSpriteComps1034 == nil then
				arg_309_1.var_.actorSpriteComps1034 = arg_309_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1034"]) then
				if arg_309_1.var_.actorSpriteComps1034 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1034"]) and arg_309_1.var_.actorSpriteComps1034 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps1034 = nil
			end

			if 0.05 < arg_309_1.time_ and arg_309_1.time_ <= 0.05 + arg_312_0 then
				arg_309_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_312_3 = 0
			local var_312_4 = 1.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(417111074).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 52 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 52)

				if (52 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 52)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play417111075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417111075
		arg_313_1.duration_ = 8.6

		local var_313_0 = {
			zh = 7.1,
			ja = 8.6
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
				arg_313_0:Play417111076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10113"]) and arg_313_1.var_.actorSpriteComps10113 == nil then
				arg_313_1.var_.actorSpriteComps10113 = arg_313_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10113"]) then
				if arg_313_1.var_.actorSpriteComps10113 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 1, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10113"]) and arg_313_1.var_.actorSpriteComps10113 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10113 = nil
			end

			local var_316_2 = arg_313_1.actors_["10113"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10113 = var_316_2.localPosition
				var_316_2.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10113", 4)

				for iter_316_4 = 0, var_316_2.childCount - 1 do
					local var_316_3 = var_316_2:GetChild(iter_316_4)

					if var_316_3.name == "" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_2.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_313_1.time_ - 0) / var_316_4)
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_2.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_316_5 = arg_313_1.actors_["1034"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1034 = var_316_5.localPosition
				var_316_5.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1034", 2)

				for iter_316_5 = 0, var_316_5.childCount - 1 do
					local var_316_6 = var_316_5:GetChild(iter_316_5)

					if var_316_6.name == "" or not string.find(var_316_6.name, "split") then
						var_316_6.gameObject:SetActive(true)
					else
						var_316_6.gameObject:SetActive(false)
					end
				end
			end

			local var_316_7 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				var_316_5.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_313_1.time_ - 0) / var_316_7)
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				var_316_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_316_8 = 0
			local var_316_9 = 0.625

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(417111075)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 25 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 25)

				if (25 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 25)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111075", "story_v_out_417111.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111075", "story_v_out_417111.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_417111", "417111075", "story_v_out_417111.awb")

						arg_313_1:RecordAudio("417111075", var_316_15)
						arg_313_1:RecordAudio("417111075", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_417111", "417111075", "story_v_out_417111.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_417111", "417111075", "story_v_out_417111.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
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
	Play417111076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 417111076
		arg_317_1.duration_ = 4.2

		local var_317_0 = {
			zh = 4.2,
			ja = 3.5
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play417111077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1034"]) and arg_317_1.var_.actorSpriteComps1034 == nil then
				arg_317_1.var_.actorSpriteComps1034 = arg_317_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1034"]) then
				if arg_317_1.var_.actorSpriteComps1034 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 1, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1034"]) and arg_317_1.var_.actorSpriteComps1034 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1034 = nil
			end

			local var_320_2 = arg_317_1.actors_["10113"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10113 == nil then
				arg_317_1.var_.actorSpriteComps10113 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps10113 then
					for iter_320_4, iter_320_5 in pairs(arg_317_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_320_5 then
							if arg_317_1.isInRecall_ then
								iter_320_5.color = Color.New(Mathf.Lerp(iter_320_5.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_5.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_5.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_5.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_5.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10113 then
				for iter_320_6, iter_320_7 in pairs(arg_317_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_320_7 then
						iter_320_7.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10113 = nil
			end

			local var_320_5 = 0
			local var_320_6 = 0.425

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_7 = arg_317_1:GetWordFromCfg(417111076)
				local var_320_8 = arg_317_1:FormatText(var_320_7.content)

				arg_317_1.text_.text = var_320_8

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 17 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 17)

				if (17 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 17)) > 0 and var_320_6 < var_320_10 then
					arg_317_1.talkMaxDuration = var_320_10

					if var_320_10 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_8
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111076", "story_v_out_417111.awb") ~= 0 then
					local var_320_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111076", "story_v_out_417111.awb") / 1000

					if var_320_11 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_5
					end

					if var_320_7.prefab_name ~= "" and arg_317_1.actors_[var_320_7.prefab_name] ~= nil then
						local var_320_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_7.prefab_name].transform, "story_v_out_417111", "417111076", "story_v_out_417111.awb")

						arg_317_1:RecordAudio("417111076", var_320_12)
						arg_317_1:RecordAudio("417111076", var_320_12)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_417111", "417111076", "story_v_out_417111.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_417111", "417111076", "story_v_out_417111.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_6, arg_317_1.talkMaxDuration)

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_5) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_5 + var_320_13 and arg_317_1.time_ < var_320_5 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play417111077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 417111077
		arg_321_1.duration_ = 7.6

		local var_321_0 = {
			zh = 3.733,
			ja = 7.6
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
				arg_321_0:Play417111078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.425

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(417111077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 17 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 17)

				if (17 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 17)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111077", "story_v_out_417111.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111077", "story_v_out_417111.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_417111", "417111077", "story_v_out_417111.awb")

						arg_321_1:RecordAudio("417111077", var_324_6)
						arg_321_1:RecordAudio("417111077", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_417111", "417111077", "story_v_out_417111.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_417111", "417111077", "story_v_out_417111.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play417111078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417111078
		arg_325_1.duration_ = 12.07

		local var_325_0 = {
			zh = 9.6,
			ja = 12.066
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
				arg_325_0:Play417111079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10113"]) and arg_325_1.var_.actorSpriteComps10113 == nil then
				arg_325_1.var_.actorSpriteComps10113 = arg_325_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10113"]) then
				if arg_325_1.var_.actorSpriteComps10113 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 1, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10113"]) and arg_325_1.var_.actorSpriteComps10113 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps10113 = nil
			end

			local var_328_2 = arg_325_1.actors_["1034"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps1034 == nil then
				arg_325_1.var_.actorSpriteComps1034 = var_328_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_3 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.actorSpriteComps1034 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_328_5 then
							if arg_325_1.isInRecall_ then
								iter_328_5.color = Color.New(Mathf.Lerp(iter_328_5.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_3), Mathf.Lerp(iter_328_5.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_3), (Mathf.Lerp(iter_328_5.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_3)))
							else
								local var_328_4 = Mathf.Lerp(iter_328_5.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_3)

								iter_328_5.color = Color.New(var_328_4, var_328_4, var_328_4)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps1034 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_328_7 then
						iter_328_7.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps1034 = nil
			end

			local var_328_5 = 0
			local var_328_6 = 1.05

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(417111078)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 42 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 42)

				if (42 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 42)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111078", "story_v_out_417111.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111078", "story_v_out_417111.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_417111", "417111078", "story_v_out_417111.awb")

						arg_325_1:RecordAudio("417111078", var_328_12)
						arg_325_1:RecordAudio("417111078", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_417111", "417111078", "story_v_out_417111.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_417111", "417111078", "story_v_out_417111.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_13 and arg_325_1.time_ < var_328_5 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417111079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 417111079
		arg_329_1.duration_ = 8.57

		local var_329_0 = {
			zh = 7.7,
			ja = 8.566
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
				arg_329_0:Play417111080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1034"]) and arg_329_1.var_.actorSpriteComps1034 == nil then
				arg_329_1.var_.actorSpriteComps1034 = arg_329_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1034"]) then
				if arg_329_1.var_.actorSpriteComps1034 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								iter_332_1.color = Color.New(Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_0), Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_0), (Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_0)))
							else
								local var_332_1 = Mathf.Lerp(iter_332_1.color.r, 1, (arg_329_1.time_ - 0) / var_332_0)

								iter_332_1.color = Color.New(var_332_1, var_332_1, var_332_1)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1034"]) and arg_329_1.var_.actorSpriteComps1034 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps1034 = nil
			end

			local var_332_2 = arg_329_1.actors_["10113"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps10113 == nil then
				arg_329_1.var_.actorSpriteComps10113 = var_332_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_3 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.actorSpriteComps10113 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_332_5 then
							if arg_329_1.isInRecall_ then
								iter_332_5.color = Color.New(Mathf.Lerp(iter_332_5.color.r, arg_329_1.hightColor2.r, (arg_329_1.time_ - 0) / var_332_3), Mathf.Lerp(iter_332_5.color.g, arg_329_1.hightColor2.g, (arg_329_1.time_ - 0) / var_332_3), (Mathf.Lerp(iter_332_5.color.b, arg_329_1.hightColor2.b, (arg_329_1.time_ - 0) / var_332_3)))
							else
								local var_332_4 = Mathf.Lerp(iter_332_5.color.r, 0.5, (arg_329_1.time_ - 0) / var_332_3)

								iter_332_5.color = Color.New(var_332_4, var_332_4, var_332_4)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps10113 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_332_7 then
						iter_332_7.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_329_1.var_.actorSpriteComps10113 = nil
			end

			local var_332_5 = arg_329_1.actors_["1034"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1034 = var_332_5.localPosition
				var_332_5.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1034", 2)

				for iter_332_8 = 0, var_332_5.childCount - 1 do
					local var_332_6 = var_332_5:GetChild(iter_332_8)

					if var_332_6.name == "split_6" or not string.find(var_332_6.name, "split") then
						var_332_6.gameObject:SetActive(true)
					else
						var_332_6.gameObject:SetActive(false)
					end
				end
			end

			local var_332_7 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				var_332_5.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_329_1.time_ - 0) / var_332_7)
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				var_332_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_332_8 = 0
			local var_332_9 = 0.75

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(417111079)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 30 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 30)

				if (30 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 30)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111079", "story_v_out_417111.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111079", "story_v_out_417111.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_417111", "417111079", "story_v_out_417111.awb")

						arg_329_1:RecordAudio("417111079", var_332_15)
						arg_329_1:RecordAudio("417111079", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_417111", "417111079", "story_v_out_417111.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_417111", "417111079", "story_v_out_417111.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417111080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 417111080
		arg_333_1.duration_ = 7.8

		local var_333_0 = {
			zh = 6.1,
			ja = 7.8
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
				arg_333_0:Play417111081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.675

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(417111080)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 27 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 27)

				if (27 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 27)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111080", "story_v_out_417111.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111080", "story_v_out_417111.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_417111", "417111080", "story_v_out_417111.awb")

						arg_333_1:RecordAudio("417111080", var_336_6)
						arg_333_1:RecordAudio("417111080", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_417111", "417111080", "story_v_out_417111.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_417111", "417111080", "story_v_out_417111.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play417111081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 417111081
		arg_337_1.duration_ = 4.4

		local var_337_0 = {
			zh = 4.4,
			ja = 4.3
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
				arg_337_0:Play417111082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["10113"]) and arg_337_1.var_.actorSpriteComps10113 == nil then
				arg_337_1.var_.actorSpriteComps10113 = arg_337_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["10113"]) then
				if arg_337_1.var_.actorSpriteComps10113 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_0), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_0), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_0)))
							else
								local var_340_1 = Mathf.Lerp(iter_340_1.color.r, 1, (arg_337_1.time_ - 0) / var_340_0)

								iter_340_1.color = Color.New(var_340_1, var_340_1, var_340_1)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["10113"]) and arg_337_1.var_.actorSpriteComps10113 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps10113 = nil
			end

			local var_340_2 = arg_337_1.actors_["1034"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1034 == nil then
				arg_337_1.var_.actorSpriteComps1034 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps1034 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								iter_340_5.color = Color.New(Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_5.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_5.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1034 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_340_7 then
						iter_340_7.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps1034 = nil
			end

			local var_340_5 = arg_337_1.actors_["10113"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10113 = var_340_5.localPosition
				var_340_5.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10113", 4)

				for iter_340_8 = 0, var_340_5.childCount - 1 do
					local var_340_6 = var_340_5:GetChild(iter_340_8)

					if var_340_6.name == "split_4" or not string.find(var_340_6.name, "split") then
						var_340_6.gameObject:SetActive(true)
					else
						var_340_6.gameObject:SetActive(false)
					end
				end
			end

			local var_340_7 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				var_340_5.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_337_1.time_ - 0) / var_340_7)
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				var_340_5.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_340_8 = 0
			local var_340_9 = 0.375

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_10 = arg_337_1:GetWordFromCfg(417111081)
				local var_340_11 = arg_337_1:FormatText(var_340_10.content)

				arg_337_1.text_.text = var_340_11

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_13 = 15 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 15)

				if (15 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 15)) > 0 and var_340_9 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_8
					end
				end

				arg_337_1.text_.text = var_340_11
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111081", "story_v_out_417111.awb") ~= 0 then
					local var_340_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111081", "story_v_out_417111.awb") / 1000

					if var_340_14 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_8
					end

					if var_340_10.prefab_name ~= "" and arg_337_1.actors_[var_340_10.prefab_name] ~= nil then
						local var_340_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_10.prefab_name].transform, "story_v_out_417111", "417111081", "story_v_out_417111.awb")

						arg_337_1:RecordAudio("417111081", var_340_15)
						arg_337_1:RecordAudio("417111081", var_340_15)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_417111", "417111081", "story_v_out_417111.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_417111", "417111081", "story_v_out_417111.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_9, arg_337_1.talkMaxDuration)

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_8) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_8 + var_340_16 and arg_337_1.time_ < var_340_8 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 417111082
		arg_341_1.duration_ = 9.8

		local var_341_0 = {
			zh = 9.8,
			ja = 3.966
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
				arg_341_0:Play417111083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10113 = arg_341_1.actors_["10113"].transform.localPosition
				arg_341_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10113", 4)

				for iter_344_0 = 0, arg_341_1.actors_["10113"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["10113"].transform:GetChild(iter_344_0)

					if var_344_0.name == "split_6" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["10113"].transform.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_344_2 = 0
			local var_344_3 = 1.025

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(417111082)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 41 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 41)

				if (41 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 41)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111082", "story_v_out_417111.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111082", "story_v_out_417111.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_417111", "417111082", "story_v_out_417111.awb")

						arg_341_1:RecordAudio("417111082", var_344_9)
						arg_341_1:RecordAudio("417111082", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_417111", "417111082", "story_v_out_417111.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_417111", "417111082", "story_v_out_417111.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play417111083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 417111083
		arg_345_1.duration_ = 10.17

		local var_345_0 = {
			zh = 6.933,
			ja = 10.166
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play417111084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.775

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(417111083)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 31)

				if (31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 31)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111083", "story_v_out_417111.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111083", "story_v_out_417111.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_417111", "417111083", "story_v_out_417111.awb")

						arg_345_1:RecordAudio("417111083", var_348_6)
						arg_345_1:RecordAudio("417111083", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_417111", "417111083", "story_v_out_417111.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_417111", "417111083", "story_v_out_417111.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play417111084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 417111084
		arg_349_1.duration_ = 15.83

		local var_349_0 = {
			zh = 13.566,
			ja = 15.833
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
				arg_349_0:Play417111085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 1.3

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(417111084)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 52 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 52)

				if (52 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 52)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111084", "story_v_out_417111.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111084", "story_v_out_417111.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_417111", "417111084", "story_v_out_417111.awb")

						arg_349_1:RecordAudio("417111084", var_352_6)
						arg_349_1:RecordAudio("417111084", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_417111", "417111084", "story_v_out_417111.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_417111", "417111084", "story_v_out_417111.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play417111085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 417111085
		arg_353_1.duration_ = 7.17

		local var_353_0 = {
			zh = 6.533,
			ja = 7.166
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
				arg_353_0:Play417111086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1034"]) and arg_353_1.var_.actorSpriteComps1034 == nil then
				arg_353_1.var_.actorSpriteComps1034 = arg_353_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1034"]) then
				if arg_353_1.var_.actorSpriteComps1034 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 1, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1034"]) and arg_353_1.var_.actorSpriteComps1034 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps1034 = nil
			end

			local var_356_2 = arg_353_1.actors_["10113"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10113 == nil then
				arg_353_1.var_.actorSpriteComps10113 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps10113 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								iter_356_5.color = Color.New(Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_5.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_5.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10113 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_356_7 then
						iter_356_7.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps10113 = nil
			end

			local var_356_5 = 0
			local var_356_6 = 0.725

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(417111085)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 29 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 29)

				if (29 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 29)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111085", "story_v_out_417111.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111085", "story_v_out_417111.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_417111", "417111085", "story_v_out_417111.awb")

						arg_353_1:RecordAudio("417111085", var_356_12)
						arg_353_1:RecordAudio("417111085", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_417111", "417111085", "story_v_out_417111.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_417111", "417111085", "story_v_out_417111.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_6, arg_353_1.talkMaxDuration)

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_5) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_5 + var_356_13 and arg_353_1.time_ < var_356_5 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play417111086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 417111086
		arg_357_1.duration_ = 11.03

		local var_357_0 = {
			zh = 7.766,
			ja = 11.033
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
				arg_357_0:Play417111087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10113"]) and arg_357_1.var_.actorSpriteComps10113 == nil then
				arg_357_1.var_.actorSpriteComps10113 = arg_357_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10113"]) then
				if arg_357_1.var_.actorSpriteComps10113 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 1, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10113"]) and arg_357_1.var_.actorSpriteComps10113 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps10113 = nil
			end

			local var_360_2 = arg_357_1.actors_["1034"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1034 == nil then
				arg_357_1.var_.actorSpriteComps1034 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps1034 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								iter_360_5.color = Color.New(Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_5.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_5.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1034 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_360_7 then
						iter_360_7.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps1034 = nil
			end

			local var_360_5 = arg_357_1.actors_["10113"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10113 = var_360_5.localPosition
				var_360_5.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10113", 4)

				for iter_360_8 = 0, var_360_5.childCount - 1 do
					local var_360_6 = var_360_5:GetChild(iter_360_8)

					if var_360_6.name == "split_4" or not string.find(var_360_6.name, "split") then
						var_360_6.gameObject:SetActive(true)
					else
						var_360_6.gameObject:SetActive(false)
					end
				end
			end

			local var_360_7 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				var_360_5.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_357_1.time_ - 0) / var_360_7)
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				var_360_5.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_360_8 = 0
			local var_360_9 = 0.925

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(417111086)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 37 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 37)

				if (37 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 37)) > 0 and var_360_9 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111086", "story_v_out_417111.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111086", "story_v_out_417111.awb") / 1000

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end

					if var_360_10.prefab_name ~= "" and arg_357_1.actors_[var_360_10.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_10.prefab_name].transform, "story_v_out_417111", "417111086", "story_v_out_417111.awb")

						arg_357_1:RecordAudio("417111086", var_360_15)
						arg_357_1:RecordAudio("417111086", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_417111", "417111086", "story_v_out_417111.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_417111", "417111086", "story_v_out_417111.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 417111087
		arg_361_1.duration_ = 7.23

		local var_361_0 = {
			zh = 5.066,
			ja = 7.233
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
				arg_361_0:Play417111088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10113 = arg_361_1.actors_["10113"].transform.localPosition
				arg_361_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10113", 4)

				for iter_364_0 = 0, arg_361_1.actors_["10113"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["10113"].transform:GetChild(iter_364_0)

					if var_364_0.name == "split_6" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["10113"].transform.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_364_2 = 0
			local var_364_3 = 0.65

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:GetWordFromCfg(417111087)
				local var_364_5 = arg_361_1:FormatText(var_364_4.content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 26 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 26)

				if (26 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 26)) > 0 and var_364_3 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111087", "story_v_out_417111.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111087", "story_v_out_417111.awb") / 1000

					if var_364_8 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_2
					end

					if var_364_4.prefab_name ~= "" and arg_361_1.actors_[var_364_4.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_4.prefab_name].transform, "story_v_out_417111", "417111087", "story_v_out_417111.awb")

						arg_361_1:RecordAudio("417111087", var_364_9)
						arg_361_1:RecordAudio("417111087", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_417111", "417111087", "story_v_out_417111.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_417111", "417111087", "story_v_out_417111.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_10 and arg_361_1.time_ < var_364_2 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 417111088
		arg_365_1.duration_ = 8.3

		local var_365_0 = {
			zh = 6.633,
			ja = 8.3
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
				arg_365_0:Play417111089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1034"]) and arg_365_1.var_.actorSpriteComps1034 == nil then
				arg_365_1.var_.actorSpriteComps1034 = arg_365_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_0 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1034"]) then
				if arg_365_1.var_.actorSpriteComps1034 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								iter_368_1.color = Color.New(Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_0), Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_0), (Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_0)))
							else
								local var_368_1 = Mathf.Lerp(iter_368_1.color.r, 1, (arg_365_1.time_ - 0) / var_368_0)

								iter_368_1.color = Color.New(var_368_1, var_368_1, var_368_1)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1034"]) and arg_365_1.var_.actorSpriteComps1034 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_368_3 then
						iter_368_3.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps1034 = nil
			end

			local var_368_2 = arg_365_1.actors_["10113"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps10113 == nil then
				arg_365_1.var_.actorSpriteComps10113 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps10113 then
					for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_368_5 then
							if arg_365_1.isInRecall_ then
								iter_368_5.color = Color.New(Mathf.Lerp(iter_368_5.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_3), Mathf.Lerp(iter_368_5.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_3), (Mathf.Lerp(iter_368_5.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_3)))
							else
								local var_368_4 = Mathf.Lerp(iter_368_5.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_3)

								iter_368_5.color = Color.New(var_368_4, var_368_4, var_368_4)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps10113 then
				for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_368_7 then
						iter_368_7.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps10113 = nil
			end

			local var_368_5 = arg_365_1.actors_["1034"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1034 = var_368_5.localPosition
				var_368_5.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1034", 2)

				for iter_368_8 = 0, var_368_5.childCount - 1 do
					local var_368_6 = var_368_5:GetChild(iter_368_8)

					if var_368_6.name == "split_6" or not string.find(var_368_6.name, "split") then
						var_368_6.gameObject:SetActive(true)
					else
						var_368_6.gameObject:SetActive(false)
					end
				end
			end

			local var_368_7 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				var_368_5.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_365_1.time_ - 0) / var_368_7)
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				var_368_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_368_8 = 0
			local var_368_9 = 0.75

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:GetWordFromCfg(417111088)
				local var_368_11 = arg_365_1:FormatText(var_368_10.content)

				arg_365_1.text_.text = var_368_11

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_13 = 30 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 30)

				if (30 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 30)) > 0 and var_368_9 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_11
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111088", "story_v_out_417111.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111088", "story_v_out_417111.awb") / 1000

					if var_368_14 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_8
					end

					if var_368_10.prefab_name ~= "" and arg_365_1.actors_[var_368_10.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_10.prefab_name].transform, "story_v_out_417111", "417111088", "story_v_out_417111.awb")

						arg_365_1:RecordAudio("417111088", var_368_15)
						arg_365_1:RecordAudio("417111088", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_417111", "417111088", "story_v_out_417111.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_417111", "417111088", "story_v_out_417111.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_16 and arg_365_1.time_ < var_368_8 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417111089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 417111089
		arg_369_1.duration_ = 4.13

		local var_369_0 = {
			zh = 2.333,
			ja = 4.133
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
				arg_369_0:Play417111090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10113"]) and arg_369_1.var_.actorSpriteComps10113 == nil then
				arg_369_1.var_.actorSpriteComps10113 = arg_369_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10113"]) then
				if arg_369_1.var_.actorSpriteComps10113 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								iter_372_1.color = Color.New(Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_0), Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_0), (Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_0)))
							else
								local var_372_1 = Mathf.Lerp(iter_372_1.color.r, 1, (arg_369_1.time_ - 0) / var_372_0)

								iter_372_1.color = Color.New(var_372_1, var_372_1, var_372_1)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10113"]) and arg_369_1.var_.actorSpriteComps10113 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10113 = nil
			end

			local var_372_2 = arg_369_1.actors_["1034"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1034 == nil then
				arg_369_1.var_.actorSpriteComps1034 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps1034 then
					for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_372_5 then
							if arg_369_1.isInRecall_ then
								iter_372_5.color = Color.New(Mathf.Lerp(iter_372_5.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_5.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_5.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_5.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_5.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1034 then
				for iter_372_6, iter_372_7 in pairs(arg_369_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_372_7 then
						iter_372_7.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps1034 = nil
			end

			local var_372_5 = 0
			local var_372_6 = 0.275

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(417111089)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_10 = 11 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 11)

				if (11 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 11)) > 0 and var_372_6 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111089", "story_v_out_417111.awb") ~= 0 then
					local var_372_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111089", "story_v_out_417111.awb") / 1000

					if var_372_11 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_5
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_417111", "417111089", "story_v_out_417111.awb")

						arg_369_1:RecordAudio("417111089", var_372_12)
						arg_369_1:RecordAudio("417111089", var_372_12)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_417111", "417111089", "story_v_out_417111.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_417111", "417111089", "story_v_out_417111.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_13 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_13 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_13

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_13 and arg_369_1.time_ < var_372_5 + var_372_13 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play417111090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 417111090
		arg_373_1.duration_ = 1.93

		local var_373_0 = {
			zh = 1.033,
			ja = 1.933
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
				arg_373_0:Play417111091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1034"]) and arg_373_1.var_.actorSpriteComps1034 == nil then
				arg_373_1.var_.actorSpriteComps1034 = arg_373_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1034"]) then
				if arg_373_1.var_.actorSpriteComps1034 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 1, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1034"]) and arg_373_1.var_.actorSpriteComps1034 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps1034 = nil
			end

			local var_376_2 = arg_373_1.actors_["10113"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps10113 == nil then
				arg_373_1.var_.actorSpriteComps10113 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps10113 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								iter_376_5.color = Color.New(Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_5.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_5.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps10113 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_376_7 then
						iter_376_7.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10113 = nil
			end

			local var_376_5 = arg_373_1.actors_["1034"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1034 = var_376_5.localPosition
				var_376_5.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1034", 2)

				for iter_376_8 = 0, var_376_5.childCount - 1 do
					local var_376_6 = var_376_5:GetChild(iter_376_8)

					if var_376_6.name == "split_6" or not string.find(var_376_6.name, "split") then
						var_376_6.gameObject:SetActive(true)
					else
						var_376_6.gameObject:SetActive(false)
					end
				end
			end

			local var_376_7 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				var_376_5.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_373_1.time_ - 0) / var_376_7)
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				var_376_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_376_8 = 0
			local var_376_9 = 0.125

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_10 = arg_373_1:GetWordFromCfg(417111090)
				local var_376_11 = arg_373_1:FormatText(var_376_10.content)

				arg_373_1.text_.text = var_376_11

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 5 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 5)

				if (5 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 5)) > 0 and var_376_9 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_8
					end
				end

				arg_373_1.text_.text = var_376_11
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111090", "story_v_out_417111.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111090", "story_v_out_417111.awb") / 1000

					if var_376_14 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_8
					end

					if var_376_10.prefab_name ~= "" and arg_373_1.actors_[var_376_10.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_10.prefab_name].transform, "story_v_out_417111", "417111090", "story_v_out_417111.awb")

						arg_373_1:RecordAudio("417111090", var_376_15)
						arg_373_1:RecordAudio("417111090", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_417111", "417111090", "story_v_out_417111.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_417111", "417111090", "story_v_out_417111.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_9, arg_373_1.talkMaxDuration)

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_8) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_8 + var_376_16 and arg_373_1.time_ < var_376_8 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417111091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 417111091
		arg_377_1.duration_ = 4.2

		local var_377_0 = {
			zh = 2.566,
			ja = 4.2
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
				arg_377_0:Play417111092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["10113"]) and arg_377_1.var_.actorSpriteComps10113 == nil then
				arg_377_1.var_.actorSpriteComps10113 = arg_377_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["10113"]) then
				if arg_377_1.var_.actorSpriteComps10113 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 1, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["10113"]) and arg_377_1.var_.actorSpriteComps10113 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps10113 = nil
			end

			local var_380_2 = arg_377_1.actors_["1034"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1034 == nil then
				arg_377_1.var_.actorSpriteComps1034 = var_380_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_3 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.actorSpriteComps1034 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								iter_380_5.color = Color.New(Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_3), Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_3), (Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_3)))
							else
								local var_380_4 = Mathf.Lerp(iter_380_5.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_3)

								iter_380_5.color = Color.New(var_380_4, var_380_4, var_380_4)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1034 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_380_7 then
						iter_380_7.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps1034 = nil
			end

			local var_380_5 = arg_377_1.actors_["10113"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10113 = var_380_5.localPosition
				var_380_5.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10113", 4)

				for iter_380_8 = 0, var_380_5.childCount - 1 do
					local var_380_6 = var_380_5:GetChild(iter_380_8)

					if var_380_6.name == "" or not string.find(var_380_6.name, "split") then
						var_380_6.gameObject:SetActive(true)
					else
						var_380_6.gameObject:SetActive(false)
					end
				end
			end

			local var_380_7 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				var_380_5.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_377_1.time_ - 0) / var_380_7)
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				var_380_5.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_380_8 = 0
			local var_380_9 = 0.3

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:GetWordFromCfg(417111091)
				local var_380_11 = arg_377_1:FormatText(var_380_10.content)

				arg_377_1.text_.text = var_380_11

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 12 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 12)

				if (12 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 12)) > 0 and var_380_9 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_11
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111091", "story_v_out_417111.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_417111", "417111091", "story_v_out_417111.awb") / 1000

					if var_380_14 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_8
					end

					if var_380_10.prefab_name ~= "" and arg_377_1.actors_[var_380_10.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_10.prefab_name].transform, "story_v_out_417111", "417111091", "story_v_out_417111.awb")

						arg_377_1:RecordAudio("417111091", var_380_15)
						arg_377_1:RecordAudio("417111091", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_417111", "417111091", "story_v_out_417111.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_417111", "417111091", "story_v_out_417111.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_9, arg_377_1.talkMaxDuration)

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_8) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_8 + var_380_16 and arg_377_1.time_ < var_380_8 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 417111092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play417111093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10113"]) and arg_381_1.var_.actorSpriteComps10113 == nil then
				arg_381_1.var_.actorSpriteComps10113 = arg_381_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10113"]) then
				if arg_381_1.var_.actorSpriteComps10113 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								iter_384_1.color = Color.New(Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_0), Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_0), (Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_0)))
							else
								local var_384_1 = Mathf.Lerp(iter_384_1.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_0)

								iter_384_1.color = Color.New(var_384_1, var_384_1, var_384_1)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10113"]) and arg_381_1.var_.actorSpriteComps10113 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps10113 = nil
			end

			local var_384_2 = arg_381_1.actors_["1034"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1034 = var_384_2.localPosition
				var_384_2.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1034", 7)

				for iter_384_4 = 0, var_384_2.childCount - 1 do
					local var_384_3 = var_384_2:GetChild(iter_384_4)

					if var_384_3.name == "" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				var_384_2.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_381_1.time_ - 0) / var_384_4)
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				var_384_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_384_5 = arg_381_1.actors_["10113"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10113 = var_384_5.localPosition
				var_384_5.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10113", 7)

				for iter_384_5 = 0, var_384_5.childCount - 1 do
					local var_384_6 = var_384_5:GetChild(iter_384_5)

					if var_384_6.name == "" or not string.find(var_384_6.name, "split") then
						var_384_6.gameObject:SetActive(true)
					else
						var_384_6.gameObject:SetActive(false)
					end
				end
			end

			local var_384_7 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				var_384_5.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_381_1.time_ - 0) / var_384_7)
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				var_384_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_384_8 = 0
			local var_384_9 = 0.575

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_10 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(417111092).content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_12 = 23 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_10) / 23)

				if (23 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_10) / 23)) > 0 and var_384_9 < var_384_12 then
					arg_381_1.talkMaxDuration = var_384_12

					if var_384_12 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_8
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_13 = math.max(var_384_9, arg_381_1.talkMaxDuration)

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_13 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_8) / var_384_13

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_8 + var_384_13 and arg_381_1.time_ < var_384_8 + var_384_13 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play417111093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 417111093
		arg_385_1.duration_ = 5.97

		local var_385_0 = {
			zh = 4.066,
			ja = 5.966
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
				arg_385_0:Play417111094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10113"]) and arg_385_1.var_.actorSpriteComps10113 == nil then
				arg_385_1.var_.actorSpriteComps10113 = arg_385_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10113"]) then
				if arg_385_1.var_.actorSpriteComps10113 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 1, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10113"]) and arg_385_1.var_.actorSpriteComps10113 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps10113 = nil
			end

			local var_388_2 = arg_385_1.actors_["10113"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10113 = var_388_2.localPosition
				var_388_2.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10113", 3)

				for iter_388_4 = 0, var_388_2.childCount - 1 do
					local var_388_3 = var_388_2:GetChild(iter_388_4)

					if var_388_3.name == "" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				var_388_2.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_385_1.time_ - 0) / var_388_4)
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				var_388_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_388_5 = 0
			local var_388_6 = 0.475

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:GetWordFromCfg(417111093)
				local var_388_8 = arg_385_1:FormatText(var_388_7.content)

				arg_385_1.text_.text = var_388_8

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 19 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 19)

				if (19 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 19)) > 0 and var_388_6 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_8
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111093", "story_v_out_417111.awb") ~= 0 then
					local var_388_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111093", "story_v_out_417111.awb") / 1000

					if var_388_11 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_5
					end

					if var_388_7.prefab_name ~= "" and arg_385_1.actors_[var_388_7.prefab_name] ~= nil then
						local var_388_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_7.prefab_name].transform, "story_v_out_417111", "417111093", "story_v_out_417111.awb")

						arg_385_1:RecordAudio("417111093", var_388_12)
						arg_385_1:RecordAudio("417111093", var_388_12)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_417111", "417111093", "story_v_out_417111.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_417111", "417111093", "story_v_out_417111.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_13 and arg_385_1.time_ < var_388_5 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play417111094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 417111094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play417111095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10113"]) and arg_389_1.var_.actorSpriteComps10113 == nil then
				arg_389_1.var_.actorSpriteComps10113 = arg_389_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10113"]) then
				if arg_389_1.var_.actorSpriteComps10113 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10113"]) and arg_389_1.var_.actorSpriteComps10113 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps10113 = nil
			end

			local var_392_2 = arg_389_1.actors_["10113"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10113 = var_392_2.localPosition
				var_392_2.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10113", 7)

				for iter_392_4 = 0, var_392_2.childCount - 1 do
					local var_392_3 = var_392_2:GetChild(iter_392_4)

					if var_392_3.name == "" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				var_392_2.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_389_1.time_ - 0) / var_392_4)
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				var_392_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_392_5 = 0
			local var_392_6 = 1.475

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(417111094).content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 59 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 59)

				if (59 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 59)) > 0 and var_392_6 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_10 and arg_389_1.time_ < var_392_5 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417111095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 417111095
		arg_393_1.duration_ = 1.87

		local var_393_0 = {
			zh = 1.1,
			ja = 1.866
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play417111096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1034"]) and arg_393_1.var_.actorSpriteComps1034 == nil then
				arg_393_1.var_.actorSpriteComps1034 = arg_393_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1034"]) then
				if arg_393_1.var_.actorSpriteComps1034 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								iter_396_1.color = Color.New(Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_0), Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_0), (Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_0)))
							else
								local var_396_1 = Mathf.Lerp(iter_396_1.color.r, 1, (arg_393_1.time_ - 0) / var_396_0)

								iter_396_1.color = Color.New(var_396_1, var_396_1, var_396_1)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1034"]) and arg_393_1.var_.actorSpriteComps1034 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1034 = nil
			end

			local var_396_2 = arg_393_1.actors_["1034"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1034 = var_396_2.localPosition
				var_396_2.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1034", 3)

				for iter_396_4 = 0, var_396_2.childCount - 1 do
					local var_396_3 = var_396_2:GetChild(iter_396_4)

					if var_396_3.name == "split_6" or not string.find(var_396_3.name, "split") then
						var_396_3.gameObject:SetActive(true)
					else
						var_396_3.gameObject:SetActive(false)
					end
				end
			end

			local var_396_4 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				var_396_2.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_393_1.time_ - 0) / var_396_4)
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				var_396_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_396_5 = 0
			local var_396_6 = 0.1

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_7 = arg_393_1:GetWordFromCfg(417111095)
				local var_396_8 = arg_393_1:FormatText(var_396_7.content)

				arg_393_1.text_.text = var_396_8

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 4 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 4)

				if (4 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 4)) > 0 and var_396_6 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_8
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111095", "story_v_out_417111.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111095", "story_v_out_417111.awb") / 1000

					if var_396_11 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_5
					end

					if var_396_7.prefab_name ~= "" and arg_393_1.actors_[var_396_7.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_7.prefab_name].transform, "story_v_out_417111", "417111095", "story_v_out_417111.awb")

						arg_393_1:RecordAudio("417111095", var_396_12)
						arg_393_1:RecordAudio("417111095", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_417111", "417111095", "story_v_out_417111.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_417111", "417111095", "story_v_out_417111.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_6, arg_393_1.talkMaxDuration)

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_5) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_5 + var_396_13 and arg_393_1.time_ < var_396_5 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417111096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 417111096
		arg_397_1.duration_ = 5.17

		local var_397_0 = {
			zh = 2.1,
			ja = 5.166
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
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play417111097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10113"]) and arg_397_1.var_.actorSpriteComps10113 == nil then
				arg_397_1.var_.actorSpriteComps10113 = arg_397_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10113"]) then
				if arg_397_1.var_.actorSpriteComps10113 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 1, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10113"]) and arg_397_1.var_.actorSpriteComps10113 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10113 = nil
			end

			local var_400_2 = arg_397_1.actors_["1034"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1034 == nil then
				arg_397_1.var_.actorSpriteComps1034 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps1034 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_400_5 then
							if arg_397_1.isInRecall_ then
								iter_400_5.color = Color.New(Mathf.Lerp(iter_400_5.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_5.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_5.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_5.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_5.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1034 then
				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_400_7 then
						iter_400_7.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1034 = nil
			end

			local var_400_5 = 0
			local var_400_6 = 0.2

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_7 = arg_397_1:GetWordFromCfg(417111096)
				local var_400_8 = arg_397_1:FormatText(var_400_7.content)

				arg_397_1.text_.text = var_400_8

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 8 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 8)

				if (8 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 8)) > 0 and var_400_6 < var_400_10 then
					arg_397_1.talkMaxDuration = var_400_10

					if var_400_10 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_5
					end
				end

				arg_397_1.text_.text = var_400_8
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111096", "story_v_out_417111.awb") ~= 0 then
					local var_400_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111096", "story_v_out_417111.awb") / 1000

					if var_400_11 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_11 + var_400_5
					end

					if var_400_7.prefab_name ~= "" and arg_397_1.actors_[var_400_7.prefab_name] ~= nil then
						local var_400_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_7.prefab_name].transform, "story_v_out_417111", "417111096", "story_v_out_417111.awb")

						arg_397_1:RecordAudio("417111096", var_400_12)
						arg_397_1:RecordAudio("417111096", var_400_12)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_417111", "417111096", "story_v_out_417111.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_417111", "417111096", "story_v_out_417111.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_6, arg_397_1.talkMaxDuration)

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_5) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_5 + var_400_13 and arg_397_1.time_ < var_400_5 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play417111097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 417111097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play417111098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10113"]) and arg_401_1.var_.actorSpriteComps10113 == nil then
				arg_401_1.var_.actorSpriteComps10113 = arg_401_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10113"]) then
				if arg_401_1.var_.actorSpriteComps10113 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10113"]) and arg_401_1.var_.actorSpriteComps10113 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps10113 = nil
			end

			local var_404_2 = arg_401_1.actors_["1034"].transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034 = var_404_2.localPosition
				var_404_2.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1034", 7)

				for iter_404_4 = 0, var_404_2.childCount - 1 do
					local var_404_3 = var_404_2:GetChild(iter_404_4)

					if var_404_3.name == "" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				var_404_2.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_401_1.time_ - 0) / var_404_4)
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				var_404_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_404_5 = 0
			local var_404_6 = 0.625

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(417111097).content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 25 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_7) / 25)

				if (25 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_7) / 25)) > 0 and var_404_6 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_10 and arg_401_1.time_ < var_404_5 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play417111098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 417111098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play417111099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.075

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(417111098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 43 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 43)

				if (43 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 43)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play417111099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 417111099
		arg_409_1.duration_ = 3.47

		local var_409_0 = {
			zh = 1.033,
			ja = 3.466
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play417111100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.075

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:GetWordFromCfg(417111099)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 3 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 3)

				if (3 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 3)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111099", "story_v_out_417111.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111099", "story_v_out_417111.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_417111", "417111099", "story_v_out_417111.awb")

						arg_409_1:RecordAudio("417111099", var_412_6)
						arg_409_1:RecordAudio("417111099", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_417111", "417111099", "story_v_out_417111.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_417111", "417111099", "story_v_out_417111.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play417111100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 417111100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play417111101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1034"]) and arg_413_1.var_.actorSpriteComps1034 == nil then
				arg_413_1.var_.actorSpriteComps1034 = arg_413_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1034"]) then
				if arg_413_1.var_.actorSpriteComps1034 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								iter_416_1.color = Color.New(Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_0), Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_0), (Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_0)))
							else
								local var_416_1 = Mathf.Lerp(iter_416_1.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_0)

								iter_416_1.color = Color.New(var_416_1, var_416_1, var_416_1)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1034"]) and arg_413_1.var_.actorSpriteComps1034 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps1034 = nil
			end

			local var_416_2 = arg_413_1.actors_["1034"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1034 = var_416_2.localPosition
				var_416_2.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1034", 7)

				for iter_416_4 = 0, var_416_2.childCount - 1 do
					local var_416_3 = var_416_2:GetChild(iter_416_4)

					if var_416_3.name == "" or not string.find(var_416_3.name, "split") then
						var_416_3.gameObject:SetActive(true)
					else
						var_416_3.gameObject:SetActive(false)
					end
				end
			end

			local var_416_4 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				var_416_2.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_413_1.time_ - 0) / var_416_4)
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				var_416_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.53333333333333 < arg_413_1.time_ and arg_413_1.time_ <= 1.53333333333333 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword04", "")
			end

			local var_416_6 = 0
			local var_416_7 = 1.875

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(417111100).content)

				arg_413_1.text_.text = var_416_8

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 75 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_8) / 75)

				if (75 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_8) / 75)) > 0 and var_416_7 < var_416_10 then
					arg_413_1.talkMaxDuration = var_416_10

					if var_416_10 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_8
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_11 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_11 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_11

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_11 and arg_413_1.time_ < var_416_6 + var_416_11 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play417111101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 417111101
		arg_417_1.duration_ = 6.47

		local var_417_0 = {
			zh = 2.466,
			ja = 6.466
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play417111102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.3

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:GetWordFromCfg(417111101)
				local var_420_2 = arg_417_1:FormatText(var_420_1.content)

				arg_417_1.text_.text = var_420_2

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_4 = 12 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 12)

				if (12 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 12)) > 0 and var_420_0 < var_420_4 then
					arg_417_1.talkMaxDuration = var_420_4

					if var_420_4 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_4 + 0
					end
				end

				arg_417_1.text_.text = var_420_2
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111101", "story_v_out_417111.awb") ~= 0 then
					local var_420_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111101", "story_v_out_417111.awb") / 1000

					if var_420_5 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + 0
					end

					if var_420_1.prefab_name ~= "" and arg_417_1.actors_[var_420_1.prefab_name] ~= nil then
						local var_420_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_1.prefab_name].transform, "story_v_out_417111", "417111101", "story_v_out_417111.awb")

						arg_417_1:RecordAudio("417111101", var_420_6)
						arg_417_1:RecordAudio("417111101", var_420_6)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_417111", "417111101", "story_v_out_417111.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_417111", "417111101", "story_v_out_417111.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_7 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_7

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play417111102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 417111102
		arg_421_1.duration_ = 1.07

		local var_421_0 = {
			zh = 0.999999999999,
			ja = 1.066
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play417111103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["10113"]) and arg_421_1.var_.actorSpriteComps10113 == nil then
				arg_421_1.var_.actorSpriteComps10113 = arg_421_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["10113"]) then
				if arg_421_1.var_.actorSpriteComps10113 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								iter_424_1.color = Color.New(Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor1.r, (arg_421_1.time_ - 0) / var_424_0), Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor1.g, (arg_421_1.time_ - 0) / var_424_0), (Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor1.b, (arg_421_1.time_ - 0) / var_424_0)))
							else
								local var_424_1 = Mathf.Lerp(iter_424_1.color.r, 1, (arg_421_1.time_ - 0) / var_424_0)

								iter_424_1.color = Color.New(var_424_1, var_424_1, var_424_1)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["10113"]) and arg_421_1.var_.actorSpriteComps10113 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_421_1.var_.actorSpriteComps10113 = nil
			end

			local var_424_2 = arg_421_1.actors_["1034"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps1034 == nil then
				arg_421_1.var_.actorSpriteComps1034 = var_424_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_3 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_3 and not isNil(var_424_2) then
				if arg_421_1.var_.actorSpriteComps1034 then
					for iter_424_4, iter_424_5 in pairs(arg_421_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_424_5 then
							if arg_421_1.isInRecall_ then
								iter_424_5.color = Color.New(Mathf.Lerp(iter_424_5.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_3), Mathf.Lerp(iter_424_5.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_3), (Mathf.Lerp(iter_424_5.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_3)))
							else
								local var_424_4 = Mathf.Lerp(iter_424_5.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_3)

								iter_424_5.color = Color.New(var_424_4, var_424_4, var_424_4)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_3 and arg_421_1.time_ < 0 + var_424_3 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps1034 then
				for iter_424_6, iter_424_7 in pairs(arg_421_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_424_7 then
						iter_424_7.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps1034 = nil
			end

			local var_424_5 = 0
			local var_424_6 = 0.1

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_5 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_5")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_7 = arg_421_1:GetWordFromCfg(417111102)
				local var_424_8 = arg_421_1:FormatText(var_424_7.content)

				arg_421_1.text_.text = var_424_8

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_10 = 4 <= 0 and var_424_6 or var_424_6 * (utf8.len(var_424_8) / 4)

				if (4 <= 0 and var_424_6 or var_424_6 * (utf8.len(var_424_8) / 4)) > 0 and var_424_6 < var_424_10 then
					arg_421_1.talkMaxDuration = var_424_10

					if var_424_10 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_5
					end
				end

				arg_421_1.text_.text = var_424_8
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111102", "story_v_out_417111.awb") ~= 0 then
					local var_424_11 = manager.audio:GetVoiceLength("story_v_out_417111", "417111102", "story_v_out_417111.awb") / 1000

					if var_424_11 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_11 + var_424_5
					end

					if var_424_7.prefab_name ~= "" and arg_421_1.actors_[var_424_7.prefab_name] ~= nil then
						local var_424_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_7.prefab_name].transform, "story_v_out_417111", "417111102", "story_v_out_417111.awb")

						arg_421_1:RecordAudio("417111102", var_424_12)
						arg_421_1:RecordAudio("417111102", var_424_12)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_417111", "417111102", "story_v_out_417111.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_417111", "417111102", "story_v_out_417111.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_13 = math.max(var_424_6, arg_421_1.talkMaxDuration)

			if var_424_5 <= arg_421_1.time_ and arg_421_1.time_ < var_424_5 + var_424_13 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_5) / var_424_13

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_5 + var_424_13 and arg_421_1.time_ < var_424_5 + var_424_13 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play417111103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 417111103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play417111104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10113"]) and arg_425_1.var_.actorSpriteComps10113 == nil then
				arg_425_1.var_.actorSpriteComps10113 = arg_425_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["10113"]) then
				if arg_425_1.var_.actorSpriteComps10113 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor2.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor2.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor2.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 0.5, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["10113"]) and arg_425_1.var_.actorSpriteComps10113 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_425_1.var_.actorSpriteComps10113 = nil
			end

			local var_428_2 = arg_425_1.actors_["1034"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1034 = var_428_2.localPosition
				var_428_2.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("1034", 7)

				for iter_428_4 = 0, var_428_2.childCount - 1 do
					local var_428_3 = var_428_2:GetChild(iter_428_4)

					if var_428_3.name == "" or not string.find(var_428_3.name, "split") then
						var_428_3.gameObject:SetActive(true)
					else
						var_428_3.gameObject:SetActive(false)
					end
				end
			end

			local var_428_4 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				var_428_2.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_425_1.time_ - 0) / var_428_4)
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				var_428_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_425_1.time_ and arg_425_1.time_ <= 1 + arg_428_0 then
				arg_425_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_push01", "")
			end

			local var_428_6 = 0
			local var_428_7 = 1.075

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(417111103).content)

				arg_425_1.text_.text = var_428_8

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_10 = 43 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_8) / 43)

				if (43 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_8) / 43)) > 0 and var_428_7 < var_428_10 then
					arg_425_1.talkMaxDuration = var_428_10

					if var_428_10 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_8
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_11 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_11 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_11

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_11 and arg_425_1.time_ < var_428_6 + var_428_11 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play417111104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 417111104
		arg_429_1.duration_ = 6.78

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play417111105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if arg_429_1.bgs_.I16i == nil then
				local var_432_0 = Object.Instantiate(arg_429_1.paintGo_)

				var_432_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16i")
				var_432_0.name = "I16i"
				var_432_0.transform.parent = arg_429_1.stage_.transform
				var_432_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_.I16i = var_432_0
			end

			if 0.433333333333333 < arg_429_1.time_ and arg_429_1.time_ <= 0.433333333333333 + arg_432_0 then
				local var_432_1 = arg_429_1.bgs_.I16i

				arg_429_1.bgs_.I16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_432_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_2 = var_432_1:GetComponent("SpriteRenderer")

				if var_432_2 and var_432_2.sprite then
					local var_432_3 = 2 * (var_432_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_432_1.transform.localScale = Vector3.New(var_432_3 / var_432_2.sprite.bounds.size.y < var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x and var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x or var_432_3 / var_432_2.sprite.bounds.size.y, var_432_3 / var_432_2.sprite.bounds.size.y < var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x and var_432_3 * manager.ui.mainCameraCom_.aspect / var_432_2.sprite.bounds.size.x or var_432_3 / var_432_2.sprite.bounds.size.y, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "I16i" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_432_4 = 0

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.allBtn_.enabled = false
			end

			if arg_429_1.time_ >= var_432_4 + 0.3 and arg_429_1.time_ < var_432_4 + 0.3 + arg_432_0 then
				arg_429_1.allBtn_.enabled = true
			end

			local var_432_5 = 0

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_6 = 0.433333333333333

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_6 then
				local var_432_7 = Color.New(1, 1, 1)

				var_432_7.a = Mathf.Lerp(0, 1, (arg_429_1.time_ - var_432_5) / var_432_6)
				arg_429_1.mask_.color = var_432_7
			end

			if arg_429_1.time_ >= var_432_5 + var_432_6 and arg_429_1.time_ < var_432_5 + var_432_6 + arg_432_0 then
				local var_432_8 = Color.New(1, 1, 1)

				var_432_8.a = 1
				arg_429_1.mask_.color = var_432_8
			end

			local var_432_9 = 0.433333333333333

			if 0.433333333333333 < arg_429_1.time_ and arg_429_1.time_ <= var_432_9 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_10 = 1.35

			if var_432_9 <= arg_429_1.time_ and arg_429_1.time_ < var_432_9 + var_432_10 then
				local var_432_11 = Color.New(1, 1, 1)

				var_432_11.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_9) / var_432_10)
				arg_429_1.mask_.color = var_432_11
			end

			if arg_429_1.time_ >= var_432_9 + var_432_10 and arg_429_1.time_ < var_432_9 + var_432_10 + arg_432_0 then
				local var_432_12 = Color.New(1, 1, 1)

				arg_429_1.mask_.enabled = false
				var_432_12.a = 0
				arg_429_1.mask_.color = var_432_12
			end

			local var_432_13 = manager.ui.mainCamera.transform

			if 0.433333333333333 < arg_429_1.time_ and arg_429_1.time_ <= 0.433333333333333 + arg_432_0 then
				arg_429_1.var_.shakeOldPos = var_432_13.localPosition
			end

			local var_432_14 = 1.4

			if 0.433333333333333 <= arg_429_1.time_ and arg_429_1.time_ < 0.433333333333333 + var_432_14 then
				local var_432_15, var_432_16 = math.modf((arg_429_1.time_ - 0.433333333333333) / 0.066)

				var_432_13.localPosition = Vector3.New(var_432_16 * 0.13, var_432_16 * 0.13, var_432_16 * 0.13) + arg_429_1.var_.shakeOldPos
			end

			if arg_429_1.time_ >= 0.433333333333333 + var_432_14 and arg_429_1.time_ < 0.433333333333333 + var_432_14 + arg_432_0 then
				var_432_13.localPosition = arg_429_1.var_.shakeOldPos
			end

			if 0.05 < arg_429_1.time_ and arg_429_1.time_ <= 0.05 + arg_432_0 then
				arg_429_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_432_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_20 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_20

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_20
						arg_429_1.bgmTxt2_.text = var_432_20
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_429_1.time_ and arg_429_1.time_ <= 0.466666666666667 + arg_432_0 then
				arg_429_1:AudioAction("play", "music", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_432_23 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if "" ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_23 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_23

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_23
						arg_429_1.bgmTxt2_.text = var_432_23
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_24 = 1.78333333333333
			local var_432_25 = 0.65

			if 1.78333333333333 < arg_429_1.time_ and arg_429_1.time_ <= var_432_24 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_26 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_26:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_429_1.dialogCg_.alpha = arg_435_0
				end))
				var_432_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_27 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(417111104).content)

				arg_429_1.text_.text = var_432_27

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_29 = 26 <= 0 and var_432_25 or var_432_25 * (utf8.len(var_432_27) / 26)

				if (26 <= 0 and var_432_25 or var_432_25 * (utf8.len(var_432_27) / 26)) > 0 and var_432_25 < var_432_29 then
					arg_429_1.talkMaxDuration = var_432_29
					var_432_24 = var_432_24 + 0.3

					if var_432_29 + var_432_24 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_29 + var_432_24
					end
				end

				arg_429_1.text_.text = var_432_27
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_30 = var_432_24 + 0.3
			local var_432_31 = math.max(var_432_25, arg_429_1.talkMaxDuration)

			if var_432_24 + 0.3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_30 + var_432_31 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_30) / var_432_31

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_30 + var_432_31 and arg_429_1.time_ < var_432_30 + var_432_31 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play417111105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 417111105
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play417111106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0.1 < arg_437_1.time_ and arg_437_1.time_ <= 0.1 + arg_440_0 then
				arg_437_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_dodge", "")
			end

			local var_440_1 = 0
			local var_440_2 = 1.375

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(417111105).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 55 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 55)

				if (55 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 55)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play417111106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 417111106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play417111107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 1.25

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(417111106).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 50 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 50)

				if (50 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 50)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play417111107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 417111107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play417111108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0.233333333333333 < arg_445_1.time_ and arg_445_1.time_ <= 0.233333333333333 + arg_448_0 then
				arg_445_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle01", "")
			end

			local var_448_1 = 0
			local var_448_2 = 1.925

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(417111107).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 77 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 77)

				if (77 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 77)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play417111108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 417111108
		arg_449_1.duration_ = 3.3

		local var_449_0 = {
			zh = 1.966,
			ja = 3.3
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play417111109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.275

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_1 = arg_449_1:GetWordFromCfg(417111108)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 11 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 11)

				if (11 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 11)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111108", "story_v_out_417111.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111108", "story_v_out_417111.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_417111", "417111108", "story_v_out_417111.awb")

						arg_449_1:RecordAudio("417111108", var_452_6)
						arg_449_1:RecordAudio("417111108", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_417111", "417111108", "story_v_out_417111.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_417111", "417111108", "story_v_out_417111.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play417111109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 417111109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play417111110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0.35 < arg_453_1.time_ and arg_453_1.time_ <= 0.35 + arg_456_0 then
				arg_453_1:AudioAction("play", "effect", "se_story_136", "se_story_136_gun", "")
			end

			local var_456_1 = 0
			local var_456_2 = 1.35

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(417111109).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 54 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 54)

				if (54 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 54)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play417111110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 417111110
		arg_457_1.duration_ = 6.44

		local var_457_0 = {
			zh = 6.44166666666666,
			ja = 6.04166666666666
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play417111111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if arg_457_1.bgs_.SS1704 == nil then
				local var_460_0 = Object.Instantiate(arg_457_1.paintGo_)

				var_460_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1704")
				var_460_0.name = "SS1704"
				var_460_0.transform.parent = arg_457_1.stage_.transform
				var_460_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.bgs_.SS1704 = var_460_0
			end

			if 2.36666666666667 < arg_457_1.time_ and arg_457_1.time_ <= 2.36666666666667 + arg_460_0 then
				local var_460_1 = arg_457_1.bgs_.SS1704

				arg_457_1.bgs_.SS1704.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_460_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_460_2 = var_460_1:GetComponent("SpriteRenderer")

				if var_460_2 and var_460_2.sprite then
					local var_460_3 = 2 * (var_460_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_460_1.transform.localScale = Vector3.New(var_460_3 / var_460_2.sprite.bounds.size.y < var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x and var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x or var_460_3 / var_460_2.sprite.bounds.size.y, var_460_3 / var_460_2.sprite.bounds.size.y < var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x and var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x or var_460_3 / var_460_2.sprite.bounds.size.y, 0)
				end

				for iter_460_0, iter_460_1 in pairs(arg_457_1.bgs_) do
					if iter_460_0 ~= "SS1704" then
						iter_460_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_460_4 = 2.43333333333333

			if 2.43333333333333 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.allBtn_.enabled = false
			end

			if arg_457_1.time_ >= var_460_4 + 0.3 and arg_457_1.time_ < var_460_4 + 0.3 + arg_460_0 then
				arg_457_1.allBtn_.enabled = true
			end

			local var_460_5 = 0

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_5 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_6 = 2.36666666666667

			if var_460_5 <= arg_457_1.time_ and arg_457_1.time_ < var_460_5 + var_460_6 then
				local var_460_7 = Color.New(0, 0, 0)

				var_460_7.a = Mathf.Lerp(0, 1, (arg_457_1.time_ - var_460_5) / var_460_6)
				arg_457_1.mask_.color = var_460_7
			end

			if arg_457_1.time_ >= var_460_5 + var_460_6 and arg_457_1.time_ < var_460_5 + var_460_6 + arg_460_0 then
				local var_460_8 = Color.New(0, 0, 0)

				var_460_8.a = 1
				arg_457_1.mask_.color = var_460_8
			end

			local var_460_9 = 2.36666666666667

			if 2.36666666666667 < arg_457_1.time_ and arg_457_1.time_ <= var_460_9 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_10 = 2.56666666666667

			if var_460_9 <= arg_457_1.time_ and arg_457_1.time_ < var_460_9 + var_460_10 then
				local var_460_11 = Color.New(0, 0, 0)

				var_460_11.a = Mathf.Lerp(1, 0, (arg_457_1.time_ - var_460_9) / var_460_10)
				arg_457_1.mask_.color = var_460_11
			end

			if arg_457_1.time_ >= var_460_9 + var_460_10 and arg_457_1.time_ < var_460_9 + var_460_10 + arg_460_0 then
				local var_460_12 = Color.New(0, 0, 0)

				arg_457_1.mask_.enabled = false
				var_460_12.a = 0
				arg_457_1.mask_.color = var_460_12
			end

			local var_460_13 = arg_457_1.bgs_.SS1704.transform

			if 2.36666666666667 < arg_457_1.time_ and arg_457_1.time_ <= 2.36666666666667 + arg_460_0 then
				arg_457_1.var_.moveOldPosSS1704 = var_460_13.localPosition
			end

			local var_460_14 = 0.001

			if 2.36666666666667 <= arg_457_1.time_ and arg_457_1.time_ < 2.36666666666667 + var_460_14 then
				var_460_13.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 10), (arg_457_1.time_ - 2.36666666666667) / var_460_14)
			end

			if arg_457_1.time_ >= 2.36666666666667 + var_460_14 and arg_457_1.time_ < 2.36666666666667 + var_460_14 + arg_460_0 then
				var_460_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_460_15 = arg_457_1.bgs_.SS1704.transform

			if 2.66666666666667 < arg_457_1.time_ and arg_457_1.time_ <= 2.66666666666667 + arg_460_0 then
				arg_457_1.var_.moveOldPosSS1704 = var_460_15.localPosition
			end

			local var_460_16 = 2.21666666666667

			if 2.66666666666667 <= arg_457_1.time_ and arg_457_1.time_ < 2.66666666666667 + var_460_16 then
				var_460_15.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 9), (arg_457_1.time_ - 2.66666666666667) / var_460_16)
			end

			if arg_457_1.time_ >= 2.66666666666667 + var_460_16 and arg_457_1.time_ < 2.66666666666667 + var_460_16 + arg_460_0 then
				var_460_15.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_17 = 3.74166666666666
			local var_460_18 = 0.325

			if 3.74166666666666 < arg_457_1.time_ and arg_457_1.time_ <= var_460_17 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_19 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_19:setOnUpdate(LuaHelper.FloatAction(function(arg_461_0)
					arg_457_1.dialogCg_.alpha = arg_461_0
				end))
				var_460_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_20 = arg_457_1:GetWordFromCfg(417111110)
				local var_460_21 = arg_457_1:FormatText(var_460_20.content)

				arg_457_1.text_.text = var_460_21

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_23 = 13 <= 0 and var_460_18 or var_460_18 * (utf8.len(var_460_21) / 13)

				if (13 <= 0 and var_460_18 or var_460_18 * (utf8.len(var_460_21) / 13)) > 0 and var_460_18 < var_460_23 then
					arg_457_1.talkMaxDuration = var_460_23
					var_460_17 = var_460_17 + 0.3

					if var_460_23 + var_460_17 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_23 + var_460_17
					end
				end

				arg_457_1.text_.text = var_460_21
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111110", "story_v_out_417111.awb") ~= 0 then
					local var_460_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111110", "story_v_out_417111.awb") / 1000

					if var_460_24 + var_460_17 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_24 + var_460_17
					end

					if var_460_20.prefab_name ~= "" and arg_457_1.actors_[var_460_20.prefab_name] ~= nil then
						local var_460_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_20.prefab_name].transform, "story_v_out_417111", "417111110", "story_v_out_417111.awb")

						arg_457_1:RecordAudio("417111110", var_460_25)
						arg_457_1:RecordAudio("417111110", var_460_25)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_417111", "417111110", "story_v_out_417111.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_417111", "417111110", "story_v_out_417111.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_26 = var_460_17 + 0.3
			local var_460_27 = math.max(var_460_18, arg_457_1.talkMaxDuration)

			if var_460_17 + 0.3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_26 + var_460_27 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_26) / var_460_27

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_26 + var_460_27 and arg_457_1.time_ < var_460_26 + var_460_27 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.21666666666667,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play417111111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 417111111
		arg_463_1.duration_ = 8.4

		local var_463_0 = {
			zh = 5.833,
			ja = 8.4
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play417111112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.75

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:GetWordFromCfg(417111111)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 30)

				if (30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 30)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111111", "story_v_out_417111.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111111", "story_v_out_417111.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_417111", "417111111", "story_v_out_417111.awb")

						arg_463_1:RecordAudio("417111111", var_466_6)
						arg_463_1:RecordAudio("417111111", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_417111", "417111111", "story_v_out_417111.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_417111", "417111111", "story_v_out_417111.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play417111112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 417111112
		arg_467_1.duration_ = 6.13

		local var_467_0 = {
			zh = 4.133,
			ja = 6.133
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play417111113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.575

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:GetWordFromCfg(417111112)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 23 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 23)

				if (23 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 23)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111112", "story_v_out_417111.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111112", "story_v_out_417111.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_417111", "417111112", "story_v_out_417111.awb")

						arg_467_1:RecordAudio("417111112", var_470_6)
						arg_467_1:RecordAudio("417111112", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_417111", "417111112", "story_v_out_417111.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_417111", "417111112", "story_v_out_417111.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play417111113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 417111113
		arg_471_1.duration_ = 7.73

		local var_471_0 = {
			zh = 4.9,
			ja = 7.733
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play417111114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.525

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_1 = arg_471_1:GetWordFromCfg(417111113)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 21 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 21)

				if (21 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 21)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111113", "story_v_out_417111.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111113", "story_v_out_417111.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_417111", "417111113", "story_v_out_417111.awb")

						arg_471_1:RecordAudio("417111113", var_474_6)
						arg_471_1:RecordAudio("417111113", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_417111", "417111113", "story_v_out_417111.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_417111", "417111113", "story_v_out_417111.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play417111114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 417111114
		arg_475_1.duration_ = 4.17

		local var_475_0 = {
			zh = 3.433,
			ja = 4.166
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play417111115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1034"]) and arg_475_1.var_.actorSpriteComps1034 == nil then
				arg_475_1.var_.actorSpriteComps1034 = arg_475_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_0 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1034"]) then
				if arg_475_1.var_.actorSpriteComps1034 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								iter_478_1.color = Color.New(Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, (arg_475_1.time_ - 0) / var_478_0), Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, (arg_475_1.time_ - 0) / var_478_0), (Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, (arg_475_1.time_ - 0) / var_478_0)))
							else
								local var_478_1 = Mathf.Lerp(iter_478_1.color.r, 1, (arg_475_1.time_ - 0) / var_478_0)

								iter_478_1.color = Color.New(var_478_1, var_478_1, var_478_1)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1034"]) and arg_475_1.var_.actorSpriteComps1034 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_478_3 then
						iter_478_3.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps1034 = nil
			end

			local var_478_2 = 0
			local var_478_3 = 0.325

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_2 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_4 = arg_475_1:GetWordFromCfg(417111114)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 13 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 13)

				if (13 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 13)) > 0 and var_478_3 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_2
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111114", "story_v_out_417111.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111114", "story_v_out_417111.awb") / 1000

					if var_478_8 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_2
					end

					if var_478_4.prefab_name ~= "" and arg_475_1.actors_[var_478_4.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_4.prefab_name].transform, "story_v_out_417111", "417111114", "story_v_out_417111.awb")

						arg_475_1:RecordAudio("417111114", var_478_9)
						arg_475_1:RecordAudio("417111114", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_417111", "417111114", "story_v_out_417111.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_417111", "417111114", "story_v_out_417111.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_3, arg_475_1.talkMaxDuration)

			if var_478_2 <= arg_475_1.time_ and arg_475_1.time_ < var_478_2 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_2) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_2 + var_478_10 and arg_475_1.time_ < var_478_2 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play417111115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 417111115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play417111116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1034"]) and arg_479_1.var_.actorSpriteComps1034 == nil then
				arg_479_1.var_.actorSpriteComps1034 = arg_479_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1034"]) then
				if arg_479_1.var_.actorSpriteComps1034 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor2.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor2.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor2.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 0.5, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1034"]) and arg_479_1.var_.actorSpriteComps1034 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_479_1.var_.actorSpriteComps1034 = nil
			end

			if 0.2 < arg_479_1.time_ and arg_479_1.time_ <= 0.2 + arg_482_0 then
				arg_479_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_gun", "")
			end

			local var_482_3 = 0
			local var_482_4 = 1.15

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_3 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_5 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(417111115).content)

				arg_479_1.text_.text = var_482_5

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_7 = 46 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_5) / 46)

				if (46 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_5) / 46)) > 0 and var_482_4 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_3 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_3
					end
				end

				arg_479_1.text_.text = var_482_5
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_8 = math.max(var_482_4, arg_479_1.talkMaxDuration)

			if var_482_3 <= arg_479_1.time_ and arg_479_1.time_ < var_482_3 + var_482_8 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_3) / var_482_8

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_3 + var_482_8 and arg_479_1.time_ < var_482_3 + var_482_8 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play417111116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 417111116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play417111117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 1.1

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(417111116).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 44 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 44)

				if (44 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 44)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play417111117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 417111117
		arg_487_1.duration_ = 5.13

		local var_487_0 = {
			zh = 3.866,
			ja = 5.133
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play417111118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1034"]) and arg_487_1.var_.actorSpriteComps1034 == nil then
				arg_487_1.var_.actorSpriteComps1034 = arg_487_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_0 = 0.2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1034"]) then
				if arg_487_1.var_.actorSpriteComps1034 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								iter_490_1.color = Color.New(Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor1.r, (arg_487_1.time_ - 0) / var_490_0), Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor1.g, (arg_487_1.time_ - 0) / var_490_0), (Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor1.b, (arg_487_1.time_ - 0) / var_490_0)))
							else
								local var_490_1 = Mathf.Lerp(iter_490_1.color.r, 1, (arg_487_1.time_ - 0) / var_490_0)

								iter_490_1.color = Color.New(var_490_1, var_490_1, var_490_1)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1034"]) and arg_487_1.var_.actorSpriteComps1034 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_490_3 then
						iter_490_3.color = arg_487_1.isInRecall_ and (arg_487_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_487_1.var_.actorSpriteComps1034 = nil
			end

			local var_490_2 = 0
			local var_490_3 = 0.45

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_2 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_4 = arg_487_1:GetWordFromCfg(417111117)
				local var_490_5 = arg_487_1:FormatText(var_490_4.content)

				arg_487_1.text_.text = var_490_5

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_7 = 18 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_5) / 18)

				if (18 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_5) / 18)) > 0 and var_490_3 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_2
					end
				end

				arg_487_1.text_.text = var_490_5
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111117", "story_v_out_417111.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111117", "story_v_out_417111.awb") / 1000

					if var_490_8 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_2
					end

					if var_490_4.prefab_name ~= "" and arg_487_1.actors_[var_490_4.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_4.prefab_name].transform, "story_v_out_417111", "417111117", "story_v_out_417111.awb")

						arg_487_1:RecordAudio("417111117", var_490_9)
						arg_487_1:RecordAudio("417111117", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_417111", "417111117", "story_v_out_417111.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_417111", "417111117", "story_v_out_417111.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_10 = math.max(var_490_3, arg_487_1.talkMaxDuration)

			if var_490_2 <= arg_487_1.time_ and arg_487_1.time_ < var_490_2 + var_490_10 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_2) / var_490_10

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_2 + var_490_10 and arg_487_1.time_ < var_490_2 + var_490_10 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play417111118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 417111118
		arg_491_1.duration_ = 5.3

		local var_491_0 = {
			zh = 3.7,
			ja = 5.3
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play417111119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.475

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:GetWordFromCfg(417111118)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 19 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 19)

				if (19 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 19)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111118", "story_v_out_417111.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_417111", "417111118", "story_v_out_417111.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_417111", "417111118", "story_v_out_417111.awb")

						arg_491_1:RecordAudio("417111118", var_494_6)
						arg_491_1:RecordAudio("417111118", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_417111", "417111118", "story_v_out_417111.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_417111", "417111118", "story_v_out_417111.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play417111119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 417111119
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play417111120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["1034"]) and arg_495_1.var_.actorSpriteComps1034 == nil then
				arg_495_1.var_.actorSpriteComps1034 = arg_495_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_0 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["1034"]) then
				if arg_495_1.var_.actorSpriteComps1034 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								iter_498_1.color = Color.New(Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_0), Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_0), (Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_0)))
							else
								local var_498_1 = Mathf.Lerp(iter_498_1.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_0)

								iter_498_1.color = Color.New(var_498_1, var_498_1, var_498_1)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["1034"]) and arg_495_1.var_.actorSpriteComps1034 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps1034 = nil
			end

			local var_498_2 = 0
			local var_498_3 = 0.75

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_4 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(417111119).content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_6 = 30 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 30)

				if (30 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 30)) > 0 and var_498_3 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_2
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_3, arg_495_1.talkMaxDuration)

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_2) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_2 + var_498_7 and arg_495_1.time_ < var_498_2 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play417111120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 417111120
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play417111121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.775

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(417111120).content)

				arg_499_1.text_.text = var_502_1

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_3 = 31 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 31)

				if (31 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 31)) > 0 and var_502_0 < var_502_3 then
					arg_499_1.talkMaxDuration = var_502_3

					if var_502_3 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_3 + 0
					end
				end

				arg_499_1.text_.text = var_502_1
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_4 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_4

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play417111121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 417111121
		arg_503_1.duration_ = 6.27

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play417111122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				local var_506_0 = arg_503_1.var_.effect385

				if not arg_503_1.var_.effect385 then
					var_506_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_506_0.name = "385"
					arg_503_1.var_.effect385 = var_506_0
				else
					var_506_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_506_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_506_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_506_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_506_0, iter_506_1 in ipairs((var_506_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_506_1.transform.localScale = Vector3.New(iter_506_1.transform.localScale.x / var_506_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_506_1.transform.localScale.y / var_506_2, iter_506_1.transform.localScale.z)
				end
			end

			local var_506_4 = 0

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_4 + arg_506_0 then
				arg_503_1.mask_.enabled = true
				arg_503_1.mask_.raycastTarget = true

				arg_503_1:SetGaussion(false)
			end

			local var_506_5 = 0.266666666666667

			if var_506_4 <= arg_503_1.time_ and arg_503_1.time_ < var_506_4 + var_506_5 then
				local var_506_6 = Color.New(1, 1, 1)

				var_506_6.a = Mathf.Lerp(1, 0, (arg_503_1.time_ - var_506_4) / var_506_5)
				arg_503_1.mask_.color = var_506_6
			end

			if arg_503_1.time_ >= var_506_4 + var_506_5 and arg_503_1.time_ < var_506_4 + var_506_5 + arg_506_0 then
				local var_506_7 = Color.New(1, 1, 1)

				arg_503_1.mask_.enabled = false
				var_506_7.a = 0
				arg_503_1.mask_.color = var_506_7
			end

			local var_506_8 = arg_503_1.bgs_.SS1704.transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPosSS1704 = var_506_8.localPosition
			end

			local var_506_9 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_9 then
				var_506_8.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 9), (arg_503_1.time_ - 0) / var_506_9)
			end

			if arg_503_1.time_ >= 0 + var_506_9 and arg_503_1.time_ < 0 + var_506_9 + arg_506_0 then
				var_506_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_506_10 = arg_503_1.bgs_.SS1704.transform

			if 0.0166666666666667 < arg_503_1.time_ and arg_503_1.time_ <= 0.0166666666666667 + arg_506_0 then
				arg_503_1.var_.moveOldPosSS1704 = var_506_10.localPosition
			end

			local var_506_11 = 0.816666666666667

			if 0.0166666666666667 <= arg_503_1.time_ and arg_503_1.time_ < 0.0166666666666667 + var_506_11 then
				var_506_10.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 10), (arg_503_1.time_ - 0.0166666666666667) / var_506_11)
			end

			if arg_503_1.time_ >= 0.0166666666666667 + var_506_11 and arg_503_1.time_ < 0.0166666666666667 + var_506_11 + arg_506_0 then
				var_506_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_506_12 = 0

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_12 + arg_506_0 then
				arg_503_1.allBtn_.enabled = false
			end

			if arg_503_1.time_ >= var_506_12 + 1.73771769693121 and arg_503_1.time_ < var_506_12 + 1.73771769693121 + arg_506_0 then
				arg_503_1.allBtn_.enabled = true
			end

			if 0.266666666666667 < arg_503_1.time_ and arg_503_1.time_ <= 0.266666666666667 + arg_506_0 then
				arg_503_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle02", "")
			end

			if arg_503_1.frameCnt_ <= 1 then
				arg_503_1.dialog_:SetActive(false)
			end

			local var_506_14 = 1.26666666666667
			local var_506_15 = 1.1

			if 1.26666666666667 < arg_503_1.time_ and arg_503_1.time_ <= var_506_14 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_16 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_16:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_503_1.dialogCg_.alpha = arg_507_0
				end))
				var_506_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_17 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(417111121).content)

				arg_503_1.text_.text = var_506_17

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_19 = 44 <= 0 and var_506_15 or var_506_15 * (utf8.len(var_506_17) / 44)

				if (44 <= 0 and var_506_15 or var_506_15 * (utf8.len(var_506_17) / 44)) > 0 and var_506_15 < var_506_19 then
					arg_503_1.talkMaxDuration = var_506_19
					var_506_14 = var_506_14 + 0.3

					if var_506_19 + var_506_14 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_19 + var_506_14
					end
				end

				arg_503_1.text_.text = var_506_17
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_20 = var_506_14 + 0.3
			local var_506_21 = math.max(var_506_15, arg_503_1.talkMaxDuration)

			if var_506_14 + 0.3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_20 + var_506_21 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_20) / var_506_21

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_20 + var_506_21 and arg_503_1.time_ < var_506_20 + var_506_21 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.816666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play417111122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 417111122
		arg_509_1.duration_ = 7.87

		local var_509_0 = {
			zh = 4.8,
			ja = 7.866
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
			arg_509_1.auto_ = false
		end

		function arg_509_1.playNext_(arg_511_0)
			arg_509_1.onStoryFinished_()
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1034"]) and arg_509_1.var_.actorSpriteComps1034 == nil then
				arg_509_1.var_.actorSpriteComps1034 = arg_509_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1034"]) then
				if arg_509_1.var_.actorSpriteComps1034 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_512_1 then
							if arg_509_1.isInRecall_ then
								iter_512_1.color = Color.New(Mathf.Lerp(iter_512_1.color.r, arg_509_1.hightColor1.r, (arg_509_1.time_ - 0) / var_512_0), Mathf.Lerp(iter_512_1.color.g, arg_509_1.hightColor1.g, (arg_509_1.time_ - 0) / var_512_0), (Mathf.Lerp(iter_512_1.color.b, arg_509_1.hightColor1.b, (arg_509_1.time_ - 0) / var_512_0)))
							else
								local var_512_1 = Mathf.Lerp(iter_512_1.color.r, 1, (arg_509_1.time_ - 0) / var_512_0)

								iter_512_1.color = Color.New(var_512_1, var_512_1, var_512_1)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1034"]) and arg_509_1.var_.actorSpriteComps1034 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_512_3 then
						iter_512_3.color = arg_509_1.isInRecall_ and (arg_509_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_509_1.var_.actorSpriteComps1034 = nil
			end

			local var_512_2 = 0
			local var_512_3 = 0.65

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_2 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_4 = arg_509_1:GetWordFromCfg(417111122)
				local var_512_5 = arg_509_1:FormatText(var_512_4.content)

				arg_509_1.text_.text = var_512_5

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_7 = 26 <= 0 and var_512_3 or var_512_3 * (utf8.len(var_512_5) / 26)

				if (26 <= 0 and var_512_3 or var_512_3 * (utf8.len(var_512_5) / 26)) > 0 and var_512_3 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_2 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_2
					end
				end

				arg_509_1.text_.text = var_512_5
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111122", "story_v_out_417111.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111122", "story_v_out_417111.awb") / 1000

					if var_512_8 + var_512_2 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_2
					end

					if var_512_4.prefab_name ~= "" and arg_509_1.actors_[var_512_4.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_4.prefab_name].transform, "story_v_out_417111", "417111122", "story_v_out_417111.awb")

						arg_509_1:RecordAudio("417111122", var_512_9)
						arg_509_1:RecordAudio("417111122", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_417111", "417111122", "story_v_out_417111.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_417111", "417111122", "story_v_out_417111.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_3, arg_509_1.talkMaxDuration)

			if var_512_2 <= arg_509_1.time_ and arg_509_1.time_ < var_512_2 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_2) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_2 + var_512_10 and arg_509_1.time_ < var_512_2 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I16i",
		"TextureConfig/Background/SS1704"
	},
	voices = {
		"story_v_out_417111.awb"
	}
}
